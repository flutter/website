# Manage blog authors

Use this reference when adding or updating an author,
or when a post's author ID doesn't resolve.

Authors are defined in `sites/www/content/blog/authors.yaml`, and
their local profile images live in `sites/www/content/blog/author_images/`.

The top-level key in `authors.yaml` is a stable content ID,
not necessarily the author's current social handle.

## Add or resolve an author

Before adding a record,
search `authors.yaml` by ID, display name, and profile URL.
Use verified or author-provided details.
Don't invent a name, profile, or image.
For a new ID, choose a recognizable lowercase handle or concise stable slug,
then insert the record alphabetically by ID.

`name` is required while `image`, `imageUrl`, and `link` are optional:

```yaml
author-id:
  name: "Author Display Name"
  image: "author-id.webp"
  link: "https://github.com/author-id"
```

- `image` names a local image file in `author_images/`.
- `imageUrl` accepts an external URL to use as a fallback to `image`.
  Prefer a local `image` over setting `imageUrl`. Don't set both.
- `link` is the destination linked from the byline. Prefer their GitHub profile.

## Author images

Name a local image after the exact author ID and
use its real lowercase `.jpg` or `.webp` extension,
such as `author-id.webp`.
Optimize it for a small square display and a centered circular crop.
Use an author-supplied or appropriately reusable image.

## Update an author

Keep the existing ID when an author's name, handle, link, or image changes.
If the ID must change, update every occurrence in post frontmatter.

When replacing an image with a different filename or extension,
search for references to the old file before removing it.
Don't remove an apparently unused author without checking all posts.

## Configure the authors of a post

In a post's `index.md` frontmatter:

For a single author, use a YAML scalar:

```yaml
author: author-id
```

For multiple authors, use an ordered list:

```yaml
author:
  - first-author
  - second-author
```

List order controls the displayed byline.
