# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'company_check/version'

Gem::Specification.new do |spec|
  spec.name          = "company_check"
  spec.version       = CompanyCheck::VERSION
  spec.authors       = ["Clive Shirley"]
  spec.email         = ["clive.shirley@mac.com"]
  spec.summary       = %q{Simple SSO wrapper for companycheck.com}
  spec.description   = %q{Implements a simple SSO API wrapper for companycheck.com using faraday}
  spec.homepage      = "https:/github.com/cshirley/company_check"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_dependency "faraday"
  spec.add_dependency "json"

end
