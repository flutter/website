---
name: publish-blog
description: Publish a new article to the Flutter blog from a Google Doc.
---

# Publish Blog Article

## Overview

Use this skill to add a new article to the Flutter blog
by extracting content from a Google Doc,
formatting it,
and placing it in the correct directory.

## Workflow

### 1. Get content and images from Google Doc

- [ ] Ask the user to provide a link to the Google Doc.
- [ ] In your browser, open the Google Doc.
- [ ] Download the document as a Web Page (.html, zipped) via
      **File > Download > Web Page**
      (or ask the user to provide the zip if download fails).
- [ ] Extract the text content from the downloaded HTML file
      and convert it to Markdown.
- [ ] Extract the images from the `images/` folder in the zip file.
- [ ] If the hero/cover image is an animated GIF,
      ask the author for a high-quality static image (WebP or PNG)
      for social media previews.
      If none is available, extract a representative frame from the GIF
      and convert it to WebP.
      Keep the social image under 5 MB.
- [ ] Create a new folder for the blog post in `sites/www/content/blog/`
      using a concise title.
- [ ] Save the Markdown content to `index.md`
      and move the images to the `images/` directory in that folder.
- [ ] In the frontmatter, set `image:` to the image intended for blog cards.
      If that image isn't suitable for social previews, such as when it's an
      animated GIF or exceeds 5 MB, set `socialImage:` to a static WebP or PNG.
      `socialImage` controls `twitter:image` and `og:image` and
      falls back to `image` when omitted.
- [ ] In the Markdown body,
      reference the intended hero image using `<DashImage>`.
      An animated GIF or static image are both ok.
- [ ] Reference other images in the Markdown file using `<DashImage>` or
      standard Markdown image tags as appropriate.

### 2. Format the markdown

- [ ] Apply semantic line breaks to any lines over 80 characters.
- [ ] Ensure there is a blank line after each heading.

### 3. Add the author

- [ ] Ask the user to provide the author's GitHub handle.
      Search in `sites/www/content/blog/authors.yaml` for the handle.
- [ ] If the author is not found, add a new author entry.
      Add the image to `sites/www/content/blog/author_images/`
      and any other metadata you can find from the user's GitHub profile.
- [ ] Update the frontmatter for the blog post with the author's handle.

### 4. Review

- [ ] Don't create a PR until the user has looked over the article.
