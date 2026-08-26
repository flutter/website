# Import from Google Docs

Use this reference to convert an authored Google Doc into a Flutter blog post
without turning the import into an unsolicited rewrite.

## Get the source

First, try to download the source yourself.
Open the document in an authenticated browser and choose
**File > Download > Web Page (.html, zipped)**.
An authenticated Google Docs or Drive connector is also suitable
if it can produce the complete HTML export and original media.

If you can't access the document, the download fails,
or the export is incomplete,
ask the user to download and provide the HTML zip.
Don't reconstruct content that the available source omits.

Import the document body as exported.
Ignore comment threads and suggestion metadata,
don't reproduce or act on them.
Extract exports into a temporary directory and
don't commit the source archive or intermediate conversion files.

## Convert content, not export debris

Preserve the document's structure and meaning,
including headings, prose, lists, tables, emphasis, links,
code, images, and captions.
Convert ordinary content to clean Markdown,
using site components when they provide necessary behavior.

Strip Google Docs export artifacts:

- **Redirects**:
  Replace Google redirect and tracking URLs with their direct destinations.
- **Styling spans & non-breaking spaces**:
  Remove non-relevant markup and structure, such as
  inline CSS, font declarations, classes, empty anchors, and wrapping spans.
- Replace `&nbsp;` with standard whitespace.
- **Code snippets**:
  Convert exported code to fenced Markdown blocks
  with appropriate language identifiers, such as `dart` or `bash`.
  Google Docs might represent code as `<p>` tags with
  `&nbsp;` indentation or as single-cell tables.
- **Titles**:
  Don't replicate the document title as an `# H1` heading in the Markdown body.
  The `title` in the post's frontmatter supplies the page H1.
- **Footnotes**:
  Preserve footnote content,
  but omit generated Google Docs anchor navigation links.
- **Videos**: Convert standalone YouTube links into `<YouTubeEmbed>` components.

Keep the author's person, tone, pacing, spelling variety,
heading style, and rhetorical choices unless editing was requested.
Correct conversion errors,
but surface optional prose changes separately.

## Resolve authors

Identify the ordered authors from an explicit byline or user context,
not from document ownership or editor metadata.

To resolve their IDs and configure the post's frontmatter,
follow the steps in [Manage blog authors](authors.md).
If the source lacks enough information to identify or resolve an author,
ask the user for their GitHub or other profile URL.

## Reconcile images

Map each exported image to
its source position, caption, and purpose
before renaming or moving it:

- Place images in the post's `images/` directory
  with concise, descriptive names.
- Keep the highest-quality intended source.
  Convert static raster images to WebP when quality and clarity are preserved.
- If the image is a JPEG, prefer a `.jpg` extension over `.jpeg`.
- Preserve intentional animation
  and provide a static `socialImage` when needed.
- Follow the alt text and `<DashImage>` guidance in
  [Flutter blog post format](post-format.md).
- If an image's purpose or placement is ambiguous,
  ask for guidance rather than guessing.

## Check fidelity

Compare the converted post with the source section by section.
Confirm that no prose, list item, code block, table row, image, caption,
footnote, or intended link is missing or misplaced.
Check heading hierarchy, link destinations, image-caption pairings,
and meaningful emphasis.
Report any placeholder or editorial hold in the document body
that prevents the post from being ready.

Finish with the format and accessibility checks in
[Flutter blog post format](post-format.md)
and the validation workflow in the parent skill.
