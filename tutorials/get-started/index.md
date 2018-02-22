---
layout: tutorial
title: Write Your First Flutter App
permalink: /tutorials/get-started/
---

This is a guide to creating your first Flutter app. If you know
how to program, you can complete this tutorial. You don’t need
previous experience with Dart or mobile programming.

* TOC
{:toc}

### What are Flutter and Dart?

_Flutter_ is a mobile app SDK to help developers and designers
build modern mobile apps for iOS and Android.

_Dart_ is an application programming language from Google that's
easy to learn, easy to use, and deployable everywhere.
Flutter apps are written in Dart.

### What you'll build

You’ll implement a simple mobile app that proposes names for a
startup company. The user can select and unselect proposed names,
saving the best ones. The code generates ten names at a time.
As the user scrolls, new batches of names are generated.

<center><img src="images/StartupNameGenerator-screenshot.png" alt="Screenshot for a Startup Name Generator"></center>
<center>[PENDING: Temp image - replace with video]</center><br>

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
* .

</div>

<div class="whats-the-point" markdown="1">

<b> <a id="whats-the-point" class="anchor" href="#whats-the-point" aria-hidden="true"><span class="octicon octicon-link"></span></a>What you'll use:</b>

This tutorial requires version xxx or later of the Flutter SDK.
When you install Flutter, you get the correct version of the
Dart SDK as part of the install. You also get a Flutter Simulator,
which you can use instead of a physical mobile device.

These instructions feature the Android Studio IDE, but you can use whichever
tools you prefer—Flutter and Dart plugins are also available for
VSCode and JetBrains products.

See [Mit's new setup page]() for information on how to set up
your environment and create your first simple Flutter app.

</div>

## Step 1: Create the starting Flutter app

Create a basic Flutter app, using the instructions in
[Mit’s new page, preferably linked to a specific anchor for
creating the templated app]().
Name the project startup_namer. You’ll be modifying this starter
app to create the finished app.

### Update main.dart

You'll update two files during this codelab. In the next step
you'll update the pubspec file, `pubspec.yaml`, which manages
the app's assets.
You'll mostly be editing **lib/main.dart**, where the Dart code lives.

<aside class="alert alert-success" markdown="1">
<i class="fa fa-lightbulb-o"> </i> **Tip:**
When pasting code into your app, indentation can
become skewed. You can fix this in Android Studio by right-clicking the
Dart code and selecting **Reformat Code with dartfmt**.
Or, at the command line, you can use
[dartfmt](https://github.com/dart-lang/dart_style).
</aside>

<ol markdown="1">

<li markdown="1">
Replace all of the code in lib/main.dart with the following,
which displays "Hello World" in the center of the screen.

<!-- skip -->
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
        body: new Center(child: new Text('Hello World')),
      ),
    );
  }
}
{% endprettify %}
</li>

<li markdown="1">
Run the app. You should see the following screen.

<center><img src="images/hello-world-screenshot.png" alt="screenshot of hello world app"></center>
</li>

</ol>

### Observations

<ul markdown="1">
<li markdown="1"> This example creates a Material app.
</li>
<li markdown="1"> The main method specifies fat arrow (`=>`) notation,
     which is short hand used for one-line functions or methods.
</li>
<li markdown="1"> The app extends StatelessWidget which makes the app itself a
     widget. In Flutter, most everything is a widget, including
     alignment, padding, and layout.
</li>
<li markdown="1"> The Scaffold widget, from the Material library,
     provides a default app bar, title, and a body property that
     holds the widget tree for the home screen. The widget subtree
     can be quite complex.
</li>
<li markdown="1"> The widget tree for this example consists of a Center widget
     containing a Text child widget. The Center widget aligns its
     widget subtree to the center of the screen.
</li>

<li markdown="1"> A widget’s main job is to provide a `build` function
    that describes how to display the widget in terms of other,
    lower level widgets.
</li>
<li markdown="1"> Moving the “hello world” text into a separate widget,
    HelloWorld, results in an identical widget tree as the code above.
    (This code is informational only. You are starting with the Hello
    World code above.)

<!-- skip -->
{% prettify dart %}
import 'package: flutter/material.dart';

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
         child: new Text('Hello World')
       ),
     ),
   );
 }
}
{% endprettify %}
</li>
</ul>

---

## Step 2: Use an external package

