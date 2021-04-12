---
title: TextSelectionTheme migration
description: The default properties for text selection are migrating to TextSelectionTheme.
---

## Summary

The `ThemeData` properties that controlled the look of
selected text in Material widgets have been moved into
their own `TextSelectionTheme`. These properties include
`cursorColor`, `textSelectionColor`, and
`textSelectionHandleColor`. The defaults for these
properties have also been changed to match the Material
Design specification.

## Context

As part of the larger [Material Theme Updates][],
we have introduced a new [Text Selection Theme][]
used to specify the properties of selected text in
`TextField` and `SelectableText` widgets.
These replace several top-level properties of `ThemeData`
and update their default values to match the Material
Design specification. This document describes how
applications can migrate to this new API.

## Migration guide

If you are currently using the following properties of
`ThemeData`, you need to update them to use the new
equivalent properties on `ThemeData.textSelectionTheme`:

| Before                               | After                                         |
|--------------------------------------|-----------------------------------------------|
| `ThemeData.cursorColor`              | `TextSelectionThemeData.cursorColor`          |
| `ThemeData.textSelectionColor`       | `TextSelectionThemeData.selectionColor`       |
| `ThemeData.textSelectionHandleColor` | `TextSelectionThemeData.selectionHandleColor` |

<br/>

**Code before migration:**

<!-- skip -->
```dart
ThemeData(
  cursorColor: Colors.red,
  textSelectionColor: Colors.green,
  textSelectionHandleColor: Colors.blue,
)
```

**Code after migration:**

<!-- skip -->
```dart
ThemeData(
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.red,
    selectionColor: Colors.green,
    selectionHandleColor: Colors.blue,
  )
)
```

**Default changes**

If you weren't using these properties explicitly,
but depended on the previous default colors used
for text selection you can add a new field to your
`ThemeData` for your app to return to the old defaults
as shown:

<!-- skip -->
```dart
// Old defaults for a light theme
ThemeData(
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: const Color.fromRGBO(66, 133, 244, 1.0),
    selectionColor: const Color(0xff90caf9),
    selectionHandleColor: const Color(0xff64b5f6),
  )
)
```

<!-- skip -->
```dart
// Old defaults for a dark theme
ThemeData(
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: const Color.fromRGBO(66, 133, 244, 1.0),
    selectionColor: const Color(0xff64ffda),
    selectionHandleColor: const Color(0xff1de9b6),
  )
)
```

If you are fine with the new defaults,
but have failing golden file tests, you
can update your master golden files using the
following command:

```bash
flutter test --update-goldens
```

## Timeline

Landed in version: 1.23.0-4.0.pre<br>
In stable release: 2.0.0

## References

API documentation:
* [`TextSelectionThemeData`][]
* [`ThemeData`][]

Relevant PRs:
* [PR 62014: TextSelectionTheme support][]

[Material Theme Updates]: /go/material-theme-system-updates
[PR 62014: TextSelectionTheme support]: {{site.github}}/flutter/flutter/pull/62014
[Text Selection Theme]: /go/text-selection-theme
[`TextSelectionThemeData`]: {{site.api}}/flutter/material/TextSelectionThemeData-class.html
[`ThemeData`]: {{site.api}}/flutter/material/ThemeData-class.html
