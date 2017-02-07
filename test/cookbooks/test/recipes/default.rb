#
# Cookbook Name:: test
# Recipe:: default
#
# Copyright 2012-2016, Fletcher Nichol
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

apt_update 'update'

include_recipe 'java'
include_recipe 'ruby_build'

package 'default-jre-headless' if %(ubuntu debian).include?(node['platform'])

package 'bash' if node['platform_family'] == 'freebsd'

java_alternatives 'force setting java alternatives' do
  action :set
end

%w( 2.1.9 2.2.6 2.3.3 2.4.0 jruby-9.0.5.0 ).each do |rubie|
  ruby_build_ruby rubie do
    environment('MAKE_OPTS' => "-j #{node['cpu']['total'].to_i + 1}")
  end
end

user_account 'app' do
  home '/home/app'
end
