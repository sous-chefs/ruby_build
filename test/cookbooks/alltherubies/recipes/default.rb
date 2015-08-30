#
# Cookbook Name:: alltherubies
# Recipe:: default
#
# Copyright 2012, Fletcher Nichol
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

cores         = node['cpu']['total'].to_i
system_rubies = %w{ 1.9.2-p320 1.9.3-p362 2.0.0-p647 2.2.3 jruby-1.7.1 }

include_recipe "java"

if %{ubuntu debian}.include?(node['platform'])
  package "default-jre-headless"
end

java_alternatives "force setting java alternatives" do
  action :set
end

# For precise (12.04), need a repo to get a high enough version of llvm to
# build rbx
apt_repository 'llvm' do
  uri 'http://llvm.org/apt/precise'
  distribution 'llvm-toolchain-precise-3.5'
  components ['main']
end

system_rubies.each do |rubie|
  ruby_build_ruby rubie do
    environment({ 'MAKE_OPTS' => "-j #{cores + 1}" })
  end
end

ruby_build_ruby "rbx-2.5.8" do
  environment({ 'MAKE_OPTS' => "-j #{cores + 1}",
                'RUBY_CONFIGURE_OPTS' => "--llvm-config=/usr/lib/llvm-3.4/bin/llvm-config" })
end

# Woah, REE, crazy bananas! For more details see:
# * https://github.com/sstephenson/rbenv/issues/297
# * https://github.com/sstephenson/ruby-build/issues/186
ruby_build_ruby "ree-1.8.7-2012.02" do
  environment({
    'MAKE_OPTS'       => "-j #{cores + 1}",
    'CONFIGURE_OPTS'  => "--no-tcmalloc",
  })
end

user_account "app" do
  home "/home/app"
end

ruby_build_ruby "1.8.7-p371" do
  prefix_path "/home/app/.rubies/ruby-1.8.7-p371"
  user        "app"
  group       "app"
  environment({ 'MAKE_OPTS' => "-j #{cores + 1}" })
end
