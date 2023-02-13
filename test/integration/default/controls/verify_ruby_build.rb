control 'Check definitions' do
  impact 1.0
  title 'Verify we can return a list of definitions'
  desc 'Verify we can get a list of Ruby definitions'
  describe command('/usr/local/bin/ruby-build --definitions') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /3.0.4/ }
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

gem_cmd = if os.darwin?
            'sudo /usr/local/ruby/3.0.4/bin/gem install ffi --no-document'
          else
            '/usr/local/ruby/3.0.4/bin/gem install ffi --no-document'
          end

control 'Install a Ruby gem' do
  impact 1.0
  title 'Verify gem install works'
  desc 'Verify gem install works, and the gem works after installation'

  describe command(gem_cmd) do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /Successfully installed ffi/ }
  end

  describe command('/usr/local/ruby/3.0.4/bin/gem env') do
    its('exit_status') { should eq 0 }
    its('stdout') { should match %r{gems/3.0.0} }
  end
end
