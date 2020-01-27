apt_update

ruby_build_install '' do
  jruby_deps true
end

# Don't compile 2 Rubies for the sake of build time
# ruby_build_definition '2.6.0'

ruby_build_definition 'jruby-9.1.13.0'
