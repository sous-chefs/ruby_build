name              'ruby_build'
maintainer        'Sous Chefs'
maintainer_email  'help@sous-chefs.org'
license           'Apache-2.0'
description       'Manages the ruby-build framework and its installed rubies. A LWRP is also defined.'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '1.1.0'

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
depends 'git'

source_url "https://github.com/sous-chefs/#{name}"
issues_url "https://github.com/sous-chefs/#{name}/issues"
chef_version '>= 13.0' if respond_to?(:chef_version)
