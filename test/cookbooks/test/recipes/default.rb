apt_update
homebrew_update

ruby_build_install

ruby_build_definition '3.0.4' do
  version_prefix true
  patch 'test.patch'
end
