# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$:.unshift(lib) unless $:.include?(lib)

# Maintain your gem's version:
require "landable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |gem|
  gem.name          = "landable"
  gem.version       = Landable::VERSION

  gem.authors       = ["Team Trogdor"]
  gem.email         = ["trogdor@cashnetusa.com"]

  gem.homepage      = "http://git.cashnetusa.com/trogdor/landable"

  gem.license       = "MIT-LICENSE"

  gem.summary       = "Mountable CMS engine for Rails"
  gem.description   = "Landing page storage, rendering, tracking, and management API"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }

  gem.require_paths = ["lib"]

  gem.add_dependency "rails",     "~> 4.0.0.rc1"
  gem.add_dependency "rack-cors", ">= 0.2.7"
  gem.add_dependency "active_model_serializers", "~> 0.8"

  gem.add_development_dependency "pg"
  gem.add_development_dependency "rspec-rails",        '~> 2.13.0'
  gem.add_development_dependency "factory_girl_rails", '~> 4.2.0'
  gem.add_development_dependency "combustion",         '~> 0.5.0'
end