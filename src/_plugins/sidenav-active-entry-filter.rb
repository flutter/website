module ActiveNavEntries

  def active_nav_entry_index_array(nav_entry_tree, page_url_path = '')
    # puts(">> nav entries: #{page_url_path} #{nav_entry_tree.size}") if page_url_path.start_with? '/get-started'

    active_entry_indexes = _get_active_nav_entries(nav_entry_tree, page_url_path)
    # puts("<< nav entries: #{page_url_path} #{active_entry_indexes}") page_url_path.start_with? '/get-started'
    active_entry_indexes.empty? ? nil : active_entry_indexes
  end

  # @return array of indices to active nav entries.
  def _get_active_nav_entries(nav_entry_tree, page_url_path = '')
    # puts "  >> _get_active_nav_entries: #{page_url_path} #{nav_entry_tree.size}" if page_url_path.start_with? '/get-started'

    nav_entry_tree.each_with_index do |entry, i|
      # puts "    || _get_active_nav_entries loop: #{i} #{entry['permalink']} '#{entry['title']}'" if page_url_path.start_with? '/get-started'

      if entry['children']
        # puts "      || entry has children" if page_url_path.start_with? '/get-started'
        descendant_indexes = _get_active_nav_entries(entry['children'], page_url_path)
        if descendant_indexes.empty?
          # puts "      || no children matched" if page_url_path.start_with? '/get-started'
        else
          result = [i+1] + descendant_indexes
          # puts "      || matched! #{result}" if page_url_path.start_with? '/get-started'
          return result
        end
      else
        # puts "      || entry has NO children" if page_url_path.start_with? '/get-started'
      end

      next unless entry['permalink']

      is_active = if entry[':match-page-url-exactly'] then
                    page_url_path.include? entry['permalink']
                  else
                    page_url_path == entry['permalink']
                  end

      return [i+1] if is_active
    end
    []
  end
end

Liquid::Template.register_filter(ActiveNavEntries)
