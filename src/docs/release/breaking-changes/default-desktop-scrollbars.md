---
title: Default Scrollbars on Desktop
description: ScrollBehaviors will now automatically build Scrollbars on Desktop platforms.
---

## Summary

`ScrollBehavior`s now automatically apply `Scrollbar`s to
scrolling widgets on desktop platforms - Mac, Windows and Linux.

## Context

Prior to this change, `Scrollbar`s were applied to scrolling widgets
manually by the developer across all platforms. This did not match
developer expectations when executing Flutter applications on desktop platforms.

Now, the inherited `ScrollBehavior` applies a `Scrollbar` automatically
to most scrolling widgets. This is similar to how `GlowingOverscrollIndicator`
is created by `ScrollBehavior`. The few widgets that are exempt from this
behavior are listed below.

To provide better management and control of this feature, `ScrollBehavior`
has also been updated. The `buildViewportChrome` method, which applied
a `GlowingOverscrollIndicator`, has been deprecated. Instead, `ScrollBehavior`
now supports individual methods for decorating the viewport, `buildScrollbar`
and `buildOverscrollIndicator`. These methods can be overridden to control
what is built around the scrollable.

Further more, `ScrollBehavior` subclasses `MaterialScrollBehavior` and
`CupertinoScrollBehavior` have been made public, allowing developers to extend
and build upon the other existing `ScrollBehavior`s in the framework. These
subclasses were previously private. 


## Description of change

The previous approach called on developers to create their own `Scrollbar`s on
all platforms. In some use cases, a `ScrollController` would need to be provided
to the `Scrollbar` and the scrollable widget.

<!-- skip -->
```dart
final ScrollController controller = ScrollController();
Scrollbar(
  controller: controller,
  child: ListView.builder(
    controller: controller,
    itemBuilder: (BuildContext context, int index) {
      return Text('Item $index');
    }
  )
);
```

The `ScrollBehavior` now applies the `Scrollbar` automatically
when executing on desktop, and handles providing the `ScrollController`
to the `Scrollbar` for you.

<!-- skip -->
```dart
final ScrollController controller = ScrollController();
ListView.builder(
  controller: controller,
  itemBuilder: (BuildContext context, int index) {
   return Text('Item $index');
 }
);
```

Some widgets in the framework are exempt from this automatic `Scrollbar` application. They
are:
- `EditableText`, when `maxLines` is 1.
- `ListWheelScrollView`
- `PageView`
- `NestedScrollView`

Since these widgets manually override the inherited `ScrollBehavior`
to remove `Scrollbar`s, all of these widgets now have a `scrollBehavior`
parameter so that one can be provided to use instead of the override.

This change did not cause any test failures, crashes, or error messages
in the course of development, but it may result in two `Scrollbar`s
being rendered in your application if you are manually adding `Scrollbar`s
on desktop platforms.

If you are seeing this in your application, there are several ways to
control and configure this feature.

- Remove the manually applied `Scrollbar`s in your application when running on desktop.

- Extend `ScrollBehavior`, `MaterialScrollBehavior`, or `CupertinoScrollBehavior`
to modify the default behavior.
  
    - With your own `ScrollBehavior`, you can apply it app-wide by setting
      `MaterialApp.scrollBehavior` or `CupertinoApp.scrollBehavior`.
    - Or, if you wish to only apply it to specific widgets, add a
      `ScrollConfiguration` above the widget in question with your
      custom `ScrollBehavior`.
      
Your scrollable widgets then inherits this and reflects this behavior.

- Instead of creating your own `ScrollBehavior`, another option for changing
the default behavior is to copy the existing `ScrollBehavior`, and toggle the
desired feature.

    - Create a `ScrollConfiguration` in your widget tree, and provide a modified copy
      of the existing `ScrollBehavior` in the current context using `copyWith`.

## Migration guide

### Removing manual `Scrollbar`s on desktop
Code before migration:

<!-- skip -->
```dart
final ScrollController controller = ScrollController();
Scrollbar(
  controller: controller,
  child: ListView.builder(
    controller: controller,
    itemBuilder: (BuildContext context, int index) {
      return Text('Item $index');
    }
  )
);
```

Code after migration:

