def nokogiri_install_cmd(ruby_dir)
  "#{ruby_dir}/bin/gem install nokogiri --no-ri --no-rdoc"
end

def nokogiri_ssl_cmd(ruby_dir)
  %{ #{ruby_dir}/bin/ruby -rrubygems -ropen-uri -rnokogiri \\
  -e "puts Nokogiri::HTML(open('https://google.com')).css('input')" }
end

%w[2.2.6 2.3.3 2.4.0 jruby-9.1.7.0].each do |rubie|
  ruby_dir = File.join('/usr/local/ruby', rubie)

  describe directory(ruby_dir) do
    it { should be_directory }
  end

  describe command(nokogiri_install_cmd(ruby_dir)) do
    its('exit_status') { should eq 0 }
  end

  describe command(nokogiri_ssl_cmd(ruby_dir)) do
    its('exit_status') { should eq 0 }
  end
end

describe file('/usr/local/bin/ruby-build') do
  it { should be_file }
  it { should be_executable }
end

describe command('/usr/local/bin/ruby-build --definitions') do
  its('exit_status') { should eq 0 }
end
