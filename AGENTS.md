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
    - `sites/docs/firebase.json`:
      Firebase Hosting configuration for docs.flutter.dev.
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

# Convert PNG and JPEG images,
# specified relative to the repository root, to WebP.
# This doesn't update references to them, so do that afterward:
dart run dash_site optimize-images <image paths...>

# Run local visual regression diffing against main (or another base branch):
dart run dash_site --site=docs visual-diff
dart run dash_site --site=www visual-diff

# Learn what other commands are available:
dart run dash_site --help
```

### Visual regression testing

To run local visual regression diffing between your current changes
and `main`:

```bash
dart run dash_site --site=docs visual-diff
dart run dash_site --site=www visual-diff
```

By default, the command uses Chrome to capture full-page snapshots
and opens an interactive visual diff review server in your browser.

#### Renderers

- **Chrome** (default):
  Uses your installed Google Chrome or Chromium.
  Requires no extra setup if Chrome is installed.
- **Obscura**:
  A lightweight headless browser backend that renders via CPU software
  rasterization.
  To use Obscura, pass `--renderer=obscura`:

  ```bash
  dart run dash_site --site=docs visual-diff --renderer=obscura
  ```

  To install Obscura on macOS:

  ```bash
  brew install obscura
  ```

  On Linux, download pre-built release binaries from
  <https://github.com/h4ckf0r0day/obscura/releases>
  and place both `obscura` and `obscura-worker` on your `PATH`.
  If Obscura is installed in a custom location,
  pass `--renderer-path=<path>`.

#### Useful options

- `--current`: Snapshot the current working tree as baseline
  instead of checking out git `main`.
- `--update-baseline`: Update baseline snapshots from current results.
- `--route=<path>`: Snapshot specific route(s),
  for example `--route=/get-started`.
- `--all-routes`: Bypass pruning in `visual_diff.yaml`
  and snapshot every route.

## Content guidelines

### Writing style

Writing should be consistent across the site and follow the
[Google developer documentation style guide](https://developers.google.com/style/).

#### Line breaks

In Markdown files, use [semantic line breaks](https://sembr.org/) and
try to keep each line under 80 characters long.

#### Cross-references and links

Avoid using "see", "see the", or "for more information, see" to introduce
links or references. Prefer action-oriented or descriptive phrasings such as
"refer to", "consult", or "visit" (for example, "To learn about X, visit Y").

## Coding guidelines

All Dart code should follow [Effective Dart](https://dart.dev/effective-dart),
unless purposefully not for explanatory or pedagogical purposes.
