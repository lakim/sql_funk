# -*- encoding: utf-8 -*-
require File.expand_path("../lib/sql_funk/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "sql_funk"
  s.version     = SqlFunk::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = [ 'Louis-Alban KIM' ]
  s.email       = [ 'louis.alban.kim@gmail.com' ]
  s.homepage    = "http://rubygems.org/gems/sql_funk"
  s.summary     = "Rails gem that extends ActiveRecord with SQL functions, including date functions"
  s.description = "This gem lets you use SQL functions that behaves differently depending on the database adapter that is being used."

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "sql_funk"

  s.add_development_dependency "bundler", ">= 1.0.0"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
