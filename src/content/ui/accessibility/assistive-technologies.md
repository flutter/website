---
title: Accessibility Technologies
description: Information about accessibility
---

[**Screen readers**][]
: Communicate spoken feedback about UI contents


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

Check out the following [video demo][] to see Victor Tsaran,
using VoiceOver with the now-archived [Flutter Gallery][] web app.

Flutter's standard widgets generate an accessibility tree automatically.
However, if your app needs something different,
it can be customized using the [`Semantics` widget][].

When there is text in your app that should be voiced
with a specific voice, inform the screen reader
which voice to use by calling [`TextSpan.locale`][].
Note that `MaterialApp.locale` and `Localizations.override`
don't affect which voice the screen reader uses.
Usually, the screen reader uses the system voice
except where you explicitly set it with `TextSpan.locale`.

[Flutter Gallery]: {{site.gallery-archive}}
[`TextSpan.locale`]: {{site.api}}/flutter/painting/TextSpan/locale.html
[`Semantics` widget]: {{site.api}}/flutter/widgets/Semantics-class.html
[TalkBack]: https://support.google.com/accessibility/android/answer/6283677?hl=en
[VoiceOver]: https://www.apple.com/lae/accessibility/iphone/vision/
[video demo]: {{site.yt.watch}}?v=A6Sx0lBP8PI