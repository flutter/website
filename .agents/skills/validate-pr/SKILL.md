---
name: validate-pr
description: >-
  Stages the Flutter site locally. This includes checking for broken links,
  verifying excerpts, updating formatting, and serving the dev site.
---

Do the following to validate the site

## 1. Sync code excerpts

Ensure that any changed code excerpts are properly run and synced to the
Markdown files:

```bash
dart run dash_site refresh-excerpts
```

## 2. Update formatting

Update the formatting of the site examples and tools to ensure
they follow the official Dart format:

```bash
dart run dash_site format-dart
```

## 3. Check for broken links

Run the following command to check for any unlinked or broken
Markdown link references in the site output:

```bash
dart run dash_site check-link-references
```

If any broken links are found, try to patch them or alert the user.

