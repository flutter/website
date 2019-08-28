---
title: Flutter Documentation
short-title: Docs
description: The landing page for Flutter documentation.
---

{% for card in site.data.docs_cards -%}
  {% capture index0Modulo3 %}{{ forloop.index0 | modulo:3 }}{% endcapture %}
  {% capture indexModulo3 %}{{ forloop.index | modulo:3 }}{% endcapture %}
  {% if index0Modulo3 == '0' %}
  <div class="card-deck mb-4">
  {% endif %}
    <a class="card" href="{{card.url}}">
      <div class="card-body">
        <header class="card-title">{{card.name}}</header>
        <p class="card-text">{{card.description}}</p>
      </div>
    </a>
  {% if indexModulo3 == '0' %}
  </div>
  {% endif %}
{% endfor -%}

## What's new on the site

To stay on top of Flutter announcements, including breaking changes, join the
[flutter-announce](https://groups.google.com/forum/#!forum/flutter-announce)
Google group.

**July 9, 2019**

Flutter 1.7 is live!

For more information, see [Announcing Flutter
1.7]({{site.flutter-medium}}/announcing-flutter-1-7-9cab4f34eacf)
on the [Flutter Medium Publication]({{site.flutter-medium}}),
and the [1.7.8 release
notes]({{site.github}}/flutter/flutter/wiki/Release-Notes-Flutter-1.7.8)
on the [Flutter wiki]({{site.github}}//flutter/flutter/wiki).

New and updated docs on the site include:

* The [Preparing an Android app for release](/docs/deployment/android)
  page is updated to discuss how to build an Android release
  using an app bundle, as well as how to create separate APK
  files for both 32-bit and 64-bit devices.
* The [DevTools](/docs/development/tools/devtools) docs are migrated
  to flutter.dev. If you haven't tried this browser-based suite
  of debugging, performance, memory, and inspection tools that
  work with both Flutter and Dart apps and can be launched from
  Android Studio/IntelliJ _and_ VS Code, please check it out!
* The [Simple app state
  management](/docs/development/data-and-backend/state-mgmt/simple)
  page is updated. The example code in the page now uses the 3.0
  release of the Provider package.
* A new animation recipe, [Animate a page route
  transition](/docs/cookbook/animation/page-route-animation)
  has been added to the [Cookbook](/docs/cookbook).
* The [Debugging](/docs/testing/debugging), 
  [Flutter's build modes](/docs/testing/build-modes),
  [Performance best practices](/docs/testing/best-practices), and
  [Performance profiling](/docs/testing/ui-performance)
  pages are updated to reflect DevTools. A
  [Debugging apps programmatically](/docs/testing/code-debugging)
  page has also been added.

The Flutter 1.7 release includes the new
[RangeSlider]({{site.api}}/flutter/material/RangeSlider-class.html)
component, which allows the user to select both the upper and lower
endpoints in a range of values. For information about this
component and how to customize it, see [Material RangeSlider in
Flutter]({{site.flutter-medium}}/material-range-slider-in-flutter-a285c6e3447d).

Happy Fluttering!

[What's new archive](/docs/whats-new-archive)

## New to Flutter?

Once you've gone through [Get Started](/docs/get-started/install),
including [Write Your First Flutter App,](/docs/get-started/codelab)
here are some next steps.

### Docs

Coming from another platform? Check out: 
[Android](/docs/get-started/flutter-for/android-devs),
[iOS](/docs/get-started/flutter-for/ios-devs),
[Web](/docs/get-started/flutter-for/web-devs),
[React Native](/docs/get-started/flutter-for/react-native-devs),
[Xamarin.Forms](/docs/get-started/flutter-for/xamarin-forms-devs)

[Building layouts](/docs/development/ui/layout)
: Learn how to create layouts in Flutter, where everything is a widget.

[Adding interactivity to your Flutter app](/docs/development/ui/interactive)
: Learn how to add a stateful widget to your app.

[A tour of the Flutter widget framework](/docs/development/ui/widgets-intro)
: Learn more about Flutter's react-style framework.

[FAQ](/docs/resources/faq)
: Get the answers to frequently asked questions.

### Videos

We also have some helpful videos on our [Flutter Youtube
channel]({{site.social.youtube}})!  In particular, check
out the Flutter in Focus series, and learn about other
series on our [videos](/docs/resources/videos) page.

<iframe style="max-width: 100%" width="560" height="315" src="https://www.youtube.com/embed/wgTBLj7rMPM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
Flutter in Focus: Learn Flutter features in 10 minutes or less.<br>
[Flutter in Focus playlist](https://www.youtube.com/playlist?list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2)

In Flutter, "everything is a widget"! If you want to better understand the
two kinds of widgets, Stateless and Stateful, see the following videos,
part of the [Flutter in
Focus](https://www.youtube.com/playlist?list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2) series.

<iframe style="max-width: 100%" width="560" height="315" src="https://www.youtube.com/embed/wE7khGHVkYY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe> <iframe width="560" height="315" src="https://www.youtube.com/embed/AqCMFXEmf3w" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Want to skill up?

If you learn best by watching engineers write code, make mistakes, and fix them,
check out the [Boring Flutter
Show](https://www.youtube.com/watch?v=vqPG1tU6-c0&list=PLjxrf2q8roU28W3pXbISJbVA5REsA41Sx&index=3&t=9s)
video series:

<iframe style="max-width: 100%" width="560" height="315" src="https://www.youtube.com/embed/vqPG1tU6-c0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
[Boring Flutter Show playlist](https://www.youtube.com/watch?v=vqPG1tU6-c0&list=PLjxrf2q8roU28W3pXbISJbVA5REsA41Sx&index=3&t=9s)

You might also find these docs useful:

* [Using packages](/docs/development/packages-and-plugins/using-packages)
* [Adding assets and images](/docs/development/ui/assets-and-images)
* [Navigation and routing](/docs/development/ui/navigation)
* [State management](/docs/development/data-and-backend/state-mgmt/intro)
* [Animations](/docs/development/ui/animations)

