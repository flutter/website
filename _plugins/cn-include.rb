module Jekyll
  class CNInClude < Jekyll::Tags::IncludeTag

    INCLUDE_KEY = "_includes/"
    PREFIX = "zh_CN"

    def read_file(file, context)
      file_path = file.dup
      cn_file_path = file.dup
      include_index = file.index(INCLUDE_KEY)
      if include_index >= 0
        cn_file_path.insert(include_index, "#{PREFIX}/")
        File.exist?(cn_file_path) && file_path = cn_file_path
      end

      super(file_path, context)
    end

  end
end

Liquid::Template.register_tag("include", Jekyll::CNInClude)