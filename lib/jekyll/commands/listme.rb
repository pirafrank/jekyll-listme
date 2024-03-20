module Jekyll
  module Commands
    class ListMe < Command
      class << self

        def init_with_program(prog)
          prog.command(:list) do |c|
            c.description "List tags and categories used in the site."
            c.syntax "listme [options]"

            c.option "tags", "-t", "--tags", "List tags"
            c.option "categories", "-c", "--categories", "List categories"
            c.option "output", "-o", "--output FORMAT", "Output format"

            c.action do |args, options|
              options["serving"] = false
              Jekyll::Commands::ListMe.process(args, options)
            end
          end
        end

        def process(args, options)
          Jekyll.logger.adjust_verbosity(options)
          options = configuration_from_options(options)
          site = Jekyll::Site.new(options)

          site.reset
          site.read

          get_tags(site)
        end

        def get_tags(site)
          tags = {}

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
          sorted_tags = tags.sort_by { |tag, count| tag.downcase }

          # Print the output with quantity per each tag
          sorted_tags.each do |tag, count|
            puts "#{tag}: #{count}"
          end
        end

      end
    end
  end
end
