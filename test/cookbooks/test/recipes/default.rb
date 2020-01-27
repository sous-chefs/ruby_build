apt_update

ruby_build_install '' do
  jruby_deps true
end

ruby_build_definition '2.6.0'

ruby_build_definition 'jruby-9.1.6.0'
