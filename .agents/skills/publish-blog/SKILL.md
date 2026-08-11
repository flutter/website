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
- [ ] Create a new folder for the blog post in `sites/www/content/blog/`
      using a concise title.
- [ ] Save the markdown content to `index.md`
      and move the images to the `images/` directory in that folder.
- [ ] Reference the images in the markdown file
      using `<DashImage>` or standard markdown image tags as appropriate.

### 2. Format the markdown

- [ ] Apply semantic line breaks to any lines over 80 characters.
- [ ] Ensure there is a blank line after each heading.

### 3. Add the author

- [ ] Ask the user to provide the author's GitHub handle.
      Search in `sites/www/content/blog/authors.yaml` for the handle.
- [ ] If the author is not found, add a new author entry.
      Add the image to `sites/www/content/blog/authors_images/`
      and any other metadata you can find from the user's GitHub profile.
- [ ] Update the frontmatter for the blog post with the author's handle.

### 4. Review

- [ ] Don't create a PR until the user has looked over the article.
