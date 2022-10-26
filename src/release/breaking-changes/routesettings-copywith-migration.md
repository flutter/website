---
title: Migration guide for RouteSettings copyWith
description: Removal of RouteSettings copyWith and how to migrate
---

## Summary

RouteSettings copyWith was removed, and existing apps needed to use the constructor to create a new RouteSettings instead.

## Context

With the introduction of [Page](https://api.flutter.dev/flutter/widgets/Page-class.html) class,
the RouteSettings.copyWith was no longer a viable API.

## Description of change

RouteSettings copyWith was removed

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

Landed in version: 1.20.0-8.0<br>
In stable release: 1.22

## References

Relevant PRs:

* [PR 113860][]: Removes RouteSetting.copyWith
