---
title: SafeArea & MediaQuery
description: >-
  Learn how to use SafeArea and MediaQuery
  to create an adaptive app.
---

This page discusses how and when to use the
`SafeArea` and `MediaQuery` widgets.

## SafeArea

When running your app on the latest devices,
you might encounter bits of the UI being blocked
by cutouts on the device's screen.
You can fix this with the [`SafeArea`][] widget,
which insets its child widget to avoid intrusions
(like notches and camera cutouts),
as well as operating system UI
(such as the status bar on Android),
or by rounded corners of the physical display.

If you don't want this behavior,
the `SafeArea` widget allows you to
disable padding on any of its four sides.
By default, all four sides are enabled.

It's generally recommended to wrap the body of a
`Scaffold` widget in `SafeArea` as a good place to start,
but you don't always need to put it this high in the
`Widget` tree.

For example, if you purposefully want your app to stretch
under the cutouts, you can move the `SafeArea` to wrap
whatever content makes sense,
and let the rest of the app take up the full screen.

Using `SafeArea` ensures that your app content won't be
cut off by physical display features or operating system UI,
and sets your app up for success even as new devices with
different shapes and styles of cutouts enter the market.

How does `SafeArea` do so much in a small amount of code?
Behind the scenes it uses the `MediaQuery` object.

[`SafeArea`]: {{site.api}}/flutter/widgets/SafeArea-class.html

## MediaQuery

As discussed in the [SafeArea](#safearea) section,
`MediaQuery` is a powerful widget for creating
adaptive apps. Sometimes you'll use `MediaQuery`
directly, and sometimes you'll use `SafeArea`,
which uses `MediaQuery` behind the scenes.

`MediaQuery` provides lots of information,
including the app's current window size.
It exposes accessibility settings like high contrast mode
and text scaling, or if the user is using an accessibility
service like TalkBack or VoiceOver.
`MediaQuery` also contains info about the features
of your device's display, such as having a hinge or a fold.

`SafeArea` uses the data from `MediaQuery` to figure out
how much to inset its child `Widget`.
Specifically, it uses the `MediaQuery` padding property,
which is basically the amount of the display that's
partially obscured by system UI, display notches, or status bar.

So, why not use `MediaQuery` directly?

The answer is that `SafeArea` does one clever thing
that makes it beneficial to use over just raw `MediaQueryData`.
Specifically, it modifies the `MediaQuery` exposed
to `SafeArea`'s children to make it appear as if the
padding added to `SafeArea` doesn't exist.
This means that you can nest `SafeArea`s,
and only the topmost one will apply the padding
needed to avoid the notches as system UI.

As your app grows and you move widgets around,
you don't have to worry about having too much
padding applied if you have multiple `SafeArea`s,
whereas you would have issues if using
`MediaQueryData.padding` directly.

You _can_ wrap the body of a `Scaffold` widget
with a `SafeArea`, but you don't _have_ to put it this high
in the widget tree.
The `SafeArea` just needs to wrap the contents
that would cause information loss if cut off by the
hardware features mentioned earlier.

For example, if you purposefully want your app to stretch
under the cutouts, you can move the `SafeArea` to wrap
whatever content makes sense,
and let the rest of the app take up the full screen.
A side note is that this is what the `AppBar` widget
does by default, which is how it goes underneath the
system status bar. This is also why wrapping the body
of a `Scaffold` in a `SafeArea` is recommended,
instead of wrapping the whole `Scaffold` itself.

`SafeArea` ensures that your app content won't be
cut off in a generic way and sets your app up
for success even as new devices with different
shapes and styles of cutouts enter the market.
