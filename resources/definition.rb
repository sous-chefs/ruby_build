include Chef::Rbenv::MacOs

# for compatibility with earlier incarnations
# of this resource
#
provides :ruby_build_ruby

property :definition, String,
  name_property: true,
  description: 'Version of Ruby to install'

property :prefix_path, String,
  default: '/usr/local/ruby',
  description: 'Location to install Ruby'

# NOTE: adding the Ruby version to the installation prefix
# by default is unexpected and will likely lead to user
# problems. Now defaults to false.
#
property :version_prefix, [true, false],
  default: false,
  description: 'add Ruby version to the installation prefix'

property :patch, [String, nil],
  description: 'path to a Ruby patch file for ruby-build to use'

property :environment, Hash,
  default: {},
  description: 'Environment hash to pass to the ruby-build install process'

property :user, String,
  description: 'User to install as'

property :group, String,
  description: 'Group to install as'

unified_mode true if respond_to? :unified_mode

action :install do
  Chef::Log.fatal('JRuby is not a supported definition') \
    if new_resource.definition.include? 'jruby'

  if platform_family?('mac_os_x') && Chef::VERSION < '16'
    Array(package_deps).each do |pkg|
      package pkg
    end
  else
    package package_deps
  end

  installation_path = if new_resource.version_prefix
                        ::File.join(new_resource.prefix_path, new_resource.definition)
                      else
                        new_resource.prefix_path
                      end

  env = if platform_family?('mac_os_x')
          extra_env = { 'RUBY_CONFIGURE_OPTS' => "--with-openssl-dir=#{openssl_prefix}" }
          new_resource.environment.merge extra_env
        else
          new_resource.environment
        end

  ruby_build_cmd = [
    '/usr/local/bin/ruby-build',
    new_resource.definition,
    installation_path,
  ].join(' ')

  if new_resource.patch
    patch_path = "#{Chef::Config[:file_cache_path]}/#{new_resource.patch}"
    ruby_build_cmd += %( --patch < "#{patch_path}" )

    cookbook_file patch_path do
      source new_resource.patch
    end
  end

  bash "ruby-build #{new_resource.definition}" do
    code ruby_build_cmd
    environment env
    user new_resource.user
    group new_resource.group
    not_if { ::File.exist?(installation_path) }
    live_stream true
    action :run
  end
end

action_class do
  include Chef::Rbenv::PackageDeps
  include Chef::Rbenv::MacOs
end
