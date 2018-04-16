module Jekyll
  class CNGenerator < Generator
    safe true
    PREFIX = "zh_CN"

    def generate(site)
      lang = site.config["lang"] || "en"
      if !PREFIX.eql?(lang)
        return
      end
      puts "Configuration file: 启用本地化文件，中文"
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
      puts "=================== 当前翻译进度：#{translatedNum}/#{totalNum}，占比：#{completePStr}%"
      # site.pages.each do |page|
      #   puts "#{page.url} => #{page.path}"
      # end
    end
  end
end