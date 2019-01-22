

if node['platform_family'] == 'debian' && node['platform_version'] == '8'
  default['java']['jdk_version'] = '7'
else
  default['java']['jdk_version'] = '8'
end
