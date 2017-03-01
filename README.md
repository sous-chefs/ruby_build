# ruby-build Chef Cookbook

[![Build Status](https://travis-ci.org/sous-chefs/ruby_build.svg?branch=master)](https://travis-ci.org/sous-chefs/ruby_build)

## Description

Manages the [ruby-build][rb_site] framework and its installed Rubies. A lightweight resources and providers (lwrp) is also defined.

## Usage

Simply include `recipe[ruby_build]` in your run_list to have ruby-build installed. You will also have access to the `ruby_build_ruby` resource. See the See Resources and Providers section for more details.

## Requirements

### Chef

- Chef 12.1+

### Platforms

The following platforms have been tested with this cookbook, meaning that the recipes and LWRPs run on these platforms without error:

- ubuntu 12.04+
- mac_os_x
- debian 7+
- freebsd 9+
- rhel 6+
- fedora
- suse 13+

There might be more that work successfully as well, but those are not tested in test kitchen.

Please [report][issues] any additional platforms so they can be added.

### Cookbooks

There are **no** external cookbook dependencies. However, if you are installing [JRuby] then a Java runtime will need to be installed. The Opscode [java cookbook][java_cb] can be used on supported platforms.

## Installation

Depending on the situation and use case there are several ways to install this cookbook. All the methods listed below assume a tagged version release is the target, but omit the tags to get the head of development.

### From Supermarket

To install this cookbook from the Chef Supermarket, use the _knife_ command:

```
knife cookbook site install ruby_build
```

### Using Berkshelf

[Berkshelf] is a cookbook dependency manager and development workflow assistant. To install Berkshelf:

```
cd chef-repo
gem install berkshelf
berks init
```

To use the Supermarket version:

```
echo "cookbook 'ruby_build'" >> Berksfile
berks install
```

Or to reference the Git version:

```
repo="chef_rbenv/ruby_build"
latest_release=$(curl -s https://api.github.com/repos/$repo/git/refs/tags \
| ruby -rjson -e '
  j = JSON.parse(STDIN.read);
  puts j.map { |t| t["ref"].split("/").last }.sort.last
')
cat >> Berksfile <<END_OF_BERKSFILE
cookbook 'ruby_build',
  :git => 'git://github.com/$repo.git', :branch => '$latest_release'
END_OF_BERKSFILE
```

## Recipes

### default

Installs the ruby-build codebase and initializes Chef to use the Lightweight Resources and Providers ([LWRPs][lwrp]).

## Attributes

### git_url

The Git URL which is used to install ruby-build.

The default is `"git://github.com/rbenv/ruby-build.git"`.

### git_ref

A specific Git branch/tag/reference to use when installing ruby-build. For example, to pin ruby-build to a specific release:

```ruby
node['ruby_build']['git_ref'] = "v20111030"
```

The default is `"master"`.

### default_ruby_base_path

The default base path for a system-wide installed Ruby. For example, the following resource:

```ruby
ruby_build_ruby "1.9.3-p0"
```

will be installed into `"#{node['ruby_build']['default_ruby_base_path']}/1.9.3-p0"` unless a `prefix_path` attribute is explicitly set.

The default is `"/usr/local/ruby"`.

### upgrade

Determines how to handle installing updates to the ruby-build framework. There are currently 2 valid values:

- `"none"`, `false`, or `nil`: will not update ruby-build and leave it in its current state.
- `"sync"` or `true`: updates ruby-build to the version specified by the `git_ref` attribute or the head of the master branch by default.

The default is `"none"`.

## Resources and Providers

### ruby_build_ruby

#### Actions

Action    | Description                                                                                                                           | Default
--------- | ------------------------------------------------------------------------------------------------------------------------------------- | -------
install   | Build and install a Ruby from a definition file. See the [ruby-build readme][rb_readme] for more details.                             | Yes
reinstall | Force a recompiliation of the Ruby from source. The :install action will skip a build if the target install directory already exists. |

#### Attributes

Attribute   | Description                                                                                                                                                                            | Default Value
----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------
definition  | **Name attribute:** the name of a [built-in definition][rb_definitions] or the path to a ruby-build definition file.                                                                   | `nil`
prefix_path | The path to which the Ruby will be installed.                                                                                                                                          | `nil`
user        | A user which will own the installed Ruby. The default value of `nil` denotes a system-wide Ruby (root-owned) is being targeted. **Note:** if specified, the user must already exist.   | `nil`
group       | A group which will own the installed Ruby. The default value of `nil` denotes a system-wide Ruby (root-owned) is being targeted. **Note:** if specified, the group must already exist. | `nil`
environment | A Hash of [additional environment variables][rb_environment] such as `CONFIGURE_OPTS` or `RUBY_BUILD_MIRROR_URL`.                                                                      | `nil`

#### Examples

##### Install Ruby

```ruby
# See: https://github.com/sstephenson/ruby-build/issues/186
ruby_build_ruby "ree-1.8.7-2012.02" do
  environment({ 'CONFIGURE_OPTS' => '--no-tcmalloc' })
end

ruby_build_ruby "1.9.3-p0" do
  prefix_path "/usr/local/ruby/ruby-1.9.3-p0"
  environment({
    'RUBY_BUILD_MIRROR_URL' => 'http://local.example.com'
  })

  action      :install
end

ruby_build_ruby "jruby-1.6.5"
```

**Note:** the install action is default, so the second example is more common.

##### Install A Ruby For A User

```ruby
ruby_build_ruby "maglev-1.0.0" do
  prefix_path "/home/deploy/.rubies/maglev-1.0.0"
  user        "deploy"
  group       "deploy"
end
```

##### Reinstall Ruby

```ruby
ruby_build_ruby "rbx-1.2.4" do
  prefix_path "/opt/rbx-1.2.4"

  action      :reinstall
end
```

**Note:** the Ruby will be built whether or not the Ruby exists in the `prefix_path` directory.

## Known Issues

Public work on this cookbook has resumed after a hiatus. Accordingly, some combinations of versions have issues that you have to work around.

1. Ubuntu 12.04 and rubinius needs an apt repo for LLVM as the build tools rely on LLVM version between 3.0 and 3.5:

  ```ruby
  apt_repository 'llvm' do
  uri 'http://llvm.org/apt/precise'
  distribution 'llvm-toolchain-precise-3.5'
  components ['main']
  end
  ```

2. Ubuntu 14.04 and ruby 2.0.0 patch versions <457

  - The readline and openssl extensions have an [issue](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=741825) patched in 457

## License and Author

Author:: [Fletcher Nichol][fnichol] ([fnichol@nichol.ca](mailto:fnichol@nichol.ca))

Copyright 2011-2016, Fletcher Nichol

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

```
http://www.apache.org/licenses/LICENSE-2.0
```

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

[berkshelf]: http://berkshelf.com/
[cheffile]: https://github.com/applicationsonline/librarian/blob/master/lib/librarian/chef/templates/Cheffile
[fnichol]: https://github.com/fnichol
[issues]: https://github.com/chef-rbenv/ruby_build/issues
[java_cb]: https://supermarket.chef.io/cookbooks/java
[jruby]: http://jruby.org/
[kgc]: https://github.com/websterclay/knife-github-cookbooks#readme
[librarian]: https://github.com/applicationsonline/librarian#readme
[rb_definitions]: https://github.com/rbenv/ruby-build/tree/master/share/ruby-build
[rb_environment]: https://github.com/rbenv/ruby-build#special-environment-variables
[rb_readme]: https://github.com/rbenv/ruby-build#readme
[rb_site]: https://github.com/rbenv/ruby-build
[repo]: https://github.com/chef-rbenv/ruby_build
