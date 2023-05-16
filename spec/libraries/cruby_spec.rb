require 'spec_helper'

describe '#cruby_package_deps' do
  context 'CentOS' do
    recipe do
      Chef::DSL::Recipe.include(Chef::Rbenv::PackageDeps)

      log cruby_package_deps
    end

    context 'CentOS 7' do
      platform 'centos', '7'
      it { is_expected.to write_log('gcc, bzip2, openssl-devel, libyaml-devel, libffi-devel, readline-devel, zlib-devel, gdbm-devel, ncurses-devel, make, patch') }
    end

    context 'CentOS 8' do
      platform 'centos', '8'
      it { is_expected.to write_log('gcc, bzip2, openssl-devel, libyaml-devel, libffi-devel, readline-devel, zlib-devel, gdbm-devel, ncurses-devel, make, patch') }
    end

    context 'Debian 9' do
      platform 'debian', '9'
      it { is_expected.to write_log('gcc, autoconf, bison, build-essential, libssl-dev, libyaml-dev, libreadline6-dev, zlib1g-dev, libncurses5-dev, libffi-dev, libgdbm3, libgdbm-dev, make, patch') }
    end

    context 'Debian 10' do
      platform 'debian', '10'
      it { is_expected.to write_log('gcc, autoconf, bison, build-essential, libssl-dev, libyaml-dev, libreadline6-dev, zlib1g-dev, libncurses5-dev, libffi-dev, libgdbm6, libgdbm-dev, make, patch') }
    end

    context 'Ubuntu 16.04' do
      platform 'ubuntu', '16.04'
      it { is_expected.to write_log('gcc, autoconf, bison, build-essential, libssl-dev, libyaml-dev, libreadline6-dev, zlib1g-dev, libncurses5-dev, libffi-dev, libgdbm3, libgdbm-dev, make, patch') }
    end

    context 'Ubuntu 18.04' do
      platform 'ubuntu', '18.04'
      it { is_expected.to write_log('gcc, autoconf, bison, build-essential, libssl-dev, libyaml-dev, libreadline6-dev, zlib1g-dev, libncurses5-dev, libffi-dev, libgdbm5, libgdbm-dev, make, patch') }
    end

    context 'Ubuntu 20.04' do
    end
  end
end
