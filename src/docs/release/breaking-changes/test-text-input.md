---
title: TestTextInput state reset
description: TestTextInput state is now reset between tests.
---

## Summary

The state of a `TestTextInput` instance,
a stub for the system's onscreen keyboard,
is now reset between tests.

## Context

The Flutter test framework uses a class called `TestTextInput`
to track and manipulate editing state in a widgets test.
Individual tests can make calls that modify the internal
state of this object, sometimes indirectly (such as
by setting their own handlers on `SystemChannels.textInput`).
Subsequent tests might then check the state of
`WidgetTester.testTextInput` and get unexpected values.

## Description of change

The state of `WidgetTester.testTextInput`
is now reset before running a `testWidgets` test.

## Migration guide

Tests that relied on dirty state from a previously run
test must be updated. For example, the following test,
from `packages/flutter/test/material/text_field_test.dart`
in the `'Controller can update server'` test,
previously passed because of a combination of dirty state
from previous tests and a failure to actually set state
in cases where it should have been set.

Code before migration:

In a `widgetsTest`, before actually changing text on a
text editing widget, this call might have succeeded:

<!-- skip -->
```dart
    expect(tester.testTextInput.editingState['text'], isEmpty);
```

Code after migration:

Either remove the call entirely, or consider using the
following to assert that the state hasn't been modified yet:

<!-- skip -->
```dart
    expect(tester.testTextInput.editingState, isNull);
```

## Timeline

Landed in version: 1.16.3<br>
In stable release: 1.17

## References

API documentation:

* [`TestTextInput`][]
* [`WidgetTester`][]

Relevant issue:

* [Randomize test order to avoid global state][]

Relevant PR:

* [Reset state between tests][]


[Randomize test order to avoid global state]: {{site.github}}/flutter/flutter/issues/47233
[Reset state between tests]: {{site.github}}/flutter/flutter/pull/47464
[`TestTextInput`]: {{site.api}}/flutter/flutter_test/TestTextInput-class.html
[`WidgetTester`]: {{site.api}}/flutter/flutter_test/WidgetTester-class.html
