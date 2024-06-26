# Jekyll::Listme

A [Jekyll](https://jekyllrb.com/) [command](https://jekyllrb.com/docs/plugins/commands/) plugin to list and count data in your Jekyll website. List tags, categories, and more, and count their occurrencies. Choose among various output formats.

## Installation

```Gemfile
gem 'jekyll-listme', git: 'https://github.com/pirafrank/jekyll-listme', branch: 'main'
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

Bug reports and pull requests are welcome on GitHub at https://github.com/pirafrank/jekyll-listme.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
