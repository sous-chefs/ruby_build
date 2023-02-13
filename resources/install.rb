unified_mode true

property :name, String, default: ''

property :git_ref, String,
  default: 'master',
  description: 'Git reference to download, set to a tag to get a specific version'

action :install do
  src_path = "#{Chef::Config['file_cache_path']}/ruby-build"

  if platform_family?('rhel')
    if node['platform_version'].to_i >= 8
      package 'yum-utils'

      execute 'yum-config-manager --enable powertools' do
        not_if 'yum-config-manager --dump powertools | grep -q "enabled = 1"'
      end
    end

    include_recipe 'yum-epel'
  end

  package %w(tar bash curl git) unless platform_family?('mac_os_x', 'freebsd')

  git src_path do
    repository 'https://github.com/rbenv/ruby-build.git'
    revision new_resource.git_ref unless new_resource.git_ref == 'master'
    retries 5
    retry_delay 5
  end

  execute 'Install ruby-build' do
    cwd src_path
    command %(sh ./install.sh)
    not_if { ::File.exist?('/usr/local/bin/ruby-build') }
  end
end
