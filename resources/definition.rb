property :definition, String,
         name_property: true,
         description: 'Version of Ruby to install'

property :prefix_path, String,
         default: '/usr/local/ruby',
         description: 'Location to install Ruby'

property :environment, String,
         description: 'Environment to pass to the ruby-build install process'

property :user, String,
         deescription: 'User to install as'

property :group, String,
         deescription: 'Group to install as'

action :install do
  if platform_family?('rhel', 'suse', 'debian', 'fedora', 'amazon')
    package package_deps(new_resource.definition)
  else
    Array(package_deps(new_resource.definition)).each do |pkg|
      package pkg
    end
  end

  bash "ruby-build [#{new_resource.definition}]" do
    code %(/usr/local/bin/ruby-build "#{new_resource.definition}" "#{new_resource.prefix_path}/#{new_resource.definition}")
    user        new_resource.user         if new_resource.user
    group       new_resource.group        if new_resource.group
    environment new_resource.environment  if new_resource.environment
    not_if      { ::File.exist?("#{new_resource.prefix_path}/new_resource.definition/bin/ruby") }
    live_stream true
    action :run
  end
end

action_class do
  include Chef::Rbenv::PackageDeps
end
