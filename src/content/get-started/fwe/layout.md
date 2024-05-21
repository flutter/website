---
title: Layouts
description: Learn how to create layouts in Flutter.
prev:
  title: Flutter fundamentals
  path: /get-started/fwe/fundamentals
next:
    title: State management
    path: /get-started/fwe/state-management
---

Given that Flutter is a UI toolkit,
you’ll spend a lot of time creating layouts
with Flutter widgets. In this section,
you’ll learn how to build simple and
complex layouts with some of the most common layout widgets.
You’ll use Flutter DevTools (also
called Dart DevTools) to understand how
Flutter is creating your layout.
Finally, you'll encounter and debug one of
Flutter's most common layout errors,
the dreaded "unbounded constraints" error.

## Introduction to layouts

The following tutorial introduces you to layouts
in Flutter, and gives you an opportunity to work
with the most common layout widgets, like rows and columns.

<i class="material-symbols" aria-hidden="true">flutter_dash</i> Tutorial: [Layouts in Flutter][]


### Constraints

Understanding “constraints” in Flutter is  an
important part of understanding
how Flutter’s layout algorithm works.

The following resources teach you what
constraints are and some widgets that
allow you to work with constraints.

* Article: [Understanding constraints][]
* Video: [Expanded—Flutter Widget of the Week][]
* Video: [Flexible—Flutter Widget of the Week][]
* Video: [Intrinsic widgets—Decoding Flutter][]

### Intermediate layout tutorial

Now that you understand layouts and some tools
for working with them, check out the following tutorial,
which goes a bit deeper into common layout
widgets than the starting tutorial.

<i class="material-symbols" aria-hidden="true">flutter_dash</i> Tutorial: [Build a Flutter Layout][]

### Specific layout concepts

The following resources cover some common layout concepts
that are a bit more involved than using rows and columns.

#### Scrollable widgets

Several Flutter widgets facilitate scrolling through
content in your application.
First, you’ll see how to use the most common widget for
making any page scrollable,
as well as a widget for creating scrollable lists.
You’ll also be introduced to a common pattern in
Flutter—the builder pattern.
Many Flutter widgets use the builder pattern,
including some scrolling widgets.

* Documentation: [Basic scrolling][]
* Video: [Builder—Flutter Widget of the Week][]
* Video: [ListView—Flutter Widget of the Week][]
* Example code: [Work with long lists][]
* Example code: [Create a horizontal list][]
* Example code: [Create a grid list][]
* Video: [PageView—Flutter Widget of the Week][]

#### Stacks

Stacks give you more flexibility in placing widgets
in Flutter by allowing you to specify exact locations
of widgets within their parent,
including on top of each other.
If you’re coming from the web,
`Stacks` solve the same problem as `z-index`.

If you followed the previous tutorials mentioned
on this page, you’ve already worked with `Stack`s.
If not, these resources provide an overview.

* Video: [Stack—Flutter Widget of the Week][]
* Documentation: [Stack documentation][]

#### Overlays

