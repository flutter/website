---
title: The default page transition on Android is now PredictiveBackPageTransitionsBuilder
description: >-
  Android's default page transition has been updated to match the
  platform and to support predictive back.
---

## Summary

The default page transition on Android has been updated from
[`ZoomPageTransitionsBuilder`][] to [`PredictiveBackPageTransitionsBuilder`][].
When not using predictive back, this falls back to
[`FadeForwardsPageTransitionsBuilder`][].

## Context

Android has been rolling out a feature called predictive back, where performing
a back gesture allows the user to peek at the previous route or app and possibly
cancel the navigation. Flutter added support for this with the [`PopScope`][]
widget followed by [`PredictiveBackPageTransitionsBuilder`][].

In the meantime, Android also updated its default page transition. Flutter added
support for this with [`FadeForwardsPageTransitionsBuilder`][].

## Description of change

With this change, [`PredictiveBackPageTransitionsBuilder`][] has replaced
[`ZoomPageTransitionsBuilder`][] as the default page transition on Android.
During a normal page transition without a predictive back gesture, users
see the new [`FadeForwardsPageTransitionsBuilder`][] as the default page
transition. When using a predictive back gesture, the page animates along
with the gesture and allows canceling or committing to the back navigation.

In this example, no page transition is explicitly given, so the
[default]({{site.github}}/flutter/flutter/blob/e983e4bd81f29b17215057fa5c9f46f96cbaf183/packages/flutter/lib/src/material/page_transitions_theme.dart#L806-L813)
is set to [`PredictiveBackPageTransitionsBuilder`][] in the theme on Android.

```dart
MaterialApp(
  theme: ThemeData(
    brightness: Brightness.light,
  ),
  home: const PageOne(),
);
```

## Migration guide

If you want to keep your app's page transition on the old
[`ZoomPageTransitionsBuilder`][], you can simply set your page transition
explicitly in your app's theme. Keep in mind that you will not be able to
support predictive back route transitions.

Code before migration:

```dart
return MaterialApp(
  theme: ThemeData(
    brightness: Brightness.light,
    // pageTransitionsTheme is the default.
  ),
  home: const MyFirstScreen(),
);
```

Code after migration:

```dart
MaterialApp(
  theme: ThemeData(
    // pageTransitionsTheme is explicitly set to the old transition on Android.
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
takes to transition between pages has increased from 300ms to 450ms. This might
cause breakages in tests that depend on the previous transition duration.
Fortunately, it's possible to use [`TransitionDurationObserver`][] to keep tests
independent of whatever page transition is used.

Code before migration:

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

Landed in version: 3.37.0-0.0.pre<br>
In stable release: 3.38.0

## References

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

[`FadeForwardsPageTransitionsBuilder`]: {{site.api}}/flutter/material/FadeForwardsPageTransitionsBuilder-class.html
[`PopScope`]: {{site.api}}/flutter/widgets/PopScope-class.html
[`PredictiveBackPageTransitionsBuilder`]: {{site.api}}/flutter/material/PredictiveBackPageTransitionsBuilder-class.html
[`TransitionDurationObserver`]: {{site.api}}/flutter/flutter_test/TransitionDurationObserver-class.html
[`ZoomPageTransitionsBuilder`]: {{site.api}}/flutter/material/ZoomPageTransitionsBuilder-class.html

[Android predictive back route transitions]: {{site.github.com}}/flutter/flutter/issues/131961
[Predictive back route transitions by default]: {{site.github}}/flutter/flutter/pull/165832
