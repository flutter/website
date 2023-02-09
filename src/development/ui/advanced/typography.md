---
title: Flutter's fonts and typography
description: Learn about Flutter's support for typography.
---

If you aren't familiar with [_typography_][], it essentially
means how text is styled. [Variable fonts][] (also
called OpenType fonts), allow you to control various
aspects of text styling, such as font weight, width, slant,
and so on.

The following video shows you some of the capabilities
of Flutter's typography and combines it with the Material
_and_ Cupertino look and feel (depending on the platform
the app runs on), animation, and custom fragment shaders:

<iframe width="560" height="315" src="https://www.youtube.com/embed/sA5MRFFUuOU" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
<b>Prototyping beautiful designs with Flutter</b>

Also, check out the [article][].

## API docs

Here are some Flutter classes that allow you to
modify variable fonts:

* [`FontFeature`][] allows you to select glyphs in a font
* [`FontVariation`][] allows you to modify a font's design axes

## More info

If you would like to read about one engineer's experience
customizing variable fonts and animating them as they
morph, check out [Playful typography with Flutter][],
a free article on Medium. The associated example also
uses a custom shader.

[`FontFeature`]: {{site.api}}/flutter/dart-ui/FontFeature-class.html
[`FontVariation`]: {{site.api}}/flutter/dart-ui/FontVariation-class.html
[article]: {{site.flutter-medium}}/playful-typography-with-flutter-f030385058b4
[_typography_]: https://en.wikipedia.org/wiki/Typography
[Variable fonts]: https://fonts.google.com/knowledge/introducing_type/introducing_variable_fonts
