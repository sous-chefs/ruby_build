## 0.7.1 (unreleased)


## 0.7.0 (November 21, 2012)

### New features

* Add environment attr to ruby_build_ruby. This allows for adding custom
  compilation flags, as well as newer ruby-build environment variables, such
  as RUBY_BUILD_MIRROR_URL. ([@fnichol][])

### Improvements

* Update foodcritic configuration and update .travis.yml. ([@fnichol][])
* Update Installation section of README (welcome Berkshelf). ([@fnichol][])


## 0.6.2 (May 3, 2012)

### Bug fixes

* ruby_build_ruby LWRP now notifies when updated (FC017). ([@fnichol][])
* Add plaform equivalents in default attrs (FC024). ([@fnichol][])
* JRuby requires make package on Ubuntu/Debian. ([@fnichol][])
* Ensure `Chef::Config[:file_cache_path]` exists in solo mode. ([@fnichol][])

### Improvements

* Add TravisCI to run Foodcritic linter. ([@fnichol][])
* Reorganize README with section links. ([@fnichol][])


## 0.6.0 (December 10, 2011)

The initial release.

[@fnichol]: https://github.com/fnichol
