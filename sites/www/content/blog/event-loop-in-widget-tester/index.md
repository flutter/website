---
title: "Event Loop in Widget Tester"
description: "Flutter’s widget tester is a great way to do unit testing on widgets. It allows you to bring up a headless environment where you can…"
publishDate: 2018-11-14
author: mehmetf
image: images/1ajiMVoQuEXYZ4IJzr-yOQQ.webp
category: announcements
layout: blog
---

Flutter’s widget tester is a great way to perform unit testing on widgets. It allows you to bring up a headless environment where you can assert properties of your widgets, simulate gestures such as tap or fling and easily test their response.

This article takes a closer look at how widget tests manage the [event loop](https://webdev.dartlang.org/articles/performance/event-loop#darts-event-loop-and-queues) and what that means for asynchronous tasks.

## Pump

During my tenure as a Flutter app developer, I have found that most developers do not fully understand what [pump()](https://docs.flutter.io/flutter/flutter_test/TestWidgetsFlutterBinding/pump.html) does other than the fact that they need to call it to make tests pass.

Documentation states that:
> Pump triggers a frame sequence (build/layout/paint/etc), then flushes microtasks.

A microtask is anything that is scheduled for execution in the event loop. Calling pump() repeatedly flushes microtasks and allows new ones to be created.

Say your widget depends on some data store that returns a Future to be resolved. In tests, you typically have a fake store that returns data immediately. That does not change the fact that a Future still is a microtask that needs to be resolved. You will need to call pump to flush these tasks and trigger the build so your widget can be tested.

Without pump, the event flow looks like this:

<DashImage figure src="images/1ajiMVoQuEXYZ4IJzr-yOQQ.webp" alt="Tester flow without pump" caption="Tester flow without pump" />


With pump, you are able to rebuild the widget and the test passes:

<DashImage figure src="images/1hf94gBylm_JwULMwfWFncw.webp" />


You might think calling pump advances the clock because that’s how your widget works in real life. You initiate a data fetch, some time later the Future resolves and your widget displays the data. In reality, pump does not advance the clock. For instance, an animation that has a preset duration will *never* finish just by calling pump.

To solve this problem, you will have to call pump with a *duration*. It flushes microtasks, schedules a frame but also advances the clock by the specified duration. It effectively schedules a new frame, then pretends that all frames were missed until the duration has expired, as if there the system had been too busy to schedule the app for that time. This allows you to jump past animations quickly and is essentially how the *pumpAndSettle* API is implemented.

## FakeAsync

Pump can skip ahead this way because WidgetTester runs in the *FakeAsync zone*. This zone creates a predictable and controllable environment for tests to run. The flip side is that Futures (and async work in general) behave very differently in this zone compared to your real app.

Consider this example:

```dart
import "dart:async";
import "package:flutter_test/flutter_test.dart";

void main() {
  Future future;
  
  setUp(() {
    future = new Future.value();
  });
  
  testWidgets("awaiting future with value from setUp works", (WidgetTester tester) async {
    await future;
  });
}
```

This test never finishes because nobody is calling *pump(Duration)* to advance the time on the awaited future on line 12.

The solution is to use a function called [runAsync](https://docs.flutter.io/flutter/flutter_test/WidgetTester/runAsync.html) to make the async work run outside of the fake zone, which decouples it from the fake test-controlled time flow and lets it run in *real time*.

```dart
import "dart:async";
import "package:flutter_test/flutter_test.dart";

void main() {
  Future future;
  
  setUp(() {
    future = new Future.value();
  });

  testWidgets("awaiting future with value from setUp works", (WidgetTester tester) async {
    await tester.runAsync(() => future);
  });
}
```

While this is a straight-forward example, it becomes more subtle when the application (or even framework) code starts doing async work.

Let’s go over two more examples.

### Snackbar

Imagine that you have written a widget that shows a snackbar with a cancel button when an async operation is ongoing. The user can tap on the cancel button and interrupt the operation. You want to write a test for the cancel button and it should be trivial:

* Create the snackbar widget with some async work

* Simulate the tap on the button

* Check the widget’s state

You might be tempted to code this by defining a *Future.delayed()* for your async work. You soon discover that the test is not working as expected. You see that while the tap simulation on the button is being executed, the tap handler in your widget is never called.

The problem is that Future.delayed() is running inside the fake async zone and waiting for someone to advance the time. Tap events cannot be consumed because the frames are not advancing past the previous operation.

The solution, once again, is to put the work in runAsync so that it can run in real time, let the button consume the tap and trigger the flow user wants to test.
> runAsync makes your async work run in *real time*. If you put a Future.delayed(5 seconds) in there, then your actual test time will be prolonged by 5 ***very real*** seconds.

### Method Channel

Sometimes, FakeAsync bites in even subtler ways. If a framework call awaits on a platform channel, this await cannot be completed even if the native side is trying to send data because the tests run in a fake zone. Unfortunately there is no solution on the application side for this. The framework controlled channels need to be explicitly tracked by the test framework and advanced manually so they can finish. So please file an issue with Flutter if you run into this scenario as we would love to learn more.

## To sum up…

Keep these points in mind:

* If your widget tests involve async operations, any real async work in tests needs to be done in runAsync *including bogus Future.delayed()* constructs.

* Any real async work performed in your widgets *cannot* be tested via widget tests. You need to inject an overridable service so that you can either take over the execution of the async task in the test or provide a synchronous implementation.
