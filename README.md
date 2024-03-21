# Jekyll::Listme

A [Jekyll](https://jekyllrb.com/) [command](https://jekyllrb.com/docs/plugins/commands/) plugin to list tags and categories for your Jekyll website and number of their occurrencies. Choose between a JSON, YAML, or plain text output.

## Installation

```
gem 'jekyll-listme', '0.1.0', git: 'https://github.com/pirafrank/jekyll-listme', branch: 'main'
```

## Usage

Plain output is the default, or you can use `--output plain`.

```
bundle exec jekyll list --tags
bundle exec jekyll list --categories
```

You can also `--output json` or `--output yaml` to get JSON or YAML output.

```
bundle exec jekyll list --tags --output json
bundle exec jekyll list --categories --output json
```

```
bundle exec jekyll list --tags --output yaml
bundle exec jekyll list --categories --output yaml
```

## Development

Clone and run `bundle install` to get started.

Code lives in `lib/jekyll/commands` and is referenced with `require` in `lib/jekyll/listme.rb`. To experiment with that code, run `bundle exec jekyll list` from a Jekyll site with this gem added as plugin. Read more on [Jekyll's Commands documentation](https://jekyllrb.com/docs/plugins/commands/).

I got the first steps to create the template from [here](https://maxchadwick.xyz/blog/building-a-custom-jekyll-command-plugin).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pirafrank/jekyll-listme.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
