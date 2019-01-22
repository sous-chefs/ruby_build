# default['java']['jdk_version'] = value_for_platform(
#   'debian' => { '8' => '7' },
#   'default' => '8'
# )

default['java']['jdk_version'] = if platform_family?('debian') && node['platform_version'].to_f < 9
                                   '7'
                                 else
                                   '8'
                                 end
