require 'rspec'
require 'simplecov'
require 'daru'
require 'daru/data_tables.rb'
require 'coveralls'
require 'simplecov-console'

Coveralls.wear!
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  [
    SimpleCov::Formatter::Console,
    # Want a nice code coverage website? Uncomment this next line!
    # SimpleCov::Formatter::HTMLFormatter
  ]
)

SimpleCov.start
