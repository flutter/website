---
title: Add currentAutofillScope to TextInputClient
description: A new getter`TextInputClient.currentAutofillScope` was added to the `TextInputClient` interface for autofill support.
---

## Summary

A new getter`TextInputClient.currentAutofillScope` was added to the `TextInputClient` interface.

## Context

On many platforms, autofill services are capable of autofilling multiple input fields in a single autofill 
attempt. For example, username fields and password fields can usually be autofilled in one go. For this reason, 
a Flutter input field that is about to trigger autofill should also provide the platform with information about other autofillable
input fields logically connected to it. `TextInputClient.currentAutofillScope` defines the group of input fields that are logically
connected to this `TextInputClient`, and can be autofilled together.

## Description of change

`TextInputClient` now has an additional getter that returns the `AutofillScope` that this client belongs to. This getter will be used by the input client to collect autofill related information from other 
autofillable input fields within the same scope.

```dart
abstract class TextInputClient {
  AutofillScope get currentAutofillScope;
}
```

## Migration guide

If you're not planning to add multifield autofill support to your `TextInputClient` subclass, simply return `null` in the getter:
```dart
class CustomTextField implements TextInputClient {
  // Not having an AutofillScope does not prevent the input field
  // from being autofilled. However, only this input field will
  // be autofilled when autofill is triggered on it.
  AutofillScope get currentAutofillScope => null;
}
```

If multifield autofill support is desirable, a common `AutofillScope` to use is the `AutofillGroup` widget. To get the closest `AutofillGroup`
widget to the text input, use `AutofillGroup.of(context)`:

<!-- skip -->
```dart
class CustomTextFieldState extends State<CustomTextField> implements TextInputClient {
  // Not having an AutofillScope does not prevent the input field
  // from being autofilled. However, only this input field will
  // be autofilled when autofill is triggered on it.
  AutofillScope get currentAutofillScope => AutofillGroup.of(context);
}
```
for more information about the `AutofillGroup` widget, please refer to its documentation: [`AutofillGroup`][].


## Timeline

TBA

{% comment %}
The version # of the SDK where this change was
introduced.  If there is a deprecation window,
the version # to which we guarantee to maintain the old API.
{% endcomment %}

## References

API documentation:
* [`AutofillGroup`][]
* [`TextInputClient.currentAutofillScope`][]

Relevant issues:
* [Issue 13015: Autofill support][]

Relevant PRs:
* [Framework PR that added autofill support][]


{% include master-api.md %}

Stable channel link:
[Framework PR that added autofill support]: {{site.github}}/flutter/flutter/pull/52126
[Issue 13015: Autofill support]: {{site.github}}/flutter/flutter/issues/13015

Master channel link:
[`AutofillGroup`]: https://master-api.flutter.dev/flutter/widgets/AutofillGroup-class.html
[`TextInputClient.currentAutofillScope`]: https://https://master-api.flutter.dev/flutter/services/TextInputClient/currentAutofillScope.html
