---
title: Stricter Android `Intent` Verification for App Entrypoints
description: >-
  Android `Intent` extras for routing, entrypoints, and cached engines
  are now strictly verified.
---

{% render "docs/breaking-changes.md" %}

## Summary

To prevent [`Intent`][]-based vulnerability exploits,
the Flutter Android embedder
(`FlutterActivity` and `FlutterFragmentActivity`)
now verifies the sender of `Intent` objects
before processing `EXTRA_INITIAL_ROUTE`, `EXTRA_DART_ENTRYPOINT`,
`EXTRA_DART_ENTRYPOINT_ARGS`, `EXTRA_CACHED_ENGINE_ID`,
and `EXTRA_CACHED_ENGINE_GROUP_ID`.

In release mode, external `Intent` objects cannot set these extras
unless verified as originating from the app itself.
If verification fails, the embedder ignores the extras
and falls back to manifest metadata or default values for initial routes
and Dart entrypoints.

## Context

Previously, the Flutter Android embedder accepted routing, entrypoint,
and engine configuration directly from `Intent` extras.
This allowed external apps or malicious actors to:

1. Hijack app navigation to sensitive internal routes
   (`EXTRA_INITIAL_ROUTE`).
1. Execute arbitrary Dart entrypoints or pass unsafe arguments
   (`EXTRA_DART_ENTRYPOINT` and `EXTRA_DART_ENTRYPOINT_ARGS`).
1. Reuse active, pre-authenticated in-memory engine instances
   (`EXTRA_CACHED_ENGINE_ID` and `EXTRA_CACHED_ENGINE_GROUP_ID`).

To fix these vulnerabilities, Flutter now validates the `Intent` sender.
Deep links remain supported,
but they must match the `<intent-filter>` declarations
in your `AndroidManifest.xml`.

## Description of change

In release builds, the Android embedder strictly validates `Intent` extras:
`"route"`, `"dart_entrypoint"`, `"dart_entrypoint_args"`,
`"cached_engine_id"`, and `"cached_engine_group_id"`.

### Intent verification rules

An `Intent` is verified as safe if:

* **The activity is not exported:**
  Activities with `android:exported="false"` are automatically trusted.
* **On Android 14 and later (API 34+):**
  The launching UID matches the application's UID (`getLaunchedFromUid()`).
* **On Android 13 and earlier (API 33 and lower):**
  The calling package matches the app package (`getCallingPackage()`).
  This requires launching with `startActivityForResult()`
  or `startActivityIfNeeded()`.

For deep links (`Intent.ACTION_VIEW`),
the link URI must match an `<intent-filter>`
declared in the application manifest,
unless the `Intent` is verified as self-sent.

### Fallback behavior

If verification fails in release builds, the extras are ignored:

* **Initial route (`EXTRA_INITIAL_ROUTE`):**
  Falls back to command-line arguments or `io.flutter.InitialRoute` metadata
  in `AndroidManifest.xml`.
  If neither is specified, it defaults to `"/"`.
* **Dart entrypoint (`EXTRA_DART_ENTRYPOINT`):**
  Falls back to `io.flutter.Entrypoint` metadata in `AndroidManifest.xml`.
  If not specified, it defaults to `"main"`.
* **Entrypoint arguments (`EXTRA_DART_ENTRYPOINT_ARGS`):**
  Ignored; returns `null`.
* **Cached engine IDs (`EXTRA_CACHED_ENGINE_ID` and
  `EXTRA_CACHED_ENGINE_GROUP_ID`):**
  Ignored; returns `null`.

### Behavior in debug and profile modes

In debug and profile builds,
the embedder bypasses verification to preserve developer tooling
(such as `adb shell am start`) and automated tests.
However, if an `Intent` fails verification,
the embedder logs a warning with the target component,
intent extras, and migration instructions.

## Migration guide

You do not need to migrate if:

* You do not pass `route`, `dart_entrypoint`, `dart_entrypoint_args`,
  `cached_engine_id`, or `cached_engine_group_id` extras in `Intent`s.
* Your target `FlutterActivity` or `FlutterFragmentActivity`
  is not exported (`android:exported="false"`).

If you pass these extras to an exported activity,
choose one of the following migration strategies:

### Set host activities to non-exported

If external apps do not need to open your activity directly,
set `android:exported="false"` in `AndroidManifest.xml`:

```xml title="AndroidManifest.xml"
<activity
    android:name=".MyFlutterActivity"
    android:exported="false">
</activity>
```

:::note
Your app's main launcher activity (with `ACTION_MAIN`
and `CATEGORY_LAUNCHER`) must remain exported so that the system launcher
can launch your app.
:::

### Migrate to deep links for external routing

To route to specific screens from external sources,
shortcuts, or notifications,
use standard [deep links][] instead of `EXTRA_INITIAL_ROUTE`:

```java
Intent intent = new Intent(context, MainActivity.class);
intent.setAction(Intent.ACTION_VIEW);
intent.setData(Uri.parse("myapp://product_details"));
```

Declare matching `<intent-filter>` entries in `AndroidManifest.xml`
so the embedder can validate the incoming URL.

### Declare entrypoints and routes in AndroidManifest.xml

For static entrypoints or initial routes,
declare them as `<meta-data>` in `AndroidManifest.xml`:

```xml title="AndroidManifest.xml"
<activity 
    android:name=".MyFlutterActivity"
    android:exported="true">
    <meta-data
        android:name="io.flutter.Entrypoint"
        android:value="myCustomEntrypoint" />
    <meta-data
        android:name="io.flutter.InitialRoute"
        android:value="/customRoute" />
</activity>
```

### Use startActivityForResult on Android 13 and earlier

For internal app launches to an exported activity on Android 13 and earlier,
call `startActivityForResult()` instead of `startActivity()`:

```diff
- startActivity(intent);
+ startActivityForResult(intent, REQUEST_CODE);
```

This populates `getCallingPackage()`, allowing the embedder to verify
that the `Intent` originated from your app.
You do not need to handle the result in `onActivityResult()`.

### Override configuration methods in an activity subclass

To provide dynamic entrypoints or arguments without relying on `Intent` extras,
subclass `FlutterActivity` or `FlutterFragmentActivity`
and override the configuration methods:

```java
public class MyFlutterActivity extends FlutterActivity {
    @NonNull
    @Override
    public String getDartEntrypointFunctionName() {
        return ConfigManager.getEntrypoint(); 
    }
    
    @Nullable
    @Override
    public List<String> getDartEntrypointArgs() {
        return ConfigManager.getArgs();
    }
}
```

## Timeline

Landed in version: TBD<br>
In stable release: TBD

## References

* [Android `Intent` filters][]
* [Set up Flutter Android deep links][]

Relevant issues:

* [Issue 190450][]
* [Issue 190452][]

Relevant PR:

* [PR 190249][]

[`Intent`]: https://developer.android.com/reference/android/content/Intent
[deep links]: /cookbook/navigation/set-up-app-links
[intent filters]: https://developer.android.com/guide/components/intents-filters
[Android `Intent` filters]:
https://developer.android.com/guide/components/intents-filters
[Set up Flutter Android deep links]: /cookbook/navigation/set-up-app-links
[Issue 190450]: https://github.com/flutter/flutter/issues/190450
[Issue 190452]: https://github.com/flutter/flutter/issues/190452
[PR 190249]: https://github.com/flutter/flutter/pull/190249

