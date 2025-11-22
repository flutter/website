---
title: Default Scrollbars on Android
description: >
  MaterialScrollBehavior will now automatically build Scrollbars on Android.
---

{% render "docs/breaking-changes.md" %}

## Summary

`MaterialScrollBehavior` will now automatically apply a `Scrollbar` to
scrolling widgets on Android.

## Context

Prior to this change, `Scrollbar`s were only applied automatically to
scrolling widgets on desktop platforms - Mac, Windows and Linux. On all
other platforms, a `Scrollbar` could only be applied manually by the
developer, including Android. This does not match Android's default
behavior for scrollable `View`s nor its quality guidelines for running
on large screens; see [Large Screen Quality Guideline T1-10][].

Now, `MaterialScrollBehavior`, the default `ScrollBehavior` for all
`MaterialApp`s, applies a `Scrollbar` automatically to most scrolling
widgets. This is similar to how the inherited `ScrollBehavior`
automatically applies a `Scrollbar` on all desktop platforms. The few
widgets that are exempt from this behavior are listed below.

## Description of change

The previous approach called on developers to create their own `Scrollbar`s
on all non-desktop platforms, including Android. In some use cases, a
`ScrollController` would need to be provided to the `Scrollbar` and
the scrollable widget.

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

Now, you can specify a `ScrollConfiguration` with the `MaterialScrollBehavior`
scroll behavior to build a `Scrollbar` automatically on Android:

```dart
WidgetsApp(
  builder: (context, child) {
    return ScrollConfiguration(
      behavior: MaterialScrollBehavior(),
      child: ListView.builder(
        controller: controller,
        itemBuilder: (BuildContext context, int index) {
          return Text('Item $index');
        },
      ),
    );
  },
);
```

`MaterialScrollBehavior`, the scroll behavior that `MaterialApp` applies by default,
now applies a `Scrollbar` automatically when executing on Android,
and handles providing the `ScrollController` to the `Scrollbar`
for you.

```dart
final ScrollController controller = ScrollController();

MaterialApp(
home: ListView.builder(
    controller: controller,
    itemBuilder: (BuildContext context, int index) {
    return Text('Item $index');
    }
  ),
);
```

Some widgets in the framework are exempt from this automatic `Scrollbar`
application. They are:

- `EditableText`, when `maxLines` is 1.
- `ListWheelScrollView`
- `PageView`

Since `MaterialApp` automatically uses `MaterialScrollBehavior`,
you must override the `MaterialApp`'s `scrollBehavior` parameter
to choose a different `ScrollBehavior` or customize the `Scrollbar`
shown. 

This change did not cause any test failures, crashes, or error messages
in the course of development, but it might result in two `Scrollbar`s
being rendered in your application if you are manually adding `Scrollbar`s
on Android.

If you are seeing this in your application, there are several ways to
control and configure this feature.

- Remove the manually applied `Scrollbar`s in your
  application when running on Android.

- Extend `MaterialScrollBehavior` to modify the default behavior.

  - With your own `ScrollBehavior`, you can apply it app-wide by setting
    `MaterialApp.scrollBehavior`.
  - Or, if you wish to only apply it to specific widgets, add a
    `ScrollConfiguration` above the widget in question with your
    custom `ScrollBehavior`.

- Instead of creating your own `ScrollBehavior`, another option for changing
  the default behavior is to copy the existing `ScrollBehavior`, and toggle the
  desired feature.
  - Create a `ScrollConfiguration` in your widget tree, and
    provide a modified copy of the existing `ScrollBehavior` in
    the current context using `copyWith`.

## Migration guide

Before migration, if you are using a `MaterialApp`, you might have some code
that looks like:

```dart
final ScrollController controller = ScrollController();

MaterialApp(
  home: Scrollbar(
    controller: controller,
    child: ListView.builder(
      controller: controller,
      itemBuilder: (BuildContext context, int index) {
        return Text('Item $index');
      }
    )
  )
);
```

See the following strategies for how to migrate this code.

### Removing manual `Scrollbar`s on Android when using `MaterialApp`

Code after migration:

```dart
final ScrollController controller = ScrollController();

final Widget child = ListView.builder(
  controller: controller,
  itemBuilder: (BuildContext context, int index) {
    return Text('Item $index');
  }
);

// Only manually add a `Scrollbar` when not on Android or desktop platforms,
// or see other migrations for changing `ScrollBehavior`.
switch (currentPlatform) {
  case TargetPlatform.linux:
  case TargetPlatform.macOS:
  case TargetPlatform.windows:
  case TargetPlatform.android:
    return child;
  case TargetPlatform.fuchsia:
  case TargetPlatform.iOS:
    return Scrollbar(
      controller: controller,
      child: child;
    );
}

MaterialApp(home: child);
```

### Setting a custom `ScrollBehavior` for your application

Code after migration:

```dart
// Extend any `ScrollBehavior` that you would like.
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods like buildOverscrollIndicator and buildScrollbar.
}

// MyCustomScrollBehavior can now be configured for an entire application.
final ScrollController controller = ScrollController();
MaterialApp(
  scrollBehavior: MyCustomScrollBehavior(),
  home: ListView.builder(
        controller: controller,
        itemBuilder: (BuildContext context, int index) {
          return Text('Item $index');
        }
  )
);
```

### Setting a custom `ScrollBehavior` for a specific widget

Code after migration:

```dart
// Extend any `ScrollBehavior` that you would like.
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods like buildOverscrollIndicator and buildScrollbar.
}


// MyCustomScrollBehavior can be set for a specific widget.
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

Code after migration:

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

Landed in version: 3.40.0-0.1.pre<br>
In stable release: 3.40.0

## References

API documentation:

* [`ScrollConfiguration`][]
* [`ScrollBehavior`][]
* [`MaterialScrollBehavior`][]
* [`Scrollbar`][]

Relevant issues:

* [Issue #170540][]

Relevant PRs:

* [Modify MaterialScrollBehavior to show scrollbar by default][]

[Large Screen Quality Guideline T1-10]: https://developer.android.com/docs/quality-guidelines/large-screen-app-quality#T1-10
[`ScrollConfiguration`]: {{site.api}}/flutter/widgets/ScrollConfiguration-class.html
[`ScrollBehavior`]: {{site.api}}/flutter/widgets/ScrollBehavior-class.html
[`MaterialScrollBehavior`]: {{site.api}}/flutter/material/MaterialScrollBehavior-class.html
[`Scrollbar`]: {{site.api}}/flutter/material/Scrollbar-class.html
[Issue #170540]: {{site.repo.flutter}}/issues/170540
[Modify MaterialScrollBehavior to show scrollbar by default]: {{site.repo.flutter}}/pull/178308
