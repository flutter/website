# AGENTS.md

This file provides important project context and guidance to
agentic coding and writing tools when working with them on
content and code in this repository.

## Project overview

This repository contains the source code and content for
the Flutter framework's documentation website.
It is hosted at `docs.flutter.dev` and shouldn't be confused with
the marketing site at `flutter.dev` or the API docs at `api.flutter.dev`.

The website is statically built and implemented with
Dart and the [Jaspr](https://jaspr.site) web framework.
For loading content, data, and some of its assets,
it uses [Jaspr Content](https://docs.jaspr.site/content).

### Directory structure

- `src/content/`:
  Markdown-based documentation pages.
- `src/data/`:
  YAML and JSON data files used by the site, such as
  for the sidenav, glossary, and various indices.
- `src/_includes/`:
  Liquid partial files written in Markdown.
- `examples/`:
  A pub workspace containing Dart and Flutter code examples,
  referenced by code excerpts in the Markdown files.
- `site/`:
  The site implementation written in Dart using Jaspr and Jaspr Content.
- `tool/dash_site/`:
  CLI tool for site development and maintenance.

## Common commands

While working on the site,
you might need to run these commands:

```bash
# Install or update Dart dependencies:
dart pub get

# Serve a dev server of the site locally:
dart run dash_site serve

# Build a production version of the site:
dart run dash_site build

# Sync code excerpts to Markdown files:
dart run dash_site refresh-excerpts

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
