---
title: Best practices for adaptive design
description: >-
  Summary of some of the best practices for adaptive design.
shortTitle: Best practices
---

Recommended best practices for adaptive design include:

## Design considerations

### Break down your widgets

While designing your app, try to break down large,
complex widgets into smaller, simpler ones.

Refactoring widgets can reduce the complexity of
adopting an adaptive UI by sharing core pieces of code.
There are other benefits as well:

* On the performance side, having lots of small `const`
  widgets improves rebuild times over having large,
  complex widgets.
* Flutter can reuse `const` widget instances,
  while a larger complex widget has to be set up
  for every rebuild.
* From a code health perspective, organizing your UI
  into smaller bite sized pieces helps keep the complexity
  of each `Widget` down. A less-complex `Widget` is more readable,
  easier to refactor, and less likely to have surprising behavior.

To learn more, check out the 3 steps of
adaptive design in [General approach][].

[General approach]: /ui/adaptive-responsive/general

### Design to the strengths of each form factor

Beyond screen size, you should also spend time
considering the unique strengths and weaknesses
of different form factors. It isn't always ideal
for your multiplatform app to offer identical
functionality everywhere. Consider whether it makes
sense to focus on specific capabilities,
or even remove certain features, on some device categories.

For example, mobile devices are portable and have cameras,
but they aren't well suited for detailed creative work.
With this in mind, you might focus more on capturing content
and tagging it with location data for a mobile UI,
but focus on organizing or manipulating that content
for a tablet or desktop UI.

Another example is leveraging the web's extremely low barrier
for sharing. If you're deploying a web app,
decide which [deep links][] to support,
and design your navigation routes with those in mind.

The key takeaway here is to think about what each
platform does best and see if there are unique capabilities
you can leverage.

[deep links]: /ui/navigation/deep-linking

### Solve touch first

Building a great touch UI can often be more difficult
than a traditional desktop UI due, in part,
to the lack of input accelerators like right-click,
scroll wheel, or keyboard shortcuts.

One way to approach this challenge is to focus initially
on a great touch-oriented UI. You can still do most of
your testing using the desktop target for its iteration speed.
But, remember to switch frequently to a mobile device to
verify that everything feels right.

After you have the touch interface polished, you can tweak
the visual density for mouse users, and then layer on all
the additional inputs. Approach these other inputs as
accelerator—alternatives that make a task faster.
The important thing to consider is what a user expects
when using a particular input device,
and work to reflect that in your app.

## Implementation details

### Don't lock the orientation of your app.

An adaptive app should look good on windows of
different sizes and shapes. While locking an app
to portrait mode on phones can help narrow the scope
of a minimum viable product, it can increase the
effort required to make the app adaptive in the future.

For example, the assumption that phones will only
render your app in a full screen portrait mode is
not a guarantee. Multi window app support is becoming common,
and foldables have many use cases that work best with
multiple apps running side by side.

