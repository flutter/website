# AGENTS.md

This file provides important project context and guidance to
agentic coding and writing tools when working with them on
content and code in this repository.

## Project overview

This repository contains the source code and content for
the Flutter framework's documentation and marketing websites:

- `docs.flutter.dev`:
  The Flutter framework's documentation website.
- `flutter.dev`:
  Flutter's homepage and marketing website.

The API docs at `api.flutter.dev` are embedded in the Flutter SDK source
and are maintained in the <https://github.com/flutter/flutter> repository.

The websites are statically built and implemented with
Dart and the [Jaspr](https://jaspr.site) web framework.
For loading content, data, and some assets,
they use [Jaspr Content](https://docs.jaspr.site/content).

### Directory structure

- `sites/`:
  Top-level directory containing each website maintained in this repository.
  - `sites/docs/`:
    The implementation of docs.flutter.dev,
    written in Dart using Jaspr and Jaspr Content.
    - `sites/docs/src/content/`:
      Markdown-based documentation pages.
    - `sites/docs/src/data/`:
      YAML and JSON data files used by the site, such as
      for the sidenav, glossary, and various indices.
    - `sites/docs/src/_includes/`:
      Liquid partial files written in Markdown.
  - `sites/www/`:
    The implementation of flutter.dev,
    written in Dart using Jaspr and Jaspr Content.
    - `sites/www/content/`:
      Markdown-based marketing pages and structured content.
    - `sites/www/lib/`:
      Dart source code for the site.
    - `sites/www/firebase.json`:
      Firebase Hosting configuration for flutter.dev.
- `examples/`:
  A pub workspace containing Dart and Flutter code examples,
  referenced by code excerpts in the docs Markdown files.
- `tool/dash_site/`:
  CLI tool for site development and maintenance.

## Common commands

While working on these sites,
you might need to run these commands:

```bash
# Install or update Dart dependencies:
dart pub get

# Serve a dev server of the site locally:
dart run dash_site --site=docs serve
dart run dash_site --site=www serve

# Build a production version of the site:
dart run dash_site --site=docs build
dart run dash_site --site=www build

# Sync docs code excerpts to Markdown files:
dart run dash_site --site=docs refresh-excerpts

# Learn what other commands are available:
dart run dash_site --help
```

## Content guidelines

### Writing style

Writing should be consistent across the site and follow the
[Google developer documentation style guide](https://developers.google.com/style/).

#### Line breaks

In Markdown files, use [semantic line breaks](https://sembr.org/) and
try to keep each line under 80 characters long.

## Coding guidelines

All Dart code should follow [Effective Dart](https://dart.dev/effective-dart),
unless purposefully not for explanatory or pedagogical purposes.
