---
title: Deprecate `containsSemantics` in favor of `isSemantics`
description: >
  The `containsSemantics` matcher has been deprecated in favor of
  `isSemantics` and `matchesSemantics` matchers.
---

{% render "docs/breaking-changes.md" %}

## Summary

The `containsSemantics` partial matcher is deprecated and replaced by
`isSemantics` to clarify intent and standardize matcher conventions.

## Context

The `contains` prefix for partial matchers, such as `containsSemantics`, has been 
replaced with `is` to align with naming conventions:

* **Partial matchers** (e.g. `isSemantics`) match only the properties explicitly
  provided. Any arguments not provided are ignored.
* **Exact matchers** (e.g. `matchesSemantics`) verify all values. Any arguments 
  not provided are expected to match the object's default values.

## Migration guide

To automatically migrate your code, run the following command:

```bash
dart fix --apply
```

Alternatively, replace `containsSemantics` with `isSemantics` for partial
matching (most common case), or `matchesSemantics` if you need to assert 
exact property values (including defaults for omitted arguments).

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