# Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
# for details. All rights reserved. Use of this source code is governed by a
# BSD-style license that can be found in the LICENSE file.

require 'cgi'
require 'liquid/tag/parser' # https://github.com/envygeeks/liquid-tag-parser
require_relative 'prettify'

module Jekyll

  module Tags

    # A Ruby plugin equivalent of the <?code-excerpt?> instruction.
    class CodeExcerpt < Prettify

      def initialize(tag_name, string_of_args, tokens)
        super
        @args = Liquid::Tag::Parser.new(string_of_args).args
        @argv1 = @args[:argv1]
        @lang = 'dart' # TODO: set dynamically
      end

      def render(context)
        # Don't add a copy button here since we're currently adding
        # it dynamically to all <pre> elements.
        #
        # id = 'code-excerpt-1' # TODO: autogenerate id
        #
        # Extra template code was:
        #
        # <button class="code-excerpt__copy-btn" type="button"
        #     data-toggle="tooltip" title="Copy code"
        #     data-clipboard-target="##{id}">
        #   <i class="material-icons">content_copy</i>
        # </button>
        # <div id="#{id}">
        # #{super(context)}
        # </div>

        # TODO: only add header if there is a title

        %(
<div class="code-excerpt">
<div class="code-excerpt__header">
  #{CGI.escapeHTML(@argv1)}
</div>
<div class="code-excerpt__code">
#{super(context)}
</div>
</div>).strip
      end
    end
  end
end

Liquid::Template.register_tag('code_excerpt', Jekyll::Tags::CodeExcerpt)
