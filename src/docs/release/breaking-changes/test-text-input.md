---
title: TestTextInput and setEditingState updates
description: TestTextInput will have its state reset between tests, and setEditingState will be sent at times where it previously was missed.
---

# Send `setEditingState` when text changes

## Context

The Flutter engine and framework have to keep state about text fields in sync.
Sometimes, the engine can lose this state - such as when the application is
backgrounded on Android. In this case, the engine asks the framework to re-send
text field related state. [Currently, the framework is failing to send the
actual text content of the text field in this scenario](https://github.com/flutter/flutter/issues/47137).

## Description of change

The Flutter framework tracks when the editing state of an `EditableText` widget
changes. It synchronizes this value to the engine, but only if the value has
changed. The state of this value is tracked by the `TextInputClient`, and
logic exists to prevent sending duplicate values to the engine side.

A line of code currently prevents the `TextInputClient` from ever seeing changes
to this value. On Android applications in particular, this causes problems if
the Flutter engine is detached (e.g. when the app is backgrounded) and needs to
get the current state of any `EditableText` fields.

In addition, the testing framework was allowing global state to persist between
tests, and failed to have a helper class (`TestTextInput`) regain control of
the `SystemChannels.textInput` if a test grabbed it away (e.g. by calling
`SystemChannels.textInput.setMockMethodCallHandler(...)`).

Tests that inspect the `TestTextInput.editingState` may have been able to pass
before this change because:

- There was dirty state from a previous test.
- The framework did not call `setEditingState` on the `SystemChannels.textInput`
  channel where it now does.

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
* https://api.flutter.dev/flutter/widgets/EditableText-class.html
* https://api.flutter.dev/flutter/services/TextInput-class.html
* https://api.flutter.dev/flutter/services/TextInputClient-class.html

Relevant issues:
* https://github.com/flutter/flutter/issues/47137

Relevant PRs:
* https://github.com/flutter/flutter/pull/47177
