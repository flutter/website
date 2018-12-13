##
## Classes that support the processing of <?code-excerpt?> and
## <?code-pane?> instructions.
##

require 'open3'
require 'nokogiri'
require 'yaml'

module NgCodeExcerpt

  class MarkdownProcessor

    @@log_file_name = 'code-excerpt-log.txt'
    @@log_entry_count = 0
    @log_diffs = false

    File.delete(@@log_file_name) if File.exist?(@@log_file_name)

    def initialize
    end

    def code_excerpt_regex
      /^(\s*(<\?(code-\w+)[^>]*>)\n)((\s*)```(\w*)\n(.*?)\n(\s*)```\n?)?/m;
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
      lang = !match[6] || match[6].empty? ? (args['ext'] || 'nocode') : match[6]
      attrs = mk_code_example_directive_attr(lang, args['linenums'])

      return process_code_pane(pi, attrs, args) if pi_name == 'code-pane'

      if pi_name != 'code-excerpt'
        log_puts "Warning: unrecognized instruction: #{pi}"
        return match[0]
      elsif !optional_code_block
        # w/o a code block assume it is a set cmd
        process_set_command(pi, args)
        return ''
      elsif lang == 'diff'
        return _diff(match[7], args)
      end

      title = args['title']
      classes = args['class']
      code = match[7]

      code = trim_min_leading_space(code)

      # We escape all code fragments (not just HTML fragments),
      # because we're rendering the code block as HTML.
      escaped_code = CGI.escapeHTML(code)

      code_excerpt(title, classes, attrs, _process_highlight_markers(escaped_code), indent)
    end

    def code_excerpt(title, classes, attrs, escaped_code, indent)
      result = _unindented_template(title, classes, attrs, escaped_code)
      # For markdown, indent at most the first line (in particular, we don't want to indent the code)
      result.sub!(/^/, indent) if indent
      result
    end

    def _diff(unified_diff_text, args)
      log_puts "Diff input:\n#{unified_diff_text}" if @log_diffs
      begin
        o, e, _s = Open3.capture3('npx diff2html --su hidden -i stdin -o stdout', :stdin_data => unified_diff_text)
        log_puts e if e.length > 0
      rescue Errno::ENOENT => _e
        raise "** ERROR: diff2html isn't installed or could not be found. " \
              'To install with NPM run: npm install -g diff2html-cli'
      end
      doc = Nokogiri::HTML(o)
      doc.css('div.d2h-file-header span.d2h-tag').remove
      diff_html = doc.search('.d2h-wrapper')
      _trim_diff(diff_html, args) if args['from'] || args['to']
      log_puts "Diff output:\n#{diff_html.to_s[0, [diff_html.to_s.length, 100].min]}...\n" if @log_diffs
      diff_html.to_s
    end

    def _process_highlight_markers(s)
      s.gsub(/\[!/, '<span class="highlight">')
       .gsub(/!\]/, '</span>')
    end

    def _trim_diff(diff_html, args)
      # The code updater truncates the diff after `to`. Only trim before `from` here.
      # (We don't trim after `to` here because of an unwanted optimizing behavior of diff2html.)
      log_puts ">>> from='#{args['from']}' to='#{args['to']}'" if @log_diffs
      inside_matching_lines = done = false
      diff_html.css('tbody.d2h-diff-tbody tr').each do |tr|
        if tr.text.strip.start_with?('@')
          tr.remove
          next
        end
        code_line = tr.xpath('td[2]//span').text
        inside_matching_lines = true if !done && !inside_matching_lines && code_line.match(args['from'] || '.')
        saved_inside_matching_lines = inside_matching_lines
        # if inside_matching_lines && args['to'] && code_line.match(args['to'])
        #   inside_matching_lines = false
        #   done = true;
        # end
        log_puts ">>> tr (#{saved_inside_matching_lines}) #{code_line} -> #{tr.text.gsub(/\s+/, ' ')}" if @log_diffs
        tr.remove unless saved_inside_matching_lines
      end
    end

    # @param [String] _div_classes, in the form "foo bar"
    # @param [Hash] attrs: attributes as attribute-name/value pairs.
    def _unindented_template(title, _div_classes, attrs, escaped_code)
      div_classes = ['code-example']
      div_classes << _div_classes if _div_classes

      pre_classes = attrs[:class] || []
      pre_classes.unshift("lang-#{attrs[:lang]}") if attrs[:lang]
      pre_classes.unshift('prettyprint')

      # <code-example data-webdev-raw #{attr_str attrs}>#{
      # escaped_code
      # }</code-example>

      <<~TEMPLATE.gsub(/!n\s*/,'').sub(/\bescaped_code\b/,escaped_code)
        <div class="#{div_classes * ' '}">
        #{title ? "<header><h4>#{title}</h4></header>" : '!n'}
        <copy-container>!n
          <pre class="#{pre_classes * ' '}">!n
            <code ng-non-bindable>escaped_code</code>!n
          </pre>!n
        </copy-container>
        </div>
      TEMPLATE
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
      # puts ">> path base set to #{@@path_base}"
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

  end
end