In this step, you’ll start using an open-source package named
**english_words**, which contains a few thousand of the most used
English words plus some utility functions.

You can find the
[english_words](https://pub.dartlang.org/packages/english_words)
package, as well as many other open source packages, on
[pub.dartlang.org](https://pub.dartlang.org/).

<ol markdown="1">

<li markdown="1">
The pubspec file manages the assets for a Flutter app.
In **pubspec.yaml**, add **english_words** (3.0.1 or higher)
to the dependencies list.
The new line is highlighted below:

<!-- skip -->
{% prettify dart %}
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
While viewing the pubspec in Android Studio's editor view,
click **Packages get** upper right. This pulls the package into
your project. You should see the following in the console:

<!-- skip -->
{% prettify dart %}
flutter packages get
Running "flutter packages get" in startup_namer...
Process finished with exit code 0
{% endprettify %}
</li>

<li markdown="1">
In **lib/main.dart**, add the import for `english_words`, as
shown in the highlighted line:

<!-- skip -->
{% prettify dart %}
import 'package:flutter/material.dart';
[[highlight]]import 'package:english_words/english_words.dart';[[/highlight]]
{% endprettify %}

As you type, Android Studio gives you suggestions for libraries to
import. It then renders the import string in gray, letting you
know that the imported library is unused (so far).
</li>

<li markdown="1">
Use the English words package to generate the text instead of
using the string "Hello World". Add the highlighted lines below:

<!-- skip -->
{% prettify dart %}
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Use the WordPair class in english_words to generate
    // a new word pairing.
    [[highlight]]var wordPair = new WordPair.random();[[/highlight]]

    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: new Center(
          //child: new Text([[highlight]]'Hello World'[[/highlight]]), // Replace the highlighted text...
          child: new Text([[highlight]]wordPair.asPascalCase[[/highlight]]),  // With this highlighted text.
        ),
      ),
    );
  }
}
{% endprettify %}
</li>

<li markdown="1">
If the app is running, use the hot reload button
(<img src="images/hot-reload-button.png" alt="lightning bolt icon">)
to update the running app. Each time you click hot reload,
or save the project, you should see a different word pair,
chosen at random, in the running app.
This is because the word pairing is generated inside the `build`
method, which is run each time the app is hot loaded or saved.
</li>

</ol>

### Problems?

If your app isn't running correctly, look for typos.
If needed, use the following code to get back on track.

The files you edited in this step should now look like this
(minus the comments):

**pubspec.yaml**

<!-- skip -->
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
    var wordPair = new WordPair.random();

    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: new Center(
          child: new Text(wordPair.asPascalCase),
        ),
      ),
    );
  }
}
{% endprettify %}

---

## Step 3: Add a Stateful widget

State<em>less</em> widgets are immutable, meaning that their
properties can’t change&mdash;all values are final.

State<em>ful</em> widgets maintain state that might change
during the lifetime of the widget. Implementing a stateful
widget requires at least two classes: 1) a StatefulWidget class
that creates an instance of 2) a State class. The StatefulWidget
class is, itself, immutable, but the State class persists over the
lifetime of the widget.

In this step, you’ll add a stateful widget, RandomWords, which creates
its State class, RandomWordsState. The State class will eventually
maintain the proposed and favorite word pairs for the widget.

<ol markdown="1">
<li markdown="1">
Add the stateful RandomWords widget to main.dart. It can go
anywhere in the file, outside of MyApp, but the solution places
it at the bottom of the file. The RandomWords widget does little
else besides creating its State class:

<!-- skip -->
{% prettify dart %}
class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}
{% endprettify %}
</li>

<li markdown="1">
Add the RandomWordsState class. Most of the
app’s code resides in this class, which maintains the state for the
RandomWords widget. This class will save the generated word pairs,
which grow infinitely as the user scrolls, and also favorite
word pairs, as the user adds or removes them from the list by
toggling the heart icon.

You’ll build this class bit by bit. To begin, create a minimal
class by adding the highlighted text:

<!-- skip -->
{% prettify dart %}
class RandomWordsState extends State<RandomWords> {
}
{% endprettify %}
</li>

<li markdown="1">
After adding the state class, the IDE complains that the class is
missing a `build` function. Next, you'll add a basic
build function that generates the word pairs by moving the
word generation code from MyApp to RandomWordsState.

Add the `build` function to RandomWordState, as shown
by the highlighted text:

<!-- skip -->
{% prettify dart %}
class RandomWordsState extends State<RandomWords> {
  [[highlight]]@override[[/highlight]]
  [[highlight]]Widget build(BuildContext context) {[[/highlight]]
    [[highlight]]var wordPair = new WordPair.random();[[/highlight]]
    [[highlight]]return(new Text(wordPair.asPascalCase));[[/highlight]]
  }
{% endprettify %}
</li>

<li markdown="1">
Remove the word generation code from MyApp by making the highlighted
changes below:

<!-- skip -->
{% prettify dart %}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    [[strike]]var wordPair = new WordPair.random();[[/strike]]  // Delete this line

    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
       ),
        body: new Center(
          //child: new [[highlight]]Text(wordPair.asPascalCase)[[/highlight]] // Change the highlighted text to...
          child: new [[highlight]]RandomWords()[[/highlight]] // ... this highlighted text
        ),
      ),
    );
  }
}
{% endprettify %}
</li>

</ol>

Run the app. It should behave as before, displaying a word
pairing each time you hot reload or save the app.

### Problems?

If your app isn't running correctly, you can use the code
below to get back on track.

The **pubspec.yaml** file won't change again.
The **lib/main.dart** file should now look like this:

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
          child: new RandomWords()
        ),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    var wordPair = new WordPair.random();
    return(new Text(wordPair.asPascalCase));
  }
}
{% endprettify %}

---

## Step 4: Create a ListView containing the word pairings

In this step, you'll expand RandomWordsState to generate
and display a list of word pairings. As the user scrolls, the list
displayed in a ListView widget, grows infinitely. ListView's
`builder` factory constructor allows you to build a list view
lazily, on demand.

<ol markdown="1">

<li markdown="1"> Add a `_suggestions` list to the RandomWordsState
class for saving suggested word pairings. Note that the variable begins
with an underscore (`_`).  Prefixing an identifier with an underscore enforces
privacy in the Dart language.

<!-- skip -->
{% prettify dart %}
class RandomWordsState extends State<RandomWords> {
  [[highlight]]final _suggestions = <WordPair>[];[[/highlight]]
  ...
}
{% endprettify %}
</li>

<li markdown="1"> Add a `_buildSuggestions()` function to the RandomWordsState
class. This function grabs word pairings in batches of 10 and
displays them in the ListView.

The ListView class provides a builder property, `itemBuilder`, where the rows
are built inside an anonymous function. Two parameters are passed to
the function, the BuildContext, and the row iterator.

<!-- skip -->
{% prettify dart %}
class RandomWordsState extends State<RandomWords> {
  ...
  [[highlight]]Widget _buildSuggestions() {[[/highlight]]
    [[highlight]]return new ListView.builder([[/highlight]]
      [[highlight]]padding: const EdgeInsets.all(16.0),[[/highlight]]
      [[highlight]]itemBuilder: (context, i) {[[/highlight]]
        [[highlight]]if (i.isOdd) return new Divider();[[/highlight]]

        [[highlight]]final index = i ~/ 2;[[/highlight]]
        [[highlight]]if (index >= _suggestions.length) {[[/highlight]]
          [[highlight]]_suggestions.addAll(generateWordPairs().take(10));[[/highlight]]
        [[highlight]]}[[/highlight]]
        [[highlight]]return _buildRow(_suggestions[index]);[[/highlight]]
      [[highlight]]}[[/highlight]]
    [[highlight]]);[[/highlight]]
  [[highlight]]}[[/highlight]]
}
{% endprettify %}
</li>

<li markdown="1"> The `_buildSuggestions` function calls `_buildRow`, once per
word pair. This function displays each new pair using a ListTile,
which allows you to make the rows more attractive in the next step.

Add a `_buildRow` function:

<!-- skip -->
{% prettify dart %}
class RandomWordsState extends State<RandomWords> {
  ...

  [[highlight]]Widget _buildRow(WordPair pair) {[[/highlight]]
    [[highlight]]return new ListTile([[/highlight]]
      [[highlight]]title: new Text([[/highlight]]
        [[highlight]]pair.asPascalCase,[[/highlight]]
        [[highlight]]style: _biggerFont,[[/highlight]]
      [[highlight]])[[/highlight]]
    [[highlight]]);[[/highlight]]
  [[highlight]]}[[/highlight]]
}
{% endprettify %}
</li>

<li markdown="1"> Add a `biggerFont` variable for making the font size larger:

