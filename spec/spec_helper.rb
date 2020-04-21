require 'chefspec'
require 'chefspec/berkshelf'
require_relative '../libraries/package_deps'

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
end
