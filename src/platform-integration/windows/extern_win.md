---
title: External windows in Flutter Windows apps
description: Special considerations for adding external windows to Flutter apps
---

## Windows lifecycle

When adding a non-Flutter window to a Flutter Windows app, it will not be part
of the logic for application lifecycle state updates by default. For example,
this means that when the external window is shown or hidden, the app lifecycle
state will not appropriately update to inactive or hidden. In order to add the
external window to this application logic, the window's `WndProc` procedure
must invoke `FlutterEngine::ProcessExternalWindowMessage`.

Callbacks can be registered to app lifecycle state changes through
[WidgetsBindingObserver.didChangeAppLifecycle][].

An example procedure can be found on the [documentation of this breaking change.][]

[documentation of this breaking change.]: {{site.url}}/release/breaking-changes/win_lifecycle_process_function
[WidgetsBindingObserver.didChangeAppLifecycle]: https://api.flutter.dev/flutter/widgets/WidgetsBindingObserver/didChangeAppLifecycleState.html
