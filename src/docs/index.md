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

<a name="latest-release"></a>
## What's new on this site

To stay on top of Flutter announcements,
including breaking changes, join the
[flutter-announce][] Google group.

**Dec 11, 2019, Flutter Interact Edition**

Flutter 1.12 is live!

For more information, see
[Flutter: the first UI platform designed for ambient computing][],
[Announcing Flutter 1.12: What a year!][] and
the [Flutter 1.12.13][] release notes.

Docs added and updated since the last announcement include:

* To accompany an updated implementation of add-to-app,
  we have added documentation on how to
  [add Flutter to an existing app][] for both iOS and Android.
* If you own plugin code, we encourage you to update to the
  new plugin APIs for Android. For more information, see
  [Migrating your plugin to the new Android APIs][].
* Web support has moved to the beta channel. For more information,
  see [Web support for Flutter][] and
  [Web support for Flutter goes beta][] on the Medium publication.
  Also, the [building a web app with Flutter][] page is updated.
* A new [write your first Flutter app on the web][] codelab
  is added to the [Get started][] docs, and includes
  instructions on setting breakpoints in DevTools!
* A new [implicit animations][] codelab is available
  featuring DartPad.
  (To run it, you don't need to download any software!)
* Alpha support for MacOS (desktop) is now available in
  release 1.13 on the master and dev channels.
  For more information, see [Desktop support for Flutter][].
* The iOS section of the [app size][] page is updated to reflect
  the inclusion of bitcode.
* An alpha release of Flutter Layout Explorer, a new feature
  (and part of the Flutter inspector) that allows you to
  explore a visual representation of your layout is available.
  For more information, see the [Flutter Layout Explorer][] docs.

Other newness:

* A brand new version of [Flutter Gallery][]. There's a 
  link to the runnable sample in the side nav under
  **Samples & Tutorials**.

Happy Fluttering!

[add Flutter to an existing app]: /docs/development/add-to-app
[Announcing Flutter 1.12: What a year!]: https://medium.com/flutter/announcing-flutter-1-12-what-a-year-22c256ba525d
[app size]: /docs/perf/app-size#ios
[building a web app with Flutter]: /docs/get-started/web
[Desktop support for Flutter]: /desktop
[Flutter: the first UI platform designed for ambient computing]: https://developers.googleblog.com/2019/12/flutter-ui-ambient-computing.html?m=1
[Flutter 1.12.13]: /docs/development/tools/sdk/release-notes/release-notes-1.12.13
[Flutter Gallery]: https://flutter.github.io/samples/#/
[Flutter Layout Explorer]: https://flutter.dev/docs/development/tools/devtools/inspector#flutter-layout-explorer
[Flutter Medium publication]: https://medium.com/flutter
[Migrating your plugin to the new Android APIs]: /docs/development/packages-and-plugins/plugin-api-migration
[implicit animations]: /docs/codelabs/implicit-animations
[Web support for Flutter]: /web
[Web support for Flutter goes beta]: https://medium.com/flutter/web-support-for-flutter-goes-beta-35b64a1217c0
[write your first Flutter app on the web]: /docs/get-started/codelab-web
[Get started]: /docs/get-started/install

## New to Flutter?

Once you've gone through [Get Started][],
including [Write Your First Flutter App,][]
here are some next steps.

### Docs

Coming from another platform? Check out:
[Android][], [iOS][], [Web][], [React Native][],
[Xamarin.Forms][]

[Building layouts][]
: Learn how to create layouts in Flutter,
  where everything is a widget.

[Adding interactivity to your Flutter app][]
: Learn how to add a stateful widget to your app.

[A tour of the Flutter widget framework][]
: Learn more about Flutter's react-style framework.

[FAQ][]
: Get the answers to frequently asked questions.

### Videos

We also have some helpful videos on our
[Flutter Youtube channel][]! In particular, check
out the Flutter in Focus series,
and learn about other series on our [videos][] page.

First up, why use Flutter? What makes it different than other
app frameworks?

<iframe width="560" height="315" src="https://www.youtube.com/embed/l-YO9CmaSUM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe><br>
How is Flutter different for app development?

<iframe style="max-width: 100%" width="560" height="315" src="https://www.youtube.com/embed/wgTBLj7rMPM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
Flutter in Focus: Learn Flutter features in 10 minutes or less.<br>
[Flutter in Focus playlist][]

In Flutter, "everything is a widget"! If you want to better
understand the two kinds of widgets, Stateless and Stateful,
see the following videos,
part of the [Flutter in Focus][] series.

<iframe style="max-width: 100%" width="560" height="315" src="https://www.youtube.com/embed/wE7khGHVkYY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe> <iframe width="560" height="315" src="https://www.youtube.com/embed/AqCMFXEmf3w" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## Want to skill up?

If you learn best by watching engineers write code,
make mistakes, and fix them,
check out the [Boring Flutter Show][] video series:

<iframe style="max-width: 100%" width="560" height="315" src="https://www.youtube.com/embed/vqPG1tU6-c0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
[Boring Flutter Show playlist][]

You might also find these docs useful:

* [Using packages][]
* [Adding assets and images][]
* [Navigation and routing][]
* [State management][]
* [Animations][]


[A tour of the Flutter widget framework]: /docs/development/ui/widgets-intro
[Adding assets and images]: /docs/development/ui/assets-and-images
[Adding interactivity to your Flutter app]: /docs/development/ui/interactive
[Android]: /docs/get-started/flutter-for/android-devs
[Animations]: /docs/development/ui/animations
[Boring Flutter Show]: https://www.youtube.com/watch?v=vqPG1tU6-c0&list=PLjxrf2q8roU28W3pXbISJbVA5REsA41Sx&index=3&t=9s
[Boring Flutter Show playlist]: https://www.youtube.com/watch?v=vqPG1tU6-c0&list=PLjxrf2q8roU28W3pXbISJbVA5REsA41Sx&index=3&t=9s
[Building layouts]: /docs/development/ui/layout
[FAQ]: /docs/resources/faq
[flutter-announce]: https://groups.google.com/forum/#!forum/flutter-announce
[Flutter in Focus]: https://www.youtube.com/playlist?list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2
[Flutter in Focus playlist]: https://www.youtube.com/playlist?list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2
[Flutter Youtube channel]: {{site.social.youtube}}
[Get Started]: /docs/get-started/install
[iOS]: /docs/get-started/flutter-for/ios-devs
[Navigation and routing]: /docs/development/ui/navigation
[React Native]: /docs/get-started/flutter-for/react-native-devs
[State management]: /docs/development/data-and-backend/state-mgmt/intro
[Using packages]: /docs/development/packages-and-plugins/using-packages
[videos]: /docs/resources/videos
[Web]: /docs/get-started/flutter-for/web-devs
[What's new archive]: /docs/whats-new-archive
[Write Your First Flutter App,]: /docs/get-started/codelab
[Xamarin.Forms]: /docs/get-started/flutter-for/xamarin-forms-devs