<!-- skip -->
{% prettify dart %}
class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];

  [[highlight]]final TextStyle _biggerFont = new TextStyle(fontSize: 18.0);[[/highlight]]
  ...
}
{% endprettify %}
</li>

<li markdown="1"> Update the `build` function for RandomWordsState to use
`_buildSuggestions`, rather than directly calling the word
generation library. Make the highlighted changes:

<!-- skip -->
{% prettify dart %}
class RandomWordsState extends State<RandomWords> {
  ...
  @override
  Widget build(BuildContext context) {
    [[strike]]var wordPair = new WordPair.random();[[/strike]] // Delete these two lines.
    [[strike]]Return(new Text(wordPair.asPascalCase));[[/strike]]
    [[highlight]]return new Scaffold ([[/highlight]]
      [[highlight]]appBar: new AppBar([[/highlight]]
        [[highlight]]title: new Text('Startup Name Generator'),[[/highlight]]
      [[highlight]]),[[/highlight]]
    [[highlight]]body: _buildSuggestions(),[[/highlight]]
    [[highlight]]);[[/highlight]]
  }
  ...
}
{% endprettify %}
</li>

<li markdown="1">
Update the `build` function for MyApp. Replace the contents of the
build method with the following highlighted code. This removes the
Scaffold and AppBar instances from MyApp. These are now managed
by RandomWordsState and make it possible to navigate from one screen
to another in the next step.

Make the changes as shown below:

<!-- skip -->
{% prettify dart %}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    [[highlight]]return new MaterialApp([[/highlight]]
      [[highlight]]title: 'Startup Name Generator',[[/highlight]]
      [[highlight]]home: new RandomWords(),[[/highlight]]
    );
  }
}
{% endprettify %}
</li>

</ol>

Run the app. You should see a list of word pairings. Scroll down
as far as you want and you will continue to see new word pairings.

### Problems?

If you've gotten off track, you can use the following
**lib/main.dart** code to get back on track.

{% prettify dart %}
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      home: new RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];

  final TextStyle _biggerFont = new TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return new ListTile(
        title: new Text(
      pair.asPascalCase,
      style: _biggerFont,
    ));
  }
}
{% endprettify %}

---

## Step 5: Save favorite word pairings

In this step, you'll add tappable heart icons to each row.
When the user taps an entry in the list, toggling its
"favorited" state, that word pairing is added or removed from a
set of saved favorites.

<!--
- Add ability to save favorites (in state class)
- Add navigation to view saved word pairings
-->

<ol markdown="1">
<li markdown="1"> Add a `_saved` Set to RandomWordsState. This Set stores
    the word pairings that the user favorited. A Set is used instead of a List
    because a Set typically doesn't allow duplicates, if it's implemented not to
    do so.

<!-- skip -->
{% prettify dart %}
class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];

  [[highlight]]final _saved = new Set<WordPair>();[[/highlight]]

  final TextStyle _biggerFont = new TextStyle(fontSize: 18.0);
  ...
}
{% endprettify %}
</li>

<li markdown="1">
In the `_buildRow` function, add `alreadySaved`, a check to ensure that
a word pairing hasn't already been added to favorites.

<!-- skip -->
{% prettify dart %}
  Widget _buildRow(WordPair pair) {
    [[highlight]]final alreadySaved = _saved.contains(pair);[[/highlight]]
    ...
  }
{% endprettify %}
</li>

<li markdown="1">
Also in `_buildRow`, add heart-shaped icons to the ListTiles to enable
favoriting. Display favorite entries with a solid red heart,
and other entries with a heart-shaped outline.

Make the highlighted changes below:

<!-- skip -->
{% prettify dart %}
  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
        title: new Text(
          pair.asPascalCase,
          style: _biggerFont,
        [[highlight]]),[[/highlight]]  // Replace the "));" with this.
        [[highlight]]trailing: new Icon([[/highlight]] // Add this line, plus the next 3 lines.
          [[highlight]]alreadySaved ? Icons.favorite : Icons.favorite_border,[[/highlight]]
          [[highlight]]color: alreadySaved ? Colors.red : null,[[/highlight]]
        [[highlight]]));[[/highlight]]
  }
}
{% endprettify %}
</li>

<li markdown="1">
Run the app. You should now see open hearts on each row, but they aren't yet
interactive.
</li>

