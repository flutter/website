---
title: Adding a splash screen to your Android app
short-title: Splash screen
description: Learn how to add a splash screen to your Android app.
---

<img src='/assets/images/docs/development/ui/splash-screen/android-splash-screen/splash-screens_header.png'
class="mw-100" alt="A graphic outlining the launch flow of an app including a splash screen">

Splash screens (also known as launch screens) provide 
a simple initial experience while your Android app loads. 
They set the stage for your application, 
while allowing time for the app engine 
to load and your app to initialize.

## Overview

:::warning
If you are experiencing a crash from implementing a splash screen, you
might need to migrate your code. See detailed instructions in the
[Deprecated Splash Screen API Migration guide][].
:::

In Android, there are two separate screens that you can control:
a _launch screen_ shown while your Android app initializes,
and a _splash screen_ that displays while the Flutter experience
initializes.

:::note
As of Flutter 2.5, the launch and splash screens have been
consolidated—Flutter now only implements the Android launch screen,
which is displayed until the framework draws the first frame.
This launch screen can act as both an Android launch screen and an
Android splash screen via customization, and thus, is referred to
as both terms. For example of such customization, check out the
[Android splash screen sample app][].

If, prior to 2.5, you used `flutter create` to create an app,
and you run the app on 2.5 or later, the app might crash.
For more info, see the [Deprecated Splash Screen API Migration guide][].
:::

:::note
For apps that embed one or more Flutter screens within an
existing Android app, consider
[pre-warming a `FlutterEngine`][] and reusing the
same engine throughout your app to minimize wait
time associated with initialization of the Flutter engine.
:::

## Initializing the app

Every Android app requires initialization time while the
operating system sets up the app's process.
Android provides the concept of a [launch screen][] to
display a `Drawable` while the app is initializing.

A `Drawable` is an Android graphic.
To learn how to add a `Drawable` to your
Flutter project in Android Studio,
check out [Import drawables into your project][drawables]
in the Android developer documentation.

The default Flutter project template includes a definition
of a launch theme and a launch background. You can customize
this by editing `styles.xml`, where you can define a theme
whose `windowBackground` is set to the
`Drawable` that should be displayed as the launch screen.

```xml
<style name="LaunchTheme" parent="@android:style/Theme.Black.NoTitleBar">
    <item name="android:windowBackground">@drawable/launch_background</item>
</style>
```

In addition, `styles.xml` defines a _normal theme_
to be applied to `FlutterActivity` after the launch
screen is gone. The normal theme background only shows
for a very brief moment after the splash screen disappears,
and during orientation change and `Activity` restoration.
Therefore, it's recommended that the normal theme use a
solid background color that looks similar to the primary
background color of the Flutter UI.

```xml
<style name="NormalTheme" parent="@android:style/Theme.Black.NoTitleBar">
    <item name="android:windowBackground">@drawable/normal_background</item>
</style>
```

[drawables]: {{site.android-dev}}/studio/write/resource-manager#import

## Set up the FlutterActivity in AndroidManifest.xml

In `AndroidManifest.xml`, set the `theme` of
`FlutterActivity` to the launch theme. Then,
add a metadata element to the desired `FlutterActivity`
to instruct Flutter to switch from the launch theme
to the normal theme at the appropriate time.

```xml
<activity
    android:name=".MyActivity"
    android:theme="@style/LaunchTheme"
    // ...
    >
    <meta-data
        android:name="io.flutter.embedding.android.NormalTheme"
        android:resource="@style/NormalTheme"
        />
    <intent-filter>
        <action android:name="android.intent.action.MAIN"/>
        <category android:name="android.intent.category.LAUNCHER"/>
    </intent-filter>
</activity>
```

The Android app now displays the desired launch screen
while the app initializes.

## Android 12

To configure your launch screen on Android 12,
check out [Android Splash Screens][].

As of Android 12, you must use the new splash screen
API in your `styles.xml` file.
Consider creating an alternate resource file for Android 12 and higher.
Also make sure that your background image is in line with
the icon guidelines;
check out [Android Splash Screens][] for more details.

```xml
<style name="LaunchTheme" parent="@android:style/Theme.Black.NoTitleBar">
    <item name="android:windowSplashScreenBackground">@color/bgColor</item>
    <item name="android:windowSplashScreenAnimatedIcon">@drawable/launch_background</item>
</style>
```

Make sure that
`io.flutter.embedding.android.SplashScreenDrawable` is
**not** set in your manifest, and that `provideSplashScreen`
is **not** implemented, as these APIs are deprecated.
Doing so causes the Android launch screen to fade smoothly
into the Flutter when the
app is launched and the app might crash.

Some apps might want to continue showing the last frame of
the Android launch screen in Flutter. For example,
this preserves the illusion of a single frame
while additional loading continues in Dart.
To achieve this, the following
Android APIs might be helpful:

{% tabs "android-language" %}
{% tab "Kotlin" %}

```kotlin title="MainActivity.kt"
import android.os.Build
import android.os.Bundle
import androidx.core.view.WindowCompat
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    // Aligns the Flutter view vertically with the window.
    WindowCompat.setDecorFitsSystemWindows(getWindow(), false)

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
      // Disable the Android splash screen fade out animation to avoid
      // a flicker before the similar frame is drawn in Flutter.
      splashScreen.setOnExitAnimationListener { splashScreenView -> splashScreenView.remove() }
    }

    super.onCreate(savedInstanceState)
  }
}
```

{% endtab %}
{% tab "Java" %}

```java title="MainActivity.java"
import android.os.Build;
import android.os.Bundle;
import android.window.SplashScreenView;
import androidx.core.view.WindowCompat;
import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        // Aligns the Flutter view vertically with the window.
        WindowCompat.setDecorFitsSystemWindows(getWindow(), false);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            // Disable the Android splash screen fade out animation to avoid
            // a flicker before the similar frame is drawn in Flutter.
            getSplashScreen()
                .setOnExitAnimationListener(
                    (SplashScreenView splashScreenView) -> {
                        splashScreenView.remove();
                    });
        }

        super.onCreate(savedInstanceState);
    }
}
```

{% endtab %}
{% endtabs %}

Then, you can reimplement the first frame in Flutter
that shows elements of your Android launch screen in
the same positions on screen.
For an example of this, check out the
[Android splash screen sample app][].

[Android Splash Screens]: {{site.android-dev}}/about/versions/12/features/splash-screen
[launch screen]: {{site.android-dev}}/topic/performance/vitals/launch-time#themed
[pre-warming a `FlutterEngine`]: /add-to-app/android/add-flutter-fragment#using-a-pre-warmed-flutterengine
[Android splash screen sample app]: {{site.repo.samples}}/tree/main/android_splash_screen
[Deprecated Splash Screen API Migration guide]: /release/breaking-changes/splash-screen-migration
[Customizing web app initialization guide]: /platform-integration/web/initialization
