---
title: Stricter Android Intent Verification for App Entrypoints
description: Android Intent extras for routing, entrypoints, and cached engines are now strictly verified.
---

{% render "docs/breaking-changes.md" %}

## Summary

To protect against Intent-based vulnerability exploits,
the Flutter Android embedder (`FlutterActivity` and `FlutterFragmentActivity`)
now strictly verifies the sender of Intents
before processing `EXTRA_INITIAL_ROUTE`, `EXTRA_DART_ENTRYPOINT`,
`EXTRA_DART_ENTRYPOINT_ARGS`, `EXTRA_CACHED_ENGINE_ID`, and
`EXTRA_CACHED_ENGINE_GROUP_ID`. 

External intents that try to pass these extras (such as `"route"`,
`"dart_entrypoint"`, or `"cached_engine_id"`) will now be ignored
unless they are verified as originating from the app itself.

## Context

Historically, the Flutter Android embedder unconditionally accepted
routing, entrypoint, and engine configuration from Intent extras.
While convenient, this allowed third-party applications on the same device
to maliciously inject parameters into a Flutter app. 

This exposed applications to security vulnerabilities, including:
1. **Route Hijacking (CWE-940):** Forcing the app to load a sensitive internal route (via `EXTRA_INITIAL_ROUTE`).
2. **Entrypoint Injection (CWE-926):** Forcing the app to execute arbitrary Dart functions or passing unsafe parameters (via `EXTRA_DART_ENTRYPOINT` and `EXTRA_DART_ENTRYPOINT_ARGS`).
3. **Session Hijacking / Privilege Escalation:** Reusing an active, pre-authenticated in-memory `FlutterEngine` instance (via `EXTRA_CACHED_ENGINE_ID` and `EXTRA_CACHED_ENGINE_GROUP_ID`) to access user-restricted states.

To mitigate these issues, we introduced a strict verification layer using Android's `getLaunchedFromUid()` (on Android 14+) and `getCallingPackage()` (on Android 13 and below). 

If the sender of the Intent cannot be verified as the app itself, the intent extras will be safely ignored. Standard Deep Links (`intent.getData()`) remain supported but are now validated against the app's declared `AndroidManifest.xml` intent-filters.

## Description of change

Any external system passing the `"route"`, `"dart_entrypoint"`, `"dart_entrypoint_args"`, `"cached_engine_id"`, or `"cached_engine_group_id"` extras will no longer have an effect in release builds.

### Behavior in Debug/Profile vs. Release
* **Debug and Profile builds:** The verification is bypassed unconditionally to preserve developer velocity, CLI testing (`adb shell am start`), and automated instrumentation tests. However, if a verification check would have failed, a warning is printed to Logcat/console to alert developers.
* **Release builds:** Enforced strictly. Extras from unverified sources are silently ignored.

### Affected Scenarios
* **Push Notifications:** Push notification SDKs frequently build a `PendingIntent` that includes a `"route"` string extra to navigate the user to a specific screen when the notification is tapped. On Android 14+ (API 34), this will continue to work. On Android 13 and below (API 33 and lower), the route extra will be ignored because the OS calling package metadata is lost.
* **Internal Cached Engine/Entrypoint Launches:** If an application launches a pre-warmed cached engine or custom entrypoint dynamically from its own native code using standard `startActivity(intent)`, it will fail to resolve the cached engine or entrypoint parameters on Android 13 and below if the activity is exported.

## Migration guide

Depending on your application's use case, you should migrate using one of the following methods:

### For Push Notifications and App Shortcuts
We recommend migrating to use standard Deep Link URIs instead of Intent extras.

**Before (Insecure):**
```java
Intent intent = new Intent(context, MainActivity.class);
intent.putExtra("route", "/product_details");
```

**After (Recommended):**
```java
Intent intent = new Intent(context, MainActivity.class);
intent.setAction(Intent.ACTION_VIEW);
intent.setData(Uri.parse("myapp://product_details"));
```

Ensure that your `AndroidManifest.xml` declares the corresponding `<intent-filter>` for the deep link, as the embedder will query the PackageManager to verify the route is legitimate.

Alternatively, if you must use Intent extras, configure your push notification to launch a custom `Activity` or `BroadcastReceiver` that you control (and is not exported). Inside that component, construct a new explicit Intent to launch your `FlutterActivity`. Because the new Intent is launched from within your app, the embedder will successfully verify it as self-sent.

### For Internal Cached Engine or Entrypoint Launches
If your app launches custom entrypoints or cached engines internally, you have three primary options:

#### Option 1: Mark host activities as non-exported (Recommended)
If the activity hosting the cached engine or custom entrypoint does not need to be opened by external third-party apps, ensure it is not exported.

In your `AndroidManifest.xml`:
```xml
<activity
    android:name="io.flutter.embedding.android.FlutterActivity"
    android:exported="false"> <!-- Secure: Only your app can launch this -->
</activity>
```

#### Option 2: Use `startActivityForResult` for internal launches
If the activity must remain exported (e.g. to handle deep links), but you also want to launch it internally with custom entrypoints, routes, or cached engines on legacy Android versions (API 33 and below):

Change your Kotlin/Java caller code to request a result (using a dummy request code):
```diff
- startActivity(intent)
+ startActivityForResult(intent, 0) // 0 is a dummy request code
```
*Note: You do not need to implement `onActivityResult()` in the caller activity.*

#### Option 3: Configure settings via Manifest `<meta-data>`
For configurations that are static or known at compile time, avoid passing them via Intent extras. Instead, declare them directly in your manifest.

In your `AndroidManifest.xml`:
```xml
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

#### Option 4: Subclass and programmatically define parameters
For dynamic configurations that cannot use `startActivityForResult` (e.g. launches from background `Services` or `BroadcastReceivers`), you can subclass `FlutterActivity` or `FlutterFragmentActivity` and programmatically supply the parameters:

```java
public class MyFlutterActivity extends FlutterActivity {
    @NonNull
    @Override
    public String getDartEntrypointFunctionName() {
        return MyConfigManager.getDynamicEntrypoint(); 
    }
    
    @Nullable
    @Override
    public List<String> getDartEntrypointArgs() {
        return MyConfigManager.getDynamicArgs();
    }
}
```

## Timeline

Landed in version: TBD<br>
In stable release: TBD
