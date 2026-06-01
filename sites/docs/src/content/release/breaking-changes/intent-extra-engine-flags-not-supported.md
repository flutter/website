---
title: Android engine flags specified via `Intent`s no longer supported
description: >-
  Passing Flutter engine flags on Android via `Intent` extras
  is no longer supported for security reasons.
---

{% render "docs/breaking-changes.md" %}

## Summary

For security reasons,
passing Flutter engine flags with Android `Intent` extras
is no longer supported.
To set engine flags, configure them statically in the manifest
or set them from the command line.

## Background

Flutter previously allowed passing engine flags to the Android embedding
with Android `Intent` extras.
However, malicious actors can take advantage of that mechanism
to exploit flag vulnerabilities and execute malicious code.

For example,
an attacker can specify a malicious path for the AOT library flag
(`--aot-shared-library-name=`),
which allows running arbitrary native C code.
While not all engine flags present security vulnerabilities,
allowing dynamic flag configuration with `Intent`s
is insecure for production Flutter Android applications.

To eliminate this vulnerability,
support for setting engine flags via `Intent` extras
has been completely removed.

## Migration guide

If your application relies on dynamically setting engine flags,
migrate to one of the supported methods.

Example of code before migration:

```kotlin
// Passing engine flags via Intent extras (no longer supported).
val intent = Intent(this, MainActivity::class.java).apply {
    putExtra("enable-software-rendering", true)
}
startActivity(intent)
```

Choose one of the following supported methods to configure engine flags:

### Option 1: Configure statically in AndroidManifest.xml

Set flags inside the `<application>` tag of your `AndroidManifest.xml` file.
All supported flags, their manifest keys, and whether or not they are allowed in release mode can be found in [`FlutterEngineFlags.java`][].
For boolean flags, explicitly set `android:value="true"`.

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.myapp">
    <application>
        <meta-data
            android:name="io.flutter.embedding.android.TraceToFile"
            android:value="some_file.txt" />
        <meta-data
            android:name="io.flutter.embedding.android.EnableFlutterGPU"
            android:value="true" />
    </application>
</manifest>
```

If a disallowed flag is specified in a release build,
the Android embedding ignores the flag.

### Option 2: Pass flags from the command line

For local debugging and development,
pass engine flags directly using `flutter run`:

```bash
flutter run \
  --trace-startup \
  --enable-software-rendering
```

### Option 3: Initialize programmatically (Dynamic/Add-to-app)

If you need per-launch or runtime-controlled flags,
supply engine arguments directly to a cached `FlutterEngine`
during engine initialization.

To do that, supply engine arguments directly to a `FlutterEngine` with the
desired flags from the earliest point you can control in your
application. For example, if you are writing an add-to-app app that launches
a `FlutterActivity` or `FlutterFragment`, then you can cache a
`FlutterEngine` that is initialized with your desired
engine flags:

```kotlin
class MyApp : Application() {
    override fun onCreate() {
        super.onCreate()

        val args = arrayOf(
            "--trace-startup",
            "--enable-software-rendering"
        )
        val flutterEngine = FlutterEngine(this, args)
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartEntrypoint.createDefault()
        )
        FlutterEngineCache.getInstance().put("my_engine_id", flutterEngine)
    }
}
```

Then, launch the activity or fragment using the cached engine:

```kotlin
val intent = FlutterActivity.withCachedEngine("my_engine_id").build(this)
startActivity(intent)
```

For normal Flutter Android applications,
override `provideFlutterEngine` in your app's `FlutterActivity`
to return the custom configured engine:

```kotlin
class MainActivity : FlutterActivity() {
    override fun provideFlutterEngine(context: Context): FlutterEngine? {
        return FlutterEngineCache.getInstance().get("my_engine_id")
    }
}
```

## Timeline

Not yet released.

## References

Relevant issues:

* [Issue 172553][]
* [Issue 180686][]

[`FlutterEngineFlags.java`]: {{site.repo.flutter}}/blob/master/engine/src/flutter/shell/platform/android/io/flutter/embedding/engine/FlutterEngineFlags.java
[Issue 172553]: {{site.repo.flutter}}/issues/172553
[Issue 180686]: {{site.repo.flutter}}/issues/180686
