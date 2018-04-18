module Jekyll
  class CnReader < Jekyll::Reader

    def read
      @site.layouts = LayoutReader.new(site).read
      read_directories
      sort_files!
      @site.data = Jekyll::CnDataReader.new(site).read(site.config["data_dir"])
      CollectionReader.new(site).read
      ThemeAssetsReader.new(site).read
    end

  end
end