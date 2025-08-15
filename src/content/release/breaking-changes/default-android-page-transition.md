---
title: The default page transition on Android is now PredictiveBackPageTransitionsBuilder
description: Android's default page transition has been updated to match the
platform and to support predictive back.
---

{% comment %}
  PLEASE READ THESE GENERAL INSTRUCTIONS:
  * All lines of text should be 80 chars OR LESS.
    The writers strongly prefer semantic line breaks:
    https://github.com/dart-lang/site-shared/blob/master/doc/writing-for-dart-and-flutter-websites.md#semantic-line-breaks
  * DON'T SUBMIT a PR weeks and weeks in advance.
    Doing this causes it to get stanky in the website
    repo and usually develops conflicts in the index file.
    Ideally, submit a PR once you have confirmed
    info on the version number where the breaking
    change landed.
  * One of the most important things to fill out 
    in this template is the *Timeline* section.
    I won't approve/merge the PR until the "landed in"
    release info is provided. For example:
    `Landed in version: 1.21.0-5.0.pre<br>`.
    Do NOT list the PR in this section. Also, don't
    fill in the "stable" release info unless it's
    already in a published stable release.
    After a stable release, I go through and confirm
    that updates have made it to stable and I then
    update the breaking change and the index file.
  * The text in this page should be backwards looking,
    so write about previous behavior in past tense,
    not future tense. People are reading this months
    from now when the change is likely in the stable
    release, not today. Don't say "in a month" or
    talk about your plan to do something next week.
    Assume you've done it, and that they're looking
    back to figure out how to migrate their code.
  * Use sentence case for headings and titles.
    (`## Migration guide`, NOT `Migration Guide`)
  * DON'T use the abbreviation `i.e.` or `e.g.`.
    Use "for example" or "such as", and similar.
  * For links, use the macros where possible.
    See the examples at the end of this template,
    but don't use "github.com" or "api.flutter.dev" or
    "pub.dev" in your URLs. Use the {{site.github}},
    {{site.api}}, or {{site.pub}} macros.
  * AVOID "will" when possible, in other words,
    stay in the present tense. For example:
    Bad: "When encountering an xxx value,
          the code will throw an exception."
    Good: "When encountering an xxx value,
           the code throws an exception."
    Good use of "will": "In release 2.0, the xxx API
          will be deprecated."
  * If your included Dart code won't pass analysis
    on its own (using the analyzer from the latest
    stable release), then preface that code with an
    HTML `<!-- skip -->` tag.
  * Finally, delete the comment tags and text from the
    final PR.
{% endcomment %}

## Summary

The default page transition on Android has been updated from
[`ZoomPageTransitionsBuilder`][] to [`PredictiveBackPageTransitionsBuilder`][]. When
not using predictive back, this falls back to
[`FadeForwardsPageTransitionsBuilder`][].

## Context

Android has been rolling out a feature called predictive back, where performing
a back gesture allows the user to peek at the previous route or app and possibly
cancel the navigation. Flutter added support for this with the [`PopScope`][]
widget followed by [`PredictiveBackPageTransitionsBuilder`][].

In the meantime, Android also updated its default page transition. Flutter added
support for this with [`FadeForwardsPageTransitionsBuilder`][].

Finally with this change, [`PredictiveBackPageTransitionsBuilder`][] has
replaced [`ZoomPageTransitionsBuilder`][] as the default page transition on
Android. Any time that navigation happens without a predictive back gesture,
[`FadeForwardsPageTransitionsBuilder`][] is used.

## Description of change

TODO(justinmc): Maybe take some from Context section above.
{% comment %}
A technical description of the actual change,
with code samples showing how the API changed.

Include examples of the error messages that are produced
in code that has not been migrated. This helps the search
engine find the migration guide when people search for those
error messages.
{% endcomment %}

## Migration guide

If you want to keep your app's page transition exactly the same as before, you
can simply set your page transition explicitly in your app's theme. Keep in mind
that you will not be able to support predictive back route transitions.

Code before migration:

<!-- skip -->
```dart
return MaterialApp(
  // ThemeData.pageTransitionsTheme is the default.
  home: const MyFirstScreen(),
);
```

Code after migration:

<!-- skip -->
```dart
return MaterialApp(
  theme: ThemeData(
    // ThemeData.pageTransitionsTheme is explicitly set to the old transition.
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      },
    ),
  ),
  home: const MyFirstScreen(),
);
```

One side effect of changing the default transition is that the duration that it
takes to transition between pages has increased from 300ms to 450ms. This may
cause breakages in tests that depend on the previous transition duration.
Fortunately, it's possible to use [`TransitionDurationObserver`][] to keep tests
independent of whatever page transition is used.

Code before migration:

<!-- skip -->
```dart
testWidgets('example', (WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      onGenerateRoute: (RouteSettings settings) { ... },
    ),
  );

  expect(find.text('Page 1'), findsOneWidget);
  expect(find.text('Page 2'), findsNothing);

  // Pump through the whole transition, hardcoded to 300ms.
  await tester.tap(find.text('Next'));
  await tester.pump(const Duration(milliseconds: 300));

  expect(find.text('Page 1'), findsNothing);
  expect(find.text('Page 2'), findsOneWidget);
});
```

