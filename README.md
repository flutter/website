# [Flutter][]'s website

Flutter's static website, built with Jekyll.

[![Build Status](https://travis-ci.org/flutter/website.svg?branch=master)](https://travis-ci.org/flutter/website)

## Issues, bugs, and requests

We welcome contributions and feedback on our website!
Please file a request in our
[issue tracker](https://github.com/flutter/flutter/issues/new)
and we'll take a look.

## Developing

Install Jekyll and related tools by following the
[instructions](https://help.github.com/articles/using-jekyll-with-pages/)
provided by GitHub.

A tldr version follows:

1. Ensure you have [Ruby](https://www.ruby-lang.org/en/documentation/installation/) installed; you need version 2.2.2 or later:<br>
`ruby --version`

1. Ensure you have [Bundler](http://bundler.io/) installed; if not install with:<br>
`sudo gem install bundler`

1. Install all dependencies:<br>
`bundle install`

1. Create a branch.

1. Make your changes.

1. Test your changes by serving the site locally:<br>
`bundle exec jekyll serve` (or `jekyll serve -w --force_polling`)

1. Prior to submitting, run link validation:<br>
`bundle exec jekyll build`<br>
`bundle exec htmlproofer _site --log-level :debug --empty-alt-ignore --url-ignore "#" --only-4xx  --url-swap "https?\:\/\/(localhost\:4000|flutter\.io):"`

## Writing for flutter.io

(Eventually, this section should be expanded to its own page.)

### Highlighting code in a code block

Do you want to highlight code inside a code block? We got that!
Don't confuse this with automatic syntax highlighting. You can accomplish that
by adding "dart" (or the relevant language identifier) after the tick-tick-tick:

<pre>
&#96;&#96;&#96;dart
void main() {
  print('Hello World');
}
&#96;&#96;&#96;
</pre>

If you want to highlight a specific bit of code, use the
`[[highlight]]highlight this text[[/highlight]]` syntax. For example:

<!-- skip -->
{% prettify dart %}
void main() {
  print([[highlight]]'Hello World'[[/highlight]]);
}
{% endprettify %}

The prettify plugin will also unindent your code.

If you want to see how this functionality was added to this site, refer to
[this commit](https://github.com/flutter/website/commit/ea15f52fe47d3a7b6313ac58d07c66f3b29fe74d).

### Including a region of a file

You can include a specific range of lines from a file:

```ruby
{% include includelines filename=PATH start=INT count=INT %}
```

`PATH` must be inside of `_include`. If you are including source code,
place that code into `_include/_code` to follow our convention.

### Adding next/previous page links

If you have a document that spans multiple pages, you can add next and previous
page links to make navigating these pages easier. It involves adding some information
to the front matter of each page, and including some HTML.


```
---
layout: tutorial
title: "Constraints"
sidebar: home_sidebar
permalink: /tutorials/layout/constraints.html
prev-page: /tutorials/layout/properties.html
prev-page-title: "Container Properties"
next-page: /tutorials/layout/create.html
next-page-title: "Create a Layout"
---

{% include prev-next-nav.html %}

{:toc}

<!-- PAGE CONTENT -->

{% include prev-next-nav.html %}
```

Omit the "prev-page" info for the first page, and the "next-page" info for the
last page.

## Code snippet validation

The code snippets in the markdown documentation are validated as part of the
build process. Anything within a '\`\`\`dart' code fence will be extracted into
its own file and checked for analysis issues. Some ways to tweak that:

- If a code snippet should not be analyzed, immediately proceed it with
  a `<!-- skip -->` comment
- To include code to be analyzed, but not displayed, add that in a comment
  immediately proceeding the snippet (e.g., `<!-- someCodeHere(); -->`)
- A snippet without any import statements will have an import
  (`'package:flutter/material.dart'`)
  automatically added to it
- We ignore special formatting tags like `[[highlight]]`.

[Flutter]: https://flutter.io
