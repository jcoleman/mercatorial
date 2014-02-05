# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mercatorial/version'

Gem::Specification.new do |spec|
  spec.name          = "mercatorial"
  spec.version       = Mercatorial::VERSION
  spec.authors       = ["James Coleman"]
  spec.email         = ["jtc331@gmail.com"]
  spec.description   = %q{A simple wrapper for the Google Maps API.}
  spec.summary       = %q{A simple wrapper for the Google Maps API.}
  spec.homepage      = "https://github.com/jcoleman/mercatorial"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "httparty", "~> 0.12.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
