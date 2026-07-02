# frozen_string_literal: true

name 'ruby_build'

default_source :supermarket

run_list 'test::default'

cookbook 'ruby_build', path: '.'
cookbook 'test', path: 'test/cookbooks/test'

Dir.entries('./test/cookbooks/test/recipes').select { |f| f.end_with?('.rb') }.each do |test|
  test = test.delete_suffix('.rb')
  named_run_list :"#{test}", "test::#{test}"
end
