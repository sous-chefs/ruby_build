name              "ruby_build"
maintainer        "Dane Hammer"
maintainer_email  "dane.molotok@gmail.com"
license           "Apache 2.0"
description       "Manages the ruby-build framework and its installed rubies. A LWRP is also defined."
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.9.0"

supports "ubuntu"
supports "debian"
supports "freebsd"
supports "redhat"
supports "centos"
supports "fedora"
supports "amazon"
supports "scientific"
supports "suse"
supports "mac_os_x"

depends 'yum-epel'