<!-- skip -->
```dart
final ScrollController controller = ScrollController();
final Widget child = ListView.builder(
  controller: controller,
  itemBuilder: (BuildContext context, int index) {
    return Text('Item $index');
  }
);
// Only manually add a `Scrollbar` when not on desktop platforms.
// Or, see other migrations for changing `ScrollBehavior`.
switch (currentPlatform) {
  case TargetPlatform.linux:
  case TargetPlatform.macOS:
  case TargetPlatform.windows:
    return child;
  case TargetPlatform.android:
  case TargetPlatform.fuchsia:
  case TargetPlatform.iOS:
    return Scrollbar(
      controller: controller,
      child: child;
    );
}
```

### Setting a custom `ScrollBehavior` for your application
Code before migration:

<!-- skip -->
```dart
// MaterialApps previously had a private ScrollBehavior.
MaterialApp(
  // ...
);
```

Code after migration:

<!-- skip -->
```dart
// MaterialApps previously had a private ScrollBehavior.
// This is available to extend now.
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods like buildOverscrollIndicator and buildScrollbar
}

// ScrollBehavior can now be configured for an entire application.
MaterialApp(
  scrollBehavior: MyCustomScrollBehavior(),
  // ...
);
```

### Setting a custom `ScrollBehavior` for a specific widget
Code before migration:

<!-- skip -->
```dart
final ScrollController controller = ScrollController();
ListView.builder(
  controller: controller,
  itemBuilder: (BuildContext context, int index) {
   return Text('Item $index');
 }
);
```

Code after migration:

<!-- skip -->
```dart
// MaterialApps previously had a private ScrollBehavior.
// This is available to extend now.
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods like buildOverscrollIndicator and buildScrollbar
}

// ScrollBehavior can be set for a specific widget.
final ScrollController controller = ScrollController();
ScrollConfiguration(
  behavior: MyCustomScrollBehavior(),
  child: ListView.builder(
    controller: controller,
    itemBuilder: (BuildContext context, int index) {
     return Text('Item $index');
    }
  ),
);
```

### Copy and modify existing `ScrollBehavior`
Code before migration:

<!-- skip -->
```dart
final ScrollController controller = ScrollController();
ListView.builder(
  controller: controller,
  itemBuilder: (BuildContext context, int index) {
   return Text('Item $index');
 }
);
```

Code after migration:

<!-- skip -->
```dart
// ScrollBehavior can be copied and adjusted.
final ScrollController controller = ScrollController();
ScrollConfiguration(
  behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
  child: ListView.builder(
    controller: controller,
    itemBuilder: (BuildContext context, int index) {
     return Text('Item $index');
    }
  ),
);
```

## Timeline

Landed in version: 2.2.0-10.0.pre<br>
In stable release: 2.2.0

## References

API documentation:
* [`ScrollConfiguration`][]
* [`ScrollBehavior`][]
* [`MaterialScrollBehavior`][]
* [`CupertinoScrollBehavior`][]
* [`Scrollbar`][]
* [`CupertinoScrollbar`][]

Relevant issues:
* [Issue #40107][]
* [Issue #70866][]

Relevant PRs:
* [Exposing ScrollBehaviors for app-wide settings][]
* [Automatically applying Scrollbars on desktop platforms with configurable ScrollBehaviors][]


[`ScrollConfiguration`]: https://master-api.flutter.dev/flutter/widgets/ScrollConfiguration-class.html
[`ScrollBehavior`]: https://master-api.flutter.dev/flutter/widgets/ScrollBehavior-class.html
[`MaterialScrollBehavior`]: https://master-api.flutter.dev/flutter/material/MaterialScrollBehavior-class.html
[`CupertinoScrollBehavior`]: https://master-api.flutter.dev/flutter/cupertino/CupertinoScrollBehavior-class.html
[`Scrollbar`]: https://master-api.flutter.dev/flutter/material/Scrollbar-class.html
[`CupertinoScrollbar`]: https://master-api.flutter.dev/flutter/cupertino/CupertinoScrollbar-class.html
[Issue #40107]: {{site.github}}/flutter/flutter/issues/40107
[Issue #70866]: {{site.github}}/flutter/flutter/issues/70866
[Exposing ScrollBehaviors for app-wide settings]: {{site.github}}/flutter/flutter/pull/76739
[Automatically applying Scrollbars on desktop platforms with configurable ScrollBehaviors]: {{site.github}}/flutter/flutter/pull/78588
