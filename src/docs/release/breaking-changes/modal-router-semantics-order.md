---
title: Semantics Order of the Overlay Entries in Modal Routes
description: The scope of the modal route has a higher semantics traverse order than its modal barrier.
---

## Summary

We changed the semantics traverse order of the overlay entries in model routes.
The accessibility talk back or voice over now focus the scope of a model first
instead of its modal barrier.

## Context

The model route has two overlay entries, the scope and the modal barrier. The
scope is the actual content of the modal route, and the modal barrier is the
background of the route if its scope does not cover the entire screen. If the
modal route returns true for barrierDismissible, the modal barrier becomes
accessibility focusable because users can tap the modal barrier to pop the
modal route. This change specifically made the accessibility to focus the scope
first before the modal barrier.

## Description of change

We added additional semantics node above both the overlay entries of modal routes.
Those semantics nodes denote the semantics traverse order of these two overlay entries.
This also changed the structure of semantics tree.

## Migration guide

If your tests start failing due to semantics tree changes after the update,
you can migrate your code by expecting a new node on above of the modal route
overlay entries.

Code before migration:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('AppBar excludes header semantics correctly', (WidgetTester tester) async {
    final SemanticsTester semantics = SemanticsTester(tester);

    await tester.pumpWidget(
      MaterialApp(
        home: Center(
          child: AppBar(
            leading: const Text('Leading'),
            title: const ExcludeSemantics(child: Text('Title')),
            excludeHeaderSemantics: true,
            actions: const <Widget>[
              Text('Action 1'),
            ],
          ),
        ),
      ),
    );
    // This will fail because it is missing a node above the scopesRoute.
    expect(semantics, hasSemantics(
      TestSemantics.root(
        children: <TestSemantics>[
          TestSemantics(
            children: <TestSemantics>[
              TestSemantics(
                flags: <SemanticsFlag>[SemanticsFlag.scopesRoute],
                children: <TestSemantics>[
                  TestSemantics(
                    children: <TestSemantics>[
                      TestSemantics(
                        label: 'Leading',
                        textDirection: TextDirection.ltr,
                      ),
                      TestSemantics(
                        label: 'Action 1',
                        textDirection: TextDirection.ltr,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      ignoreRect: true,
      ignoreTransform: true,
      ignoreId: true,
    ));
    semantics.dispose();
  });
}
```

Code after migration:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('AppBar excludes header semantics correctly', (WidgetTester tester) async {
    final SemanticsTester semantics = SemanticsTester(tester);

    await tester.pumpWidget(
      MaterialApp(
        home: Center(
          child: AppBar(
            leading: const Text('Leading'),
            title: const ExcludeSemantics(child: Text('Title')),
            excludeHeaderSemantics: true,
            actions: const <Widget>[
              Text('Action 1'),
            ],
          ),
        ),
      ),
    );
    expect(semantics, hasSemantics(
      TestSemantics.root(
        children: <TestSemantics>[
          TestSemantics(
            children: <TestSemantics>[
              // Adds an additional node above the scopesRoute.
              TestSemantics(
                children: <TestSemantics>[
                  TestSemantics(
                    flags: <SemanticsFlag>[SemanticsFlag.scopesRoute],
                    children: <TestSemantics>[
                      TestSemantics(
                        children: <TestSemantics>[
                          TestSemantics(
                            label: 'Leading',
                            textDirection: TextDirection.ltr,
                          ),
                          TestSemantics(
                            label: 'Action 1',
                            textDirection: TextDirection.ltr,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      ignoreRect: true,
      ignoreTransform: true,
      ignoreId: true,
    ));
    semantics.dispose();
  });
}
```

## Timeline

Landed in version: 1.19.0
In stable release: not yet

## References

API documentation:
* [`ModalRoute`][]
* [`OverlayEntry`][]

Relevant issue:
* [Issue 46625][]

Relevant PRs:
* [PR 59290][]

[`ModalRoute`]: {{site.api}}/flutter/widgets/ModalRoute-class.html
[`OverlayEntry`]: {{site.api}}/flutter/widgets/OverlayEntry-class.html
[Issue 46625]: {{site.github}}/flutter/flutter/issues/46625
[PR 59290]: {{site.github}}/flutter/flutter/pull/59290
