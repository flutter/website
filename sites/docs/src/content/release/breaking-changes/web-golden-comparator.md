---
title: Web-specific golden comparisons are no longer supported
description: >-
  The `WebGoldenComparator` class and `webGoldenComparator` top-level instance
  are deprecated, pending removal, and the web rendering backends (including
  both CanvasKit and skWasm) now use `GoldenFileComparator` and
  `goldenFileComparator` directly.
---

{% render "docs/breaking-changes.md" %}

## Summary

The `flutter_test` package and `flutter` tool will no longer use the
[`webGoldenComparator`][] top-level variable, and instead use the original
[`goldenFileComparator`][] top-level variable (like the non-web platforms).

For _users_ of `flutter_test`, these changes will be made automatically.

## Background

Originally, [`WebGoldenComparator`][class-WebGoldenComparator] was added for
the HTML-backend of Flutter web, as it was not possible to create an encoded
PNG (byte buffer), and a new API was needed. As [the HTML backend is being
deprecated and removed][Issue 145954], this separate API is no longer necessary.

## Migration guide

For most users, no changes are required (other than migrating off the HTML
backend, which is not covered here), the `flutter` tool will automatically
configure [`goldenFileComparator`][] and use it (when using a non-HTML web
backend).

For users that implement a custom [`WebGoldenComparator`][], you will
migrate the implemenation to [`GoldenFileComparator`][]. Fortunately the
Canvas Kit and SkWasm backends already required similar methods (`compareButes`
and `updateBytes`).

For example:

```dart
// Before
class MyWebGoldenComparator extends WebGoldenComparator {
  @override
  Future<bool> compare(double width, double height, Uri golden) {
    // will be removed in the migration
  }

  @override
  Future<bool> update(double width, double height, Uri golden) {
    // will be removed in the migration
  }

  @override
  Future<bool> compareBytes(Uint8List bytes, Uri golden) {
    // will be renamed "compare"
  }

  @override
  Future<bool> updateBytes(Uint8List bytes, Uri golden) {
    // will be renamed "update" and the parameter orders swapped
  }
}

// After
class MyGenericGoldenComparator extends GoldenFileComparator {
  @override
  Future<bool> compare(Uint8List bytes, Uri golden) {
    // used to be "compareBytes"
  }

  @override
  Future<bool> update(Uri golden, Uint8List bytes) {
    // used to be "updateBytes"
  }
}
```

## Timeline

Landed in version: 3.29.0-0.0.pre<br>
In stable release: 3.29

## References

Relevant Issues:

- [Issue 145954][], where the HTML renderer was deprecated.
- [Issue 160261][], where it was proposed to consolidate `GoldenFileComparator` and `WebGoldenComparator`.

Relevant PRs:

- [PR 161196][], where `WebGoldenComparator` was deprecated and the `flutter` CLI started using `goldenFileComparator`.

[Issue 145954]: {{site.github}}/flutter/flutter/issues/145954
[Issue 160261]: {{site.github}}/flutter/flutter/issues/160261
[PR 161196]: https://github.com/flutter/flutter/pull/161196
[class-WebGoldenComparator]: {{site.api}}/flutter/flutter_test/WebGoldenComparator-class.html
[`webGoldenComparator`]: {{site.api}}/flutter/flutter_test/webGoldenComparator.html
[`goldenFileComparator`]: {{site.api}}/flutter/flutter_test/goldenFileComparator.html
