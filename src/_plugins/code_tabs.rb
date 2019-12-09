# Defines a tag that renders a code sample with multiple languages.
#
# This custom tag was written by the Flutter team for the Flutter website.
#
# Example Android usage:
#
#   {% samplecode sample-title %}
#   {% sample Java %}
#   <?code-excerpt "MyActivity.java" title?>
#   ```java
#   // Java code here
#   ```
#   {% sample Kotlin %}
#   <?code-excerpt "MyActivity.kt" title?>
#   ```kotlin
#   // Kotlin code here
#   ```
#   {% endsamplecode %}
#
# Example iOS usage:
#
#   {% samplecode sample-title %}
#   {% sample Objective-C %}
#   <?code-excerpt "MyVC.h" title?>
#   ```objectivec
#   // Header file code
#   ```
#   <?code-excerpt "MyVC.c" title?>
#   ```objectivec
#   // Implementation file code
#   ```
#   {% sample Swift %}
#   <?code-excerpt "MyVC.swift" title?>
#   ```swift
#   // Swift code here
#   ```
#   {% endsamplecode %}
#
# The "samplecode" tag accepts a single parameter that represents the title of this sample. The
# title is not displayed on the page, but it is injected into a number of HTML attributes to
# differentiate itself from other code samples. The "samplecode" tag is a block tag and therefore
# must be closed with a "endsamplecode" tag.
#
# The "sample" tag accepts one parameter: the name of the language as it should appear to
# the reader.
#
# Code samples are placed directly beneath their associated "sample" tag.
#
# Helpful maintenance information:
#
# You can log with the following command:
# Jekyll.logger.info("Log message")
#
# You can get crash stack traces with:
# ./tool/serve.sh --trace
#
# Understanding custom tags and this class:
#
# There does not seem to be much documentation available for creating custom Liquid tags. The root
# class "Tag" establishes a number of methods that are called at specific times by the templating
# engine. The "Block" class subclasses "Tag" and adds some behavior on top of that protocol.
#
# The fundamental process is:
# 1. The templating engine instructs the Block/Tag to "parse()" a given tag with parameters and content
#    - the 1st parameter, tag_name, is the literal name of the tag
#    - the 2nd parameter, params, is a string that includes all content that appears after the tag name in a tag.
#      The Liquid template engine does not parse multiple parameters for you. You have to do that, yourself.
#    - the 3rd parameter, tokens, is an object that understands all types of content that follows this tag, e.g.,
#      other tags and regular text content. The tokens object is used by the Block class to find and report each
#      inner tag that it finds, so it should probably not be directly manipulated in this class.
#
# 2. The Block superclass looks for other tags within itself while parsing
#    a. If inner tags are found, but not recognized, then the "unknown_tag()" method is invoked.
#    b. This class overrides "unknown_tag()" to find inner "sample" tags.
#    c. For each "sample" tag, fields are set that will be processed when rendering.
#
# 3. The Block/Tag is instructed to "render()". The render step occurs after all parsing is complete. Therefore,
#    it appears that the standard workflow is to collect all needed information during parsing and then apply it
#    during rendering.
#    a. HTML for language tabs are generated for all languages that were found.
#    b. HTML for each code sample is generated, inserting the literal code that was written beneath the given
#       "sample" tag.
#    c. The generated code is returned form the "render()" function.
#
# Reading the source code for Tag, Block, and BlockBody will be helpful in understanding this code. In the
# Liquid project, those classes can be found at:
#
# - lib/liquid/tag.rb
# - lib/liquid/block.rb
# - lib/liquid/block_body.rb
module Jekyll

    class SampleCode < Liquid::Block

        def initialize(tag_name, params, tokens)
            super
            # Title that differentiates this code sample from others on the page.
            @title = params.strip

            # Info needed to render the HTML for the language tabs above the sample.
            @tabs = CodeTabsBlock.new(@title)

            # Info needed to render each per-language code sample.
            @codeBlocks = []

            # List of BlockBody's to facilitate the standard parsing process.
            @blocks = []
            @blocks << @tabs
        end

        # Invoked by the superclass throughout the parsing process. The nodelist
        # represents the mutating data structure that is being filled during parsing.
        #
        # By default the super class has a single BodyBlock and that BodyBlock's internal
        # nodelist is used here. We override that behavior, offering our own list, which
        # allows us to construct a list of various kinds of BodyBlocks, e.g., CodeTabBlock
        # and CodeBlocks.
        def nodelist
            @blocks
        end

        # Invoked by the superclass to parse this tags contents.
        #
        # We override this method to force parsing to use our @blocks list.
        def parse(tokens)
            while parse_body(@blocks.last, tokens)
            end
        end

        # Invoked by the superclass as it parses the content block and
        # finds additional Liquid tags.
        def unknown_tag(name, params, tokens)
            if name == "sample"
                language = params.strip
                codeBlock = CodeBlock.new(@title, language)

                @tabs.addLanguage(language)
                @codeBlocks << codeBlock
                @blocks << codeBlock
            else
                super
            end
        end

        def render(context)
            output = ""
            output += @tabs.render(context) + "\n"

            # Start rendering code blocks with an appropriate div.
            output += "<div class=\"tab-content\">" + "\n"

            # We want to display the first code block when the page loads. To do that
            # we tell the first code block that it is active, which will generate the
            # appropriate HTML to display itself.
            @codeBlocks[0].is_active = true

            # Render all language code blocks.
            for codeBlock in @codeBlocks do
                output += codeBlock.render(context) + "\n"
            end

            # Close the code blocks div.
            output += "</div>\n"

            # Return the rendered output
            output.strip
        end
    end

    class CodeTabsBlock < Liquid::BlockBody
        def initialize(title)
            super()
            @title = title
            @languages = [].to_set
        end

        def addLanguage(language)
            @languages << language
        end

        def render(context)
            output = %Q(<ul class="nav nav-tabs sample-code-tabs" id="#{@title}-language" role="tablist">)

            is_active = true
            for language in @languages
                languageLower = language.downcase
                output += %Q(
<li class="nav-item">
  <a class="nav-link #{is_active ? "active" : ""}" id="#{@title}-#{languageLower}" href="\##{@title}-#{languageLower}-tab" role="tab" aria-controls="#{@title}-#{languageLower}" aria-selected="true">#{language}</a>
</li>
)
                is_active = false
            end
            
            output += "</ul>"
            output.strip
        end
    end

    class CodeBlock < Liquid::BlockBody
        attr_reader :language_name
        attr_accessor :is_active

        def initialize(title, language_name)
            super()
            @title = title
            @language_name = language_name
            @is_active = false
        end

        def render(context)
            code = super
            language_name_lower = @language_name.downcase
            %Q(
<div class="tab-pane #{@is_active ? "active" : ""}" id="#{@title}-#{language_name_lower}-tab" role="tabpanel" aria-labelledby="#{@title}-#{language_name_lower}-tab" markdown="1">
#{code}
</div>
)
        end
    end
end

Liquid::Template.register_tag('samplecode', Jekyll::SampleCode)