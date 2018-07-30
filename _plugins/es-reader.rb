module Jekyll
  class EsReader < Jekyll::Reader

    def read
      @site.layouts = LayoutReader.new(site).read
      read_directories
      sort_files!
      puts(site.config)
      @site.data = Jekyll::EsDataReader.new(site).read(site.config["data_dir"])
      CollectionReader.new(site).read
      ThemeAssetsReader.new(site).read
    end

  end
end