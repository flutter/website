# Gemini Workspace Configuration

This file contains project-specific information to help Gemini assist with
development tasks.

## Project Overview

This is a Flutter web project for the Flutter website.

## Development Workflow

- When any of the scripts in the `tool/` directory are modified, this file
  (`GEMINI.md`) should be reviewed and updated to reflect those changes.

## Conventions

- **Line Length:** All Markdown files (`.md`) should be formatted to have a
  line length of 80 characters or less.

## Tools

### `flutter_site`

-   **Location:** `tool/flutter_site/bin/flutter_site.dart`
-   **Purpose:** A command-line tool for managing the Flutter website.
-   **Usage:** `dart tool/flutter_site/bin/flutter_site.dart <command>`
-   **Commands:**
    -   `analyze-dart`: Run analysis on the site infra and examples.
        -   **Details:** Analyzes `tool/flutter_site` and `examples`
            directories using `flutter analyze`. Use `--verbose` for more logs.
    -   `build`: Build the site.
        -   **Details:** Uses Eleventy to build the site. Use `--release` for a
            production build.
    -   `check-all`: Run all code related tests and validation.
        -   **Details:** A meta-command that runs `format-dart --check`,
            `analyze-dart`, `test-dart`, and
            `refresh-excerpts --fail-on-update --dry-run`.
    -   `check-links`: Verify all links between pages on the site work.
        -   **Details:**
            -   Starts a Firebase emulator on port 5500 to check links.
            -   Use the `--external` or `-e` flag to check external links.
            -   Uses a skip list at `tool/config/linkcheck-skip-list.txt` to
                ignore specific URLs.
    -   `check-link-references`: Verify there are no unlinked/broken Markdown
        link references in the generated site output.
        -   **Details:** Scans the generated `_site` directory for broken
            Markdown references. The site must be built first.
    -   `format-dart`: Format or check formatting of the site examples and
        tools.
        -   **Details:** Uses `dart format` on the `tool` and `examples`
            directories. Use `--check` to validate without changing files.
    -   `inline-excerpts`: Extracts code snippets from Markdown files and creates
        example files.
        -   **Details:**
            -   Code snippets are identified by ` ```dart magic id=<unique-id>`.
            -   The `id` is used to create a unique filename for the example.
            -   Filenames are created by taking the original filename, replacing
                hyphens with underscores, and appending the sanitized `id`. For
                example, `my-doc.md` with `id=my-snippet` becomes
                `examples/my_doc_my_snippet.dart`.
    -   `refresh-excerpts`: Updates all code excerpts on the site.
        -   **Details:** Updates code excerpts in `src/content` from sources in
            the `examples` directory. Use `--dry-run` to check for updates and
            `--fail-on-update` to error if updates are needed.
    -   `serve`: Serve the site locally.
        -   **Details:** Runs a local development server using Eleventy on port
            4000 by default. Use the `PORT` environment variable to change it.
    -   `test-dart`: Run tests on the site infra and examples.
        -   **Details:** Runs `flutter test` in the `tool/flutter_site` and
            `examples` directories.
    -   `verify-firebase-json`: Verify the firebase.json file is valid and
        meets the site standards.
        -   **Details:** Checks for duplicate and malformed redirects in the
            `firebase.json` file.
