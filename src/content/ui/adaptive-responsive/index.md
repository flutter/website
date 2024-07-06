---
title: Adaptive and responsive design in Flutter
description: >-
  It's important to create an app,
  whether for mobile or web,
  that responds to size and orientation changes
  and maximizes the use of each platform.
short-title: Adaptive design
---

![List of supported platforms](/assets/images/docs/ui/adaptive-responsive/platforms.png)

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
For example, should a tablet UI use bottom navigation or
side-panel navigation?

:::note
Often adaptive and responsive concepts are
collapsed into a single term. Most often,
_adaptive design_ is used to refer to both
adaptive and responsive.
:::

This section covers various aspects of adaptive and
responsive design:

* [General approach][]
* [SafeArea & MediaQuery][]
* [Large screens & foldables][]
* [User input & accessibility][]
* [Capabilities & policies][]
* [Best practices for adaptive apps][]
* [Additional resources][]

[Additional resources]: /ui/adaptive-responsive/more-info
[Best practices for adaptive apps]: /ui/adaptive-responsive/best-practices
[Capabilities & policies]: /ui/adaptive-responsive/capabilities
[General approach]: /ui/adaptive-responsive/general
[Large screens & foldables]: /ui/adaptive-responsive/large-screens
[SafeArea & MediaQuery]: /ui/adaptive-responsive/safearea-mediaquery
[User input & accessibility]: /ui/adaptive-responsive/input

:::note
You might also check out the Google I/O 2024 talk about
this subject.

{% ytEmbed 'LeKLGzpsz9I', 'How to build adaptive UI with Flutter' %}
:::
