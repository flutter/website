---
title: Migration guide for describeEnum
description: Removal of describeEnum and how to migrate
---

## Summary

The global method `describeEnum` has been deprecated. Existing uses
of `describeEnum(Enum.something)` should use
`Enum.something.name` instead.

## Context

Dart 2.17 introduced enhanced enums. With them, Enum became a type
and all enums got a `name` getter, which made `describeEnum` redundant.

The `describeEnum` method was used to convert an enum value to a string,
since `Enum.something.toString()` would produce `Enum.something` instead
of `something`, which a lot of users wanted. Now, the `name` getter does this.

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

print(describeEnum(MyEnum.paper)); // output: paper
```

Code after migration:

<!-- skip -->
```dart
enum MyEnum { paper, rock }

print(MyEnum.paper.name); // output: paper
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
