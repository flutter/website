---
title: Flutter documentation
short-title: Docs
description: Get started with Flutter. Widgets, examples, updates, and API docs to help you write your first Flutter app.
---

{% for card in site.data.docs_cards -%}
  {% capture index0Modulo3 -%}{{ forloop.index0 | modulo:3 }}{% endcapture -%}
  {% capture indexModulo3 -%}{{ forloop.index | modulo:3 }}{% endcapture -%}
  {% if index0Modulo3 == '0' -%}
  <div class="card-deck mb-4">
  {% endif -%}
    <a class="card" href="{{card.url}}">
      <div class="card-body">
        <header class="card-title">{{card.name}}</header>
        <p class="card-text">{{card.description}}</p>
      </div>
    </a>
  {% if indexModulo3 == '0' -%}
  </div>
  {% endif -%}
{% endfor %}

**To see changes to the site since our last release,
see [What's new][].**

[What's new]: {{site.url}}/release/whats-new

## New to Flutter?

Once you've gone through [Get started][],
including [Write your first Flutter app][],
here are some next steps.

[Write your first Flutter app]: {{site.url}}/get-started/codelab

### Docs

Coming from another platform? Check out Flutter for:
[Android][], [SwiftUI][], [UIKit][], [React Native][], and
[Xamarin.Forms][] developers.

[Building layouts][]
: Learn how to create layouts in Flutter,
  where everything is a widget.

[Understanding constraints][]
: Once you understand that "Constraints
  flow down. Sizes flow up. Parents set
  positions", then you are well on your
  way to understanding Flutter's layout model.

[Adding interactivity to your Flutter app][interactivity]
: Learn how to add a stateful widget to your app.

[FAQ][]
: Get the answers to frequently asked questions.

[Android]: {{site.url}}/get-started/flutter-for/android-devs
[Building layouts]: {{site.url}}/ui/layout
[FAQ]: {{site.url}}/resources/faq
[Get started]: {{site.url}}/get-started/install
[interactivity]: {{site.url}}/ui/interactivity
[SwiftUI]: {{site.url}}/get-started/flutter-for/swiftui-devs
[UIKit]: {{site.url}}/get-started/flutter-for/uikit-devs
[React Native]: {{site.url}}/get-started/flutter-for/react-native-devs
[Understanding constraints]: {{site.url}}/ui/layout/constraints
[Xamarin.Forms]: {{site.url}}/get-started/flutter-for/xamarin-forms-devs

### Videos

Check out the Introducing Flutter series.
Learn Flutter basics like
[how do I make my first Flutter app?][first-app]
In Flutter, "everything is a widget"!
Learn more about `Stateless` and `Stateful`
widgets in [What is State?][]

<div class="card-deck card-deck--responsive">
    <div class="video-card">
        <div class="card-body">
            <iframe style="max-width: 100%; width: 100%; height: 230px;" src="{{site.yt.embed}}/xWV71C2kp38" title="Create your first Flutter app" {{site.yt.set}}></iframe>
        </div>
    </div>
    <div class="video-card">
        <div class="card-body">
            <iframe style="max-width: 100%; width: 100%; height: 230px;" src="{{site.yt.embed}}/QlwiL_yLh6E" title="What is state?" {{site.yt.set}}></iframe>
        </div>
    </div>
</div>

[first-app]: {{site.yt.watch}}?v=xWV71C2kp38
[What is State?]: {{site.yt.watch}}?v=QlwiL_yLh6E

{:.text-center}
**Only have 60 seconds? Learn how to build and deploy a Flutter App!**

<div style="display: flex; align-items: center; justify-content: center; flex-direction: column;">
  <iframe style="max-width: 100%" width="560" height="315" src="{{site.yt.embed}}/ZnufaryH43s" title="Learn how to build and deploy a Flutter app in 60 seconds" {{site.yt.set}}></iframe>
</div>

## Want to skill up?

Dive deeper into how Flutter works under the hood!
Learn [why you write standalone widgets instead of
using helper methods][standalone-widgets] or
[what is "BuildContext" and how is it used][buildcontext]?

<div class="card-deck card-deck--responsive">
    <div class="video-card">
        <div class="card-body">
            <iframe style="max-width: 100%; width: 100%; height: 230px;" src="{{site.yt.embed}}/IOyq-eTRhvo" title="Learn the difference between Widgets and Helper Methods" {{site.yt.set}}></iframe>
        </div>
    </div>
    <div class="video-card">
        <div class="card-body">
            <iframe style="max-width: 100%; width: 100%; height: 230px;" src="{{site.yt.embed}}/rIaaH87z1-g" title="Learn how to demystify BuildContext" {{site.yt.set}}></iframe>
        </div>
    </div>
</div>

[standalone-widgets]: {{site.yt.watch}}?v=IOyq-eTRhvo
[buildcontext]: {{site.yt.watch}}?v=rIaaH87z1-g

To learn about all of the Flutter video series,
see our [videos][] page.

We release new videos almost every week on the Flutter YouTube channel:

<a class="btn btn-primary" target="_blank" href="https://www.youtube.com/@flutterdev">Explore more Flutter videos</a>

**The documentation on this site reflects the
latest stable release of Flutter.**

[videos]: {{site.url}}/resources/videos
