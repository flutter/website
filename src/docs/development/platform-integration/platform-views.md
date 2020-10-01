---
title: Hosting native Android and iOS views in your Flutter app with Platform Views
short-title: Platform-views
description: Learn how to host native Android and iOS views in your Flutter app with Platform Views.
---

Platform views allow to embed native views in a Flutter app. 

The Flutter engine takes care of coordinating the platform
and the Flutter compositors, so you can apply transforms,
clips, and opacity to the native View from Dart.

This allows you, for example, to use the native
Google Maps from the Android and iOS SDKs
directly inside your Flutter app, by using Platform Views.

This page discusses how to host your own native views
within a Flutter app.

## Android

Flutter supports two modes: Virtual displays and Hybrid composition.

Which one to use depends on the use case. Let's take a look:

* Virtual displays renders the native view to a texture,
  so it's not embeded within the Android view hierachy. Performance 
  is good although certain platform interactions such as keyboard 
  handling, and accessibility features might not work.

* Hybrid composition requires Flutter 1.22. This mode appends the 
  native view to the Android View hirarchy. Thefore, keyboard
  handling, and accesibility work out of the box. Performance is
  good in Android 10 or above. Prior to Android 10, this mode
  reduces the frame throughput (FPS) of the Flutter UI.
  See [performance][#performance] for more.

To create a platform view, follow these steps:

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
  final String viewType = 'hybrid-view-type';
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

[plugin migration guide]: https://flutter.dev/docs/development/packages-and-plugins/plugin-api-migration
[`AndroidViewService`]: {{site.api}}/flutter/widgets/AndroidViewSurface-class.html
[`PlatformViewLink`]: {{site.api}}/flutter/widgets/PlatformViewLink-class.html
[`PlatformViewsService`]: {{site.api}}/flutter/services/PlatformViewsService-class.html
[`AndroidView`]: {{site.api}}/flutter/widgets/AndroidView-class.html


### On the platform side

On the platform side, use the standard
`io.flutter.plugin.platform` package in either Java or Kotlin:

(TBD: Where is the Kotlin implementation? How is iOS different?)

In your native code, for example `NativeView.java`, implement
the following:

`NativeView.java`

```java
package dev.flutter.example;

import android.content.Context;
import android.graphics.Color;
import android.view.View;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.plugin.platform.PlatformView;

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

In your factory class, for example `NativeViewFactory.java`:

`NativeViewFactory.java`

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

In your main activity file, for example `MainActivity.java`:

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
            .registerViewFactory("hybrid-view-type", new NativeViewFactory());
    }
}
```

For more information, see the API docs for:

* [`PlatformViewRegistry`][]
* [`PlatformViewFactory`][]
* [`PlatformView`][]


[`PlatformViewFactory`]: {{site.api}}/javadoc/io/flutter/plugin/platform/PlatformViewFactory.html
[`PlatformViewRegistry`]: {{site.api}}/javadoc/io/flutter/plugin/platform/PlatformViewRegistry.html
[`PlatformView`]: {{site.api}}/javadoc/io/flutter/plugin/platform/PlatformView.html

Finally, modify your `build.gradle` file to require either 
the minimal Android SDK version:

```gradle
android {
    defaultConfig {
        minSdkVersion 19 // if using Hybrid composition.
        minSdkVersion 20 // if using Virtual display.
    }
}
```

### Performance

Hybrid composition on Android works best on Android 10 or above.
On lower versions of Android, the engine makes a device-host-device
copy of the Flutter texture. This results in a reduction of frame 
per seconds (FPS) of the Flutter UI.

To mitigate this issue, we recommend that you avoid displaying
the native view while an animation is taking place in Dart.

For example, you could use a placeholder such as capturing a
screenshot of the native view and rendering the placeholder
while the animation is happening.

Also, if a keyboard is not needed, you might find that virtual
display mode works better for Android releases earlier than 10.

## iOS

Lazy initialization removes the use of iOS resources before a
Platform View is rendered. As a result, you are no longer required
to add the `io.flutter.embedded_views_preview` flag to `Info.plist`.

By default, the `UIKitView` widget appends the native
`UIView` to the view hierarchy. For more information,
see the API page for [`UIKitView`][].

[`UIKitView`]: {{site.api}}/flutter/widgets/UiKitView-class.html
