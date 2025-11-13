---
title: Integration test default golden-file comparators changed on Android and iOS.
description: >-
  When using `package:integration_test` to run a test _on_ an Android device or
  emulator, or an iOS device or simulator, the default `goldenFileComparator`
  has changed, and correctly uses the host filesystem.
---

{% render "docs/breaking-changes.md" %}

## Summary

Unless a user-defined [`goldenFileComparator`][] is set, either manually in a
test, or using a `flutter_test_config.dart` file, Android and iOS devices
and emulators/simulators have a new default that proxies to the local host
filesystem, fixing a long-standing bug ([#143299][Issue 143299]).

## Background

The package [`integration_test`][], and its integration with [`flutter_test`][]
has historically had a bug where using [`matchesGoldenFile`][] or similar APIs
where a `FileSystemException` was thrown.

Some users may have worked around this issue by writing and using a custom
[`goldenFileComparator`][]:

```dart
import 'package:integration_test/integration_test.dart';
import 'package:my_integration_test/custom_golden_file_comparator.dart';

void main() {
  goldenFileComparator = CustomGoldenFileComparatorThatWorks();

  // ...
}
```

Such workarounds are no longer necessary, and if type checking the default,
will no longer work as before:

```dart
if (goldenFileComparator is ...) {
  // The new default is a new (hidden) type that has not existed before.
}
```

## Migration guide

In most cases, we expect users to have to do nothing - this will be in a sense
_new_ functionality that replaced functionality that did not work and caused
an unhandled exception which would fail a test.

In cases where users wrote custom test infrastructure and comparators, consider
instead removing the [`goldenFileComparator`][] overrides, and instead rely on
the (new) default which should work as expected:

```dart diff
  import 'package:integration_test/integration_test.dart';
- import 'package:my_integration_test/custom_golden_file_comparator.dart';

  void main() {
-   goldenFileComparator = CustomGoldenFileComparatorThatWorks();

    // ...
  }
```

_Fun fact_: The existing code that was used for
the _web_ platform was [reused][PR 160484].

## Timeline

Landed in version: 3.29.0-0.0.pre<br>
Stable release: 3.32

## References

Relevant APIs:

- [`flutter_test`][], which talks about `flutter_test_config.dart` and its capabilities.
- [`goldenFileComparator`][], which implements comparison, and is user-configurable.

Relevant Issues:

- [Issue 143299][], one of many user reports about the long-standing bug.
- [Issue 160043][], which explains in technical detail why [`matchesGoldenFile`][] failed.

Relevant PRs:

- [PR 160215][], where the web tool implementation was refactored to make it generic.
- [PR 160484][], which uses the Dart VM service protocol to proxy between device and host.

[`flutter_test`]: {{site.api}}/flutter/flutter_test
[`goldenFileComparator`]: {{site.api}}/flutter/flutter_test/goldenFileComparator.html
[`integration_test`]: {{site.api}}/flutter/package-integration_test_integration_test/
[Issue 143299]: {{site.repo.flutter}}/issues/143299
[Issue 160043]: {{site.repo.flutter}}/issues/160043
[`matchesGoldenFile`]: {{site.api}}/flutter/flutter_test/MatchesGoldenFile-class.html
[PR 160215]: {{site.repo.flutter}}/pull/160215
[PR 160484]: {{site.repo.flutter}}/pull/160484
