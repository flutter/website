---
title: Migration guide for adding AppLifecycleState.hidden
description: AppLifecycleState had an additional hidden state added.
---

{% render "docs/breaking-changes.md" %}

## Summary

A new `hidden` state was added to the [`AppLifecycleState`][] enum to denote
when the application is not visible.

## Context

The `AppLifecycleState` enum is used to indicate which lifecycle state the
application is in when [`WidgetsBindingObserver.didChangeAppLifecycleState`][]
is called.

## Description of change

The new state `AppLifecycleState.hidden` was added to the `AppLifecycleState`
enum in the `dart:ui` package.

The `hidden` state is entered when all of the application views are no longer
visible to the user. On Android and iOS, this state is entered briefly whenever
the state machine traverses from inactive to paused, or from paused to inactive.
It doesn't change when paused or inactive are entered. On other platforms, it
will be in this state while the application is not visible.

## Migration guide

If code has switch statements that handle all cases of the `AppLifecycleState`
enum, a new case will need to be added to handle the `AppLifecycleState.hidden`
state.

Code before migration:

```dart
void didChangeAppLifecycleState(AppLifecycleState state) {
  switch (state) {
    case AppLifecycleState.resumed:
    case AppLifecycleState.inactive:
      // Do something when the app is visible...
      break;
    case AppLifecycleState.paused:
    case AppLifecycleState.detached:
      // Do something when the app is not visible...
      break;
  }
}
```

Code after migration:

```dart
void didChangeAppLifecycleState(AppLifecycleState state) {
  switch (state) {
    case AppLifecycleState.resumed:
    case AppLifecycleState.inactive:
      // Do something when the app is visible...
      break;
    case AppLifecycleState.hidden:  // <-- This is the new state.
    case AppLifecycleState.paused:
    case AppLifecycleState.detached:
      // Do something when the app is not visible...
      break;
  }
}
```

If there is already a `default:` case in the switch statement, or the code uses
conditionals instead, then the code will compile without changes, but the
default case or conditional will still need to be evaluated to decide if the
`hidden` state should also be handled.

## Timeline

Landed in version: 3.11.0-16.0.pre<br>
In stable release: 3.13.0

## References

Relevant PRs:

* [PR 42418][]: Adds `AppLifecycleState.hidden` enum value

[PR 42418]: {{site.repo.engine}}/pull/42418
[`WidgetsBindingObserver.didChangeAppLifecycleState`]: {{site.api}}/flutter/widgets/WidgetsBindingObserver/didChangeAppLifecycleState.html
[`AppLifecycleState`]: {{site.api}}/flutter/dart-ui/AppLifecycleState.html
