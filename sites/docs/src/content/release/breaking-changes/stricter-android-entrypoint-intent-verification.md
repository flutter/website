---
title: Stricter Android `Intent` Verification for App Entrypoints
description: >
  Android `Intent` extras for routing, entrypoints, and cached engines
  are now strictly verified.
---

{% render "docs/breaking-changes.md" %}

## Summary

To protect against [`Intent`][]-based vulnerability exploits,
the Flutter Android embedder
(`FlutterActivity`, `FlutterFragmentActivity`, and `FlutterFragment`)
now strictly verifies the sender of Intents
before processing `EXTRA_INITIAL_ROUTE`, `EXTRA_DART_ENTRYPOINT`,
`EXTRA_DART_ENTRYPOINT_ARGS`, `EXTRA_CACHED_ENGINE_ID`, and
`EXTRA_CACHED_ENGINE_GROUP_ID`.

External [`Intent`][]s that try to pass these extras (such as `"route"`,
`"dart_entrypoint"`, or `"cached_engine_id"`) will now be ignored
unless they are verified as originating from the app itself.

:::note
**Unexpected failures or silent drops in Release mode?**
If you see an `Intent verification failed` warning in Debug mode,
or if custom routes suddenly stop working in Release mode without warnings,
one of the following is likely responsible:
- **Third-party Plugins (Push notifications, widgets):**
  The plugin author must update their code.
  Check `pub.dev` for a plugin update or file an issue.
  You do not need to change your own code.
- **Inter-app Communication:**
  Another app is trying to launch your app using Intent extras.
  You must migrate to using standard Deep Links instead.
- **Automated Testing:**
  Your CI/QA scripts are using `adb`
  to launch specific routes on a Release APK.
:::

## Context

Before this change, the Flutter Android embedder unconditionally accepted
routing, entrypoint, and engine configuration from `Intent` extras.
This made Flutter Android apps vulnerable to malicious actors
injecting arbitrary parameters via external Intents.

This exposed applications to security vulnerabilities, including:
1. **Route Hijacking:** Forcing the app to load a sensitive internal route
   (via `EXTRA_INITIAL_ROUTE`).
2. **Entrypoint Injection:**
   Forcing the app to execute arbitrary Dart functions
   or passing unsafe parameters
   (via `EXTRA_DART_ENTRYPOINT` and `EXTRA_DART_ENTRYPOINT_ARGS`).
3. **Session Hijacking/Privilege Escalation:**
   Reusing an active, pre-authenticated in-memory `FlutterEngine` instance
   (via `EXTRA_CACHED_ENGINE_ID` and `EXTRA_CACHED_ENGINE_GROUP_ID`)
   to access user-restricted states.

To mitigate these issues, we introduced a strict verification check using
Android's `getLaunchedFromUid()` (on Android 14+)
and `getCallingPackage()` (on Android 13 and below).

If the sender of the `Intent` cannot be verified as the app itself,
the `Intent` extras will be safely ignored.
Standard [deep links][] remain supported
but are now validated against the app's declared `AndroidManifest.xml`
[intent filters][].

## Description of change

Any **external** system passing the `"route"`, `"dart_entrypoint"`,
`"dart_entrypoint_args"`, `"cached_engine_id"`,
or `"cached_engine_group_id"` extras
will no longer have an effect in release builds.

### Behavior in Debug/Profile vs. Release
* **Debug and Profile builds:** The verification check is bypassed
  to preserve developer velocity, CLI testing (`adb shell am start`),
  and automated instrumentation tests.
  However, if a verification check would have failed,
  a warning is logged to alert developers.
* **Release builds:** Enforced strictly.
  Extras from unverified sources are silently ignored.

### Affected Scenarios
* **Push Notifications:** If a push notification payload or SDK builds
  a `PendingIntent` that passes the Flutter `"route"` `Intent` extra
  (which automatically configures the initial route of the app),
  this extra will be ignored on Android 13 and below (API 33 and lower)
  because the OS calling package metadata is lost.
  On Android 14+ (API 34), this will continue to work.
  Custom data extras processed manually in Dart are not affected.
* **App Shortcuts and Home Screen Widgets:** Tap actions on widgets
  or shortcuts that launch `FlutterActivity` directly
  with route/entrypoint extras will fail verification in release builds
  because the launch is initiated by the system launcher
  or system widget host.
* **Internal Cached Engine & Entrypoint Launches:**
  If an application launches a pre-warmed cached engine
  or custom entrypoint dynamically from its own native code
  (e.g. from a background [`Service`][] or [`BroadcastReceiver`][]
  using standard `startActivity(intent)`),
  it will fail to resolve the cached engine or entrypoint parameters
  on Android 13 and below if the target activity is exported.

