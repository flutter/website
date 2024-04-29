---
title: Best practices for adaptive design
description: >
  Summarize some of the best practices for adaptive design.
short-title: Best practice
---

Recommended best practices for adaptive design include:

## Don't lock the orientation of your app.

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

If you absolutely need to lock your app to portrait mode,
remember to use the `Display` API instead of something
like `MediaQuery`, which has been previously recommended.

To summarize:

  * Locked screens can be [an accessibility issue][] for some users
  * Android large format tiers require portrait and landscape
    support at the [lowest level][].
  * Android devices can [override a locked screen][]
  * Apple guidelines say [aim to support both orientations][] 

[accessibility issue]: https://www.w3.org/WAI/WCAG21/Understanding/orientation.html
[aim to support both orientations]: https://www.w3.org/WAI/WCAG21/Understanding/orientation.html
[lowest level]:  {{site.android-dev}}/docs/quality-guidelines/large-screen-app-quality#T3-8
[override a locked screen]: {{site.android-dev}}/guide/topics/large-screens/large-screen-compatibility-mode#per-app_overrides

<b>PENDING: Link to blog post</b>

## Don't gobble up all of the horizontal space

Use the `MediaQuery.sizeOf` and `LayoutBuilder` classes
that reflect the app area and available widget area, respectively

To maintain the scroll position in a list
that doesn't change its layout when the
device's orientation changes,
use the [`PageStorageKey`][] class.
[`PageStorageKey`][] persists the
widget state in storage after the widget is
destroyed and restores state when recreated.

You can see an example of this
in the [app code for the Wonderous app][],
where it stores the list's state in the
`SingleChildScrollView` widget.

If the `List` widget changes its layout
when the device's orientation changes,
you might have to do a bit of math ([example][])
to change the scroll position on screen rotation.

[app code for the Wonderous app]: {{site.github}}/gskinnerTeam/flutter-wonderous-app/blob/8a29d6709668980340b1b59c3d3588f123edd4d8/lib/ui/screens/wonder_events/widgets/_events_list.dart#L64
[example]: {{site.github}}/gskinnerTeam/flutter-wonderous-app/blob/34e49a08084fbbe69ed67be948ab00ef23819313/lib/ui/screens/collection/widgets/_collection_list.dart#L39
[`PageStorageKey`]: {{site.api}}/flutter/widgets/PageStorageKey-class.html

## Break down your `Widget`s

While building your app, try to break down large,
complex widgets into smaller, simpler ones.

Refactoring widgets can reduce the complexity of
adopting an adaptive UI by sharing core pieces of code.
There are other benefits as well:

* On the performance side, having lots of small `const`
  widgets improves rebuild times over having large,
  complex widgets.
* Flutter can reuse `const` widget instances,
  while a larger complex widget has to be set up
  every time there is a rebuild.
* From a code health perspective, organizing your UI
  into smaller bite sized pieces helps keep the complexity
  of each `Widget` down. A less-complex `Widget` is more readable,
  easier to refactor, and less likely to have surprising behavior.

## Avoid checking for hardware types

Avoid writing code that checks whether the device you're
running on is a "phone" or a "tablet", or any other type
of device when making layout decisions.

What space your app is actually given to render in
isn’t always tied to the full screen size of the device.
Flutter can run on many different platforms,
and your app might be running in a resizeable window on ChromeOS,
side by side with another app on tablets in a multi-window mode,
or even in a picture-in-picture on phones.
Therefore, device type and app window size aren’t
really strongly connected.

Instead, use `MediaQuery` to get the size of the window
your app is currently running in.

This isn’t just helpful for UI code.
Check out last year’s talk
[Flutter lessons for federated plugin development][]
to learn how abstracting out device capabilities
can help your business logic code as well.
 
[Flutter lessons for federated plugin development]: https://www.youtube.com/watch?v=GAnSNplNpCA

## Avoid orientation-based layouts

Avoid using `MediaQuery`'s orientation field
or `OrientationBuilder` to switch between
different app layouts. This is similar to the
guidance of not checking device types to determine
screen size. The device’s orientation also doesn’t
necessarily inform you of how much space your app window has.

Instead, use `MediaQuery`'s `sizeOf` or `LayoutBuilder`,
and use adaptive breakpoints like the ones that the
Material website recommends.

# Support multi-window mode
Use the [`Display`][] class, which
supports Android's [window size classes][],
to determine the full screen size an app can use,
and to distinguish a small device from
a large, multi-screen device.<br><br>
The `Display` class allows you to retrieve
various properties of a display,
such as physical size, pixel ratio,
and refresh rate.
The [`FlutterView.display`][] getter returns
a `Display` object.<br><br>

:::secondary Warning
This class should only be used
when you need to know the physical display
capabilities. For most use cases, use `MediaQuery`.
:::

For an example that uses this method,
check out the [`setPreferredOrientations`][] API.

[`FlutterView.display`]: {{site.api}}/flutter/dart-ui/FlutterView/display.html
[`MediaQuery`]: {{site.api}}/flutter/widgets/MediaQuery-class.html
[`setPreferredOrientations`]: {{site.api}}/flutter/services/SystemChrome/setPreferredOrientations.html
[window size classes]: {{site.android-dev}}/guide/topics/large-screens/support-different-screen-sizes#window_size_classes

## Support a variety of input devices

Apps should support basic mice, trackpads,
and keyboard shortcuts. The most common user
flows should support keyboard navigation
to ensure accessibility. In particular,
your app must provide accessible best practices
for keyboards on large devices.

The Material library provides widgets with
excellent default behavior for touch, mouse,
and keyboard interaction.

# Save app state

Apps should retain or restore [app state][]
as the device rotates, changes window size,
or folds and unfolds. 
By default, Flutter should maintain state.

If your app loses state during device configuration,
verify that the plugins and native extensions
that your app uses support the
device type, such as a large screen.
Some native extensions might lose state when the
device changes position.

<b>TODO(sfshaza): PENDING: What can you do when this happens?</b>

[app state]: {{site.android-dev}}/jetpack/compose/state#store-state
