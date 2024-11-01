---
title: Add a Flutter screen to an Android app
short-title: Add a Flutter screen
description: >
  Learn how to add a single Flutter screen to your existing Android app.
---

This guide describes how to add a single Flutter screen to an
existing Android app. A Flutter screen can be added as a normal,
opaque screen, or as a see-through, translucent screen.
Both options are described in this guide.

## Add a normal Flutter screen

<img src='/assets/images/docs/development/add-to-app/android/add-flutter-screen/add-single-flutter-screen_header.png'
class="mw-100" alt="Add Flutter Screen Header">

### Step 1: Add FlutterActivity to AndroidManifest.xml

Flutter provides [`FlutterActivity`][] to display a Flutter
experience within an Android app. Like any other [`Activity`][],
`FlutterActivity` must be registered in your
`AndroidManifest.xml`. Add the following XML to your
`AndroidManifest.xml` file under your `application` tag:

```xml
<activity
  android:name="io.flutter.embedding.android.FlutterActivity"
  android:theme="@style/LaunchTheme"
  android:configChanges="orientation|keyboardHidden|keyboard|screenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
  android:hardwareAccelerated="true"
  android:windowSoftInputMode="adjustResize"
  />
```

The reference to `@style/LaunchTheme` can be replaced
by any Android theme that want to apply to your `FlutterActivity`.
The choice of theme dictates the colors applied to
Android's system chrome, like Android's navigation bar, and to
the background color of the `FlutterActivity` just before
the Flutter UI renders itself for the first time.

### Step 2: Launch FlutterActivity

With `FlutterActivity` registered in your manifest file,
add code to launch `FlutterActivity` from whatever point
in your app that you'd like. The following example shows
`FlutterActivity` being launched from an `OnClickListener`.

:::note
Make sure to use the following import:

```java
import io.flutter.embedding.android.FlutterActivity;
```
:::

{% tabs "android-language" %}
{% tab "Jetpack Compose" %}

```kotlin title="ExistingActivity.kt"
MyButton(onClick = {
    startActivity(
        FlutterActivity.createDefaultIntent(this)
    )
})

@Composable
fun MyButton(onClick: () -> Unit) {
    Button(onClick = onClick) {
        Text("Launch Flutter!")
    }
}
```

{% endtab %}
{% tab "Kotlin" %}

```kotlin title="ExistingActivity.kt"
myButton.setOnClickListener {
  startActivity(
    FlutterActivity.createDefaultIntent(this)
  )
}
```

{% endtab %}
{% tab "Java" %}

```java title="ExistingActivity.java"
myButton.setOnClickListener(new OnClickListener() {
  @Override
  public void onClick(View v) {
    startActivity(
      FlutterActivity.createDefaultIntent(currentActivity)
    );
  }
});
```

{% endtab %}
{% endtabs %}

The previous example assumes that your Dart entrypoint
is called `main()`, and your initial Flutter route is '/'.
The Dart entrypoint can't be changed using `Intent`,
but the initial route can be changed using `Intent`.
The following example demonstrates how to launch a
`FlutterActivity` that initially renders a custom
route in Flutter.

{% tabs "android-language" %}
{% tab "Jetpack Compose" %}

```kotlin title="ExistingActivity.kt"
MyButton(onClick = {
  startActivity(
    FlutterActivity
      .withNewEngine()
      .initialRoute("/my_route")
      .build(this)
  )
})

@Composable
fun MyButton(onClick: () -> Unit) {
    Button(onClick = onClick) {
        Text("Launch Flutter!")
    }
}
```

{% endtab %}
{% tab "Kotlin" %}

```kotlin title="ExistingActivity.kt"
myButton.setOnClickListener {
  startActivity(
    FlutterActivity
      .withNewEngine()
      .initialRoute("/my_route")
      .build(this)
  )
}
```

{% endtab %}
{% tab "Java" %}

```java title="ExistingActivity.java"
myButton.addOnClickListener(new OnClickListener() {
  @Override
  public void onClick(View v) {
    startActivity(
      FlutterActivity
        .withNewEngine()
        .initialRoute("/my_route")
        .build(currentActivity)
      );
  }
});
```

{% endtab %}
{% endtabs %}

Replace `"/my_route"` with your desired initial route.

The use of the `withNewEngine()` factory method
configures a `FlutterActivity` that internally create
its own [`FlutterEngine`][] instance. This comes with a
non-trivial initialization time. The alternative approach
is to instruct `FlutterActivity` to use a pre-warmed,
cached `FlutterEngine`, which minimizes Flutter's
initialization time. That approach is discussed next.

