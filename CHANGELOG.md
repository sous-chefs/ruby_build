# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased

Standardise files with files in sous-chefs/repo-management

## 2.5.9 - *2024-05-02*

## 2.5.8 - *2024-05-02*

## 2.5.7 - *2024-03-01*

## 2.5.6 - *2024-03-01*

- CentOS Stream 9 uses 'crb' instead of the 'powertools' repo.

## 2.5.5 - *2023-10-26*

## 2.5.4 - *2023-09-29*

## 2.5.3 - *2023-09-28*

## 2.5.2 - *2023-09-04*

## 2.5.1 - *2023-07-10*

## 2.5.0 - *2023-05-16*

- Allow ruby-build to recognize when it needs to be upgraded.
- Allow ruby-build to reinstall Ruby if the version changes.

## 2.4.1 - *2023-05-16*

## 2.4.0 - *2023-05-16*

- Ubuntu 18 now uses 'libssl-dev' instead of 'libssl1.0-dev'

## 2.3.15 - *2023-05-15*

## 2.3.14 - *2023-04-17*

## 2.3.13 - *2023-04-07*

Standardise files with files in sous-chefs/repo-management

## 2.3.12 - *2023-04-01*

## 2.3.11 - *2023-04-01*

## 2.3.10 - *2023-04-01*

Standardise files with files in sous-chefs/repo-management

## 2.3.9 - *2023-03-20*

Standardise files with files in sous-chefs/repo-management

## 2.3.8 - *2023-03-15*

Standardise files with files in sous-chefs/repo-management

Standardise files with files in sous-chefs/repo-management

## 2.3.7 - *2023-02-27*

Standardise files with files in sous-chefs/repo-management

## 2.3.6 - *2023-02-16*

Standardise files with files in sous-chefs/repo-management

## 2.3.5 - *2023-02-14*

Standardise files with files in sous-chefs/repo-management

## 2.3.4 - *2023-02-13*

## 2.3.3 - *2023-02-13*

## 2.3.2 - *2023-02-13*

## 2.3.1 - *2022-12-06*

Standardise files with files in sous-chefs/repo-management

## 2.3.0 - *2022-08-08*

- Add `verbose` option
- Remove Delivery and move to calling RSpec directly via a reusable workflow
- Use reusable workflows
- Update test build to use Ruby 3.0.4
- Add Alma Linux & Rocky Linux / Replace CentOS 8 with CentOS Stream 8
- Standardize kitchen.dokken.yml
- Add support for Ubuntu 22.04
- Remove use of yum-centos and replace with use of yum-config-manager to make it easier to work with Alma/Rocky
- Install openssl@1.1 on MacOS

## 2.2.3 - *2022-05-16*

- Standardise files with files in sous-chefs/repo-management

## 2.2.2 - *2022-02-10*

- Standardise files with files in sous-chefs/repo-management

## 2.2.1 - *2022-02-08*

- Remove delivery folder

## 2.2.0 - *2021-12-27*

- support Chef temporary directory being located on a volume mounted `noexec`
- support Ruby installation directory being created ahead of time

## 2.1.5 - *2021-11-22*

- Retry when cloning the ruby-build code repository

## 2.1.4 - *2021-08-30*

- Standardise files with files in sous-chefs/repo-management

## 2.1.3 - *2021-06-01*

- Standardise files with files in sous-chefs/repo-management

## 2.1.2 - *2020-12-02*

- resolved cookstyle error: libraries/package_deps.rb:8:5 convention: `Layout/EmptyLineBetweenDefs`

## 2.1.1 (2020-09-16)

- resolved cookstyle error: spec/libraries/cruby_spec.rb:6:7 refactor: `ChefCorrectness/IncorrectLibraryInjection`
- Cookstyle Bot Auto Corrections with Cookstyle 6.16.8

## 2.1.0 (2020-06-17)

- Fix package_deps being passed too many arguments
- Fix switching to master when we're already on master
- Add MacOS testing

