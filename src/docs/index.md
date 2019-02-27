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

## What's new on the site

**February 26, 2019**

Flutter released [version
1.2](https://developers.googleblog.com/2019/02/launching-flutter-12-at-mobile-world.html)
today at Mobile World Congress (MWC) in Barcelona!

In addition, here are some new docs we've released:

* We've updated our [state management
  advice](/docs/development/data-and-backend/state-mgmt/intro).
  New pages include an
  [introduction](/docs/development/data-and-backend/state-mgmt/intro),
  [thinking declaratively](/docs/development/data-and-backend/state-mgmt/declarative), 
  [ephemeral vs app state](/docs/development/data-and-backend/state-mgmt/ephemeral-vs-app),
  [simple app state management](/docs/development/data-and-backend/state-mgmt/simple),
  and [different state management
  options](/docs/development/data-and-backend/state-mgmt/options).
  Documenting state management is a tricky thing, as there is no one-size-fits-all
  approach. We'd love your feedback on these new docs!
* A new page on [Performance best practices](/docs/testing/best-practices).
* Also at MWC, we announced a preview version of the new Dart DevTools
  for profiling and debugging Dart and Flutter apps. You can find the docs on the
  [DevTools wiki](https://flutter.github.io/devtools/).
  In particular, check out the DevTool's [Flutter widget
  inspector](https://flutter.github.io/devtools/inspector) for debugging
  your UI, or the [timeline
  view](https://flutter.github.io/devtools/timeline) for profiling your Flutter
  application. Try them out and let us know what you think!
* An update to the [Performance profiling](/docs/testing/ui-performance)
  page that incorporates the new Dart DevTools UI.
* Updates to the [Android
  Studio/IntelliJ](/docs/development/tools/android-studio)
  and [VS Code](/docs/development/tools/vs-code) pages incorporating info from
  the new Dart DevTools UI.

If you have questions or comments about any of these docs, [file an
issue]({{site.repo.this}}/issues).

[What's new archive](/docs/whats-new-archive)

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

[Sample apps on GitHub]({{site.github}}/flutter/samples/blob/master/INDEX.md)
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

[Effective Dart]({{site.dart-site}}/guides/language/effective-dart)
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
