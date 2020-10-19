---
title: Hosting native Android and iOS views in your Flutter app with Platform Views
short-title: Platform-views
description: Learn how to host native Android and iOS views in your Flutter app with Platform Views.
---

Platform views allow to embed native views in a Flutter app, so
you can apply transforms, clips, and opacity to the native view
from Dart.

This allows you, for example, to use the native
Google Maps from the Android and iOS SDKs
directly inside your Flutter app, by using Platform Views.

This page discusses how to host your own native views
within a Flutter app.

## Android

Flutter supports two modes: Virtual displays and Hybrid composition.

Which one to use depends on the use case. Let's take a look:

* Virtual displays renders the `android.view.View` instance to a texture,
  so it's not embedded within the Android Activity's view hierachy.
  Certain platform interactions such as keyboard handling, and accessibility
  features might not work.

* Hybrid composition requires Flutter 1.22. This mode appends the
  native `android.view.View` to the view hierarchy. Therefore, keyboard
  handling, and accessibility work out of the box. Prior to Android 10,
  this mode may significantly reduce the frame throughput (FPS) of the
  Flutter UI. See [performance][] for more.

To create a platform view on Android, follow these steps:

### On the Dart side

On the Dart side, create a `Widget`
and add the following build implementation,
as shown in the following steps.

{{site.alert.warning}}
  For this to work, your plugin or app must use Android embedding v2.
  If you haven't updated your plugin, see the
  [plugin migration guide][].
{{site.alert.end}}


#### Hybrid Composition

In your Dart file, for example `native_view_example.dart`,
do the following:

1. Add the following imports:

<!-- skip -->
```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
```

2. Implement a `build()` method:

<!-- skip -->
```dart
Widget build(BuildContext context) {
  // This is used in the platform side to register the view.
  final String viewType = '<platform-view-type>';
  // Pass parameters to the platform side.
  final Map<String, dynamic> creationParams = <String, dynamic>{};

  return PlatformViewLink(
    viewType: viewType,
    surfaceFactory:
        (BuildContext context, PlatformViewController controller) {
      return AndroidViewSurface(
        controller: controller,
        gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
        hitTestBehavior: PlatformViewHitTestBehavior.opaque,
      );
    },
    onCreatePlatformView: (PlatformViewCreationParams params) {
      return PlatformViewsService.initSurfaceAndroidView(
        id: params.id,
        viewType: viewType,
        layoutDirection: TextDirection.ltr,
        creationParams: creationParams,
        creationParamsCodec: StandardMessageCodec(),
      )
        ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
        ..create();
    },
  );
}
```

For more information, see the API docs for:

* [`PlatformViewLink`][]
* [`AndroidViewService`][]
* [`PlatformViewsService`][]

#### Virtual Display

In your Dart file, for example `native_view_example.dart`,
do the following:

1. Add the following imports:

<!-- skip -->
```dart
import 'package:flutter/widget.dart';
```

2. Implement a `build()` method:

<!-- skip -->
```dart
Widget build(BuildContext context) {
  // This is used in the platform side to register the view.
  final String viewType = 'hybrid-view-type';
  // Pass parameters to the platform side.
  final Map<String, dynamic> creationParams = <String, dynamic>{};

  return AndroidView(
    viewType: viewType,
    layoutDirection: TextDirection.ltr,
    creationParams: creationParams,
    creationParamsCodec: const StandardMessageCodec(),
  );
}
```

For more information, see the API docs for:

* [`AndroidView`][]

### On the platform side

On the platform side, use the standard
`io.flutter.plugin.platform` package in either Java or Kotlin:


{% samplecode android-platform-views %}
{% sample Kotlin %}

In your native code, implement the following:

Extend `io.flutter.plugin.platform.PlatformView` to provide a reference to the `android.view.View`,
For example `NativeView.kt`:

```kotlin
package dev.flutter.example

import android.content.Context
import android.graphics.Color
import android.view.View
import android.widget.TextView
import io.flutter.plugin.platform.PlatformView

internal class NativeView(context: Context, id: Int, creationParams: Map<String?, Any?>?) : PlatformView {
    private val textView: TextView

    override fun getView(): View {
        return textView
    }

    override fun dispose() {}

    init {
        textView = TextView(context)
        textView.textSize = 72f
        textView.setBackgroundColor(Color.rgb(255, 255, 255))
        textView.text = "Rendered on a native Android view (id: $id)"
    }
}
```

