name              'ruby_build'
maintainer        'Fletcher Nichol'
maintainer_email  'fnichol@nichol.ca'
license           'Apache 2.0'
description       'Manages the ruby-build framework and its installed rubies. A LWRP is also defined.'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '1.0.0'

supports 'ubuntu'
supports 'debian'
supports 'freebsd'
supports 'redhat'
supports 'centos'
supports 'fedora'
supports 'amazon'
supports 'scientific'
supports 'suse'
supports 'opensuse'
supports 'opensuseleap'
supports 'mac_os_x'

depends 'yum-epel'

source_url 'https://github.com/chef-rbenv/ruby_build'
issues_url 'https://github.com/chef-rbenv/ruby_build/issues'

chef_version '>= 11.0' if respond_to?(:chef_version)
