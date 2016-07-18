require 'spec_helper'

rubies = %w( 2.1.9 2.2.5 2.3.1 jruby-9.0.5.0 rbx-2.5.8 )

rubies.each do |rubie|
  describe "#{rubie} install" do
    describe file("/usr/local/ruby/#{rubie}") do
      it { should be_directory }
    end
  end
end
