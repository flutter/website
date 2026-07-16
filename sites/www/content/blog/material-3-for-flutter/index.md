---
title: "Material 3 for Flutter"
description: "Sherlock Holmes and Dr Watson; peanut butter and jam; Flutter and Material! These matches are made in heaven!"
publishDate: 2023-01-18
author: esouthren
image: images/0RuCmIqSnK0G0kHmy.webp
category: announcement
layout: blog
---

<DashImage figure src="images/0RuCmIqSnK0G0kHmy.webp" />


## Material 3 for Flutter

### Sherlock Holmes and Dr Watson; peanut butter and jam; Flutter and Material! These matches are made in heaven!

[Material](https://m3.material.io/) is a design system that helps you build beautiful, accessible apps across mobile, web, and desktop.

In Flutter, the [Material library](https://api.flutter.dev/flutter/material/Material-class.html) provides developers with all the building blocks your UI needs. Since the launch of Material 3 at Google I/O 2021, the Flutter team has been updating Flutter’s Material library to support these new changes.

I joined the Material for Flutter team in August 2022. Since then, I’ve been helping update widgets to Material 3 specifications, while supporting Material 3 users in the open source Flutter community.

In this article, I’ll show you the new features in Material 3, how to integrate them into your Flutter app, and update you on what’s coming next.

<DashImage figure src="images/06JGBM5itMcIMnvYV.webp" alt="The Flutter Material 3 sample app" caption="The Flutter Material 3 sample app" />


## Material 3

To see all the latest Material 3 updates, check out our [sample app](https://flutter.github.io/samples/web/material_3_demo/#/). It allows you to interact with all of the widgets live.

This app demonstrates the updated components and lets you toggle between Material 2 and Material 3, light mode and dark mode, and try out different color schemes.

## Getting started

To add Material 3 to your app, set the [`useMaterial3`](https://api.flutter.dev/flutter/material/ThemeData/useMaterial3.html) flag to `true` in your theme’s constructor:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      body: MyHomePage(),
    );
  }
}
```


For information on migrating an existing Flutter app, check out [Migrating a Flutter app to Material 3](https://blog.codemagic.io/migrating-a-flutter-app-to-material-3/), an article by Flutter contributor Taha Tesser at CodeMagic.

At the time of this writing, you have the *option* to use Material 3. In the future, it will become the default (and mandatory) Material version for Flutter apps.

## New widgets

To get most of the widget changes, set the `useMaterial3` flag. However, some widgets have changed so much in Material 3 that they’ve been replaced with new widgets. Here are some of the new widgets:

### NavigationBar & NavigationDrawer

The [`BottomNavigationBar`](https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html) widget has been replaced with the [`NavigationBar`](https://api.flutter.dev/flutter/material/NavigationBar-class.html). It’s a little taller and doesn’t have a drop-shadow (that indicates elevation).

### Segmented buttons

Segmented buttons give your user a toggleable choice from several options *in a single widget*. By default, you can only select one item, unless you specify the `multiSelectionEnabled` parameter.

<DashImage figure src="images/0gjBdIy6V7lT5XGk2.gif" alt="Segmented buttons — single selection and multi selection" caption="Segmented buttons — single selection and multi selection" />


### Filled buttons

We’ve increased our selection of `Button`s to include the new `[FilledButton](https://m3.material.io/components/buttons/guidelines#07a1577b-aaf5-4824-a698-03526421058b).` This button creates a colored, non-elevated button. The `FilledButton.tonal`method sets current background as a secondary color.

<DashImage figure src="images/1Rh5tEKBvA8ivNBGgDB7X9w.gif" alt="Elevated, Filled, and Outlined buttons" caption="Elevated, Filled, and Outlined buttons" />


### Badges

The new [`Badge`](https://master-api.flutter.dev/flutter/material/Badge-class.html) widget can be used to give extra information, generally indicating a count or change of status, to a parent widget. They’re available in large and small sizes:

<DashImage figure src="images/0SgE01KkHs1LzX0TN.webp" alt="Badge widgets attached to parent Icons" caption="Badge widgets attached to parent Icons" />


## Generating a color scheme

A brand new feature of Material 3 allows you to set the color theme of your *entire* app from a single seed color. Set the color scheme seed parameter in your theme constructor and, from that *one* entry, Flutter generates a harmonious color scheme for **every** widget in your app. This scheme works in both light *and* dark modes!

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(
        useMaterial3: true,
        colorSchemeSeed: Color.fromRGBO(188, 0, 74, 1.0);
        ),
      body: MyHomePage(),
    );
  }
```


<DashImage figure src="images/0udIjHdleLcn1C0Ox.webp" />


<DashImage figure src="images/0IM7o73HEWHQMgHUe.webp" alt="Color schemes and tint values generated from a seed color" caption="Color schemes and tint values generated from a seed color" />


If you’d like to customize your color scheme further, visit the [Material generator app](https://m3.material.io/theme-builder#/custom). You can define secondary and tertiary colors to create a completely unique color palette. Best of all, it exports Dart files that you can use immediately in your Flutter app.

## What’s next?

Flutter’s migration to Material 3 continues. You can follow the progress at the [Bring Material 3 to Flutter](https://github.com/flutter/flutter/issues/91605#issuecomment-1264995277) GitHub issue. You can also contribute! We welcome bug reports and fixes that make Material 3 even better for Flutter developers like you.

Our most recent update brought the [`SnackBar`](https://api.flutter.dev/flutter/material/SnackBar-class.html), [`TabBar`](https://api.flutter.dev/flutter/material/TabBar-class.html) and [`Slider`](https://api.flutter.dev/flutter/material/Slider-class.html) widgets up to Material 3 spec. So far, we’ve migrated 27/30 components, and added a range of new features to support dynamic color, text themes, Android 12 functionality, and more.

If you’d like to get more involved with the Flutter community, head over to [flutter.dev/community](https://flutter.dev/community) and find us on your favorite social platform. See you there!
