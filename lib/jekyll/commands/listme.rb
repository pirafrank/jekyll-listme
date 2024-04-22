require 'json'

module Jekyll
  module Commands
    class ListMe < Command
      class << self

        def init_with_program(prog)
          prog.command(:list) do |c|
            c.description "List tags and categories used in the site."
            c.syntax "list [options]"

            c.option "tags", "-t", "--tags", "List tags"
            c.option "categories", "-c", "--categories", "List categories"
            c.option "output", "-o", "--output FORMAT", "Output format"

            c.action do |args, options|
              options["serving"] = false
              Jekyll::Commands::ListMe.process(args, options)
            end
          end
        end

        def normalize_output_format(o)
          if o.nil? then
            o = "plain"
          else
            o = o.downcase
          end
          o
        end

        def get_site(opts)
          Jekyll.logger.adjust_verbosity(opts)
          options = configuration_from_options(opts)
          site = Jekyll::Site.new(options)
          site.reset
          site.read
          site
        end

        def process(args, opts)
          opts["output"] = normalize_output_format(opts["output"])
          supported_formats = [ "plain", "yaml", "json", "csv", "tsv", "psv", "toml" ]
          unless supported_formats.include?(opts["output"])
            Jekyll.logger.error "Invalid output format. Supported formats are: #{supported_formats.join(", ")}"
            return
          end

          if opts["tags"].nil? && opts["categories"].nil? then
            Jekyll.logger.error "You must specify either --tags or --categories."
            return
          end

          site = get_site(opts)
          list = nil
          if opts["tags"]
            list = get_tags(site)
          else
            list = get_categories(site)
          end
          print_data(list, opts)
        end

        def print_data(data, opts)
          print_list_text(data) if opts["output"] == "plain"
          print_list_yaml(data) if opts["output"] == "yaml"
          print_list_json(data) if opts["output"] == "json"
          print_list_text(data, ",") if opts["output"] == "csv"
          print_list_text(data, "\t") if opts["output"] == "tsv"
          print_list_text(data, "|") if opts["output"] == "psv"
          print_list_toml(data, opts["tags"] ? "Tags" : "Categories") if opts["output"] == "toml"
        end

        def get_categories(site)
            categories = site.categories.keys
        end

        def get_tags(site)
          tags = Hash.new(0)
          # Loop through all the posts
          site.posts.docs.each do |post|
            # Loop through each tag of the post
            post.data['tags'].each do |tag|
              # If the tag already exists in the map, increment the count
              if tags.key?(tag)
                tags[tag] += 1
              else
                # Otherwise initialize the count to 1
                tags[tag] = 1
              end
            end
          end

          # Sort the tags alphabetically (case-insensitive)
          sorted_tags = tags.sort_by { |tag, count| tag.downcase }.to_h
        end

        def print_list_text(list, separator = " ")
          # Print the output as plain text
          list.each do |item, count|
            if count.nil?
              puts "#{item}"
            else
              puts "#{item}#{separator}#{count}"
            end
          end
        end

        def print_list_json(list)
          # Print the output in JSON format
          puts JSON.pretty_generate(list)
        end

        def print_list_yaml(list)
          # Print the output in YAML format
          puts list.to_yaml
        end

        def print_list_toml(list, data_name)
          puts "[#{data_name}]"
          if list.empty? then return end
          # Print the output in TOML format
          list.each do |item, count|
            if count.nil?
              puts "\"#{item}\" = 1"
            else
              puts "\"#{item}\" = #{count}"
            end
          end
        end

      end
    end
  end
end
