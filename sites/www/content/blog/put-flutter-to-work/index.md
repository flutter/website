---
title: "Put Flutter to Work"
description: >-
  Connect a Flutter feature to a native app and get up and running in just a few
  lines of code
publishDate: 2022-05-26
author: verygoodopensource
image: images/17pcNynupdvylRqlRdi6rPQ.webp
category: tutorial
layout: blog
---

<DashImage figure src="images/17pcNynupdvylRqlRdi6rPQ.webp" />

If you’ve ever wanted to try using Flutter, but don’t want to build something from scratch, Flutter’s [add-to-app functionality](https://docs.flutter.dev/development/add-to-app) is a great place to start. To make it even easier to put Flutter to work for you, we teamed up with the Flutter team to create a sample add-to-app prototype to showcase how Flutter can be integrated into a native codebase with minimal effort. Whether you want to take Flutter for a trial run or show your team how Flutter works in a tangible way, this article is for you!

<DashImage figure src="images/1gJk1B6Jqynp6QGXirf8VBQ.webp" />

## Adding Flutter to a native newsfeed app

In this tutorial, we’ll show you how to take a Flutter feature and, using Flutter’s add-to-app API, incorporate it into a native app in just a few lines.

The project we’ll look at is split into two parts. The first part contains three identical newsfeed applications for three separate native platforms: Android, iOS, and the web. The app is interactive, so you can run it on a device and scroll through the articles, click on the news items, and more. The second part of this project is a dialog that pops up when interacting with the app and asks users to submit feedback. This feature, which we’ll call the NPS (Net Promoter Score) module, is built with Flutter.

First, go to the [example repository](https://github.com/flutter/put-flutter-to-work). Here you’ll see a folder for each platform containing the native code for the newsfeed app. Also in the repository is the `flutter_nps` folder that contains all of the Flutter code for the NPS module.

## Adding Flutter on the web with Angular

The Flutter module runs as an `<iframe>` within the native web app. To integrate the feature into the Angular codebase, first run a Flutter build for the web target. This step generates an `index.html` and other necessary files. Copy all of the build files into the Angular app `src` folder. From there, you can reference the build files within the `iframe`. The next time you run the web app, you’ll see the Flutter feature!

**[View the README for full instructions](https://github.com/flutter/put-flutter-to-work#web).**

## Adding Flutter to Android with Kotlin

Now let’s add the NPS module into the Android app. First start a [Flutter activity using a cached engine](https://docs.flutter.dev/development/add-to-app/android/add-flutter-screen#step-3-optional-use-a-cached-flutterengine). As soon as you launch the native news app, the Flutter engine warms up in the background. Then, you’ll start a new activity and point it to the Flutter activity. This ensures a quick transition from the native Kotlin code to Flutter and allow the Flutter feature to work seamlessly within the Android app.

**[View the README for full instructions](https://github.com/flutter/put-flutter-to-work#android).**

## Adding Flutter on iOS with SwiftUI

Finally, we can add the NPS Module into the iOS App. First, embed the compiled Flutter module into your application in Xcode’s build settings. Then, in your application delegate, create an instance of the Flutter engine and start it up. With that done, you’re ready to display Flutter UI wherever needed — just create a `FlutterViewController` using the Flutter Engine and present it. Then run `flutter build ios-framework` with the path.

**[View the README for full instructions](https://github.com/flutter/put-flutter-to-work#ios).**

## Put Flutter to work for you (and your team!)

Now that you have the Flutter code up and running within your app, you can experiment with some of the fun parts of Flutter. The following sections include some ideas for where to begin.

## Supporting multiple platforms

In this newsfeed example, you can see how the NPS module supports platform differences. On the web, the module appears as a dialog on top of the newsfeed and reacts to input from a mouse or screen reader. On mobile, the module takes up the full screen space and reacts to input via touch or screen reader.

Note that the Flutter NPS module contains Material widgets, which automatically handle gesture detection, depending on the user’s device. If using a desktop device, the app receives mouse input, and if using a mobile device, the app receives touch input.

## Animations

This prototype includes a few [implicit animations](https://docs.flutter.dev/development/ui/animations/implicit-animations) that are easy to adjust since they are built into the Flutter framework. For example, if you want to make changes to the `AnimatedContainer` widget, simply adjust its properties, such as the duration of the animation, the height of the container, its shape, and color.

```dart
// ...
return AnimatedContainer(
  duration: duration,
  height: Spacing.huge,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: isSelected
      ? NpsColors.colorSecondary
      : NpsColors.colorGrey5,
  ),
  // ...
);
```

The NPS module includes a custom page animation transition. Take a look at the `SlideTransition` widget for another animation example that could be customized by updating its duration and other elements.

```dart
SlideTransition(
  position: Tween<Offset>(
    begin: const Offset(0, 1),
    end: Offset.zero,
  ).animate(animation),
  child: child,
);
```

If you want to take your animations to the next level, you could import the [`animations`](https://pub.dev/packages/animations) package from pub.dev and use some of the fancy, pre-built animations.

## `Theming`

It’s also simple to update the theme of the NPS module. Because it uses the built-in Material theming via [`ThemeData`](https://api.flutter.dev/flutter/material/ThemeData-class.html), you can simply update the colors, button style, and font all in one place. For example, to change the `accentColor` and `backgroundColor` of the NPS module with Flutter, update to your desired color using the provided [Material color palette shades](https://api.flutter.dev/flutter/material/Colors-class.html), or your desired custom colors.

```dart
class AppTheme {
  ThemeData get theme =>
      ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          accentColor: NpsColors.colorSecondary,
          backgroundColor: NpsColors.colorWhite,
        ),
        scaffoldBackgroundColor: NpsColors.colorWhite,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: NpsColors.colorSecondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ).copyWith(
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (!states.contains(MaterialState.disabled)) {
                  return NpsColors.colorSecondary;
                } else if (states.contains(MaterialState.disabled)) {
                  return NpsColors.colorWhite;
                }
                return null;
              },
            ),
          ),
        ),
        textTheme: const TextTheme(
          headline5: NpsStyles.headline5,
          subtitle1: NpsStyles.subtitle1,
          bodyText2: NpsStyles.link,
        ),
      );
}
```

## Additional features

The Flutter NPS module uses [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) for state management to keep track of the user’s score response. Cubit is one of [many options for state management](https://docs.flutter.dev/development/data-and-backend/state-mgmt/options) when building Flutter applications. The feature also includes [unit and widget tests](https://docs.flutter.dev/testing), which are useful tools to ensure that the code you’re writing is working as intended. Finally, the codebase has [localization](https://docs.flutter.dev/development/accessibility-and-localization/internationalization) support for 78 languages out of the box. This project has [GitHub Actions integration for continuous integration](https://github.com/VGVentures/take-flutter-home/tree/main/.github/workflows) to run formatting, linting, and test phases before merging changes.

## Backend

While this prototype does not currently interact with a backend, you could configure it with a backend of your choosing to store the data from the NPS module, or even pull in sample articles for the native newsfeed. One option to explore is Firebase, which integrates seamlessly with Flutter. [See the Firebase documentation to add Firebase to your Flutter app](https://firebase.google.com/docs/flutter/setup?platform=ios).

Now that you know how to add a Flutter feature into a native web, Android, and iOS codebase, you could follow a similar process to integrate the feature into any native app. See the full [add-to-app documentation](https://docs.flutter.dev/development/add-to-app) for more information.

## Check out the full code in the [open source repository here](https://github.com/flutter/put-flutter-to-work).
