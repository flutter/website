---
title: Adding a splash screen to your mobile app
short-title: Splash screens
description: Learn how to add a splash screen to your mobile app.
---

<img src='/assets/images/docs/development/ui/splash-screen/android-splash-screen/splash-screens_header.png'
class="mw-100" alt="Add Splash Screen Header">

Splash screens (also known as launch screens)
provide a simple initial experience while your
mobile app loads. They set the stage for your
application, while allowing time for the app
engine to load and your app to initialize.
This guide teaches you how to use splash screens
appropriately on iOS and Android.

## iOS launch screen

All apps submitted to the Apple App Store
[must use an Xcode storyboard][] to
provide the app's launch screen.

The default Flutter template includes an Xcode
storyboard named `LaunchScreen.storyboard`
that can be customized as you see fit with
your own assets. By default,
the storyboard displays a blank image,
but you can change this. To do so,
open the Flutter app's Xcode project
by typing `open ios/Runner.xcworkspace`
from the root of your app directory.
Then select `Runner/Assets.xcassets`
from the Project Navigator and
drop in the desired images to the `LaunchImage` image set.

Apple provides detailed guidance for launch screens as
part of the [Human Interface Guidelines][].

## Android launch screen

In Android, there are two separate screens that you can control:
a _launch screen_ shown while your Android app initializes,
and a _splash screen_ that displays while the Flutter experience
initializes.

{{site.alert.note}}
  For apps that embed one or more Flutter screens within an
  existing Android app, consider
  [pre-warming a `FlutterEngine`][] and reusing the
  same engine throughout your app to minimize wait
  time associated with initialization of the Flutter engine.
{{site.alert.end}}

### Initializing the app

Every Android app requires initialization time while the
operating system sets up the app's process.
Android provides the concept of a [launch screen][] to
display a `Drawable` while the app is initializing.

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

In addition, `style.xml` defines a _normal theme_
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

### Set up the FlutterActivity in AndroidManifest.xml

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

### Android S

See [Android Splash Screens][] first on how to configure your splash screen on
Android S.

Make sure neither `io.flutter.embedding.android.SplashScreenDrawable` is set in
your manifest, nor is `provideSplashScreen` implemented, as these APIs are
deprecated. Doing so will cause the Android splash screen to fade smoothly into
the Flutter when the app is launched.

Some apps may want to continue showing the last frame of the Android splash
screen in Flutter. For example, this preserves the illusion of a single frame
while additional loading continues in Dart. To achieve this, the following
Android APIs may be helpful:

{% samplecode android-splash-alignment %}
{% sample Java %}
<!--code-excerpt "MainActivity.java" title-->
```java
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
{% sample Kotlin %}
<!--code-excerpt "MainActivity.kt" title-->
```kotlin
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
{% endsamplecode %}

Then, you can reimplement the first frame in Flutter that shows elements of your
Android splash screen in the same positions on screen.

### Migrating from Manifest / Activity defined custom splash screens

{{site.alert.note}}
  This is an upcoming change for Flutter 2.5.
{{site.alert.end}}

Previously, Android Flutter apps would either set
`io.flutter.embedding.android.SplashScreenDrawable` in their application
manifest, or implement [`provideSplashScreen`][] within their Flutter Activity.
This would be shown momentarily in between the time after the Android launch
screen is shown and when Flutter has drawn the first frame. This is no longer
needed and is deprecated – Flutter now automatically keeps the Android launch
screen displayed until Flutter has drawn the first frame. Developers should
instead remove usage of these APIs.

[Android Splash Screens]: {{site.android-dev}}/about/versions/12/features/splash-screen
[launch screen]: {{site.android-dev}}/topic/performance/vitals/launch-time#themed
[pre-warming a `FlutterEngine`]:/development/add-to-app/android/add-flutter-fragment#using-a-pre-warmed-flutterengine
[`provideSplashScreen`]: {{site.api}}/javadoc/io/flutter/embedding/android/SplashScreenProvider.html#provideSplashScreen--
[must use an Xcode storyboard]: {{site.apple-dev}}/news/?id=03042020b
[Human Interface Guidelines]: {{site.apple-dev}}/design/human-interface-guidelines/ios/visual-design/launch-screen/
