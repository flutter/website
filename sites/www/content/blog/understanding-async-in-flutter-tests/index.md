---
title: "Understanding Async in Flutter Tests"
description: "Taking a look at the caveats and best practices of working with asynchronous behavior in your Flutter Widget Tests."
publishDate: 2019-05-02
author: arbullard
category: tutorial
layout: blog
---

The [FakeAsync](https://docs.flutter.io/flutter/quiver.testing.async/FakeAsync-class.html) class (from the quiver package), was created to make time-dependent code testable. Flutter unit tests run in a **FakeAsync** Zone. What does that mean? From the docs on **FakeAsync**:
> *Test code can be passed as a callback to run, which causes it to be run in a Zone which fakes timer and microtask creation, such that they are run during calls to elapse which simulates the asynchronous passage of time.*

This means that when you use any language feature that requires the creation of timers or microtasks, like Futures and Streams, they are handled by **FakeAsync** in a way that mimics the semantics of real asynchronicity in a logical fashion, but divorced from actual wall clock time.

Observe the code sample below:

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<int> outerF;
  final Duration delay = Duration(seconds: 20);

  group('Async Tests - Fake Async', () {
    setUpAll(() async {
      outerF = Future<int>.delayed(delay, () => 42);
      final Stopwatch waiting = Stopwatch()..start();
      final Future<void> innerF = Future<int>.delayed(Duration(seconds: 3), () {});
      await innerF;
      waiting.stop();
      print('Waited for ${waiting.elapsed}');
    });
    // Each testWidgets callback is run in a distinct FakeAsync zone
    testWidgets('Delayed in test, no time added', (WidgetTester tester) async {
      // This will fail due to blowing past the 2 second test case timeout.
      final Future<int> f = Future<int>.delayed(delay, () => 1);
      await f;
    });
    testWidgets('Delayed in test, time added', (WidgetTester tester) async {
      final Future<int> f = Future<int>.delayed(delay, () => 1);
      // So we extend the "time" allowed in the zone, and now it passes.
      // Note that this still runs almost immediately.
      tester.pump(delay);
      await f;
    });
    testWidgets('Delayed from setUp, no time added', (WidgetTester tester) async {
      // This will fail, and will appear to be from a timeout.
      await outerF;
    });
    testWidgets('Delayed from setUp, time added', (WidgetTester tester) async {
      // Even with the "time" added though, it will fail. It will not resolve the
      // future from a different, Real Async, Zone. The error will still look like
      // an exception related to a timeout.
      // It will also run very slow, at least as long as the amount of "time" the
      // tester binding thinks it will take.
      tester.binding.addTime(delay);
      await outerF;
    });
  });
}
```

What is happening here?

The most fundamental takeaway is that a **FakeAsync** Zone is created for each test case. These Zones are completely independent of each other in the sense of keeping track of time(obviously, variable and references still obey the Dart scoping rules). They cannot access asynchronous work from other Zones, Real or Fake.

The same applies to your Widget code when using **tester.pumpWidget()**. Any asynchronous behavior in your Widget will not be waited for. This presents a number of issues when testing widget trees that contain Images.

Images are problematic for two reasons:

## The asset manifest is not created for tests.

So there is no way for the **AssetBundle** to load the bytes for your (Asset) image. Luckily, there is a solution for this: create your own subtype of **AssetBundle** that loads the bytes for all images before you run your tests. We have the pattern for that below. This solves the first exception you would receive in the preceding example.

```dart
class TestAssetBundle extends CachingAssetBundle {
  TestAssetBundle(Map<String, List<String>> assets) : _assets = assets {
    for (String assetList in assets.keys) {
      for (String asset in assets[assetList]) {
        _assetMap[asset] = bytesForFile(asset);
      }
    }
  }

  final Map<String, ByteData> _assetMap = <String, ByteData>{};
  final Map<String, List<String>> _assets;

  @override
  Future<ByteData> load(String key) {
    if (key == 'AssetManifest.json') {
      return Future<ByteData>.value(bytesForJsonLike(_assets));
    }
    return Future<ByteData>.value(_assetMap[key]);
  }
}

ByteData bytesForJsonLike(Map<String, dynamic> jsonLike) => ByteData.view(
    Uint8List.fromList(const Utf8Encoder().convert(json.encode(jsonLike)))
        .buffer);

ByteData bytesForFile(String path) => ByteData.view(
    Uint8List.fromList(File('../' + path).readAsBytesSync()).buffer);
