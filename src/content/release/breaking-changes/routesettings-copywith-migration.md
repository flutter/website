---
title: Migration guide for RouteSettings copyWith
description: Removal of RouteSettings copyWith and how to migrate
---

## Summary

The `RouteSettings.copyWith` method is removed, and apps that use
it need to use the constructor to create a new `RouteSettings`
instance instead.

## Context

With the introduction of the [`Page`][] class,
the `RouteSettings.copyWith` was no longer a viable API.

## Description of change

`RouteSettings.copyWith` was removed

## Migration guide

Code before migration:

```dart
RouteSettings newSettings = oldSettings.copyWith(name: 'new name');
```

Code after migration:

```dart
RouteSettings newSettings = RouteSettings(name: 'new name', arguments: oldSettings.arguments);
```

## Timeline

Landed in version: 3.5.0-9.0.pre-137-gc6f6095acd<br>
In stable release: 3.7

## References

Relevant PRs:

* [PR 113860][]: Removes RouteSetting.copyWith.

[PR 113860]: {{site.repo.flutter}}/pull/113860
[`Page`]: {{site.api}}/flutter/widgets/Page-class.html
