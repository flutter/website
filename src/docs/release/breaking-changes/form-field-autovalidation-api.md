---
title: The new Form, FormField auto-validation API
description: Gives more control in how we want to auto validate a Form, FormField
---

## Summary

The previous auto validation API for the `Form` and `FormField` widgets
didn't control when the auto validation should occur.
So the auto validation for these widgets always happened on first
build when the widget was first visible to the user,
and you weren't able to control when the auto validation should happen.

## Context

Due to the original API not allowing developers to change the auto validation
behaviour for validating only when the user interacts with the form field,
we added new API that allows developers to configure how they want 
auto validation to behave for the `Form` and `FormField` widgets.

## Description of change

Here are the changes made to address the above problems:

* The `autovalidate` parameter has been deprecated.
* A new parameter called `autovalidateMode`,
  an Enum that accepts values from the `AutovalidateMode` Enum class,
  is added.


## Migration guide

To migrate to the new auto validation API you need to replace the
usage of the deprecated `autovalidate` parameter to the new
`autovalidateMode` parameter. If you want to have the same behavour
as before you can use: `autovalidateMode = AutovalidateMode.always`,
this makes your `Form` and `FormField` widgets auto validate on
first build and every time it changes. 

Code before migration:

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FormField(
      autovalidate: true,
      builder: (FormFieldState state) {
        return Container();
      },
    );
  }
}
```

Code after migration:

<!-- skip -->
```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FormField(
      autovalidateMode: AutovalidateMode.always,
      builder: (FormFieldState state) {
        return Container();
      },
    );
  }
}
```

## Timeline

Landed in version: 1.20<br>
In stable release: not yet

## References

API documentation:
* [`AutovalidateMode`](https://master-api.flutter.dev/flutter/widgets/AutovalidateMode-class.html)

Relevant issues:
* [Issue 56363](https://github.com/flutter/flutter/issues/56363)
* [Issue 18885](https://github.com/flutter/flutter/issues/18885)
* [Issue 15404](https://github.com/flutter/flutter/issues/15404)
* [Issue 36154](https://github.com/flutter/flutter/issues/36154)
* [Issue 48876](https://github.com/flutter/flutter/issues/48876)

Relevant PRs:
* [FormField should autovalidate only if its content was
  changed](https://github.com/flutter/flutter/pull/56365)
* [FormField should autovalidate only if its content was
  changed (fixed)](https://github.com/flutter/flutter/pull/59766)
