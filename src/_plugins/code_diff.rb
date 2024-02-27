# Copyright (c) 2018, the project authors.  Please see the AUTHORS file
# for details. All rights reserved. Use of this source code is governed by a
# BSD-style license that can be found in the LICENSE file.

require 'liquid/tag/parser' # https://github.com/envygeeks/liquid-tag-parser
require_relative 'code_diff_core'

module Jekyll

  module Tags

    class CodeDiff < Liquid::Block

      def initialize(tag_name, string_of_args, tokens)
        super
        @args = Liquid::Tag::Parser.new(string_of_args).args
        @log_diffs = false
      end

      def render(liquid_context)
        helper = DartSite::CodeDiffCore.new
        helper.render(@args, super)
      end

    end
  end
end

Liquid::Template.register_tag('diff'.freeze, Jekyll::Tags::CodeDiff)

