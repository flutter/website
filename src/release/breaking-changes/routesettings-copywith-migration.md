---
title: Migration guide for RouteSettings copyWith
description: Removal of RouteSettings copyWith and how to migrate
---

## Summary

`RouteSettings.copyWith` was removed, and existing apps needed to use the constructor to create a new `RouteSettings` instead.

## Context

With the introduction of [`Page`][] class,
the `RouteSettings.copyWith` was no longer a viable API.

## Description of change

`RouteSettings.copyWith` was removed

## Migration guide

Existing apps:

```dart
RouteSettings newSettings = oldSettings.copyWith(name: 'new name');
```

After migrations:

```dart
RouteSettings newSettings = RouteSettings(name: 'new name', arguments: oldSettings.arguments);
```


## Timeline

Landed in version: 3.5.0-9.0.pre-137-gc6f6095acd<br>
In stable release: TBD

## References

Relevant PRs:

* [PR 113860][]: Removes RouteSetting.copyWith.

[PR 113860]: {{site.repo.flutter}}/pull/113860
[`Page`]: {{site.api}}/flutter/widgets/Page-class.html