- fix broken environment property (needs a Hash, was set to String)
- update documentation pages with new custom resource name ruby_build_definition
- make the automatic addition of the Ruby version to the prefix an option
- allow users to use the old ruby_build_ruby resource name, for compatibility
- do not assume that users are running Chef 15.3.x and can use unified_mode
- add requested feature: patch

## 2.0.0 (2020-04-21)

- Remove support for JRuby, it requires an out of support Java version
- Convert to a custom resource
- Move test from bats to Inspec
- Add support for Amazon Linux
- Add support for Ubuntu 18.04

## 1.3.0 (2020-03-05)

- Add debian-10 platform to test kitchen configurations
- Migrate to github actions
- Fix CircleCI testing, bring it up to Sous-Chefs standards
- Fix Markdown
- Fix YAML
- Use platform? helper in the attributes file
- Remove the unnecessary long_description field in metadata.rb
- Fix libgdbm package name in attributes for debian 10
- Fix libgdbm package name in attributes for Ubuntu 19.04

## 1.2.0 (2019-01-23)

- Add debian-10 platform to test kitchen configurations
- Migrate to github actions
- Remove recipes
- Add ruby_build_install resource
- Add ruby_build_definition resource
- Add unit testing

## 1.1.0 (2017-04-07)

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

## 1.0.0 (2016-07-18)

- This cookbook has been moved under the chef-rbenv Github organization to allow for additional committers and further maintenance
- The cookbook now requires Chef 12 due to the use of multi-package installations
- Existing lists of package dependencies have been updated to match those on the ruby-build wiki. This removes several runtime dependencies such as readline, zlib, and subversion
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

## 0.8.0 (2013-05-22)

- Pull request [#8]: Remove libyaml-devel pkg dependency for Red Hat family platforms. ([@fnichol])
- Pull request [#9]: Use the HTTPS clone URL. ([@adammck])
- Pull request [#10]: Use old-form notifies to support AWS OpsWorks. ([@tsabat])
- Issue [#7]: Install Git package(s) only if Git is not previously installed. ([@fnichol], [@ChrisLundquist])
- Convert project from Jamie to Test Kitchen. ([@fnichol])

## 0.7.2 (2012-12-31)

- Fix missing package dependencies for C Ruby versions on RHEL family. ([@fnichol])
- Print Ruby build time to :info logger (formerly :debug). ([@fnichol])
- Add integration tests for commonly installed Ruby versions. ([@fnichol])

## 0.7.0 (2012-11-21)

- Add environment attr to ruby_build_ruby. This allows for adding custom compilation flags, as well as newer ruby-build environment variables, such as RUBY_BUILD_MIRROR_URL. ([@fnichol])
- Update foodcritic configuration and update .travis.yml. ([@fnichol])
- Update Installation section of README (welcome Berkshelf). ([@fnichol])

## 0.6.2 (2012-05-03)

- Fix ruby_build_ruby LWRP now notifies when updated (FC017). ([@fnichol])
- Fix Add plaform equivalents in default attrs (FC024). ([@fnichol])
- Fix JRuby requires make package on Ubuntu/Debian. ([@fnichol])
- Ensure `Chef::Config[:file_cache_path]` exists in solo mode. ([@fnichol])
- Add TravisCI to run Foodcritic linter. ([@fnichol])
- Reorganize README with section links. ([@fnichol])

## 0.6.0 (2011-12-10)

The initial release.

[#10]: https://github.com/fnichol/chef-ruby_build/issues/10
[#7]: https://github.com/fnichol/chef-ruby_build/issues/7
[#8]: https://github.com/fnichol/chef-ruby_build/issues/8
[#9]: https://github.com/fnichol/chef-ruby_build/issues/9
[@adammck]: https://github.com/adammck
[@chrislundquist]: https://github.com/ChrisLundquist
[@fnichol]: https://github.com/fnichol
[@tsabat]: https://github.com/tsabat
