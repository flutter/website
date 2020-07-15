---
title: More Strict Assertions in the Navigator and the Hero Controller Scope
description: Added additional assertions to guarantee that one hero controller scope can only subscribe to one navigator at a time.
---

## Summary

The framework throws assertion error when it detects there are
multiple navigators register with one hero controller scope.

## Context

The hero controller scope hosts a hero controller for its widget
subtree. The hero controller can only support one navigator at
a time. Previously, there was no assertion to guarantee that.

## Description of change

If the code starts throwing assertion error after this change,
it means the code has already been broken even before this change.
This change only surfaced the problem.


## Migration guide

An example application that starts to throw exceptions.

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      builder: (BuildContext context, Widget child) {
        // Builds two parallel navigators. This will throw
        // error because both of navigators are under the same
        // hero controller scope created by MaterialApp.
        return Stack(
          children: <Widget>[
            Navigator(
              onGenerateRoute: (RouteSettings settings) {
                return MaterialPageRoute<void>(
                  settings: settings,
                  builder: (BuildContext context) {
                    return const Text('first Navigator');
                  }
                );
              },
            ),
            Navigator(
              onGenerateRoute: (RouteSettings settings) {
                return MaterialPageRoute<void>(
                  settings: settings,
                  builder: (BuildContext context) {
                    return const Text('Second Navigator');
                  }
                );
              },
            ),
          ],
        );
      }
    )
  );
}
```

You can fix this application by introducing your own hero controller scopes.

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      builder: (BuildContext context, Widget child) {
        // Builds two parallel navigators.
        return Stack(
          children: <Widget>[
            HeroControllerScope(
              controller: HeroController(createRectTween: materialRectTween),
              child: Navigator(
                onGenerateRoute: (RouteSettings settings) {
                  return MaterialPageRoute<void>(
                    settings: settings,
                    builder: (BuildContext context) {
                      return const Text('first Navigator');
                    }
                  );
                },
              ),
            ),
            HeroControllerScope(
              controller: HeroController(createRectTween: materialRectTween),
              child: Navigator(
                onGenerateRoute: (RouteSettings settings) {
                  return MaterialPageRoute<void>(
                    settings: settings,
                    builder: (BuildContext context) {
                      return const Text('second Navigator');
                    }
                  );
                },
              ),
            ),
          ],
        );
      }
    )
  );
}

RectTween materialRectTween(Rect begin, Rect end) {
  return MaterialRectArcTween(begin: begin, end: end);
}
```

## Timeline

Landed in version: 1.20.0

## References

API documentation:
* [`Navigator`][]
* [`HeroController`][]
* [`HeroControllerScope`][]

Relevant issue:
* [Issue 45938][]

Relevant PR:
* [Clean up hero controller scope][]

[Clean up hero controller scope]: {{site.github}}/flutter/flutter/pull/60655
[`Navigator`]{{site.api}}/flutter/widgets/Navigator-class.html
[`HeroController`]{{site.api}}/flutter/widgets/HeroController-class.html
[`HeroControllerScope`]: https://master-api.flutter.dev/flutter/widgets/HeroControllerScope-class.html
[Issue 45938]: {{site.github}}/flutter/flutter/issues/45938
