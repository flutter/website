---
title: Hosting native Android views in your Flutter app with Platform Views
shortTitle: Android platform-views
description: >-
  Learn how to host native Android views in your
  Flutter app with Platform Views.
---

<?code-excerpt path-base="platform_integration/platform_views"?>

Platform views allow you to embed native views in a Flutter app,
so you can apply transforms, clips, and opacity to the native view
from Dart.

This allows you, for example,
to use the native Google Maps from the Android SDK
directly inside your Flutter app.

:::note
This page discusses how to host your own native Android views
within a Flutter app.
If you'd like to embed native iOS views in your Flutter app,
visit [Hosting native iOS views][].
To embed native macOS views in your Flutter app,
visit [Hosting native macOS views][].
:::

[Hosting native iOS views]: /platform-integration/ios/platform-views
[Hosting native macOS views]: /platform-integration/macos/platform-views

Platform Views on Android have several implementations.
They come with tradeoffs both in terms of performance and fidelity.

### Choosing an implementation

The following matrix summarizes the different implementations and their trade-offs:

| Mode | Benefits | Considerations | Enabler |
| :--- | :--- | :--- | :--- |
| **Texture layer** | • Good Flutter performance<br>• Full widget transforms work | • Janky during quick scrolling<br>• SurfaceViews lose accessibility and text magnifier breaks | Default behavior or standard `AndroidView` |
| **Hybrid composition** | • Full native fidelity<br>• Correct accessibility and SurfaceView support | • Causes thread merging of raster & platform, which degrades Flutter FPS<br>• Platform View -> Renders to texture -> Uploads to Impeller -> Impeller composites Flutter content and Platform View content |• `PlatformViewLink` with `AndroidViewSurface`<br>• [`AndroidViewController` builds either a TLHC or an HC Platform View][AC] |
| **HCPP** (Experimental) | • Full fidelity and performance<br>• Solves original sync overhead | • Requires Android API 34+, Vulkan support, and use of the Impeller rendering engine<br>• Platform View -> Renders to native Android Surface, Impeller renders to native Android Surface, SurfaceFlinger composites the two together | • `<meta-data>` in `AndroidManifest.xml`<br>• `--enable-hcpp` local flag<br> •[`AndroidViewController` builds either a TLHC or an HC Platform View][AC] |

{:.table .table-striped}

[AC]: {{site.github}}/flutter/flutter/blob/master/dev/integration_tests/hybrid_android_views/lib/android_platform_view.dart

## Hybrid composition {: #hybrid-composition }

Platform Views are rendered as they are normally.
Flutter content is rendered into a texture.
SurfaceFlinger composes the Flutter content and the platform views.

## Hybrid composition++ (HCPP) {: #hcpp }

:::note
This feature is experimental and is available starting from Flutter 3.44.
:::

HCPP is the latest hybrid composition strategy,
designed to solve compositing performance and synchronization issues
seen in the original Hybrid Composition mode.
It is currently available as an opt-in feature.

### Requirements

* **Android API 34 or later**: Required for native transaction
  synchronization capabilities.
* **Vulkan rendering**: The device must be capable of rendering with Vulkan.

If these requirements are not met on the end-user device,
Flutter will automatically fall back to the existing platform view strategy
configured for the app.

### Opt in

Because HCPP acts as a global upgrade for how platform views are backed,
it's enabled through configuration rather than standard Dart initialization methods
(`initAndroidView`, and so on).

You can enable HCPP using one of the following methods:

1. **Command line flag (run/test)**:
   Pass the `--enable-hcpp` flag to your `flutter run` or `flutter test` command:

   ```bash
   flutter run --enable-hcpp
   ```

:::note
   This flag is intended for local execution and testing.
   **It can't be passed to the `flutter build` commands.**
   For release builds, use the manifest configuration
   as shown in the next step.
:::

2. **AndroidManifest.xml**:
   Include a `<meta-data>` tag inside the `<application>` block of your
   `AndroidManifest.xml`:

   ```xml
   <meta-data
       android:name="io.flutter.embedding.android.EnableHcpp"
       android:value="true" />
   ```

### Limitations and known issues

* **Complex overlay stacking**:
  Transparent platform views won't display correctly
  in layout stacks structured as:
  **Flutter canvas -> Platform View -> Overlay -> Transparent Platform View**,
  when all four of these layers intersect.

## Texture layer {: #texture-layer }

Platform Views are rendered into a texture.
Flutter draws the platform views (using the texture).
Flutter content is rendered directly into a Surface.

This approach provides:

* good performance for Android Views
* good performance for Flutter rendering
* all transformations work correctly

However, this approach might cause:

* jankiness on quick scrolling (such as a web view)
* broken accessibility for `SurfaceView`s
* broken text magnification unless Flutter is rendered
  into a `TextureView`

## On the Dart side

To create a platform view on Android, use the following steps.
First, on the Dart side, create a `Widget` and add one of the
following build implementations depending on your chosen strategy.

### Hybrid composition

In your Dart file,
for example `native_view_example.dart`,
use the following instructions:

1. Add the following imports:

   <?code-excerpt "lib/native_view_example_1.dart (import)"?>
   ```dart
   import 'package:flutter/foundation.dart';
   import 'package:flutter/gestures.dart';
   import 'package:flutter/material.dart';
   import 'package:flutter/rendering.dart';
   import 'package:flutter/services.dart';
   ```

