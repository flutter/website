# Formatting and structure in documentation

Use these rules to structure and format documentation.

## Headings and titles

- Use **sentence case**: capitalize only the first word and proper nouns.
- Make headings descriptive and specific
  so they work out of context and in navigation.
  Prefer task-based headings such as "Configure authentication"
  over vague ones such as "Configuration".
- For task-oriented headings,
  start with an imperative verb such as "Deploy the app".
  For conceptual headings,
  use a noun phrase such as "Authentication overview".
- Don't end headings with periods.
- Use the pattern appropriate to the content:
  imperative verbs for parallel task headings
  and noun phrases for parallel conceptual headings.
  Avoid starting a heading with an _-ing_ verb,
  such as _Configuring authentication_.
- Don't stack two headings with no text between them.
  Add an intro sentence.
- Don't skip heading levels.
  For example, don't go from H2 to H4.
- Don't put links in headings.
- Avoid code items and bold UI formatting in headings.
  If a code item is necessary,
  add a descriptive noun after it.

## Lists

- Use a **numbered list** for sequential steps, ranked items,
  or anything where order matters.
- Use a **bulleted list** for unordered items.
- Use a **term-and-description list** for term-and-description pairs.
  If you use Markdown,
  follow the `format-markdown` guidance for compatible syntax.
- Usually introduce a list with a complete sentence.
  Use a colon when the sentence immediately precedes the list
  and a period when other material intervenes.
  Don't use a partial sentence that the list items complete.
  You can omit the introduction when the heading provides enough context.
- Keep items **parallel**:
  use all imperative verbs, all noun phrases, or all full sentences.
- Capitalize the first word of each item.
  Use end punctuation unless an item is a single word,
  contains no verb,
  or consists entirely of code, link text, or a document title.
  If punctuation would be inconsistent,
  rewrite the items or add end punctuation to all of them.
- Give a list at least two items.
  If a single step exists, write it as a sentence, not a one-item list.
- Avoid deeply nested lists.
  Restructure or use subheadings.
- When items have multiple comparable attributes,
  use a table instead of a list.

## Tables

- Use tables for data with two or more dimensions
  that the reader compares across rows.
- Give every column a clear header in sentence case.
- Keep cell content brief and parallel.
  Don't use tables purely for visual layout.
- Introduce the table.
  If a caption helps,
  add one that describes the table.
- Don't merge cells in ways that break screen-reader order.
  Provide a header row.
- For a single list of items with one attribute each,
  use a term-and-description list instead.

## Paragraphs

- One main idea per paragraph.
  Lead with it.
- Keep paragraphs short and scannable.
  Break up walls of text.
- Don't bury prerequisites or warnings at the end of a long paragraph.
  Put them before the instructions they affect.

## Procedures

- Write steps as a numbered list using imperative verbs.
  For example, write "Click **Create**".
- When practical, include one action per step.
  Group only tightly coupled actions.
- State the location or condition before the action within a step.
  For example, "In the **Name** field, enter a name".
- For a single-step task,
  use a sentence instead of a numbered list.
- When the expected result isn't obvious,
  tell the reader what to expect.
- Put required context, such as permissions and prerequisites,
  before the procedure instead of in the middle of it.

## Notes, cautions, and warnings

- Use notices sparingly so they retain impact.
- Use a **note** for useful supplementary information.
- Use a **caution** for the risk of a minor or recoverable problem,
  such as data or time loss.
- Use a **warning** for the risk of a serious or unrecoverable problem,
  such as a security issue, data destruction, or an outage.
- Keep the notice short and state the consequence and how to avoid it.
  Don't hide essential steps inside a note.
  Put required actions in the main flow.

## Numbers

- Spell out zero through nine in ordinary prose.
  Use numerals for 10 and above.
- Use numerals regardless of size for versions and technical values,
  including measurements, percentages, dimensions, ports,
  and literal code or UI values.
  For example, write "version 3", "6 queries per second", and "port 8080".
- When consistency in a series requires it,
  use numerals for every number if one is 10 or greater.
  For example, write "3 of the 14 tests".
- Don't start a sentence with a numeral.
  Rewrite or spell it out.
  A four-digit year can start a sentence when rewriting would be awkward.
- Use commas as thousands separators in non-code prose,
  such as "1,024",
  but not in code, ports, years, or addresses.
