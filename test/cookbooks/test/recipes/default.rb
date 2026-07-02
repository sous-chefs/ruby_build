apt_update
homebrew_update

ruby_build_install

ruby_version = platform_family?('mac_os_x') ? '3.3.10' : '3.0.4'

ruby_build_definition ruby_version do
  version_prefix true
  patch 'test.patch' unless platform_family?('mac_os_x')
end
