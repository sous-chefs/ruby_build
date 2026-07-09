# frozen_string_literal: true

name 'ruby_build'

run_list 'test::default'

cookbook 'ruby_build', path: '.'
cookbook 'test', path: 'test/cookbooks/test'
cookbook 'homebrew', git: 'https://github.com/sous-chefs/homebrew.git', branch: 'main'
cookbook 'yum-epel', git: 'https://github.com/sous-chefs/yum-epel.git', branch: 'main'

Dir.entries('./test/cookbooks/test/recipes').select { |f| f.end_with?('.rb') }.each do |test|
  test = test.delete_suffix('.rb')
  named_run_list :"#{test}", "test::#{test}"
end
