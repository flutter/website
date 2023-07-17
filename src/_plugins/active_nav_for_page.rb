module ActiveNavForPage
  def active_nav_for_page(page_url_path = '', active_nav)
    parts = page_url_path.downcase.split('/').drop(1)
    current_path_pairs = active_nav
    last_allowed_backup_active = []

    parts.each do |part|
      # If the last entry allowed children and has active data
      # allow it to be a backup if a path is not found
      unless current_path_pairs['active'].nil? or current_path_pairs['allow-children'] == false
        last_allowed_backup_active = current_path_pairs['active']
      end

      paths = current_path_pairs['paths']
      unless paths.nil?
        current_path_pairs = paths
      end

      next_pair = current_path_pairs[part]

      # If the next part of the path does not exist
      if next_pair.nil?
        return last_allowed_backup_active
      end
      current_path_pairs = next_pair
    end

    active_entries = current_path_pairs['active']
    if active_entries.nil?
        active_entries = last_allowed_backup_active
    end

    return active_entries
  end
end

Liquid::Template.register_filter(ActiveNavForPage)
