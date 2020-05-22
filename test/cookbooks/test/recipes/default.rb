apt_update
homebrew_update

ruby_build_install

ruby_build_definition '2.6.6' do
  version_prefix true
  patch 'test.patch'
end
