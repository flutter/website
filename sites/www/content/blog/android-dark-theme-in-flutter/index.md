---
title: "Android Dark Theme in Flutter"
description: "A week ago at Google I/O 2019, the Android team announced support in Android Q for Dark Theme, a system-wide dark UI mode that is toggled…"
publishDate: 2019-05-15
author: matthew-carroll
image: images/1wogDV86zrS8BNYI-8Th-TA.jpeg
category: tutorial
layout: blog
---

<DashImage figure src="images/1wogDV86zrS8BNYI-8Th-TA.jpeg" />


## Android Dark Theme in Flutter

A week ago at Google I/O 2019, the Android team [announced support in Android Q for Dark Theme](https://developer.android.com/preview/features/darktheme), a system-wide dark UI mode that is toggled by the user. This then begs the question, when will Flutter add support for this awesome new Android feature? Well, you might be surprised to find out that [Flutter added support for dark theme back in February](https://github.com/flutter/flutter/pull/26605)! Here’s how to use it.

First, let’s start with a typical *MaterialApp* that establishes the theme for the rest of the UI. The following is how a typical app would define its theme before Dark Theme.

```dart
MaterialApp(
  theme: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.red,
  ),
);
```

<DashImage figure src="images/1jNi8NVhtMe7zo_3Nmtajqg.webp" />


In Flutter, we introduced a *darkTheme* property for *MaterialApp*, which allows you to specify a 2nd, independent theme to be used just for Android’s Dark Theme feature. Let’s introduce a theme with a setting of *Brightness.dark* for our *MaterialApp*’s *darkTheme*.

```dart
MaterialApp(
  theme: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.red,
  ),
  darkTheme: ThemeData(
    brightness: Brightness.dark,
  ),
);
```

<DashImage figure src="images/1b5P4ZxNmuw2q6-cZwj1Ukw.webp" />


Tada! Now when you toggle Dark Theme in your system drawer, your Flutter app will automatically switch from your regular *theme* to your *darkTheme*!

<DashImage figure src="images/1dGPFsh1dbSaoNOGQCpsmCw.webp" />


Thanks to Flutter’s use of code for UI, updating your app to support a great new feature takes little more than adding a new property to your widget tree. No XML styles to update, no CSS to update, just a normal Dart parameter.

In Flutter, there’s no reason to be afraid of the dark.