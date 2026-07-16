---
title: "Writing a good code sample"
description: "Authoring a good code sample is hard. Let me clarify that, putting together a sample that demonstrates the usage of an API, or shows off a…"
publishDate: 2021-08-23
author: domesticmouse
category: tutorial
layout: blog
---

Authoring a good code sample is hard. Let me clarify that, putting together a sample that demonstrates the usage of an API, or shows off a UI idiom, can be quick and easy. The difficulty comes from the additional pieces you need to add to your repository to keep the code sample fresh and appealing to your developers.

The first thing to add to your code is a good README that starts with a summary of why a developer should invest the time and effort to investigate and understand the sample. Following that with usage instructions, and links to an issue tracker where developers can raise bugs and ask for clarification if something is confusing is a great next step.

Next up, the code itself. Does the code follow conventions for layout and usage? This may be as simple as where does the code go, or as intricate as appropriate settings for linters and the like. I like programming community languages that have adopted a strong standard as to code formatting, layout, and linting rule sets. These standards bring conformity to the look and feel of the code which make it easier to navigate. To enforce code formatting for Dart and Flutter you can add the following command to your CI pipeline to fail the build if it isn’t correctly formatted:

```bash
$ dart format --output none --set-exit-if-changed .
```


After code formatting, the next step is enforcing a good set of lints. For Dart, I strongly recommend investigating the [lints](https://pub.dev/packages/lints) package, and for Flutter I likewise recommend the [flutter_lints](https://pub.dev/packages/flutter_lints) package. To make sure the lints pass in the CI pipeline, add the following command:

```bash
$ dart analyze
```


Tests. Oh so many tests. Unit tests, integration tests, and for Flutter we also have Widget tests. Tests are great for samples, as the tests communicate intent of how a piece of code is intended to be used. The tests also keep a codebase evergreen, when used in combination with the aforementioned CI pipeline. A good place to learn more about Flutter’s testing capability is the [How to test a Flutter app codelab](https://codelabs.developers.google.com/codelabs/flutter-app-testing). The CI commands for Dart and Flutter respectively:

```bash
$ flutter test   # for Flutter projects
$ dart test      # for pure Dart projects
```


If your code repository is hosted on GitHub, then I suggest you use the [Dart Setup](https://github.com/marketplace/actions/setup-dart-sdk) action if you have a Dart project, and the [Flutter Action](https://github.com/marketplace/actions/flutter-action) if you have a Flutter project. For additional points, consider adding the [Very Good Coverage](https://github.com/marketplace/actions/very-good-coverage) action to keep test coverage high. Given you’ve gone this far, you probably should advertise your CI status with a [workflow status badge](https://docs.github.com/en/actions/managing-workflow-runs/adding-a-workflow-status-badge).

Hopefully the above list of additions guides you through making your code sample much more valuable to your target audience.