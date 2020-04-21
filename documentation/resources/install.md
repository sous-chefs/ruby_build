# ruby_build_install

Install Ruby Build and all package dependencies

Installs ruby-build binary to `/usr/local/bin/ruby-build`

## Properties

| Property  | Ruby Type | Default  | Description                                                       |
| --------- | --------- | -------- | ----------------------------------------------------------------- |
| `git_ref` | `String`  | `master` | Git reference to download, set to a tag to get a specific version |

## Example Usage

Install Ruby 2.6.0

```ruby
# recipes/default.rb
ruby_build_install ''

ruby_build_definition '2.6.0'
```