### Step 3: (Optional) Use a cached FlutterEngine

Every `FlutterActivity` creates its own `FlutterEngine`
by default. Each `FlutterEngine` has a non-trivial
warm-up time. This means that launching a standard
`FlutterActivity` comes with a brief delay before your Flutter
experience becomes visible. To minimize this delay,
you can warm up a `FlutterEngine` before arriving at
your `FlutterActivity`, and then you can use
your pre-warmed `FlutterEngine` instead.

To pre-warm a `FlutterEngine`, find a reasonable
location in your app to instantiate a `FlutterEngine`.
The following example arbitrarily pre-warms a
`FlutterEngine` in the `Application` class:

{% tabs "android-language" %}
{% tab "Kotlin" %}

```kotlin title="MyApplication.kt"
class MyApplication : Application() {
  lateinit var flutterEngine : FlutterEngine

  override fun onCreate() {
    super.onCreate()

    // Instantiate a FlutterEngine.
    flutterEngine = FlutterEngine(this)

    // Start executing Dart code to pre-warm the FlutterEngine.
    flutterEngine.dartExecutor.executeDartEntrypoint(
      DartExecutor.DartEntrypoint.createDefault()
    )

    // Cache the FlutterEngine to be used by FlutterActivity.
    FlutterEngineCache
      .getInstance()
      .put("my_engine_id", flutterEngine)
  }
}
```

{% endtab %}
{% tab "Java" %}

```java title="MyApplication.java"
public class MyApplication extends Application {
  public FlutterEngine flutterEngine;
  
  @Override
  public void onCreate() {
    super.onCreate();
    // Instantiate a FlutterEngine.
    flutterEngine = new FlutterEngine(this);

    // Start executing Dart code to pre-warm the FlutterEngine.
    flutterEngine.getDartExecutor().executeDartEntrypoint(
      DartEntrypoint.createDefault()
    );

    // Cache the FlutterEngine to be used by FlutterActivity.
    FlutterEngineCache
      .getInstance()
      .put("my_engine_id", flutterEngine);
  }
}
```

{% endtab %}
{% endtabs %}

The ID passed to the [`FlutterEngineCache`][] can be whatever you want.
Make sure that you pass the same ID to any `FlutterActivity`
or [`FlutterFragment`][] that should use the cached `FlutterEngine`.
Using `FlutterActivity` with a cached `FlutterEngine`
is discussed next.

:::note
To warm up a `FlutterEngine`, you must execute a Dart
entrypoint. Keep in mind that the moment
`executeDartEntrypoint()` is invoked,
your Dart entrypoint method begins executing.
If your Dart entrypoint invokes `runApp()`
to run a Flutter app, then your Flutter app behaves as if it
were running in a window of zero size until this
`FlutterEngine` is attached to a `FlutterActivity`,
`FlutterFragment`, or `FlutterView`. Make sure that your app
behaves appropriately between the time you warm it up and
the time you display Flutter content.
:::

With a pre-warmed, cached `FlutterEngine`, you now need
to instruct your `FlutterActivity` to use the cached
`FlutterEngine` instead of creating a new one.
To accomplish this, use `FlutterActivity`'s `withCachedEngine()`
builder:

{% tabs "android-language" %}
{% tab "Kotlin" %}

```kotlin title="ExistingActivity.kt"
myButton.setOnClickListener {
  startActivity(
    FlutterActivity
      .withCachedEngine("my_engine_id")
      .build(this)
  )
}
```

{% endtab %}
{% tab "Java" %}

```java title="ExistingActivity.java"
myButton.addOnClickListener(new OnClickListener() {
  @Override
  public void onClick(View v) {
    startActivity(
      FlutterActivity
        .withCachedEngine("my_engine_id")
        .build(currentActivity)
      );
  }
});
```

{% endtab %}
{% endtabs %}

When using the `withCachedEngine()` factory method,
pass the same ID that you used when caching the desired
`FlutterEngine`.

Now, when you launch `FlutterActivity`,
there is significantly less delay in
the display of Flutter content.

:::note
When using a cached `FlutterEngine`, that `FlutterEngine` outlives any
`FlutterActivity` or `FlutterFragment` that displays it. Keep in
mind that Dart code begins executing as soon as you pre-warm the
`FlutterEngine`, and continues executing after the destruction of your
`FlutterActivity`/`FlutterFragment`. To stop executing and clear resources,
obtain your `FlutterEngine` from the `FlutterEngineCache` and destroy the
`FlutterEngine` with `FlutterEngine.destroy()`.
:::

