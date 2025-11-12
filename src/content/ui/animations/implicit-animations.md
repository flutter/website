---
title: Implicit animations
description: Where to find more information on using implicit animations in Flutter.
---

With Flutter's [animation library][],
you can add motion and create visual effects
for the widgets in your UI.
One part of the library is an assortment of widgets
that manage animations for you.
These widgets are collectively referred to as _implicit animations_,
or _implicitly animated widgets_, deriving their name from the
[`ImplicitlyAnimatedWidget`][] class that they implement.
The following set of resources provide many ways to learn
about implicit animations in Flutter.

## Documentation

[Animations in Flutter codelab][]
: Learn about implicit and explicit animations 
  and get hands-on experience adding implicit animations
  to a complete Flutter app.

[`AnimatedContainer` sample][]
: A step-by-step recipe for using the
  [`AnimatedContainer`][] implicitly animated widget.

[`ImplicitlyAnimatedWidget`][] API page
: All implicit animations extend the `ImplicitlyAnimatedWidget` class.

[Animations in Flutter codelab]: {{site.codelabs}}/advanced-flutter-animations
[`AnimatedContainer` sample]: /cookbook/animation/animated-container
[`ImplicitlyAnimatedWidget`]: {{site.api}}/flutter/widgets/ImplicitlyAnimatedWidget-class.html

## Flutter in Focus videos

Flutter in Focus videos feature 5-10 minute tutorials
with real code that cover techniques
that every Flutter dev needs to know from top to bottom.
The following videos cover topics
that are relevant to implicit animations.

<YouTubeEmbed id="IVTjpW3W33s" title="Flutter implicit animation basics"></YouTubeEmbed>

<YouTubeEmbed id="6KiPEqzJIKQ" title="Create custom implicit animations with TweenAnimationBuilder"></YouTubeEmbed>

## The Boring Show

Watch the Boring Show to follow Google Engineers build apps
from scratch in Flutter. The following episode covers
using implicit animations in a news aggregator app.

<YouTubeEmbed id="8ehlWchLVlQ" title="Adding implicit animations to a news application"></YouTubeEmbed>

## Widget of the Week videos

A weekly series of short animated videos each showing
the important features of one particular widget.
In about 60 seconds, you'll see real code for each
widget with a demo about how it works.
The following Widget of the Week videos cover
implicitly animated widgets:

{% assign animatedWidgets = 'AnimatedOpacity, AnimatedPadding, AnimatedPositioned, AnimatedSwitcher' | split: ", " %}
{% assign animatedUrls = 'QZAvjqOqiLY, PY2m0fhGNz4, hC3s2YdtWt8, 2W7POjFb88g' | split: ", " %}

{% for widget in animatedWidgets %}
{% assign videoUrl = animatedUrls[forloop.index0] %}
{% assign videoDescription = 'Learn about the ' | append: widget | append: ' Flutter Widget' %}

<YouTubeEmbed id="{{ videoUrl }}" title="{{ videoDescription }}"></YouTubeEmbed>

{% endfor -%}

[`AnimatedContainer`]: {{site.api}}/flutter/widgets/AnimatedContainer-class.html
[animation library]: {{site.api}}/flutter/animation/animation-library.html
