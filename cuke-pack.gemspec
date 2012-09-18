# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cuke-pack/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["John Bintz"]
  gem.email         = ["john@coswellproductions.com"]
  gem.description   = %q{Stuff I use for Cucumber}
  gem.summary       = %q{Stuff I use for Cucumber}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "cuke-pack"
  gem.require_paths = ["lib"]
  gem.version       = CukePack::VERSION

  gem.add_dependency 'cucumber'
  gem.add_dependency 'cucumber-step_writer'
  gem.add_dependency 'thor'
  gem.add_dependency 'flay'
  gem.add_dependency 'hirb'
  gem.add_dependency 'sourcify'
end