Create a factory class that creates an instance of the `NativeView` created earlier,
for example `NativeViewFactory.kt`:


```kotlin
package dev.flutter.example

import android.content.Context
import android.view.View
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

internal class NativeViewFactory(private val messenger: BinaryMessenger, private val containerView: View) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, id: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String?, Any?>?
        return NativeView(context, id, creationParams)
    }
}
```

Finally, register the platform view. This can be done in an app or a plugin.

For app registration, modify the app's main activity (e.g. `MainActivity.kt`):

```kotlin
package dev.flutter.example

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        flutterEngine
                .platformViewsController
                .registry
                .registerViewFactory("<platform-view-type>", NativeViewFactory())
    }
}
```

For plugin registration, modify the plugin's main class (e.g. `PlatformViewPlugin.kt`):

```kotlin
package dev.flutter.plugin.example

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding

class PlatformViewPlugin : FlutterPlugin {
    override fun onAttachedToEngine(binding: FlutterPluginBinding) {
        binding
                .platformViewRegistry
                .registerViewFactory("<platform-view-type>", NativeViewFactory())
    }

    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {}
}
```

{% sample Java %}

In your native code, implement the following:

Extend `io.flutter.plugin.platform.PlatformView` to provide a reference to the `android.view.View`,
For example, `NativeView.java`:

```java
package dev.flutter.example;

import android.content.Context;
import android.graphics.Color;
import android.view.View;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.plugin.platform.PlatformView;
import java.util.Map;

class NativeView implements PlatformView {
   @NonNull private final TextView textView;

    NativeView(@NonNull Context context, int id, @Nullable Map<String, Object> creationParams) {
        textView = new TextView(context);
        textView.setTextSize(72);
        textView.setBackgroundColor(Color.rgb(255, 255, 255));
        textView.setText("Rendered on a native Android view (id: " + id + ")");
    }

    @NonNull
    @Override
    public View getView() {
        return textView;
    }

    @Override
    public void dispose() {}
}
```

Create a factory class that creates an instance of the `NativeView` created earlier,
for example, `NativeViewFactory.java`:

```java
package dev.flutter.example;

import android.content.Context;
import android.view.View;
import androidx.annotation.Nullable;
import androidx.annotation.NonNull;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;
import java.util.Map;

class NativeViewFactory extends PlatformViewFactory {
  @NonNull private final BinaryMessenger messenger;
  @NonNull private final View containerView;

  NativeViewFactory(@NonNull BinaryMessenger messenger, @NonNull View containerView) {
    super(StandardMessageCodec.INSTANCE);
    this.messenger = messenger;
    this.containerView = containerView;
  }

  @NonNull
  @Override
  public PlatformView create(@NonNull Context context, int id, @Nullable Object args) {
    final Map<String, Object> creationParams = (Map<String, Object>) args;
    return new NativeView(context, id, creationParams);
  }
}
```

Finally, register the platform view. This can be done in an app or a plugin.

For app registration, modify the app's main activity (e.g. `MainActivity.java`):

```java
package dev.flutter.example;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;

public class MainActivity extends FlutterActivity {
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        flutterEngine
            .getPlatformViewsController()
            .getRegistry()
            .registerViewFactory("<platform-view-type>", new NativeViewFactory());
    }
}
```

For plugin registration, modify the plugin's main file (e.g. `PlatformViewPlugin.java`):

```java
package dev.flutter.plugin.example;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;

public class PlatformViewPlugin implements FlutterPlugin {
  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    binding
        .getPlatformViewRegistry()
        .registerViewFactory("<platform-view-type>", new NativeViewFactory());
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {}
}
```
{% endsamplecode %}

For more information, see the API docs for:

* [`FlutterPlugin`][]
* [`PlatformViewRegistry`][]
* [`PlatformViewFactory`][]
* [`PlatformView`][]

Finally, modify your `build.gradle` file to require one of the
minimal Android SDK versions:

```gradle
android {
    defaultConfig {
        minSdkVersion 19 // if using Hybrid composition.
        minSdkVersion 20 // if using Virtual display.
    }
}
```

## iOS

iOS only uses Hybrid composition, which means that the native
`UIView` is appended to view hierarchy.

