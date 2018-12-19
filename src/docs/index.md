---
title: Flutter Documentation
short-title: Docs
description: The landing page for Flutter documentation.
---

<div class="card-deck">
{% for card in site.data.docs_cards -%}
  <a class="card" href="{{card.url}}">
    <div class="card-body">
      <header class="card-title">{{card.name}}</header>
      <p class="card-text">{{card.description}}</p>
    </div>
  </a>
{% endfor -%}
</div>

## What's new on flutter.io

**November 5, 2018**

Welcome to the revamped Flutter website!

We've spent the last few months redesigning the website and how its
information is organized. We hope you can more easily find the docs
you are looking for. Some of the changes to the website include:

* Revised [front](/) page
* Revised [showcase](/showcase) page
* Revised [community](/community) page
* Revised navigation in the left side bar
* Table of contents on the right side of most pages

Some of the new content includes:

* Deep dive on Flutter internals,
  [Inside Flutter](/docs/resources/inside-flutter)
* [Technical videos](/docs/resources/videos)
* [State management](/docs/development/data-and-backend/state-mgmt)
* [Background Dart
  processes](/docs/development/packages-and-plugins/background-processes)
* [Flutter's build modes](/docs/testing/build-modes)
{% comment %}
* How to connect [a native debugger _and_
  a Dart debugger to your app](/docs/testing/oem-debuggers)
  (not yet complete)
{% endcomment %}

If you have questions or comments about the revamped site, [file an
issue]({{site.repo.this}}/issues).

## New to Flutter?

Once you've gone through [Get Started](/docs/get-started/install),
including [Write Your First Flutter App,](/docs/get-started/codelab)
here are some next steps.

[Flutter for Android developers](/docs/get-started/flutter-for/android-devs)
: Review these tips if you have Android experience.

[Flutter for iOS developers](/docs/get-started/flutter-for/ios-devs)
: Review these tips if you have iOS experience.

[Flutter for Web developers](/docs/get-started/flutter-for/web-devs)
: Review these HTML -> Flutter analogs if you have web experience.

[Flutter for React Native developers](/docs/get-started/flutter-for/react-native-devs)
: Review these tips if you have React Native experience.

[Flutter for Xamarin.Forms developers](/docs/get-started/flutter-for/xamarin-forms-devs)
: Review these tips if you have Xamarin Forms experience.

[Building layouts in Flutter](/docs/development/ui/layout)
: Learn how to create layouts in Flutter, where everything is a widget.

[Adding interactivity to your Flutter app](/docs/development/ui/interactive)
: Learn how to add a stateful widget to your app.

[A tour of the Flutter widget framework](/docs/development/ui/widgets-intro)
: Learn more about Flutter's react-style framework.

[FAQ](/docs/resources/faq)
: Get the answers to frequently asked questions.


## Want to skill up?

Once you’ve mastered the basics, try these pages.

[Cookbook](/docs/cookbook)
: A (growing) collection of recipes that address common Flutter use cases.

[Sample apps on GitHub](https://github.com/flutter/samples/blob/master/INDEX.md)
: A (growing) collection of sample apps that show Flutter best practices.

[Adding assets and images in Flutter](/docs/development/ui/assets-and-images)
: How to add resources to a Flutter app.

[Animations in Flutter](/docs/development/ui/animations)
: How to create standard, hero, or staggered animations, to
  name a few animations styles that Flutter supports.

[Navigation and routing](/docs/development/ui/navigation)
: How to create and navigate to a new screen (called a _route_ in Flutter).

[Internationalization](/docs/development/accessibility-and-localization/internationalization)
: Go global! How to internationalize your Flutter app.

[Effective Dart](https://www.dartlang.org/guides/language/effective-dart)
: Guides on how to write better Dart code.

## Specialized topics

Dive deeper into topics that interest you.

[Flutter Widget inspector](/docs/development/tools/inspector)
: How to use the widget inspector, a powerful tool that allows
  you to explore widget trees, disable the "DEBUG"
  banner, display the performance overlay, and much more.

[Custom fonts](/docs/cookbook/design/fonts)
: How to add new fonts to your app.

[Text input](/docs/cookbook/forms/text-input)
: How to set up basic text input.

[Debugging Flutter apps](/docs/testing/debugging)
: Tools and tips for debugging your app.

This is not a complete list. Please use the left navigation,
or the search field to find other topics.
