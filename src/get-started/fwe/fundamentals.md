---
title: Flutter fundamentals
description: Learn the basic building blocks of Flutter.
prev:
    title: Learn more
    permalink: /get-started/learn-more
next:
    title: Layouts
    permalink: /get-started/fwe/layout
---

Welcome to Flutter! On this page, there are a few videos, articles and a short tutorial that introduce many of the foundational concepts Flutter developers use on a daily basis.

## Welcome to Flutter

The following tutorial is a gentle introduction in building UIs with Flutter. It starts with a 'hello world' app, and walks you through building a simple shopping list application. If you're exploring Flutter for the first time, it's the perfect place to begin.

<i class="material-symbols" aria-hidden="true">flutter_dash</i> Tutorial: [Building user interfaces with Flutter][]

## Dart

Flutter applications are built in [Dart][], a language that will look familiar to anyone who's written Java, Javascript or any other C-like language. The first resource listed here is a tutorial about writing Dart code. After that, you can read about why Flutter chose to use Dart, and find a page with more resources for learning Dart.

{{site.alert.note}}
You don't need to install Dart separately if you install Flutter. Dart is included in the Flutter SDK. 
{{site.alert.end}}

<i class="material-symbols" aria-hidden="true">flutter_dash</i> Tutorial: [Get started with Dart: Write command-line apps][]

* [Why did Flutter choose to use Dart?][]
* [Bootstrap into Dart][]

## Anatomy of a widget

In regard to Flutter, you'll often hear "everything is a widget". This isn't exactly true, but it is safe to say that "_almost_ everything is a widget". Widgets are the UI building blocks that are combined to create a fully functional application. 

In the first tutorial, [Building user interfaces with Flutter][], you saw some built in widgets, and created some custom widgets. The following videos expand on what you learned by explaining in detail the two types of widgets that you use the most in Flutter: stateless widgets and stateful widgets. 

* [Flutter widgets 101 episode 1: Stateless widgets][]
* [Flutter widgets 101 episode 2: Stateful widgets][]

## Important widgets to know

The Flutter SDK includes many built-in widgets, from the smallest pieces of UI, like `Text`, to layout widgets and widgets that style your application. The following widgets are the most important to be aware of as you move onto the next lesson in the learning pathway.

* [Container][]
* [Text][]
* [Scaffold][]
* [AppBar][]
* [Row][] and [Column][]
* [Elevated Button][]
* [Image][]
* [Icon][]

## Next: Layouts

This page was meant to be an introduction to foundational Flutter concepts, like widgets, and to help you get familiar with reading Flutter and Dart code. It's okay if you don't feel clear on every topic you encountered, as every page after this is a deep-dive on specific topics. In the next section, you'll start building more interesting UIs by creating more complex layouts in Flutter.

[Building user interfaces with Flutter]:{{site.url}}/ui
[Dart]: {{site.dart-site}}
[Why did Flutter choose to use Dart?]: {{site.url}/resources/faq#why-did-flutter-choose-to-use-dart
[Get started with Dart: Write command-line apps]: {{site.dart-site}}/tutorials/server/cmdline
[Bootstrap into Dart]: {{site.url}}/resources/bootstrap-into-dart
[Flutter widgets 101 episode 1: Stateless widgets]: https://www.youtube.com/watch?v=wE7khGHVkYY
[Flutter widgets 101 episode 2: Stateful widgets]: https://www.youtube.com/watch?v=AqCMFXEmf3w
[Container]: {{api}}/flutter/widgets/Container-class.html
[Text]: {{api}}/flutter/widgets/Text-class.html
[Scaffold]: {{api}}/flutter/material/Scaffold-class.html
[AppBar]: {{api}}/flutter/material/AppBar-class.html
[Row]: {{api}}/flutter/widgets/Row-class.html
[Column]: {{api}}/flutter/widgets/Column-class.html
[Elevated Button]: {{api}}/flutter/material/ElevatedButton-class.html
[Image]: {{api}}/flutter/widgets/Image-class.html
[Icon]: {{api}}/flutter/widgets/Icon-class.html

