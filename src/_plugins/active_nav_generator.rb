# Generates and stores active entry data for paths
# based on the data declared in `_data/sidenav.yml`.
# This stored active entry data is used in `active_nav_for_page`
# and the `active_nav_for_page` filter it declares to
# determine which entries to indicate as active in the sidenav
# on each page.
module ActiveNavGenerator
  class ActiveNavGenerator < Jekyll::Generator
    def generate(site)
      # @param [Hash] result The subset of the the map to store activenav data for this part
      # @param [Array<Integer>] path The path of indices leading to this entry's part of sidenav
      # @param [Array<String>] parts The parts of this entry's permalink split by `/`
      # @param [Integer] index The index of the part of the path being added
      # @param [Boolean] match_path_exactly If this entry shouldn't allow children of its permalink to match
      def add_part(result, path, parts, index, match_path_exactly: false)
        is_last = index == parts.length - 1
        current = result[parts[index]]
        if current.nil?
          # If the current part isn't in the results map yet, add a new hash.
          current = {}
          result[parts[index]] = current
        end

        # If this is the last part of the path,
        # store the activenav data.
        if is_last
          active = current['active']
          # Only override activenav data if
          # it doesn't already exist for this part.
          if active.nil? or match_path_exactly
            current['active'] = path
            if match_path_exactly
              current['allow-children'] = false
            end
          end
        else
          unless current.key?('paths')
            current['paths'] = {}
          end
          # Continue to the next part
          add_part(current['paths'], path, parts, index + 1, match_path_exactly: match_path_exactly)
        end
      end

      # @param [Hash] results The map where to store resulting activenav data
      # @param [String] permalink The permalink to add the activenav data map
      # @param [Array<Integer>] path The indices of parents in the sidenav
      # @param [Boolean] match_path_exactly If this entry shouldn't allow children of its permalink to match
      def add_link(results, permalink, path, match_path_exactly: false)
        # Skip external links.
        return if permalink.start_with? 'http'

        # Throw an error if a permalink does not start with a `/`.
        raise "#{permalink} does not begin with a '/'" unless permalink.start_with? '/'

        # Split the specified permalink into parts.
        parts = permalink.split('/')

        # Add activenav data for the specified permalink
        add_part(results, path, parts, 1, match_path_exactly: match_path_exactly)
      end

      # @param [Hash] results The map where to store activenav data
      # @param [Hash] nav_tree The sidenav data or a collection of children entries
      # @param [Array<int>] path The indices of parents in the sidenav
      def visit_permalinks(results, nav_tree, path)
        # Visit each entry in the sidenav/children
        nav_tree.each_with_index do |entry, i|
          permalink = entry['permalink']
          new_path = path + [i + 1]

          # Only consider paths which actually have a permalink,
          # skipping headers, dividers, etc.
          if permalink.is_a? String
            add_link(results, permalink, new_path,
                match_path_exactly: entry['match-page-url-exactly'] == true)
          end

          # If the current sidenav entry has children,
          # visit those to build their activenav data.
          children = entry['children']
          if children.is_a? Array
            visit_permalinks(results, children, new_path)
          end
        end
      end

      sidenav = site.data['sidenav']

      new_sidenav_hash = sidenav.hash

      # Only regenerate activenav data if the sidenav has changed.
      # If it hasn't changed, use the cached activenav results:
      unless (defined?(@last_sidenav_hash)).nil? or @last_sidenav_hash != new_sidenav_hash
        site.data['activenav'] = @last_activenav_results
        return
      end

      # If last_sidenav_hash is nil, it means this will be
      # the first time generating active nav data.
      first_generation = @last_sidenav_hash.nil?

      @last_sidenav_hash = new_sidenav_hash

      results = {}

      visit_permalinks(results, site.data['sidenav'], [])

      @last_activenav_results = results
      site.data['activenav'] = results

      # If this isn't the first time generating activenav data,
      # mark each page for regeneration since
      # the sidenav needs to be regenerated.
      unless first_generation
          puts('      Regenerating with new sidenav data!')
          site.regenerator.clear
      end
    end
  end
end
