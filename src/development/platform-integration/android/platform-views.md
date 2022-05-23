---
title: Hosting native Android views in your Flutter app with Platform Views
short-title: Android platform-views
description: Learn how to host native Android views in your Flutter app with Platform Views.
---

<?code-excerpt path-base="development/platform_integration"?>

Platform views allow you to embed native views in a Flutter app,
so you can apply transforms, clips, and opacity to the native view
from Dart.

This allows you, for example, to use the native
Google Maps from the Android SDK
directly inside your Flutter app.

{{site.alert.note}}
  This page discusses how to host your own native views
  within a Flutter app.
  If you'd like to embed native iOS views in your Flutter app,
  see [Hosting native iOS views][].
{{site.alert.end}}

[Hosting native iOS views]: {{site.url}}/development/platform-integration/ios/platform-views

Flutter supports two modes:
Virtual displays and Hybrid composition.

Which one to use depends on the use case.
Let's take a look:

* Virtual displays render the `android.view.View`
  instance to a texture, so it's not embedded within
  the Android Activity's view hierachy.
  Certain platform interactions such as keyboard handling
  and accessibility features might not work.

* Hybrid composition appends the native `android.view.View`
  to the view hierarchy. Therefore, keyboard
  handling, and accessibility work out of the box.
  Prior to Android 10, this mode might significantly
  reduce the frame throughput (FPS) of the
  Flutter UI. See [performance][] for more info.

[performance]: #performance

To create a platform view on Android,
use the following steps:

### On the Dart side

On the Dart side, create a `Widget`
and add the following build implementation:

{{site.alert.warning}}
  For this to work, your plugin or app must use
  Android embedding v2.
  If you haven't updated your plugin, see the
  [plugin migration guide][].
{{site.alert.end}}

[plugin migration guide]: {{site.url}}/development/packages-and-plugins/plugin-api-migration

In your Dart file,
for example `native_view_example.dart`,
use the following instructions:

<ol markdown="1">
<li markdown="1">Add the following imports:

<?code-excerpt "lib/platform_views/native_view_example_1.dart (Import)"?>
```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
```
</li>

<li markdown="1">Implement a `build()` method:

<?code-excerpt "lib/platform_views/native_view_example_1.dart (HybridCompositionWidget)"?>
```dart
Widget build(BuildContext context) {
  // This is used in the platform side to register the view.
  const String viewType = '<platform-view-type>';
  // Pass parameters to the platform side.
  const Map<String, dynamic> creationParams = <String, dynamic>{};

  return PlatformViewLink(
    viewType: viewType,
    surfaceFactory:
        (context, controller) {
      return AndroidViewSurface(
        controller: controller as AndroidViewController,
        gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
        hitTestBehavior: PlatformViewHitTestBehavior.opaque,
      );
    },
    onCreatePlatformView: (params) {
      return PlatformViewsService.initSurfaceAndroidView(
        id: params.id,
        viewType: viewType,
        layoutDirection: TextDirection.ltr,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
        onFocus: () {
          params.onFocusChanged(true);
        },
      )
        ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
        ..create();
    },
  );
}
```
</li>
</ol>

For more information, see the API docs for:

* [`PlatformViewLink`][]
* [`AndroidViewSurface`][]
* [`PlatformViewsService`][]

[`AndroidViewSurface`]: {{site.api}}/flutter/widgets/AndroidViewSurface-class.html
[`PlatformViewLink`]: {{site.api}}/flutter/widgets/PlatformViewLink-class.html
[`PlatformViewsService`]: {{site.api}}/flutter/services/PlatformViewsService-class.html

#### Virtual Display

In your Dart file,
for example `native_view_example.dart`,
use the following instructions:

<ol markdown="1">
<li markdown="1">Add the following imports:

<?code-excerpt "lib/platform_views/native_view_example_2.dart (Import)"?>
```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
```
</li>

<li markdown="1">Implement a `build()` method:

<?code-excerpt "lib/platform_views/native_view_example_2.dart (VirtualDisplayWidget)"?>
```dart
Widget build(BuildContext context) {
  // This is used in the platform side to register the view.
  const String viewType = '<platform-view-type>';
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
</li>
</ol>

For more information, see the API docs for:

* [`AndroidView`][]

[`AndroidView`]: {{site.api}}/flutter/widgets/AndroidView-class.html

### On the platform side

On the platform side, use the standard
`io.flutter.plugin.platform` package
in either Java or Kotlin:

{% samplecode android-platform-views %}
{% sample Kotlin %}

In your native code, implement the following:

Extend `io.flutter.plugin.platform.PlatformView`
to provide a reference to the `android.view.View`,
For example, `NativeView.kt`:

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

Create a factory class that creates an instance of the
`NativeView` created earlier,
for example, `NativeViewFactory.kt`:

```kotlin
package dev.flutter.example

import android.content.Context
import android.view.View
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class NativeViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String?, Any?>?
        return NativeView(context, viewId, creationParams)
    }
}
```

Finally, register the platform view.
You can do this in an app or a plugin.

For app registration,
modify the app's main activity
(for example, `MainActivity.kt`):

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

For plugin registration,
modify the plugin's main class
(for example, `PlatformViewPlugin.kt`):

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

Extend `io.flutter.plugin.platform.PlatformView`
to provide a reference to the `android.view.View`,
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

Create a factory class that creates an
instance of the `NativeView` created earlier,
for example, `NativeViewFactory.java`:

```java
package dev.flutter.example;

import android.content.Context;
import androidx.annotation.Nullable;
import androidx.annotation.NonNull;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;
import java.util.Map;

class NativeViewFactory extends PlatformViewFactory {

  NativeViewFactory() {
    super(StandardMessageCodec.INSTANCE);
  }

  @NonNull
  @Override
  public PlatformView create(@NonNull Context context, int id, @Nullable Object args) {
    final Map<String, Object> creationParams = (Map<String, Object>) args;
    return new NativeView(context, id, creationParams);
  }
}
```

Finally, register the platform view.
You can do this in an app or a plugin.

For app registration,
modify the app's main activity
(for example, `MainActivity.java`):

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

For plugin registration,
modify the plugin's main file
(for example, `PlatformViewPlugin.java`):

```java
package dev.flutter.plugin.example;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;

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

[`FlutterPlugin`]: {{site.api}}/javadoc/io/flutter/embedding/engine/plugins/FlutterPlugin.html
[`PlatformView`]: {{site.api}}/javadoc/io/flutter/plugin/platform/PlatformView.html
[`PlatformViewFactory`]: {{site.api}}/javadoc/io/flutter/plugin/platform/PlatformViewFactory.html
[`PlatformViewRegistry`]: {{site.api}}/javadoc/io/flutter/plugin/platform/PlatformViewRegistry.html

Finally, modify your `build.gradle` file
to require one of the minimal Android SDK versions:

```gradle
android {
    defaultConfig {
        minSdkVersion 19 // if using Hybrid composition.
        minSdkVersion 20 // if using Virtual display.
    }
}
```

[`AndroidViewSurface`]: {{site.api}}/flutter/widgets/AndroidViewSurface-class.html
{% include {{site.url}}/development/platform-integration/_platform-view-perf %}
