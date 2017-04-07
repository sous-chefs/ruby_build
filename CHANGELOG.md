# activemq Cookbook CHANGELOG

This file is used to list changes made in each version of the activemq cookbook.

## 1.1.0 / 2017-04-07

- Maintenance of this cookbook has been moved to the Sous Chefs organization - <http://sous-chefs.org/>
- Switched git installation to the git cookbook
- Sped up converge times by using multi-package installs when available
- Added Chefspec matchers
- Removed a duplicate package that was causing warnings on Chef 12 / failures on Chef 13
- Ensured that multi-package installs would continue on Amazon Linux with Chef 13
- Removed some fragile and unnecessary code that checked to see if we were on Chef 12+
- Switched testing to Delivery local mode and removed all test gems from the Gemfile.
- Added a skeleton Chefspec test suite
- Updated to more modern Ruby versions to test with

## 1.0.0 / 2016-07-18

### BREAKING CHANGES:

- This cookbook has been moved under the chef-rbenv Github organization to allow for additional committers and further maintenance
- The cookbook now requires Chef 12 due to the use of multi-package installations
- Existing lists of package dependencies have been updated to match those on the ruby-build wiki. This removes several runtime dependencies such as readline, zlib, and subversion

### Additional Changes

- Added support for installing Rubinius dependencies when installing Rubinius
- Added dependency installation on OS X machines
- Added support for FreeBSD
- Added a dependency on yum-epel when on RHEL
- Added Travis CI integration testing using kitchen-dokken and inspec
- Added cookstyle for Ruby linting and resolved all warnings
- Updated the ruby-build Github URL to the new location
- Switched package dependency logic to use platform_family which supports additional derivative distros
- Add source_url, issues_url, and chef_version metadata to metadata.rb
- Updated the LWRP to use use_inline_resources for proper update notifications
- Added a Chef 11+ style default_action to the LWRP
- Updated attribute file to use default instead of node.set which avoids deprecation warnings
- Updated the Berksfile to use Supermarket
- Updated the Gemfile with the latest testing dependencies
- Added the Apache 2.0 license file
- Updated readme to remove HTML tables that don't render in Supermarket
- Swapped the Rakefile for the standard Chef Rakefile

## 0.8.0 / 2013-05-22

### Bug fixes

- Pull request [#8]: Remove libyaml-devel pkg dependency for Red Hat family platforms. ([@fnichol])

### Improvements

- Pull request [#9]: Use the HTTPS clone URL. ([@adammck])
- Pull request [#10]: Use old-form notifies to support AWS OpsWorks. ([@tsabat])
- Issue [#7]: Install Git package(s) only if Git is not previously installed. ([@fnichol], [@ChrisLundquist])
- Convert project from Jamie to Test Kitchen. ([@fnichol])

## 0.7.2 / 2012-12-31

### Bug fixes

- Add missing package dependencies for C Ruby versions on RHEL family. ([@fnichol])

### Improvements

- Print Ruby build time to :info logger (formerly :debug). ([@fnichol])
- Add integration tests for commonly installed Ruby versions. ([@fnichol])

## 0.7.0 / 2012-11-21

### New features

- Add environment attr to ruby_build_ruby. This allows for adding custom compilation flags, as well as newer ruby-build environment variables, such as RUBY_BUILD_MIRROR_URL. ([@fnichol])

### Improvements

- Update foodcritic configuration and update .travis.yml. ([@fnichol])
- Update Installation section of README (welcome Berkshelf). ([@fnichol])

## 0.6.2 / 2012-05-03

### Bug fixes

- ruby_build_ruby LWRP now notifies when updated (FC017). ([@fnichol])
- Add plaform equivalents in default attrs (FC024). ([@fnichol])
- JRuby requires make package on Ubuntu/Debian. ([@fnichol])
- Ensure `Chef::Config[:file_cache_path]` exists in solo mode. ([@fnichol])

### Improvements

- Add TravisCI to run Foodcritic linter. ([@fnichol])
- Reorganize README with section links. ([@fnichol])

## 0.6.0 / 2011-12-10

The initial release.

[#10]: https://github.com/fnichol/chef-ruby_build/issues/10
[#7]: https://github.com/fnichol/chef-ruby_build/issues/7
[#8]: https://github.com/fnichol/chef-ruby_build/issues/8
[#9]: https://github.com/fnichol/chef-ruby_build/issues/9
[@adammck]: https://github.com/adammck
[@chrislundquist]: https://github.com/ChrisLundquist
[@fnichol]: https://github.com/fnichol
[@tsabat]: https://github.com/tsabat
