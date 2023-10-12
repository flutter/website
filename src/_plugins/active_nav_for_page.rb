module ActiveNavForPage
  def active_nav_for_page(page_url_path = '', active_nav)
    # Split the path for this page
    # Example: docs.flutter.dev/cookbook/networking/update-data ->
    # [cookbook, networking, update-data]
    parts = page_url_path.downcase.split('/').drop(1)
    current_path_pairs = active_nav
    last_allowed_backup_active = []

    parts.each do |part|
      # If the current entry allows children and has active data
      # allow its active data to be a backup if a later path is not found.
      unless current_path_pairs['active'].nil? or current_path_pairs['allow-children'] == false
        last_allowed_backup_active = current_path_pairs['active']
      end

      paths = current_path_pairs['paths']

      # If the current entry has children paths,
      # explore those next.
      unless paths.nil?
        current_path_pairs = paths
      end

      # Get the data for the next part.
      next_pair = current_path_pairs[part]

      # If the next part of the path does not have data,
      # use the active data for the current backup.
      if next_pair.nil?
        return last_allowed_backup_active
      end
      current_path_pairs = next_pair
    end

    # If the last path part has active data, use that,
    # otherwise fallback to the backup active data.
    active_entries = current_path_pairs['active']
    if active_entries.nil?
        active_entries = last_allowed_backup_active
    end

    return active_entries
  end
end

Liquid::Template.register_filter(ActiveNavForPage)
