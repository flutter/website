# Copied from https://github.com/dart-lang/site-shared/blob/master/src/_plugins/prettify.rb
# and slightly adapted for use with prism.js
#
# Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
# for details. All rights reserved. Use of this source code is governed by a
# BSD-style license that can be found in the LICENSE file.

require 'cgi'
require 'liquid/tag/parser' # https://github.com/envygeeks/liquid-tag-parser

module Prettify

  # Wraps code with tags for Prettify.
  #
  # Arguments:
  #
  # - The first unnamed optional argument is the prettifier lang argument.
  #   Use 'nocode' or 'none' as the language to turn of prettifying.
  # - class="..."
  # - tag="pre|pre+code|code|code+br". The HTML element used to wrap the prettified code.
  #   Default is pre. The `code` element is used for `code+br`; in addition,
  #   newlines in the code excerpt are reformatted at `<br>` elements.
  #
  # Example usage:
  #
  # {% prettify dart %}
  # var hello = 'world';
  # {% endprettify %}

  class Tag < Liquid::Block

    def initialize(tag_name, stringOfArgs, tokens)
      super
      @args = Liquid::Tag::Parser.new(stringOfArgs).args
      @lang = @args[:argv1]
      @tag = @args[:tag] || 'pre'
      @tag = 'code' if @tag == 'code+br';
      initCssClasses
    end

    def initCssClasses
      @cssClasses = []
      unless @lang == 'nocode' || @lang == 'none'
        @cssClasses << 'prettyprint highlighter-rouge highlight' # TODO: Unnecessary, remove after transition
        @cssClasses << "lang-#{@lang}" if @lang
        @cssClasses << "language-#{@lang}" if @lang # TODO: Unnecessary, remove after transition
      end
      @cssClasses << @args[:class] if @args[:class]
    end

    def classAttr
      @cssClasses.empty? ? '' : " class=\"#{@cssClasses.join(' ')}\""
    end

    def render(context)
      out = "<#{@tag}#{classAttr}>"
      out += '<code>' if @tag == 'pre'

      code = trimMinLeadingSpace(super)
      # Strip leading and trailing whitespace so that <pre> and </pre> tags wrap tightly
      code.strip!
      code = CGI::escapeHTML(code)

      if @args[:tag] == 'code+br'
        code.gsub!(/\n[ \t]*/) { |s|
          "<br>\n#{'&nbsp;' * (s.length - 1)}"
        }
      end

      # Names of tags previously supported: highlight, note, red, strike.
      code.gsub!(/\[\[(\w+)\]\]/, '<span class="nocode \1">') # TODO: 'nocode' is unnecessary, remove after transition
      code.gsub!(/\[\[\/(\w+)\]\]/, '</span>')

      # Flutter tag syntax variant:
      code.gsub!(/\/\*\*(\w+)\*\//, '<span class="nocode \1">') # TODO: 'nocode' is unnecessary, remove after transition
      code.gsub!(/\/\*-(\w+)\*\//, '</span>')

      code.gsub!('[!', '<span class="highlight">')
      code.gsub!('!]', '</span>')

      out += code
      out += '</code>' if @tag == 'pre'
      out += "</#{@tag}>"
    end

    def trimMinLeadingSpace(code)
      lines = code.split(/\n/);

      # 1. Trim leading blank lines
      while lines.first =~ /^\s*$/ do lines.shift; end

      # 2. Trim trailing blank lines. Also determine minimal
      # indentation for the entire code block.
      # This is required for uses of prettify that are indented in
      # markdown -- for example, when used in a list.

      # Last line should consist of the indentation of the `endprettify`
      # (when it is on a separate line).
      last_line = lines.last =~ /^\s*$/ ? lines.pop : ''
      while lines.last =~ /^\s*$/ do lines.pop end
      min_len = last_line.length

      nonblanklines = lines.reject { |s| s.match(/^\s*$/) }

      # 3. Determine length of leading spaces to be trimmed
      len = nonblanklines.map{ |s|
        matches = s.match(/^[ \t]*/)
        matches ? matches[0].length : 0 }.min

      # Only trim the excess relative to min_len
      len = len < min_len ? min_len : len - min_len

      len == 0 ? code : lines.map{|s| s.length < len ? s : s.sub(/^[ \t]{#{len}}/, '')}.join("\n")
    end
  end
end

Liquid::Template.register_tag('prettify', Prettify::Tag)
