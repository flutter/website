---
name: write-technical-docs
description: >-
  Write or review clear, consistent, and accessible prose
  for Dart and Flutter developer documentation.
  Use for tutorials, API references, UI text, error messages,
  code comments, and terminology or style reviews.
---

# Write technical documentation

Write clear, consistent developer-facing prose.
Use the `format-markdown` skill for markup mechanics
and the `write-dart` and `write-flutter` skills for code examples.

This style is based on the [Google developer documentation style guide][].
The guide is licensed under CC BY 4.0
and is the fallback for topics not covered here.
An explicit project convention takes precedence.

[Google developer documentation style guide]: https://developers.google.com/style

## Core rules

Apply these rules to most developer-facing prose.

### Voice and stance

- Write in **second person**:
  address the reader as "you".
  Use "we" only to describe something the authoring team
  or project did.
  Never use "we" to mean "you".
  For example, don't write "we then call the function".
- Use **active voice** and name the actor:
  "Send a request to the server", not "A request is sent".
- Use **present tense**:
  "The command returns a list", not "will return".
- Keep a **conversational but professional** tone.
  Use common contractions such as "you're", "it's", and "don't".
  Skip filler enthusiasm and exclamation points.
- Don't **anthropomorphize** software:
  code doesn't "want", "think", "see", or "decide".
  A function "returns" or "produces".
  It doesn't "know".

### Clarity

- Put **purpose, context, and conditions before instructions**
  when they help the reader interpret the action.
  Write "To deploy the app, run the command"
  instead of "Run the command to deploy the app".
  Write "If the build fails, check the logs"
  instead of "Check the logs if the build fails".
  Readers need relevant framing before the action.
- Remove empty intensifiers and time-bound words:
  **avoid** _simply, just, easy, quick, currently, at this time, please,
  in order to, note that_.
- Prefer short, direct sentences.
  Lead each paragraph with its main point.

### Formatting

- Use **sentence case** for all titles and headings:
  capitalize only the first word and proper nouns.
  For example, write "Set up your environment",
  not "Set Up Your Environment".
  When referring to an existing UI label,
  match the interface unless its labels are all uppercase or inconsistent.
  In those cases, use sentence case.
- Use **code font** for code in prose.
  In Markdown, enclose code font in backticks.
  Apply it to:
  keywords, identifiers, filenames, paths,
  commands, subcommands, flags, and literal values.
- Use **bold** for the names of UI elements. For example,
  **Save**, the **Settings** menu, and the **Name** field.
- For quoted keywords, literal strings, and other exact text,
  use **logical punctuation**:
  place punctuation inside the closing quotation mark
  only when it's part of the quoted content.
  For ordinary prose quotations,
  place commas and periods inside the closing quotation mark.
  For examples, see [Punctuation](references/punctuation.md).
- Use the **serial comma**, also called the **Oxford comma**:
  "buttons, links, and menus".
- Use **descriptive link text** that names the destination.
  Never link bare "click here", "here", "this", or "read more".
- Write _and_, not `&`, except in code, a space-constrained label,
  or when matching a UI label.
- Write **unambiguous dates**:
  "January 5, 2026" or "2026-01-05", never "01/05/26".

### Lists

- Use a **numbered list** for sequential steps or ranked items.
- Use a **bulleted list** for unordered items.
- Use a **term-and-description list** for pairs of related data,
  such as fields and their meanings.
  For Markdown syntax,
  follow the `format-markdown` guidance for the target platform.
- Keep list items **parallel** in grammar and roughly parallel in length.
  For example, start all items with a verb
  or write all items as noun phrases.

### Content and inclusion

- **Don't pre-announce** unreleased features, dates, or plans.
  Document only released behavior.
  For additional guidance, see [Voice and tone](references/voice-and-tone.md).
- Write for a **global audience**: avoid idioms, cultural references,
  humor that doesn't translate, and directional words that assume a layout.
- Use **inclusive language**:
  prefer _allowlist_ and _blocklist_ over _whitelist_ and _blacklist_,
  _primary_ and _replica_ over _master_ and _slave_,
  _placeholder_ over _dummy_,
  and people-first or community-preferred phrasing.
  For additional guidance,
  see [Inclusive and global writing](references/inclusive-and-global.md)
  and [Word choice](references/word-choice.md).

## References

Read only the references relevant to the text you're writing or reviewing:

- **[Voice and tone](references/voice-and-tone.md)**:
  Stance, tense, active voice, claims, jargon, recommendations,
  and stable wording.
- **[Grammar and usage](references/grammar.md)**:
  Abbreviations, capitalization, pronouns, sentence structure,
  and API-reference verb forms.
- **[Punctuation](references/punctuation.md)**:
  Commas, dashes, hyphens, end punctuation, quotation marks, and slashes.
- **[Formatting and structure](references/formatting-and-structure.md)**:
  Headings, lists, tables, procedures, notices, numbers, units,
  examples, images, and cross-references.
- **[Code and UI](references/code-and-ui.md)**:
  Code in text, code samples, command-line syntax, placeholders,
  UI interaction, API reference comments, and filenames.
- **[Inclusive and global writing](references/inclusive-and-global.md)**:
  Inclusive language, writing for a global audience, and accessibility.
- **[Word choice](references/word-choice.md)**:
  High-frequency terms, Dart and Flutter names, trademarks,
  and safe example data.
- **[Strict-review word list](references/word-list.yaml)**:
  Expanded structured guidance and rationale for individual terms.
  Load it only for a strict or thorough terminology review or
  to resolve and explain a specific word-choice change.
