---
title: Semantics Order of the Overlay Entries in Modal Routes
description: The scope of the modal route has a higher semantics traverse order than its modal barrier.
---

## Summary

We changed the semantics traverse order of the overlay entries in modal routes.
Accessibility talk back or voice over now focuses the scope of a modal route
first instead of its modal barrier.

## Context

The modal route has two overlay entries, the scope and the modal barrier. The
scope is the actual content of the modal route, and the modal barrier is the
background of the route if its scope does not cover the entire screen. If the
modal route returns true for `barrierDismissible`, the modal barrier becomes
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
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('example test', (WidgetTester tester) async {
    final SemanticsHandle handle =
        tester.binding.pipelineOwner.ensureSemantics();

    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: Text('test'))));

    final SemanticsNode root =
        tester.binding.pipelineOwner.semanticsOwner.rootSemanticsNode;

    final SemanticsNode firstNode = getChild(root);
    expect(firstNode.rect, Rect.fromLTRB(0.0, 0.0, 800.0, 600.0));

    // Fixes the test by expecting an additional node above the scope route.
    final SemanticsNode secondNode = getChild(firstNode);
    expect(secondNode.rect, Rect.fromLTRB(0.0, 0.0, 800.0, 600.0));

    final SemanticsNode thirdNode = getChild(secondNode);
    expect(thirdNode.rect, Rect.fromLTRB(0.0, 0.0, 800.0, 600.0));
    expect(thirdNode.hasFlag(SemanticsFlag.scopesRoute), true);

    final SemanticsNode forthNode = getChild(thirdNode);
    expect(forthNode.rect, Rect.fromLTRB(0.0, 0.0, 56.0, 14.0));
    expect(forthNode.label, 'test');
    handle.dispose();
  });
}

SemanticsNode getChild(SemanticsNode node) {
  SemanticsNode child;
  bool visiter(SemanticsNode target) {
    child = target;
    return false;
  }

  node.visitChildren(visiter);
  return child;
}
```

Code after migration:

```dart
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('example test', (WidgetTester tester) async {
    final SemanticsHandle handle =
        tester.binding.pipelineOwner.ensureSemantics();

    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: Text('test'))));

    final SemanticsNode root =
        tester.binding.pipelineOwner.semanticsOwner.rootSemanticsNode;

    final SemanticsNode firstNode = getChild(root);
    expect(firstNode.rect, Rect.fromLTRB(0.0, 0.0, 800.0, 600.0));

    // Fixes the test by expecting an additional node above the scope route.
    final SemanticsNode secondNode = getChild(firstNode);
    expect(secondNode.rect, Rect.fromLTRB(0.0, 0.0, 800.0, 600.0));

    final SemanticsNode thirdNode = getChild(secondNode);
    expect(thirdNode.rect, Rect.fromLTRB(0.0, 0.0, 800.0, 600.0));
    expect(thirdNode.hasFlag(SemanticsFlag.scopesRoute), true);

    final SemanticsNode forthNode = getChild(thirdNode);
    expect(forthNode.rect, Rect.fromLTRB(0.0, 0.0, 56.0, 14.0));
    expect(forthNode.label, 'test');
    handle.dispose();
  });
}

SemanticsNode getChild(SemanticsNode node) {
  SemanticsNode child;
  bool visiter(SemanticsNode target) {
    child = target;
    return false;
  }

  node.visitChildren(visiter);
  return child;
}
```

## Timeline

Landed in version: 1.19.0
In stable release: 1.20

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
