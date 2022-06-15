---
title: Default `PrimaryScrollController` on Desktop
description: The `PrimaryScrollController` will no longer attach to vertical `ScrollView`s automatically on Desktop.
---

## Summary

The `PrimaryScrollController` API has been updated to no longer automatically
attach to vertical `ScrollView`s on desktop platforms.

## Context

Prior to this change, `ScrollView.primary` would default to true if a
`ScrollView` had an `Axis.vertical` scroll direction and a `ScrollController`
had not already been provided. This allowed for common UI patterns, like the
scroll-to-top function on iOS to work out of the box for Flutter apps.
On desktop however, this default would often cause the following assertion error:

```
ScrollController attached to multiple ScrollViews.
```

While it is common for a mobile application to display one `ScrollView` at a time,
desktop UI patterns are more likely to display multiple `ScrollView`s
side-by-side. The prior implementation of `PrimaryScrollController` conflicted
with this pattern, resulting in an often unhelpful error message. To remedy this,
the `PrimaryScrollController` has been updated with additional parameters as
well as better error messaging across multiple widgets that depend on it.

## Description of change

The previous implementation of `ScrollView` resulted in `primary` being true by
default for all vertical `ScrollView`s that did not already have a
`ScrollController`, on all platforms. This default behavior was not always clear,
particularly because it is separate from the `PrimaryScrollController` itself.

<!-- skip -->
```dart
// Previously, this ListView would always result in primary being true,
// and attached to the PrimaryScrollController on all platforms.
Scaffold(
  body: ListView.builder(
    itemBuilder: (BuildContext context, int index) {
      return Text('Item $index');
    }
  ),
);
```

The implementation changes `ScrollView.primary` to be nullable, with the fallback
decision-making being relocated to the `PrimaryScrollController`.
When `primary` is null, and no `ScrollController` has been provided, the `ScrollView`
will look up the `PrimaryScrollController` and instead calls `shouldInherit` to
determine if the given `ScrollView` should use the `PrimaryScrollController`.

The new members of the `PrimaryScrollController` class,
`automaticallyInheritForPlatforms`, and `scrollDirection` are evaluated in
`shouldInherit`, allowing users clarity and control over the
`PrimaryScrollController`'s behavior.

By default, backwards compatibility is maintained for mobile platforms.
`PrimaryScrollController.shouldInherit` will return true for vertical
`ScrollView`s. On desktop, this will return false by default.

<!-- skip -->
```dart
// Only on mobile platforms will this attach to the PrimaryScrollController by
// default.
Scaffold(
  body: ListView.builder(
    itemBuilder: (BuildContext context, int index) {
      return Text('Item $index');
    }
  ),
);
```

To change the default, users can set `ScrollView.primary` true or false to
explicitly manage the `PrimaryScrollController` for an individual `ScrollView`.
For behavior across multiple `ScrollView`s, the `PrimaryScrollController` is now
configurable by setting the specific platform, as well as the scroll direction
that is preferred for inheritance.

Widgets that use the `PrimaryScrollController` such as the `NestedScrollView`,
`Scrollbar`, and `DropdownMenuButton` will experience no change to existing
functionality. Features like the iOS scroll-to-top will also continue to work as
expected without any migration.

`ScrollAction`s, and `ScrollIntent`s on desktop are the only classes affected by
this change, requiring migration. By default, the `PrimaryScrollController` is
used to execute fallback keyboard scrolling `Shortcuts` if the current `Focus` is
contained within a `Scrollable`. Since displaying more than one `ScrollView`
side-by-side is common on desktop platforms, it is not possible for
Flutter to decide "Which `ScrollView` should be primary in this view and receive
the keyboard scroll action?"

If more than one `ScrollVie`w were present previous to this change, the same
assertion (`ScrollController attached to multiple ScrollViews.`) would be thrown.
Now, on desktop platforms, users will need to specify `primary: true` to
designate which `ScrollView` is the fallback to receive unhandled keyboard
`Shortcuts`.

## Migration guide

Code before migration:

<!-- skip -->
```dart
// These side-by-side ListViews would throw errors from Scrollbars and
// ScrollActions previously due to the PrimaryScrollController.
Scaffold(
  body: LayoutBuilder(
    builder: (context, constraints) {
      return Row(
        children: [
          SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth / 2,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Text('List 1 - Item $index');
              }
            ),
          ),
          SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth / 2,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Text('List 2 - Item $index');
              }
            ),
          ),
        ]
      );
    },
  ),
);
```

Code after migration:

<!-- skip -->
```dart
// These side-by-side ListViews will no longer throw errors, but for
// default ScrollActions, one will need to be designated as primary.
Scaffold(
  body: LayoutBuilder(
    builder: (context, constraints) {
      return Row(
        children: [
          SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth / 2,
            child: ListView.builder(
              // This ScrollView will use the PrimaryScrollController
              primary: true,
              itemBuilder: (BuildContext context, int index) {
                return Text('List 1 - Item $index');
              }
            ),
          ),
          SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth / 2,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Text('List 2 - Item $index');
              }
            ),
          ),
        ]
      );
    },
  ),
);
```

## Timeline

Landed in version: TBD<br>
In stable release: TBD

## References

API documentation:
* [`PrimaryScrollController`][]
* [`ScrollView`][]
* [`ScrollAction`][]
* [`ScrollIntent`][]
* [`Scrollbar`][]

Design Document
* [Updating PrimaryScrollController][]

Relevant issues:
* [Issue #100264][]

Relevant PRs:
* [Updating PrimaryScrollController for Desktop][]

[`PrimaryScrollController`]: {{site.api}}/flutter/widgets/PrimaryScrollController-class.html
[`ScrollView`]: {{site.api}}/flutter/widgets/ScrollView-class.html
[`ScrollAction`]: {{site.api}}/flutter/widgets/ScrollAction-class.html
[`ScrollIntent`]: {{site.api}}/flutter/widgets/ScrollIntent-class.html
[`Scrollbar`]: {{site.api}}/flutter/material/Scrollbar-class.html
[Updating PrimaryScrollController]: https://docs.google.com/document/d/12OQx7h8UQzzAi0Kxh-saDC2dg7h2fghCCzwJ0ysPmZE/edit?usp=sharing&resourcekey=0-ATO-1Er3HO2HITm59I0IdA
[Issue #100264]: {{site.repo.flutter}}/issues/100264
[Updating PrimaryScrollController for Desktop]: {{site.repo.flutter}}/pull/102099
