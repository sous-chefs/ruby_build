def gem_install_cmd(ruby_dir)
  # Install a popular gem with native extensions that doesnt take so long that
  # builds timeout (as is the case with nokogiri).
  "#{ruby_dir}/bin/gem install ffi --no-document"
end

ruby_dir = File.join('/usr/local/ruby', 'jruby-9.1.13.0')

describe directory(ruby_dir) do
  it { should be_directory }
end

describe command(gem_install_cmd(ruby_dir)) do
  its('exit_status') { should eq 0 }
end

describe file('/usr/local/bin/ruby-build') do
  it { should be_file }
  it { should be_executable }
end

describe command('/usr/local/bin/ruby-build --definitions') do
  its('exit_status') { should eq 0 }
end
