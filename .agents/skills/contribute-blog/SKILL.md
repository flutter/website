---
name: contribute-blog
description: >-
  Create, import, edit, or review posts for the
  official Flutter blog at flutter.dev/blog,
  including metadata, media, authors, and publication checks.
---

# Contribute to the Flutter blog

## Editorial approach

Preserve the author's voice, intent, and requested scope.
First person, contractions, anecdotes, humor, enthusiasm,
and future-facing announcements can all be appropriate.
Don't rewrite them merely to match documentation conventions.

Apply `write-technical-docs` and `format-markdown` selectively for clarity,
accuracy, accessibility, links, code formatting, and sound structure.
Their documentation-specific preferences aren't blanket blog requirements:
semantic line breaks and an 80-character limit aren't required,
especially when importing or lightly editing an existing post.

Fix or flag substantive issues with source fidelity,
technical accuracy, accessibility, metadata, or rendering.
Treat preference-only rewrites as suggestions
unless copyediting was requested.

## Read relevant reference material

- For a new post, import, metadata or media change,
  structural edit, or full review, read
  [Flutter blog post format](references/post-format.md).
- For a Google Doc import, also read
  [Import from Google Docs](references/google-doc-import.md).
- To add or update an author or resolve an unknown author ID, read
  [Manage blog authors](references/authors.md).

A small prose-only correction might need no reference.
Consult `sites/www/content/blog/data.yaml`,
`sites/www/content/blog/authors.yaml`, comparable recent posts,
or implementation source when a convention is unclear.

## Code and quality checks

- If changing or writing Dart or Flutter samples,
  apply `write-dart` and `write-flutter` as relevant.
  Validate complete examples when practical and
  label intentional omissions or pseudocode clearly.
- Before calling a post ready,
  search the changed content for unresolved markers and placeholders,
  such as `TODO`, `TBD`, or placeholder notes.
  Report intentional markers or blockers instead of silently removing them.

## Validate proportionally

For a new post or a change to metadata or content,
run the build and link-reference checks:

```bash
dart run dash_site --site=www build
dart run dash_site --site=www check-link-references
```

When layout, media, metadata, or content significantly changes,
consider previewing the site locally:

```bash
dart run dash_site --site=www serve
```

For a prose-only edit that doesn't change links,
direct inspection of the content can be enough.
