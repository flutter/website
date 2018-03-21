---
layout: page
title: Accessibility

permalink: /accessibility/
---

Flutter is committed to enable developers to make their Flutter apps accessible:
usable for all users, including users with disabilities such as blindness or
motor impairment.

* Placeholder for TOC
{:toc}

# Flutter's accessibility support

Flutter supports three components of accessibility support:

* **[Large fonts](#large-fonts)**: Render text widgets with user specified font
  font sizes
* **[Screen readers](#screen-reader)**: Communicate spoken feedback about UI
  contents
* **[High contrast](#high-contrast)**: Render widgets with colors that have
  sufficient contrast

## Large fonts {#large-fonts}

Both Android and iOS contain system settings for configure the desired font
sizes used by apps. Flutter text widgets respect this OS setting when
determining fint font sizes.

### Tips for developers

Font sizes are calculated automatically by Flutter based on the OS setting.
However, as a developer you should make sure your all layout has enough room to
render all it's contents when the font sizes are increased, for example by
testing all of your app on a small-screen device configured to use the largest
font setting.

### Example

The following two screenshots show the standard Flutter app template rendered 1)
with default Android font setting, and 2) with the largest font setting
specified in Android accessibility settings.

![Screenshot showing a Flutter app using regular font sizes](/images/a18n/a18n-fonts-regular.png)
![Screenshot showing a Flutter app using large font sizes](/images/a18n/a18n-fonts-large.png)

## Screen readers {#screen-reader}

Screen readers ([TalkBack][talkback], [VoiceOver][voiceover]) visually impaired
users can use a screen reader to get spoken feedback about the contents of the
screen.

### Tips for developers

To enable screen readers you as a developer must annotate the widget
tree with descriptions using the [Semantics widget][semanticswidget].


[talkback]: https://support.google.com/accessibility/android/answer/6283677?hl=en
[voiceover]: https://www.apple.com/lae/accessibility/iphone/vision/
[semanticswidget]: https://docs.flutter.io/flutter/widgets/Semantics-class.html

## High contract {#high-contrast}

Sufficient color contrast makes text and images easier to read. Along with
benefiting users with various visual impairments, sufficient color contrast
helps all users when viewing an interface on devices in extreme lighting
conditions, such as when exposed to direct sunlight or on a display with low
brightness.

The [W3C recommends](https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html):

* At least 4.5:1 for small text (below 18 point regular or 14 point bold)
* At least 3.0:1 for large text (18 point and above regular or 14 point and
  above bold)

### Tips for developers

Make sure any images you include have sufficient contrast.

When specifying colors on widgets, make sure sufficient contrast is used.
