---
title: Migration guide for describeEnum and EnumProperty
description: Learn about the removal of describeEnum and how to migrate.
---

{% render "docs/breaking-changes.md" %}

## Summary

The global method `describeEnum` has been deprecated. Previous uses
of `describeEnum(Enum.something)` should use
`Enum.something.name` instead.

The class `EnumProperty` was modified to
extend `<T extends Enum?>` instead of `<T>`.
Existing uses of `EnumProperty<NotAnEnum>` should
use `DiagnosticsProperty<NotAnEnum>` instead.

## Context

Dart 2.17 introduced [enhanced enums][], which added `Enum` as a type.
As a result, all enums got a `name` getter, which made `describeEnum`
redundant. Before that, enum classes were often analyzed using an
`EnumProperty`.

The `describeEnum` method was used to convert an enum value to a string,
since `Enum.something.toString()` would produce `Enum.something` instead
of `something`, which a lot of users wanted. Now, the `name` getter does this.

The `describeEnum` function is being deprecated,
so the `EnumProperty` class is updated to only accept `Enum` objects.

[enhanced enums]: {{site.dart-site}}/language/enums#declaring-enhanced-enums

## Description of change

Remove `describeEnum`.

- Replace `describeEnum(Enum.something)` with `Enum.something.name`.

The `EnumProperty` now expects null or an `Enum`;
you can no longer pass it a non-`Enum` class.

## Migration guide

If you previously used `describeEnum(Enum.field)` to access the
string value from an enum, you can now call `Enum.field.name`.

If you previously used `EnumProperty<NotAnEnum>`, you can
now use the generic `DiagnosticsProperty<NotAnEnum>`.

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

Landed in version: 3.14.0-2.0.pre<br>
In stable release: 3.16

## References

API documentation:

* [`describeEnum`][]
* [`EnumProperty`][]

Relevant issues:

* [Cleanup SemanticsFlag and SemanticsAction issue][]

Relevant PRs:

* [Deprecate `describeEnum` PR][]

[`describeEnum`]: {{site.api}}/flutter/foundation/describeEnum.html
[`EnumProperty`]: {{site.api}}/flutter/foundation/EnumProperty-class.html

[Cleanup SemanticsFlag and SemanticsAction issue]: {{site.repo.flutter}}/issues/123346
[Deprecate `describeEnum` PR]: {{site.repo.flutter}}/pull/125016
