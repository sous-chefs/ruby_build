#
# Cookbook:: ruby_build
# Resource:: ruby
#
# Author:: Fletcher Nichol <fnichol@nichol.ca>
# Author:: Dan Webb <dan.webb@damacus.io>
#
# Copyright:: 2011-2016, Fletcher Nichol
# Copyright:: 2017, Dan Webb
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

actions :install, :reinstall
default_action :install

property :definition, String, name_attribute: true
property :prefix_path, String
property :user, String
property :group, String
property :environment, Hash

action :install do
  installed = perform_install
end

action :reinstall do
  installed = perform_install
end

action_class do
  include Chef::Rbenv::PackageDeps

  def root_path
    new_resource.prefix_path ||
                    "#{node['ruby_build']['default_ruby_base_path']}/#{new_resource.definition}"
  end

  def perform_install
    if ruby_installed?
      Chef::Log.debug(
        "ruby_build_ruby[#{new_resource.definition}] is already installed, so skipping")
      false
    else
      install_start = Time.now

      install_ruby_dependencies

      Chef::Log.info(
        "Building ruby_build_ruby[#{new_resource.definition}], this could take a while...")

      rubie       = new_resource.definition
      execute "ruby-build[#{rubie}]" do
        command   %(/usr/local/bin/ruby-build "#{rubie}" "#{root_path}")
        user        new_resource.user         if new_resource.user
        group       new_resource.group        if new_resource.group
        environment new_resource.environment  if new_resource.environment

        action :nothing
      end.run_action(:run)

      Chef::Log.info("ruby_build_ruby[#{new_resource.definition}] build time was " \
        "#{(Time.now - install_start) / 60.0} minutes")
      true
    end
  end

  def ruby_installed?
    if Array(new_resource.action).include?(:reinstall)
      false
    else
      ::File.exist?("#{root_path}/bin/ruby")
    end
  end

  def install_ruby_dependencies
    case ::File.basename(new_resource.definition)
    when /^\d\.\d\.\d/, /^ree-/
      pkgs = node['ruby_build']['install_pkgs_cruby']
    when /^rbx-/
      pkgs = node['ruby_build']['install_pkgs_rbx']
    when /^jruby-/
      pkgs = node['ruby_build']['install_pkgs_jruby']
    end

    # use multi-package when available since it's much faster
    if platform_family?('rhel', 'suse', 'debian', 'fedora', 'amazon')
      package pkgs do
        action :nothing
      end.run_action(:install)
    else
      Array(pkgs).each do |pkg|
        package pkg do
          action :nothing
        end.run_action(:install)
      end
    end
  end
end
