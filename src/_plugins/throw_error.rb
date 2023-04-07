module ThrowErrorFilter
  def throw_error(message)
    raise message
  end
end

Liquid::Template.register_filter(ThrowErrorFilter)
