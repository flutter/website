---
title: Dart 3 API removals & no unsound null safety support.
description: Dart 3 will remove several deprecated APIs, and the ability to use unsound null safety.
---

## Summary

The Dart language is preparing for a new major release, [Dart 3], in which
there will be several breaking changes:

* **No unsound null safety**: All code must run with sound null safety.
* **Removal of deprecated core library APIs**: Several currently deprecated API
  members in Dart core libraries are being removed.

## Timeline

The Dart team expects this release by mid 2023. The Flutter team expects to
include this release in a Flutter SDK release around the same time.

## No unsound null safety

The Dart team is removing support for unsound null safety in Dart 3: 
[Dart breaking change #49530]. Concretely this implies that Dart 3 will **not
support**:

1. Code using an SDK constraint where the min-constraint isn't at least 2.12
   (e.g. `sdk: ">=2.7.0"` will be disallowed and won't resolve).

1. Libraries using [per-library language version markers] selecting versions
   less than 2.12 (e.g. `// @dart=2.9` will be disallowed).

### Backwards compatibility for null safe packages

Dart 3 sound null safety will be **backwards compatible** with with code already
migrated to use null safety in language versions 2.12 and later.
 
This means that a Dart 3.0 SDK will allow SDK constraints where the lower-bound
is at least `2.12`, even when the SDK upper-bound only allows versions less than
3 (`<3.0`). For example, a package with the following constraint will be allowed
to resolve with a Dart 3.x SDK:

```
environment:
  sdk: '>=2.12.0 <3.0.0'
```

This allows developers to use Dart 3 sound null safety with packages that have been migrated to 2.12 null safety.

### Migration guide

All code must be migrated to use full sound null safety. For details, see the
[Dart null safety migration guide].

## Removal of deprecated core library APIs

Several currently `@deprecated` API members in the Dart core libraries are being
removed in Dart 3.

We believe these changes to have low impact on code migrated to use null safety.
When we release the first Dart 3 alpha build -- in early 2032 -- you will be
able to quickly test if any of these smaller breaking changes apply to your
packages or apps.

### Migration guide

Please see notes in the Dart breaking changes for these API removals:

* [Dart 3 API removal, part I][Dart breaking change #34233]
* [Dart 3 API removal, part II][Dart breaking change #49529]

## References

* [Dart breaking change #49530]
* [Dart breaking change #34233]
* [Dart breaking change #49529]

[Dart 3]: https://medium.com/dartlang/the-road-to-dart-3-afdd580fbefa
[Dart null safety migration guide]: {{site.dart-site}}/null-safety/migration-guide
[Dart breaking change #49530]: https://github.com/dart-lang/sdk/issues/49530
[Dart breaking change #34233]: https://github.com/dart-lang/sdk/issues/34233
[Dart breaking change #49529]: https://github.com/dart-lang/sdk/issues/49529
[Dart null safety migration guide]: {{site.dart-site}}/null-safety/migration-guide
[per-library language version markers]: {{site.dart-site}}/guides/language/evolution#per-library-language-version-selection
