---
title: Architecture recommendations and resources
shortTitle: Architecture recommendations
description: >
  Recommendations for building scalable Flutter applications.
prev:
  title: Architecture case study
  path: /app-architecture/case-study
next:
  title: Design patterns
  path: /app-architecture/design-patterns
---

This page presents architecture best practices, why they matter, and
whether we recommend them for your Flutter application.
You should treat these recommendations as recommendations,
and not steadfast rules, and you should
adapt them to your app's unique requirements.

The best practices on this page have a priority,
which reflects how strongly the Flutter team recommends it.

* **Strongly recommend:** You should always implement this recommendation if
  you're starting to build a new application. You should strongly consider
  refactoring an existing app to implement this practice unless doing so would
  fundamentally clash with your current approach.
* **Recommend**: This practice will likely improve your app.
* **Conditional**: This practice can improve your app in certain circumstances.

## Separation of concerns

You should separate your app into a UI layer and a data layer. Within those layers, 
you should further separate logic into classes by responsibility.

<ArchitectureRecommendations category="separation-of-concerns" />

## Handling data

Handling data with care makes your code easier to understand, less error prone, and
prevents malformed or unexpected data from being created.

<ArchitectureRecommendations category="handling-data" />

## App structure

Well organized code benefits both the health of the app itself, and the team working on the code.

<ArchitectureRecommendations category="app-structure" />

## Testing

Good testing practices makes your app flexible. 
It also makes it straightforward and low risk to add new logic and new UI.

<ArchitectureRecommendations category="testing" />

<a id="recommended-resources" aria-hidden="true"></a>

## Recommended resources {:#resources}

* Code and templates
  * [Compass app source code][] -
    Source code of a full-featured, robust Flutter application that
    implements many of these recommendations.
  * [very_good_cli][] -
    A Flutter application template made by
    the Flutter experts Very Good Ventures.
    This template generates a similar app structure.
* Documentation
  * [Very Good Engineering architecture documentation][] -
    Very Good Engineering is a documentation site by VGV that has
    technical articles, demos, and open-sourced projects.
    It includes documentation on architecting Flutter applications.
  * [State Management with ChangeNotifier walkthrough][] -
    A gentle introduction into using the primitives in
    the Flutter SDK for your state management.
* Tooling
  * [Flutter developer tools][] -
    DevTools is a suite of performance and debugging tools for Dart and Flutter.
  * [flutter_lints][] -
    A package that contains the lints for
    Flutter apps recommended by the Flutter team.
    Use this package to encourage good coding practices across a team.


[Compass app source code]: https://github.com/flutter/samples/tree/main/compass_app
[very_good_cli]: https://cli.vgv.dev/
[Very Good Engineering architecture documentation]: https://engineering.verygood.ventures/architecture/architecture/
[State Management with ChangeNotifier walkthrough]: /get-started/fwe/state-management
[Flutter developer tools]: /tools/devtools
[flutter_lints]: https://pub.dev/packages/flutter_lints

## Feedback

As this section of the website is evolving,
we [welcome your feedback][]!

[welcome your feedback]: https://google.qualtrics.com/jfe/form/SV_4T0XuR9Ts29acw6?page="recommendations"
