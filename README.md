# ruby-build Chef Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/ruby_build.svg)](https://supermarket.chef.io/cookbooks/ruby_build)
[![Build Status](https://img.shields.io/circleci/project/github/sous-chefs/ruby_build/master.svg)](https://circleci.com/gh/sous-chefs/ruby_build)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

## Description

Manages the [ruby-build][rb_site] framework and its installed Rubies, through custom resources.

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community of Chef cookbook maintainers working together to maintain important cookbooks. If you’d like to know more please visit [sous-chefs.org](https://sous-chefs.org/) or come chat with us on the Chef Community Slack in [#sous-chefs](https://chefcommunity.slack.com/messages/C2V7B88SF).

## Usage

```ruby
# metadata.rb
require 'ruby_build'
```

```ruby
# default.rb
ruby_build_install ''

ruby_build_definition '2.6.0'
```

## Requirements

### Chef

- Chef 13.10+

### Platforms

The following platforms have been tested with this cookbook, meaning that the recipes and LWRPs run on these platforms without error:

- ubuntu 12.04+
- MacOS
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

```shell
knife cookbook site install ruby_build
```

### Using Berkshelf

[Berkshelf] is a cookbook dependency manager and development workflow assistant. To install Berkshelf:

```shell
cd chef-repo
gem install berkshelf
berks init
```

To use the Supermarket version:

```ruby
echo "cookbook 'ruby_build'" >> Berksfile
berks install
```

Or to reference the Git version:

```ruby
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

- `"none"`: will not update ruby-build and leave it in its current state.
- `"sync"`: updates ruby-build to the version specified by the `git_ref` attribute or the head of the master branch by default.

The default is `"none"`.

## Resources and Providers

### ruby_build_ruby

#### Actions

| Action    | Description                                                                                                                           | Default |
| --------- | ------------------------------------------------------------------------------------------------------------------------------------- | ------- |
| install   | Build and install a Ruby from a definition file. See the [ruby-build readme][rb_readme] for more details.                             | Yes     |
| reinstall | Force a recompiliation of the Ruby from source. The :install action will skip a build if the target install directory already exists. |

#### Attributes

| Attribute   | Description                                                                                                                                                                            | Default Value |
| ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- |
| definition  | **Name attribute:** the name of a [built-in definition][rb_definitions] or the path to a ruby-build definition file.                                                                   | `nil`         |
| prefix_path | The path to which the Ruby will be installed.                                                                                                                                          | `nil`         |
| user        | A user which will own the installed Ruby. The default value of `nil` denotes a system-wide Ruby (root-owned) is being targeted. **Note:** if specified, the user must already exist.   | `nil`         |
| group       | A group which will own the installed Ruby. The default value of `nil` denotes a system-wide Ruby (root-owned) is being targeted. **Note:** if specified, the group must already exist. | `nil`         |
| environment | A Hash of [additional environment variables][rb_environment] such as `CONFIGURE_OPTS` or `RUBY_BUILD_MIRROR_URL`.                                                                      | `nil`         |

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

- Ubuntu 12.04 and rubinius needs an apt repo for LLVM as the build tools rely on LLVM version between 3.0 and 3.5:

  ```ruby
  apt_repository 'llvm' do
  uri 'http://llvm.org/apt/precise'
  distribution 'llvm-toolchain-precise-3.5'
  components ['main']
  end
  ```

- Ubuntu 14.04 and ruby 2.0.0 patch versions <457

  - The readline and openssl extensions have an [issue](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=741825) patched in 457

## Contributors

This project exists thanks to all the people who [contribute.](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false)

### Backers

Thank you to all our backers!

![https://opencollective.com/sous-chefs#backers](https://opencollective.com/sous-chefs/backers.svg?width=600&avatarHeight=40)

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website.

![https://opencollective.com/sous-chefs/sponsor/0/website](https://opencollective.com/sous-chefs/sponsor/0/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/1/website](https://opencollective.com/sous-chefs/sponsor/1/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/2/website](https://opencollective.com/sous-chefs/sponsor/2/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/3/website](https://opencollective.com/sous-chefs/sponsor/3/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/4/website](https://opencollective.com/sous-chefs/sponsor/4/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/5/website](https://opencollective.com/sous-chefs/sponsor/5/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/6/website](https://opencollective.com/sous-chefs/sponsor/6/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/7/website](https://opencollective.com/sous-chefs/sponsor/7/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/8/website](https://opencollective.com/sous-chefs/sponsor/8/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/9/website](https://opencollective.com/sous-chefs/sponsor/9/avatar.svg?avatarHeight=100)
