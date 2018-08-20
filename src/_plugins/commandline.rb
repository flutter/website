# Copyright (c) 2017, the Chromium project authors.  Please see the AUTHORS file
# for details. All rights reserved. Use of this source code is governed by a
# BSD-style license that can be found in the LICENSE file.

module CommandLine

  # Wraps lines intended for the command line.
  #
  # Example usage:
  # 
  # {% commandline %}
  # // dart code here
  # {% endcommandline %}
  class Tag < Liquid::Block

    def initialize(tag_name, markup, tokens)
      super
    end

    def render(context)
      # out = '<pre><code>'
      out = '<pre><code>'

      contents = super

      contents = contents.split("\n")
          .map{|line| line.strip}
          .select{|line| line.length > 0}
          .map{|line| "<span class=\"noselect\">$ </span>#{line}" }
          .join("\n")

      out += contents + "</code></pre>"
    end

  end
end

Liquid::Template.register_tag('commandline', CommandLine::Tag)