## Migration guide

:::note
You are **NOT affected** and do not need to migrate
if **ANY** of the following are true:
- **You do not use custom intent extras:** You only use the default
  entrypoint (`main()`) and route (`/`), and do not launch cached engines
  (i.e., you never pass `route`, `dart_entrypoint`, `dart_entrypoint_args`,
  `cached_engine_id`, or `cached_engine_group_id` as `Intent` extras).
- **Your activity is internal:** Your target `FlutterActivity` or
  `FlutterFragmentActivity` is non-exported (`android:exported="false"`).
  Since it is non-exported, it automatically passes
  the embedder's security verification.
:::

Depending on your application's use case,
you should migrate using one of the following methods:

### For Push Notifications, App Shortcuts, and Home Screen Widgets
We recommend migrating to use standard [deep links][]
instead of `Intent` extras.

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

Ensure that your `AndroidManifest.xml` declares the corresponding
`<intent-filter>` for the deep link,
as the embedder will use those `Intent` filters
to verify that the route is legitimate.

Alternatively, if you must use `Intent` extras,
you can configure your push notification, shortcut, or widget
to launch a custom, unexported `Activity` or `BroadcastReceiver`
that you control:

* **If your target `FlutterActivity` is non-exported:**
  Your custom component can launch the `FlutterActivity` directly
  using `startActivity`.
  Since the target `Activity` is non-exported,
  it automatically passes the embedder's security verification.
* **If your target `FlutterActivity` must remain exported:**
  On Android 13 and below, launching it from a `BroadcastReceiver` or `Service`
  will **fail** verification because `getCallingPackage()` is always `null`
  for non-Activity context launches.
  In this scenario, your receiver should launch an intermediate,
  unexported helper `Activity` first,
  which then launches the `FlutterActivity` using `startActivityForResult`.

### For Internal Cached Engine or Entrypoint Launches
If your app launches custom entrypoints or cached engines internally,
you have three primary options:

#### Option 1: Mark host activities as non-exported (Recommended where possible)
If the `Activity` hosting the cached engine or custom entrypoint
does not need to be opened by external third-party apps,
ensure it is not exported.

In your `AndroidManifest.xml`:
```xml
<activity
    android:name="io.flutter.embedding.android.FlutterActivity"
    android:exported="false"> <!-- Secure. Only your app can launch this -->
</activity>
```

> **Note:** The primary launcher `Activity` of your app
> (the one containing the `android.intent.action.MAIN`
> and `android.intent.category.LAUNCHER` intent filters)
> **must** remain exported so that the OS Launcher can start your app.
> Consequently, you cannot use this option for your main launcher activity.

#### Option 2: Use `startActivityForResult` for internal launches
If the activity must remain exported (to handle deep links, for example),
but you also want to launch it internally with custom entrypoints, routes,
or cached engines on legacy Android versions (API 33 and below):

Change your Kotlin/Java caller code to request a result
(using a dummy request code):
```diff
- startActivity(intent)
+ startActivityForResult(intent, request_code)
```
*Note: You do not need to implement [`onActivityResult()`] in the caller activity.*

#### Option 3: Configure settings via Manifest `<meta-data>`
For configurations that are static or known at compile time,
avoid passing them via `Intent` extras.
Instead, declare them directly in your manifest.

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
For dynamic configurations that cannot use `startActivityForResult`
(e.g. launches from background `Services` or `BroadcastReceivers`),
you can subclass `FlutterActivity` or `FlutterFragmentActivity`
and programmatically supply the parameters:

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

## References

* [Android `Intent` filters][]
* [Set up Flutter Android deep links][]

Relevant issue:

* [Issue 190450][]
* [Issue 190452][]

Relevant PR:

* [PR 190249][]

[`Intent`]: https://developer.android.com/reference/android/content/Intent
[`Service`]: https://developer.android.com/reference/android/app/Service
[`BroadcastReceiver`]: https://developer.android.com/reference/android/content/BroadcastReceiver
[deep links]: https://docs.flutter.dev/cookbook/navigation/set-up-app-links
[intent filters]: https://developer.android.com/guide/components/intents-filters
[onActivityResult()]: https://developer.android.com/reference/android/app/Activity#onActivityResult(int,%20int,%20android.content.Intent)
[Android `Intent` filters]: https://developer.android.com/guide/components/intents-filters
[Set up Flutter Android deep links]: https://docs.flutter.dev/cookbook/navigation/set-up-app-links
[Issue 190450]: https://github.com/flutter/flutter/issues/190450
[Issue 190452]: https://github.com/flutter/flutter/issues/190452
[PR 190249]: https://github.com/flutter/flutter/pull/190249
