---
title: TestTextInput state reset
description: TestTextInput will have its state reset between tests.
---

# TestTextInput state will be reset between tests

## Context

The Flutter test framework uses a class called `TestTextInput` to track and
manipulate editing state in a widgets test. Individual tests can make calls
that modify the internal state of this object, sometimes indirectly (such as
by setting their own handlers on `SystemChannels.textInput`). Subsequent tests
may then check the state of `WidgetTester.testTextInput` and get unexpected
values.

## Description of change

Reset the state of `WidgetTester.testTextInput` before running a `testWidgets`
test.

## Migration guide

Tests that relied on dirty state from a previously run testwill have to be
updated. For example, this test:

```dart
    expect(tester.testTextInput.editingState['text'], isEmpty);
```

from `packages/flutter/test/material/text_field_test.dart` in the `'Controller
can update server'` test previously passed because of a combination of dirty
state from previous tests and a failure to actually set state in cases where
we should have been.

### Before

In a `widgetsTest`, before actually changing text on a text editing widget,
this call might have succeeded:

```dart
    expect(tester.testTextInput.editingState['text'], isEmpty);
```

### After

Either remove the call entirely, or consider:

```dart
    expect(tester.testTextInput.editingState, isNull);
```

to assert that the state hasn't been modified yet.

## Timeline

This change is being proposed for December of 2019.

## References

API documentation:
* [TestTextInput](https://api.flutter.dev/flutter/flutter_test/TestTextInput-class.html)
* [WidgetTester](https://api.flutter.dev/flutter/flutter_test/WidgetTester-class.html)

Relevant issues:
* [Randomize test order to avoid global state](https://github.com/flutter/flutter/issues/47233)

Relevant PRs:
* [Reset state between tests](https://github.com/flutter/flutter/pull/47464)
