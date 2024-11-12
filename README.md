# Solidus Card Pointe

[![CircleCI](https://circleci.com/gh/solidusio-contrib/solidus_card_pointe.svg?style=shield)](https://circleci.com/gh/solidusio-contrib/solidus_card_pointe)
[![codecov](https://codecov.io/gh/solidusio-contrib/solidus_card_pointe/branch/main/graph/badge.svg)](https://codecov.io/gh/solidusio-contrib/solidus_card_pointe)

<!-- Explain what your extension does. -->

## Installation

Add solidus_card_pointe to your Gemfile:

```ruby
gem 'solidus_card_pointe'
```

Bundle your dependencies and run the installation generator:

```shell
bin/rails generate solidus_card_pointe:install
```

## Usage

<!-- Explain how to use your extension once it's been installed. -->

## Development

### Testing the extension

First bundle your dependencies, then run `bin/rake`. `bin/rake` will default to building the dummy
app if it does not exist, then it will run specs. The dummy app can be regenerated by using
`bin/rake extension:test_app`.

```shell
bin/rake
```

To run [Rubocop](https://github.com/bbatsov/rubocop) static code analysis run

```shell
bundle exec rubocop
```

When testing your application's integration with this extension you may use its factories.
You can load Solidus core factories along with this extension's factories using this statement:

```ruby
SolidusDevSupport::TestingSupport::Factories.load_for(SolidusCardPointe::Engine)
```

### Running the sandbox

To run this extension in a sandboxed Solidus application, you can run `bin/sandbox`. The path for
the sandbox app is `./sandbox` and `bin/rails` will forward any Rails commands to
`sandbox/bin/rails`.

Here's an example:

```
$ bin/rails server
=> Booting Puma
=> Rails 6.0.2.1 application starting in development
* Listening on tcp://127.0.0.1:3000
Use Ctrl-C to stop
```

### Releasing new versions

Please refer to the [dedicated page](https://github.com/solidusio/solidus/wiki/How-to-release-extensions) in the Solidus wiki.

## License

Copyright (c) 2024 Daniele Palombo, released under the New BSD License.
