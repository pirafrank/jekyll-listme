# frozen_string_literal: true

require_relative "listme/version"

module Jekyll
  module Listme
    class Error < StandardError; end
    # Your code goes here...
  end
end

require_relative "commands/listme.rb"
