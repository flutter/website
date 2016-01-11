# [Flutter][]'s website

Flutter's static website, built with Jekyll.

[![Build Status](https://travis-ci.org/flutter/flutter.github.io.svg?branch=master)](https://travis-ci.org/flutter/flutter.github.io)

## Developing

Install Jekyll and related tools by following the
[instructions](https://help.github.com/articles/using-jekyll-with-pages/)
provided by GitHub.

A tldr version follows:

* First time contributor to this site? Ensure you have Ruby and bundler
  installed, and then run `bundle install`
* Create a branch.
* Make your changes.
* To test your changes, run `bundle exec jekyll serve` (or
  `jekyll serve -w --force_polling`)

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
