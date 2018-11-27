# Arrow

Arrow brings functional programming capabilities to Ruby. It features:

- Function composition
- Monads:
  - Maybe

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'arrow'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install arrow

## Usage

### Function Composition

### Monads

#### Maybe

The Maybe monad operates similar to Haskell. It is comprised of two data types: Just and Maybe. To use it:

```ruby
maybe = Maybe(1)
#=> Just(1)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mattmoore/ruby-arrow.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
