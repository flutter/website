---
title: UI Design & Styling
description: Information on Flutter's accessibility support.
---

To create an accessible app, design your UI with accessibility in mind.
This page covers key aspects of accessible UI design and styling.

## Large fonts

Both Android and iOS contain system settings to configure the desired font
sizes used by apps. Flutter text widgets respect this OS setting when
determining font sizes.

Font sizes are calculated automatically by Flutter based on the OS setting.
However, as a developer you should make sure your layout has enough room to
render all its contents when the font sizes are increased.
For example, you can test all parts of your app on a small-screen
device configured to use the largest font setting.

### Example

The following two screenshots show the standard Flutter app
template rendered with the default iOS font setting,
and with the largest font setting selected in iOS accessibility settings.

<div class="wrapping-row">
  {% render docs/app-figure.md, image:"a11y/app-regular-fonts.png", caption:"Default font setting", img-class:"simple-border", img-style:"max-height: 480px;" %}
  {% render docs/app-figure.md, image:"a11y/app-large-fonts.png", caption:"Largest accessibility font setting", img-class:"simple-border", img-style:"max-height: 480px;" %}
</div>


## Sufficient contrast

Sufficient color contrast makes text and images easier to read.
Along with benefitting users with various visual impairments,
sufficient color contrast helps all users when viewing an interface
on devices in extreme lighting conditions,
such as when exposed to direct sunlight or on a display with low
brightness.

The [W3C recommends][]:

* At least 4.5:1 for small text (below 18 point regular or 14 point bold)
* At least 3.0:1 for large text (18 point and above regular or 14 point and
  above bold)

[W3C recommends]: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html

### Example
The following screenshot shows good and bad examples for text color contrast.

  {% render docs/app-figure.md, image:"a11y/text-contrast.png", caption:"text contrast", img-class:"simple-border", img-style:"max-height: 480px;" %}


## Tap target size

Controls that are too small are hard for many people to interact with and select.
Ensure that interactive elements have a large enough tap target to be easily
pressed by users.  

Both [Android][] and [iOS][] recommend a minimum tap target size of 48x48 dp and 44x44 pts respectively.

The [W3C] recommends a minimum target size of 44 by 44 CSS pixels,

[Android]: https://developer.android.com/guide/topics/ui/accessibility/apps#large-controls
[iOS]: https://developer.apple.com/design/human-interface-guidelines/accessibility#Mobility
[W3C]: https://www.w3.org/WAI/WCAG21/Understanding/target-size.html


### Example

The following screenshot shows how to make these widgets to have at least an 48x48 tap target.

  {% render docs/app-figure.md, image:"a11y/tap-target-size.png", caption:"tap target size", img-class:"simple-border", img-style:"max-height: 480px;" %}
