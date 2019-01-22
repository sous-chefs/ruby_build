apt_update

include_recipe 'java'
include_recipe 'ruby_build'

%w(2.4.4 jruby-9.1.13.0).each do |rubie|
  ruby_build_ruby rubie do
    environment('MAKE_OPTS' => "-j #{node['cpu']['total'].to_i + 1}")
  end
end
