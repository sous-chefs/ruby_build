#!/usr/bin/env bats

export ruby_root="/usr/local/ruby/2.1.0"
export def="$(basename $ruby_root)"

load _verify_tests

@test "Ruby $def can use openssl from stdlib" {
  run_openssl_test
}

@test "Ruby $def can install nokogiri gem" {
  run_nokogiri_install_test
}

@test "Ruby $def can use nokogiri with openssl" {
  run_nokogiri_openssl_test
}
