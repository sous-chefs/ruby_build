property :git_ref, String,
  default: 'master',
  description: 'Git reference to download, set to a tag to get a specific version'

action :install do
  src_path = "#{Chef::Config['file_cache_path']}/ruby-build"

  if platform_family?('rhel')
    node.override['yum']['powertools']['enabled'] = true
    node.override['yum']['powertools']['managed'] = true
    include_recipe 'yum-centos'
    include_recipe 'yum-epel'
  end

  package %w( tar bash curl git ) unless platform_family?('mac_os_x', 'freebsd')

  git src_path do
    repository  'https://github.com/rbenv/ruby-build.git'
    reference   new_resource.git_ref
  end

  execute 'Install ruby-build' do
    cwd       src_path
    command   %(./install.sh)
    not_if    { ::File.exist?('/usr/local/bin/ruby-build') }
  end
end
