property :git_ref, String, default: 'master',
                           description: 'Git refernce to download, set to a tag to get a specific version'

property :java_version, String,
         default: lazy { platform_family?('debian') && node['platform_version'].to_f < 9 ? '7' : '8' },
         description: 'JDK version to install'

property :jruby_deps, TrueClass,
         description: 'Set to true to install jruby dependencies'

action :install do
  src_path = "#{Chef::Config['file_cache_path']}/ruby-build"

  include_recipe 'yum-epel' if platform_family?('rhel')

  package %w( tar bash curl git ) unless platform_family?('mac_os_x', 'freebsd')

  execute 'Install ruby-build' do
    cwd       src_path
    command   %(./install.sh)
    action    :nothing
    not_if    { ::File.exist?('/usr/local/bin/ruby-build') }
  end

  git src_path do
    repository  'https://github.com/rbenv/ruby-build.git'
    reference   new_resource.git_ref
    notifies :run, 'execute[Install ruby-build]', :immediately
  end

  if new_resource.jruby_deps
    node.default['java']['jdk_version'] = new_resource.java_version
    include_recipe 'java'
  end
end
