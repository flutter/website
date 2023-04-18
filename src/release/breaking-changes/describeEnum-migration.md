---
title: Migration guide for describeEnum
description: Removal of describeEnum and how to migrate
---

## Summary

The global method `describeEnum` has been deprecated. Existing uses
of `describeEnum(Enum.something)` should use
`Enum.something.name` instead.

## Context

As Dart introduced the `name` getter in Enums, `describeEnum` became redudant.
The `describeEnum` method was used to convert an enum value to a string.

## Description of change

Remove `describeEnum`.

- Replace `describeEnum(Enum.something)` with `Enum.something.name`.

## Migration guide

If you used `describeEnum(Enum.field)` to acesss the string value from an
enum, you can now call `Enum.field.name`.

Code before migration:

<!-- skip -->
```dart
enum MyEnum { paper, rock }

print(describeEnum(paper)); // output: paper
```

Code after migration:

<!-- skip -->
```dart
enum MyEnum { paper, rock }

print(paper.name); // output: paper
```

## Timeline

Landed in version: TBD<br>
In stable release: not yet

## References

{% include docs/master-api.md %}

API documentation:

* [`describeEnum` stable][]
* [`describeEnum` main][]

Relevant issues:

* [☂️ Cleanup SemanticsFlag and SemanticsAction issue][]

Relevant PRs:

* [Deprecate `describeEnum` PR][]

<!-- Stable channel link: -->
[`describeEnum` stable]: {{site.api}}/flutter/lib/src/foundation/describeEnum.html

<!-- Master channel link: -->
{% include docs/master-api.md %}

[`describeEnum` main]: {{site.master-api}}/flutter/lib/src/foundation/describeEnum.html

[☂️ Cleanup SemanticsFlag and SemanticsAction issue]: {{site.repo.flutter}}/issues/123346
[Deprecate `describeEnum` PR]: {{site.repo.flutter}}/pull/125016
