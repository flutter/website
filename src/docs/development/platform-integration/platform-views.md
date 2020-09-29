---
title: Hosting native Android and iOS views in your Flutter app with Platform Views
short-title: Platform-views
description: Learn how to host native Android and iOS views in your Flutter app with Platform Views.
---

As of the Flutter 1.22 release, support for hosting
Android and iOS views from a Flutter mobile app
is now production ready.
This allows you, for example, to use the native
Google Maps from the Android and iOS SDKs
directly inside your Flutter app, by using Platform Views.
The [`google_maps_flutter`][] and [`webview_flutter`][]
plugins are updated to 1.0.

[`google_maps_flutter`]: {{site.pub}}/packages/google_maps_flutter
[`webview_flutter`]: {{site.pub}}/packages/webview_flutter

This page discusses how to host your own native components
within a Flutter app.

## Android

Flutter supports two modes: Virtual displays and Hybrid composition.

In 1.22, Hybrid composition is enabled by default,
and only requires API level 19 (instead of API level 20,
which the previous version required).
Also, these updates fix all known keyboard,
and accessibility issues for Android views.

### On the Dart side

On the Dart side, create a `Widget`
and add the following build implementation,
as shown in the following steps.

{{site.alert.warning}}
  For this to work, your plugin must use Android embedding v2. 
  If you haven't updated your plugin, see the
  [plugin migration guide][].
{{site.alert.end}}

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


[plugin migration guide]: https://flutter.dev/docs/development/packages-and-plugins/plugin-api-migration
[`AndroidViewService`]: {{site.api}}/flutter/widgets/AndroidViewSurface-class.html
[`PlatformViewLink`]: {{site.api}}/flutter/widgets/PlatformViewLink-class.html
[`PlatformViewsService`]: {{site.api}}/flutter/services/PlatformViewsService-class.html

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

Finally, modify your `build.gradle` file to require
version 19 (or later) of the Android API.

```gradle
android {
    defaultConfig {
        minSdkVersion 19
    }
}
```

### Performance

Hybrid composition on Android works best on Android 10 or above.
On lower versions of Android, the Flutter UI can appear slower
while the native view is rendered on the screen.
This overhead is due to the synchronization of Flutter frames to the
Android view system.

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
