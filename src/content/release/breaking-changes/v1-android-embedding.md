---
title: Removal of v1 Android embedding Java APIs
description: Deletion of the Android v1 embedding.
---

## Summary

The v1 embedding has been removed in Flutter 3.29.0. 
This follows the deprecation described in 
[Android v1 embedding app and plugin creation deprecation][].
The following is a full list of classes removed.
```text
io.flutter.app.FlutterActivity;
io.flutter.app.FlutterActivityDelegate;
io.flutter.app.FlutterActivityEvents;
io.flutter.app.FlutterApplication;
io.flutter.app.FlutterFragmentActivity
io.flutter.app.FlutterPlayStoreSplitApplication
io.flutter.app.FlutterPluginRegistry

io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry
io.flutter.embedding.engine.plugins.shim.ShimRegistrar

io.flutter.view.FlutterMain
io.flutter.view.FlutterNativeView
io.flutter.view.FlutterView
```

If your project references any of the above classes, consult the following 
list for instructions on migration.

* `io.flutter.app.FlutterActivity` was replaced with `io.flutter.embedding.android.FlutterActivity`.
* `io.flutter.app.FlutterActivityDelegate` was replaced with `io.flutter.embedding.android.FlutterActivityAndFragmentDelegate`.
* `io.flutter.app.FlutterActivityEvents` was removed.
* `io.flutter.app.FlutterApplication` was removed. Flutter projects with custom `Application` implementations should instead extend the base `android.app.Application`. 
* `io.flutter.app.FlutterFragmentActivity` was replaced with `io.flutter.embedding.android.FlutterFragmentActivity`.
* `io.flutter.app.FlutterPlayStoreSplitApplication` was replaced with `io.flutter.embedding.android.FlutterPlayStoreSplitApplication`.
* `io.flutter.app.FlutterPluginRegistry` was removed, as it only served to let plugins support apps using the v1 embedding.
* `io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry` was removed, as it only served to support let plugins support apps using the v1 embedding.
* `io.flutter.embedding.engine.plugins.shim.ShimRegistrar` was removed, as it only served to support let plugins support apps using the v1 embedding.
* `io.flutter.view.FlutterMain` was replaced by `io.flutter.embedding.engine.loader.FlutterLoader`.
* `io.flutter.view.FlutterNativeView` was replaced by `io.flutter.embedding.android.FlutterView`.
* `io.flutter.view.FlutterView` was replaced by `io.flutter.embedding.android.FlutterView`.


[Android v1 embedding app and plugin creation deprecation]: /release/breaking-changes/android-v1-embedding-create-deprecation

## Plugin authors

Plugins which are still supporting v1 embedding Flutter apps through the 
inclusion of the method with the signature
```java
public static void registerWith(@NonNull io.flutter.plugin.common.PluginRegistry.Registrar registrar);
```
in their implementation of the `FlutterPlugin` interface should remove this 
method.