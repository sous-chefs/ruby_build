#
# Cookbook:: ruby_build
# Recipe:: default
#
# Copyright:: 2011-2016, Fletcher Nichol
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

class Chef::Recipe
  # mix in recipe helpers
  include Chef::RubyBuild::RecipeHelpers
end

git_url = node['ruby_build']['git_url']
git_ref = node['ruby_build']['git_ref']
upgrade_strategy = build_upgrade_strategy(node['ruby_build']['upgrade'])

cache_path  = Chef::Config['file_cache_path']
src_path    = "#{cache_path}/ruby-build"

include_recipe 'yum-epel' if platform_family?('rhel')
include_recipe 'git'

# use multipackage when available as it is much faster
if platform_family?('rhel', 'suse', 'debian', 'fedora')
  package node['ruby_build']['install_pkgs']
else # mostly for os x / freebsd
  node['ruby_build']['install_pkgs'].each do |pkg|
    package pkg
  end
end

execute 'Install ruby-build' do
  cwd       src_path
  command   %(./install.sh)
  action    :nothing
  not_if    { ::File.exist?('/usr/local/bin/ruby-build') && upgrade_strategy == 'none' }
end

directory ::File.dirname(src_path) do
  recursive true
end

git src_path do
  repository  git_url
  reference   git_ref

  if upgrade_strategy == 'none'
    action    :checkout
  else
    action    :sync
  end

  notifies :run, 'execute[Install ruby-build]', :immediately
end
