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

Check out the Introducing Flutter series. Learn Flutter basics like [how do I make my first Flutter app?][] In Flutter, "everything is a widget"! Learn more about `Stateless` and `Stateful` widgets in [What is State?][]

<div class="card-deck card-deck--responsive">
    <div class="video-card">
        <div class="card-body">
            <iframe style="max-width: 100%; width: 100%; height: 230px;" src="{{site.youtube-site}}/embed/xWV71C2kp38" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe> 
        </div>
    </div>
    <div class="video-card">
        <div class="card-body">
            <iframe style="max-width: 100%; width: 100%; height: 230px;" src="{{site.youtube-site}}/embed/QlwiL_yLh6E" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe> 
        </div>
    </div>
</div>

[How do I make my first Flutter app?]: {{site.youtube-site}}/watch?v=xWV71C2kp38
[What is State?]: {{site.youtube-site}}/watch?v=QlwiL_yLh6E




<div style="display: flex; align-items: center; justify-content: center; flex-direction: column;">
  <h4>Only have 60 seconds? Learn how to build and deploy a Flutter App!</h4>

  <iframe style="max-width: 100%" width="560" height="315" src="{{site.youtube-site}}/embed/ZnufaryH43s" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

## Want to skill up?

Dive deeper into how Flutter works under the hood! Learn [why you write standalone widgets instead of using helper methods][] or [what is “BuildContext” and how is it used][]?

<div class="card-deck card-deck--responsive">
    <div class="video-card">
        <div class="card-body">
            <iframe style="max-width: 100%; width: 100%; height: 230px;" src="{{site.youtube-site}}/embed/IOyq-eTRhvo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe> 
        </div>
    </div>
    <div class="video-card">
        <div class="card-body">
            <iframe style="max-width: 100%; width: 100%; height: 230px;" src="{{site.youtube-site}}/embed/rIaaH87z1-g" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe> 
        </div>
    </div>
</div>

[why you write standalone widgets instead of using helper methods]: {{site.youtube-site}}/IOyq-eTRhvo
[what is “BuildContext” and how is it used]: {{site.youtube-site}}/rIaaH87z1-g

To learn about all of the Flutter video series, see our [videos][] page.

We release new videos every week on the Flutter YouTube channel.

<a class="btn btn-primary" target="_blank" href="https://www.youtube.com/c/flutterdev">Explore more Flutter videos</a>




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
