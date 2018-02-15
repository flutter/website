---
layout: page
title: "Tutorial: Your First Flutter App"
permalink: /tutorials/get-started/
---

This is a guide to creating your first Flutter app. If you know how
to program, you can complete this tutorial. You don't need previous
experience with Dart or mobile programming.

<!-- Probably replace this with a manual TOC.-->
* TOC Placeholder
{:toc}

### What are Flutter and Dart?

_Flutter_ is a mobile app SDK to help developers and designers build
modern mobile apps for iOS and Android.

_Dart_ is an application programming language from Google that's easy
to learn, easy to use, and deployable everywhere. Flutter apps are
written in Dart.

### What you'll build

You'll implement a simple mobile app that proposes names for a startup
company.  The user can select and unselect proposed names,
saving the best ones.  The code generates ten names at a time.
As the user scrolls, new batches of names are generated.

<center><img src="images/StartupNameGenerator-screenshot.png" alt="Screenshot of the name generator"></center>
<center>[PENDING: Temporary image - replace this with video.]</center><br><br>

The following video shows how the finished app works:

[PENDING: Matt is making the video]

<div class="whats-the-point" markdown="1">

<b> <a id="whats-the-point" class="anchor" href="#whats-the-point" aria-hidden="true"><span class="octicon octicon-link"></span></a>What you'll learn:</b>

* Basic structure of a Flutter app.
* Finding and using packages to extend functionality.
* Using hot reload for a quicker development cycle.
* How to implement a stateful widget.
* How to create an infinite, lazily loaded list.
* How to create and navigate to a second screen.
* ...

</div>

<div class="whats-the-point" markdown="1">

<b> <a id="whats-the-point" class="anchor" href="#whats-the-point" aria-hidden="true"><span class="octicon octicon-link"></span></a>What you'll use:</b>

This tutorial requires version xxx or later of the Flutter SDK.
When you install Flutter, you get the correct version of the Dart SDK
as part of the install. You also get a Flutter Simulator, which you can
use instead of a physical mobile device.

These instructions feature the Android Studio IDE, but you
can use whichever tools you prefer&mdash;Flutter and Dart plugins
are also available for VSCode and JetBrains products.

See [Mit's new setup page](todo) for information on how to set up
your environment and create your first simple Flutter app.

</div>

## Step 1: Create the starting Flutter app

Create a basic Flutter app, using the instructions in [Mit's new page,
preferably linked to a specific anchor for creating the templated
app](todo). Name the project **startup_namer**. You'll be modifying
this starter app to create the finished app.

### View the code

Here's the code for the initial app,
which displays "Hello World" in the middle of the screen.

{% prettify dart %}
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: new Center(
          child: new Text('Hello World')
        ),
      ),
    );
  }
}
{% endprettify %}

### Observations

<ul markdown="1">

<li markdown="1"> This example creates a Material app.
</li>
<li markdown="1"> The `main` method specifies fat arrow (`=>`)
    notation, which is short hand used for one-line functions
    or methods.
</li>
<li markdown="1"> The app extends StatelessWidget which makes
    the app itself a widget.  In Flutter, most everything is a widget,
    including alignment, padding, and layout.
</li>
<li markdown="1"> The Scaffold widget, from the Material library,
    provides a default app bar, title, and a body property
    that holds the widget tree for the home screen.
    The widget subtree can be quite complex. <!--For example, it might
    consist of a Column widget, which can contain many children.-->
</li>
<li markdown="1"> The widget tree for this example consists of a
    Center widget containing a Text child widget. The Center widget
    aligns its widget subtree to the center of the screen.
</li>
<li markdown="1"> A widget's main job is to provide a `build`
    function which describes how to display the widget in terms
    of other, lower level widgets.
</li>
<li markdown="1"> Moving the "hello world" text into a separate
    widget, HelloWorld, results in an identical widget tree:
</li>
</ul>

<!-- skip -->
{% prettify dart %}
class HelloWorld extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return new Center(
     child: new Text('Hello World'),
   );
 }
}
{% endprettify %}

---

## Step 2: Use an external package

