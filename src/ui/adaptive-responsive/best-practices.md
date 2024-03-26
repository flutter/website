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

{{site.alert.secondary}}
  **Why do large screens matter, in particular?**<br>
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
{{site.alert.end}}

[large screens]: {{site.android-dev}}/guide/topics/large-screens/get-started-with-large-screens
[Play Store updates]: {{site.android-dev}}/2022/03/helping-users-discover-quality-apps-on.html

## Best practices

These best practices cover responsive _and_
adaptive app design.

### Save app state

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

### Restore List state

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

[FYI: I'd like to mostly avoid speaking specifically
about the Wonderous app, though
linking to example code is OK.]

If the `List` widget changes its layout
when the device's orientation changes,
you might have to do a bit of math ([example][])
to change the scroll position on screen rotation.

[app code for the Wonderous app]: {{site.github}}/gskinnerTeam/flutter-wonderous-app/blob/8a29d6709668980340b1b59c3d3588f123edd4d8/lib/ui/screens/wonder_events/widgets/_events_list.dart#L64
[example]: {{site.github}}/gskinnerTeam/flutter-wonderous-app/blob/34e49a08084fbbe69ed67be948ab00ef23819313/lib/ui/screens/collection/widgets/_collection_list.dart#L39
[`PageStorageKey`]: {{site.api}}/flutter/widgets/PageStorageKey-class.html

### Support multi-window mode

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

{{site.alert.secondary}}
  **A note about `MediaQuery`**<br>
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
{{site.alert.end}}

[`Display`]: {{site.api}}/flutter/dart-ui/Display-class.html
[`FlutterView.display`]: {{site.api}}/flutter/dart-ui/FlutterView/display.html
[_letterboxing_]: {{site.android-dev}}/guide/topics/large-screens/large-screen-compatibility-mode#letterboxing
[`MediaQuery`]: {{site.api}}/flutter/widgets/MediaQuery-class.html
[`setPreferredOrientations`]: {{site.api}}/flutter/services/SystemChrome/setPreferredOrientations.html
[window size classes]: {{site.android-dev}}/guide/topics/large-screens/support-different-screen-sizes#window_size_classes

### Support a variety of input devices

Apps should support basic mice, trackpads,
and keyboard shortcuts. The most common user
flows should support keyboard navigation
to ensure accessibility. In particular,
your app must provide accessible best practices
for keyboards on large devices.

### Implement focus state for custom widgets

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
