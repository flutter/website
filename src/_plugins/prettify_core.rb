require 'cgi'
require_relative 'dart_site_util'

module DartSite

  # Base class used by some Liquid Block plugins to render code that gets
  # prettified by https://github.com/google/code-prettify.
  #
  # The following markup syntax can be used to apply a CSS class to a span
  # of code:
  #
  #   `[[foo]]some code[[/foo]]`
  #
  # will render as
  #
  #   `<span class="foo">some code</span>`
  #
  # Note that `[[highlight]]...[[/highlight]]` can be abbreviated using the
  # following shorthand: `[!...!]`.
  #
  class PrettifyCore

    # @param code [String], raw code to be converted to HTML.
    # @param lang [String], e.g., 'dart', 'json' or 'yaml'
    # @param tag_specifier [String] matching "pre|pre+code|code|code+br".
    #   This is the HTML element used to wrap the prettified
    #   code. The `code` element is used for `code+br`; in addition,
    #   newlines in the code excerpt are reformatted at `<br>` elements.
    # @param user_classes [String] zero or more space separated CSS class names
    #   to be applied to the outter-most enclosing tag.
    # @param context [String] 'html' or 'markdown' (default), represents whether
    #   the tag is being rendered in an HTML or a markdown document. Indentation
    #   is preserved for markdown but not for HTML.
    def code2html(code, lang: nil, context: 'markdown', tag_specifier: 'pre', user_classes: nil)
      tag = _get_real_tag(tag_specifier || 'pre')
      css_classes = _css_classes(lang, user_classes)
      class_attr = css_classes.empty? ? '' : " class=\"#{css_classes.join(' ')}\""

      out = "<#{tag}#{class_attr}>"
      out += '<code>' if tag_specifier == 'pre+code'

      code = context == 'markdown' ?
                 Util.block_trim_leading_whitespace(code.split(/\n/)).join("\n") :
                 Util.trim_min_leading_space(code)
      # Strip leading and trailing whitespace so that <pre> and </pre> tags wrap tightly
      code.strip!
      code = CGI.escapeHTML(code)

      if tag_specifier == 'code+br'
        code.gsub!(/\n[ \t]*/) { |s|
          "<br>\n#{'&nbsp;' * (s.length - 1)}"
        }
      end

      # Names of tags previously supported: highlight, note, red, strike.
      code.gsub!(/\[\[([\w-]+)\]\]/, '<span class="\1">')
      code.gsub!(/\[\[\/([\w-]*)\]\]/, '</span>')

      # Flutter tag syntax variant:
      code.gsub!(/\/\*\*([\w-]+)\*\//, '<span class="\1">')
      code.gsub!(/\/\*-([\w-]*)\*\//, '</span>')

      code.gsub!('[!', '<span class="highlight">')
      code.gsub!('!]', '</span>')

      out += code
      out += '</code>' if tag_specifier == 'pre+code'
      out += "</#{tag}>"
    end

    private

    def _css_classes(lang, user_classes)
      css_classes = []
      unless lang == 'nocode' || lang == 'none'
        css_classes << 'prettyprint'
        css_classes << "lang-#{lang}" if lang
      end
      css_classes << user_classes if user_classes
      css_classes
    end

    # Returns the word before the '+' if tag_specifier contains a '+',
    # tag_specifier otherwise
    def _get_real_tag(tag_specifier)
      tag_specifier[/^[^\+]+(?=\+)/] || tag_specifier
    end
  end
end
