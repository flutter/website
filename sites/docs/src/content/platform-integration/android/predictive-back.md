---
title: Add the predictive-back gesture
shortTitle: Predictive-back
description: >-
  Learn how to enable and handle Android predictive back gestures in Flutter.
---

The Android predictive back gesture lets users preview
where a back gesture will navigate to,
whether that's the previous screen or the home screen,
before they commit to or cancel it.

## Overview

Starting with Android 14 (API level 34), predictive back animations are
enabled by default for system gestures when supported by the application.
Flutter provides built-in support for predictive back animations across
default page route transitions and custom pop handling.

## Enable predictive back in Android

To support predictive back gestures in your Flutter app
on Android 13 or later:

1. Open `android/app/src/main/AndroidManifest.xml`.
2. Add `android:enableOnBackInvokedCallback="true"` to the `<application>` tag:

<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <application
        android:label="my_app"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher"
        android:enableOnBackInvokedCallback="true">
        <!-- ... -->
    </application>
</manifest>
```

## Handle back gestures with PopScope

To customize back navigation or prevent users from accidentally leaving a
screen, use the [`PopScope`]({{site.api}}/flutter/widgets/PopScope-class.html)
widget. `PopScope` replaces the deprecated `WillPopScope` widget and
supports predictive back gestures.

### Callback parameters

`PopScope` uses the `onPopInvokedWithResult` callback:

* `didPop`: A boolean indicating whether the pop operation succeeded.
  If `canPop` is `false`, `didPop` is `false`.
* `result`: An optional return payload passed when popping the route
  (for example, with `Navigator.pop(context, result)`).

### Example: Intercepting back navigation

```dart
PopScope(
  canPop: false,
  onPopInvokedWithResult: (bool didPop, Object? result) async {
    if (didPop) {
      return;
    }
    final shouldLeave = await _showExitConfirmationDialog(context);
    if (shouldLeave && context.mounted) {
      Navigator.of(context).pop(result);
    }
  },
  child: Scaffold(
    appBar: AppBar(title: const Text('Form Screen')),
    body: const Center(child: Text('Complete the form before leaving.')),
  ),
)
```

## More information

For more details on API migrations, check out the
[Android predictive back migration guide](
/release/breaking-changes/android-predictive-back).

