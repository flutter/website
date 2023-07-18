module ActiveNavGenerator
  class ActiveNavGenerator < Jekyll::Generator
    def generate(site)
      def add_part(result, path, parts, index, match_path_exactly: false)
        is_last = index == parts.length - 1
        current = result[parts[index]]
        if current.nil?
          current = {}
          result[parts[index]] = current
        end

        if is_last
          active = current['active']
          # Only override path if one isn't present
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
          add_part(current['paths'], path, parts, index + 1, match_path_exactly: match_path_exactly)
        end
      end

      def add_link(results, permalink, path, match_path_exactly: false)
      return unless not permalink.start_with? 'http'
        raise "#{permalink} does not begin with a '/'" unless permalink.start_with? '/'
        parts = permalink.split('/')
        add_part(results, path, parts, 1, match_path_exactly: match_path_exactly)
      end

      def visit_permalinks(results, nav_tree, path)
        nav_tree.each_with_index do |entry, i|
          permalink = entry['permalink']
          new_path = path + [i + 1]
          if permalink.is_a? String
            add_link(results, permalink, new_path,
                match_path_exactly: entry['match-page-url-exactly'] == true)
          end
          children = entry['children']
          if children.is_a? Array
            visit_permalinks(results, children, new_path)
          end
        end
      end

      sidenav = site.data['sidenav']

      new_sidenav_hash = sidenav.hash

      # Only regenerate activenav data if sidenav has changed
      unless (defined?(@last_sidenav_hash)).nil? or @last_sidenav_hash != new_sidenav_hash
        site.data['activenav'] = @last_activenav_results
        return
      end

      first_generation = @last_sidenav_hash.nil?

      @last_sidenav_hash = new_sidenav_hash

      results = {}

      visit_permalinks(results, site.data['sidenav'], [])

      @last_activenav_results = results
      site.data['activenav'] = results

      unless first_generation
          puts('      Regenerating with new sidenav data!')
          site.regenerator.clear
      end
    end
  end
end
