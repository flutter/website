---
title: Change the enterText method to move the caret to the end of the input text
description: WidgetTester.enterText and TestTextInput.enterText now move the caret to the end of the input text.
---

## Summary

The `WidgetTester.enterText` and `TestTextInput.enterText` methods
now move the caret to the end of the input text.

## Context

The caret indicates the insertion point within the current text in an 
active input field. Typically, when a new character is entered, the 
caret stays immediately after it. In Flutter the caret position is 
represented by a collapsed selection. When the selection is invalid, 
usually the user won't be able to modify or add text until they 
change the selection to a valid value.

`WidgetTester.enterText` and `TestTextInput.enterText` are 2 methods 
used in tests to replace the content of the target text field. Prior 
to this change, `WidgetTester.enterText` and `TestTextInput.enterText` 
set the selection to an invalid range (-1, -1), indicating there's 
no selection or caret. This contradicts the typical behavior of an
input field.

## Description of change

In addition to replacing the text with the supplied text, 
`WidgetTester.enterText` and `TestTextInput.enterText` now set the 
selection to `TextSelection.collapsed(offset: text.length)`, instead
of `TextSelection.collapsed(offset: -1)`.

## Migration guide

It should be very uncommon for tests to have to rely on the 
previous behavior of `enterText`, since usually the selection 
should not be invalid. **Consider changing the expected values of 
your tests to adopt the `enterText` change.**

Common test failures this change may introduce includes:
- Golden test failures: 

  The caret appears at the end of the text, as opposed to before
  the text prior to the change.
  
- Different `TextEditingValue.selection` after calling `enterText`:

  The text field's `TextEditingValue` now has a collapsed 
  selection with a non-negative offset, as opposed to 
  `TextSelection.collapsed(offset: -1)` prior to the change.
  For instance, you may see 
  `expect(controller.value.selection.baseOffset, -1);`
  failing after `enterText` calls.


If your tests have to rely on setting the selection to invalid,
the previous behavior can be achieved using`updateEditingValue`:  

### `TestTextInput.enterText`

Code before migration:

<!-- skip -->
```dart
await testTextInput.enterText(text);
```
Code after migration:

<!-- skip -->
```dart
await testTextInput.updateEditingValue(TextEditingValue(
  text: text,
));
```

### `WidgetTester.enterText`

Code before migration:

<!-- skip -->
```dart
await tester.enterText(finder, text);
```

Code after migration:

<!-- skip -->
```dart
await tester.showKeyboard(finder);
await tester.updateEditingValue(TextEditingValue(
  text: text,
));
await tester.idle();
```

## Timeline

Landed in version: 2.1.0-13.0.pre<br>
In stable release: not yet

## References

{% include master-api.md %}

API documentation:

* [`WidgetTester.enterText`][]
* [`TestTextInput.enterText`][]

Relevant issues:

* [Issue 79494]

Relevant PRs:

* [enterText to move the caret to the end]


<!-- Master channel link: -->

[`WidgetTester.enterText`]: https://master-api.flutter.dev/flutter/flutter_test/WidgetTester/enterText.html
[`TestTextInput.enterText`]: https://master-api.flutter.dev/flutter/flutter_test/TestTextInput/enterText.html

[Issue 79494]: {{site.github}}/flutter/flutter/issues/79494
[enterText to move the caret to the end]: {{site.github}}/flutter/flutter/pull/79506
