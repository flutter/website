module DartSite

  class Util

    def self.get_indentation_string(s)
      s.match(/^[ \t]*/)[0]
    end

    # String to string transformation.
    def self.trim_min_leading_space(code)
      lines = code.split(/\n/);
      non_blank_lines = lines.reject { |s| s.match(/^\s*$/) }

      # Length of leading spaces to be trimmed
      len = non_blank_lines.map{ |s|
        matches = s.match(/^[ \t]*/)
        matches ? matches[0].length : 0 }.min

      len == 0 ? code : lines.map{|s| s.length < len ? s : s[len..-1]}.join("\n")
    end

    # This method is for trimming the content of Jekyll blocks.
    #
    # @return a copy of the input lines array, with lines unindented by the
    # maximal amount of whitespace possible without affecting relative
    # (non-whitespace) line indentation. Also trime off leading and trailing blank lines.
    def self.block_trim_leading_whitespace(lines)
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
