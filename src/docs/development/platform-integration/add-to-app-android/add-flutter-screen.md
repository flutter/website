---
title: Adding a Flutter screen to an Android app
short-title: Add a Flutter screen
description: Learn how to add a single Flutter screen to your existing Android app.
---

This guide describes how to add a single Flutter screen to an existing Android
app. A Flutter screen can be added as a normal, opaque screen, or as a
see-through, translucent screen. Both options are described in this guide.

## Add a normal Flutter screen

{% asset
development/platform-integration/add-to-app-android/add-flutter-screen/add-single-flutter-screen_header.png
class="mw-100" alt="Add Flutter Screen Header" %}

### Step 1: Add Gradle dependencies

TODO: update this with gradle instructions when the embedding is broken into
multiple maven artifacts.

### Step 2: Initialize Flutter

Flutter requires that it be initialized before attempting to display any Flutter
content. This can be done in one of three ways: 

 * Use `FlutterApplication` as your app's `Application` class.

 * Extend `FlutterApplication` with your own `Application` class.

 * Manually initialize Flutter.

#### Option 1: Use FlutterApplication

To use `FlutterApplication` directly, simply declare it as the `Application`
class in the `AndroidManifest.xml` file:

```xml
<application
  android:name="io.flutter.app.FlutterApplication"
  // other properties omitted
  >
  <!-- content omitted -->
</application>
```

Now, as soon as your application is created, Flutter initializes.

#### Option 2: Extend FlutterApplication

Extending `FlutterApplication` automatically initializes Flutter when
Android creates your application. First, create an `Application` class that
extends `FlutterApplication`:

```java
public class MyApplication extends FlutterApplication {
  // no implementation is necessary.
}
```

Second, register your custom `Application` subclass in the
`AndroidManifest.xml` file:

```xml
<application
  android:name=".MyApplication"
  // other properties omitted
  >
  <!-- content omitted -->
</application>
```

Replace `MyApplication` with your `Application` subclass name.

#### Option 3: Manually initialize Flutter

If you'd like to control precisely where and when Flutter is initialized, you
can initialize Flutter manually. This must occur before you attempt to display
any Flutter content, or execute any Dart code. Initialization only needs to
happen once within the application process - it does not need to be repeated
for every Flutter experience.

To manually initialize Flutter, execute the following code at the desired
location:

```java
FlutterMain.startInitialization(appContext);
FlutterMain.ensureInitializationComplete(appContext, null);
```

The call to `ensureInitializationComplete()` is a blocking call. Make sure you
invoke it at a place and time that can afford a brief processing pause.

### Step 3: Add FlutterActivity to AndroidManifest.xml

Flutter provides `FlutterActivity` to display a Flutter experience within an
Android `Activity`. Like any other `Activity`, `FlutterActivity` must be
registered in your `AndroidManifest.xml`. Add the following XML to your
`AndroidManifestxml` file under your `application` tag:

```xml
<activity
  android:name=".YourFlutterActivityName"
  android:launchMode="singleTop"
  android:theme="@style/LaunchTheme"
  android:configChanges="orientation|keyboardHidden|keyboard|screenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
  android:hardwareAccelerated="true"
  android:windowSoftInputMode="adjustResize"
  />
```

Replace `YourFlutterActivityName` with the name of your Flutter `Activity`.

### Step 4: Launch FlutterActivity

With `FlutterActivity` registered in your manifest file, add code to launch
`FlutterActivity` from whatever point in your app that you'd like. The following
example shows `FlutterActivity` being launched from an `OnClickListener`.

```java
myButton.addOnClickListener(new OnClickListener() {
  @Override
  public void onClick(View v) {
    startActivity(
      FlutterActivity.createBuilder().build(currentActivity)
    );
  }
});
```

The above example assumes that your Dart entrypoint is called `main()`, and your
initial Flutter route is '/'. If you'd like to change either property, use the
`IntentBuilder` to provide your desired properties:

```java
myButton.addOnClickListener(new OnClickListener() {
  @Override
  public void onClick(View v) {
    startActivity(
      FlutterActivity
        .createBuilder()
        .dartEntrypoint("mySpecialEntrypoint")
        .initialRoute("/my_route")
        .build(currentActivity)
      );
  }
});
```

Replace `"mySpecialEntrypoint"` with the name of your desired Dart entrypoint,
and replace `"/my_route"` with your desired initial route.

### Step 5: (Optional) Use a cached FlutterEngine

Every `FlutterActivity` creates its own `FlutterEngine` by default. Each
`FlutterEngine` has a non-trivial "warm-up" time. This means that launching a
standard `FlutterActivity` comes with a brief delay before your Flutter
experience becomes visible. To avoid this delay, you can warm-up a
`FlutterEngine` before arriving at your `FlutterActivity` and then you can use
your pre-warmed `FlutterEngine` instead.

