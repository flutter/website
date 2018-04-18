module Jekyll
  class CnDataReader < Jekyll::DataReader

    DATA_KEY = "_data/"
    PREFIX = "zh_CN"

    def read_data_file(path)
      file_path = path.dup
      cn_file_path = path.dup
      data_key_index = path.index(DATA_KEY)
      if data_key_index && data_key_index >= 0
        cn_file_path.insert(data_key_index, "#{PREFIX}/")
        File.exist?(cn_file_path) && file_path = cn_file_path
      end
      super(file_path)
    end

  end
end