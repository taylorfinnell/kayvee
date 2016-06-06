# Kayvee

A simple key value store with multiple backing implementations.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kayvee'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kayvee

## Usage

```
store = Kayvee::Store.new(:s3, aws_access_key: '', ... )
key = store.set('hello', 'world')
key.read
  => 'world'

store = Kayvee::Store.new(:redis, host: 'redis://locahost')
key = store.set('hello', 'world')
key.read
  => 'world'
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/kayvee/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
