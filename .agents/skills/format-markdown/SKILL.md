---
name: format-markdown
description: >-
  Write or edit well-structured Markdown and MDX.
  Use for front matter, headings, lists, code fences, links, tables,
  other Markdown mechanics, and site-specific extensions.
  Pair with the write-technical-docs skill when changing prose.
---

# Format Markdown

Use this skill for markup mechanics and document structure.
Use the `write-technical-docs` skill alongside it for
prose, terminology, heading wording, link text, and alt text.

## Core conventions

Apply these conventions unless the target project specifies otherwise.

### Document structure

- Follow the target project's renderer and established conventions.
  When the project doesn't specify them,
  assume CommonMark with GitHub Flavored Markdown (GFM) extensions.
- Use **ATX headings** (`#`, `##`, `###`), not Setext underlines (`===`, `---`).
- Use a **single H1** (`#`) as the document title.
  Some platforms generate the H1 from front matter,
  so the body can start at `##`.
- **Don't skip heading levels** below the H1.
  For example, don't jump from `##` to `####`.
- Separate **top-level block elements** with blank lines,
  including headings, paragraphs, lists, code fences, blockquotes, and tables.
  Preserve adjacency when the target syntax requires it,
  such as within a tight list or blockquote.
- Wrap new or revised prose with **semantic line breaks**.
  Read [Semantic line breaks](references/semantic-line-breaks.md)
  before writing more than a few lines or reviewing line wrapping.
- Never leave **trailing whitespace** on a line.
  Don't use the two-trailing-spaces line break.
  Restructure the text or use the platform's explicit line-break syntax.
- End the file with a single trailing newline.

### Line breaks and line length

- Put each sentence on its own source line.
- Break a long sentence at natural clause or phrase boundaries,
  keeping lines to 80 characters or fewer when a clean break exists.
- Don't split a Markdown construct or change rendered whitespace.
- Rewrap only new or revised sentences, not untouched paragraphs.

### Headings

- Put one space after the `#` markers:
  `## Section`, not `##Section`.
- Don't use closing hashes such as `## Section ##`.
- For heading wording and capitalization,
  follow the `write-technical-docs` rules:
  use sentence case and descriptive wording with no trailing period.

### Lists

- Use a **consistent unordered marker** throughout a file.
  Use the `-` hyphen by default.
- For ordered lists, use `1.` for **every** item.
  Don't increment the numbers.
- Put **two spaces after `1.`** and indent continuation blocks
  four spaces from the list marker's indentation.
  Keep the marker at the list level's margin.
  Don't add leading spaces to create the four-space alignment.

  ````markdown
  1.  List item

      ```dart
      void main() {}
      ```
  ````
- Indent nested list items and their continuation lines
  under the parent item's text,
  so wrapped lines and sublists render correctly.
- For term-and-description pairs, use a definition list.
- Keep a blank line between a list and surrounding paragraphs.
  For list _types_ and parallelism, follow `write-technical-docs`.

### Definition lists

Put each term on one line,
then start its description with a colon and a space (`: `):

```markdown
Debug mode
: Enables assertions and debugging information.

Profile mode
: Preserves enough tracing information for performance analysis,
  while otherwise behaving similarly to release mode.
```

- Keep the initial `: ` flush left.
- Indent continuation lines and nested blocks by two spaces.
- Separate term-and-description pairs with a blank line.

### Alerts

Open an alert or aside with `:::type` and close it with `:::` on its own line:

```markdown
:::warning Back up the signing key
If you lose the signing key,
you can't publish updates to the existing app.
:::
```

- Add an optional, sentence-case title after the type.
  Otherwise, the type supplies a default title except for `secondary`.
- For information, use `note`, `flutter-note`, or `version-note`.
- For advice, use `tip` or `recommend`.
- For essential information, use `important`.
- For experimental behavior, use `experimental`.
- Use `secondary` for a neutral aside.
- To call out potential risks, use `caution` or `warning`.

### Code

- Use **fenced code blocks** that start and end with ```` ``` ````
  rather than indented blocks,
  and add a language identifier:
  ```` ```dart ````, ```` ```bash ````, or ```` ```yaml ````.
  Use ```` ```text ```` for plain output or content with no specific language.
- Use **inline code spans** with backticks for inline code.
  If the code contains a backtick, wrap it in double backticks:
  ``` ``code with ` backtick`` ```.
- Keep the language tag and indentation consistent.
  Keep fences flush with the surrounding text's indentation level
  or correctly nested inside a list item.
- For _what_ to put in code font versus bold, follow `write-technical-docs`.

### Links and images

- Use **descriptive link text** that names the destination.
  Never link bare "here", "click here", "this", or a raw URL.
  See `write-technical-docs` for the full rule.
- Follow the target project's convention for internal links.
  On documentation sites that support root-relative routes,
  use an explicit root-relative path such as `/path/to/page`
  instead of a parent-directory relative path such as `../path/to/page`.
  In repository files such as READMEs and package documentation,
  keep repository-relative links when the host requires them.
- For a link to a section on the same page,
  use a fragment-only target, such as `#section`.
  Short same-page links can use inline syntax,
  such as `[Configuration](#configuration)`.
- For other links, prefer **reference-style links**.
  Use an implicit label that reuses the text, `[How to do this][]`,
  or a named label, `[The official tutorial][tutorial]`.
- Place link definitions at the **end of the section** where they're used.
  If the document uses a link across multiple sections,
  place its definition at the **end of the document** instead.
- When you must show a raw URL,
  use an angle-bracket autolink, such as `<https://example.com>`.
- Use `![alt text](path)` syntax for images.
  For link text and alt text _content_, follow `write-technical-docs`.

### Tables

- Use pipe tables with a header row and a delimiter row (`| --- |`).
  Include leading and trailing pipes for clarity.
- When practical, keep source columns reasonably aligned.
  It aids review but isn't required for rendering.
- Use alignment colons (`:---`, `:---:`, `---:`) intentionally and consistently.
- When Markdown can't express the table,
  such as one with merged cells, use raw HTML.
  See [Markdown versus HTML](#markdown-versus-html).

### Emphasis and other inline marks

- Use double **asterisks for bold**, as in `**bold**`.
- Use single **underscores for italics**, as in `_italic_`.
  Don't mix markers.
  For example, don't use `__bold__` or `*italic*`.
- Don't use emphasis to fake a heading.
  Use a real heading.
- When you need characters literally,
  escape the characters that Markdown would otherwise parse as markup,
  such as `\*`, `` \` ``, or `\|` inside a table cell.

### Front matter

- If the platform uses YAML front matter,
  place it at the very top of the file,
  fenced by `---` lines, with no blank line before it.
- Keep keys consistent with the project's schema.
  Quote only values that need quotation marks.
- When the schema supports it,
  use the `>-` folded block scalar for a long prose value
  and wrap its source semantically.

## Markdown versus HTML

- When the platform supports Markdown,
  prefer it for readability and maintainability.
- When Markdown can't express what you need, use HTML.
  Examples include complex tables, specific accessibility attributes,
  or layout that a renderer requires.
- Confirm that the target renderer permits the required elements and attributes.
- Use semantic elements and the accessibility attributes the content requires.
  Don't use presentational markup to imitate structure.
- Keep heading levels and list semantics correct in Markdown.
  Don't simulate structure with bold text or manual numbering.
