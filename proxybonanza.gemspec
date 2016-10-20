# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'proxybonanza/version'

Gem::Specification.new do |spec|
  spec.name          = "proxybonanza"
  spec.version       = Proxybonanza::VERSION
  spec.authors       = ["José Duarte"]
  spec.email         = ["jose.fduarte@gmail.com"]

  spec.summary       = %q{ProxyBonanza Ruby API Client Wrapper}
  spec.description   = %q{ProxyBonanza Ruby API Client Wrapper}
  spec.homepage      = "https://github.com/jduarte/proxybonanza"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"

  spec.add_dependency "faraday"
  spec.add_dependency "json"
end
