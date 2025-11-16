---
title: The Form widget no longer supports being a sliver.
description: >-
  The Form widget now includes a semantics widget,
  which prevents it from being used directly as a sliver.
---

{% render "docs/breaking-changes.md" %}

## Summary

Previously, the Form widget essentially acted as a direct wrapper
around its child. This design allowed a Form containing a sliver child
(e.g., Form(child: other sliver)) to be treated as a sliver itself
 within a CustomScrollView or similar scrollable parent.

However, This PR introduced a new semantics widget
within the Form widget's internal structure. This change alters
its rendering behavior, meaning Form can no longer directly
function as a sliver.

## Context

This change is part of an ongoing effort to improve the
accessibility and semantic understanding of Flutter widgets.
By embedding a semantics widget directly within Form, the framework
can provide better information to accessibility services.

## Description of change

The core change is the integration of a semantics widget
into the Form widget's build method.

## Migration guide

If your app does not currently use the Form widget directly
as a sliver within a scrollable list
(e.g., as a direct child of CustomScrollView's slivers property),
then no changes are required.

If your app use Form as a sliver, you will need to wrap the Form
widget within a SliverToBoxAdapter. SliverToBoxAdapter is a
sliver that contains a single box widget, converting a regular
widget into a sliver that can be placed in a CustomScrollView.

Code before migration:

```dart
sliver: Form(
    key: controller.formKey,
    child: SomeWidgetWithFormFields(),
)
```

Code after migration:

```dart
sliver: SliverToBoxAdapter(
    child: Form(
        key: controller.formKey,
        child: SomeWidgetWithFormFields(),
    )
)
```

## Timeline

Landed in version: 3.35.0-pre<br>
In stable release: 3.35

## References

API documentation:

* [`Form`]({{site.api}}/flutter/widgets/Form-class.html)

Relevant issues:

* [Issue 161628]({{site.repo.flutter}}/issues/161628)

Relevant PRs:

* [PR 170709: Add semantics role for form]({{site.repo.flutter}}/pull/170709)
