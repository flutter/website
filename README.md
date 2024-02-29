[![Flutter logo]](https://docs.flutter.dev)

[Flutter logo]: https://github.com/dart-lang/site-shared/blob/main/src/_assets/image/flutter/icon/64.png?raw=1

# [Flutter][] website 

[![Build Status][]][Repo on GitHub Actions]
[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/flutter/website/badge)](https://deps.dev/project/github/flutter%2Fwebsite)

[Build Status]: https://github.com/flutter/website/workflows/build/badge.svg
[Flutter]: https://docs.flutter.dev/
[Repo on GitHub Actions]: https://github.com/flutter/website/actions?query=workflow%3Abuild+branch%3Amain

## Table of contents

* [Issues, bugs, and requests](#issues-bugs-and-requests)
* [Before you submit a PR](#before-you-submit-a-pr)
* [Before you build this site](#before-you-build-this-site)
* [Creating and/or editing DartPad example code](#creating-andor-editing-dartpad-example-code)
* [Writing for flutter.dev](#writing-for-flutterdev)

## Issues, bugs, and requests

We welcome contributions and feedback on our website. 
Please file a request in our
[issue tracker](https://github.com/flutter/website/issues/new/choose) 
or create a [pull request](https://github.com/flutter/website/pulls). 
For simple changes (such as tweaking some text), 
it's easiest to make changes using the GitHub UI.

If you have an issue with the 
API docs on [api.flutter.dev](https://api.flutter.dev), 
please file those issues on 
the [flutter/flutter](https://github.com/flutter/flutter/issues) repo, 
not on this (flutter/website) repo. 
The API docs are embedded in Flutter's source code, 
so the engineering team handles those.


## Before you submit a PR

We love it when the community gets involved in improving our docs! 
But here are a few notes to keep in mind before you submit a PR:

- When triaging issues, 
  we sometimes label an issue with the tag **PRs welcome**. 
  But we welcome PRs on other issues as well&mdash;
  it doesn't have to be tagged with that label.
- Please don't run our docs through Grammarly (or similar) 
  and submit those changes as a PR.
- We follow the [Google Developer Documentation Style Guidelines][] —
  for example, don't use "i.e." or "e.g.", 
  avoid writing in first person,
  and avoid writing in future tense.
  You can start with the
  [style guide highlights](https://developers.google.com/style/highlights) 
  or the [word list](https://developers.google.com/style/word-list), 
  or use the search bar that's at the top of every style guide page. 

> We truly thank you for your willingness and helpfulness
> in keeping the website docs up to date!

[Google Developer Documentation Style Guidelines]: https://developers.google.com/style

## Before you build this site

For changes beyond simple text and CSS tweaks, 
we recommend building the site.

> [!WARNING]  
> Support for building the site locally has temporarily been removed.
> This README will be updated with the new building details soon.
> 
> Until then, please rely on automatic staging in pull requests.
> Thanks for your patience!

### Clone this repo _and_ its submodules

> **Note:** This repo has git _submodules_, 
> which affects how you clone it. 
> The GitHub documentation has general help on
> [forking][] and [cloning][] repos.

[cloning]: https://help.github.com/articles/cloning-a-repository
[forking]: https://docs.github.com/en/get-started/quickstart/fork-a-repo

If you're outside of the Flutter organization, 
we recommend you **create a fork** of the repo under your own account, 
and then submit a PR from that fork. 

Once you have a fork (or you're a Flutter org member), 
_choose one_ of the following submodule-cloning techniques:

- Clone the repo and its submodule at the same
  using the `--recurse-submodules` option:
- 
  ```bash
  $ git clone --recurse-submodules https://github.com/<username-or-flutter>/website.git
  ```

  OR

- If you've already cloned the repo without its submodule, 
  then run this command from the repo root:

  ```bash
  $ git submodule update --init --recursive
  ```

> **Note:** At any time during development 
> you can use the `git submodule` command to refresh submodules:
>
> ```bash
> $ git pull; git submodule update --init --recursive
> ```

## Creating and/or editing DartPad example code

Most of the code used to create [DartPad][] examples is hosted on GitHub. 
However, this repo also contains some `*.dart` files
responsible for DartPad example code.

[DartPad]: https://dartpad.dev

### DartPad example code in GitHub gists

A typical DartPad example takes the form of an `iframe`, 
for example, within a codelab's Markdown file:

```html
<iframe
  src="{{ site.custom.dartpad.embed-flutter-prefix }}?id=d7b09149ffee2f0535bb0c04d96987f5" 
  style="border:1px solid lightgrey;margin-top:10px;margin-bottom:25px"
  frameborder="no" height="500" width="100%">
</iframe>
```

This `iframe` depends on the following GitHub gist URL:
> https://gist.github.com/d7b09149ffee2f0535bb0c04d96987f5

For detailed instructions on how to use this approach
to DartPad examples, see the [DartPad embedding guide][].

[DartPad embedding guide]: https://github.com/dart-lang/dart-pad/wiki/Embedding-Guide
   

## Refreshing code excerpts

A build that fails with the error
`Error: Some code excerpts needed to be updated!`
means that one or more code excerpts in the markdown file
aren't identical to the
code in the corresponding `.dart` file. 

To resolve this error,
from the root of the `website` directory,
run `dart run flutter_site refresh-excerpts`. 

For more information see [Code excerpts][] . 

[Code excerpts]: https://github.com/dart-lang/site-shared/blob/main/doc/code-excerpts.md

## Writing for flutter.dev

The [site-shared](https://github.com/dart-lang/site-shared) repo 
contains infrastructure shared by most of our Dart and Flutter websites. 
Some of this README is in the
[doc](https://github.com/dart-lang/site-shared/tree/main/doc)
directory in the site-shared repo.

For more information on using and writing for this repo,
refer to the following docs:

* [Writing for Dart and Flutter websites](https://github.com/dart-lang/site-shared/blob/main/doc/writing-for-dart-and-flutter-websites.md)
* [Infrastructure](https://github.com/dart-lang/site-shared/blob/main/doc/infrastructure.md)
* [Markdown](https://github.com/dart-lang/site-shared/blob/main/doc/markdown.md)
* [Examples](https://github.com/dart-lang/site-shared/blob/main/doc/examples.md)
* [Code excerpts][]
* [Images](https://github.com/dart-lang/site-shared/blob/main/doc/images.md)
* [Mobile friendly pages: tips & tricks](https://github.com/dart-lang/site-shared/blob/main/doc/mobile-friendly-pages.md)

