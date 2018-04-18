# 在 Bundle 开始工作前将中文插件运行需要的对象注入到程序中
# 以下为需要进行注入的对象：
# 1. 将 Reader 替换为 CnReader
Jekyll::Hooks.register :site, :after_init do |site|
  site.reader = Jekyll::CnReader.new(site)
end