<li markdown="1"> Make the hearts tappable in the `_buildRow` function.
If a word entry has already been added to favorites, tapping it again
removes it from favorites. When the heart has been tapped, the function
calls `setState()`. Calling this method signals the build system that
state has changed and that the state needs updating.

Make the highlighted changes:

<!-- skip -->
{% prettify dart %}
  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
        title: new Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        trailing: new Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
        [[highlight]]),[[/highlight]] // Replace the "))," with "),"
        [[highlight]]onTap: () {[[/highlight]] //Add this and the remaining highlighted lines.
          [[highlight]]setState(() {[[/highlight]]
            [[highlight]]if (alreadySaved) {[[/highlight]]
              [[highlight]]_saved.remove(pair);[[/highlight]]
            [[highlight]]} else {[[/highlight]]
              [[highlight]]_saved.add(pair);[[/highlight]]
            [[highlight]]}[[/highlight]]
          [[highlight]]});[[/highlight]]
        [[highlight]]});[[/highlight]]
  }
{% endprettify %}
</li>
</ol>

Run the app. You should be able to tap the hearts to favorite, or unfavorite,
the entries.

### Problems?

If you've gotten off track, you can use the following
**lib/main.dart** code to get back on track.

{% prettify dart %}
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      home: new RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];

  final _saved = new Set<WordPair>();

  final TextStyle _biggerFont = new TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
        title: new Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        trailing: new Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
        ),
        onTap: () {
          setState(() {
            if (alreadySaved) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          });
        });
  }
}
{% endprettify %}

---

## Step 6: Navigate to a new screen

In this step, you'll add a new screen (called a _route_ in Flutter) that
displays the favorites. You'll learn how to navigate between the home route
and the new route. Finally, you'll add a Theme to the app's UI.

In Flutter, the Navigator manages a stack containing the app's routes.
Pushing a route onto the Navigator's stack, updates the display to that route.
Popping a route from the Navigator's stack, returns the display to the previous
route.

<ol markdown="1">
<li markdown="1">
Add a list icon to the AppBar in the `build` method for RandomWordsState.
When the user clicks the list icon, a new
route that contains the favorites items is pushed to the Navigator, displaying the
new list.

Note that the `actions` property takes an array of widgets. Some properties
take a single widget (`child`), and other properties take multiple widgets
(`children`), as indicated by the square brackets (`[]`).

Add the highlighted "action" code to the build method:

<!-- skip -->
{% prettify dart %}
class RandomWordsState extends State<RandomWords> {
  ...
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
        [[highlight]]actions: <Widget>[[[/highlight]]
          [[highlight]]new IconButton([[/highlight]]
            [[highlight]]icon: new Icon(Icons.list),[[/highlight]]
            [[highlight]]onPressed: _pushSaved[[/highlight]]
          [[highlight]])[[/highlight]]
        [[highlight]]][[/highlight]]
      ),
      body: _buildSuggestions(),
    );
  }
  ...
}
{% endprettify %}
</li>

<li markdown="1">
Add a `_pushSaved()` function to the RandomWordsState class.

<!-- skip -->
{% prettify dart %}
class RandomWordsState extends State<RandomWords> {
  ...
  void _pushSaved() {
  }
}
{% endprettify %}

Run the app. The list icon appears in the app bar. Tapping it does nothing
yet, because the `_pushSaved` function is empty.
</li>

<li markdown="1">
When the user taps the list icon in the app bar, build a Material route
and push it to the Navigator's stack. This action changes the screen to
display the new route.

The content for the new page is built in MaterialPageRoute's `builder`
property, in an anonymous function.

Add the call to Navigator.push, as shown by the highlighted code,
which pushes the route to the Navigator's stack.

<!-- skip -->
{% prettify dart %}
  void _pushSaved() {
    [[highlight]]Navigator.of(context).push([[/highlight]]
      [[highlight]]);[[/highlight]]
  }
{% endprettify %}
</li>

<li markdown="1">
Add the MaterialPageRoute and its builder. For now, add the code that
generates the ListTile rows. The `divideTiles()` function of ListTile
adds horizontal spacing between each ListTile. The `divided` variable
holds the final rows, converted to a list by the convienice function, `toList()`.

