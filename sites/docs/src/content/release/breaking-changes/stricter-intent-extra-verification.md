---
title: Stricter Intent Extra Verification for FlutterActivity
description: Android Intent extras for routing and entrypoints are now strictly verified.
---

{% render "docs/breaking-changes.md" %}

## Summary

To protect against Intent-based vulnerability exploits,
the Flutter Android embedder (`FlutterActivity` and `FlutterFragmentActivity`)
now strictly verifies the sender of Intents
before processing `EXTRA_INITIAL_ROUTE`, `EXTRA_DART_ENTRYPOINT`,
and `EXTRA_DART_ENTRYPOINT_ARGS`. 

External intents that try to pass these string extras (e.g., `"route"`)
will now be ignored
unless they are verified as originating from the app itself.

## Context

Historically, the Flutter Android embedder unconditionally accepted
routing and entrypoint configuration from Intent extras.
While convenient, this allowed third-party applications on the same device
to maliciously inject entrypoints or routes into a Flutter app
by sending an explicit Intent. 

To mitigate arbitrary route injection (CWE-940)
and entrypoint injection (CWE-926),
we introduced a strict verification layer
using Android's `getLaunchedFromUid()` (on Android 14+)
and `getCallingPackage()` (on Android 13 and below). 

If the sender of the Intent cannot be verified as the app itself,
the intent extras will be safely ignored.
Standard Deep Links (`intent.getData()`) remain supported
but are now validated against the app's declared `AndroidManifest.xml`
intent-filters.

## Description of change

Any external system passing the `"route"`, `"dart_entrypoint"`,
or `"dart_entrypoint_args"` extras will no longer have an effect. 

The most common legitimate use-case affected by this change
is **Push Notifications** (e.g., Firebase Cloud Messaging).
Push notification SDKs frequently build a `PendingIntent`
that includes a `"route"` string extra
to navigate the user to a specific screen when the notification is tapped. 

On Android 14+ (API 34), push notifications via `PendingIntent`
will generally continue to work
because `getLaunchedFromUid()` can successfully verify
the identity of the `PendingIntent` creator. 

However, on **Android 13 and below (API 33 and lower)**,
`getCallingPackage()` is often `null`
when a `PendingIntent` is fired from the notification tray.
As a result, the embedder will safely assume the intent is untrusted
and **ignore the route extra**.

## Migration guide

If your application relies on Push Notifications or App Shortcuts
to launch the app into a specific route,
you should migrate to using standard Deep Link URIs
instead of Intent extras.

**Before (Deprecated & Insecure):**
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
as the embedder will query the PackageManager
to verify the route is legitimate.

Alternatively, if you must use Intent extras,
configure your push notification to launch a custom `Activity`
or `BroadcastReceiver` that you control.
Inside that component, construct a new explicit Intent
to launch your `FlutterActivity`.
Because the new Intent is launched from within your app,
the embedder will successfully verify it as self-sent.

## Timeline

Landed in version: TBD<br>
In stable release: TBD
