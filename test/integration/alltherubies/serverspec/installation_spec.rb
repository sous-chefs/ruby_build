require 'spec_helper'

describe 'ruby-build' do
  describe file('/usr/local/bin/ruby-build') do
    it { should be_file }
    it { should be_executable }
  end
  describe command('/usr/local/bin/ruby-build --definitions') do
    its(:exit_status) { should eq 0 }
  end
end
