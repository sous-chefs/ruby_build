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

def gem_install_cmd
  # Install a popular gem with native extensions that doesnt take so long that
  # builds timeout (as is the case with nokogiri).
  '/usr/local/ruby/2.6.0/bin/gem install ffi --no-document'
end

control 'Install a Ruby gem' do
  impact 1.0
  title 'Verify gem install works'
  desc 'Verify gem install works, and the gem works after installation'

  describe command(gem_install_cmd) do
    its('exit_status') { should eq 0 }
  end
end
