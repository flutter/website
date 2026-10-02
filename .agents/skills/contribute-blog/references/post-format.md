# Flutter blog post format

Use this reference for new posts, imports, metadata or media changes,
structural edits, and full reviews in `sites/www/content/blog/`.

## Location and publication

Each post uses this structure:

```text
- sites/www/content/blog/<stable-kebab-case-slug>/
  - index.md
  - images/
```

The directory name becomes the public URL path, like `/blog/<slug>`.
Don't rename a published post unless a URL change is requested
and redirects are handled.
Keep source documents, export archives, notes, and scratch files elsewhere.

A future `publishDate` doesn't hide a post,
and there is no `draft` frontmatter field.

## Post frontmatter

A typical post begins with the following frontmatter:

```yaml
---
title: "A concise post title"
description: >-
  A short, plain-text summary that stands on its own.
publishDate: YYYY-MM-DD
author: author-id
coverImage:
  alt: "Descriptive alt text, or empty for decorative."
  caption: "Optional caption."
  url: images/hero.webp
category: deep-dive
layout: blog
---
```

`title` (required)
: Supplies the page H1, card title, social title, and feed title.
  Don't repeat it as an `# H1` heading in the Markdown body.

`description` (required)
: Plain text used in the subtitle, cards, metadata, and feed.
  Avoid Markdown formatting or links here.

`publishDate` (required)
: The publication date in `YYYY-MM-DD` format.
  Preserve it when editing an existing post unless a date change is requested.

`author` (required)
: One or more author IDs from `sites/www/content/blog/authors.yaml`.
  To set up authors, follow [Manage blog authors](authors.md).

`category` (required)
: A valid category slug from `sites/www/content/blog/data.yaml`.
  Current categories include `release`, `news`, `deep-dive`, and `case-study`.

`layout` (required)
: Must be `blog`.

`coverImage` (optional)
: Post-relative hero/cover image that supplies the `/blog` card thumbnail,
  social preview, and optional in-body rendering before the first paragraph.
  Contains `url` (path to image), `alt` (alternative text; empty string `""`
  for decorative images; required when `display` is `true`), optional `caption`,
  and optional `display` (boolean; defaults to `true`).
  Set `display: false` if you want the card thumbnail and social preview
  without automatically rendering the image at the top of the post (for
  example, if you prefer to place the image elsewhere in the body with
  `<DashImage>` or omit in-body display).

`socialImage` (optional)
: Static image override (WebP or PNG under 5 MB) for social sharing metadata
  when `coverImage` is animated or exceeds 5 MB.

## Card and social images

`coverImage` is optional but recommended when suitable artwork exists.
It supplies the default card image and social preview (unless overridden
by `socialImage`), and automatically renders at the top of the post body
when `display` is `true` (the default).
If `coverImage` is omitted, no image is rendered at the top of the post body,
and the `/blog` card displays without a thumbnail.

To supply a card and social preview image without rendering it at the top
of the post, set `display: false`:

```yaml
coverImage:
  url: images/workflow.webp
  display: false
```

You can then embed the image elsewhere in the article body using `<DashImage>`.

Use post-local paths such as `images/hero.webp`.
Prefer optimized WebP for new static raster artwork when quality permits.
Don't upscale sources or commit unused variants.

Set `socialImage` when `coverImage` is animated (such as a GIF),
larger than 5 MB, or otherwise unsuitable for social previews:

```yaml
coverImage:
  alt: "Animated hero diagram"
  url: images/animated-hero.gif
socialImage: images/social-cover.webp
```

Use a static WebP or PNG under 5 MB for `socialImage`.

## Media in the body

### Images

Hero images at the top of a post are defined using `coverImage` in frontmatter.
For images within the article body, use `<DashImage>`:

```markdown
<DashImage figure src="images/workflow.webp" alt="Diagram showing requests moving from the Flutter app through the API to the cache" caption="Requests move through the API before reaching the cache." />
```

Keep the entire component tag on one source line.

The common `<DashImage>` attributes are:

- `src` (required):
  Post-local path to the image file (for example, `images/diagram.webp`).
- `alt` (required for new images):
  Alternative text for accessibility.
- `caption` (optional):
  Visible figure caption text.
- `figure` (optional):
  Wraps the image and caption in a `<figure>` element.
  Use it when setting `caption`.

Make the accessibility choice explicit:

- Give informative images concise, purposeful alt text.
- Use `alt=""` for decorative images or images that only repeat nearby text.
- Explain a chart's key findings in surrounding prose or its caption.
  Don't rely on pixels alone.
- Ensure animation isn't the only way to perceive important information.

### Videos

Embed YouTube videos using `<YouTubeEmbed>` on a single line:

```markdown
<YouTubeEmbed id="VIDEO_ID" title="Descriptive video title" fullwidth />
```

## Body content and formatting

### Structure

- Start the body with an introduction, hero image, or `## H2` heading.
  The layout renders the title, description, and author metadata automatically.
- Use semantic headings without skipping levels.

### Markdown source formatting

- Preserve valid source formatting and the author's stylistic choices.
- Use semantic line breaks when drafting new prose,
  but don't reflow imported or existing text only to meet a line-length rule.
- Keep each Markdown link, inline code span, table row,
  or component tag on a single line.

### Links

- Use descriptive link text.
- Verify all destination URLs.
- Use root-relative paths for internal blog links,
  such as `/blog/<slug>`.
- Use absolute URLs for docs pages,
  such as `https://docs.flutter.dev/...`.

### Code, tables, and custom markup

- Use fenced code blocks with accurate language identifiers.
- Verify commands, API names, and other technical details.
- Make intentional omissions in code samples clear.
- Don't use tables only for visual layout.
  Give them a header row and sensible reading order.
- Only use raw HTML or site components when
  Markdown can't express the required behavior.
