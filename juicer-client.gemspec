# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'juicer'
require 'juicer/version'

Gem::Specification.new do |spec|
  spec.name          = "juicer-client"
  spec.version       = Juicer::VERSION
  spec.authors       = ["Karl Sutt"]
  spec.email         = ["karl@sutt.ee"]
  spec.summary       = %q{API client for BBC News Labs Juicer.}
  spec.description   = %q{An API client for querying the BBC News Juicer
                          programmatically.}
  spec.homepage      = "http://juicer.bbcnewslabs.co.uk"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency     "rest-client", "~> 1.7.2"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1.0"
end
