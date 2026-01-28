---
title: IconData class marked as final
description: >-
  The IconData class is now marked as final, preventing it from being
  extended or implemented.
---

{% render "docs/breaking-changes.md" %}

## Summary

The `IconData` class is now marked as `final`, which prevents it from being
implemented or extended. This change is part of an effort to generalize the
mechanism for tree-shaking assets and native code.

## Background

The Flutter team is working on a generalized mechanism to bring tree-shaking of
assets and native code to packages. The existing bespoke Icon Tree Shaker is
being folded into this general mechanism.

For performance, locality, and understandability, the general mechanism doesn't
support recording `const` instances in complex type hierarchies. Therefore,
the `IconData` class is now marked as `final`.

Code that implements or extends `IconData` fails to compile with an error like:
`The class 'IconData' is 'final' and can't be extended or implemented outside of its library.`

## Migration guide

Instead of implementing `IconData` (for example, using an `enum` to get dot
shorthands, type safety, and an automated `.values` list), use a wrapper class
with `static const` instances.

### Migrating custom icon types

If you used an `enum` that implements `IconData`, migrate to a class with
`static const` instances and a custom widget.

Code before migration:

```dart
enum AppIcons implements IconData {
  arrowUpward(0xe062),
  arrowDownward(0xe061);

  const AppIcons(this.codePoint)
    : fontFamily = 'MaterialIcons',
      fontPackage = null,
      matchTextDirection = false;

  @override
  final int codePoint;
  @override
  final String? fontFamily;
  @override
  final String? fontPackage;
  @override
  final bool matchTextDirection;
}

// Usage
Widget build(BuildContext context) {
  return Icon(AppIcons.arrowUpward);
}
```

Code after migration:

To maintain dot shorthand support and type safety, use a wrapper class and a
custom widget:

```dart
final class AppIconData {
  final IconData iconData;

  const AppIconData._(this.iconData);

  static const arrowUpward = AppIconData._(
    IconData(0xe062, fontFamily: 'MaterialIcons'),
  );
  static const arrowDownward = AppIconData._(
    IconData(0xe061, fontFamily: 'MaterialIcons'),
  );

  static const values = [arrowUpward, arrowDownward];
}

class AppIcon extends StatelessWidget {
  const AppIcon(this.icon, {super.key});
  final AppIconData icon;

  @override
  Widget build(BuildContext context) {
    return Icon(icon.iconData);
  }
}

// Usage preserves dot shorthand if the type can be inferred
Widget build(BuildContext context) {
  return const AppIcon(AppIconData.arrowUpward);
  // Or if inferred: const AppIcon(.arrowUpward)
}
```

If you rely on `.values` for tools like Widgetbook, you can maintain the
`values` list manually as shown above or use code generation.

### Ignoring the mustBeConst lint

To enable tree-shaking, some `IconData` parameters might be marked with the
`mustBeConst` annotation. If you must use a non-const `IconData` and are
willing to forego tree-shaking for that icon, ignore the lint.

```dart
// ignore: non_const_argument_for_const_parameter
Icon(myDynamicIconData);
```

## Timeline

Change landed in version: Not yet<br>
In stable release: Not yet

## References

Relevant issues:

* [Issue 181342][]
* [Issue 181344][]

[Issue 181342]: {{site.repo.flutter}}/issues/181342
[Issue 181344]: {{site.repo.flutter}}/issues/181344
