# Inyecta los objetos necesarios para el complemento Español 
# antes de que el Bundle comienze a funcionar
# 1. Reemplaza el lector con EsReader
Jekyll::Hooks.register :site, :after_init do |site|
  site.reader = Jekyll::EsReader.new(site)
end