# ruby_build_install

Install Ruby Build and all package dependencies

Installs ruby-build binary to `/usr/local/bin/ruby-build`

## Properties

| Property       | Ruby Type | Default             | Description                                                      |
| -------------- | --------- | ------------------- | ---------------------------------------------------------------- |
| `git_ref`      | `String`  | `master`            | Git reference to download, set to a tag to get a specific version |
| `java_version` | `String`  | `8` (7 on Debian 8) | JDK version to install                                           |
| `jruby_deps`   | TrueClass | `Nil`               | Git refernce to download, set to a tag to get a specific version |

## Example Usage

Install JRuby 9.1.13.0

```ruby
# recipes/default.rb
ruby_build_install '' do
  jruby_deps true
end

ruby_build_definition 'jruby-9.1.13.0'
```

Install Ruby 2.6.0

```ruby
# recipes/default.rb
ruby_build_install ''

ruby_build_definition '2.6.0'
```
