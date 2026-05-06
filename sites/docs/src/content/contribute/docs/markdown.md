---
title: Authoring Markdown
shortTitle: Markdown
description: >-
  Learn about the Markdown syntaxes the Dart and Flutter documentation sites
  support and their guidelines for using them.
sitemap: false
noindex: true
showBreadcrumbs: true
---

:::warning
This document is a work in progress.
:::

Our sites support writing content in [Markdown][],
with some additions from [GitHub Flavored Markdown][]
as well as other custom syntaxes.

This page outlines the Markdown syntax we support
as well as our style guidelines for authoring Markdown.

[Markdown]: https://commonmark.org/
[GitHub Flavored Markdown]: https://github.github.com/gfm/

## General guidelines

Prefer using Markdown syntax over custom HTML and components.
Raw Markdown is easier to maintain, easier for tools to understand,
and easier to migrate in the future if necessary.

## Code blocks

Don't use Markdown's indented code blocks,
only use fenced code blocks using backticks
and always specify a language. For example:

````markdown
```dart
void main() {
  print('Hello world!');
}
```
````

To learn more about customizing code blocks,
check out the dedicated documentation on [Code blocks][].

[Code blocks]: /contribute/docs/code-blocks
