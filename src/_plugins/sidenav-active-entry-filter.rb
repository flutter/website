module ActiveNavEntries

  def active_nav_entry_index_array(nav_entry_tree, page_url_path = '')
    active_entry_indexes = _get_active_nav_entries(nav_entry_tree, page_url_path)
    active_entry_indexes.empty? ? nil : active_entry_indexes
  end

  # @return array of indices to active nav entries.
  def _get_active_nav_entries(nav_entry_tree, page_url_path = '')
    nav_entry_tree.each_with_index do |entry, i|
      if entry['children']
        descendant_indexes = _get_active_nav_entries(entry['children'], page_url_path)
        return [i+1] + descendant_indexes unless descendant_indexes.empty?
      end

      next unless entry['permalink']

      is_active = if entry['match-page-url-exactly']
                    page_url_path == entry['permalink']
                  else
                    page_url_path.include? entry['permalink']
                  end

      return [i+1] if is_active
    end
    []
  end
end

Liquid::Template.register_filter(ActiveNavEntries)
