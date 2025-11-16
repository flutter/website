---
title: Accessibility technologies
description: >-
  Information about accessibility technologies for Flutter developers.
---

## Summary

Assistive technologies are essential for making digital content accessible to
individuals with disabilities. This document provides an overview of two key
categories of assistive technologies relevant to Flutter development: screen
readers for users with visual impairments and mobility support tools for
those with motor limitations. By understanding and testing with these
technologies, you can ensure your Flutter application provides a more inclusive
and user-friendly experience for everyone.

## Screen readers

For mobile, screen readers ([TalkBack][], [VoiceOver][])
enable visually impaired users to get spoken feedback about
the contents of the screen and interact with the UI by using
gestures on mobile and keyboard shortcuts on desktop.
Turn on VoiceOver or TalkBack on your mobile device and
navigate around your app.

**To turn on the screen reader on your device, complete the following steps:**

{% tabs %}
{% tab "TalkBack on Android" %}

1. On your device, open **Settings**.
2. Select **Accessibility** and then **TalkBack**.
3. Turn 'Use TalkBack' on or off.
4. Select Ok.

To learn how to find and customize Android's
accessibility features, view the following video.

{% ytEmbed 'FQyj_XTl01w', 'Customize Pixel and Android accessibility features' %}

{% endtab %}
{% tab "VoiceOver on iPhone" %}

1. On your device, open **Settings > Accessibility > VoiceOver**
2. Turn the VoiceOver setting on or off

To learn how to find and customize iOS
accessibility features, view the following video.

{% ytEmbed 'ROIe49kXOc8', 'How to navigate your iPhone or iPad with VoiceOver' %}

{% endtab %}
{% tab "Browsers" %}

For web, the following screen readers are currently supported:

Mobile browsers:

* iOS - VoiceOver
* Android - TalkBack

Desktop browsers:

* macOS - VoiceOver
* Windows - JAWs & NVDA

Screen readers users on web must toggle the
"Enable accessibility" button to build the semantics tree.
Users can skip this step if you programmatically auto-enable
accessibility for your app using this API:

```dart
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

void main() {
  runApp(const MyApp());
  SemanticsBinding.instance.ensureSemantics();
}
```

{% endtab %}
{% tab "Desktop" %}

Windows comes with a screen reader called Narrator
but some developers recommend using the more popular
NVDA screen reader. To learn about using NVDA to test
Windows apps, check out
[Screen Readers 101 For Front-End Developers (Windows)][nvda].

[nvda]: https://get-evinced.com/blog/screen-readers-101-for-front-end-developers-windows

On a Mac, you can use the desktop version of VoiceOver,
which is included in macOS.

{% ytEmbed '5R-6WvAihms', 'Screen reader basics: VoiceOver' %}

On Linux, a popular screen reader is called Orca.
It comes pre-installed with some distributions
and is available on package repositories such as `apt`.
To learn about using Orca, check out
[Getting started with Orca screen reader on Gnome desktop][orca].

[orca]: https://www.a11yproject.com/posts/getting-started-with-orca

{% endtab %}
{% endtabs %}

<br/>

Check out the following [video demo][] to see how to
use VoiceOver with the now-archived [Flutter Gallery][] web app.

Flutter's standard widgets generate an accessibility tree automatically.
However, if your app needs something different,
it can be customized using the [`Semantics` widget][].

When there is text in your app that should be voiced
with a specific voice, inform the screen reader
which voice to use by calling [`TextSpan.locale`][].
`MaterialApp.locale` and `Localizations.override`
will affect screen reader voices starting from flutter 3.38 release.
Usually, the screen reader uses the system voice
except where you explicitly set it with `TextSpan.locale`.

[Flutter Gallery]: {{site.gallery-archive}}
[`TextSpan.locale`]: {{site.api}}/flutter/painting/TextSpan/locale.html
[`Semantics` widget]: {{site.api}}/flutter/widgets/Semantics-class.html
[TalkBack]: https://support.google.com/accessibility/android/answer/6283677?hl=en
[VoiceOver]: https://www.apple.com/lae/accessibility/iphone/vision/
[video demo]: {{site.yt.watch}}?v=A6Sx0lBP8PI

## Mobility support

For users with limited dexterity or hand strength, mobility support features
can be helpful. Both Android and iOS offer a range of tools designed to make
navigation and control easier.
These features allow users to operate their devices through external switches,
voice commands, or simplified on-screen menus.

Android provides Switch Access, Voice Access and Accessibility Menu,
while iOS offers Switch Control, Voice Control, and AssistiveTouch.
Understanding these tools helps in creating
apps that are usable by people with diverse physical abilities.

<table class="table table-striped">
  <thead>
    <tr>
      <th>OS</th>
      <th>Features </th>
      <th>Functions</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Android</td>
      <td><strong>Switch Access</strong> </td>
      <td>As an alternate input method, you can use Switch Access and Camera Switches</td>
    </tr>
    <tr>
      <td>Android</td>
      <td><strong>Voice Access</strong> </td>
      <td>Control your device with your voice</td>
    </tr>
    <tr>
      <td>Android</td>
      <td><strong>Accessibility Menu</strong> </td>
      <td>A floating, on-screen menu that provides simplified buttons to control essential phone functions.</td>
    </tr>
    <tr>
      <td>iOS</td>
      <td><strong>Switch Control</strong> </td>
      <td>Use switches as an alternate input methods</td>
    </tr>
    <tr>
      <td>iOS</td>
      <td><strong>Voice Control</strong> </td>
      <td>Control your device with your voice</td>
    </tr>
    <tr>
      <td>iOS</td>
      <td><strong>AssistiveTouch</strong> </td>
      <td>Use AssistiveTouch to replace multi-finger gestures or hardware button actions</td>
    </tr>
  </tbody>
</table>
