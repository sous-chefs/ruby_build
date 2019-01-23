#
# Cookbook:: ruby_build
# Resource:: ruby
#
# Author:: Fletcher Nichol <fnichol@nichol.ca>
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

property :definition,  String, name_property: true
property :prefix_path, String, default: lazy { |r| "#{node['ruby_build']['default_ruby_base_path']}/#{r.definition}" }
property :user,        String
property :group,       String
property :environment, Hash

action :install do
  perform_install
end

action :reinstall do
  perform_install
end

action_class do
  def perform_install
    if ruby_installed?
      Chef::Log.debug(
        "ruby_build_ruby[#{new_resource.definition}] is already installed, so skipping")
    else
      install_start = Time.now

      install_ruby_dependencies

      Chef::Log.info(
        "Building ruby_build_ruby[#{new_resource.definition}], this could take a while...")

      rubie       = new_resource.definition
      prefix_path = new_resource.prefix_path
      execute "ruby-build[#{rubie}]" do
        command   %(/usr/local/bin/ruby-build "#{rubie}" "#{prefix_path}")
        user        new_resource.user         if new_resource.user
        group       new_resource.group        if new_resource.group
        environment new_resource.environment  if new_resource.environment
        action :run
      end

      Chef::Log.info("ruby_build_ruby[#{new_resource.definition}] build time was " \
        "#{(Time.now - install_start) / 60.0} minutes")
    end
  end

  def ruby_installed?
    if Array(new_resource.action).include?(:reinstall)
      false
    else
      ::File.exist?("#{new_resource.prefix_path}/bin/ruby")
    end
  end

  # def install_ruby_dependencies
  #   case ::File.basename(new_resource.version)
  #   when /^jruby-/
  #     package jruby_package_deps
  #   when /^rbx-/
  #     package rbx_package_deps
  #   else
  #     package package_deps
  #   end
  #   # ensure_java_environment if new_resource.version =~ /^jruby-/
  # end

  # def ensure_java_environment
  #   resource_collection.find('ruby_block[update-java-alternatives]').run_action(:create)
  #   rescue Chef::Exceptions::ResourceNotFound
  #   Chef::Log.info 'The java cookbook does not appear to in the run_list.'
  # end

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
      package pkgs
    else
      Array(pkgs).each do |pkg|
        package pkg
      end
    end
  end
end
