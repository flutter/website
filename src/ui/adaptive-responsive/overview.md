---
title: Adaptive and responsive app design
description: >
  It's important to create an app,
  whether for mobile or web,
  that responds to size and orientation changes
  and maximizes the use of each platform.
short-title: Adaptive
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
For example, on the current device,
should the UI use bottom navigation or
side-panel navigation?

{{site.alert.note}}
  Often adaptive and responsive concepts are
  collapsed into a single term. Most often,
  _adaptive design_ is used to refer to both
  adaptive and responsive.
{{site.alert.end}}

xxx Don't forget to redirect from the "Building an adaptive app" page to the new pages

This section covers various aspects of adaptive and
responsive design:

* Create a responsive [Layout][]
* Handling [Input][] for adaptive apps
* Adapt to [Platform idioms]
* Consider [Accessibility][] for responsive apps
* Consider [Platform idioms][] for adaptive apps
* [Best practices][] for responsive and adaptive apps;
  including **recommendations for large screens**

[Accessibility][]: {{site.url}}/ui/layout/accessibility
[Best practices]: {{site.url}}/ui/layout/best-practices
[Input]: {{site.url}}/ui/layout/input
[Layout]: {{site.url}}/ui/layout/responsive
[Platform idioms]: {{site.url}}/ui/layout/idioms

## Learn more about basic usability principles

Of course, this page doesn't constitute an
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
