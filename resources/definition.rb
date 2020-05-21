include Chef::Rbenv::MacOs

property :definition, String,
  name_property: true,
  description: 'Version of Ruby to install'

property :prefix_path, String,
  default: '/usr/local/ruby',
  description: 'Location to install Ruby'

property :environment, String,
  description: 'Environment to pass to the ruby-build install process'

property :user, String,
  description: 'User to install as'

property :group, String,
  description: 'Group to install as'

unified_mode true

action :install do
  Chef::Log.fatal 'JRuby is not a supported definition' if new_resource.definition.include? 'jruby'

  if platform_family?('mac_os_x') && Chef::VERSION < '16'
    Array(package_deps).each do |pkg|
      package pkg
    end
  else
    package package_deps
  end

  definition_path = ::File.join(new_resource.prefix_path, new_resource.definition)

  if platform_family?('mac_os_x')
    env = { 'RUBY_CONFIGURE_OPTS' => "--with-openssl-dir=#{openssl_prefix.to_s}" }
    env.merge(new_resource.environment) unless new_resource.environment.nil?
  else
    env = new_resource.environment
  end

  bash "ruby-build #{new_resource.definition}" do
    code %(/usr/local/bin/ruby-build #{new_resource.definition} #{definition_path})
    environment env
    user new_resource.user
    group new_resource.group
    not_if { ::File.exist?(definition_path) }
    live_stream true
    action :run
  end
end

action_class do
  include Chef::Rbenv::PackageDeps
  include Chef::Rbenv::MacOs
end
