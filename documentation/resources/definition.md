# ruby_build_install

Install a Ruby Definition (Ruby version)

## Properties

| Property      | Ruby Type | Default           | Description                                           |
| ------------- | --------- | ----------------- | ----------------------------------------------------- |
| `definition`  | String    | `n/a`             | Version of Ruby to install                            |
| `prefix_path` | String    | `/usr/local/ruby` | Location to install Ruby                              |
| `environment` | String    | `Nil`             | Environment to pass to the ruby-build install process |
| `user`        | String    | `Nil`             | User to install as                                    |
| `group`       | String    | `Nil`             | Group to install as                                   |

## Example Useage

### Install Enterprise Ruby t

```ruby
ruby_build_install ''

ruby_build_ruby "ree-1.8.7-2012.02" do
  environment({ 'CONFIGURE_OPTS' => '--no-tcmalloc' })
end
```

### Install A Ruby For A User

```ruby
ruby_build_ruby "maglev-1.0.0" do
  prefix_path "/home/deploy/.rubies/maglev-1.0.0"
  user        "deploy"
  group       "deploy"
end
```