```

This class is generally applicable. You build the bundle as follows:

```dart
final AssetBundle bundle = TestAssetBundle(<String, List<String>>{
'assets/dart-logo.png': <String>['assets/dart-logo.png'],
});
```

You can include, in the list for each entry, a number of assets for different pixel densities. The Flutter tester has a fixed pixel density, so you should normally only need to provide a single item there.

## Calls to Flutter Engine

The operation to decode the bytes into a paint-able image comes from the Flutter Engine through a call to a native function. This is an asynchronous operation, and again, the tester will not wait for it to complete. There is nothing you can do in a **FakeAsync** Zone to work around this.

This leads to some **iron laws** around testing widget trees that contain images:

1. Use **DefaultAssetBundle** to load the bytes for the images that will be used by tests in that file.

1. In a **FakeAsync** Zone, i.e., in normal widget tests, do not rely on implicit size or presence of images in any sort of assertion. If such an assertion must be made, wrap your image in a **SizedBox** or some other mechanism to have deterministic control over the widgets size.

1. If you don’t know the size of the image at development time (maybe it comes from user content and may vary), you may need to test with integration or end-to-end tests. It’s worth thinking about what you are looking to understand about the widget being tested.

1. If you are looking for visual regression testing, there are options available that we’ll discuss in the section below.

## Is it possible to have real async semantics in unit tests?

The short answer is yes, but the technique described here should be used only in very specific contexts. Below, we will discuss a set of best practices around the technique.

The solution is actually rather easy, as shown in the following example:

```dart
import 'dart:async';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  LiveTestWidgetsFlutterBinding();
  Future outsideFuture;

  setUp(() {
    outsideFuture = Future.microtask(() {
      return 'outside';
    });
  });

  testWidgets("awaiting future with value from setUp works", (t) async {
    Future insideFuture = Future.microtask(() {
    return 'inside';
  });
}
```

This code binds the **TestWidgetsFlutterBinding** to a **LiveTestWidgetsFlutterBinding**, which runs test code in a real async zone. This means if you await an asynchronous event that takes 10 minutes, your test runs for at least 10 minutes. If the event you are awaiting has non-deterministic performance, so will your tests.

Unfortunately, while this is available to you, it offers you very little benefit when using flutter test. The reason that most developers will want to take advantage of **LiveTestWidgetsFlutterBinding** is when they are trying to understand behavior in their tests. Luckily, there is an easier way to access this binding mode that is also much more helpful. You can run your test *on device* using flutter run path/to/your_test.dart.

One caveat with flutter running your test case is that **matchesGolden** assertions will cause an exception to be thrown. A good practice is to place [Goldens tests](https://docs.flutter.io/flutter/flutter_test/matchesGoldenFile.html) in a separate directory, and know that those tests should only be called with flutter test.

## What does this mean for images in my tests?

This mode does not change the fact that Widget Tests are not the place to make layout assertions, besides the most basic cases. If your layout depends on Images or other assets of a size that is unknown at development time, your assertions will not work as expected.

If you *do* know the size of the asset(s) at development time and wish to make layout assertions (like **isOnstage**), we recommend wrapping the widget in a **ConstrainedBox**, or **SizedBox** to ensure that the Widget will occupy the space you expect in your layout.

## Key Takeaways

Testing your widgets is critical in the maintainability of your application. Unit tests are the fastest and most productive way to test your code and **testWidgets** provides you with some amazing facilities for unit testing the most visible part of your application. That being said, this article shows that there are some caveats to be aware of and some best practices to follow.

## Caveats

* **testWidgets** is for testing *Widget Behavior*, not Widget appearance or layout.

* **FakeAsync** has semantics to make your tests run fast, but it requires changing the way you think about your app.

* The async code that runs in **tester.runAsync**, and within a test case, run in real time.

* The async code from outside the test case, and within your Widget tree, run in simulated time.

* You can not cross between these Zones.

* Your test code should not depend on asynchronicity in your Widget tree.

* Use tester.pump and **tester.pumpAndSettle** to trigger frames and ensure that animations have completed.

## Best practices

* Use driver tests for integration testing

* Put them in a driver_test/ directory. These are time-intensive and expensive, and this allows you to only run them when needed.

* Use goldens tests to prevent regressions in your layouts and widget appearance.

* Put them in a separate directory within test/(or outside of it). Run them only when you mean too. Use — update-goldens to capture intended changes.

* Don’t depend on HTTP calls, file loading, images, and other sources of asynchronicity in Widget Tests.

* If you can’t escape **AssetImage** loading, use a **TestAssetBundle**. Let us know in the comments if you’d like to see this in a pub package.

With these tools in hand, you should be ready to start adding more test coverage to your Flutter Application. Happy Fluttering!