:::note
Runtime performance isn't the only reason that you might
pre-warm and cache a `FlutterEngine`.
A pre-warmed `FlutterEngine` executes Dart code independent
from a `FlutterActivity`, which allows such a `FlutterEngine`
to be used to execute arbitrary Dart code at any moment.
Non-UI application logic can be executed in a `FlutterEngine`,
like networking and data caching, and in background behavior
within a `Service` or elsewhere. When using a `FlutterEngine`
to execute behavior in the background, be sure to adhere to all
Android restrictions on background execution.
:::

:::note
Flutter's debug/release builds have drastically different
performance characteristics. To evaluate the performance
of Flutter, use a release build.
:::

#### Initial route with a cached engine

{% include docs/add-to-app/android-initial-route-cached-engine.md %}

## Add a translucent Flutter screen

<img src='/assets/images/docs/development/add-to-app/android/add-flutter-screen/add-single-flutter-screen-transparent_header.png'
class="mw-100" alt="Add Flutter Screen With Translucency Header">

Most full-screen Flutter experiences are opaque.
However, some apps would like to deploy a Flutter
screen that looks like a modal, for example,
a dialog or bottom sheet. Flutter supports translucent
`FlutterActivity`s out of the box.

To make your `FlutterActivity` translucent,
make the following changes to the regular process of
creating and launching a `FlutterActivity`.

### Step 1: Use a theme with translucency

Android requires a special theme property for `Activity`s that render
with a translucent background. Create or update an Android theme with the
following property:

```xml
<style name="MyTheme" parent="@style/MyParentTheme">
  <item name="android:windowIsTranslucent">true</item>
</style>
```

Then, apply the translucent theme to your `FlutterActivity`.

```xml
<activity
  android:name="io.flutter.embedding.android.FlutterActivity"
  android:theme="@style/MyTheme"
  android:configChanges="orientation|keyboardHidden|keyboard|screenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
  android:hardwareAccelerated="true"
  android:windowSoftInputMode="adjustResize"
  />
```

Your `FlutterActivity` now supports translucency.
Next, you need to launch your `FlutterActivity`
with explicit transparency support.

### Step 2: Start FlutterActivity with transparency

To launch your `FlutterActivity` with a transparent background,
pass the appropriate `BackgroundMode` to the `IntentBuilder`:

{% tabs "android-language" %}
{% tab "Kotlin" %}

```kotlin title="ExistingActivity.kt"
// Using a new FlutterEngine.
startActivity(
  FlutterActivity
    .withNewEngine()
    .backgroundMode(FlutterActivityLaunchConfigs.BackgroundMode.transparent)
    .build(this)
);

// Using a cached FlutterEngine.
startActivity(
  FlutterActivity
    .withCachedEngine("my_engine_id")
    .backgroundMode(FlutterActivityLaunchConfigs.BackgroundMode.transparent)
    .build(this)
);
```

{% endtab %}
{% tab "Java" %}

```java title="ExistingActivity.java"
// Using a new FlutterEngine.
startActivity(
  FlutterActivity
    .withNewEngine()
    .backgroundMode(FlutterActivityLaunchConfigs.BackgroundMode.transparent)
    .build(context)
);

// Using a cached FlutterEngine.
startActivity(
  FlutterActivity
    .withCachedEngine("my_engine_id")
    .backgroundMode(FlutterActivityLaunchConfigs.BackgroundMode.transparent)
    .build(context)
);
```

{% endtab %}
{% endtabs %}

You now have a `FlutterActivity` with a transparent background.

:::note
Make sure that your Flutter content also includes a
translucent background. If your Flutter UI paints a
solid background color, then it still appears as
though your `FlutterActivity` has an opaque background.
:::

[`FlutterActivity`]: {{site.api}}/javadoc/io/flutter/embedding/android/FlutterActivity.html
[`Activity`]: {{site.android-dev}}/reference/android/app/Activity
[`FlutterEngine`]: {{site.api}}/javadoc/io/flutter/embedding/engine/FlutterEngine.html
[`FlutterEngineCache`]: {{site.api}}/javadoc/io/flutter/embedding/engine/FlutterEngineCache.html
[`FlutterFragment`]: {{site.api}}/javadoc/io/flutter/embedding/android/FlutterFragment.html
