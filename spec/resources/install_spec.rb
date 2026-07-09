require 'spec_helper'

describe 'test::default' do
  context 'AlmaLinux 8' do
    platform 'almalinux', '8'
    step_into :ruby_build_install

    before do
      stub_command('yum-config-manager --dump powertools | grep -q "enabled = 1"').and_return(false)
    end

    it { is_expected.to install_package('yum-utils') }
    it { is_expected.to run_execute('yum-config-manager --enable powertools') }
    it { is_expected.to create_yum_epel('default') }
    it { is_expected.not_to include_recipe('yum-epel') }
  end
end
