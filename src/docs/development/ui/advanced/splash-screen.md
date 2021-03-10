---
title: Adding a splash screen to your mobile app
short-title: Splash screens
description: Learn how to add a splash screen to your mobile app.
---

{% asset
development/ui/splash-screen/android-splash-screen/splash-screens_header.png
class="mw-100" alt="Add Splash Screen Header" %}

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

### The Flutter splash screen

Each Flutter experience in an app requires a few moments
to initialize the Dart isolate that runs the code.
This means that a user momentarily sees a blank screen
until Flutter renders its first frame. Flutter supports
an improved user experience by displaying an Android
`View` as a splash screen while Flutter initializes.

Flutter supports two options for a splash screen.
The first option is to  display a `Drawable` of
your choice, which fades out after the initialization
is complete. The other option is to provide a custom
`SplashScreen` that is capable of displaying any
Android `View` content that you want.

A `Drawable` splash screen can be configured for a
`FlutterActivity`, `FlutterFragment`, or `FlutterView`.

#### In a FlutterActivity

To display a `Drawable` as a Flutter splash screen
in a `FlutterActivity`, add the following metadata
to the associated `FlutterActivity` in `AndroidManifest.xml`.

```xml
<meta-data
    android:name="io.flutter.embedding.android.SplashScreenDrawable"
    android:resource="@drawable/my_splash"
    />
```

To display a splash screen with the same visual as a launch screen,
reference the same `@drawable/launch_background` in the
`io.flutter.embedding.android.SplashScreenDrawable` `meta-data`.

#### In a FlutterFragment

To display a `Drawable` as a Flutter splash screen in a
`FlutterFragment`, make a subclass of `FlutterFragment`
and override `provideSplashScreen()`.

```java
public class MyFlutterFragment extends FlutterFragment {
    @Override
    protected SplashScreen provideSplashScreen() {
        // Load the splash Drawable.
        Drawable splash = getResources().getDrawable(R.drawable.my_splash);

        // Construct a DrawableSplashScreen with the loaded splash
        // Drawable and return it.
        return new DrawableSplashScreen(splash);
    }
}
```

### Creating a custom SplashScreen

Splash screens are a great branding opportunity.
Because of that, many apps implement unique,
highly customized splash experiences. To facilitate this,
Flutter allows you to display an arbitrary Android `View`
as a splash screen, and even allows you to control how
that `View` transitions to
Flutter after Flutter renders its first frame.

#### Implement a custom splash View

First, define the custom `View` that should be displayed
as the splash screen. This `View` could display anything,
from a simple solid color to an animation.

#### Implement the SplashScreen interface

With a custom `View` defined, implement the `SplashScreen`
interface.

This guide shows two approaches to a `SplashScreen`
implementation. First, the following is an example of a
`SplashScreen` that has no visual state and no transition
animation.

```java
public class SimpleSplashScreen implements SplashScreen {
    @Override
    @Nullable
    public View createSplashView(
      @NonNull Context context,
      @Nullable Bundle savedInstanceState
    ) {
        // Return a new MySplashView without saving a reference, because it
        // has no state that needs to be tracked or controlled.
        return new MySplashView(context);
    }

    @Override
    public void transitionToFlutter(@NonNull Runnable onTransitionComplete) {
        // Immediately invoke onTransitionComplete because this SplashScreen
        // doesn't display a transition animation.
        //
        // Every SplashScreen *MUST* invoke onTransitionComplete at some point
        // for the splash system to work correctly.
        onTransitionComplete.run();
    }
}
```

The second example is a bit more sophisticated.
In this example, the custom `SplashScreen` keeps
a reference to its custom `View` and instructs the custom
`View` to transition away, passing the `onTransitionComplete`
callback to the custom `View` to invoke.

```java
public class SplashScreenWithTransition implements SplashScreen {
    private MySplashView mySplashView;

    @Override
    @Nullable
    public View createSplashView(
      @NonNull Context context,
      @Nullable Bundle savedInstanceState
    ) {
        // A reference to the MySplashView is retained so that it can be told
        // to transition away at the appropriate time.
        mySplashView = new MySplashView(context);
        return mySplashView;
    }

    @Override
    public void transitionToFlutter(@NonNull Runnable onTransitionComplete) {
        // Instruct MySplashView to animate away in whatever manner it wants.
        // The onTransitionComplete Runnable is passed to the MySplashView
        // to be invoked when the transition animation is complete.
        mySplashView.animateAway(onTransitionComplete);
    }
}
```
```java

//MainActivity provideSplashScreen will present the custom splash screen

@Override

@Nullable

public SplashScreen provideSplashScreen() {

return new SplashScreenWithTransition();

}

```

With custom splash screens, the sky is the limit.
But use the power you have with responsibility: a
splash screen that is too complex may frustrate your
users by adding to your app's load time.
The UX Collective provides some good
tips on how to build a [dynamic yet performant splash screen][].


[dynamic yet performant splash screen]: https://uxdesign.cc/building-the-perfect-splash-screen-46e080395f06
[launch screen]: {{site.android-dev}}/topic/performance/vitals/launch-time#themed
[pre-warming a `FlutterEngine`]: /docs/development/add-to-app/android/add-flutter-fragment#using-a-pre-warmed-flutterengine
[must use an Xcode storyboard]: https://developer.apple.com/news/?id=03042020b
[Human Interface Guidelines]: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/launch-screen/
[Sample code]: {{site.github}}/flutter/flutter/tree/master/dev/integration_tests/android_splash_screens