- Spell out ordinal numbers in prose,
  such as "first", "second", and "forty-third".
  Preserve a numeral when it's part of an official name
  or a literal code or UI value.

## Dates and times

- Write dates unambiguously:
  "January 5, 2026" in prose or ISO 8601 "2026-01-05" for data.
  Never use all-numeric ambiguous forms, such as "01/05/26".
- Match the format of a documented UI, command, API, or data format.
  Otherwise, use a 12-hour clock in prose,
  such as "9 AM" or "9:30 AM",
  and a 24-hour clock in technical contexts.

## Units of measurement

- Put a non-breaking space between a number and most unit symbols,
  such as in `5&nbsp;GB` and `10&nbsp;ms`.
  Don't add a space before a percent sign, as in "20%".
- Use standard unit symbols and capitalization,
  such as GB, MB, kB, ms, and GHz.
- When a unit has no number, spell it out.
  Otherwise, use the unit symbol with a numeral.
- Distinguish decimal and binary byte units accurately,
  such as MB versus MiB and GB versus GiB.
- In a range with units,
  repeat the unit and use _to_, such as "5 MB to 10 MB".
- Don't mix unit systems without giving readers the conversions they need.

## Mathematical notation

- Define mathematical symbols the first time they appear.
- Italicize abstract mathematical variables.
  Use code font for literal Dart identifiers and expressions.
- Use the target site's supported math renderer for equations.
  Keep simple expressions in running text when they don't need one.

## Footnotes

- Avoid footnotes in developer documentation.
  Put the information in the text, a parenthetical, a note,
  or a cross-reference instead.
- If a footnote is unavoidable,
  keep it short and use the platform's supported footnote marker and placement.

## Format examples

- Label examples clearly.
  When showing right and wrong versions,
  mark them "Recommended" and "Not recommended" consistently.
- Make examples realistic and minimal: show the point without unrelated noise.
- Keep paired examples parallel
  so the only difference is the point you're illustrating.
- When an example's correctness isn't self-evident,
  explain what makes it correct.

## Images, figures, and diagrams

- Give every image an `alt` attribute.
  For an informative image,
  provide concise **alt text** that conveys its meaning and purpose.
  For a decorative image or one that only repeats nearby text,
  mark it as hidden from screen readers.
- Don't use generic alt text such as "image" or a filename.
- Don't put essential information only in an image.
  Include it in text too.
- Don't use an image for text, code, or terminal output.
  Use actual text.
- When practical,
  provide high-resolution or vector images.
  Ensure legibility.
- Introduce an image with a complete sentence.
  Use a colon if the sentence immediately precedes the image
  or a period if other material intervenes.
  You don't need an introduction for a screenshot
  that immediately follows procedural UI text.
- Crop screenshots to the relevant area.
  When possible,
  avoid embedding text that needs translation.
- Don't include personal or sensitive information in screenshots.
- Don't rely on color alone to convey meaning.
  Ensure sufficient contrast.

## Italics for terms and emphasis

- When introducing or defining a term as a term,
  use italics.
  For example, write
  "A _closure_ is a function that captures its environment".
- Use italics sparingly for emphasis.
  Usually, rephrasing is clearer.
  Don't use bold or underlining for emphasis.
- Don't use italics for code, UI labels, or filenames.
  Use code font for code and filenames and bold for UI labels.

## Cross-references and link targets

- Use **descriptive link text** that names the destination.
  Never use "click here", "here", "this", "this page",
  or "read more" as the link text.
- Don't use a bare URL as link text in prose.
  Link a meaningful phrase.
- Introduce links naturally without using "see":
  "For more information about quotas,
  consult [Quotas and limits][]",
  or "To learn about quotas, visit [Quotas and limits][]".
  Use "about", not "on".
- Avoid using "see", "see the", or "for more information, see"
  when directing readers to links or cross-references.
  Prefer action-oriented or descriptive phrasing such as
  "refer to", "consult", or "visit".
- Don't say "the link below".
  Link the actual thing.
- Write headings that produce stable, readable anchor links:
  keep them descriptive and avoid duplicating heading text within a page.
- People using screen readers can encounter linked text out of context.
  Make sure the text still makes sense on its own.

[Quotas and limits]: https://example.com/quotas