To pre-warm a `FlutterEngine`, find a reasonable location in your app to
instantiate and hold a `FlutterEngine`. For a simplistic app, storing a
`FlutterEngine` in the `Application` class might be a reasonable option:

```java
public class MyApplication extends Application {
  private FlutterEngine flutterEngine;

  @Override
  public void onCreate() {
    super.onCreate();

    // Initialize Flutter.
    FlutterMain.startInitialization(this);
    FlutterMain.ensureInitializationComplete(this, null);

    // Create and warm-up a FlutterEngine.
    flutterEngine = new FlutterEngine(this);

    DartExecutor.DartEntrypoint entrypoint = new DartExecutor.DartEntrypoint(
      getResources().getAssets(),
      FlutterMain.findAppBundlePath(this),
      "main"
    );

    flutterEngine.getDartExecutor().executeDartEntrypoint(entrypoint);
  }

  @NonNull
  public FlutterEngine getFlutterEngine() {
    return flutterEngine;
  }
}
```

{{site.alert.note}} 
  To warm up a `FlutterEngine`, you must execute a Dart
  entrypoint. Keep in mind that the moment `executeDartEntrypoint()` is invoked,
  your Dart entrypoint method will begin executing. If your Dart entrypoint
  invokes `runApp()` to run a Flutter app, your Flutter app will behave as if it
  is running in a window of zero size until this `FlutterEngine` is attached to a
  `FlutterActivity`, `FlutterFragment`, or `FlutterView`. Make sure that your app
  behaves appropriately between the time you warm it up and the time you display
  Flutter content.
{{site.alert.end}}

With a pre-warmed `FlutterEngine`, you now need to instruct your
`FlutterActivity` to use the pre-warmed `FlutterEngine` instead of creating a
new one. To accomplish this, subclass `FlutterActivity` and override the
`provideFlutterEngine()` method:

```java
public class MyFlutterActivity extends FlutterActivity {
  @Override
  @NonNull
  protected FlutterEngine provideFlutterEngine(@NonNull Context context) {
    return ((MyApplication) context.getApplicationContext()).getFlutterEngine();
  }
}
```

Now, when you launch `MyFlutterActivity`, there is significantly less delay in
the display of Flutter content.

{{site.alert.note}} 
  When re-using a cached engine, you assume responsibility for
  showing the desired content for the given `Activity` that's using the
  `FlutterEngine`. Strategies for switching content in a shared `FlutterEngine`
  are beyond the scope of this guide. TODO(mattcarroll): link to
  resource.
{{site.alert.end}}

{{site.alert.note}} 
  Flutter's debug/release builds have drastically different
  performance characteristics. To evaluate the performance of Flutter, use a
  release build.
{{site.alert.end}}

## Add a translucent Flutter screen

{% asset
development/platform-integration/add-to-app-android/add-flutter-screen/add-single-flutter-screen-transparent_header.png
class="mw-100" alt="Add Flutter Screen With Translucency Header" %}

Most fullscreen Flutter experiences are opaque. However, some apps would like to
deploy a Flutter screen that looks like a modal, for example, a dialog, bottom sheet,
etc. Flutter supports translucent `FlutterActivity`s out of the box.

To make your `FlutterActivity` translucent, make the following adjustments to
the regular process of creating and launching a `FlutterActivity`.

### Step 1: Use a theme with translucency

Android requires a special theme property for `Activity`s that wish to render
with a translucent background. Create or update an Android theme with the
following property:

```xml
<style name="MyTheme" parent="@style/MyParentTheme">
  <item name="android:windowIsTranslucent">true</item>
</style>
```

Then, apply the translucent theme to your desired `FlutterActivity`.

```xml
<activity
  android:name="io.flutter.embedding.android.FlutterActivity"
  android:launchMode="singleTop"
  android:theme="@style/MyTheme"
  android:configChanges="orientation|keyboardHidden|keyboard|screenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
  android:hardwareAccelerated="true"
  android:windowSoftInputMode="adjustResize"
  />
```

Your `FlutterActivity` now supports translucency. Next, you need to launch your
`FlutterActivity` with explicit transparency support.

### Step 2: Start FlutterActivity with transparency

To launch your `FlutterActivity` with a transparent background, pass the
appropriate `BackgroundMode` to the `IntentBuilder`:

```java
startActivity(
  FlutterActivity
    .createBuilder()
    .backgroundMode(FlutterActivity.BackgroundMode.transparent)
    .build(context)
);
```

You now have a `FlutterActivity` with a transparent background.

{{site.alert.note}} Make sure that your Flutter content also includes a
  translucent background. If your Flutter UI paints a solid background color
  then it still appears as though your `FlutterActivity` has an opaque
  background. {{site.alert.end}}