---
title: Default drag scrolling devices
description: ScrollBehaviors will now configure what PointerDeviceKinds can drag Scrollables.
---

## Summary

`ScrollBehavior`s now allow or disallow drag scrolling from specified
`PointerDeviceKind`s. `ScrollBehavior.dragDevices`, by default,
allows scrolling widgets to be dragged by all `PointerDeviceKind`s
except for `PointerDeviceKind.mouse`.

## Context

Prior to this change, all `PointerDeviceKind`s could drag a `Scrollable` widget.
This did not match developer expectations when interacting with Flutter
applications using mouse input devices. This also made it difficult to execute
other mouse gestures, like selecting text that was contained in a `Scrollable` widget.

Now, the inherited `ScrollBehavior` manages which devices can drag scrolling widgets
as specified by `ScrollBehavior.dragDevices`. This set of `PointerDeviceKind`s are
allowed to drag.


## Description of change

This change fixed the unexpected ability to scroll by dragging with a mouse.

If you have relied on the previous behavior in your application, there are several ways to
control and configure this feature.

- Extend `ScrollBehavior`, `MaterialScrollBehavior`, or `CupertinoScrollBehavior`
to modify the default behavior, overriding `ScrollBehavior.dragDevices`.
  
    - With your own `ScrollBehavior`, you can apply it app-wide by setting
      `MaterialApp.scrollBehavior` or `CupertinoApp.scrollBehavior`.
    - Or, if you wish to only apply it to specific widgets, add a
      `ScrollConfiguration` above the widget in question with your
      custom `ScrollBehavior`.
      
Your scrollable widgets then inherit and reflect this behavior.

- Instead of creating your own `ScrollBehavior`, another option for changing
the default behavior is to copy the existing `ScrollBehavior`, and set different
`dragDevices`.

    - Create a `ScrollConfiguration` in your widget tree, and provide a modified copy
      of the existing `ScrollBehavior` in the current context using `copyWith`.
      
To accommodate the new configuration of drag devices in `ScrollBehavior`,
`GestureDetector.kind` has been deprecated along with all subclassed instances of the parameter.
A flutter fix is available to migrate existing code for all gesture detectors from `kind`
to `supportedDevices`. The previous parameter `kind` only allowed one `PointerDeviceKind` to
be used to filter gestures. The introduction of `supportedDevices` makes it possible for more
than one valid `PointerDeviceKind`.

## Migration guide

### Setting a custom `ScrollBehavior` for your application
Code before migration:

<!-- skip -->
```dart
MaterialApp(
  // ...
);
```

Code after migration:

<!-- skip -->
```dart
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => { 
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    // etc.
  };
}

// Set ScrollBehavior for an entire application.
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
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => { 
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    // etc.
  };
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
  behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  }),
  child: ListView.builder(
    controller: controller,
    itemBuilder: (BuildContext context, int index) {
     return Text('Item $index');
    }
  ),
);
```


### Migrate `GestureDetector`s from `kind` to `supportedDevices`
Code before migration:

<!-- skip -->
```dart
VerticalDragGestureRecognizer(
  kind: PointerDeviceKind.touch,
);
```

Code after migration:

<!-- skip -->
```dart
VerticalDragGestureRecognizer(
  supportedDevices: <PointerDeviceKind>{ PointerDeviceKind.touch },
);
```

## Timeline

Landed in version: 2.3.0-12.0.pre<br>
In stable release: not yet

## References

API documentation:
* [`ScrollConfiguration`][]
* [`ScrollBehavior`][]
* [`MaterialScrollBehavior`][]
* [`CupertinoScrollBehavior`][]
* [`PointerDeviceKind`][]
* [`GestureDetector`][]

Relevant issues:
* [Issue #71322][]

Relevant PRs:
* [Reject mouse drags by default in scrollables][]
* [Deprecate GestureDetector.kind in favor of new supportedDevices][]


[`ScrollConfiguration`]: https://master-api.flutter.dev/flutter/widgets/ScrollConfiguration-class.html
[`ScrollBehavior`]: https://master-api.flutter.dev/flutter/widgets/ScrollBehavior-class.html
[`MaterialScrollBehavior`]: https://master-api.flutter.dev/flutter/material/MaterialScrollBehavior-class.html
[`CupertinoScrollBehavior`]: https://master-api.flutter.dev/flutter/cupertino/CupertinoScrollBehavior-class.html
[`PointerDeviceKind`]: https://master-api.flutter.dev/flutter/dart-ui/PointerDeviceKind-class.html
[`GestureDetector`]: https://master-api.flutter.dev/flutter/widgets/GestureDetector-class.html
[Issue #71322]: {{site.github}}/flutter/flutter/issues/71322
[Reject mouse drags by default in scrollables]: {{site.github}}/flutter/flutter/pull/81569
[Deprecate GestureDetector.kind in favor of new supportedDevices]: {{site.github}}/flutter/flutter/pull/81858