2. Implement a `build` method:

   <?code-excerpt "lib/native_view_example_1.dart (hybrid-composition)"?>
   ```dart
   Widget build(BuildContext context) {
     // This is used in the platform side to register the view.
     const String viewType = '<platform-view-type>';
     // Pass parameters to the platform side.
     const Map<String, dynamic> creationParams = <String, dynamic>{};
   
     return PlatformViewLink(
       viewType: viewType,
       surfaceFactory: (context, controller) {
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

For more information, visit the following API docs:

* [`PlatformViewLink`][]
* [`AndroidViewSurface`][]
* [`PlatformViewsService`][]

[`AndroidViewSurface`]: {{site.api}}/flutter/widgets/AndroidViewSurface-class.html
[`PlatformViewLink`]: {{site.api}}/flutter/widgets/PlatformViewLink-class.html
[`PlatformViewsService`]: {{site.api}}/flutter/services/PlatformViewsService-class.html

### TextureLayerHybridComposition

In your Dart file,
for example `native_view_example.dart`,
use the following instructions:

1. Add the following imports:

   <?code-excerpt "lib/native_view_example_2.dart (import)"?>
   ```dart
   import 'package:flutter/material.dart';
   import 'package:flutter/services.dart';
   ```

2. Implement a `build` method:

   <?code-excerpt "lib/native_view_example_2.dart (virtual-display)"?>
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

For more information, visit the [`AndroidView`][] API page.

[`AndroidView`]: {{site.api}}/flutter/widgets/AndroidView-class.html

## On the platform side

On the platform side, use the standard
`io.flutter.plugin.platform` package
in either Kotlin or Java:

<Tabs key="android-language">
<Tab name="Kotlin">

In your native code, implement the following:

Extend `io.flutter.plugin.platform.PlatformView`
to provide a reference to the `android.view.View`
(for example, `NativeView.kt`):

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
`NativeView` created earlier
(for example, `NativeViewFactory.kt`):

```kotlin
package dev.flutter.example

import android.content.Context
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
        super.configureFlutterEngine(flutterEngine)
        flutterEngine
                .platformViewsController
                .registry
                .registerViewFactory("<platform-view-type>",
                                      NativeViewFactory())
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

</Tab>
<Tab name="Java">

In your native code, implement the following:

Extend `io.flutter.plugin.platform.PlatformView`
to provide a reference to the `android.view.View`
(for example, `NativeView.java`):

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
instance of the `NativeView` created earlier
(for example, `NativeViewFactory.java`):

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

For app registration, modify the app's main activity
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

</Tab>
</Tabs>

For more information, visit the API docs for:

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

```kotlin
android {
    defaultConfig {
        minSdk = 19 // if using hybrid composition
        minSdk = 20 // if using virtual display.
    }
}
```

### Manual view invalidation

Certain Android Views don't invalidate themselves when their content changes.
Some examples include `SurfaceView` and `SurfaceTexture`.
When your Platform View includes these views,
you must manually invalidate it after it has been drawn
(or, more specifically, after the swap chain is flipped).
Invalidate the view by calling `invalidate` on it or on one of its parents.

[`AndroidViewSurface`]: {{site.api}}/flutter/widgets/AndroidViewSurface-class.html

### Issues

Check out the [existing Platform View issues][] on GitHub.

[existing Platform View issues]: {{site.github}}/flutter/flutter/issues?q=is%3Aopen+is%3Aissue+label%3A%22a%3A+platform-views

## Performance

Platform views in Flutter come with performance trade-offs.

In a typical Flutter app,
the Flutter UI is composed on a dedicated raster thread,
while platform code runs on the UI/platform thread.
This separation keeps Flutter rendering fast and fluid.

However, when a platform view is rendered on Android using hybrid
composition, Flutter merges the raster and UI threads into a single thread to
ensure correct synchronization between the native Android views and the Flutter canvas.
Because of this thread merging, rendering complex Flutter widgets
alongside a platform view can compete with OS messages and plugin interactions,
potentially causing lower application FPS and frame drops.

Also, prior to Android 10, hybrid composition copied each Flutter frame
out of the graphic memory into main memory,
and then copied it back to a GPU texture. As this copy happens per frame,
the performance of the entire Flutter UI might be impacted.
In Android 10 or above, the graphics memory is copied only once.

Hybrid Composition++ (HCPP) minimizes this overhead by using native
transaction synchronization on supported devices (Android API 34+ with Vulkan),
allowing superior performance without the heavy costs of original hybrid
composition.

Virtual display, on the other hand, makes each pixel of the native view flow
through additional intermediate graphic buffers,
which cost graphic memory and drawing performance.
This can cause jank during high-frequency updates like fast scrolling.

For complex cases, there are some techniques that
can be used to mitigate these issues.

For example, you can use a placeholder texture
while an animation is happening in Dart.
In other words, if an animation is slow while a
platform view is rendered,
then consider taking a screenshot of the
native view and rendering it as a texture.

For more information, visit the following API pages:

* [`TextureLayer`][]
* [`TextureRegistry`][]
* [`FlutterTextureRegistry`][]
* [`FlutterImageView`][]

[`FlutterImageView`]: {{site.api}}/javadoc/io/flutter/embedding/android/FlutterImageView.html
[`FlutterTextureRegistry`]: {{site.api}}/ios-embedder/protocol_flutter_texture_registry-p.html
[`TextureLayer`]: {{site.api}}/flutter/rendering/TextureLayer-class.html
[`TextureRegistry`]: {{site.api}}/javadoc/io/flutter/view/TextureRegistry.html
