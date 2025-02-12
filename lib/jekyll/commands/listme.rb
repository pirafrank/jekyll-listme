require 'json'

module Jekyll
  module Commands
    class ListMe < Command
      class << self

        def init_with_program(prog)
          prog.command(:list) do |c|
            c.description "List tags and categories used in the site."
            c.syntax "list [items] [options]"

            # nb. check the short option because it may be used elsewhere.
            #     run --help to see the full list of options.
            c.option "output", "-o", "--output FORMAT", "Output format"
            c.option "count", "-c", "--count", "Count the number of items"
            c.option "all", "-a", "--all", "Count all items"

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

        def init_site(opts)
          Jekyll.logger.adjust_verbosity(opts)
          options = configuration_from_options(opts)
          options["show_drafts"] = true
          site = Jekyll::Site.new(options)
          site.reset
          site.read
          @site = site
        end

        def populate_results(choice)
          results = Hash.new(0)
          case choice
            when "tags"
              results["tags"] = get_tags()
            when "categories"
              results["categories"] = get_categories()
            when "drafts"
              results["drafts"] = get_posts(true)
            when "posts"
              results["posts"] = get_posts(false)
            when "pages"
              results["pages"] = get_pages()
            else
              Jekyll.logger.error "Invalid option. You must specify a known option. Check --help."
              return
          end
          results
        end

        def process(args, opts)
          supported_items = [ "tags", "categories", "drafts", "posts", "pages" ]
          choice = opts["all"] ? "all" : args[0]
          if choice.nil?
            Jekyll.logger.error "You must specify items to list.\nSupported items are: #{supported_items.join(", ")}"
            return
          end
          # normalize to lowercase
          choice = choice.downcase
          unless supported_items.include?(choice) || opts["all"]
            Jekyll.logger.error "Invalid argument. Supported items are: #{supported_items.join(", ")}"
            return
          end

          opts["output"] = normalize_output_format(opts["output"])
          supported_formats = [ "plain", "yaml", "json", "csv", "tsv", "psv" ]
          unless supported_formats.include?(opts["output"])
            Jekyll.logger.error "Invalid output format. Supported formats are: #{supported_formats.join(", ")}"
            return
          end

          # Generate the website
          init_site(opts)
          # Populate the results based on the choice
          to_print = Hash.new(0)
          if choice != "all"
            results = populate_results(choice)
            if opts["count"]
              to_print[choice] = count_items(results[choice])
            else
              to_print = results[choice]
            end
          else
            supported_items.each do |item|
              results = populate_results(item)
              to_print[item] = count_items(results[item])
            end
          end

          # finally print the data
          print_data(to_print, opts)
        end

        def print_data(data, opts)
          print_list_text(data) if opts["output"] == "plain"
          print_list_yaml(data) if opts["output"] == "yaml"
          print_list_json(data) if opts["output"] == "json"
          print_list_text(data, ",") if opts["output"] == "csv"
          print_list_text(data, "\t") if opts["output"] == "tsv"
          print_list_text(data, "|") if opts["output"] == "psv"
        end

        def count_items(list)
          count = 0
          if list.class == Hash
            count = list.keys.length
          elsif list.class == Array
            count = list.length
          end
          count
        end

        def get_categories()
          @site.categories.keys
        end

        def get_tags()
          tags = Hash.new(0)
          # Loop through all the posts
          @site.posts.docs.each do |post|
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
          tags.sort_by { |tag, count| tag.downcase }.to_h
        end

        def get_posts(is_draft)
          list = []
          @site.posts.docs.sort_by { |post| post.data["date"] }.each do |post|
            if post.data['draft'] == is_draft
              iso_date = post.data["date"].iso8601
              post_id = generate_base58_from_string(post.data['slug'])
              title = post.data['title']
              list << { "date" => iso_date, "id" => post_id, "title" => title }
            end
          end
          list
        end

        def get_pages()
          pages = Hash.new(0)
          @site.pages.each do |page|
            pages[page.url] = page.data['title']
          end
          pages
        end

        def generate_base58_from_string(str)
          # Generate a base58 string from the input string
          alphabet = "123456789abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ"
          base = alphabet.length
          base58 = ""
          num_hex = Digest::SHA1.hexdigest(str)
          num = num_hex.to_i(16)
          while num > 0
            num, remainder = num.divmod(base)
            base58 = alphabet[remainder] + base58
          end
          base58
        end

        def print_list_text(list, separator = " ")
          if list.class == Hash
            list.each do |key, value|
              puts "#{key}#{separator}#{value}"
            end
          elsif list.class == Array
            list.each do |item|
              if item.class == String
                puts "#{item}"
              elsif item.class == Hash
                puts item.values.join(separator)
              elsif item.class == Array
                puts item.join(separator)
              else
                puts "Invalid data type"
              end
            end
          else
            puts "Invalid data type"
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

      end
    end
  end
end
