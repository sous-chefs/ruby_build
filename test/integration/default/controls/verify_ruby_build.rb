control 'Check definitions' do
  impact 1.0
  title 'Verify we can return a list of definitions'
  desc 'Verify we can get a list of Ruby definitions'
  describe command('/usr/local/bin/ruby-build --definitions') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /2.6.0/ }
  end
end

control 'ruby-build binary should work' do
  impact 1.0
  title 'Verify that running ruby-build works'
  desc 'Verify that running ruby-build will work for users'
  describe file('/usr/local/bin/ruby-build') do
    it { should be_file }
    it { should be_executable }
  end
end

control 'Install a Ruby gem' do
  impact 1.0
  title 'Verify gem install works'
  desc 'Verify gem install works, and the gem works after installation'

  describe command('/usr/local/ruby/2.6.0/bin/gem install ffi --no-document') do
    its('exit_status') { should eq 0 }
  end

  describe command('/usr/local/ruby/2.6.0/bin/gem env') do
    its('exit_status') { should eq 0 }
  end
end
