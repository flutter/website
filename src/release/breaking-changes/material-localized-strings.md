---
title: Migration guide for material localized strings
description: >
  ReorderableListView's localized strings are moved from
  material localizations to widgets localizations.
---

## Summary

`ReorderableListView`'s localized strings were moved from
material localizations to widgets localizations.
These strings were deprecated in material localizations.

## Context

[`ReorderableListView`][] uses these strings to annotate its semantics actions.
To apply the same annotations to [`ReorderableList`][]
and [`SliverReorderableList`][], they need to
access these strings from widgets library.

## Description of change

The [`MaterialLocalizations`][] strings for
`reorderItemToStart`, `reorderItemToEnd`, `reorderItemUp`,
`reorderItemDown`, `reorderItemLeft`, and `reorderItemRight` are deprecated and
replaced by the same strings in [`WidgetsLocalizations`][].

## Migration guide

If you use these strings in your code,
you can access them from `WidgetsLocalizations`instead.

Code before migration:

```dart
MaterialLocalizations.of(context).reorderItemToStart;
```

Code after migration:

```dart
WidgetsLocalizations.of(context).reorderItemToStart;
```

If you override `MaterialLocalizations` or `WidgetsLocalizations`,
make sure to remove the translations from the `MaterialLocalizations`
subclass and move them to the `WidgetsLocalizations` subclass.

Code before migration:

```dart
class MaterialLocalizationsMyLanguage extends MaterialLocalizationsEn {
  // ...
  @override
  String get reorderItemRight => 'my translation';
}
```

Code after migration:

```dart
class MaterialLocalizationsMyLanguage extends MaterialLocalizationsEn {
  // ...
}

class WidgetsLocalizationsMyLanguage extends WidgetsLocalizationsEn {
  // ...
  @override
  String get reorderItemRight => 'my translation';
}
```

## Timeline

Landed in version: v3.10.0-2.0.pre
In stable release: TBD

## References

Relevant PR:

* [PR 124711][]: Deprecates string for
  ReorderableList in material_localizations.

[PR 124711]: {{site.repo.flutter}}/pull/124711
[`ReorderableListView`]: {{site.api}}/flutter/material/ReorderableListView-class.html
[`ReorderableList`]: {{site.api}}/flutter/widgets/ReorderableList-class.html
[`SliverReorderableList`]: {{site.api}}/flutter/widgets/SliverReorderableList-class.html
[`MaterialLocalizations`]: {{site.api}}/flutter/material/MaterialLocalizations-class.html
[`WidgetsLocalizations`]: {{site.api}}/flutter/widgets/WidgetsLocalizations-class.html