Prior to Flutter 1.22, platform views were in developers preview.
In 1.22 or above, it's no longer the case, so there's no need to
set the `io.flutter.embedded_views_preview` flag in `Info.plist`.

To create a platform view on iOS, follow these steps:

### On the Dart side

On the Dart side, create a `Widget`
and add the following build implementation,
as shown in the following steps.

In your Dart file, for example
do the following in `native_view_example.dart`:

1. Add the following imports:

<!-- skip -->
```dart
import 'package:flutter/widget.dart';
```

2. Implement a `build()` method:

<!-- skip -->
```dart
Widget build(BuildContext context) {
  // This is used in the platform side to register the view.
  final String viewType = '<platform-view-type>';
  // Pass parameters to the platform side.
  final Map<String, dynamic> creationParams = <String, dynamic>{};

  return UiKitView(
    viewType: viewType,
    layoutDirection: TextDirection.ltr,
    creationParams: creationParams,
    creationParamsCodec: const StandardMessageCodec(),
  );
}
```

For more information, see the API docs for:
[`UIKitView`][].

### On the platform side

On the platform side, you use the either Swift or Objective-C:

{% samplecode ios-platform-views %}
{% sample Swift %}

Implement the factory and the platform view.
The `FLNativeViewFactory` creates the platform view, and the platform view
provides a reference to the `UIView`. For example, `FLNativeView.swift`:

```swift
import Flutter
import UIKit

class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private weak var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        super.init()
        self.messenger = messenger
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return FLNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }
}

class FLNativeView: NSObject, FlutterPlatformView {
    private var _view: UIView

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        super.init()
        _view = UIView()
    }

    func view() -> UIView {
        return _view
    }
}
```

Finally, register the platform view. This can be done in an app or a plugin.

For app registration, modify the App's `AppDelegate.swift`:

```swift
import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(withRegistry: self)

        weak var registrar = self.registrar(forPlugin: "plugin-name")

        let factory = FLNativeViewFactory(messenger: registrar?.messenger)
        self.registrar(forPlugin: "<plugin-name>").register(
            factory,
            withId: "<platform-view-type>")
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
```

For plugin registration, modify the plugin's main file (e.g. `FLPlugin.swift`):

```swift
import Flutter
import UIKit

class FLPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let factory = FLNativeViewFactory(messenger: registrar.messenger)
        registrar.register(factory, withId: "<platform-view-type>")
    }
}
```

{% sample Objective-C %}

Add the headers for the factory and the platform view.
For example, `FLNativeView.h`:

```objc
#import <Flutter/Flutter.h>

@interface FLNativeViewFactory : NSObject <FlutterPlatformViewFactory>
- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;
@end

@interface FLNativeView : NSObject <FlutterPlatformView>

- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;

- (UIView*)view;
@end
```

Implement the factory and the platform view.
The `FLNativeViewFactory` creates the platform view, and the platform view
provides a reference to the `UIView`. For example, `FLNativeView.m`:

```objc
#import "FLNativeView.h"

@implementation FLNativeViewFactory {
  NSObject<FlutterBinaryMessenger>* _messenger;
}

- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
  self = [super init];
  if (self) {
    _messenger = messenger;
  }
  return self;
}

- (NSObject<FlutterPlatformView>*)createWithFrame:(CGRect)frame
                                   viewIdentifier:(int64_t)viewId
                                        arguments:(id _Nullable)args {
  return [[FLNativeView alloc] initWithFrame:frame
                              viewIdentifier:viewId
                                   arguments:args
                             binaryMessenger:_messenger];
}

@end

@implementation FLNativeView {
   UIView *_view;
}

- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
              binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
  if (self = [super init]) {
    _view = [[UIView alloc] init];
  }
  return self;
}

- (UIView*)view {
  return _view;
}

@end
```

Finally, register the platform view. This can be done in an app or a plugin.

For app registration, modify the App's `AppDelegate.m`:

```objc
#import "AppDelegate.h"
#import "FLNativeView.h"
#import "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];

   NSObject<FlutterPluginRegistrar>* registrar =
      [self registrarForPlugin:@"plugin-name"];

  FLNativeViewFactory* factory =
      [[FLNativeViewFactory alloc] initWithMessenger:registrar.messenger];

  [[self registrarForPlugin:@"<plugin-name>"] registerViewFactory:factory
                                                          withId:@"<platform-view-type>"];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
```

