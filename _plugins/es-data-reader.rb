module Jekyll
  class EsDataReader < Jekyll::DataReader

    DATA_KEY = "_data/"
    PREFIX = "es_ES"

    def read_data_file(path)
      file_path = path.dup
      es_file_path = path.dup
      data_key_index = path.index(DATA_KEY)
      if data_key_index && data_key_index >= 0
        es_file_path.insert(data_key_index, "#{PREFIX}/")
        File.exist?(es_file_path) && file_path = es_file_path
      end
      super(file_path)
    end

  end
end