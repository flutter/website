---
title: Contribute to the docs
shortTitle: Docs
description: >-
  Learn about contributing to the Dart and Flutter documentation sites.
sitemap: false
noindex: true
showBreadcrumbs: true
---

:::warning
This document is a work in progress.
:::

## Contribution guides

- [Writing](/contribute/docs/writing)
- [Markdown](/contribute/docs/markdown)
- [Frontmatter](/contribute/docs/frontmatter)
- [Code blocks](/contribute/docs/code-blocks)
- [Code excerpts](/contribute/docs/excerpts)
- [Components](/contribute/docs/components)
- [Sidenav](/contribute/docs/sidenav)
- [Releases](/contribute/docs/releases)
- [Command-line tool](/contribute/docs/cli)

## Repository layout

- `.github/`

  Configuration for GitHub [actions][gh-actions],
  issue and PR [templates][gh-templates], and [dependabot][].
- `cloud_build/`

  Configuration for Google [Cloud Build][] that is used for staging
  and deploying the site.
- `diagrams/`

  Source files for diagrams used on the site.
- `examples/`

  The source files for [code excerpts][] used in doc code blocks.
- `src/`
  - `_11ty/`

    Custom extensions for [11ty][], [Liquid][], and Markdown.
    - `plugins/`
    - `syntax/`

      [Shiki][] themes for syntax highlighting.
    - `filters.ts`
    - `shortcodes.ts`
  - `_data/`

    YAML and JSON files used to add data used across site templates.
  - `_includes/`

    Partial files used by liquid [render and include][] statements.
  - `_layouts/`

    Layout templates used by the pages on the site.
  - `_sass/`

    Styles for the generated documentation, written with [sass][].
  - `content/`

    The root directory for the content of the site.
    - `assets/`

      The directory for assets, including images, used by the site.
    - `...`

      The other directories hosting the site content.
- `tool/`
  - `dash_site/`

    The implementation directories for the `dash_site` tooling.
- `dash_site`

  The entrypoint script for the site's CLI tool.
- `eleventy.config.ts`

  The entrypoint for the site's [11ty][] static-site generation setup.
- `firebase.json`

  Configuration for [Firebase Hosting][] that is used for
  the staged and deployed sites.
- `package.json`

  Configuration of used [npm][] dependencies.

[gh-actions]: https://docs.github.com/actions
[gh-templates]: https://docs.github.com/communities/using-templates-to-encourage-useful-issues-and-pull-requests
[dependabot]: https://docs.github.com/en/code-security/getting-started/dependabot-quickstart-guide

[Cloud Build]: https://cloud.google.com/build
[code excerpts]: /contribute/docs/excerpts

[Shiki]: https://shiki.style/
[render and include]: https://liquidjs.com/tags/render.html
[sass]: https://sass-lang.com/

[Liquid]: https://liquidjs.com/
[11ty]: https://www.11ty.dev/
[Firebase Hosting]: https://firebase.google.com/docs/hosting
[npm]: https://www.npmjs.com/
