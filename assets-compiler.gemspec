# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "assets/compiler/version"

Gem::Specification.new do |s|
  s.name        = "assets-compiler"
  s.version     = Assets::Compiler::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = "Jonathan Tropper"
  s.email       = "tropperstyle@gmail.com"
  s.homepage    = "http://rubygems.org/gems/assets-compiler"
  s.summary     = "A static asset compiler"
  s.description = "Can be used to compile any static assets (etc minify javascript)"

  s.rubyforge_project = "assets-compiler"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

	s.add_dependency('closure-compiler', '>= 1.0.0')
end
