module Jekyll

  module Tags

    # A block that preserves the indentation of its content.
    #
    # This is useful for use in markdown where indentation can be significant.
    class Indent < Liquid::Block

      # def initialize(tag_name, tag_arg_raw, liquid_parse_context) end

      def render(liquid_context)
        content = super
        lines = content.split(/\n/);
        return content if lines.length <= 1

        # Get the indentation before the closing tag.
        indentation = lines.last.match(/^[ \t]*/)[0]
        lines = _trimLeadingWhitespace(lines)

        indented_lines = lines.map{|s| indentation + s}
        # Actually, don't indent the first line since it will be
        # indented by the amount of the opening tag
        indented_lines[0].sub!(/^[ \t]+/, '')
        indented_lines.join("\n")
      end

      # @return a copy of the input lines array, with lines unindented by the maximal amount of whitespace possible
      # without affecting relative (non-whitespace) line indentation.
      def _trimLeadingWhitespace(lines)
        # 1. Trim leading blank lines
        while lines.first =~ /^\s*$/ do lines.shift; end

        # 2. Trim trailing blank lines. Also determine minimal
        # indentation for the entire block.

        # Last line should consist of the indentation of the end tag
        # (when it is on a separate line).
        last_line = lines.last =~ /^\s*$/ ? lines.pop : ''
        while lines.last =~ /^\s*$/ do lines.pop end
        min_len = last_line.length

        non_blank_lines = lines.reject { |s| s.match(/^\s*$/) }

        # 3. Determine length of leading spaces to be trimmed
        len = non_blank_lines.map{ |s|
          matches = s.match(/^[ \t]*/)
          matches ? matches[0].length : 0 }.min

        # Only trim the excess relative to min_len
        len = len < min_len ? min_len : len - min_len

        len == 0 ? lines : lines.map{|s| s.length < len ? s : s.sub(/^[ \t]{#{len}}/, '')}
      end
    end
  end
end

Liquid::Template.register_tag('indent'.freeze, Jekyll::Tags::Indent)

