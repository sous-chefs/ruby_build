#
# Cookbook:: ruby_build
# Attributes:: default
#
# Author:: Fletcher Nichol <fnichol@nichol.ca>
#
# Copyright:: 2011-2016, Fletcher Nichol
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

# git repository containing the ruby-build framework
default['ruby_build']['git_url'] = 'https://github.com/rbenv/ruby-build.git'
default['ruby_build']['git_ref'] = 'master'

# default base path for a system-wide installed Ruby
default['ruby_build']['default_ruby_base_path'] = '/usr/local/ruby'

# ruby-build upgrade action
default['ruby_build']['upgrade'] = 'none'

case node['platform_family']
when 'rhel', 'fedora'
  default['ruby_build']['install_pkgs'] = %w( tar bash curl )
  default['ruby_build']['install_pkgs_cruby'] =
    %w( gcc-c++ patch readline-devel zlib-devel
        libffi-devel openssl-devel libyaml-devel
        make bzip2 autoconf automake libtool bison
        libxml2 libxml2-devel libxslt libxslt-devel
        gdbm-devel )
  default['ruby_build']['install_pkgs_rbx'] =
    %w( ncurses-devel llvm-static llvm-devel ) + node['ruby_build']['install_pkgs_cruby']
  default['ruby_build']['install_pkgs_jruby'] = []

when 'debian'
  default['ruby_build']['install_pkgs'] = %w( tar bash curl )
  default['ruby_build']['install_pkgs_cruby'] =
    %w( autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev
        zlib1g-dev libsqlite3-dev libxml2-dev libxslt1-dev
        libc6-dev libffi-dev libgdbm3 libgdbm-dev )
  default['ruby_build']['install_pkgs_rbx'] =
    %w( libncurses5-dev llvm-3.4 llvm-3.4-dev libeditline-dev libedit-dev
      ) + node['ruby_build']['install_pkgs_cruby']

  default['ruby_build']['install_pkgs_jruby'] = %w( make g++ )

when 'suse'
  default['ruby_build']['install_pkgs'] = %w( tar bash curl )
  default['ruby_build']['install_pkgs_cruby'] =
    %w( gcc-c++ automake patch zlib-devel libffi48-devel libyaml-devel
        sqlite3-devel libxml2-devel libxslt-devel autoconf gdbm-devel
        libopenssl-devel readline-devel libyaml-devel )
  default['ruby_build']['install_pkgs_rbx'] =
    %w( ncurses-devel ) + node['ruby_build']['install_pkgs_cruby']
  default['ruby_build']['install_pkgs_jruby'] = []

when 'mac_os_x'
  default['ruby_build']['install_pkgs'] = []
  default['ruby_build']['install_pkgs_cruby'] = %w( openssl libyaml libffi )
  default['ruby_build']['install_pkgs_jruby'] = []

when 'freebsd'
  default['ruby_build']['install_pkgs'] = []
  default['ruby_build']['install_pkgs_cruby'] =
    %w( autoconf autoconf-wrapper automake automake-wrapper indexinfo
        libedit libffi libyaml m4 perl5 gmake )
  default['ruby_build']['install_pkgs_jruby'] =
    %w( alsa-lib bash dejavu expat fixesproto fontconfig freetype2
        gettext-runtime giflib indexinfo inputproto java-zoneinfo
        javavmwrapper kbproto libICE libSM libX11 libXau libXdmcp libXext
        libXfixes libXi libXrender libXt libXtst libfontenc libpthread-stubs
        libxcb libxml2 mkfontdir mkfontscale openjdk8 recordproto renderproto
        xextproto xproto )
end
