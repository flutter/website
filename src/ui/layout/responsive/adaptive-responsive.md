---
title: A responsive vs adaptive app
description: >
  It's important to create an app, >
  whether for mobile or web, >
  that responds to size and orientation changes
  and maximizes the use of each platform.
short-title: Adaptive vs responsive
---

{% include docs/yt_shims.liquid %}

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

