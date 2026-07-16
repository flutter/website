---
title: "Building performant Flutter widgets"
description: "This article is part of a series developed after the Flutter Material team worked on making the Flutter Gallery app more performant on the…"
publishDate: 2020-07-23
author: guidez
image: images/0GWFHSeCrjUgPdkJ-.webp
category: tutorial
layout: blog
---

*This article is part of a series developed after the Flutter Material team worked on making the Flutter Gallery app more performant on the web. However, the tips in this article apply to **all** Flutter applications. Skip to the end to find the other articles in this series.*

By [Anthony Robledo](https://medium.com/@clocksmith) & [Pierre-Louis Guidez](https://medium.com/@guidez)

<DashImage figure src="images/0GWFHSeCrjUgPdkJ-.webp" />

All stateless and stateful widgets implement `build()` methods that define how they’re rendered. A screen on an app can have hundreds or even thousands of widgets. These widgets may get built only once, or multiple times if there is an animation or some kind of interaction. While building widgets is relatively fast in Flutter, you must be vigilant in when and what you choose to build.

This article talks about building only what you need and only when you need it. Then we share how we used this approach to achieve a significant performance improvement in the Flutter Gallery web app. We’ll also share pro tips on how you can diagnose similar problems in your web app.

## Only build when necessary

One important optimization is to build widgets only when it’s absolutely necessary.

### Call `setState()` judiciously

Calling `setState` schedules a `build()` method to be called. Doing this too often can slow down the performance of a screen.

Consider the following animation, where the display of the front (the black screen) is animated to slide down to reveal the back (the checkerboard), similar to how a [bottom sheet](https://material.io/components/sheets-bottom) might behave. The front widget is simple, but the back widget is busy:

<DashImage figure src="images/0Bm6-mK_lPlO1deUS.webp" alt="A smooth animation" caption="A smooth animation" />

```dart
Stack(
   children: [
     Back(),
     PositionedTransition(
       rect: RelativeRectTween(
         begin: RelativeRect.fromLTRB(0, 0, 0, 0),
         end: RelativeRect.fromLTRB(0, MediaQuery.of(context).size.height, 0, 0),
       ).animate(_animationController),
       child: Front(),
     )
   ],
 ),
```

You might be tempted to set up the parent widget as follows, but in this scenario, this is wrong!

```dart
// BAD CODE
@override
void initState() {
 super.initState();
 _animationController = AnimationController(
   duration: Duration(seconds: 3),
   vsync: this,
 );
 _animationController.addListener(() {
   setState(() {
     // Rebuild when animation ticks.
   });
 });
}
```

This is not performant! Why not?

Because the animation is doing unnecessary work.

<DashImage figure src="images/0Q4WC3xmG1iRG1-lp.webp" alt="A janky animation" caption="A janky animation" />

Here is the problematic code:

```dart
// BAD CODE
_animationController.addListener(() {
 setState(() {
   // Rebuild when animation ticks.
 });
});
```

* This style of animation is recommended when you need to animate the entire widget, but that is not what we are doing here.

* Calling `setState()` in the animation listener causes the entire `Stack` to be rebuilt, which is not necessary!

* The `PositionedTransition` widget is already an `AnimatedWidget`, so it rebuilds *automatically* when the animation ticks.

* Calling `setState()` is actually not needed here!

<DashImage figure src="images/0Zl3QkQlHJMoDkDQj.webp" />

Even though the back widget is busy, it can animate smoothly at 60 FPS. For more on calling setState judiciously, see [Flutter Laggy Animations: How Not To setState](https://medium.com/flutter-community/flutter-laggy-animations-how-not-to-setstate-f2dd9873b8fc).

## Only build *what* is necessary

In addition to only building when it’s required, you want to build only the portion of the UI that actually changes. The following section focuses on creating performant lists.

### Prefer ListView.builder()

First, let’s briefly cover the basics of displaying lists.

1. To layout list items vertically, use a `Column`.

1. If the list should be scrollable, use a `ListView` instead.

1. If the list contains many items, use the `ListView.builder` constructor, which creates items as they scroll onto the screen instead of all at once. This has obvious performance benefits for complex list items and deep widget subtrees.

To illustrate the benefits of `ListView.builder` over `ListView` when you have a large number of list items, let’s look at a couple of examples.

Run the following `ListView` [example in DartPad](https://dartpad.dev/e41ed2678b9b9d7347880c20ec49f3f2). Observe that all 8 items are created. (Click **Console** in the lower left to display the console, and then click **Run**. The output window has no scrollbar, but you can scroll the content and observe the console to see what is created and built when.)

```dart
ListView(
  children: [
    _ListItem(index: 0),
    _ListItem(index: 1),
    _ListItem(index: 2),
    _ListItem(index: 3),
    _ListItem(index: 4),
    _ListItem(index: 5),
    _ListItem(index: 6),
    _ListItem(index: 7),
  ],
);
```

Next, run the `ListView.builder` [example in DartPad](https://dartpad.dev/1ae687f1c0d17eb80c8e28a70fb5b8d1). Observe that only the visible items are created. As you scroll, it creates (and builds) new rows.

```dart
ListView.builder(
  itemBuilder: (context, index) {
    return _ListItem(index: index);
  },
  itemCount: 8,
);
```

Now, run the [example in DartPad](https://dartpad.dev/a338a69afea04f746015861cd55782db) where `ListView`’s children are created in advance, all at once when the `ListView` itself is created. In this scenario, it’s more efficient to use the `ListView` constructor.

```dart
final listItems = [
  _ListItem(index: 0),
  _ListItem(index: 1),
  _ListItem(index: 2),
  _ListItem(index: 3),
  _ListItem(index: 4),
  _ListItem(index: 5),
  _ListItem(index: 6),
  _ListItem(index: 7),
];

@override
Widget build(BuildContext context) {
  // This offers no benefit, it is actually more efficient to use the ListView constructor instead.
  return ListView.builder(
    itemBuilder: (context, index) {
      return listItems[index];
    },
    itemCount: 8,
  );
}
```

For more on lazily building lists, see [Slivers, Demystified](https://medium.com/flutter/slivers-demystified-6ff68ab0296f).

## How we improved the Flutter Gallery web page render time by more than 2x with a single line of code

The Flutter Gallery supports over 100 locales; Those locales are listed using — you guessed it — a `ListView.builder`. By obtaining widget rebuild information, we noticed these list items were being built unnecessarily on startup. It was not obvious that these items were the culprit since they were in two levels of collapsed menus: the settings panel itself, and the locale expansion tile (as it turns out, the settings panel was rendered ‘invisible’ using a `ScaleTransition`, meaning it was very much being built).

<DashImage figure src="images/0RtYWMsCJ83boCm6h.webp" alt="Flutter Gallery settings panel with the locale options expanded" caption="Flutter Gallery settings panel with the locale options expanded" />

By simply setting `ListView.builder`’s `itemCount` to 0 for non-expanded setting categories, we ensured that list items are only built for the expanded, visible category. The [one-line PR](https://github.com/flutter/gallery/pull/109/files) that resolved this issue improved render time on the web by more than 2x. The key was to identify excessive widget building.

## Seeing widget build counts for your application

While Flutter builds very efficiently, there are some cases where building excessively can cause performance issues. There are a few ways to identify excessive widget rebuilding.

### By using Android Studio/IntelliJ

Android Studio and IntelliJ developers can use built-in tooling to [show Widget rebuild information](https://flutter.dev/docs/development/tools/android-studio#show-performance-data).

### By modifying the framework

If you use a different editor, or would like to know widget rebuild information for the web, you can do so by adding a bit of code to the framework.

Sample output:

```plaintext
RaisedButton 1
RawMaterialButton 2
ExpensiveWidget 538
Header 5
```

Locate `<Flutter path>/packages/flutter/lib/src/widgets/framework.dart`. Add the following code, which counts the number of times widgets are built at startup, and outputs the results after some duration (here, 10 seconds).

```dart
bool _outputScheduled = false;
Map<String, int> _outputMap = <String, int>{};
void _output(Widget widget) {
  final String typeName = widget.runtimeType.toString();
  if (_outputMap.containsKey(typeName)) {
    _outputMap[typeName] = _outputMap[typeName] + 1;
  } else {
    _outputMap[typeName] = 1;
  }
  if (_outputScheduled) {
    return;
  }
  _outputScheduled = true;
  Timer(const Duration(seconds: 10), () {
    _outputMap.forEach((String key, int value) {
      switch (widget.runtimeType.toString()) {
        // Filter out widgets whose build counts we don't care about
        case 'InkWell':
        case 'RawGestureDetector':
        case 'FocusScope':
          break;
        default:
          print('$key $value');
      }
    });
  });
}
```

Then, modify the `build` methods for `StatelessElement` and `StatefulElement` to call `_output(widget)`.

```dart
class StatelessElement extends ComponentElement {
  ...

@override
  Widget build() {
    final Widget w = widget.build(this);
    _output(w);
    return w;
   }

class StatefulElement extends ComponentElement {
...

@override
  Widget build() {
    final Widget w = _state.build(this);
    _output(w);
    return w;
  }
```

See the resulting [framework.dart](https://gist.github.com/guidezpl/54f9a03b0adbf207153178dba0bf214c) file.

Note that numerous rebuilds doesn’t necessarily indicate a problem. However, it can help debug performance issues by verifying that non-visible widgets aren’t being built, for example.

**Tip for web only**: you can add a `resetOutput` function (that can be called from a browser’s developer tools) to obtain widget build counts at any point in time.

```dart
import 'dart:js' as js;

void resetOutput() {
 _outputScheduled = false;
 _outputMap = <String, int>{};
}

void _output(Widget widget) {
  // Add this line
  js.context['resetOutput'] = resetOutput;
  ...
```

See the resulting [framework.dart](https://gist.github.com/guidezpl/32518a6d22596393fa368c28e8f0ece4) file.

## Closing Remarks

Effective performance debugging requires understanding what’s happening under the hood. These tips can help decide how to implement your next build method so that your app stays performant in all scenarios.

This post is a part of a series about what we learned when improving performance for the Flutter Gallery. Articles in the *Creating performant Flutter web apps* series:

* [Optimizing performance in Flutter web apps with tree shaking and deferred loading](https://medium.com/flutter/optimizing-performance-in-flutter-web-apps-with-tree-shaking-and-deferred-loading-535fbe3cd674)

* [Improving perceived performance with image placeholders, precaching, and disabled navigation transitions](https://medium.com/flutter/improving-perceived-performance-with-image-placeholders-precaching-and-disabled-navigation-6b3601087a2b)

* Building performant Flutter widgets (this article)

For more general information, the Flutter [docs on UI performance](https://flutter.dev/docs/perf/rendering/ui-performance) are a great place for developers of all levels to start.

Thanks to Shams Zakhour for editing this article and Ferhat Buyukkokten for debugging tips.
