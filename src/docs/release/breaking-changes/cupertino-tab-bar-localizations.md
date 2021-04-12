---
title: CupertinoTabBar requires Localizations parent
description: In order to provide locale appropriate semantics, the CupertinoTabBar requires a Localizations parent.
---

## Summary

Instances of `CupertinoTabBar` must have a
`Localizations`parent in order to provide a localized
`Semantics` hint. Trying to instantiate  a
`CupertinoTabBar` without localizations 
results in an assertion such as the following:
       
```
CupertinoTabBar requires a Localizations parent in order to provide an appropriate Semantics hint
for tab indexing. A CupertinoApp provides the DefaultCupertinoLocalizations, or you can
instantiate your own Localizations.
'package:flutter/src/cupertino/bottom_tab_bar.dart':
Failed assertion: line 213 pos 7: 'localizations != null'
```

## Context

To support localized semantics information,
the `CupertinoTabBar` requires localizations.

Before this change, the `Semantics` hint provided
to the `CupertinoTabBar` was a hard-coded String,
'tab, $index of $total'. The content of the semantics
hint was also updated from this original
String to 'Tab $index of $total' in English.

If your `CupertinoTabBar` is within the scope
of a `CupertinoApp`, the `DefaultCupertinoLocalizations`
is already instantiated and may suit your
needs without having to make a change to your existing code.

If your `CupertinoTabBar` is not within a `CupertinoApp`,
you may provide the localizations of
your choosing using the `Localizations` widget.

## Migration guide

If you are seeing a `'localizations != null'` assertion error,
make sure locale information is being
provided to your `CupertinoTabBar`.

Code before migration:

```dart
import 'package:flutter/cupertino.dart';

void main() => runApp(Foo());

class Foo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: const MediaQueryData(),
      child: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.add_circled),
            label: 'Tab 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.add_circled_solid),
            label: 'Tab 2',
          ),
        ],
        currentIndex: 1,
      ),
    );
  }
}
```

Code after migration (Providing localizations via the `CupertinoApp`):

```dart
import 'package:flutter/cupertino.dart';

void main() => runApp(Foo());

class Foo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.add_circled),
            label: 'Tab 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.add_circled_solid),
            label: 'Tab 2',
          ),
        ],
        currentIndex: 1,
      ),
    );
  }
}
```

Code after migration (Providing localizations by using
the `Localizations` widget):

```dart
import 'package:flutter/cupertino.dart';

void main() => runApp(Foo());

class Foo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: const Locale('en', 'US'),
      delegates: <LocalizationsDelegate<dynamic>>[
        DefaultWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      child: MediaQuery(
        data: const MediaQueryData(),
        child: CupertinoTabBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.add_circled),
              label: 'Tab 1',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.add_circled_solid),
              label: 'Tab 2',
            ),
          ],
          currentIndex: 1,
        ),
      ),
    );
  }
}
```

## Timeline

This change was introduced in May 2020, in 1.18.0-9.0.pre.

## References

API documentation:
* [`CupertinoTabBar`][]
* [`Localizations`][]
* [`DefaultCupertinoLocalizations`][]
* [`Semantics`][]
* [`CupertinoApp`][]
* [Internationalizing Flutter Apps][]


Relevant PR:
* [PR 55336: Adding tabSemanticsLabel to CupertinoLocalizations][]
* [PR 56582: Update Tab semantics in Cupertino to be the same as Material][]

[`CupertinoTabBar`]: {{site.api}}/flutter/cupertino/CupertinoTabBar-class.html
[`Localizations`]: {{site.api}}/flutter/widgets/Localizations-class.html
[`DefaultCupertinoLocalizations`]: {{site.api}}/flutter/cupertino/DefaultCupertinoLocalizations-class.html
[`Semantics`]: {{site.api}}/flutter/widgets/Semantics-class.html
[`CupertinoApp`]: {{site.api}}/flutter/cupertino/CupertinoApp-class.html
[Internationalizing Flutter Apps]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[PR 55336: Adding tabSemanticsLabel to CupertinoLocalizations]: {{site.github}}/flutter/flutter/pull/55336
[PR 56582: Update Tab semantics in Cupertino to be the same as Material]: {{site.github}}/flutter/flutter/pull/56582#issuecomment-625497951
