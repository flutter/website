---
title: Overview
description: >
  It's important to create an app,
  whether for mobile or web,
  that responds to size and orientation changes
  and maximizes the use of each platform.
short-title: Adaptive
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
For example, on the current device,
should the UI use bottom navigation or
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

{% comment %}
---------------- CUT THIS OUT

* Create a responsive [Layout][]
* Handle [Input][] for adaptive apps
* Consider [Accessibility][] for responsive apps
* Respond to [Large screen][] devices
* Consider [Platform idioms][] for adaptive apps
  to make your app feel more native on a particular device
* Use [Best practices][] for responsive and adaptive apps,
  including **recommendations for large screens**

[Accessibility]: /ui/adaptive-responsive/accessibility
[Best practices]: /ui/adaptive-responsive/best-practices
[Input]: /ui/adaptive-responsive/input
[Large screen]: /ui/adaptive-responsive/large-screens
[Layout]: /ui/adaptive-responsive/layout
[Platform idioms]: /ui/adaptive-responsive/idioms

------------------ TO HERE, replace with new toc
{% endcomment %}

## Examples

If you'd like to see how these concepts come together,
check out the the source code for the following
apps/demos:

* [Wonderous][]
* [Flutter adaptive demo][]

[Flutter adaptive demo]: {{site.github}}/gskinnerTeam/flutter-adaptive-demo
[Wonderous]: {{site.github}}/gskinnerTeam/flutter-wonderous-app

## Learn more about basic usability principles

Of course, these pages don't constitute an
exhaustive list of the things you might consider.
The more operating systems, form factors,
and input devices you support, the more difficult
it becomes to spec out every permutation in design.

Taking time to learn basic usability principles as a
developer empowers you to make better decisions,
reduces back-and-forth iterations with
design during production, and results in
improved productivity with better outcomes.

Here are some resources to get you started:

* [Material guidelines on applying layout][]
* [Material design for large screens][]
* [Material guidelines on canonical layouts][]
* [Build high quality apps (Android)][]
* [UI design do's and don'ts (Apple)][]
* [Human interface guidelines (Apple)][]
* [Responsive design techniques (Microsoft)][]
* [Machine sizes and breakpoints (Microsoft)][]

[Build high quality apps (Android)]: {{site.android-dev}}/quality
[Material guidelines on applying layout]: {{site.material}}/foundations/layout/applying-layout/window-size-classes
[Material guidelines on canonical layouts]: {{site.material}}/foundations/layout/canonical-layouts/overview
[Human interface guidelines (Apple)]: {{site.apple-dev}}/design/human-interface-guidelines/
[Material design for large screens]: {{site.material2}}/blog/material-design-for-large-screens
[Machine sizes and breakpoints (Microsoft)]: https://docs.microsoft.com/en-us/windows/uwp/design/layout/screen-sizes-and-breakpoints-for-responsive-desig
[Responsive design techniques (Microsoft)]: https://docs.microsoft.com/en-us/windows/uwp/design/layout/responsive-design
[UI design do's and don'ts (Apple)]: {{site.apple-dev}}/design/tips/
