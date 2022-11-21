---
title: Creating flavors for Flutter
short-title: Flavors
description: How to create build flavors specific to different release types or development environments.
---
## What are flavors
Have you ever wondered how to set up different environments in your Flutter app?
Flavors (known as build configurations in iOS), create separate environments 
for your app using the same code base. 
You can use flavors to supply your app with different development versions.

Let’s say, you want to make a free and paid version of your Flutter app. 
You can use flavors to set up both app versions 
without writing two separate apps. 
The free version of the app has basic functionality. 
In contrast, the paid version has basic app functionality, extra features, 
and different styles for paid users. 

Another example where you could use flavors is for feature development. 
If you’ve built a new feature and want to try it out, 
you could set up a flavor and deploy that feature to a different API endpoint 
than production. Your production code remains unaffected 
until you are ready to deploy your new feature to production.

Flavors function by letting you define compile time configurations 
and set parameters that are read at runtime depending on your app needs.
Setting up flavors is straightforward in Android, but requires more in-depth
set up in iOS. 

This document guides you through setting up Flutter flavors for iOS and Android. 

## Environment set up
Prerequisites:
* Xcode installed
* An existing project 

To set up flavors in iOS, you’ll need to create build configurations in Xcode. 

## Creating Flavors in iOS
1. Open your project in Xcode.

2. Click the Runner > New Scheme from the menu to add a new Scheme. 
A scheme is used to describe how Xcode runs different actions. 
For the purposes of this guide the example flavor and scheme is 
named `development`. 
The build configurations in the development scheme have the -development suffix. 

3. Duplicate the build configurations to differentiate between the default configurations that are already available and the new configurations for the development scheme. Under Info tab at the end of the Configurations dropdown list, click the plus button and duplicate each configuration name(Debug, Release, and Profile). Duplicate the listed production configurations, once for each environment.

To match the development flavor,  add -development at the end of each new configuration name. 

Change the development Scheme to match the development build configurations you’ve created to assign the correct build configurations to the development scheme. 
In the Runner project, click Manage Schemes… a pop up window opens. 
Double click the development scheme. In the next step (as shown in the screenshot), you’ll modify each scheme to match its dev build configuration:

{% comment %}
Eventually, we should actually include instructions,
but by platform and we can then move the platform-specific
instructions to /development/platform-integration/macos
or ios or android, etc.
sz: Yes, I've already asked Shamira (who will be working
on the new docs), to plan for multiple pages.
{% endcomment %}

Do you need to set up product flavors for different development
environments or release types?
The community has written some articles and packages you might find useful.
These articles address flavors for both iOS and Android.

* [Creating flavors of a Flutter app][]
* [Flavoring Flutter][]
* [Flutter Ready to Go][]
* [Build flavors in Flutter (Android and iOS)
  with different Firebase projects per flavor][]
* [Flutter 1.17 — no more Flavors, no more iOS Schemas.
  Command argument that changes everything][]
* [Multi-environment Flutter Projects with Flavors][]
  (including support for web, Firebase and FlutterFire CLI)

The following packages are listed alphabetically:

* [`flutter_flavor`][]
* [`flutter_flavorizr`][]

[Creating flavors of a Flutter app]: https://cogitas.net/creating-flavors-of-a-flutter-app/
[Flavoring Flutter]: {{site.medium}}/@salvatoregiordanoo/flavoring-flutter-392aaa875f36
[Flutter Ready to Go]: {{site.medium}}/flutter-community/flutter-ready-to-go-e59873f9d7de
[Build flavors in Flutter (Android and iOS) with different Firebase projects per flavor]: {{site.medium}}/@animeshjain/build-flavors-in-flutter-android-and-ios-with-different-firebase-projects-per-flavor-27c5c5dac10b
[Flutter 1.17 — no more Flavors, no more iOS Schemas. Command argument that changes everything]: {{site.medium}}/@tatsu.ukraine/flutter-1-17-no-more-flavors-no-more-ios-schemas-command-argument-that-solves-everything-8b145ed4285d
[Multi-environment Flutter Projects with Flavors]: https://sebastien-arbogast.com/2022/05/02/multi-environment-flutter-projects-with-flavors/
[`flutter_flavor`]: {{site.pub}}/packages/flutter_flavor
[`flutter_flavorizr`]: {{site.pub}}/packages/flutter_flavorizr
