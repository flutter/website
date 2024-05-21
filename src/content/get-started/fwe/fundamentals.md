---
title: Flutter fundamentals
description: Learn the basic building blocks of Flutter.
prev:
  title: First week experience
  path: /get-started/fwe
next:
  title: Layouts
  path: /get-started/fwe/layout
---

On this page, there are a few videos,
articles, and a short tutorial that introduce many
of the foundational concepts used by 
Flutter developers on a daily basis.

## Welcome to Flutter

The following tutorial is a gentle introduction
in building UIs with Flutter.
It starts with a 'hello world' app,
and walks you through building a simple
shopping list application.
If you're exploring Flutter for the first time, it's
the perfect place to begin.

<i class="material-symbols" aria-hidden="true">flutter_dash</i>
Tutorial: [Building user interfaces with Flutter][]

## Dart

Flutter applications are built in [Dart][],
a language that will look familiar
to anyone who's written Java, Javascript,
or any other C-like language. The first
resource listed here is a tutorial about writing Dart code.  

:::note
Installing Flutter also installs Dart,
so you don't need to install Dart separately.
:::

<i class="material-symbols" aria-hidden="true">flutter_dash</i>
Tutorial: [Get started with Dart: Write command-line apps][]

If you're interested in why Flutter chose Dart, 
you can read about it in the resource linked below. 
The other link has more resources for learning Dart.

* [Why did Flutter choose to use Dart?][]
* [Bootstrap into Dart][]

## Anatomy of a widget

In regard to Flutter, you'll often hear
"everything is a widget".
Widgets are the UI building blocks that
are combined to create a fully
functional application.

In the first tutorial,
[Building user interfaces with Flutter][],
you saw some built-in widgets,
and created some custom widgets.
The following videos expand
on what you learned by explaining in detail
the two types of widgets that you use the
most in Flutter: stateless widgets and stateful widgets.

* [Flutter widgets 101 episode 1: Stateless widgets][]
* [Flutter widgets 101 episode 2: Stateful widgets][]

## Important widgets to know

The Flutter SDK includes many built-in widgets,
from the smallest pieces of UI, like `Text`,
to layout widgets, and widgets that style
your application. The following widgets are
the most important to be aware of as you move onto the
next lesson in the learning pathway.

* [`Container`][]
* [`Text`][]
* [`Scaffold`][]
* [`AppBar`][]
* [`Row`][] and [`Column`][]
* [`ElevatedButton`][]
* [`Image`][]
* [`Icon`][]

## Next: Layouts

This page is an introduction to foundational
Flutter concepts, like widgets,
and helps you become familiar with reading
Flutter and Dart code. It's okay if you don't
feel clear on every topic you encountered, as every page after
this is a deep-dive on specific topics.
In the next section, you'll start building more
interesting UIs by creating more complex layouts in Flutter.

[Building user interfaces with Flutter]: /ui
[Bootstrap into Dart]: /resources/bootstrap-into-dart
[Dart]: {{site.dart-site}}
[Flutter widgets 101 episode 1: Stateless widgets]: {{site.youtube-site}}/watch?v=wE7khGHVkYY
[Flutter widgets 101 episode 2: Stateful widgets]: {{site.youtube-site}}/watch?v=AqCMFXEmf3w
[Get started with Dart: Write command-line apps]: {{site.dart-site}}/tutorials/server/cmdline
[Why did Flutter choose to use Dart?]: /resources/faq#why-did-flutter-choose-to-use-dart

[`AppBar`]: {{site.api}}/flutter/material/AppBar-class.html
[`Column`]: {{site.api}}/flutter/widgets/Column-class.html
[`Container`]: {{site.api}}/flutter/widgets/Container-class.html
[`ElevatedButton`]: {{site.api}}/flutter/material/ElevatedButton-class.html
[`Icon`]: {{site.api}}/flutter/widgets/Icon-class.html
[`Image`]: {{site.api}}/flutter/widgets/Image-class.html
[`Row`]: {{site.api}}/flutter/widgets/Row-class.html
[`Scaffold`]: {{site.api}}/flutter/material/Scaffold-class.html
[`Text`]: {{site.api}}/flutter/widgets/Text-class.html

## Feedback

As this section of the website is evolving, 
we [welcome your feedback][]!

[welcome your feedback]: https://google.qualtrics.com/jfe/form/SV_6A9KxXR7XmMrNsy?page="fundamentals"
