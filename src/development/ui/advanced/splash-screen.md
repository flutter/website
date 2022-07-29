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
For an example of this, see the [Android splash screen sample app][].

### Migrating from Manifest / Activity defined custom splash screens

Prior to Flutter 2.5, Flutter apps could add a splash
screen by defining it within the metadata of their application manifest
(`AndroidManifest.xml`) or implementing [`provideSplashScreen`][] within
their [`FlutterActivity`][]. This would show momentarily in between
the time after the Android launch screen is shown and when Flutter has
drawn the first frame. This is now deprecated and no longer needed –
in Flutter 2.5 and later, because Flutter now automatically keeps the
Android launch screen displayed until Flutter has drawn the first frame.

To migrate from defining a custom splash screen to defining a custom
launch screen for your application, follow the steps that correspond
to how your application's custom splash screen was defined
prior to the 2.5 release.

**Custom splash screen defined in [`FlutterActivity`][]**

1. Locate your application's implementation of `provideSplashScreen()`
   within its `FlutterActivity`. This implementation should involve
   the construction of your application's custom splash screen
   `Drawable`, for example:

   ```Java
   @Override
   public SplashScreen provideSplashScreen() {
       // ...
       return new DrawableSplashScreen(
           new SomeDrawable(
               ContextCompat.getDrawable(this, R.some_splash_screen)));
   }
   ```

2. Note this `Drawable`, as this is the `Drawable` that you will specify
   in your application's launch theme. Then, delete this implementation.

3. Follow the steps below to ensure your splash screen `Drawable`
   (`R.some_splash_screen` in the example above) is properly
   configured as your application's custom launch screen.

**Custom splash screen defined in Manifest**

1. Locate your application's `AndroidManifest.xml` file. Within this file,
   find the `activity` element. Within this element, identify the
   `android:theme` attribute and `meta-data` element that defines
   some splash screen as the
   `io.flutter.embedding.android.SplashScreenDrawable`:

   ```xml
   <activity
       // ...
       android:theme="@style/SomeTheme">
     // ...
     <meta-data
         android:name="io.flutter.embedding.android.SplashScreenDrawable"
         android:resource="@drawable/some_splash_screen"
         />
   </activity>
   ```

2. If the `android:theme` attribute is not specified, add the attribute and
   [define a launch theme][] for your application's launch screen.

3. Delete the `meta-data` tag, as Flutter no longer displays the `Drawable`
   that it specifies before showing the application's launch screen.

4. Locate the definition of the theme specified by the `android:theme` attribute
   within your application's `style` resources. This theme is what specifies the
   launch theme of your application. Ensure that this `style` configures the
   `android:windowBackground` attribute with your custom splash screen:

   ```xml
   <resources>
       <style
           name="SomeTheme"
           // ...
           >
           <!-- Show a splash screen on the activity. Automatically removed when
                Flutter draws its first frame -->
           <item name="android:windowBackground">@drawable/some_splash_screen</item>
       </style>
   </resources>
   ```

[Android Splash Screens]: {{site.android-dev}}/about/versions/12/features/splash-screen
[launch screen]: {{site.android-dev}}/topic/performance/vitals/launch-time#themed
[pre-warming a `FlutterEngine`]: {{site.url}}/development/add-to-app/android/add-flutter-fragment#using-a-pre-warmed-flutterengine
[`provideSplashScreen`]: {{site.api}}/javadoc/io/flutter/embedding/android/SplashScreenProvider.html#provideSplashScreen--
[must use an Xcode storyboard]: {{site.apple-dev}}/news/?id=03042020b
[Human Interface Guidelines]: {{site.apple-dev}}/design/human-interface-guidelines/ios/visual-design/launch-screen/
[`FlutterActivity`]: {{site.api}}/javadoc/io/flutter/embedding/android/FlutterActivity.html
[define a theme]:  #initializing-the-app
[Android splash screen sample app]: {{site.github}}/flutter/samples/blob/3a0a652984e9b974342d172b9f0ffa161d0dcb2f/android_splash_screen/android/app/src/main/res/values-night/styles.xml
[define a normal theme]: {{site.url}}/development/ui/advanced/splash-screen?tab=android-splash-alignment-kotlin-tab#initializing-the-app