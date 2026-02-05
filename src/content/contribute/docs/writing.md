---
title: Writing for the docs sites
short-tile: Writing
description: >-
  Learn about the writing style guide and processes followed when writing
  for the Dart and Flutter documentation sites.
sitemap: false
noindex: true
showBreadcrumbs: true
---

:::warning
This document is a work in progress.
:::

## Writing guidelines

When writing for the documentation sites,
follow the [Google developer documentation style guide][],
except in the cases where the [Dash docs guidelines][] conflict with it.

[Google developer documentation style guide]: https://developers.google.com/style
[Dash docs guidelines]: #dash-docs-styles

### Dash docs styles

:::warning
This section is a work in progress.
It will be added to over time.
:::

## Semantic breaks

To make PR review, diff resolution, and history tracking easier,
use [semantic breaks][] when writing Markdown.
Reference the [full specification][sembr-spec] for helps,
but roughly follow these guidelines:

- Keep each line 80 characters or fewer.
- Break lines at sentences and, unless the sentence is very short,
  on phrases within sentences.
- When it's necessary to split a sentence across lines,
  try to pick a break that makes it clear that
  the line continues on the next line.
  That way future editors and reviewers are more likely to
  notice that the edit might affect another line.

Incorporating semantic breaks in your writing might feel tedious at first,
but quickly proves helpful and becomes natural.
Don't worry about getting the breaks perfect or completely consistent,
any effort towards their semantic nature is extremely helpful.

For some more discussion about the origin of this technique,
also check out Brandon Rhode's [Semantic Linefeeds][] post.

[semantic breaks]: https://sembr.org/
[sembr-spec]: https://sembr.org/#:~:text=seen%20by%20readers.-,Semantic%20Line%20Breaks%20Specification,-(SemBr)
[Semantic Linefeeds]: https://rhodesmill.org/brandon/2012/one-sentence-per-line/

## Links

### Write link text

Use descriptive link text that follows the
Google guidelines on [Cross-references and linking][].

[Cross-references and linking]: https://developers.google.com/style/cross-references

### Configure link destinations

For easier editing, shorter lines, and reduced duplication,
prefer using Markdown link references instead of inline links.

Place the link definitions at the end of the
current section where they're used, before the next header.

If a link definition is used multiple times across a page,
you can place it at the bottom of the document.

### Open the link in a new tab

If you want a link to open in a new tab by default,
add the `target="_blank"` and `rel="noopener"` attributes.

For Markdown links:

```md
[Link text][link-ref]{: target="_blank" rel="noopener"}
```

For HTML links:

```html
<a href="#link-ref" target="_blank" rel="noopener">Link text</a>
```
