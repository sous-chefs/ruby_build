rubies = %w( 2.2.6 2.3.3 2.4.0 jruby-9.1.7.0 )

rubies.each do |rubie|
  describe directory("/usr/local/ruby/#{rubie}") do
    it { should be_directory }
  end
end

describe file('/usr/local/bin/ruby-build') do
  it { should be_file }
  it { should be_executable }
end

describe command('/usr/local/bin/ruby-build --definitions') do
  its('exit_status') { should eq 0 }
end
