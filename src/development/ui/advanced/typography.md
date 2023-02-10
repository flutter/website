---
title: Flutter's fonts and typography
description: Learn about Flutter's support for typography.
---

If you aren't familiar with [_typography_][], it essentially
means how text is styled. Typography specifies how heavy
the font it, the slant of the font, the spacing between
the letters, and other visual aspects of the text.

All fonts are _not_ created the same. Fonts are a huge
topic and beyond the scope of this site, however you
might want to know more about Flutter's support for
variable fonts.

## Variable fonts

[Variable fonts][] (also called OpenType fonts),
allow you to control pre-defined aspects of text styling,
such as font weight, width, slant, and so on.
Variable fonts support specific axes, such as width,
weight, slant (to name a few). The user can select
_any value along the axis_ when specifying the type.

<img src='/assets/images/docs/development/ui/typography/variable-font-axes.png'
class="mw-100" alt="Example of two variable font axes">

However, the font must first define what axes are available,
and that isn't always easy to figure out. If you are using
a Google Font, you _can_ learn what axes are available using
the **type tester**, described in the next section.

### Using the Google Fonts type tester

The Google Fonts site has both variable and static fonts.
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
1. Select **Roboto Serif** to open up its detail page.
1. On the detail page, select the **Type tester** tab. For the
   Roboto Serif type, the **Variable axes** column looks like the following:

<img src='/assets/images/docs/development/ui/typography/roboto-serif-font-axes.png'
class="mw-100" alt="Listing of available font axes for Roboto Serif">

In real time, you can move the slider on any of the axes to
see how it affects the font. When programming a variable font,
use the [`FontVariation`][] class modify the font's design axes.

[Google Fonts]: https://fonts.google.com/

## Static fonts

Google Fonts also contains static fonts. As with variable fonts,
you need to know how the font is designed to know what options
are available to you.
Once again, the Google Fonts type tester can help.

### Using the Google Fonts type tester

Use the type tester to learn more about its static fonts.

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
   page, along with its name.
1. In real time, you can move the pixel slider to preview the font at
   different pixel sizes.
1. Select the **Type tester** tab to see the supported styles for
   the font. In this case, there are 3 supported styles.
1. Select the **Glyph** tab. This shows the glyphs that the
   font supports.

Use the following API to programmaticaly alter a static font
(but remember that this only works if the font was _designed_
to support the feature):

* [`FontFeature`][] to select glyphs
* [`FontWeight`][] to modify weight
* [`FontStyle`][] to italicize

## More info

The following video shows you some of the capabilities
of Flutter's typography and combines it with the Material
_and_ Cupertino look and feel (depending on the platform
the app runs on), animation, and custom fragment shaders:

<iframe width="560" height="315" src="https://www.youtube.com/embed/sA5MRFFUuOU" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
<b>Prototyping beautiful designs with Flutter</b>

If you would like to read about one engineer's experience
customizing variable fonts and animating them as they
morph (and was the basis for the above video),
check out [Playful typography with Flutter][],
a free article on Medium. The associated example also
uses a custom shader. 

[`FontFeature`]: {{site.api}}/flutter/dart-ui/FontFeature-class.html
[`FontVariation`]: {{site.api}}/flutter/dart-ui/FontVariation-class.html
[`FontWeight`]: {{site.api}}/flutter/dart-ui/FontWeight-class.html
[article]: {{site.flutter-medium}}/playful-typography-with-flutter-f030385058b4
[_typography_]: https://en.wikipedia.org/wiki/Typography
[Variable fonts]: https://fonts.google.com/knowledge/introducing_type/introducing_variable_fonts
