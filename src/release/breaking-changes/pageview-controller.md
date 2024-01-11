---
title: Make PageView.controller nullable
description: >-
  PageView.controller converted to be nullable.
---

## Summary

Now, in consistency with other widgets, if controller is
not provided in the widget constructor, the member `controller` is `null`.

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

Landed in version: 3.19.0

## References

Relevant issues:

* [PageView uses global controller, that is never disposed. (Issue 141119)][]

[PageView uses global controller, that is never disposed. (Issue 141119)]: {{site.repo.flutter}}/issues/141119
