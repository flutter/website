require_relative 'code_excerpt_processor'

module Jekyll
  module Converters

    # This converter does some markdown preprocessing before using [Kramdown] to
    # do the full markdown conversion (to HTML).
    #
    # Currently, the only preprocessing that is done is for code-excerpt
    # instructions. See [code_excerpt_processor.rb] for details.
    #
    module MarkdownWithCodeExcerptsConverterMixin
      # Ensure subclass sets the following property:
      #
      # priority :high

      def matches(ext)
        ext =~ /^\.md$/i
      end

      def output_ext(_ext)
        '.html'
      end

    end

    class MarkdownWithCodeExcerpts
      def initialize(config = {}, code_framer = nil)
        @config = config
        @code_framer = code_framer || IdentityCodeFramer.new
      end

      def convert(content)
        @cep ||= DartSite::CodeExcerptProcessor.new(@code_framer)
        @cep.code_excerpt_processing_init
        content.gsub!(@cep.code_excerpt_regex) {
          @cep.process_code_excerpt(Regexp.last_match)
        }

        @base_conv ||= Markdown::KramdownParser.new(@config)
        @base_conv.convert(content)
      end
    end

    class IdentityCodeFramer
      def frame_code(title, classes, attrs, escaped_code, indent, secondary_class)
        escaped_code
      end
    end
  end
end