Use an `Overlay`` when you have widgets that are
logically related to each other but visually separate,
such as tooltips.

* Video: [OverlayPortal—Flutter Widget of the Week][]

### Adaptive layouts

Because Flutter is used to create mobile,
tablet, desktop, _and_ web apps,
it’s likely you’ll need to adjust your
application to behave differently depending on
things like screen size or input device.
This is referred to as making an app
_adaptive_ and _responsive_.
The following resources start by
showing the most important widgets when
building adaptive layouts,
and finish with a codelab that has you
build an adaptive layout yourself.

* Video: [LayoutBuilder—Flutter Widget of the Week][]
* Video: [MediaQuery—Flutter Widget of the Week][]
* Video: [Building platform adaptive apps][]

<i class="material-symbols" aria-hidden="true">flutter_dash</i> Tutorial: [Adaptive Apps codelab][]

### DevTools and debugging layout

Flutter has a robust suite of DevTools that
help you work with any number of aspects of
Flutter development.
The "Widget Inspector" tool is particularly
useful when building layouts (and working with widgets in general).

Additionally, perhaps the most common error
you’ll run into while building a Flutter application
is due to incorrectly using layout widgets,
and is referred to as the “unbounded constraints” error.
If there was only one type error you should be prepared
to confront when you first start building Flutter apps,
it would be this one.

* Article: [Use the Flutter inspector][]
* Video: [Unbounded height and width—Decoding Flutter][]

### Reference material

The following resources explain individual APIs.

* [`Builder`][]
* [`Row`][]
* [`Column`][]
* [`Expanded`][]
* [`Flexible`][]
* [`ListView`][]
* [`Stack`][]
* [`Positioned`][]
* [`MediaQuery`][]

[Layouts in Flutter]: /ui/layout
[Understanding constraints]: /ui/layout/constraints
[Expanded—Flutter Widget of the Week]: {{site.youtube-site}}/watch?v=_rnZaagadyo
[Flexible—Flutter Widget of the Week]: {{site.youtube-site}}/watch?v=CI7x0mAZiY0
[Intrinsic widgets—Decoding Flutter]: {{site.youtube-site}}/watch?v=Si5XJ_IocEs
[Build a Flutter Layout]: /ui/layout/tutorial
[Basic scrolling]: /ui/layout/scrolling#basic-scrolling
[Builder—Flutter Widget of the Week]: {{site.youtube-site}}/watch?v=xXNOkIuSYuA
[ListView—Flutter Widget of the Week]: {{site.youtube-site}}/watch?v=KJpkjHGiI5A
[Work with long lists]: /cookbook/lists/long-lists
[Create a horizontal list]: /cookbook/lists/horizontal-list
[Create a grid list]: /cookbook/lists/grid-lists
[PageView—Flutter Widget of the Week]: {{site.youtube-site}}/watch?v=J1gE9xvph-A
[Stack—Flutter Widget of the Week]: {{site.youtube-site}}/watch?v=liEGSeD3Zt8
[Stack documentation]: /ui/layout#stack
[OverlayPortal—Flutter Widget of the Week]: {{site.youtube-site}}/watch?v=S0Ylpa44OAQ
[LayoutBuilder—Flutter Widget of the Week]: {{site.youtube-site}}/watch?v=IYDVcriKjsw
[MediaQuery—Flutter Widget of the Week]: {{site.youtube-site}}/watch?v=A3WrA4zAaPw
[Adaptive apps codelab]: {{site.codelabs}}/codelabs/flutter-adaptive-app
[Building platform adaptive apps]: {{site.youtube-site}}/watch?v=RCdeSKVt7LI
[Use the Flutter inspector]: /tools/devtools/inspector
[Unbounded height and width—Decoding Flutter]: {{site.youtube-site}}/watch?v=jckqXR5CrPI
[2D Scrolling]: {{site.youtube-site}}/watch?v=ppEdTo-VGcg
[`Builder`]: {{site.api}}/flutter/widgets/Builder-class.html
[`Row`]: {{site.api}}/flutter/widgets/Row-class.html
[`Column`]: {{site.api}}/flutter/widgets/Column-class.html
[`Expanded`]: {{site.api}}/flutter/widgets/Expanded-class.html
[`Flexible`]: {{site.api}}/flutter/widgets/Flexible-class.html
[`ListView`]: {{site.api}}/flutter/widgets/ListView-class.html
[`Stack`]: {{site.api}}/flutter/widgets/Stack-class.html
[`Positioned`]: {{site.api}}/flutter/widgets/Positioned-class.html
[`MediaQuery`]: {{site.api}}/flutter/widgets/MediaQuery-class.html

## Feedback

As this section of the website is evolving,
we [welcome your feedback][]!

[welcome your feedback]: https://google.qualtrics.com/jfe/form/SV_6A9KxXR7XmMrNsy?page="layout"
