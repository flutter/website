---
title: Deprecate `findChildIndexCallback` in favor of `findItemIndexCallback` in `ListView` and `SliverList` separated constructors
description: >-
  The findChildIndexCallback parameter in ListView.separated and
  SliverList.separated have been deprecated in favor of findItemIndexCallback.
---

## Summary

The `findChildIndexCallback` parameter in `ListView.separated` and
`SliverList.separated` constructors have been deprecated in favor of
`findItemIndexCallback`. The new callback returns item indices directly,
eliminating the need for manual index calculations to account for separators.

## Background

In `ListView.separated` and `SliverList.separated` constructors,
the `findChildIndexCallback` was used to locate widgets by their key.
However, this callback returned child indices, which include both items
and separators in the internal widget tree. This meant that developers had to
multiply item indices by 2 to get the correct child index, creating
confusion and error-prone code.

The new `findItemIndexCallback` parameter simplifies this by working
directly with item indices, which do not include separators.
This makes the API more intuitive and reduces the likelihood of
index calculation errors.

If you use the deprecated `findChildIndexCallback` parameter,
you will see a deprecation warning:

```
'findChildIndexCallback' is deprecated and shouldn't be used.
Use findItemIndexCallback instead.
findChildIndexCallback returns child indices (which include separators),
while findItemIndexCallback returns item indices (which do not).
If you were multiplying results by 2 to account for separators,
you can remove that workaround when migrating to findItemIndexCallback.
This feature was deprecated after v3.37.0-1.0.pre.
```

Additionally, if you try to provide both parameters, you will encounter
an assertion error:

```
Cannot provide both findItemIndexCallback and findChildIndexCallback.
Use findItemIndexCallback as findChildIndexCallback is deprecated.
```

## Migration guide

To migrate from `findChildIndexCallback` to `findItemIndexCallback`,
replace the parameter name and remove any index multiplications
that were used to account for separators.

Code before migration:

```dart
ListView.separated(
  itemCount: items.length,
  findChildIndexCallback: (Key key) {
    final ValueKey<String> valueKey = key as ValueKey<String>;
    final int itemIndex = items.indexOf(valueKey.value);
    // Multiply by 2 to account for separators
    return itemIndex == -1 ? null : itemIndex * 2;
  },
  itemBuilder: (BuildContext context, int index) {
    return ListTile(
      key: ValueKey<String>(items[index]),
      title: Text(items[index]),
    );
  },
  separatorBuilder: (BuildContext context, int index) => const Divider(),
)
```

Code after migration:

```dart
ListView.separated(
  itemCount: items.length,
  findItemIndexCallback: (Key key) {
    final ValueKey<String> valueKey = key as ValueKey<String>;
    final int itemIndex = items.indexOf(valueKey.value);
    // Return item index directly - no need to multiply by 2
    return itemIndex == -1 ? null : itemIndex;
  },
  itemBuilder: (BuildContext context, int index) {
    return ListTile(
      key: ValueKey<String>(items[index]),
      title: Text(items[index]),
    );
  },
  separatorBuilder: (BuildContext context, int index) => const Divider(),
)
```

The same migration applies to `SliverList.separated`:

Code before migration:

```dart
SliverList.separated(
  itemCount: items.length,
  findChildIndexCallback: (Key key) {
    final ValueKey<String> valueKey = key as ValueKey<String>;
    final int itemIndex = items.indexOf(valueKey.value);
    return itemIndex == -1 ? null : itemIndex * 2;
  },
  itemBuilder: (BuildContext context, int index) {
    return Container(
      key: ValueKey<String>(items[index]),
      child: Text(items[index]),
    );
  },
  separatorBuilder: (BuildContext context, int index) => const Divider(),
)
```

Code after migration:

```dart
SliverList.separated(
  itemCount: items.length,
  findItemIndexCallback: (Key key) {
    final ValueKey<String> valueKey = key as ValueKey<String>;
    final int itemIndex = items.indexOf(valueKey.value);
    return itemIndex == -1 ? null : itemIndex;
  },
  itemBuilder: (BuildContext context, int index) {
    return Container(
      key: ValueKey<String>(items[index]),
      child: Text(items[index]),
    );
  },
  separatorBuilder: (BuildContext context, int index) => const Divider(),
)
```

## Timeline

Landed in version: 3.38.0-1.0.pre<br>
In stable release: Not yet

## References

API documentation:

* [`ListView.separated`][]
* [`SliverList.separated`][]

Relevant PRs:

* [Deprecate findChildIndexCallback for separated constructors][]

[`ListView.separated`]: {{site.api}}/flutter/widgets/ListView/ListView.separated.html
[`SliverList.separated`]: {{site.api}}/flutter/widgets/SliverList/SliverList.separated.html
[Deprecate findChildIndexCallback for separated constructors]: {{site.repo.flutter}}/pull/174491
