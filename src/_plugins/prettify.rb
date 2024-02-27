# Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
# for details. All rights reserved. Use of this source code is governed by a
# BSD-style license that can be found in the LICENSE file.

require 'liquid/tag/parser' # https://github.com/envygeeks/liquid-tag-parser
require_relative 'dart_site_util'
require_relative 'prettify_core'

module Jekyll

  module Tags

    # Liquid Block plugin to render code that gets
    # prettified by https://github.com/google/code-prettify.
    #
    # Arguments:
    #
    # - The first unnamed optional argument is the prettifier lang argument.
    #   Use 'nocode' or 'none' as the language to turn off prettifying.
    # - class="...". CSS classes to be added to the opening <pre> tag.
    # - context="html". When unspecified, the context is assumed to be markdown.
    #   In markdown, indentation of the block is preserved, in HTML the block
    #   isn't indented.
    # - tag="...". See [PrettifyCore.code2html()] for a description of
    #   accepted tag specifiers. Defaults to 'pre'.
    #
    # Code highlighting is supported; see see [PrettifyCore] for details.
    #
    # Example usage:
    #
    # {% prettify dart %}
    #   var hello = 'world';
    # {% endprettify %}
    #
    class Prettify < Liquid::Block

      def initialize(tag_name, string_of_args, tokens)
        super
        @args = Liquid::Tag::Parser.new(string_of_args).args
      end

      def render(_context)
        helper = DartSite::PrettifyCore.new
        helper.code2html(super,
                         lang: @args[:argv1],
                         context: @args[:context] || 'markdown',
                         tag_specifier: @args[:tag],
                         user_classes: @args[:class])
      end

    end
  end
end

Liquid::Template.register_tag('prettify', Jekyll::Tags::Prettify)
