# data_tables

[![Gem Version](https://badge.fury.io/rb/daru-data_tables.svg)](https://badge.fury.io/rb/daru-data_tables)
[![Build Status](https://travis-ci.org/shekharrajak/daru-data_tables.svg?branch=master)](https://travis-ci.org/shekharrajak/daru-data_tables)
[![Coverage Status](https://coveralls.io/repos/github/Shekharrajak/daru-data_tables/badge.svg?branch=master)](https://coveralls.io/github/Shekharrajak/daru-data_tables?branch=master)

This is Ruby gem for the jQuery Javascript library. This gem is created to be used in [daru-view](https://guthub.com/shekharrajak/daru-view). It can create table from Daru::DataFrame and Daru::Vector to display in webpages as well as IRuby notebook.

DataTable is very useful in loading large dataset and also we can load data into pieces.

## Examples :

- [Rails examples](https://github.com/Shekharrajak/daru-data_tables/tree/master/spec/dummy_rails)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'daru-data_tables'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install daru-data_tables

## Usage

See iruby notebook examples and spec/dummy_rails examples.

It can work in any ruby web application (e.g. Rails/Sinatra/Nanoc)


## Update to latest js library. Additional command line

  To update to the current data_tables js and css files you can always run

    rake data_tables:update


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/data_tables. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the data_tables project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/data_tables/blob/master/CODE_OF_CONDUCT.md).
