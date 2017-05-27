# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "exchange_rates/version"

Gem::Specification.new do |spec|
  spec.name          = "exchange_rates"
  spec.version       = ExchangeRates::VERSION
  spec.authors       = ["andrewmcc"]
  spec.email         = ["andrew.mccafferty@gmail.com"]

  spec.summary       = "ECB Echange Rates"
  spec.description   = "Calculates exchange rates based on European Central Bank XML feed"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency "nokogiri"
  spec.add_dependency "nori"

end
