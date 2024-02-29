module RegexReplaceFilter
  # From https://github.com/Shopify/liquid/issues/202#issuecomment-19112872
  def regex_replace(input, regex, replacement = '')
    input.to_s.gsub(Regexp.new(regex), replacement.to_s)
  end
end

Liquid::Template.register_filter(RegexReplaceFilter)
