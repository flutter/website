---
layout: page
title: Flutter for Xamarin.Forms Developers
permalink: /flutter-for-xamarin-forms/
---
This document is meant for Xamarin.Forms developers looking to apply their
existing knowledge to build mobile apps with Flutter. If you understand
the fundamentals of the Xamarin.Forms framework then you can use this document as a
jump start to Flutter development.

Your Android (and iOS) knowledge and skill set are highly valuable when building with
Flutter, because Flutter relies on the mobile operating system for numerous
capabilities and configurations. Flutter is a new way to build UIs for mobile,
and is similar to how you create a single UI in Xamarin.Forms, that is used on multiple
platforms. 

This document can be used as a cookbook by jumping around and finding questions
that are most relevant to your needs.

* TOC Placeholder
{:toc}

# Views

## What is the equivalent of a `UIView` in Flutter?

TODO

## How do I update `Widget`s?

TODO

## How do I lay out my widgets? Where is my Storyboard?

TODO

## How do I animate a widget?

TODO

## How do I use a `Canvas` to draw/paint?

TODO

## How do I build custom widgets?

TODO

## How do I draw to the screen? (NOT REALLY RELEVANT TO XF)

TODO

## Where is the widget's opacity?

TODO

## How do I build custom widgets?

TODO

# Navigation

## How do I navigate between pages?

TODO

## How do I navigate to another app?

TODO

# Async UI

## What is the equivalent of `Device.BeginOnMainThread()` in Flutter?


TODO

## How do you move work to a background thread?

TODO

## How do I make network requests?

TODO

## What is the equivalent of HttpClient on Flutter?

TODO

## How do I show the progress for a long-running task?

TODO

# Project structure & resources

## Where do I store my resolution-dependent image files?

TODO: iOS and Android specific references here

## Where do I store strings? How do I handle localization?

TODO

## What is the equivalent of Nuget? How do I add dependencies?

TODO

# Activities and fragments (XF Equivalent)

## How do I listen to Android activity lifecycle events? (XF Equiv)

TODO

# Layouts

## What is the equivalent of a LinearLayout?

## What is the equivalent of a RelativeLayout?

## What is the equivalent of a ScrollView?

## How do I handle landscape transitions in Flutter?

# Gesture detection and touch event handling

## How do I add GestureRecognizers to a widget in Flutter?

# Listviews & adapters

## What is the alternative to a ListView in Flutter?

## How do I know which list item is clicked on?

## How do I update ListView's dynamically?

# Working with text

## How do I set custom fonts on my Text widgets?

## How do I style my Text widgets?

# Form input

## What is the equivalent of a "Placeholder" on an Input?

## How do I show validation errors?

# Flutter plugins

## How do I access the GPS sensor?

Use the [`location`](https://pub.dartlang.org/packages/location) community plugin.

## How do I access the camera?

The [`image_picker`](https://pub.dartlang.org/packages/image_picker) plugin is popular
for accessing the camera.

## How do I log in with Facebook?

To Log in with Facebook, use the
[`flutter_facebook_login`](https://pub.dartlang.org/packages/flutter_facebook_login) community plugin.

## How do I use Firebase features?

Most Firebase functions are covered by
[first party plugins](https://pub.dartlang.org/flutter/packages?q=firebase).
These plugins are first-party integrations, maintained by the Flutter team:

 * [`firebase_admob`](https://pub.dartlang.org/packages/firebase_admob) for Firebase AdMob
 * [`firebase_analytics`](https://pub.dartlang.org/packages/firebase_analytics) for Firebase Analytics
 * [`firebase_auth`](https://pub.dartlang.org/packages/firebase_auth) for Firebase Auth
 * [`firebase_database`](https://pub.dartlang.org/packages/firebase_database) for Firebase RTDB
 * [`firebase_storage`](https://pub.dartlang.org/packages/firebase_storage) for Firebase Cloud Storage
 * [`firebase_messaging`](https://pub.dartlang.org/packages/firebase_messaging) for Firebase Messaging (FCM)
 * [`flutter_firebase_ui`](https://pub.dartlang.org/packages/flutter_firebase_ui) for quick Firebase Auth integrations (Facebook, Google, Twitter and email)
 * [`cloud_firestore`](https://pub.dartlang.org/packages/cloud_firestore) for Firebase Cloud Firestore

You can also find some third-party Firebase plugins on Pub that cover areas
not directly covered by the first-party plugins.

## How do I build my own custom native integrations?

If there is platform-specific functionality that Flutter or its community
Plugins are missing, you can build your own following the
[developing packages and plugins](/developing-packages/) page.

Flutter's plugin architecture, in a nutshell, is much like using an Event bus in
Android: you fire off a message and let the receiver process and emit a result
back to you. In this case, the receiver is code running on the native side
on Android or iOS.

## How do I use the NDK in my Flutter application?

TODO

# Themes (Styles)

## How do I theme my app?


# Databases and local storage

## How do I access Shared Preferences?


## How do I access SQLite in Flutter?

In Android, you use SQLite to store structured data that you can query
using SQL.

In Flutter, access this functionality using the
[SQFlite](https://pub.dartlang.org/packages/sqflite) plugin.

# Notifications

## How do I set up push notifications?