Code after migration:

<!-- skip -->
```dart
testWidgets('example', (WidgetTester tester) async {
  final TransitionDurationObserver observer = TransitionDurationObserver();

  await tester.pumpWidget(
    MaterialApp(
      navigatorObservers: <NavigatorObserver>[observer],
      onGenerateRoute: (RouteSettings settings) { ... },
    ),
  );

  expect(find.text('Page 1'), findsOneWidget);
  expect(find.text('Page 2'), findsNothing);

  // Pump through the whole transition independent of the duration.
  await tester.tap(find.text('Next'));
  await observer.pumpPastTransition(tester);

  expect(find.text('Page 1'), findsNothing);
  expect(find.text('Page 2'), findsOneWidget);
});
```

It's even possible to write tests that need to pump part of the way through a
page transition without depending on the exact duration.

Code before migration:

<!-- skip -->
```dart
testWidgets('example', (WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      onGenerateRoute: (RouteSettings settings) { ... },
    ),
  );

  expect(find.text('Page 1'), findsOneWidget);
  expect(find.text('Page 2'), findsNothing);

  // Pump through half of the transition with a hardcoded value.
  await tester.tap(find.text('Back'));
  await tester.pump(const Duration(milliseconds: 150));

  expect(find.text('Page 1'), findsOneWidget);
  expect(find.text('Page 2'), findsOneWidget);
});
```

Code after migration:

<!-- skip -->
```dart
testWidgets('example', (WidgetTester tester) async {
  final TransitionDurationObserver observer = TransitionDurationObserver();

  await tester.pumpWidget(
    MaterialApp(
      navigatorObservers: <NavigatorObserver>[observer],
      onGenerateRoute: (RouteSettings settings) { ... },
    ),
  );

  expect(find.text('Page 1'), findsOneWidget);
  expect(find.text('Page 2'), findsNothing);

  // Pump through half of the transition independent of the duration.
  await tester.tap(find.text('Back'));
  await tester.pump(observer.transitionDuration ~/ 2);

  expect(find.text('Page 1'), findsOneWidget);
  expect(find.text('Page 2'), findsOneWidget);
});
```

## Timeline

TODO(justinmc): Should land any minute now...
{% comment %}
  The version # of the SDK where this change was
  introduced.  If there is a deprecation window,
  the version # to which we guarantee to maintain
  the old API. Use the following template:

  If a breaking change has been reverted in a
  subsequent release, move that item to the
  "Reverted" section of the index.md file.
  Also add the "Reverted in version" line,
  shown as optional below. Otherwise, delete
  that line.
{% endcomment %}

Landed in version: xxx<br>
In stable release: not yet
Reverted in version: xxx  (OPTIONAL, delete if not used)

## References

TODO(justinmc)
{% comment %}
  These links are commented out because they
  cause the GitHubActions (GHA) linkcheck to fail.
  Remove the comment tags once you fill this in with
  real links. Only use the "master-api" include if
  you link to "master-api.flutter.dev".

{% include master-api.md %}

API documentation:

* [`ZoomPageTransitionsBuilder`][]
* [`PredictiveBackPageTransitionsBuilder`][]
* [`FadeForwardsPageTransitionsBuilder`][]
* [`PopScope`][]
* [`TransitionDurationObserver`][]

Relevant issues:

* [Android predictive back route transitions][]

Relevant PRs:

* [Predictive back route transitions by default][]
{% endcomment %}

{% comment %}
  Add the links to the end of the file in alphabetical order.
  The following links are commented out because they make
  the GitHubActions (GHA) link checker believe they are broken links,
  but please remove the comment tags before you commit!

  If you are sharing new API that hasn't landed in
  the stable channel yet, use the master channel link.
  To link to docs on the master channel,
  include the following note and make sure that
  the URL includes the master link (as shown below).

  Here's an example of defining a stable (site.api) link
  and a master channel (master-api) link.

<!-- Stable channel link: -->
[`ZoomPageTransitionsBuilder`]: {{site.api}}/flutter/material/ZoomPageTransitionsBuilder-class.html
[`PredictiveBackPageTransitionsBuilder`]: {{site.api}}/flutter/material/PredictiveBackPageTransitionsBuilder-class.html
[`FadeForwardsPageTransitionsBuilder`]: {{site.api}}/flutter/material/FadeForwardsPageTransitionsBuilder-class.html
[`PopScope`]: {{site.api}}/flutter/widgets/PopScope-class.html
[`TransitionDurationObserver`]: {{site.api}}/flutter/flutter_test/TransitionDurationObserver-class.html

<!-- Master channel link: -->
{% include master-api.md %}

[Android predictive back route transitions]: {{site.github.com}}/flutter/flutter/issues/131961
[Predictive back route transitions by default]: {{site.github}}/flutter/flutter/pull/165832
{% endcomment %}
