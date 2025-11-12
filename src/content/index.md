---
title: Flutter documentation
shortTitle: Docs
description: >-
  Get started with Flutter. Widgets, examples, updates, and API docs to
  help you write your first Flutter app.
---

<div class="card-grid">
{% for card in docsCards -%}
  <Card title="{{card.name}}" link="{{card.url}}" outlined="true">
    {{card.description}}
  </Card>
{% endfor -%}
</div>

**To see changes to the site since our last release,
see [What's new][].**

[What's new]: /release/whats-new

## New to Flutter?

Ready to build beautiful, multiplatform apps from a single codebase?
This video walks you through the fundamentals of Flutter and shows you how to get started.

Once you've [Set up Flutter][],
you should follow the
[Write your first Flutter app][] codelab
and read [Flutter fundamentals][].
These resources are opinionated documentation
that guide you through the most important
parts of building a Flutter app.

[Write your first Flutter app]: /get-started/codelab
[Flutter fundamentals]: /get-started/fundamentals

### Docs

Coming from another platform? Check out Flutter for:
[Android][], [SwiftUI][], [UIKit][], [React Native][], and
[Xamarin.Forms][] developers.

[Building layouts][]
: Learn how to create layouts in Flutter,
  where everything is a [widget](/resources/glossary#widget).

[Understanding constraints][]
: Once you understand that "Constraints
  flow down. Sizes flow up. Parents set
  positions", then you are well on your
  way to understanding Flutter's layout model.

[Adding interactivity to your Flutter app][interactivity]
: Learn how to add a stateful widget to your app.

[FAQ][]
: Get the answers to frequently asked questions.

[Android]: /get-started/flutter-for/android-devs
[Building layouts]: /ui/layout
[FAQ]: /resources/faq
[Set up Flutter]: /get-started
[interactivity]: /ui/interactivity
[SwiftUI]: /get-started/flutter-for/swiftui-devs
[UIKit]: /get-started/flutter-for/uikit-devs
[React Native]: /get-started/flutter-for/react-native-devs
[Understanding constraints]: /ui/layout/constraints
[Xamarin.Forms]: /get-started/flutter-for/xamarin-forms-devs

### Videos

<div class="video-wrapper">
  <span class="video-intro">Check out what's new in Flutter at Google I/O 2025!</span>
  <YouTubeEmbed id="v6Rzo5khNE8" title="What's new in Flutter" fullWidth></YouTubeEmbed>
</div>
<br>

For more Flutter at Google I/O 2025, check out
[How to build agentic apps with Flutter and Firebase AI Logic][]
and [How Flutter makes the most of your platforms][].

<div class="card-grid">
  <div class="card wrapped-card outlined-card">
    <div class="card-content">
      <YouTubeEmbed id="xo271p-Fl_4" title="How to build agentic apps with Flutter and Firebase AI Logic"></YouTubeEmbed>
    </div>
  </div>
  <div class="card wrapped-card outlined-card">
    <div class="card-content">
      <YouTubeEmbed id="flwULzNYRac" title="How Flutter makes the most of your platforms"></YouTubeEmbed>
    </div>
  </div>
</div>

[How to build agentic apps with Flutter and Firebase AI Logic]: {{site.yt.watch}}?v=xo271p-Fl_4
[How Flutter makes the most of your platforms]: {{site.yt.watch}}?v=flwULzNYRac

To learn about all of the Flutter video series, see our [videos][] page.

We release new videos almost every week!

<a class="filled-button" target="_blank" href="https://www.youtube.com/@flutterdev">Check out the Flutter YouTube channel</a>

[videos]: /resources/videos
