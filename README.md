# Jekyll ListMe

[![Gem Version](https://img.shields.io/gem/v/jekyll-listme)](https://rubygems.org/gems/jekyll-listme)
[![GitHub Release](https://img.shields.io/github/v/release/pirafrank/jekyll-listme)](https://github.com/pirafrank/jekyll-listme/releases/latest)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A [Jekyll](https://jekyllrb.com/) [command](https://jekyllrb.com/docs/plugins/commands/) plugin to list and count data in your Jekyll website. List tags, categories, and more, and count their occurrencies. Choose among various output formats.

## Installation

1. Add the plugin to you Jekyll site's `Gemfile` in the `:jekyll_plugins` group:

```Gemfile
group :jekyll_plugins do
  gem 'jekyll-listme'
end
```

2. Run `bundle install`

### From git

Alternatively, you can get code straight from this repository. Code from `main` branch should be stable enough but may contain unreleased software with bugs or breaking changes. Unreleased software should be considered of beta quality.

```Gemfile
group :jekyll_plugins do
  gem 'jekyll-listme', git: 'https://github.com/pirafrank/jekyll-listme', branch: 'main'
end
```

## Update

```sh
bundle update jekyll-listme
```

## Usage

Plain text is the default output format:

```sh
bundle exec jekyll list tags
bundle exec jekyll list categories
```

You can choose an output format like this:

```sh
bundle exec jekyll list tags --output FORMAT
bundle exec jekyll list categories --output FORMAT
```

You can also count items, instead of listing them:

```sh
bundle exec jekyll list --count tags --output FORMAT
bundle exec jekyll list --all --output FORMAT
```

Supported formats are:

- `plain`
- `json`
- `yaml`
- `csv`
- `tsv`
- `psv`

## Development

Clone and run `bundle install` to get started.

Code lives in `lib/jekyll/commands` and is referenced with `require` in `lib/jekyll/listme.rb`. To experiment with that code, run `bundle exec jekyll list` from a Jekyll site with this gem added as plugin. Read more on [Jekyll's Commands documentation](https://jekyllrb.com/docs/plugins/commands/).

I got the first steps to create the template from [here](https://maxchadwick.xyz/blog/building-a-custom-jekyll-command-plugin).

## Contributing

[Bug reports](https://github.com/pirafrank/jekyll-listme/issues) and [pull requests](https://github.com/pirafrank/jekyll-listme/pulls) are welcome on GitHub.

## Guarantee

This plugin is provided as is, without any guarantee. Use at your own risk.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
