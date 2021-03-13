---
title: More Strict Assertions in the Navigator and the Hero Controller Scope
description: Added additional assertions to guarantee that one hero controller scope can only subscribe to one navigator at a time.
---

## Summary

The framework throws an assertion error when it detects there are
multiple navigators registered with one hero controller scope.

## Context

The hero controller scope hosts a hero controller for its widget
subtree. The hero controller can only support one navigator at
a time. Previously, there was no assertion to guarantee that.

## Description of change

If the code starts throwing assertion errors after this change,
it means the code was already broken even before this change.
Multiple navigators may be registered under the same hero
controller scope, and they can not trigger hero animations when
their route changes. This change only surfaced this problem.


## Migration guide

An example application that starts to throw exceptions.

<!-- skip -->
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      builder: (BuildContext context, Widget child) {
        // Builds two parallel navigators. This throws
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

<!-- skip -->
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
              controller: MaterialApp.createMaterialHeroController(),
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
              controller: MaterialApp.createMaterialHeroController(),
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
```

## Timeline

Landed in version: 1.20.0
In stable release: 1.20

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
[`Navigator`]: {{site.api}}/flutter/widgets/Navigator-class.html
[`HeroController`]: {{site.api}}/flutter/widgets/HeroController-class.html
[`HeroControllerScope`]: {{site.api}}/flutter/widgets/HeroControllerScope-class.html
[Issue 45938]: {{site.github}}/flutter/flutter/issues/45938
