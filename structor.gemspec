# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'structor/version'

Gem::Specification.new do |spec|
  spec.name          = "structor"
  spec.version       = Structor::VERSION
  spec.authors       = ["Roman Kuznietsov"]
  spec.email         = ["roman.kuznietsov@gmail.com"]
  spec.description   = %q{nested structure validator}
  spec.summary       = %q{Provides a simple DSL to define nested data schemas
and perform checks generating verbose error messages}
  spec.homepage      = "https://github.com/romankuznietsov/structor"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
