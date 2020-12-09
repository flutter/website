---
title: TextField requires a MaterialLocalizations widget
description: TextField now throws an assert error if there is no MaterialLocalizations widget in the widget tree.
---

## Summary

Instances of `TextField` must have a `MaterialLocalizations` present in the widget tree.
Trying to instantiate a `TextField` without the proper localizations results in an assertion such
as the following:

```
No MaterialLocalizations found.
TextField widgets require MaterialLocalizations to be provided by a Localizations widget ancestor.
The material library uses Localizations to generate messages, labels, and abbreviations.
To introduce a MaterialLocalizations, either use a MaterialApp at the root of your application to
include them automatically, or add a Localization widget with a MaterialLocalizations delegate.
The specific widget that could not find a MaterialLocalizations ancestor was:
  TextField
```

## Context

If the `TextField` descends from a `MaterialApp`, the
`DefaultMaterialLocalizations` is already instantiated
and won't require any changes to your existing code.

If the `TextField` doesn't descend from `MaterialApp`,
you can use a `Localizations` widget to
provide your own localizations.

## Migration guide

If you see an assertion error, make sure that locale information is available to the `TextField`,
either through an ancestor `MaterialApp` (that automatically provides `Localizations`), or by
creating your own `Localizations` widget.

Code before migration:

```dart
import 'package:flutter/material.dart';

void main() => runApp(Foo());

class Foo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: const MediaQueryData(),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: TextField(),
      ),
    );
  }
}
```

Code after migration (Providing localizations using the `MaterialApp`):

```dart
import 'package:flutter/material.dart';

void main() => runApp(Foo());

class Foo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TextField(),
    );
  }
}
```

Code after migration (Providing localizations via the `Localizations` widget):

```dart
import 'package:flutter/material.dart';

void main() => runApp(Foo());

class Foo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: const Locale('en', 'US'),
      delegates: <LocalizationsDelegate<dynamic>>[
        DefaultWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
      ],
      child: MediaQuery(
        data: const MediaQueryData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: TextField(),
        ),
      ),
    );
  }
}
```

## Timeline

Landed in version: 1.20.0-1.0.pre<br>
In stable release: 1.20

## References

API documentation:
* [`TextField`][]
* [`Localizations`][]
* [`MaterialLocalizations`][]
* [`DefaultMaterialLocalizations`][]
* [`MaterialApp`][]
* [Internationalizing Flutter apps][]


Relevant PR:
* [PR 58831: Assert debugCheckHasMaterialLocalizations on TextField][]

[`TextField`]: {{site.api}}/flutter/material/TextField-class.html
[`Localizations`]: {{site.api}}/flutter/widgets/Localizations-class.html
[`MaterialLocalizations`]: {{site.api}}/flutter/material/MaterialLocalizations-class.html
[`DefaultMaterialLocalizations`]: {{site.api}}/flutter/material/DefaultMaterialLocalizations-class.html
[`MaterialApp`]: {{site.api}}/flutter/material/MaterialApp-class.html
[Internationalizing Flutter apps]: /docs/development/accessibility-and-localization/internationalization
[PR 58831: Assert debugCheckHasMaterialLocalizations on TextField]: {{site.github}}/flutter/flutter/pull/58831
