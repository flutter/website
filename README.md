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
`bundle exec htmlproofer _site --empty-alt-ignore --url-ignore "#" --only-4xx`

## Code Snippet Validation

The code snippets in the markdown documentation are validated as part of the
build process. Anything within a '\`\`\`dart' code fence will be extracted into
its own file and checked for analysis issues. Some ways to tweak that:

- if a code snippet should not be analyzed, immediately proceed it with
  a `<!-- skip -->` comment
- to include code to be analyzed, but not displayed, add that in a comment
  immediately proceeding the snippet (e.g., `<!-- someCodeHere(); -->`)
- a snippet without any import statements will have an import
  (`'package:flutter/material.dart'`)
  automatically added to it

[Flutter]: https://flutter.io
