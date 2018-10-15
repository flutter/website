---
title: Flutter Documentation
description: The landing page for Flutter documentation.
---

<div class="card-deck">
{% for card in site.data.docs_cards %}
    <a class="card" href="{{card.url}}">
        <div class="card-body">
            <header class="card-title">{{card.name}}</header>
            <p class="card-text">{{card.description}}</p>
        </div>
    </a>
{% endfor %}
</div>

## What's new on flutter.io

**November 4, 2018**

Welcome to the revamped Flutter website!

We've spent the last few months redesigning the website and how its
information is organized. We hope you can more easily find the docs
you are looking for. Some of the changes to the website include:

* Revised [landing](/) page
* Revised [showcase](/showcase) page
* Revised navigation in the left side bar
* Table of contents on the right side of most pages

Some of the new content includes:

* Additional [cookbook](/cookbook) recipes
* Deep dive on Flutter internals,
  [Inside Flutter](/resources/inside-flutter)
* [Technical videos](/resources/videos) page
* How to connect [a native debugger _and_
  a Dart debugger to your app](/testing/oem-debuggers)
  (not yet complete)
* [Background Dart
  processes](development/packages-and-plugins/background-processes)
  placeholder that links to an in-depth post
  on Medium. (To be eventually replaced by actual documentation.)
* [Flutter's build modes](/testing/build-modes)

If you have questions or comments about the revamped site, [file an
issue]({{site.repo.this}}/issues).

{% comment %}
# TODO (Not for publication)

* Finish reviewing all pages and fixing issues
* Add a TOC back to pages containing tabs
* Run site through accessibility testing/review
* UX testing of new site
* Custom search
* Deprecated/watermark format option
* Add descriptions to each page
* Sitemap
* Redirects
* Finalize landing page
* Finalize showcase page
* A new 404 page
* Complete styling for widget catalog
* More new content (by Flutter Live)
{% endcomment %}


## New to Flutter?

Once you've gone through [Get Started](/get-started/install),
including [Write Your First Flutter App,](/get-started/codelab)
here are some next steps.

[Flutter for Android Developers](/get-started/flutter-for/android-devs)
: Review these tips if you have Android experience.

[Flutter for iOS Developers](/get-started/flutter-for/ios-devs)
: Review these tips if you have iOS experience.

[Flutter for Web Devs](/get-started/flutter-for/web-devs)
: Review these HTML -> Flutter analogs if you have web experience.

[Flutter for React Native Devs](/get-started/flutter-for/react-native-devs)
: Review these tips if you have React Native experience.

[Flutter for Xamarin.Forms Devs](/get-started/flutter-for/xamarin-forms-devs)
: Review these tips if you have Xamarin Forms experience.

[Building Layouts in Flutter](/development/ui/layout)
: Learn how to create layouts in Flutter, where everything is a widget.

[Adding Interactivity to Your Flutter App](/development/ui/interactive)
: Learn how to add a stateful widget to your app.

[A Tour of the Flutter Widget Framework](/development/ui/widgets-intro)
: Learn more about Flutter's react-style framework.

## Want to skill up?

Once you’ve mastered the basics, try these pages.

[Cookbook](/cookbook)
: A (growing) collection of recipes that address common Flutter use cases.

[Sample App Catalog](/catalog/samples)
: Simple apps that demonstrate how to implement features and widgets.

[Adding Assets and Images in Flutter](/development/ui/assets-and-images)
: How to add resources to a Flutter app.

[Animations in Flutter](/development/ui/animations)
: How to create standard, hero, or staggered animations, to
  name a few animations styles that Flutter supports.

[Routing and Navigation](/cookbook/navigation/navigation-basics)
: How to create and navigate to a new screen (called a _route_ in Flutter).

[Internationalization](/development/accessibility-and-localization/internationalization)
: Go global! How to internationalize your Flutter app.

[Effective Dart](https://www.dartlang.org/guides/language/effective-dart)
: Guides on how to write better Dart code.

## Specialized topics

Dive deeper into topics that interest you.

[Flutter Widget Inspector](/development/tools/inspector)
: How to use the widget inspector, a powerful tool that allows
  you to explore widget trees, disable the "DEBUG"
  banner, display the performance overlay, and much more.

[Custom Fonts](/cookbook/design/fonts)
: How to add new fonts to your app.

[Text Input](/cookbook/forms/text-input)
: How to set up basic text input.

[Debugging Flutter Apps](/testing/debugging)
: Tools and tips for debugging your app.

This is not a complete list. Please use the left navigation,
or the search field to find other topics.
