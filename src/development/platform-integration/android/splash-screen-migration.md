---
title: Deprecated Splash Screen API Migration
description: How to migrate from Manifest/Activity defined splash screen.
---

Prior to Flutter 2.5, Flutter apps could add a splash
screen by defining it within the metadata of their application manifest file
(`AndroidManifest.xml`), by implementing [`provideSplashScreen`][] within
their [`FlutterActivity`][], or both. This would display momentarily in between
the time after the Android launch screen is shown and when Flutter has
drawn the first frame. This approach is now deprecated as of Flutter 2.5.
Flutter now automatically keeps the Android launch screen displayed
until it draws the first frame.

To migrate from defining a custom splash screen to just defining a custom
launch screen for your application, follow the steps that correspond
to how your application's custom splash screen was defined
prior to the 2.5 release.

**Custom splash screen defined in [`FlutterActivity`][]**

1. Locate your application's implementation of `provideSplashScreen()`
   within its `FlutterActivity` and **delete it**. This implementation should involve
   the construction of your application's custom splash screen
   as a `Drawable`. For example:

   ```java
   @Override
   public SplashScreen provideSplashScreen() {
       // ...
       return new DrawableSplashScreen(
           new SomeDrawable(
               ContextCompat.getDrawable(this, R.some_splash_screen)));
   }
   ```

2. Use the steps in the section directly following to ensure that your
   `Drawable` splash screen (`R.some_splash_screen` in the previous example)
   is properly configured as your application's custom launch screen.

**Custom splash screen defined in Manifest**

1. Locate your application's `AndroidManifest.xml` file.
   Within this file, find the `activity` element.
   Within this element, identify the `android:theme` attribute
   and the `meta-data` element that defines
   a splash screen as an
   `io.flutter.embedding.android.SplashScreenDrawable`,
   and update it. For example:

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

2. If the `android:theme` attribute isn't specified, add the attribute and
   [define a launch theme][] for your application's launch screen.

3. Delete the `meta-data` element, as Flutter no longer
   uses that, but it can cause a crash.

4. Locate the definition of the theme specified by the `android:theme` attribute
   within your application's `style` resources. This theme specifies the
   launch theme of your application. Ensure that the `style` attribute configures the
   `android:windowBackground` attribute with your custom splash screen. For example:

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

[`provideSplashScreen`]: {{site.api}}/javadoc/io/flutter/embedding/android/SplashScreenProvider.html#provideSplashScreen--
[`FlutterActivity`]: {{site.api}}/javadoc/io/flutter/embedding/android/FlutterActivity.html
[define a launch theme]:  {{site.url}}/development/ui/advanced/splash-screen?tab=android-splash-alignment-kotlin-tab#initializing-the-app
