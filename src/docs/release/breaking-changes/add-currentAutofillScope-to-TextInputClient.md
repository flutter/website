---
title: Adding TextInputClient.currentAutofillScope property
description: A new getter TextInputClient.currentAutofillScope was added to the TextInputClient interface for autofill support.
---

## Summary

A new getter, `TextInputClient.currentAutofillScope`, was added to the
`TextInputClient` interface; all `TextInputClient` subclasses must 
provide a concrete implementation of `currentAutofillScope`.

This getter allows the `TextInputClient` to trigger an
autofill that involves multiple logically connected input
fields. For example, a "username" field can trigger an
autofill that fills both itself and the "password"
field associated with it. 

## Context

On many platforms, autofill services are capable of
autofilling multiple input fields in a single autofill attempt.
For example, username fields and password fields can usually
be autofilled in one go. For this reason, a Flutter input
field that is about to trigger autofill should also provide
the platform with information about other autofillable input
fields logically connected to it.
`TextInputClient.currentAutofillScope` defines the group of
input fields that are logically connected to this `TextInputClient`,
and can be autofilled together.

## Description of change

`TextInputClient` now has an additional getter that returns
the `AutofillScope` that this client belongs to.
This getter is used by the input client to collect autofill
related information from other autofillable input fields
within the same scope.

<!-- skip -->
```dart
abstract class TextInputClient {
  AutofillScope get currentAutofillScope;
}
```

If you see the error message "missing concrete implementation of 
'getter TextInputClient.currentAutofillScope'" while compiling
a Flutter app, follow the migration steps listed below.

## Migration guide

If you're not planning to add multifield autofill
support to your `TextInputClient` subclass,
simply return `null` in the getter:

<!-- skip -->
```dart
class CustomTextField implements TextInputClient {
  // Not having an AutofillScope does not prevent the input field
  // from being autofilled. However, only this input field is
  // autofilled when autofill is triggered on it.
  AutofillScope get currentAutofillScope => null;
}
```

If multifield autofill support is desirable, a common
`AutofillScope` to use is the `AutofillGroup` widget.
To get the closest `AutofillGroup` widget to the text
input, use `AutofillGroup.of(context)`:

<!-- skip -->
```dart
class CustomTextFieldState extends State<CustomTextField> implements TextInputClient {
  AutofillScope get currentAutofillScope => AutofillGroup.of(context);
}
```

For more information, see [`AutofillGroup`][].


## Timeline

Landed in version: 1.18.0<br>
In stable release: 1.20

## References

API documentation:
* [`AutofillGroup`][]
* [`TextInputClient.currentAutofillScope`][]

Relevant issues:
* [Issue 13015: Autofill support][]

Relevant PRs:
* [Framework PR that added autofill support][]


[Framework PR that added autofill support]: {{site.github}}/flutter/flutter/pull/52126
[Issue 13015: Autofill support]: {{site.github}}/flutter/flutter/issues/13015

[`AutofillGroup`]: {{site.api}}/flutter/widgets/AutofillGroup-class.html
[`TextInputClient.currentAutofillScope`]: {{site.api}}/flutter/services/TextInputClient/currentAutofillScope.html

