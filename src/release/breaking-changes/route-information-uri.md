---
title: Migration guide for `RouteInformation.location`
description: Deprecation of `RouteInformation.location` and its related APIs.
---

## Summary

`RouteInformation.location` and related APIs were deprecated
in the favor of `RouteInformation.uri`.

## Context

The [`RouteInformation`][] needs the authority information to
handle mobile deeplinks from different web domains.
The `uri` field was added to `RouteInformation` that captures
the entire deeplink information and route-related parameters
were converted to the full [`Uri`][] format.
This led to deprecation of incompatible APIs.

## Description of change

* The `RouteInformation.location` was replaced by `RouteInformation.uri`.
* The `WidgetBindingObserver.didPushRoute` was deprecated.
* The `location` parameter of `SystemNavigator.routeInformationUpdated` was
  replaced by the newly added `uri` parameter.

## Migration guide

Code before migration:

```dart
const RouteInformation myRoute = RouteInformation(location: '/myroute');
```

Code after migration:

```dart
final RouteInformation myRoute = RouteInformation(uri: Uri.parse('/myroute'));
```

Code before migration:

```dart
final String myPath = myRoute.location;
```

Code after migration:

```dart
final String myPath = myRoute.uri.path;
```

Code before migration:

```dart
class MyObserverState extends State<MyWidget> with WidgetsBindingObserver {
  @override
  Future<bool> didPushRoute(String route) => _handleRoute(route);
}
```

Code after migration:

```dart
class MyObserverState extends State<MyWidget> with WidgetsBindingObserver {
  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) => _handleRoute(
    Uri.decodeComponent(
      Uri(
        path: uri.path.isEmpty ? '/' : uri.path,
        queryParameters: uri.queryParametersAll.isEmpty ? null : uri.queryParametersAll,
        fragment: uri.fragment.isEmpty ? null : uri.fragment,
      ).toString(),
    )
  );
}
```

Code before migration:

```dart
SystemNavigator.routeInformationUpdated(location: '/myLocation');
```

Code after migration:

```dart
SystemNavigator.routeInformationUpdated(uri: Uri.parse('/myLocation'));
```

## Timeline

Landed in version: 3.9.0-18.0.pre-93-gf9095ef022<br>
In stable release: TBD

## References

Relevant PRs:

* [PR 119968][]: Implement url support for
  RouteInformation and didPushRouteInformation.

[PR 119968]: {{site.repo.flutter}}/pull/119968
[`RouteInformation`]: {{site.api}}/flutter/widgets/RouteInformation-class.html
[`Uri`]: {{site.api}}/flutter/dart-core/Uri-class.html
