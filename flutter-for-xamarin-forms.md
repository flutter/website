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

## What is the equivalent of a `Page` or `Element` in Flutter?

A `ContentPage`, `TabbedPage`, `MasterDetailPage` are all types of pages you could 
use in a Xamarin.Forms application. These pages would then hold `Element`s to display
the various controls.

In Xamarin.Forms an `Entry` or `Button` are examples of an `Element`. In Flutter, there 
is no difference between a `Page` or `Element`, everything is a `Widget`. The root of
a page in Flutter is a `Widget`. A `Widget` can contain more `Widget`s to build out your
page.

Flutter includes the [Material Components](https://material.io/develop/flutter/)
library. These are widgets that implement the
[Material Design guidelines](https://material.io/design/). Material Design is a
flexible design system [optimized for all
platforms](https://material.io/design/platform-guidance/cross-platform-adaptation.html#cross-platform-guidelines),
including iOS.

But Flutter is flexible and expressive enough to implement any design language.
For example, on iOS, you can use the [Cupertino widgets](https://flutter.io/widgets/cupertino/)
to produce an interface that looks like
[Apple's iOS design language](https://developer.apple.com/design/resources/).

## How do I update `Widget`s?

In Xamarin.Forms, each `Page` or `Element` is a stateful class, that has properties and
methods. You update your `Element` by updating a property, and this is propagated down
to the native control. 

In Flutter, `Widget`s are immutable and you can not directly update them by changing a
property, instead you have to work with the widget's state.

This is where the concept of Stateful vs Stateless widgets comes from. A
`StatelessWidget` is just what it sounds like&mdash;a widget with no state
information.

`StatelessWidgets` are useful when the part of the user interface
you are describing does not depend on anything other than the configuration
information in the object.

For example, in Xamarin.Forms, this is similar to placing an `Image`
with your logo. The logo is not going to change during runtime, so
use a `StatelessWidget` in Flutter.

If you want to dynamically change the UI based on data received
after making an HTTP call or user interaction then you have to work
with `StatefulWidget` and tell the Flutter framework that the widget’s `State`
has been updated so it can update that widget.

The important thing to note here is at the core both stateless and stateful
widgets behave the same. They rebuild every frame, the difference is the
`StatefulWidget` has a `State` object that stores state data across frames
and restores it.

If you are in doubt, then always remember this rule: if a widget changes
(because of user interactions, for example) it’s stateful.
However, if a widget reacts to change, the containing parent widget can
still be stateless if it doesn't itself react to change.

The following example shows how to use a `StatelessWidget`. A common
`StatelessWidget` is the `Text` widget. If you look at the implementation of
the `Text` widget you'll find it subclasses `StatelessWidget`.

<!-- skip -->
{% prettify dart %}
new Text(
  'I like Flutter!',
  style: new TextStyle(fontWeight: FontWeight.bold),
);
{% endprettify %}

As you can see, the `Text` Widget has no state information associated with it,
it renders what is passed in its constructors and nothing more.

But, what if you want to make "I Like Flutter" change dynamically, for
example when clicking a `FloatingActionButton`?

To achieve this, wrap the `Text` widget in a `StatefulWidget` and
update it when the user clicks the button.

For example:

<!-- skip -->
{% prettify dart %}
import 'package:flutter/material.dart';

void main() {
  runApp(new SampleApp());
}

class SampleApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Sample App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  SampleAppPage({Key key}) : super(key: key);

  @override
  _SampleAppPageState createState() => new _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  // Default placeholder text
  String textToShow = "I Like Flutter";

  void _updateText() {
    setState(() {
      // update the text
      textToShow = "Flutter is Awesome!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Sample App"),
      ),
      body: new Center(child: new Text(textToShow)),
      floatingActionButton: new FloatingActionButton(
        onPressed: _updateText,
        tooltip: 'Update Text',
        child: new Icon(Icons.update),
      ),
    );
  }
}
{% endprettify %}

## How do I lay out my widgets?

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