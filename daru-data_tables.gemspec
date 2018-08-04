# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "daru/data_tables/version"

Gem::Specification.new do |spec|
  spec.name          = "daru-data_tables"
  spec.version       = Daru::View::VERSION
  spec.authors       = ["shekharrajak"]
  spec.email         = ["shekharstudy@ymail.com"]

  spec.summary       = %q{Ruby gem for the jQuery Javascript library Datatables}
  spec.description   = %q{Ruby gem for the jQuery Javascript library Datatables}
  spec.homepage      = "https://github.com/shekharrajak/data_tables"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'actionview'
  spec.add_development_dependency 'byebug'
  spec.add_runtime_dependency 'daru'

  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'rubocop'
end
