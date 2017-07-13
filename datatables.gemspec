# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "datatables/version"

Gem::Specification.new do |spec|
  spec.name          = "datatables"
  spec.version       = DataTables::VERSION
  spec.authors       = ["shekharrajak"]
  spec.email         = ["shekharstudy@ymail.com"]

  spec.summary       = %q{Ruby gem for the jQuery Javascript library Datatables}
  spec.description   = %q{Ruby gem for the jQuery Javascript library Datatables}
  spec.homepage      = "https://github.com/shekharrajak/datatables.rb"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'actionview'
  spec.add_development_dependency 'byebug'
end
