##
## Classes that support the processing of <?code-excerpt?> and
## <?code-pane?> instructions.
##

require 'active_support'
require 'active_support/isolated_execution_state'
require 'active_support/core_ext/string'
require 'open3'
require 'nokogiri'
require 'yaml'
require_relative 'code_diff_core'
require_relative 'dart_site_util'

module DartSite

  class CodeExcerptProcessor

    # @param code_framer is used to wrap code blocks with HTML that provides
    # features like code block headers and a copy-code button.
    def initialize(code_framer)
      @@log_file_name = 'code-excerpt-log.txt'
      @@log_entry_count = 0
      @log_diffs = false

      File.delete(@@log_file_name) if File.exist?(@@log_file_name)

      # @site_title = Jekyll.configuration({})['title']
      @code_differ = DartSite::CodeDiffCore.new
      @code_framer = code_framer
    end

    def code_excerpt_regex
      /^(\s*(<\?(code-\w+)[^>]*>)\n)((\s*)```((\w*)([^\n]*))\n(.*?)\n(\s*)```\n?)?/m;
    end

    def code_excerpt_processing_init
      @path_base = ''
    end

    def process_code_excerpt(match)
      # pi_line_with_whitespace = match[1]
      pi = match[2] # full processing instruction <?code-excerpt...?>
      pi_name = match[3]
      args = process_pi_args(pi)
      optional_code_block = match[4]
      indent = match[5]
      secondary_class = match[6]
      lang = !match[7] || match[7].empty? ? (args['ext'] || 'nocode') : match[7]
      attrs = mk_code_example_directive_attr(lang, args['linenums'])

      return process_code_pane(pi, attrs, args) if pi_name == 'code-pane'

      if pi_name != 'code-excerpt'
        log_puts "Warning: unrecognized instruction: #{pi}"
        return match[0]
      elsif !optional_code_block
        # w/o a code block assume it is a set cmd
        process_set_command(pi, args)
        return ''
      end

      code = match[9]
      leading_whitespace = get_indentation_string(optional_code_block)
      code = Util.trim_min_leading_space(code)

      if lang == 'diff'
        diff = @code_differ.render(args, code)
        diff.indent!(leading_whitespace.length) if leading_whitespace
        return diff
      end

      title = args['title']
      classes = args['class']

      # We escape all code fragments (not just HTML fragments),
      # because we're rendering the code block as HTML.
      escaped_code = CGI.escapeHTML(code)

      code = @code_framer.frame_code(title, classes, attrs, _process_highlight_markers(escaped_code), indent, secondary_class)
      code.indent!(leading_whitespace.length) if leading_whitespace
      code
    end

    def _process_highlight_markers(s)
      # Only replace [! and !] if both exist
      s.gsub(/\[!(.*?)!\]/m, '<span class="highlight">\1</span>')
    end

    def trim_min_leading_space(code)
      lines = code.split(/\n/);
      non_blank_lines = lines.reject { |s| s.match(/^\s*$/) }

      # Length of leading spaces to be trimmed
      len = non_blank_lines.map{ |s|
        matches = s.match(/^[ \t]*/)
        matches ? matches[0].length : 0 }.min

      len == 0 ? code : lines.map{|s| s.length < len ? s : s[len..-1]}.join("\n")
    end

    # @return [Hash] of attributes as attribute-name/value pairs.
    #   Supported attribute names (all optional):
    #   - [Array] `:class`
    #   - [String] `:lang`
    def mk_code_example_directive_attr(lang, linenums)
      classes = []
      classes << 'linenums' if linenums
      classes << 'nocode' if lang == 'nocode'
      attrs = {}
      attrs[:class] = classes unless classes.empty?
      attrs[:lang] = lang unless lang == 'nocode'
      attrs
    end

    # @param [Hash] attrs: attributes as attribute-name/value pairs.
    # @return [String] Attributes as a single string: 'foo="bar" baz="..."'
    def attr_str(attrs)
      attributes = []
      attrs.each do |name, value|
        attr_as_s = name.to_s
        value *= ' ' if value.kind_of?(Array)
        attr_as_s += %Q(="#{value}") if value
        attributes << attr_as_s
      end
      attributes * ' '
    end

    def process_pi_args(pi)
      # match = /<\?code-\w+\s*(("([^"]*)")?((\s+[-\w]+="[^"]*"\s*)*))\?>/.match(pi)
      match = /<\?code-\w+\s*(.*?)\s*\?>/.match(pi)
      unless match
        log_puts "ERROR: improperly formatted instruction: #{pi}"
        return nil
      end

      arg_string = match[1]
      args = { }

      # First argument can be unnamed. When present, it is saved as
      # args['']. It is used to define a path and an optional region.
      match = /^"(([^("]*)(\s+\(([^"]+)\))?)"/.match(arg_string)
      if match
        arg_string = $' # reset to remaining args
        args[''] = match[1]
        path = args['path'] = match[2]
        args['ext'] = File.extname(path)&.sub(/^\./,'')
        args['region'] = match[4]&.gsub(/[^\w]+/, '-') || ''
      end

      # Process remaining args
      arg_string.scan(/\b(\w[-\w]*)(="([^"]*)")?/) { |id,arg,val|
        if id == 'title' && !arg then val = trim_file_vers(args['']) end
        args[id] = val || ''
      }
      # puts "  >> args: #{args}"
      args
    end

    # @param [Hash] attrs: attributes as attribute-name/value pairs.
    def process_code_pane(pi, _attrs, args)
      # TODO: support use of globally set replace args.
      title = args['title'] || trim_file_vers(args[''])
      escaped_code = get_code_frag(args['path'],
                                   full_frag_path(args['path'], args['region']),
                                   src_path(args['path'], args['region']),
                                   args['region'])
      # args['replace'] syntax: /regex/replacement/g
      # Replacement and '_g' are currently mandatory (but not checked)
      if args['replace']
        _, re, replacement, _g = args['replace'].split '/'
        escaped_code.gsub!(Regexp.new(re)) {
          match = Regexp.last_match
          # TODO: doesn't yet recognize escaped '$' ('\$')
          while (arg_match = /(?<=\$)(\d)(?!\d)/.match(replacement)) do
            next unless arg_match
            replacement.gsub!("$#{arg_match[0]}", match[arg_match[0].to_i])
          end
          if /\$\d+|\\\$/.match?(replacement)
            raise "Plugin doesn't support \\$, or more than 9 match groups $1, ..., $9: #{replacement}.\nAborting."
          end
          if replacement.include? '$&'
            replacement.gsub('$&', match[0])
          else
            replacement
          end
        }
      end
      escaped_code = _process_highlight_markers(escaped_code)
      attrs = {}
      attrs[:language] = _attrs[:lang] if _attrs[:lang]
      attrs[:format] = _attrs[:class] if _attrs[:class]
      <<~TEMPLATE
        #{pi}
        <code-pane name="#{title}" #{attr_str attrs}>#{escaped_code}</code-pane>
      TEMPLATE
    end

    def process_set_command(_pi, args)
      # Ignore all commands other than path-base.
      path_base = args['path-base']
      return unless path_base
      @path_base = path_base.sub(/\/$/, '')
      # puts ">> path base set to '#{@path_base}'"
    end

    def get_code_frag(proj_rel_path, _frag_path, src_path, region)
      excerpt_yaml_path = File.join(Dir.pwd, 'tmp', '_fragments', @path_base, proj_rel_path + '.excerpt.yaml');
      if File.exist? excerpt_yaml_path
        yaml = YAML.load_file(excerpt_yaml_path)
        result = yaml[region]
        if result.nil?
          result = "CODE EXCERPT not found: region '#{region}' not found in #{excerpt_yaml_path}"
          log_puts result
        else
          lines = result.split(/(?<=\n)/) # split and keep separator
          result = escape_and_trim_code(lines)
        end
      # We don't generate frag_path fragments anymore:
      # elsif File.exists? frag_path
      #   lines = File.readlines frag_path
      #   result = escapeAndTrimCode(lines)
      elsif region.empty? && src_path && (File.exist? src_path)
        lines = File.readlines src_path
        result = escape_and_trim_code(lines)
        raise 'CODE EXCERPT not found: no .excerpt.yaml file ' \
         "and source contains docregions: #{src_path}" if result.include? '#docregion'
      else
        result = "CODE EXCERPT not found: #{excerpt_yaml_path}, region='#{region}'"
        log_puts result
      end
      result
    end

    def full_frag_path(proj_rel_path, region)
      frag_rel_path = File.join(@path_base, proj_rel_path)
      if region && !region.empty?
        dir = File.dirname(frag_rel_path)
        basename = File.basename(frag_rel_path, '.*')
        ext = File.extname(frag_rel_path)
        frag_rel_path = File.join(dir, "#{basename}-#{region}#{ext}")
      end
      frag_extension = '.txt'
      File.join(Dir.pwd, 'tmp', '_fragments', frag_rel_path + frag_extension)
    end

    def src_path(proj_rel_path, region)
      region == '' ? File.join(@path_base, proj_rel_path) : nil
    end

    def escape_and_trim_code(lines)
      # Skip blank lines at the end too
      while !lines.empty? && lines.last.strip == '' do lines.pop end
      CGI.escapeHTML(lines.join)
    end

    def log_puts(s)
      puts(s)
      file_mode = (@@log_entry_count += 1) <= 1 ? 'w' : 'a'
      File.open(@@log_file_name, file_mode) do |logFile| logFile.puts(s) end
    end

    def trim_file_vers(s)
      # Path/title like styles.1.css or foo_1.dart? Then drop the '.1' or '_1' qualifier:
      match = /^(.*)[._]\d(\.\w+)(\s+.+)?$/.match(s)
      s = "#{match[1]}#{match[2]}#{match[3]}" if match
      s
    end

    def get_indentation_string(s)
      match = s.match(/^[ \t]*/)
      match ? match[0] : nil
    end

  end
end
