---
title: Flutter documentation
short-title: Docs
description: Get started with Flutter. Widgets, examples, updates, and API docs to help you write your first Flutter app.
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

To see changes to the site since our last release,
see [What's new][].

## New to Flutter?

Once you've gone through [Get started][],
including [Write your first Flutter app][],
here are some next steps.

### Docs

Coming from another platform? Check out Flutter for:
[Android][], [iOS][], [Web][], [React Native][] and
[Xamarin.Forms][] developers.

[Building layouts][]
: Learn how to create layouts in Flutter,
  where everything is a widget.

[Understanding constraints][]
: Once you understand that "Constraints
  flow down. Sizes flow up. Parents set
  positions", then you are well on your
  way to understanding Flutter's layout model.

[Adding interactivity to your Flutter app][]
: Learn how to add a stateful widget to your app.

[A tour of the Flutter widget framework][]
: Learn more about Flutter's react-style framework.

[FAQ][]
: Get the answers to frequently asked questions.

### Videos

We also have some helpful videos on our [Flutter YouTube channel][]!
In particular, check out the [Flutter in Focus series][],
and learn about other series on our [videos][] page.

Learn Flutter basics in [How do I make my first Flutter app?][]

<iframe style="max-width: 100%" width="560" height="315" src="{{site.youtube-site}}/embed/xWV71C2kp38" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe><br>

In Flutter, "everything is a widget"! To better understand
the two kinds of widgets, `Stateless` and `Stateful`, see 
[What is State?][]

<iframe style="max-width: 100%" width="560" height="315" src="{{site.youtube-site}}/embed/QlwiL_yLh6E" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

[How do I make my first Flutter app?]: {{site.youtube-site}}/watch?v=xWV71C2kp38
[What is State?]: {{site.youtube-site}}/watch?v=QlwiL_yLh6E

## Want to skill up?

If you learn best by watching engineers write code,
make mistakes, and fix them,
check out the [Boring Flutter Show][] video series:

<iframe style="max-width: 100%" width="560" height="315" src="{{site.youtube-site}}/embed/vqPG1tU6-c0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
[Boring Flutter Show playlist][]

You might also find these docs useful:

* [Using packages][]
* [Adding assets and images][]
* [Navigation and routing][]
* [State management][]
* [Animations][]

The documentation on this site reflects the latest stable release of Flutter.

[A tour of the Flutter widget framework]: {{site.url}}/development/ui/widgets-intro
[Adding assets and images]: {{site.url}}/development/ui/assets-and-images
[Adding interactivity to your Flutter app]: {{site.url}}/development/ui/interactive
[Android]: {{site.url}}/get-started/flutter-for/android-devs
[Animations]: {{site.url}}/development/ui/animations
[Boring Flutter Show]: {{site.youtube-site}}/watch?v=vqPG1tU6-c0&list=PLjxrf2q8roU28W3pXbISJbVA5REsA41Sx&index=3&t=9s
[Boring Flutter Show playlist]: {{site.youtube-site}}/watch?v=vqPG1tU6-c0&list=PLjxrf2q8roU28W3pXbISJbVA5REsA41Sx&index=3&t=9s
[Building layouts]: {{site.url}}/development/ui/layout
[FAQ]: {{site.url}}/resources/faq
[flutter-announce]: {{site.groups}}/forum/#!forum/flutter-announce
[Flutter in Focus]: {{site.youtube-site}}/playlist?list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2
[Flutter in Focus series]: {{site.youtube-site}}/playlist?list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2
[Flutter YouTube channel]: {{site.social.youtube}}
[Get started]: {{site.url}}/get-started/install
[iOS]: {{site.url}}/get-started/flutter-for/ios-devs
[Navigation and routing]: {{site.url}}/development/ui/navigation
[React Native]: {{site.url}}/get-started/flutter-for/react-native-devs
[State management]: {{site.url}}/development/data-and-backend/state-mgmt/intro
[Understanding constraints]: {{site.url}}/development/ui/layout/constraints
[Using packages]: {{site.url}}/development/packages-and-plugins/using-packages
[videos]: {{site.url}}/resources/videos
[Web]: {{site.url}}/get-started/flutter-for/web-devs
[What's new]: {{site.url}}/whats-new
[Write your first Flutter app]: {{site.url}}/get-started/codelab
[Xamarin.Forms]: {{site.url}}/get-started/flutter-for/xamarin-forms-devs
