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

  spec.metadata["allowed_push_host"] = "https://github.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/pirafrank/jekyll-listme"
  spec.metadata["changelog_uri"] = "https://github.com/pirafrank/jekyll-listme/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
