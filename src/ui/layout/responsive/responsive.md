---
title: Create a responsive app
description: >
  Learn how to create a responsive app >
  that responds to changes in the screen size.
short-title: Responsive
---

{% include docs/yt_shims.liquid %}

Flutter allows you to create apps that self-adapt
to the device's screen size and orientation.

## Two approaches

There are at least two ways you can create a
UI that responds to a change in screen size.

For either approach, you need to determine
the sizes (called _breakpoints_) where you
want your UI change its display.
The following examples use a pixel width
1201 or more for an ultra wide display,
601 to 1200 pixels for a wide display,
301 to 600 pixels for a narrow display,
and a width of 300 pixels or less for an
ultra narrow display.

The calling function then decides how to handle
the UI. Using the screen size examples above,
if the screen is 1201 pixels or more,
return a [`Scaffold`][] object with a row
that has a list on the left (a side nav).
If the screen is less than 300 pixels wide,
return a [`Scaffold`][] object with a drawer
containing that list (assume bottom navigation).

You can also adjust your display based on the
device's height, the aspect ratio,
or some other property.

### MediaQuery

You can determine the current screen size by using the
[`MediaQuery.of()`][] method in your widget's build function.
Keep in mind that this method returns the current size
and orientation of the app's entire screen and
not just a single widget..

The following example code uses `MediaQuery.of`:

```dart
final screenWidth = MediaQuery.of(context).size.width;

if (screenWidth > 1200) {
  return UltraWideLayout();
} else if (screenwidth > 600) {
  return WideLayout();
} else if (screenwidth > 300) {
  return NarrowLayout();
} else {
  return UltraNarrowLayout();
}
```

If you use this approach, your `build` function
automatically runs when the user is done changing
the screen's size. However, this isn't a
particularly reactive approach. What you
likely want to see is the UI changing in
real time as the user resizes the screen.

### LayoutBuilder

To accomplish a more reactive approach,
use the `LayoutBuilder` class.
From a `LayoutBuilder`'s [`builder`][] property,
extract the [`BoxConstraints`][] object.
Examine the constraint's properties to decide
what to display.

When the constraints change (for example,
the user rotates the phone or puts your app
app into a tile UI on Android), Flutter calls
the `LayoutBuilder`'s `build` function.

The following example code shows how you might use a
`LayoutBuilder`:

```dart
LayoutBuilder()
  ...
  child: LayoutBuilder(
    bulider: (context, constraints) {
      if (constraints.maxWidth > 1200) {
        return UltraWideLayout();
      } else if (constraints.maxWidth > 600) {
        return WideLayout();
      } else {
        return NarrowLayout();
    }
    ...
```

The `LayoutBuilder` re-runs its `build` method
whenever the constraints passed to it from
its parent changes, giving your app a chance
to update the layout in real time.

## Respond to large screen devices

You can optimize your app to improve its
look and feel on large screens. 
Flutter defines [large screens][] as tablets,
foldables, and ChromeOS devices running Android.
Demand for large screens continues to increase. 
As of December 2023, more than
[270 million active large screen][] and 
foldable devices run on Android.

---

### Why this matters

When your app supports large screens,
it also receives the following benefits:

* Improves your app's metrics to show increased
  user engagement when optimized to fill the screen.
* Increases your app's visibility in the Play Store.
  Recent [Play Store updates][] show ratings by device type
  and indicates when an app lacks large screen support. 

---
Learn more in the following 5-minute video:

<iframe width="560" height="315" src="{{yt-embed}}/HD5gYnspYzk?si=dsA37QUjHBb2Zh_-" title="Learn the difference between adaptive and responsive Flutter apps" {{yt-set}}></iframe>
[Adaptive vs Responsive][]


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

[`FractionallySizedBox`]: {{site.api}}/flutter/widgets/FractionallySizedBox-class.html
[How to make flutter app responsive according to different screen size?]: {{site.so}}/questions/49704497/how-to-make-flutter-app-responsive-according-to-different-screen-size
[`LayoutBuilder`]: {{site.api}}/flutter/widgets/LayoutBuilder-class.html
[Making Cross-platform Flutter Landing Page Responsive]: {{site.medium}}/flutter-community/making-cross-platform-flutter-landing-page-responsive-7fffe0655970
[`maxWidth`]: {{site.api}}/flutter/rendering/BoxConstraints/maxWidth.html
[`MediaQuery`]: {{site.api}}/flutter/widgets/MediaQuery-class.html
[`MediaQuery.of()`]: {{site.api}}/flutter/widgets/MediaQuery/of.html
[`MediaQueryData`]: {{site.api}}/flutter/widgets/MediaQueryData-class.html
[`OrientationBuilder`]: {{site.api}}/flutter/widgets/OrientationBuilder-class.html
[`Scaffold`]: {{site.api}}/flutter/material/Scaffold-class.html

## Creating an adaptive Flutter app

Learn more about creating an adaptive Flutter app with
[Building adaptive apps][], written by the gskinner team.

You might also check out the following episodes
of The Boring Show:

<iframe style="max-width: 100%" width="560" height="315" src="{{yt-embed}}/n6Awpg1MO6M" title="Learn about adaptative layouts on the Boring Show" {{yt-set}}></iframe>
[Adaptive layouts][]

<iframe style="max-width: 100%" width="560" height="315" src="{{yt-embed}}/eikOZzfc0l4" title="Continue to learn about adaptative layouts on the Boring Show" {{yt-set}}></iframe>
[Adaptive layouts, part 2][]

For an excellent example of an adaptive app,
check out Flutter Folio, a scrapbooking app created
in collaboration with gskinner and the Flutter team:

<iframe style="max-width: 100%" width="560" height="315" src="{{yt-embed}}/yytBENOnF0w" title="Watch a demonstration of the Flutter Folio app" {{yt-set}}></iframe>

The [Folio source code][] is also available on GitHub.
Learn more on the [gskinner blog][].

### Other resources

You can learn more about creating platform adaptive apps
in the following resources:

* [Platform-specific behaviors and adaptations][], a page on this site.
* [Designing truly adaptive user interfaces][] a blog post and video by
  Aloïs Deniel, presented at the Flutter Vikings 2020 conference.
* The [Flutter gallery app][] ([repo][]) has been written as an
  adaptive app.

[Adaptive layouts]: {{yt-watch}}?v=n6Awpg1MO6M&t=694s
[Adaptive layouts, part 2]: {{yt-watch}}?v=eikOZzfc0l4&t=11s
[Adaptive vs Responsive]: {{site.youtube-site}}/HD5gYnspYzk?si=5ItDD7UjXvGCRM0K
[Building adaptive apps]: {{site.url}}/ui/layout/responsive/building-adaptive-apps

[Designing truly adaptive user interfaces]: https://www.aloisdeniel.com/blog/designing-truly-adaptative-user-interfaces
[Flutter gallery app]: {{site.gallery}}
[Folio source code]: {{site.github}}/gskinnerTeam/flutter-folio
[gskinner blog]: https://blog.gskinner.com/
[Platform-specific behaviors and adaptations]: {{site.url}}/platform-integration/platform-adaptations
[repo]: {{site.repo.gallery}}
