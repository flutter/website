---
title: Migration guide for describeEnum and EnumProperty
description: Removal of describeEnum and how to migrate
---

## Summary

The global method `describeEnum` has been deprecated. Previous uses
of `describeEnum(Enum.something)` should use
`Enum.something.name` instead.

The class EnumProperty was modified to extend `<T extends Enum?>` instead of `<T>`. Existing uses of `EnumProperty<NotAnEnum>` should use `DiagnosticsProperty<NotAnEnum>` instead.

## Context

Dart 2.17 introduced [enhanced enums][], which added `Enum` as a type.
As a result, all enums got a `name` getter, which made `describeEnum`
redundant. Before that, enum classes were often analyzed using an
`EnumProperty`.

The `describeEnum` method was used to convert an enum value to a string,
since `Enum.something.toString()` would produce `Enum.something` instead
of `something`, which a lot of users wanted. Now, the `name` getter does this.

The `describeEnum` function is being deprecated, so the `EnumProperty` class is updated to only accept `Enum` objects.

## Description of change

Remove `describeEnum`.

- Replace `describeEnum(Enum.something)` with `Enum.something.name`.

The `EnumProperty` now expects null or an `Enum`;
you can no longer pass it a non-`Enum` class.

## Migration guide

If you previously used `describeEnum(Enum.field)` to access the string value from
an enum, you can now call `Enum.field.name`.

If you previously used `EnumProperty<NotAnEnum>`, you can now use the generic `DiagnosticsProperty<NotAnEnum>`.

Code before migration:

```dart
enum MyEnum { paper, rock }

print(describeEnum(MyEnum.paper)); // output: paper

// TextInputType is not an Enum
properties.add(EnumProperty<TextInputType>( ... ));
```

Code after migration:

```dart
enum MyEnum { paper, rock }

print(MyEnum.paper.name); // output: paper

// TextInputType is not an Enum
properties.add(DiagnosticsProperty<TextInputType>( ... ));
```

## Timeline

Landed in version: TBD<br>
In stable release: not yet

## References

API documentation:

* [`describeEnum` stable][]
* [`describeEnum` main][]
* [`EnumProperty` stable][]
* [`EnumProperty` main][]
* [enhanced enums]: https://github.com/dart-lang/language/blob/main/working/0158%20-%20Enhanced%20Enum/proposal.md

Relevant issues:

* [Cleanup SemanticsFlag and SemanticsAction issue][]

Relevant PRs:

* [Deprecate `describeEnum` PR][]

[`describeEnum` stable]: {{site.api}}/flutter/lib/src/foundation/describeEnum.html

[`EnumProperty` stable]: {{site.api}}/flutter/lib/src/foundation/EnumProperty.html

<!-- Master channel link: -->
{% include docs/master-api.md %}

[`describeEnum` main]: {{site.master-api}}/flutter/lib/src/foundation/describeEnum.html

[`EnumProperty` main]: {{site.master-api}}/flutter/lib/src/foundation/describeEnum.html

[Cleanup SemanticsFlag and SemanticsAction issue][cleanup-issue]

[cleanup-issue]: {{site.repo.flutter}}/issues/123346

[Deprecate `describeEnum` PR]: {{site.repo.flutter}}/pull/125016
