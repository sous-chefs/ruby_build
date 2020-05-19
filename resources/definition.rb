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

  apt_update ''
  homebrew_update ''

  if platform_family?('mac_os_x') && Chef::VERSION < '16'
    Array(package_deps).each do |pkg|
      package pkg
    end
  else
    package package_deps
  end

  bash "ruby-build [#{new_resource.definition}]" do
    code %(/usr/local/bin/ruby-build "#{new_resource.definition}" "#{new_resource.prefix_path}/#{new_resource.definition}")
    environment RUBY_CONFIGURE_OPTS: "--with-openssl-dir=#{openssl_prefix}"
    user new_resource.user
    group new_resource.group
    environment new_resource.environment
    not_if { ::File.exist?("#{new_resource.prefix_path}/#{new_resource.definition}/bin/ruby") }
    live_stream true
    action :run
  end
end

action_class do
  include Chef::Rbenv::PackageDeps
  include Chef::Rbenv::MacOs
end
