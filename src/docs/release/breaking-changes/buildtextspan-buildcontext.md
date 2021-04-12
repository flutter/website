---
title: Added BuildContext parameter to TextEditingController.buildTextSpan
description: A BuildContext parameter is added to TextEditingController.buildTextSpan so inheritors that override buildTextSpan can access inherited widgets.
---

## Summary

A `BuildContext` parameter was added to `TextEditingController.buildTextSpan`.

Classes that extend or implement `TextEditingController`
and override `buildTextSpan` need to add the `BuildContext`
parameter to the signature to make it a valid override.

Callers of `TextEditingController.buildTextSpan`
need to pass a `BuildContext` to the call.

## Context

`TextEditingController.buildTextSpan` is called by `EditableText`
on its controller to create the `TextSpan` that it renders.
`buildTextSpan` can be overridden in custom classes that extend
`TextEditingController`. This allows classes extending
`TextEditingController` override `buildTextSpan` to change
the style of parts of the text, for example, for rich text editing.

Any state that is required by `buildTextSpan`
(other than the `TextStyle` and `withComposing` arguments)
needed to be passed into the class that extends
`TextEditingController`.

## Description of change

With the `BuildContext` available, users can access
`InheritedWidgets` inside `buildTextSpan`
to retrieve state required to style the text,
or otherwise manipulate the created `TextSpan`.

Consider the example where we have a
`HighlightTextEditingController` that wants to
highlight text by setting its color to `Theme.accentColor`.

Before this change the controller implementation would look like this:

<!-- skip -->
```dart
class HighlightTextEditingController extends TextEditingController {
  HighlightTextEditingController(this.highlightColor);

  final Color highlightColor;

  @override
  TextSpan buildTextSpan({TextStyle? style, required bool withComposing}) {
    return super.buildTextSpan(style: TextStyle(color: highlightColor), withComposing: withComposing);
  }
```

And users of the controller would need to pass the color
when creating the controller.

With the `BuildContext` parameter available,
the `HighlightTextEditingController` can directly access
`Theme.accentColor` using `Theme.of(BuildContext)`:

<!-- skip -->
```dart
class HighlightTextEditingController extends TextEditingController {
  @override
  TextSpan buildTextSpan({required BuildContext context, TextStyle? style, required bool withComposing}) {
    final Color color = Theme.of(context).accentColor;
    return super.buildTextSpan(context: context, style: TextStyle(color: color), withComposing: withComposing);
  }
}
```

## Migration guide

### Overriding `TextEditingController.buildTextSpan`

Add a `required BuildContext context` parameter to the
signature of the `buildTextSpan` override.

Code before migration:

<!-- skip -->
```dart
class MyTextEditingController {
  @override
  TextSpan buildTextSpan({TextStyle? style, required bool withComposing}) {
    /* ... */
  }
}
```

Example error message before migration:

```
'MyTextEditingController.buildTextSpan' ('TextSpan Function({TextStyle? style, required bool withComposing})') isn't a valid override of 'TextEditingController.buildTextSpan' ('TextSpan Function({required BuildContext context, TextStyle? style, required bool withComposing})').
```

Code after migration:

<!-- skip -->
```dart
class MyTextEditingController {
  @override
  TextSpan buildTextSpan({required BuildContext context, TextStyle? style, required bool withComposing}) {
    /* ... */
  }
}
```

### Calling `TextEditingController.buildTextSpan`

Pass a named parameter 'context' of type
`BuildContext` to the call.

Code before migration:

<!-- skip -->
```dart
TextEditingController controller = /* ... */;
TextSpan span = controller.buildTextSpan(withComposing: false);
```

Error message before migration:

```
The named parameter 'context' is required, but there's no corresponding argument.
Try adding the required argument.
```

Code after migration:

<!-- skip -->
```dart
BuildContext context = /* ... */;
TextEditingController controller = /* ... */;
TextSpan span = controller.buildTextSpan(context: context, withComposing: false);
```

## Timeline

Landed in version: 1.26.0<br>
In stable release: 2.0.0

## References

API documentation:

* [`TextEditingController.buildTextSpan`][]

Relevant issues:

* [Issue #72343][]

Relevant PRs:

* [Reland "Add BuildContext parameter to TextEditingController.buildTextSpan" #73510][]
* [Revert "Add BuildContext parameter to TextEditingController.buildTextSpan" #73503][]
* [Add BuildContext parameter to TextEditingController.buildTextSpan #72344][]

[Add BuildContext parameter to TextEditingController.buildTextSpan #72344]: {{site.github}}/flutter/flutter/pull/72344
[Issue #72343]: {{site.github}}/flutter/flutter/issues/72343
[Reland "Add BuildContext parameter to TextEditingController.buildTextSpan" #73510]: {{site.github}}/flutter/flutter/pull/73510
[Revert "Add BuildContext parameter to TextEditingController.buildTextSpan" #73503]: {{site.github}}/flutter/flutter/pull/73503
[`TextEditingController.buildTextSpan`]: {{site.api}}/flutter/widgets/TextEditingController/buildTextSpan.html
