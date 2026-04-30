---
title: Make PageView.controller nullable
description: >-
  PageView.controller is now nullable.
---

{% render "docs/breaking-changes.md" %}

## Summary

If a controller isn't provided in the constructor,
the `controller` member is `null`. This makes
`PageView` and its `controller` property consistent with other widgets.

## Migration guide

Before:

```dart
pageView.controller.page
```

After:

```dart
pageView.controller!.page
```

## Timeline

Landed in version: 3.19.0-12.0.pre<br>
In stable release: 3.22.0

## References

Relevant issues:

* [PageView uses global controller, that is never disposed. (Issue 141119)][]

[PageView uses global controller, that is never disposed. (Issue 141119)]: {{site.repo.flutter}}/issues/141119
