---
title: Deprecated API removed after v3.16
description: >-
  After reaching end of life, the following deprecated APIs
  were removed from Flutter.
---

## Summary

In accordance with Flutter's [Deprecation Policy][],
deprecated APIs that reached end of life after the
3.16 stable release have been removed.

All affected APIs have been compiled into this
primary source to aid in migration.
To further aid your migration, check out this
[quick reference sheet][].

[Deprecation Policy]: {{site.repo.flutter}}/blob/master/docs/contributing/Tree-hygiene.md#deprecations
[quick reference sheet]: /go/deprecations-removed-after-3-16

## Changes

This section lists the deprecations by the package and affected class.

### Button `styleFrom` properties

Package: flutter
Supported by Flutter Fix: yes

The `TextButton`, `ElevatedButton` and `OutlinedButton` widgets all have a
static `styleFrom` method for generating the `ButtonStyle`. The following color
properties of this method for each class were deprecated in v3.1:

* `TextButton.styleFrom`
  * `primary`
  * `onSurface`
* `ElevatedButton.styleFrom`
  * `primary`
  * `onPrimary`
  * `onSurface`
* `OutlinedButton.styleFrom`
  * `primary`
  * `onSurface`

These changes better aligned the API with updated Material Design
specifications. The changes also provided more clarity in how the colors would
be applied to the buttons, by replacing these properties with `backgroundColor`,
`foregroundColor`, and `disabledForegroundColor`.

**Migration guide**

Code before migration:

```dart
TextButton.styleFrom(
  primary: Colors.red,
  onSurface: Colors.black,
);
ElevatedButton.styleFrom(
  primary: Colors.red,
  onPrimary: Colors.blue,
  onSurface: Colors.black,
);
OutlinedButton.styleFrom(
  primary: Colors.red,
  onSurface: Colors.black,
);
```

Code after migration:

```dart
TextButton.styleFrom(
  foregroundColor: Colors.red,
  disabledForegroundColor: Colors.black,
);
ElevatedButton.styleFrom(
  backgroundColor: Colors.red,
  foregroundColor: Colors.blue,
  disabledForegroundColor: Colors.black,
);
OutlinedButton.styleFrom(
  foregroundColor: Colors.red,
  disabledForegroundColor: Colors.black,
);
```

**References**

API documentation:

* [`TextButton`][]
* [`ElevatedButton`][]
* [`OutlinedButton`][]
* [`ButtonStyle`][]

Relevant PRs:

* Deprecated in [#105291][]
* Removed in [#139267][]

[`TextButton`]: {{site.api}}/flutter/material/TextButton-class.html
[`ElevatedButton`]: {{site.api}}/flutter/material/ElevatedButton-class.html
[`OutlinedButton`]: {{site.api}}/flutter/material/OutlinedButton-class.html
[`ButtonStyle`]: {{site.api}}/flutter/material/ButtonStyle-class.html

[#105291]: {{site.repo.flutter}}/pull/105291
[#139267]: {{site.repo.flutter}}/pull/139267

---

### ThemeData.selectedRowColor

Package: flutter
Supported by Flutter Fix: yes

The `selectedRowColor` property of `ThemeData` was deprecated in v3.1.

The property was no longer used by the framework, as widgets using it migrated
to other component themes or no longer required it in the updated specification
for Material Design.

**Migration guide**

Code before migration:

```dart
ThemeData(
  // ...
  selectedRowColor: Colors.pink, // Would have no effect.  
);
```

Code after migration:

```dart
ThemeData(
  // ...
  // Remove uses.  
);
```

**References**

API documentation:

* [`ThemeData`][]

Relevant PRs:

* Deprecated in [#109070][]
* Removed in [#139080][]

[`ThemeData`]: {{site.api}}/flutter/material/ThemeData-class.html

[#109070]: {{site.repo.flutter}}/pull/109070
[#139080]: {{site.repo.flutter}}/pull/139080

---

### NavigatorState.focusScopeNode

Package: flutter
Supported by Flutter Fix: yes

The `focusScopeNode` property of `NavigatorState` was deprecated in v3.1.

This change was made to resolve several issues stemming around the
`FocusScopeNode` introduced by the `Navigator`. Instead, the `FocusScope`
was moved to enclose the topmost `Navigator` in a `WidgetsApp`.
`NavigatorState` was changed to contain its own `FocusNode`, from where it can
refer to its `FocusNode.enclosingScope` to access the correct `FocusScopeNode`.

**Migration guide**

Code before migration:

```dart
Navigator.of(context).focusScopeNode;

```

Code after migration:

```dart
Navigator.of(context).focusNode.enclosingScope!;
```

**References**

API documentation:

* [`Navigator`][]
* [`NavigatorState`][]
* [`FocusScope`][]
* [`FocusScopeNode`][]
* [`FocusNode`][]

Relevant PRs:

* Deprecated in [#109702][]
* Removed in [#139260][]

[`Navigator`]: {{site.api}}/flutter/widgets/Navigator-class.html
[`NavigatorState`]: {{site.api}}/flutter/widgets/NavigatorState-class.html
[`FocusScope`]: {{site.api}}/flutter/widgets/FocusScope-class.html
[`FocusScopeNode`]: {{site.api}}/flutter/widgets/FocusScopeNode-class.html
[`FocusNode`]: {{site.api}}/flutter/widgets/FocusNode-class.html

[#109702]: {{site.repo.flutter}}/pull/109702
[#139260]: {{site.repo.flutter}}/pull/139260

---

### PlatformMenuBar.body

Package: flutter
Supported by Flutter Fix: yes

The `body` property of `PlatformMenuBar` was deprecated in v3.1.

This change was made to align `PlatformMenuBar` with other widgets in the
framework, renaming it to `child`.

**Migration guide**

Code before migration:

```dart
PlatformMenuBar(
  body: myWidget,
);
```

Code after migration:

```dart
PlatformMenuBar(
  child: myWidget,
);
```

**References**

API documentation:

* [`PlatformMenuBar`][]

Relevant PRs:

* Deprecated in [#104565][]
* Removed in [#138509][]

[`PlatformMenuBar`]: {{site.api}}/flutter/widgets/PlatformMenuBar-class.html

[#104565]: {{site.repo.flutter}}/pull/104565
[#138509]: {{site.repo.flutter}}/pull/138509

---

The [previously announced][] deprecations for `TextTheme`, `WidgetInspectorService`,
and `WidgetInspectorServiceExtensions` were not removed during this cycle.
The `WidgetInspectorService` and `WidgetInspectorServiceExtensions`
deprecation on `setPubRootDirectories` has been extended another year to allow
IDEs and other customer to migrate.
Expect the `TextTheme` deprecations to be removed in the next cycle, which will
be announced again when it comes.

[previously announced]: https://groups.google.com/g/flutter-announce/c/DLnuqZo714o

---

## Timeline

In stable release: 3.19.0