<!-- skip -->
{% prettify dart %}
  void _pushSaved() {
    Navigator.of(context).push([[/highlight]]
      [[highlight]]new MaterialPageRoute([[/highlight]]
        [[highlight]]builder: (context) {[[/highlight]]
          [[highlight]]final tiles = _saved.map((pair) {[[/highlight]]
            [[highlight]]return new ListTile([[/highlight]]
                [[highlight]]title: new Text([[/highlight]]
                  [[highlight]]pair.asPascalCase,[[/highlight]]
                  [[highlight]]style: _biggerFont,[[/highlight]]
                [[highlight]]));[[/highlight]]
          [[highlight]]});[[/highlight]]
          [[highlight]]final divided = ListTile[[/highlight]]
              [[highlight]].divideTiles([[/highlight]]
            [[highlight]]context: context,[[/highlight]]
            [[highlight]]tiles: tiles,[[/highlight]]
          [[highlight]])[[/highlight]]
              [[highlight]].toList();[[/highlight]]

        [[highlight]]},[[/highlight]]
      [[highlight]]),[[/highlight]]
    );
  }
}
{% endprettify %}
</li>

<li markdown="1">
The builder function returns a Scaffold. From the Material library,
this widget provides an app bar for the new route with the name,
"Saved Suggestions". The body consists of a ListView with the
ListTiles.

Add the highlisted text below:

<!-- skip -->
{% prettify dart %}
  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map((pair) {
            return new ListTile(
                title: new Text(
              pair.asPascalCase,
              style: _biggerFont,
            ));
          });
          final divided = ListTile
              .divideTiles(
                context: context,
                tiles: tiles,
              )
              .toList();

          [[highlight]]return new Scaffold([[/highlight]]
            [[highlight]]appBar: new AppBar([[/highlight]]
              [[highlight]]title: new Text('Saved suggestions'),[[/highlight]]
            [[highlight]]),[[/highlight]]
            [[highlight]]body: new ListView(children: divided),[[/highlight]]
          [[highlight]]);[[/highlight]]
        },
      ),
    );
  }
{% endprettify %}
</li>

<li markdown="1">
Run the app. Favorite some of the selections and tap the list icon in
the app bar. The new route appears containing the favorites. Note that the
Navigator adds a "Back" button to the app bar. You didn't have to explicitly
implement Navigator.pop. Tap the back button to return to the home route.
</li>

<li markdown="1">
You can easily change an app's theme by configuring the ThemeData class.
Our app uses the default Theme, but you can use themes to make the app
reflect your branding.

You'll set the primary color of your theme to be white, but you can play
with this feature to test other themes.

Add the following code to MyApp:

<!-- skip -->
{% prettify dart %}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      [[highlight]]theme: new ThemeData([[/highlight]]
        [[highlight]]primaryColor: Colors.white,[[/highlight]]
      [[highlight]]),[[/highlight]]
      home: new RandomWords(),
    );
  }
}
{% endprettify %}
</li>

<li markdown="1">
Run the app. You'll notice that the background is white, even the app bar.
</li>
</ol>

### Problems?

If you've gotten off track, use the following code for
**lib/main.dart** to get back on track.

{% prettify dart %}
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: new RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];

  final _saved = new Set<WordPair>();

  final TextStyle _biggerFont = new TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text('Startup Name Generator'),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
          ]),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
        title: new Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        trailing: new Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
        ),
        onTap: () {
          setState(() {
            if (alreadySaved) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          });
        });
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map((pair) {
            return new ListTile(
                title: new Text(
              pair.asPascalCase,
              style: _biggerFont,
            ));
          });
          final divided = ListTile
              .divideTiles(
                context: context,
                tiles: tiles,
              )
              .toList();

          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Saved suggestions'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }
}
{% endprettify %}

---

## Well done!

You've written a Flutter app that uses Material Design widgets.  You've edited
a pubspec file to pull in a third party library and leveraged the library
in your code. You've written Dart code. xxx [PENDING]



Here are some resources you might find useful:

{% comment %}
Once the cookbook and the "Flutter for React" docs (etc) are done, add here.
{% endcomment %}

* [Flutter API docs](https://docs.flutter.io/)
* [Building Layouts in Flutter](https://flutter.io/tutorials/layout/) tutorial
* [Add Interactivity](https://flutter.io/tutorials/interactive/) tutorial
* [From Java to Dart](https://codelabs.developers.google.com/codelabs/from-java-to-dart/#0) codelab

You can learn more about Flutter at [flutter.io,](https://flutter.io/)
and Dart at [www.dartlang.org.](https://www.dartlang.org/)
