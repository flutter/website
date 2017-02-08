# Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
# for details. All rights reserved. Use of this source code is governed by a
# BSD-style license that can be found in the LICENSE file.

require 'cgi'

module Prettify

  # Wraps code with tags for Prettify.
  #
  # Example usage:
  # 
  # {% prettify dart %}
  # // dart code here
  # {% endprettify %}
  #
  # The language name can be ommitted if it is not known.
  class Tag < Liquid::Block

    Syntax = /\s*(\w+)\s*/o

    def initialize(tag_name, markup, tokens)
      super
      if markup =~ Syntax
        @lang = $1
      end
    end

    def unindent(original)
      indent = original.split("\n").select do |line|
        !line.strip.empty?
      end.map do |line|
        line.index(/[^\s]/)
      end.compact.min || 0
      original.gsub(/^[[:blank:]]{#{indent}}/, '')
    end

    def render(context)
      # out = '<pre class="prettyprint linenums'
      out = '<pre class="prettyprint highlighter-rouge highlight'
      unless @lang.nil?
        out += ' lang-' + @lang
        out += ' language-' + @lang
      end
      out += '"><code>'

      contents = unindent(super)

      contents = contents.strip
      contents = CGI::escapeHTML(contents)

      contents.gsub!('[[strike]]', '<span class="nocode strike">')
      contents.gsub!('[[/strike]]', '</span>')
      contents.gsub!('/**strike*/', '<span class="nocode strike">')
      contents.gsub!('/*-strike*/', '</span>')

      contents.gsub!('[[highlight]]', '<span class="nocode highlight">')
      contents.gsub!('[[/highlight]]', '</span>')
      contents.gsub!('/**highlight*/', '<span class="nocode highlight">')
      contents.gsub!('/*-highlight*/', '</span>')

      contents.gsub!('[[note]]', '<span class="nocode note">')
      contents.gsub!('[[/note]]', '</span>')
      contents.gsub!('/**note*/', '<span class="nocode note">')
      contents.gsub!('/*-note*/', '</span>')

      contents.gsub!('[[red]]', '<span class="nocode red">')
      contents.gsub!('[[/red]]', '</span>')
      contents.gsub!('/**red*/', '<span class="nocode red">')
      contents.gsub!('/*-red*/', '</span>')

      out += contents + "</code></pre>"
    end

  end
end

Liquid::Template.register_tag('prettify', Prettify::Tag)
