---
title: Sidenav
description: >-
  Learn about adding to and configuring the sidenav of the
  Dart and Flutter documentation site.
sitemap: false
noindex: true
showBreadcrumbs: true
---

:::warning
This document is a work in progress.
:::

The sidenav presents the overall information architecture for the site
and provides developers access to documentation by topic.

The contents of the sidenav are configured in
[YAML][] files in the `/src/data/sidenav/` directory.
Each file in that directory defines a named sidenav,
with the filename (without extension) serving as the key.
Pages select which sidenav to display through the `sidenav` front matter field.
If no sidenav is specified, the `default` sidenav is used.

[YAML]: https://yaml.org/

## Add a page

## Remove a page

## Hide pages unless open

## Icons for top-level sections

Top-level section entries support an optional `icon` field to render a Material Symbols icon to the left of the section title. Use the icon's identifier (for example, `flag`, `download`, or `build`). This icon appears only for the first-level items.

Icons use the site's Material Symbols font. Choose identifiers from Google's [Material Symbols catalog](https://fonts.google.com/icons).

## Infrastructure
