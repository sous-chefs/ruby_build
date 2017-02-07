if defined?(ChefSpec)
  ChefSpec.define_matcher(:ruby_build_ruby)

  def install_ruby_build_ruby(name)
    ChefSpec::Matchers::ResourceMatcher.new(:ruby_build_ruby, :install, name)
  end

  def reinstall_ruby_build_ruby(name)
    ChefSpec::Matchers::ResourceMatcher.new(:ruby_build_ruby, :reinstall, name)
  end
end
