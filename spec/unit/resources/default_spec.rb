# require 'spec_helper'

# describe 'ruby_build_install' do
#   step_into :ruby_build_install, :ruby_build_definition
#   platform 'ubuntu'

#   context 'Install C Rubie' do
#     recipe do
#       ruby_build_install ''
#       ruby_build_definition '2.6.0'
#     end

#     it 'Installs the correct packages' do
#       is_expected.to install_package %w(gcc autoconf bison build-essential libssl1.0-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev make)
#     end
#   end
# end
