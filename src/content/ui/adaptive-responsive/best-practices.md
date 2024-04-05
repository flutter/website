---
title: Best practices for app design
description: >
  Learn the best practices for creating >
  a responsive and an adaptive app.
short-title: Best practices
---

The best practices on this page cover,
in particular, large screen devices,
but can equally apply to any Flutter app.
Flutter defines [large screens][] as tablets,
foldables, and ChromeOS devices running Android.

:::secondary Why do large screens matter, in particular?
Demand for large screens continues to increase.
As of January 2024,
more than [270 million active large screen][]
and foldable devices run on Android.
When your app supports large screens,
it also receives the following benefits:

* Optimizing your app to fill the screen improves
  your app's user engagement metrics.
* Increases your app's visibility in the Play Store.
  Recent [Play Store updates][] show ratings by
  device type and indicates when an app lacks
  large screen support. 
:::

[large screens]: {{site.android-dev}}/guide/topics/large-screens/get-started-with-large-screens
[Play Store updates]: {{site.android-dev}}/2022/03/helping-users-discover-quality-apps-on.html

These best practices cover responsive _and_
adaptive app design.

## SafeArea

When running your app on the latest devices,
you might encounter bits of the UI being blocked
by cutouts on top of the device's screen.

You can fix this with the [`SafeArea`][] widget,
which insets its child widget to avoid intrusions
(like notches and camera cutouts),
as well as operating system UI (such as the status bar
on Android, or by rounded corners of the display).
The `SafeArea` widget allows you to enable or
disable padding on any of its four sides.

It’s generally recommended to wrap the body of a
`Scaffold` widget in `SafeArea` as a safe place to start,
but you don’t always need to put it this high in the
`Widget` tree.

[xxx PENDING: example code]

For example, if you purposefully want your app to stretch
under the cutouts, you can move the `SafeArea` to wrap
whatever content makes sense,
and let the rest of the app take up the full screen.

[xxx PENDING: example]

Using `SafeArea` ensures that your app content won’t be
cut off by physical display features or operating system UI
and sets your app up for success even as new devices with
different shapes and styles of cutouts enter the market.

[`SafeArea`]: {{site.api}}/flutter/widgets/SafeArea-class.html

## Don't gobble up all horizontal space

If viewing your mobile app on a large screen device,
you might notice that either a box or some text might
take up all the horizontal space.

This is _not_ recommended by the Android Large Screen App
Quality Guidelines.
There are a couple ways you can solve this.

You can use the `GridView` widget to transform your
existing `ListView` into more reasonably sized items,
or you can use the `maxWidth` property of `BoxConstraints`
to not have the list go edge-to-edge.

### GridView

The `GridView` widget is very similar to the `ListView` widget,
but instead of only handling a list of widgets arranged linearly,
`GridView` can arrange widgets in a two-dimensional array.

`GridView` also has constructors that are similar to `ListView`'s,
with `ListView`'s default constructor mapping to `GridView.count`,
and `ListView.builder` being similar to `GridView.builder`.
`GridView` also has additional constructors for more custom layouts,
if you’re interested in finding out more,
check out the [`GridView`][] API page.

[`GridView`]: {{site.api}}/flutter/widgets/GridView-class.html

[xxx PENDING] Not finished yet.

## Save app state

Apps should retain or restore [app state][]
as the device rotates, changes window size,
or folds and unfolds. 
By default, Flutter should maintain state.

[xxx PENDING: How SHOULD they save app state? Does [this page][] apply to this situation?]
[this page]: /platform-integration/android/restore-state-android

If your app loses state during device configuration,
verify that the plugins and native extensions
that your app uses support the
device type, such as a large screen.
Some native extensions might lose state when the
device changes position.

[xxx PENDING: What can you do when this happens? Do you need a federated plugin?]

[app state]: {{site.android-dev}}/jetpack/compose/state#store-state

## Restore List state

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

## Support multi-window mode

Use the [`Display`][] class, which
supports Android's [window size classes][],
to determine a device's full screen size,
and to distinguish a small device from
a large, multi-screen device.

The `Display` class allows you to retrieve
various properties of a display,
such as physical size, pixel ratio,
and refresh rate.
The [`FlutterView.display`][] getter returns
a `Display` object. 

For an example that uses this method,
check out the [`setPreferredOrientations`][] API.

:::note A note about `MediaQuery`
Using the [`MediaQuery`][] class to determine
the size of the device while also disabling 
landscape mode (called _portrait locking_),
causes the app's window to lock to the center of
the screen while surrounding the window with black.

This scenario, called [_letterboxing_][],
can happen in other situations as well and
is undesirable, particularly on larger screens.
The [`MediaQuery`][] class doesn't return the
proper screen size in split screen mode, and
can mistake a large screen for a small screen.
Use the `Display` class, instead.
:::

[`Display`]: {{site.api}}/flutter/dart-ui/Display-class.html
[`FlutterView.display`]: {{site.api}}/flutter/dart-ui/FlutterView/display.html
[_letterboxing_]: {{site.android-dev}}/guide/topics/large-screens/large-screen-compatibility-mode#letterboxing
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

## Implement focus state for custom widgets

Flutter’s Material buttons handle basic
focus states, unless you change the
default styling of the Material buttons
to set the `overlayColor` to transparent. 

Implement a focus state for any custom
buttons or gesture detectors in your app. 
If you change the default Material button styles,
test for keyboard focus states and 
implement your own, if needed.

For an example that changes the button style
to outline the button when the it has focus,
check out the [button code for the Wonderous app][].
In this example, the [`FocusNode.hasFocus`][]
property is modified to check whether
the button has focus and, if so, adds an outline.

[button code for the Wonderous app]: {{site.github}}/gskinnerTeam/flutter-wonderous-app/blob/8a29d6709668980340b1b59c3d3588f123edd4d8/lib/ui/common/controls/buttons.dart#L143
[`FocusNode.hasFocus`]: {{site.api}}/flutter/widgets/FocusNode/hasFocus.html
