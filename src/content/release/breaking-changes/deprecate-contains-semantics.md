---
title: Deprecate `containsSemantics` in favor of `isSemantics`
description: >
  The `containsSemantics` matcher has been deprecated in favor of
  `isSemantics` and `matchesSemantics` matchers.
---

{% render "docs/breaking-changes.md" %}

## Summary

The `containsSemantics` matcher is deprecated and replaced by `isSemantics` 
(for partial matching) and `matchesSemantics` (for exact matching) to clarify 
intent and standardize matcher conventions.

## Background

The `containsSemantics` matcher was ambiguous about whether it performed 
partial or exact matching on semantics properties. To resolve this and align 
with a new naming convention for matchers:

*   **Partial matchers** (like `isSemantics`) only match the properties you 
    explicitly provide. Arguments not provided are ignored
    (treated as wildcards).
*   **Exact matchers** (like `matchesSemantics`) match all values. Arguments 
    not provided are expected to match the default values of the object.

This change codifies this convention and deprecates `containsSemantics` in 
favor of more explicit options.

## Migration guide

Replace `containsSemantics` with `isSemantics` for partial matching (most 
common case), or `matchesSemantics` if you need to assert exact property 
values (including defaults for omitted arguments).

Code before migration:

```dart
expect(
  tester.getSemantics(find.byType(MyWidget)),
  containsSemantics(
    label: 'My Widget',
    isButton: true,
  ),
);
```

Code after migration:

```dart
expect(
  tester.getSemantics(find.byType(MyWidget)),
  isSemantics(
    label: 'My Widget',
    isButton: true,
  ),
);
```

## Timeline

Landed in version: 3.40.0-1.0.pre
In stable release: 3.40

## References

API documentation:

* [`isSemantics`][]
* [`matchesSemantics`][]

Relevant issues:

* [Issue 180534][]
* [Issue 107859][]

Relevant PR:

* [PR 180538][]

<!-- Stable channel link: -->
[`isSemantics`]: {{site.api}}/flutter/flutter_test/isSemantics.html
[`matchesSemantics`]: {{site.api}}/flutter/flutter_test/matchesSemantics.html
[Issue 180534]: {{site.repo.flutter}}/issues/180534
[Issue 107859]: {{site.repo.flutter}}/issues/107859
[PR 180538]: {{site.repo.flutter}}/pull/180538