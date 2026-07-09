require 'chefspec'
require 'chefspec/policyfile'
require_relative '../libraries/package_deps'

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
end
