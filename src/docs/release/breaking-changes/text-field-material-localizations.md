---
title: TextField requires Material Localizations
description: TextFields will now assert for Material Localizations.
---

## Summary

Instances of `TextField` must have a `MaterialLocalizations` present.
Trying to instantiate  a `TextField` without the proper localizations will
result in an assertion such as the following:

```
No MaterialLocalizations found.
TextField widgets require MaterialLocalizations to be provided by a Localizations widget ancestor.
Localizations are used to generate many different messages, labels, and abbreviations which are used
by the material library.
To introduce a MaterialLocalizations, either use a MaterialApp at the root of your application to
include them automatically, or add a Localization widget with a MaterialLocalizations delegate.
The specific widget that could not find a MaterialLocalizations ancestor was:
  TextField
```

## Context

If your `TextField` is within the scope of a `MaterialApp`, the
`DefaultMaterialLocalizations` is already be instantiated and may suit your needs without having
to make a change to your existing code.

If your `TextField` is not within a `MaterialApp`, you may provide the localizations of
your choosing using the `Localizations` widget.

This change was initially introduced with an opt-in flag
`TextField.canAssertMaterialLocalizations`, to allow developers time to migrate
without experiencing broken code. This temporary opt-in flag will be removed in a follow up change.

## Migration guide

If you are seeing an assertion error, make sure locale information is being
provided to your `TextField` through ans ancestor `MaterialApp`, which will automatically provide
`MaterialLocalizations`, or with your own `Localizations` widget.

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

Code after migration (Providing localizations via the `MaterialApp`):

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

Code to validate migration:

<!-- skip -->
```dart
import 'package:flutter/material.dart';
void main() => runApp(Foo());
class Foo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TextField(canAssertMaterialLocalizations: true),
    );
  }
}
```

## Timeline

TBD - Add the version number that contains this change.

## References

{% include master-api.md %}

API documentation:
* [`TextField`][]
* [`Localizations`][]
* [`MaterialLocalizations`][]
* [`DefaultMaterialLocalizations`][]
* [`MaterialApp`][]
* [Internationalizing Flutter apps][]


Relevant PR:
* [PR 56090: Add opt-in for debugCheckHasMaterialLocalizations assertion on TextField][]

[`TextField`]: https://master-api.flutter.dev/flutter/material/TextField-class.html
[`Localizations`]: {{site.api}}/flutter/widgets/Localizations-class.html
[`MaterialLocalizations`]: {{site.api}}/flutter/material/MaterialLocalizations-class.html
[`DefaultMaterialLocalizations`]: {{site.api}}/flutter/material/DefaultMaterialLocalizations-class.html
[`MaterialApp`]: {{site.api}}/flutter/material/MaterialApp-class.html
[Internationalizing Flutter apps]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[PR 56090: Add opt-in for debugCheckHasMaterialLocalizations assertion on TextField]: {{site.github}}/flutter/flutter/pull/56090
