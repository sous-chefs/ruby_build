require 'spec_helper'

describe 'ruby_build_install' do
  step_into :ruby_build_install, :ruby_build_definition
  platform 'ubuntu'

  context 'Install C Rubie' do
    recipe do
      ruby_build_install ''
      ruby_build_definition '2.6.0'
    end

    it 'Installs the correct packages' do
      is_expected.to install_package %w(gcc autoconf bison build-essential libssl1.0-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev make)
    end
  end

  context 'Install a JRubie' do
    recipe do
      ruby_build_install '' do
        jruby_deps true
      end

      ruby_build_definition 'jruby-9.1.6.0'
    end

    # Not possible to unit test as it includes another cookbook
    # it 'Installs the correct packages' do
    #   is_expected.to install_package %w( make g++ )
    # end
  end
end

describe 'RBX on Redhat' do
  step_into :ruby_build_install, :ruby_build_definition
  platform 'redhat'

  context '' do
    recipe do
      ruby_build_install ''
      ruby_build_definition 'rbx-3.99'
    end

    #   it 'Installs the correct packages' do
    #     is_expected.to install_package %w(gcc bzip2 openssl-devel libyaml-devel libffi-devel readline-devel zlib-devel gdbm-devel ncurses-devel make ncurses-devel llvm-static llvm-devel )
    #   end
  end
end
