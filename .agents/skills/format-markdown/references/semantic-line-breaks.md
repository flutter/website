# Semantic line breaks

Use semantic line breaks to make Markdown easier to scan and edit.
Markdown joins consecutive lines in a paragraph with spaces,
so these source breaks don't change the rendered paragraph.

## Write with semantic line breaks

For new prose and any sentence you revise:

1.  **End every sentence with a line break.**
    Don't start the next sentence on the same line.

1.  **Split long or complex sentences at natural boundaries.**
    Prefer a break:

    - After an independent clause,
      often at a comma, semicolon, or colon.
    - After a dependent clause or long phrase
      when the break makes the sentence easier to scan.

1.  **Keep lines to 80 characters or fewer when a clean break exists.**
    The limit is a maximum, not a target.
    If a line has no clean break,
    let it exceed the limit.
    Common exceptions include long headings, URLs, link definitions,
    code spans, table rows, image paths, and raw HTML tags.

If you're unsure where to break a sentence,
use the fewest breaks that reveal its structure.

## Preserve the rendered output

A semantic line break must remain invisible when Markdown renders.

- Don't split a construct that Markdown requires on one line,
  such as a heading, code span, link, table row,
  or single-line front matter value.
- Don't break inside a hyphenated word
  or between an em dash and the adjacent text.
- Don't add trailing spaces or a backslash to force a rendered line break.
  To separate ideas in the rendered output,
  use separate paragraphs or the platform's explicit syntax.
- Wrap code according to the conventions of its language,
  not these prose rules.

## Examples

```text
If the build fails,
check the logs in the `build/` directory.
If the error reports a missing dependency,
run `flutter pub get`,
and then retry the build.
```

The breaks separate each condition and instruction
without changing the rendered paragraph.

Semantic line breaks also apply to prose in list items.
Indent continuation lines under the item's text:

```markdown
- If the platform uses YAML front matter,
  place it at the start of the file,
  fenced by `---` lines.
```

## Update only text you touch

Don't reflow untouched prose only to add semantic line breaks.
For new text, apply these rules as you write.
When you revise a sentence,
rewrap that sentence and leave the surrounding sentences unchanged.
