---
title: Hosting native macOS views in your Flutter app with Platform Views
short-title: macOS platform-views
description: Learn how to host native macOS views in your Flutter app with Platform Views.
---

<?code-excerpt path-base="platform_integration/platform_views"?>

Platform views allow you to embed native views in a Flutter app, so you can
apply transforms, clips, and opacity to the native view from Dart.

This allows you, for example, to use the native web views directly inside your
Flutter app.

:::note
This page discusses how to host your own native macOS views within a Flutter
app.
If you'd like to embed native Android views in your Flutter app,
see [Hosting native Android views][].
If you'd like to embed native iOS views in your Flutter app,
see [Hosting native iOS views][].
:::

[Hosting native Android views]: /platform-integration/android/platform-views
[Hosting native iOS views]: /platform-integration/ios/platform-views

:::note Version note
Platform view support on macOS isn't fully functional as of the current release.
For example, gesture support isn't yet available on macOS.
Stay tuned for a future stable release.
:::
macOS uses Hybrid composition, which means that the native `NSView` is appended
to the view hierarchy.

To create a platform view on macOS, use the following instructions:

## On the Dart side

On the Dart side, create a `Widget` and add the build implementation, as shown
in the following steps.

In the Dart widget file, make changes similar to those 
shown in `native_view_example.dart`:

<ol>
<li>

Add the following imports:

<?code-excerpt "lib/native_view_example_4.dart (import)"?>
```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
```

</li>

<li>

Implement a `build()` method:

<?code-excerpt "lib/native_view_example_4.dart (macos-composition)"?>
```dart
Widget build(BuildContext context) {
  // This is used in the platform side to register the view.
  const String viewType = '<platform-view-type>';
  // Pass parameters to the platform side.
  final Map<String, dynamic> creationParams = <String, dynamic>{};

  return AppKitView(
    viewType: viewType,
    layoutDirection: TextDirection.ltr,
    creationParams: creationParams,
    creationParamsCodec: const StandardMessageCodec(),
  );
}
```

</li>
</ol>

For more information, see the API docs for: [`AppKitView`][].

[`AppKitView`]: {{site.api}}/flutter/widgets/AppKitView-class.html

## On the platform side

Implement the factory and the platform view. The `NativeViewFactory` creates the
platform view, and the platform view provides a reference to the `NSView`. For
example, `NativeView.swift`:

```swift
import Cocoa
import FlutterMacOS

class NativeViewFactory: NSObject, FlutterPlatformViewFactory {
  private var messenger: FlutterBinaryMessenger

  init(messenger: FlutterBinaryMessenger) {
    self.messenger = messenger
    super.init()
  }

  func create(
    viewIdentifier viewId: Int64,
    arguments args: Any?
  ) -> FlutterPlatformView {
    return NativeView(
      viewIdentifier: viewId,
      arguments: args,
      binaryMessenger: messenger)
  }

  /// Implementing this method is only necessary when the `arguments` in `createWithFrame` is not `nil`.
  public func createArgsCodec() -> (FlutterMessageCodec & NSObjectProtocol)? {
    return FlutterStandardMessageCodec.sharedInstance()
  }
}

class NativeView: NSView {
  private var _view: NSView

  init(
    frame: CGRect,
    viewIdentifier viewId: Int64,
    arguments args: Any?,
    binaryMessenger messenger: FlutterBinaryMessenger?
  ) {
    _view = NSView()
    super.init(frame: frame)
    // macOS views can be created here
    createNativeView(view: _view)
  }

  func createNativeView(view _view: NSView) {
    _view.wantsLayer = true
    _view.layer?.backgroundColor = NSColor.systemBlue.cgColor
    _view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)

    let nativeLabel = NSTextField()
    nativeLabel.frame = CGRect(x: 0, y: 0, width: 180, height: 48.0)
    nativeLabel.stringValue = "Native text from macOS"
    nativeLabel.textColor = NSColor.white
    nativeLabel.font = NSFont.systemFont(ofSize: 14)
    nativeLabel.isBezeled = false
    nativeLabel.focusRingType = .none
    nativeLabel.isEditable = true
    nativeLabel.sizeToFit()
    _view.addSubview(nativeLabel)
  }
}
```

Finally, register the platform view. This can be done in an app or a plugin.

For app registration, modify the App's `MainFlutterWindow.swift`:

```swift
import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    // ...

    let registrar = flutterViewController.registrar(forPlugin: "plugin-name")
    let factory = NativeViewFactory(messenger: registrar.messenger)
    registrar.register(
      factory,
      withId: "<platform-view-type>")
  }
}
```

For plugin registration, modify the plugin's main file (for example,
`Plugin.swift`):

```swift
import Cocoa
import FlutterMacOS

public class Plugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let factory = NativeViewFactory(messenger: registrar.messenger)
    registrar.register(factory, withId: "<platform-view-type>")
  }
}
```

For more information, see the API docs for:

* [`FlutterPlatformViewFactory`][]
* [`FlutterPlatformView`][]
* [`PlatformView`][]

[`FlutterPlatformView`]: {{site.api}}/ios-embedder/protocol_flutter_platform_view-p.html
[`FlutterPlatformViewFactory`]: {{site.api}}/ios-embedder/protocol_flutter_platform_view_factory-p.html
[`PlatformView`]: {{site.api}}/javadoc/io/flutter/plugin/platform/PlatformView.html

## Putting it together

When implementing the `build()` method in Dart,
you can use [`defaultTargetPlatform`][]
to detect the platform, and decide which widget to use:

<?code-excerpt "lib/native_view_example_4.dart (together-widget)"?>
```dart
Widget build(BuildContext context) {
  // This is used in the platform side to register the view.
  const String viewType = '<platform-view-type>';
  // Pass parameters to the platform side.
  final Map<String, dynamic> creationParams = <String, dynamic>{};

  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
    // return widget on Android.
    case TargetPlatform.iOS:
    // return widget on iOS.
    case TargetPlatform.macOS:
    // return widget on macOS.
    default:
      throw UnsupportedError('Unsupported platform view');
  }
}
```

[`defaultTargetPlatform`]: {{site.api}}/flutter/foundation/defaultTargetPlatform.html

## Performance
Platform views in Flutter come with performance trade-offs.

For example, in a typical Flutter app, the Flutter UI is composed on a dedicated
raster thread. This allows Flutter apps to be fast, as this thread is rarely
blocked.

When a platform view is rendered with hybrid composition, the Flutter UI
continues to be composed from the dedicated raster thread, but the platform view
performs graphics operations on the platform thread. To rasterize the combined
contents, Flutter performs synchronization between its raster thread and the
platform thread. As such, any slow or blocking operations on the platform thread
can negatively impact Flutter graphics performance.
