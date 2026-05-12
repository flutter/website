# AGENTS.md

This file provides guidance to agentic coding tools when
working with or understanding code in this repository.

## Project overview

This repository contains the source code for the Flutter website.
Flutter is an open-source framework for building beautiful,
natively compiled, multi-platform applications from a single codebase.

It is hosted at [`flutter.dev`](https://flutter.dev) and shouldn't be confused
with the docs website (`docs.flutter.dev`) or the API docs (`api.flutter.dev`).
This website is sometimes called the "Flutter marketing website" as
its primary focus is providing information to
potential Flutter developers, businesses, and partners.

The website is statically built and implemented with
the Dart programming language and the [Jaspr](https://jaspr.site) framework.
It also uses [Jaspr Content](https://docs.jaspr.site/content) for
loading data and content as well as handling assets.

Content lives in Markdown and YAML files in the `content/` directory,
while the supporting Dart code lives in the `lib/` directory.

## Common commands

The following snippet contains some common commands that
you'll need to run when working on the website.

```bash
# Install dependencies, matching the constraints in pubspec.yaml.
dart pub get

# Start the Jaspr development server at http://localhost:8080/.
dart pub global run jaspr_cli:jaspr serve

# Statically build the production site, output to `build/jaspr/`.
dart pub global run jaspr_cli:jaspr build

# Run all the tests defined in the `/test` directory.
dart test

# Run code generation, which includes
# generating the serialization logic for the data models.
dart run build_runner build --delete-conflicting-outputs

# Format code in the current directory.
dart format .

# Analyze Dart sources in the current directory.
dart analyze
```

## Architecture

### Server/client split

Our Jaspr setup has a server/client architecture:

- `lib/main.server.dart` acts as the entrypoint on the server.
  It configures static site generation, including Jaspr Content,
  such as setting up routes, content loaders, layouts, and asset transformers.
- `lib/main.client.dart` acts as the entrypoint on the client.
  It automatically runs the hydration of
  interactive client-components that are annotated with `@client`.
  Additional imperative code that should be run on the client
  can be called from here as well.

### Content-to-page pipeline

1.  **Content files** (`content/`)

    YAML data files and Markdown pages with YAML frontmatter.

2.  **Loaders**

    - `FilesystemLoader` discovers and loads Markdown files.
    - `FilesystemDataLoader` loads YAML and JSON files,
      that is then accessible under `page.data`.

3.  **Data access**

    The `DataContext` extension (`lib/src/utils/data_utils.dart`) provides
    `decodeJsonObject()` and `decodeJsonList()` using dot-notation paths.
    For example,
    `context.decodeJsonList('home.latest_news', HomeNewsItem.fromJson)`
    loads `content/home/latest_news.yaml` typed as a list of `HomeNewsItem`.

4.  **Data models** (`lib/src/models/content/`)

    Data models defined using `package:dart_mappable` for YAML and JSON data.

    For detailed conventions on adding or updating data models, check out
    the `data-model` skill in `.agents/skills/data-model/SKILL.md`.

5.  **Pages** (`lib/src/pages/`)

    Jaspr components that represent the full layout and design of a page.
    Registered in `lib/main.server.dart` and
    usually used from the corresponding pages with an MDX-style syntax.

6.  **Layouts** (`lib/src/layouts/`)

    `DefaultLayout` wraps all pages with HTML document structure (head, analytics, header, footer).
    `ShowcaseStoryLayout` extends it for `/showcase/*` story pages,
    auto-applied via `ShowcaseStoryExtension`.
    Layouts implement `PageLayout` and are registered by pattern name.

7.  **Components** (`lib/src/components/`)

    When a page or layout has or needs a reusable or shareable piece of UI,
    it's usually implemented as a Jaspr component in this directory.

    - Use `StatelessComponent` for purely presentational components that
      do not manage local state.
    - Use `StatefulComponent` only when internal state management,
      such as animations, form input handling, or similar is required.
    - If the component requires browser-specific APIs or
      interactivity that can't be server-side rendered,
      annotate the component class with `@client`.

### Asset pipeline

Three asset transformers chain in `main.server.dart`:

- `TrackingAssetTransformer` -
  Logs used assets to the `tool/used_assets.txt` file.
- `ResizingAssetTransformer` -
  Currently resizes supported images to expected widths.
- `HashingAssetTransformer` -
  Adds content hashes for cache busting.

Site styles are written in SCSS in `assets/src/css` and
built with `package:sass_builder` automatically during the build.

## Coding guidelines and best practices

### Dart-specific guidelines

When writing or editing Dart code,
follow these guidelines:

- Follow Dart and programming best practices, especially the
  official [Effective Dart](https://dart.dev/effective-dart) guidelines.
- Use `const` for variables and values where possible,
  otherwise prefer `final` over `var` for variables.
- Avoid implicit and explicit usage of `dynamic`.
  Use `Object?` instead when a top type is needed.
- Explicitly specify generic type arguments to avoid implicit `dynamic`.
- Inline comments should be useful, written in complete sentences,
  and placed before the relevant code, not as a trailing comment.
- Rather than imperatively building collections,
  prefer using collection literals and a combination of
  [collection elements](https://dart.dev/language/collections#collection-elements),
  such as if, for, spread, and null-aware elements.
- Add helpful documentation comments to public members.
  The doc comments should use the syntax supported by `dart doc` and
  follow the Effective Dart
  [guidelines for documentation](https://dart.dev/effective-dart/documentation).

### Jaspr-specific guidelines

When writing or editing Jaspr code, particularly Jaspr components,
follow these guidelines in addition to the Dart guidelines:

- Components should be immutable, `const` when possible.
  and ideally, they should be stateless as well.
  When mutable state is needed, use a `StatefulComponent`,
  and keep mutable state in its separate `State` class.
- Rather than huge `build` methods or
  private helper methods that return components,
  prefer to break down large components
  into smaller, private components.