In this step, you'll start using an open-source package named
**english_words**, which contains a few thousand of the most used
English words plus some utility functions.

You can find the
[english_words](https://pub.dartlang.org/packages/english_words)
package, as well as many other open source packages, on
[pub.dartlang.org](https://pub.dartlang.org/).

<ol markdown="1">

<li markdown="1">
In **pubspec.yaml**, add **english_words** (3.0.1 or higher)
to the **dependencies** list. The new line is highlighted below:

<!-- skip -->
{% prettify yaml %}
dependencies:
  flutter:
    sdk: flutter

  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^0.1.0
  [[highlight]]english_words: ^3.0.1[[/highlight]]
{% endprettify %}
</li>

<li markdown="1">
Click **Packages get**, at the upper right of Android Studio
editor's view of `pubspec.yaml`. This pulls the package into
your project.
</li>
<li markdown="1">
In **lib/main.dart**, add the import for `english_words`, as
shown in the highlighted line:

{% prettify dart %}
import 'package:flutter/material.dart';
[[highlight]]import 'package:english_words/english_words.dart';[[/highlight]]
{% endprettify %}

As you type, Android Studio gives you suggestions for libraries to
import.  It then renders the import string in gray, letting you know
that the imported library is unused (so far).
</li>
<li markdown="1">
Use the English Words package to generate the text for Hello World by
adding the RandomWords class and using an instance of RandomWords
as the child for the Center widget. The changes are highlighted
below:

<!-- skip -->
{% prettify dart %}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: new Center(
          [[highlight]]//child: new Text('Hello World')[[/highlight]]  //old line
          [[highlight]]child: new RandomWords(),[[/highlight]] //new line
        ),
      ),
    );
  }
}

// new class
[[highlight]]class RandomWords extends StatelessWidget {[[/highlight]]
  [[highlight]]@override[[/highlight]]
  [[highlight]]Widget build(BuildContext context) {[[/highlight]]
    [[highlight]]var wordPair = generateWordPairs().first;[[/highlight]]
    [[highlight]]return new Center([[/highlight]]
      [[highlight]]child: new Text('${wordPair.first} ${wordPair.second}'),[[/highlight]]
    [[highlight]]);[[/highlight]]
  [[highlight]]}[[/highlight]]
[[highlight]]}[[/highlight]]
{% endprettify %}
</li>
<li markdown="1">
If the app is running, use the hot reload button
(<img src="images/hot-reload-button.png" alt="lightning bolt icon")
to update the running app. Each time you click hot reload, you should
see two different words, chosen at random, in the running app.
</li>
</ol>

### Problems?

If your app isn't running correctly, look for typos.

The files you edited in this step should now look like this
(minus the comments):

**pubspec.yaml**

{% prettify yaml %}
name: startup_namer
description: A new Flutter application.

dependencies:
  flutter:
    sdk: flutter

  cupertino_icons: ^0.1.0
  english_words: ^3.0.1

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  uses-material-design: true
{% endprettify %}

**lib/main.dart**

{% prettify dart %}
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: new Center(
          child: new RandomWords(),
        ),
      ),
    );
  }
}

class RandomWords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var wordPair = generateWordPairs().first;
    return new Center(
      child: new Text('${wordPair.first} ${wordPair.second}'),
    );
  }
}
{% endprettify %}

---

## Step 3: Add a Stateful widget

Stateless widgets are immutable, meaning that their
properties can't change&mdash;all values are final.

Stateful widgets maintain state that might change during the
lifetime of the widget. Implementing a stateful widget requires
at least two classes: 1) a StatefulWidget class that creates an
instance of 2) a State class.
The StatefulWidget class is, itself, immutable,
but the State class persists over the lifetime of the widget.

In this step, we'll change RandomWords to be a stateful widget.
The accompanying State class, _RandomWordsState,
maintains lists of proposed and favorite word pairs.

[PENDING: Realized we need to make sure the final code is final
and have it reviewed by Ian or another SWE.]

<ol markdown="1">

<li markdown="1">
</li>

<li markdown="1">
</li>

<li markdown="1">
</li>

<li markdown="1">
</li>

</ol>
