# frozen_string_literal: true

require_relative "lib/jekyll/listme/version"

Gem::Specification.new do |spec|
  spec.name = "jekyll-listme"
  spec.version = Jekyll::Listme::VERSION
  spec.authors = ["Francesco Pira"]
  spec.email = ["dev@fpira.com"]

  spec.summary = "List tags and categories for your Jekyll website."
  spec.description = "Jekyll command plugin to list tags and categories for your Jekyll website and number of their occurrencies. Choose between a JSON, YAML, or plain text output."
  spec.homepage = "https://github.com/pirafrank/jekyll-listme"

  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r!^bin/!) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/pirafrank/jekyll-listme/blob/main/CHANGELOG.md"
  spec.metadata["bug_tracker_uri"] = "https://github.com/pirafrank/jekyll-listme/issues"

  spec.add_dependency "json", "~> 2.7"

  spec.add_development_dependency "bundler", "~> 2.5"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rubocop-jekyll", "~> 0.14"
end
