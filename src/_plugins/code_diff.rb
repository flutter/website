# Copyright (c) 2018, the project authors.  Please see the AUTHORS file
# for details. All rights reserved. Use of this source code is governed by a
# BSD-style license that can be found in the LICENSE file.

require 'liquid/tag/parser' # https://github.com/envygeeks/liquid-tag-parser
require 'nokogiri'
require 'open3'
require_relative 'dart_site_util'

module Jekyll

  module Tags

    class CodeDiff < Liquid::Block

      def initialize(tag_name, string_of_args, tokens)
        super
        @args = Liquid::Tag::Parser.new(string_of_args).args
        @log_diffs = false
      end

      def render(liquid_context)
        content = super

        # Get the indentation before the closing tag.
        indentation = content.split(/\n/).last.match(/^[ \t]*/)[0]

        diff = DartSite::Util.trim_min_leading_space(content)
        lines = _diff(diff, @args).split(/\n/)

        log_puts ">> CodeDiff content (#{@args}):\n#{diff}\n---\n" if @log_diffs

        # We're rendering to markdown, and we don't want the diff table HTML
        # to be adjacent to any text, otherwise the text might not be rendered
        # as a paragraph (e.g., esp. if inside an <li>).
        lines.unshift('')
        lines.push('')

        # Indent the table in case the diff is inside a markdown list,
        # which has its content indented.
        indented_lines = lines.map{|s| indentation + s}
        indented_lines.join("\n")
      end

      def _diff(unified_diff_text, args)
        log_puts ">> Diff input:\n#{unified_diff_text}" if @log_diffs
        begin
          o, e, _s = Open3.capture3('npx diff2html --su hidden -i stdin -o stdout',
                                    stdin_data: unified_diff_text)
          log_puts e if e.length > 0
        rescue Errno::ENOENT => _e
          raise "** ERROR: diff2html isn't installed or could not be found. " \
              'To install with NPM run: npm install -g diff2html-cli'
        end
        doc = Nokogiri::HTML(o)
        doc.css('div.d2h-file-header span.d2h-tag').remove
        diff_html = doc.search('.d2h-wrapper')
        _trim_diff(diff_html, args) if args[:from] || args[:to]
        log_puts "Diff output:\n#{diff_html.to_s[0, [diff_html.to_s.length, 100].min]}...\n" if @log_diffs
        diff_html.to_s
      end

      def _trim_diff(diff_html, args)
        # The code updater truncates the diff after `to`. Only trim before `from` here.
        # (We don't trim after `to` here because of an unwanted optimizing behavior of diff2html.)
        log_puts ">>> from='#{args[:from]}' to='#{args[:to]}'" if @log_diffs
        inside_matching_lines = done = false
        diff_html.css('tbody.d2h-diff-tbody tr').each do |tr|
          if tr.text.strip.start_with?('@')
            tr.remove
            next
          end
          code_line = tr.xpath('td[2]//span').text
          inside_matching_lines = true if !done && !inside_matching_lines && code_line.match(args[:from] || '.')
          saved_inside_matching_lines = inside_matching_lines
          # if inside_matching_lines && args[:to] && code_line.match(args[:to])
          #   inside_matching_lines = false
          #   done = true;
          # end
          log_puts ">>> tr (#{saved_inside_matching_lines}) #{code_line} -> #{tr.text.gsub(/\s+/, ' ')}" if @log_diffs
          tr.remove unless saved_inside_matching_lines
        end
      end

      def log_puts(s)
        puts(s)
        # file_mode = (@@log_entry_count += 1) <= 1 ? 'w' : 'a'
        # File.open(@@log_file_name, file_mode) do |logFile| logFile.puts(s) end
      end

    end
  end
end

Liquid::Template.register_tag('diff'.freeze, Jekyll::Tags::CodeDiff)

