---
title: Flutter's fonts and typography
description: Learn about Flutter's support for typography.
---

[_Typography_][] covers the style and appearance of
type or fonts: it specifies how heavy the font is,
the slant of the font, the spacing between
the letters, and other visual aspects of the text.

All fonts are _not_ created the same. Fonts are a huge
topic and beyond the scope of this site, however,
this page discusses Flutter's support for variable
and static fonts.

[_Typography_]: https://en.wikipedia.org/wiki/Typography

## Variable fonts

[Variable fonts][] (also called OpenType fonts),
allow you to control pre-defined aspects of text styling.
Variable fonts support specific axes, such as width,
weight, slant (to name a few).
The user can select _any value along the continuous axis_
when specifying the type.

<img src='/assets/images/docs/development/ui/typography/variable-font-axes.png'
class="mw-100" alt="Example of two variable font axes">

However, the font must first define what axes are available,
and that isn't always easy to figure out. If you are using
a Google Font, you _can_ learn what axes are available using
the **type tester** feature, described in the next section.

[Variable fonts]: https://fonts.google.com/knowledge/introducing_type/introducing_variable_fonts

### Using the Google Fonts type tester

The Google Fonts site offers both variable and static fonts.
Use the type tester to learn more about its variable fonts.

1. To investigate a variable Google font, go to the [Google Fonts][]
   website. Note that in the upper right corner of each font card,
   it says either **variable** for a variable font, or
   **x styles** indicating how many styles a static
   font supports.
1. To see all variable fonts, check the **Show only variable fonts**
   checkbox.
1. Either scroll down (or use the search field) to find Roboto.
   This lists several Roboto variable fonts.
1. Select **Roboto Serif** to open up its details page.
1. On the details page, select the **Type tester** tab.
   For the Roboto Serif font,
   the **Variable axes** column looks like the following:

<img src='/assets/images/docs/development/ui/typography/roboto-serif-font-axes.png'
class="mw-100" alt="Listing of available font axes for Roboto Serif">

In real time, move the slider on any of the axes to
see how it affects the font. When programming a variable font,
use the [`FontVariation`][] class to modify the font's design axes.
The `FontVariation` class conforms to the
[OpenType font variables spec][].

[`FontVariation`]: {{site.api}}/flutter/dart-ui/FontVariation-class.html
[Google Fonts]: https://fonts.google.com/
[OpenType font variables spec]: https://learn.microsoft.com/en-us/typography/opentype/spec/otvaroverview

## Static fonts

Google Fonts also contains static fonts. As with variable fonts,
you need to know how the font is designed to know what options
are available to you.
Once again, the Google Fonts site can help.

### Using the Google Fonts site

Use the font's details page to learn more about its static fonts.

1. To investigate a variable Google font, go to the [Google Fonts][]
   website. Note that in the upper right corner of each font card,
   it says either **variable** for a variable font, or
   **x styles** indicating how many styles a static
   font supports.
1. Make sure that **Show only variable fonts** is **not** checked
   and the search field is empty.
1. Open the **Font properties** menu. Check the **Number of styles**
   checkbox, and move the slider to 10+.
1. Select a font, such as **Roboto** to open up its details page.
1. Roboto has 12 styles, and each style is previewed on its details
   page, along with the name of that variation.
1. In real time, move the pixel slider to preview the font at
   different pixel sizes.
1. Select the **Type tester** tab to see the supported styles for
   the font. In this case, there are 3 supported styles.
1. Select the **Glyph** tab. This shows the glyphs that the
   font supports.

Use the following API to programmatically alter a static font
(but remember that this only works if the font was _designed_
to support the feature):

* [`FontFeature`][] to select glyphs
* [`FontWeight`][] to modify weight
* [`FontStyle`][] to italicize

A `FontFeature` corresponds to an [OpenType feature tag][]
and can be thought of as a boolean flag to enable or disable
a feature of a given font.
The following example is for CSS, but illustrates the concept:

<img src='/assets/images/docs/development/ui/typography/feature-tag-example.png'
class="mw-100" alt="Example feature tags in CSS">

[`FontFeature`]: {{site.api}}/flutter/dart-ui/FontFeature-class.html
[`FontStyle`]: {{site.api}}/flutter/dart-ui/FontStyle.html
[`FontWeight`]: {{site.api}}/flutter/dart-ui/FontWeight-class.html
[OpenType feature tag]: https://learn.microsoft.com/en-us/typography/opentype/spec/featuretags

## Other resources

The following video shows you some of the capabilities
of Flutter's typography and combines it with the Material
_and_ Cupertino look and feel (depending on the platform
the app runs on), animation, and custom fragment shaders:

{% ytEmbed 'sA5MRFFUuOU', 'Prototyping beautiful designs with Flutter' %}

To read one engineer's experience
customizing variable fonts and animating them as they
morph (and was the basis for the above video),
check out [Playful typography with Flutter][article],
a free article on Medium. The associated example also
uses a custom shader.

[article]: {{site.flutter-medium}}/playful-typography-with-flutter-f030385058b4
