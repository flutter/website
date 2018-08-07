module Jekyll
  class ESGenerator < Generator
    safe true
    PREFIX = "es_ES"

    def generate(site)
      lang = site.config["lang"] || "en"
      if !PREFIX.eql?(lang)
        return
      end
      puts "Configuration file: Habilitar archivo de configuración，Español"
      translatedNum = 0
      deleteList = []
      site.pages.each do |page|
        newPath = "#{site.source}/#{PREFIX}/#{page.path}"
        isFileExist = File.exist?(newPath)
        if isFileExist
          deleteList << page
          translatedNum += 1
        end
      end
      site.pages -= deleteList
      totalNum = site.pages.size
      completeP = translatedNum * 100 / totalNum.to_f
      completePStr = format('%.2f', completeP)
      puts "=================== Progreso de la traducción：#{translatedNum}/#{totalNum}，Porcentaje：#{completePStr}%"
      # site.pages.each do |page|
      #   puts "#{page.url} => #{page.path}"
      # end
    end
  end
end