For plugin registration, modify the main plugin file (e.g. `FLPlugin.m`):

```objc

#import <Flutter/Flutter.h>
#import "FLNativeView.h"

@interface FLPlugin : NSObject<FlutterPlugin>
@end

@implementation FLPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FLNativeViewFactory* factory =
      [[FLNativeViewFactory alloc] initWithMessenger:registrar.messenger];
  [registrar registerViewFactory:factory withId:@"<platform-view-type>"];
}

@end
```

{% endsamplecode %}

For more information, see the API docs for:

* [`FlutterPlatformViewFactory`][]
* [`FlutterPlatformView`][]
* [`PlatformView`][]

## Putting it together

When implementing the `build()` method in Dart, you can use [`defaultTargetPlatform`][]
to detect the platform, and decide what widget to use:

<!-- skip -->
```dart
Widget build(BuildContext context) {
  // This is used in the platform side to register the view.
  final String viewType = '<platform-view-type>';
  // Pass parameters to the platform side.
  final Map<String, dynamic> creationParams = <String, dynamic>{};

  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      // return widget on Android.
    case TargetPlatform.iOS:
      // return widget on iOS.
    default:
      throw UnsupportedError("Unsupported platform view");
  }
}
```

## Performance

Platform views in Flutter come with performance trade-offs.

For example, in a typical Flutter app, the Flutter UI is composed
on a dedicated raster thread. This allows Flutter apps to be fast,
as the main platform thread is rarely blocked.

While a platform view is rendered with Hybrid composition, the Flutter
UI is composed from the platform thread, which competes with other
tasks like handling OS or plugin messages, etc.

Prior to Android 10, Hybrid composition copies each Flutter frame
out of the graphic memory into main memory, and then copies it back
to a GPU texture. In Android 10 or above, the graphics memory is
copied twice. As this copy happens per frame, the performance of
the entire Flutter UI may be impacted.

Virtual display, on the other hand, makes each pixel of the native view
flow through additional intermediate graphic buffers, which cost graphic
memory and drawing performance.

For complex cases, there are some techniques that can be used to mitigate
these issues.

For example, you could use a placeholder texture while an animation is
happening in Dart. In other words, if an animation is slow while a
platform view is rendered, then consider taking a screenshot of the
native view and rendering it as a texture.

For more information, see:

* [`TextureLayer`][]
* [`TextureRegistry`][]
* [`FlutterTextureRegistry`][]

[`AndroidView`]: {{site.api}}/flutter/widgets/AndroidView-class.html
[`AndroidViewService`]: {{site.api}}/flutter/widgets/AndroidViewSurface-class.html
[`defaultTargetPlatform`]: {{site.api}}/flutter/foundation/defaultTargetPlatform.html
[`FlutterPlatformView`]: {{site.api}}/objcdoc/Protocols/FlutterPlatformView.html
[`FlutterPlatformViewFactory`]: {{site.api}}/objcdoc/Protocols/FlutterPlatformViewFactory.html
[`FlutterPlugin`]: {{site.api}}/javadoc/io/flutter/embedding/engine/plugins/FlutterPlugin.html
[`FlutterTextureRegistry`]: {{site.api}}/objcdoc/Protocols/FlutterTextureRegistry.html
[performance]: #performance
[plugin migration guide]: https://flutter.dev/docs/development/packages-and-plugins/plugin-api-migration
[`PlatformView`]: {{site.api}}/javadoc/io/flutter/plugin/platform/PlatformView.html
[`PlatformViewFactory`]: {{site.api}}/javadoc/io/flutter/plugin/platform/PlatformViewFactory.html
[`PlatformViewLink`]: {{site.api}}/flutter/widgets/PlatformViewLink-class.html
[`PlatformViewRegistry`]: {{site.api}}/javadoc/io/flutter/plugin/platform/PlatformViewRegistry.html
[`PlatformViewsService`]: {{site.api}}/flutter/services/PlatformViewsService-class.html
[`UIKitView`]: {{site.api}}/flutter/widgets/UiKitView-class.html
[`TextureLayer`]: {{site.api}}/flutter/rendering/TextureLayer-class.html
[`TextureRegistry`]: {{site.api}}/javadoc/io/flutter/view/TextureRegistry.html
