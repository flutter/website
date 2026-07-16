---
title: "Integration Testing with flutter_driver"
description: "Unit tests ensure that individual parts of your application work as intended, but what about your application as a whole? This is where…"
publishDate: 2020-09-29
author: guidez
category: tutorial
layout: blog
---

Unit tests ensure that individual parts of your application work as intended, but what about your application as a whole? This is where integration testing comes in.

## Flutter driver

If you’ve never done integration testing in Flutter (or anywhere), fear not! Adding integration tests to your app is a straightforward task in Flutter. A very helpful set of articles will guide you.

1. [An introduction to integration testing](https://flutter.dev/docs/cookbook/testing/integration/introduction): What even is this thing, and how do I set it up?

1. [Handle scrolling](https://flutter.dev/docs/cookbook/testing/integration/scrolling): How do I handle the common pattern of scrolling to something?

Getting to this point ensures that your app can run without crashing, that certain screens can be reached, that specific actions have some result, and so on. What tests you create depends on your needs. You can have one test that opens every screen of your app, or tests that go through specific user journeys.

But we can go further with `flutter_driver` by using it for performance testing.

## Performance profiling

Simply wrapping your test with `flutterDriver.traceAction` records the performance of your app as your test is running. This output data (in JSON format) can be used in Continuous Integration (CI) testing, to ensure, for example, that certain metrics remain above or below a particular threshold. The data can also be used to debug performance issues. For details on how to do performance profiling, see the article on integration testing, [Performance profiling](https://flutter.dev/docs/cookbook/testing/integration/profiling).

For reference, the Flutter Gallery has an [integration test](https://github.com/flutter/gallery/tree/master/test_driver) that goes through all demos and captures performance metrics for a subset of them.

## Screenshot testing

*Screenshot testing* is the technique of rendering the UI, capturing a screenshot of the output, and then comparing the result to an expected image. An easy way to add screenshot tests to your app is to use `flutterDriver.screenshot`. To learn more and see a real code example, see the Medium article, [Testing Flutter UI with Flutter Driver](https://medium.com/flutter-community/testing-flutter-ui-with-flutter-driver-c1583681e337#8561), by community member Darshan Kawar.

This method can be easily integrated into your continuous integration testing setup to prevent UI regressions. The Flutter Gallery has a few [screenshots tests](https://github.com/flutter/gallery/tree/master/golden_test) and a [GitHub workflow configuration](https://github.com/flutter/gallery/blob/master/.github/workflows/golden.yml) to automatically test incoming PRs.

```dart
await pumpWidgetWithImages(
  tester,
  const GalleryApp(initialRoute: demoBannerRoute),
  homeAssets,
);

await tester.pumpAndSettle();

await expectLater(
  find.byType(GalleryApp),
  matchesGoldenFile('goldens/demo_desktop_dark.png'),
);

```

## a11y testing

*a11y*, or accessibility testing, is a type of usability testing performed to ensure that the application is usable by people with disabilities, such as vision impairment, hearing loss, a motor disability, and so on. Use `flutterDriver.getSemanticsId` to verify semantic labels, for example, to verify that all images have semantic labels.

```dart
final imageLabel = find.bySemanticsLabel('Company logo');
int id = await flutterDriver.getSemanticsId(imageLabel);
expect(id, isNotNull);
```

Learn more about testing for accessibility in another great article by Darshan Kawar, [Developing and testing accessible apps in Flutter](https://medium.com/flutter-community/developing-and-testing-accessible-app-in-flutter-1dc1d33c7eea).

## i18n testing

*i18n*, or internationalization testing, is the process of testing that an application can be used in various languages and regions without any changes.

Depending on how your localization code is set up, you might change locales using your localizations’ delegate.

```dart
ExampleAppLocalizationsDelegate.load(Locale('fr'));
```

Alternatively, when using MaterialApp, simply allow overriding the locale for the app to run in a different locale.

```dart
void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({
    Key key,
    this.locale,
  }) : super(key: key);

  final Locale locale;

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        locale: locale,
        ...
      );
  }
}

```

In the driver file that launches the app, set the locale.

```dart
void main() {
  runApp(const ExampleApp(locale: Locale('fr')));
}

```

## Extra tip

Want to know if an element is present on the page?

```dart
/// Returns a [Future] that resolves to true if the widget specified by [finder]
/// is present, false otherwise.
Future<bool> isPresent(SerializableFinder finder, FlutterDriver driver,
    {Duration timeout = const Duration(seconds: 1)}) async {
  try {
    await flutterDriver.waitFor(finder, timeout: timeout);
    return true;
  } catch (exception) {
    return false;
  }
}

```

You can choose whatever timeout works for your app.

## Closing remarks

By now you should have a good idea of what is possible with `flutter_driver`. You can combine methods to fit your needs; for example, performing screenshot tests using different locales. If we forgot something, let us know in the comments! For more information, see the [flutter_driver](https://api.flutter.dev/flutter/flutter_driver/flutter_driver-library.html) API docs.

*About the author: Pierre-Louis is a recent undergrad for the University of Waterloo. Based in Munich, he is part of a team that maintains the Flutter Material library. He has a keen interest in UI, UX, and app development. You can connect with him on [LinkedIn](https://www.linkedin.com/in/guidezpl) and [GitHub](https://github.com/guidezpl).*
