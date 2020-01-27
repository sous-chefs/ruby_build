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
It is for use in standalone mode. If you wish to use ruby-build with rbenv, please use the [rbenv cookbook][rbenv-cookbook].

## Requirements

### Chef

- Chef 13.10+

### Supported Platforms

- Ubuntu 16.04+
- MacOS
- debian 8+
- FreeBSD 9+
- RedHat 6+

### Cookbooks

- Java
  The java cookbook is included to make JRuby install convenient.

## Usage

<<<<<<<
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

=======

>>>>>>>
```ruby
# metadata.rb
require 'ruby_build'
```

```ruby
# default.rb
ruby_build_install ''

ruby_build_definition '2.6.0'
```

## Custom Resources

- [ruby_build_install](documentation/resources/install.md)
- [ruby_build_definition](documentation/resources/definition.md)

## License and Author

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

```text
http://www.apache.org/licenses/LICENSE-2.0
```

### Sponsors

[rb_site]: https://github.com/rbenv/ruby-build
[rbenv-cookbook]: https://github.com/sous-chefs/ruby_rbenv
[repo]: https://github.com/chef-rbenv/ruby_build

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
