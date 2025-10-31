---
title: Frontmatter
description: >-
  Learn about the YAML frontmatter each document on
  the Dart and Flutter documentation sites starts with.
sitemap: false
noindex: true
showBreadcrumbs: true
---

:::warning
This document is a work in progress.
:::

Each Markdown document on the site starts with [YAML][] frontmatter.
You can edit the frontmatter to customize
the generated page and its metadata.

As a minimum, a `title` and `description` are required for each page.

```yaml
---
title: Build a Flutter app
description: >-
  Learn how to build a basic Flutter app with interactive code samples.
---
```

[YAML]: https://yaml.org/

## Access frontmatter data in templates

Layouts, templates, and source files can access values from the frontmatter
as top-level data with templating.

For example, the following frontmatter sets a `showData` variable to `value`:

```yaml
---
# ...
showDate: false
---
```

The configured value of `showDate` can be accessed in templates:

```md
Should show date: {{showDate}}
{% if showDate %}
  The current data is...
{% endif %}
```

If you add a new value to the frontmatter,
prefer using `lowerCamelCase` for the name.

## Frontmatter fields

Besides `title` and `description`,
the sites support a variety of other optional fields
to customize page generation.

### `title`

### `description`

### `shortTitle`

### `js`

### `toc`

### `layout`

### `showBreadcrumbs`

### `showBanner`

### `sitemap`
