---
title: A responsive vs adaptive app
description: >
  It's important to create an app, >
  whether for mobile or web, >
  that responds to size and orientation changes
  and maximizes the use of each platform.
short-title: Adaptive vs responsive
---

One of Flutter's primary goals is to create a framework
that allows you to develop apps from a single codebase
that look and feel great on any platform.

This means that your app might appear on screens of
many different sizes, from a watch, to a foldable
phone with two screens, to a high definition monitor.
And your input device might be a physical or
virtual keyboard, a mouse, a touchscreen, or
any number of other devices.

Two terms that describe these design concepts
are _adaptive_ and _responsive_. Ideally,
you'd want your app to be _both_ but what,
exactly, does this mean?

## What is responsive vs adaptive?

An easy way to think about it is that responsive design
is about fitting the UI _into_ the space and
adaptive design is about the UI being _usable_ in
the space.

So, a responsive app adjusts the placement of design
elements to _fit_ the available space. And an
adaptive app selects the appropriate layout and
input devices to be usable _in_ the available space.
For example, should the UI use bottom navigation or
side-panel navigation?

For considerations and best practices for creating
a responsive app, check out [Create a responsive app][].

<<<<<<< HEAD
=======
## Creating a responsive Flutter app

### Other resources

For more information, here are a few resources,
including contributions from the Flutter community:

* [Developing for Multiple Screen Sizes and Orientations in
  Flutter][] by Deven Joshi
* [Build Responsive UIs in Flutter][] by Raouf Rahiche
* [Making Cross-platform Flutter Landing Page Responsive][]
  by Priyanka Tyagi
* [How to make flutter app responsive according to different screen
  size?][], a question on StackOverflow

[`AspectRatio`]: {{site.api}}/flutter/widgets/AspectRatio-class.html
[`BoxConstraints`]: {{site.api}}/flutter/rendering/BoxConstraints-class.html
[Build Responsive UIs in Flutter]: {{site.medium}}/flutter-community/build-responsive-uis-in-flutter-fd450bd59158
[`builder`]: {{site.api}}/flutter/widgets/LayoutBuilder/builder.html
[`CustomMultiChildLayout`]: {{site.api}}/flutter/widgets/CustomMultiChildLayout-class.html
[`CustomSingleChildLayout`]: {{site.api}}/flutter/widgets/CustomSingleChildLayout-class.html
[Developing for Multiple Screen Sizes and Orientations in Flutter]: {{site.medium}}/flutter-community/developing-for-multiple-screen-sizes-and-orientations-in-flutter-fragments-in-flutter-a4c51b849434
[`FittedBox`]: {{site.api}}/flutter/widgets/FittedBox-class.html

[How to make flutter app responsive according to different screen size?]: {{site.so}}/questions/49704497/how-to-make-flutter-app-responsive-according-to-different-screen-size
[`LayoutBuilder`]: {{site.api}}/flutter/widgets/LayoutBuilder-class.html
[Making Cross-platform Flutter Landing Page Responsive]: {{site.medium}}/flutter-community/making-cross-platform-flutter-landing-page-responsive-7fffe0655970
[`MediaQuery`]: {{site.api}}/flutter/widgets/MediaQuery-class.html
[`MediaQuery.of()`]: {{site.api}}/flutter/widgets/MediaQuery/of.html

## Creating an adaptive Flutter app

Learn more about creating an adaptive Flutter app with
[Building adaptive apps][], written by the gskinner team.

You might also check out the following episodes
of The Boring Show:

<iframe style="max-width: 100%" width="560" height="315" src="{{site.yt.embed}}/n6Awpg1MO6M" title="Learn about adaptive layouts on the Boring Show" {{site.yt.set}}></iframe>
[Adaptive layouts][]

<iframe style="max-width: 100%" width="560" height="315" src="{{site.yt.embed}}/eikOZzfc0l4" title="Continue to learn about adaptive layouts on the Boring Show" {{site.yt.set}}></iframe>
[Adaptive layouts, part 2][]

For an excellent example of an adaptive app,
check out Flutter Folio, a scrapbooking app created
in collaboration with gskinner and the Flutter team:

<iframe style="max-width: 100%" width="560" height="315" src="{{site.yt.embed}}/yytBENOnF0w" title="Watch a demonstration of the Flutter Folio app" {{site.yt.set}}></iframe>

The [Folio source code][] is also available on GitHub.
Learn more on the [gskinner blog][].

### Other resources

You can learn more about creating platform adaptive apps
in the following resources:

* [Platform-specific behaviors and adaptations][], a page on this site.
* [Extreme UI Adaptability in Flutter][], the story of how Google Earth is
  using Flutter to take adaptability to the next level.
* [Designing truly adaptive user interfaces][] a blog post and video by
  Aloïs Deniel, presented at the Flutter Vikings 2020 conference.

[Adaptive layouts]: {{site.yt.watch}}?v=n6Awpg1MO6M&t=694s
[Adaptive layouts, part 2]: {{site.yt.watch}}?v=eikOZzfc0l4&t=11s
[Adaptive vs Responsive]: {{site.youtube-site}}/HD5gYnspYzk?si=5ItDD7UjXvGCRM0K
[Building adaptive apps]: {{site.url}}/ui/layout/responsive/building-adaptive-apps

[Designing truly adaptive user interfaces]: https://www.aloisdeniel.com/blog/designing-truly-adaptative-user-interfaces
[Folio source code]: {{site.github}}/gskinnerTeam/flutter-folio
[gskinner blog]: https://blog.gskinner.com/
[Platform-specific behaviors and adaptations]: {{site.url}}/platform-integration/platform-adaptations
[Extreme UI Adaptability in Flutter]: {{site.flutter-medium}}/extreme-ui-adaptability-in-flutter-how-google-earth-supports-every-use-case-on-earth-6db4661e7a17
>>>>>>> main
