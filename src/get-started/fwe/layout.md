---
title: Layouts
description: Learn how to create layouts in Flutter.
prev:
  title: Flutter fundamentals
next:
    title: State management
---

Given that Flutter is a UI toolkit, you’ll spend a lot of time creating layouts
with Flutter widgets. In this section, you’ll learn how to build simple and
complex layouts in Flutter with some of the most common layout widgets in
Flutter. You’ll also learn about how to use DevTools to understand how your apps
are being laid out, and you’ll learn how to debug one of the most common Flutter
errors, which is related to the most common Flutter layout widgets.

### Introduction to layouts

The following tutorial will introduce you to layouts in Flutter, and give you an
opportunity to work with the most common layout widgets, like rows and columns.

<i class="material-symbols" aria-hidden="true">flutter_dash</i> Tutorial: [Layouts in Flutter][]

### Constraints

Understanding “constraints” in Flutter are an important part of understanding
how Flutter’s layout algorithm works.

The following resources will teach you what constraints are, some widgets that
allow you to work with constraints, and how to deal with “unbounded constraints”
type errors.

* Article: [Understanding Constraints][]
* Video: [Expanded - Flutter Widget of the Week][]
* Video: [Flexible - Flutter Widget of the Week][]
* Video: [Intrinsic widgets - Decoding Flutter][]

### Intermediate layout tutorial

Now that you understand layouts and some tools that help working with them, you
should read the following tutorial, which goes a bit deeper into common layout
widgets than the starting tutorial.

<i class="material-symbols" aria-hidden="true">flutter_dash</i> Tutorial: [Build a Flutter Layout][]

### Specific layout concepts

The following resources cover a few specific layout concepts that are very common, and a bit more involved than using rows and columns.

#### Scrollable widgets

There are several Flutter widgets that facilitate scrolling through content in
your application. For now, you’ll see how to use the most common widget for
making any given page scrollable, as well as a widget that creates scrollable
lists. You’ll also be introduced to a common pattern in Flutter - the builder
pattern. The builder pattern is used in many Flutter widgets, including some
scrolling widgets.

* Documentation: [Basic scrolling][]
* Video: [Builder - Flutter Widget of the Week][]
* Video: [ListView - Flutter Widget of the Week][]
* Example code: [Work with long lists][]
* Example code: [Create a horizontal list][]
* Example code: [Create a grid list][]
* Video: [PageView - Flutter Widget of the Week][]

#### Stacks

Stacks give you more flexibility in placing widgets in Flutter by allowing you
to specify exact locations of widgets within their parent, including on top of
each other. If you’re coming from the web, `Stacks` solve the same problem
as `z-index`.

If you followed both of the tutorials mentioned on this page, you’ve already
worked with Stacks. If not, these resources provide an overview.

* Video: [Stack - Flutter Widget of the Week][]
* Documentation: [Stack documentation][]

#### Overlays

Overlays are used when you have widgets that are logically related to each
other, but visually separate, such as tooltips.

* Video: [OverlayPortal - Flutter Widget of the Week][]

### Adaptive layouts

Because Flutter is used to create mobile, tablet, desktop and web apps, it’s
likely you’ll need to adjust your application to behave differently depending on
things like screen-size, input types, and more. The following resources start by
showing the most important widgets when building adaptive layouts, and finish
with a Codelab that has you build an adaptive layout yourself.

* Video: [LayoutBuilder - Flutter Widget of the Week][]
* Video: [MediaQuery - Flutter Widget of the Week][]
* Video: [Building platform adaptive apps][]

<i class="material-symbols" aria-hidden="true">flutter_dash</i> Tutorial: [Adaptive Apps codelab][]

### DevTools and debugging for layout

Flutter has a robust suite of DevTools that will help you work with any number
of aspects of Flutter development. The “Widget Inspector” tool is particularly
useful when building Layouts (and working with widgets in general).

Additionally, perhaps the most common error you’ll run into while building a
Flutter application is due to incorrectly using Layout widgets, and is referred
to as the “unbounded constraints” error. If there was only one type error you
should be prepared to confront before you start building Flutter apps, it’d be
this type.

* Article: [DevTools - Widget Inspector][]
* Video: [Unbounded height and width - Decoding Flutter][]

### Reference material

The following resources explain individual APIs.

- [Builder][]
- [Row][]
- [Column][]
- [Expanded][]
- [Flexible][]
- [ListView][]
- [Stack][]
- [Positioned][]
- [MediaQuery][]

[Layouts in Flutter]: {{site.url}}/ui/layout
[Understanding Constraints]: {{site.url}}/ui/layout/constraints
[Expanded - Flutter Widget of the Week]: https://www.youtube.com/watch?v=_rnZaagadyo
[Flexible - Flutter Widget of the Week]: https://www.youtube.com/watch?v=CI7x0mAZiY0
[Intrinsic widgets - Decoding Flutter]: https://www.youtube.com/watch?v=Si5XJ_IocEs
[Build a Flutter Layout]: {{site.url}}/ui/layout/tutorial
[Basic scrolling]: {{site.url}}/ui/layout/scrolling#basic-scrolling
[Builder - Flutter Widget of the Week]: https://www.youtube.com/watch?v=xXNOkIuSYuA
[ListView - Flutter Widget of the Week]: https://www.youtube.com/watch?v=KJpkjHGiI5A
[Work with long lists]: {{site.url}}/cookbook/lists/long-lists
[Create a horizontal list]: {{site.url}}/cookbook/lists/horizontal-list
[Create a grid list]: {{site.url}}/cookbook/lists/grid-lists
[PageView - Flutter Widget of the Week]: https://www.youtube.com/watch?v=J1gE9xvph-A
[Stack - Flutter Widget of the Week]: https://www.youtube.com/watch?v=liEGSeD3Zt8
[Stack documentation]: {{site.url}}/ui/layout#stack
[OverlayPortal - Flutter Widget of the Week]: https://www.youtube.com/watch?v=S0Ylpa44OAQ
[LayoutBuilder - Flutter Widget of the Week]: https://www.youtube.com/watch?v=IYDVcriKjsw
[MediaQuery - Flutter Widget of the Week]: https://www.youtube.com/watch?v=A3WrA4zAaPw
[Adaptive Apps codelab]: https://codelabs.developers.google.com/codelabs/flutter-adaptive-app
[Building platform adaptive apps]: https://www.youtube.com/watch?v=RCdeSKVt7LI
[DevTools - Widget Inspector]: {{site.url}}/tools/devtools/inspector
[Unbounded height and width - Decoding Flutter]: https://www.youtube.com/watch?v=jckqXR5CrPI
[2D Scrolling]: https://www.youtube.com/watch?v=ppEdTo-VGcg
[Builder]: {{site.api}}/flutter/widgets/Builder-class.html
[Row]: {{site.api}}flutter/widgets/Row-class.html
[Column]: {{site.api}}flutter/widgets/Column-class.html
[Expanded]: {{site.api}}flutter/widgets/Expanded-class.html
[Flexible]: {{site.api}}flutter/widgets/Flexible-class.html
[ListView]: {{site.api}}flutter/widgets/ListView-class.html
[Stack]: {{site.api}}flutter/widgets/Stack-class.html
[Positioned]: {{site.api}}flutter/widgets/Positioned-class.html
[MediaQuery]: {{site.api}}flutter/widgets/MediaQuery-class.html