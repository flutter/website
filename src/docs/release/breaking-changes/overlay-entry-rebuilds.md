---
title: Rebuild optimization for OverlayEntries and Routes
description: OverlayEntries will only rebuild on explicit state changes.
---

## Summary

This  optimization improves performance for route transitions, but it may
uncover missing calls to `setState` in your app.

## Context

Prior to this change an `OverlayEntry` would rebuild when a new opaque entry
was added on top of it or removed above it. These rebuilds were unnecessary
because they were not triggered by a change in state of the affected
`OverlayEntry`. This change optimizes how we handle the addition and removal of
`OverlayEntry`s and removes the unnecessary rebuilds to improve performance.

Since the Navigator internally puts each `Route` into an `OverlayEntry` this
change also applies to `Route` transitions: If an opaque `Route` is pushed on
top or removed from above another `Route`, the `Route`s below the opaque `Route`
no longer rebuild unnecessarily.

## Description of change

In most cases, this change is not expected to require any changes to user code.
However, if your app was erroneously relying on the implicit rebuilds you may
see issues, which can be resolved by wrapping any state change in a `setState`
call.

Furthermore, the change slightly modifies the shape of the widget tree: Prior
to this change, the `OverlayEntry`s were wrapped in a `Stack` widget. The
explicit `Stack` widget has been removed from the widget hierarchy.

## Migration guide

If you're seeing issues after upgrading to a Flutter version that includes this
change, audit your code for missing calls to `setState`. In the example below
assigning the return value of `Navigator.pushNamed` to `buttonLabel` is
implicitly modifying the state and it should be wrapped in an explicit
`setState` call.

Code before migration:

<!-- skip -->
```dart
class FooState extends State<Foo> {
  String buttonLabel = 'Click Me';
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () async {
        // Illegal state modification that should be wrapped in setState.
        buttonLabel = await Navigator.pushNamed(context, '/bar');
      },
      child: Text(buttonLabel),
    );
  }
}
```

Code after migration:

<!-- skip -->
```dart
class FooState extends State<Foo> {
  String buttonLabel = 'Click Me';
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () async {
        final newLabel = await Navigator.pushNamed(context, '/bar');
        setState(() {
          buttonLabel = newLabel;
        });
      },
      child: Text(buttonLabel),
    );
  }
}
```

## Timeline

This change was made in January of 2020 after the v1.14.3 release.

## References

API documentation:
* [`setState`]
* [`OverlayEntry`]
* [`Overlay`]
* [`Navigator`]
* [`Route`]
* [`OverlayRoute`]

Relevant issues:
* [Issue 45797]

Relevant PRs:
* [Do not rebuild Routes when a new opaque Route is pushed on top]
* [Reland "Do not rebuild Routes when a new opaque Route is pushed on top"]

[`OverlayEntry`]: {{site.api}}/flutter/widgets/OverlayEntry-class.html
[`Overlay`]: {{site.api}}/flutter/widgets/Overlay-class.html
[`Navigator`]: {{site.api}}/flutter/widgets/Navigator-class.html
[`Route`]: {{site.api}}/flutter/widgets/Route-class.html
[`OverlayRoute`]: {{site.api}}/flutter/widgets/OverlayRoute-class.html
[`setState`]: {{site.api}}/flutter/widgets/State/setState.html
[Issue 45797]: {{site.github}}/flutter/flutter/issues/45797
[Do not rebuild Routes when a new opaque Route is pushed on top]: {{site.github}}/flutter/flutter/pull/48900
[Reland "Do not rebuild Routes when a new opaque Route is pushed on top"]: {{site.github}}/flutter/flutter/pull/49376