If you absolutely must lock your app in portrait mode (but don't),
use the `Display` API instead of something like `MediaQuery`
to get the physical dimensions of the screen.

To summarize:

  * Locked screens can be [an accessibility issue][] for some users
  * Android large format tiers require portrait and landscape
    support at the [lowest level][].
  * Android devices can [override a locked screen][]
  * Apple guidelines say [aim to support both orientations][]

[an accessibility issue]: https://www.w3.org/WAI/WCAG21/Understanding/orientation.html
[aim to support both orientations]: https://www.w3.org/WAI/WCAG21/Understanding/orientation.html
[lowest level]:  {{site.android-dev}}/docs/quality-guidelines/large-screen-app-quality#T3-8
[override a locked screen]: {{site.android-dev}}/guide/topics/large-screens/large-screen-compatibility-mode#per-app_overrides

### Avoid device orientation-based layouts

Avoid using `MediaQuery`'s orientation field
or `OrientationBuilder` near the top of your widget tree
to switch between different app layouts. This is
similar to the guidance of not checking device types
to determine screen size. The device's orientation also
doesn't necessarily inform you of how much space your
app window has.

Instead, use `MediaQuery`'s `sizeOf` or `LayoutBuilder`,
as discussed in the [General approach][] page.
Then use adaptive breakpoints like the ones that
[Material][] recommends.

[General approach]: /ui/adaptive-responsive/general#
[Material]: https://m3.material.io/foundations/layout/applying-layout/window-size-classes

### Don't gobble up all of the horizontal space

Apps that use the full width of the window to
display boxes or text fields don't play well
when these apps run on large screens.

To learn how to avoid this,
check out [Layout with GridView][].

[Layout with GridView]: /ui/adaptive-responsive/large-screens#layout-with-gridview

### Avoid checking for hardware types

Avoid writing code that checks whether the device you're
running on is a "phone" or a "tablet", or any other type
of device when making layout decisions.

What space your app is actually given to render in
isn't always tied to the full screen size of the device.
Flutter can run on many different platforms,
and your app might be running in a resizeable window on ChromeOS,
side by side with another app on tablets in a multi-window mode,
or even in a picture-in-picture on phones.
Therefore, device type and app window size aren't
really strongly connected.

Instead, use `MediaQuery` to get the size of the window
your app is currently running in.

This isn't only helpful for UI code.
To learn how abstracting out device
capabilities can help your business logic code,
check out the 2022 Google I/O talk,
[Flutter lessons for federated plugin development][].

[Flutter lessons for federated plugin development]: {{site.youtube-site}}/watch?v=GAnSNplNpCA

### Support a variety of input devices

Apps should support basic mice, trackpads,
and keyboard shortcuts. The most common user
flows should support keyboard navigation
to ensure accessibility. In particular,
your app follow accessible best practices
for keyboards on large devices.

The Material library provides widgets with
excellent default behavior for touch, mouse,
and keyboard interaction.

To learn how to add this support to custom widgets,
check out [User input & accessibility][].

[User input & accessibility]: /ui/adaptive-responsive/input

### Restore List state

To maintain the scroll position in a list
that doesn't change its layout when the
device's orientation changes,
use the [`PageStorageKey`][] class.
[`PageStorageKey`][] persists the
widget state in storage after the widget is
destroyed and restores state when recreated.

You can see an example of this in the [Wonderous app][],
where it stores the list's state in the
`SingleChildScrollView` widget.

If the `List` widget changes its layout
when the device's orientation changes,
you might have to do a bit of math ([example][])
to change the scroll position on screen rotation.

[example]: {{site.github}}/gskinnerTeam/flutter-wonderous-app/blob/34e49a08084fbbe69ed67be948ab00ef23819313/lib/ui/screens/collection/widgets/_collection_list.dart#L39
[`PageStorageKey`]: {{site.api}}/flutter/widgets/PageStorageKey-class.html
[Wonderous app]: {{site.github}}/gskinnerTeam/flutter-wonderous-app/blob/8a29d6709668980340b1b59c3d3588f123edd4d8/lib/ui/screens/wonder_events/widgets/_events_list.dart#L64

## Save app state

Apps should retain or restore [app state][]
as the device rotates, changes window size,
or folds and unfolds.
By default, an app should maintain state.

If your app loses state during device configuration,
verify that the plugins and native extensions
that your app uses support the
device type, such as a large screen.
Some native extensions might lose state when the
device changes position.

For more information on a real-world case
where this occurred, check out
[Problem: Folding/unfolding causes state loss][state-loss]
in [Developing Flutter apps for Large screens][article],
a free article on Medium.

[app state]: {{site.android-dev}}/jetpack/compose/state#store-state
[article]: {{site.flutter-blog}}/developing-flutter-apps-for-large-screens-53b7b0e17f10
[state-loss]: {{site.flutter-blog}}/developing-flutter-apps-for-large-screens-53b7b0e17f10#:~:text=Problem%3A%20Folding/Unfolding%20causes%20state%2Dloss
