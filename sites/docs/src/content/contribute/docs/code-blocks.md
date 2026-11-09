---
title: Code blocks
description: >-
  Learn about Markdown code blocks on the Dart and Flutter documentation sites
  and custom functionality and configurability that they support.
sitemap: false
noindex: true
showBreadcrumbs: true
---

:::warning
This document is a work in progress.
:::

## Title

## Tags

## Line numbers

## Highlight lines

## Highlight spans

## Diffing

## DartPad

To embed an example that readers can run and edit in DartPad,
use `dartpad` as the code block's language.
DartPad runs each example as a project with its own pubspec,
so the site needs to know the example's dependencies.

If a `<?code-excerpt?>` instruction syncs the code block from
an example in the `/examples` directory,
the DartPad project uses that example's pubspec.
To change the dependencies, edit the example's `pubspec.yaml` file.

Otherwise, specify the dependencies with the `dependencies` option.
Its value is a flow-style YAML map of package names to
[package descriptors][], in double quotes.
Separate each name from its descriptor with a colon and a space.
For example, a Flutter example that uses `package:provider`
might start with the following code block:

````markdown
```dartpad title="Flutter provider example" dependencies="{flutter: {sdk: flutter}, provider: ^6.1.0}"
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
```
````

A code block can't have both an excerpt instruction and
the `dependencies` option.

[package descriptors]: {{site.dart-site}}/tools/pub/dependencies#package-descriptors
