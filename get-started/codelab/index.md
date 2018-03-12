---
layout: tutorial
title: Write Your First Flutter App
permalink: /get-started/codelab/
---

<figure class="right-figure" style="max-width: 260px; padding-right: 10px">
    <img src="images/startup-namer-app.gif"
         alt="Animated GIF of the app that you will be building."
         style="border: 10px solid #333; border-radius: 10px; margin-bottom: 10px" >
</figure>

This is a guide to creating your first Flutter app. If you
are familiar with object-oriented code and basic programming
concepts such as variables, loops, and conditionals,
you can complete this tutorial. You don’t need
previous experience with Dart or mobile programming.

{% comment %}
TODO: (maybe, but later)
- Retake screenshots on the Android emulator? (Tao)
  Maybe alternate between Android and iOS emulators?
- Somehow cross link from code to text so people can restart
  and find their place more easily? (Tao)
{% endcomment %}

* TOC
{:toc}

<p class="h2-like">What you'll build</p>

You’ll implement a simple mobile app that generates proposed names for a
startup company. The user can select and unselect names,
saving the best ones. The code generates ten names at a time.
As the user scrolls, new batches of names are generated.
The user can tap the list icon in the upper right of the app bar
to move to a new route that lists only the favorited names.

The animated GIF shows how the finished app works.

<div class="whats-the-point" markdown="1">

<b> <a id="whats-the-point" class="anchor" href="#whats-the-point" aria-hidden="true"><span class="octicon octicon-link"></span></a>What you'll learn:</b>

* Basic structure of a Flutter app.
* Finding and using packages to extend functionality.
* Using hot reload for a quicker development cycle.
* How to implement a stateful widget.
* How to create an infinite, lazily loaded list.
* How to create and navigate to a second screen.
* How to change the look of an app using Themes.

</div>

<div class="whats-the-point" markdown="1">

<b> <a id="whats-the-point" class="anchor" href="#whats-the-point" aria-hidden="true"><span class="octicon octicon-link"></span></a>What you'll use:</b>

You'll need to install the following:

<ul markdown="1">
<li markdown="1"> Flutter SDK<br>
    The Flutter SDK includes Flutter's engine, framework, widgets, tools,
    and a Dart SDK. This codelab requires v0.1.4 or later.
</li>
<li markdown="1"> Android Studio IDE<br>
    This codelab features the Android Studio IDE, but you can use
    another IDE, or work from the command line.
</li>
<li markdown="1"> Plugin for your IDE<br>
    The Flutter and Dart plugins must be installed separately for your
    IDE. Besides Android Studio, Flutter and Dart plugins are also available
    for the [VS Code](https://code.visualstudio.com/download) and
    [IntelliJ](https://www.jetbrains.com/idea/download/#section=mac) IDEs.
</li>
</ul>

See [Flutter Installation and Setup](/get-started/install/) for information on
how to set up your environment.

</div>

# Step 1: Create the starting Flutter app

Create a simple, templated Flutter app, using the instructions in
[Getting Started with your first Flutter app.](/get-started/test-drive/#create-app)
Name the project **startup_namer** (instead of _myapp_).
You’ll be modifying this starter app to create the finished app.

In this codelab, you'll mostly be editing **lib/main.dart**,
where the Dart code lives.

<aside class="alert alert-success" markdown="1">
<i class="fa fa-lightbulb-o"> </i> **Tip:**
When pasting code into your app, indentation can
become skewed. You can fix this automatically with the Flutter tools:

* Android Studio / IntelliJ IDEA: Right-click the dart code and
  select **Reformat Code with dartfmt**.
* VS Code: Right-click and select **Format Document**.
* Terminal: Run `flutter format <filename>`.
</aside>

<ol markdown="1">

<li markdown="1"> Replace lib/main.dart.<br>
    Delete all of the code from **lib/main.dart**.
    Replace with the following code, which displays "Hello World" in the center
    of the screen.

{% prettify dart %}
import 'package:flutter/material.dart';

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
          child: new Text('Hello World'),
        ),
      ),
    );
  }
}
{% endprettify %}
</li>

<li markdown="1"> Run the app. You should see the following screen.

<center><img src="images/hello-world-screenshot.png" alt="screenshot of hello world app"></center>
</li>
</ol>

<p class="h2-like">Observations</p>

  <ul markdown="1">
  <li markdown="1"> This example creates a Material app.
      [Material](https://material.io/guidelines/) is a visual design language
      that is standard on mobile and the web. Flutter offers a rich set
      of Material widgets.
  </li>
  <li markdown="1"> The main method specifies fat arrow (`=>`) notation,
       which is short hand used for one-line functions or methods.
  </li>
  <li markdown="1"> The app extends StatelessWidget which makes the app itself a
       widget. In Flutter, almost everything is a widget, including
       alignment, padding, and layout.
  </li>
  <li markdown="1"> The Scaffold widget, from the Material library,
       provides a default app bar, title, and a body property that
       holds the widget tree for the home screen. The widget subtree
       can be quite complex.
  </li>
  <li markdown="1"> A widget’s main job is to provide a `build()` method
      that describes how to display the widget in terms of other,
      lower level widgets.
  </li>
  <li markdown="1"> The widget tree for this example consists of a Center widget
       containing a Text child widget. The Center widget aligns its
       widget subtree to the center of the screen.
  </li>
</ul>
{% comment %}
  Removing this for now. A) It might be confusing and B) the code as shown here is wrong.
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

  Update with this code:

  class HelloWorld extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return new Center(
       child: new Text('Hello World'),
     );
   }
  }
  </li>
{% endcomment %}

---

# Step 2: Use an external package

In this step, you’ll start using an open-source package named
**english_words**, which contains a few thousand of the most used
English words plus some utility functions.

You can find the
[english_words](https://pub.dartlang.org/packages/english_words)
package, as well as many other open source packages, on
[pub.dartlang.org](https://pub.dartlang.org/flutter/).

<ol markdown="1">

<li markdown="1"> The pubspec file manages the assets for a Flutter app.
    In **pubspec.yaml**, add **english_words** (3.1.0 or higher)
    to the dependencies list.
    The new line is highlighted below:

<!-- skip -->
{% prettify dart %}
dependencies:
  flutter:
    sdk: flutter

  cupertino_icons: ^0.1.0
  [[highlight]]english_words: ^3.1.0[[/highlight]]
{% endprettify %}
</li>

<li markdown="1"> While viewing the pubspec in Android Studio's editor view,
    click **Packages get** upper right. This pulls the package into
    your project. You should see the following in the console:

<!-- skip -->
{% prettify dart %}
flutter packages get
Running "flutter packages get" in startup_namer...
Process finished with exit code 0
{% endprettify %}
</li>

<li markdown="1"> In **lib/main.dart**, add the import for `english_words`,
    as shown in the highlighted line:

<!-- skip -->
{% prettify dart %}
import 'package:flutter/material.dart';
[[highlight]]import 'package:english_words/english_words.dart';[[/highlight]]
{% endprettify %}

As you type, Android Studio gives you suggestions for libraries to
import. It then renders the import string in gray, letting you
know that the imported library is unused (so far).
</li>

<li markdown="1"> Use the English words package to generate the text instead of
    using the string "Hello World".

<aside class="alert alert-success" markdown="1">
<i class="fa fa-lightbulb-o"> </i> **Tip:**
"Pascal case" (also known as "upper camel case"),
means that each word in the string, including the first one,
begins with an uppercase letter. So, "uppercamelcase" becomes
"UpperCamelCase".
</aside>

Make the following changes, as highlighted below:

<!-- skip -->
{% prettify dart %}
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    [[highlight]]final wordPair = new WordPair.random();[[/highlight]]
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

<li markdown="1"> If the app is running, use the hot reload button
    (<img src="images/hot-reload-button.png" alt="lightning bolt icon">)
    to update the running app. Each time you click hot reload,
    or save the project, you should see a different word pair,
    chosen at random, in the running app.
    This is because the word pairing is generated inside the build
    method, which is run each time the MaterialApp requires rendering,
    or when toggling the Platform in Flutter Inspector.

<center><img src="images/step2-screenshot.png" alt="screenshot at completion of second step"></center>
</li>

</ol>

<p class="h2-like">Problems?</p>

If your app is not running correctly, look for typos. If needed,
use the code at the following links to get back on track.

* [**pubspec.yaml**](https://gist.githubusercontent.com/Sfshaza/bb51e3b7df4ebbf3dfd02a4a38db2655/raw/57c25b976ec34d56591cb898a3df0b320e903b99/pubspec.yaml)
(The **pubspec.yaml** file won't change again.)
* [**lib/main.dart**](https://gist.githubusercontent.com/Sfshaza/bb51e3b7df4ebbf3dfd02a4a38db2655/raw/57c25b976ec34d56591cb898a3df0b320e903b99/main.dart)

---

# Step 3: Add a Stateful widget

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
<li markdown="1"> Add the stateful RandomWords widget to main.dart.
    It can go anywhere in the file, outside of MyApp, but the solution
    places it at the bottom of the file. The RandomWords widget does little
    else besides creating its State class:

<!-- skip -->
{% prettify dart %}
class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}
{% endprettify %}
</li>

<li markdown="1"> Add the RandomWordsState class. Most of the
    app’s code resides in this class, which maintains the state for the
    RandomWords widget. This class will save the generated word pairs,
    which grow infinitely as the user scrolls, and also favorite
    word pairs, as the user adds or removes them from the list by
    toggling the heart icon.

You’ll build this class bit by bit. To begin, create a minimal
class by adding the highlighted text:

<!-- skip -->
{% prettify dart %}
[[highlight]]class RandomWordsState extends State<RandomWords> {[[/highlight]]
[[highlight]]}[[/highlight]]
{% endprettify %}
</li>

<li markdown="1"> After adding the state class, the IDE complains that
    the class is missing a build method. Next, you'll add a basic
    build method that generates the word pairs by moving the
    word generation code from MyApp to RandomWordsState.

Add the build method to RandomWordState, as shown
by the highlighted text:

<!-- skip -->
{% prettify dart %}
class RandomWordsState extends State<RandomWords> {
  [[highlight]]@override[[/highlight]]
  [[highlight]]Widget build(BuildContext context) {[[/highlight]]
    [[highlight]]final wordPair = new WordPair.random();[[/highlight]]
    [[highlight]]return new Text(wordPair.asPascalCase);[[/highlight]]
  [[highlight]]}[[/highlight]]
}
{% endprettify %}
</li>

<li markdown="1"> Remove the word generation code from MyApp by making
    the highlighted changes below:

<!-- skip -->
{% prettify dart %}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    [[strike]]final wordPair = new WordPair.random();[[/strike]]  // Delete this line

    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: new Center(
          //child: new [[highlight]]Text(wordPair.asPascalCase),[[/highlight]] // Change the highlighted text to...
          child: new [[highlight]]RandomWords(),[[/highlight]] // ... this highlighted text
        ),
      ),
    );
  }
}
{% endprettify %}
</li>

</ol>

Restart the app. If you try to hot reload, you might see a warning:

{% prettify sh %}
Reloading...
Not all changed program elements ran during view reassembly; consider
restarting.
{% endprettify %}

It may be a false positive, but consider restarting in order to make sure
that your changes are reflected in the app's UI.

The app should behave as before, displaying a word
pairing each time you hot reload or save the app.

<center><img src="images/step3-screenshot.png" alt="screenshot at completion of third step"></center>

<p class="h2-like">Problems?</p>

If your app is not running correctly, you can use the code
at the following link to get back on track.

* [**lib/main.dart**](https://gist.githubusercontent.com/Sfshaza/d7f13ddd8888556232476be8578efe40/raw/329c397b97309ce99f834bf70ebb90778baa5cfe/main.dart)

---

# Step 4: Create an infinite scrolling ListView

In this step, you'll expand RandomWordsState to generate
and display a list of word pairings. As the user scrolls, the list
displayed in a ListView widget, grows infinitely. ListView's
`builder` factory constructor allows you to build a list view
lazily, on demand.

<ol markdown="1">

<li markdown="1"> Add a `_suggestions` list to the RandomWordsState
class for saving suggested word pairings. The variable begins with
an underscore (`_`)&mdash;prefixing an identifier with an underscore enforces
privacy in the Dart language.

Also, add a `biggerFont` variable for making the font size larger.

<!-- skip -->
{% prettify dart %}
class RandomWordsState extends State<RandomWords> {
  [[highlight]]final _suggestions = <WordPair>[];[[/highlight]]

  [[highlight]]final _biggerFont = const TextStyle(fontSize: 18.0);[[/highlight]]
  ...
}
{% endprettify %}
</li>

<li markdown="1"> Add a `_buildSuggestions()` function to the RandomWordsState
class. This method builds the ListView that displays the suggested word
pairing.

The ListView class provides a builder property, `itemBuilder`,
a factory builder and callback function specified as an anonymous function.
Two parameters are passed to the function&mdash;the BuildContext,
and the row iterator, `i`. The iterator begins at 0 and increments
each time the function is called, once for every suggested word pairing.
This model allows the suggested list to grow infinitely as the user scrolls.

Add the highlighted lines below:

<!-- skip -->
{% prettify dart %}
class RandomWordsState extends State<RandomWords> {
  ...
  [[highlight]]Widget _buildSuggestions() {[[/highlight]]
    [[highlight]]return new ListView.builder([[/highlight]]
      [[highlight]]padding: const EdgeInsets.all(16.0),[[/highlight]]
      // The itemBuilder callback is called once per suggested word pairing,
      // and places each suggestion into a ListTile row.
      // For even rows, the function adds a ListTile row for the word pairing.
      // For odd rows, the function adds a Divider widget to visually
      // separate the entries. Note that the divider may be difficult
      // to see on smaller devices.
      [[highlight]]itemBuilder: (context, i) {[[/highlight]]
        // Add a one-pixel-high divider widget before each row in theListView.
        [[highlight]]if (i.isOdd) return new Divider();[[/highlight]]

        // The syntax "i ~/ 2" divides i by 2 and returns an integer result.
        // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
        // This calculates the actual number of word pairings in the ListView,
        // minus the divider widgets.
        [[highlight]]final index = i ~/ 2;[[/highlight]]
        // If you've reached the end of the available word pairings...
        [[highlight]]if (index >= _suggestions.length) {[[/highlight]]
          // ...then generate 10 more and add them to the suggestions list.
          [[highlight]]_suggestions.addAll(generateWordPairs().take(10));[[/highlight]]
        [[highlight]]}[[/highlight]]
        [[highlight]]return _buildRow(_suggestions[index]);[[/highlight]]
      [[highlight]]}[[/highlight]]
    [[highlight]]);[[/highlight]]
  [[highlight]]}[[/highlight]]
}
{% endprettify %}
</li>

<li markdown="1"> The `_buildSuggestions` function calls `_buildRow` once per
word pair. This function displays each new pair in a ListTile,
which allows you to make the rows more attractive in the next step.

Add a `_buildRow` function to RandomWordsState:

<!-- skip -->
{% prettify dart %}
class RandomWordsState extends State<RandomWords> {
  ...

  [[highlight]]Widget _buildRow(WordPair pair) {[[/highlight]]
    [[highlight]]return new ListTile([[/highlight]]
      [[highlight]]title: new Text([[/highlight]]
        [[highlight]]pair.asPascalCase,[[/highlight]]
        [[highlight]]style: _biggerFont,[[/highlight]]
      [[highlight]]),[[/highlight]]
    [[highlight]]);[[/highlight]]
  [[highlight]]}[[/highlight]]
}
{% endprettify %}
</li>

<li markdown="1"> Update the build method for RandomWordsState to use
`_buildSuggestions()`, rather than directly calling the word
generation library. Make the highlighted changes:

<!-- skip -->
{% prettify dart %}
class RandomWordsState extends State<RandomWords> {
  ...
  @override
  Widget build(BuildContext context) {
    [[strike]]final wordPair = new WordPair.random();[[/strike]] // Delete these two lines.
    [[strike]]return new Text(wordPair.asPascalCase);[[/strike]]
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

<li markdown="1"> Update the build method for MyApp.
    Remove the Scaffold and AppBar instances from MyApp.
    These will be managed by RandomWordsState, which makes it easier to
    change the name of the route in the app bar as the user
    navigates from one screen to another in the next step.

Replace the original method with the highlighted build method below:

<!-- skip -->
{% prettify dart %}
class MyApp extends StatelessWidget {
  @override
  [[highlight]]Widget build(BuildContext context) {[[/highlight]]
    [[highlight]]return new MaterialApp([[/highlight]]
      [[highlight]]title: 'Startup Name Generator',[[/highlight]]
      [[highlight]]home: new RandomWords(),[[/highlight]]
    [[highlight]]);[[/highlight]]
  [[highlight]]}[[/highlight]]
}
{% endprettify %}
</li>

</ol>

Restart the app. You should see a list of word pairings. Scroll down
as far as you want and you will continue to see new word pairings.

<center><img src="images/step4-screenshot.png" alt="screenshot at completion of fourth step"></center>

<p class="h2-like">Problems?</p>

If your app is not running correctly, you can use the code
at the following link to get back on track.

* [**lib/main.dart**](https://gist.githubusercontent.com/Sfshaza/d6f9460a04d3a429eb6ac0b0f07da564/raw/34fe240f4122435c871bb737708ee0357741801c/main.dart)

---

# Step 5: Add interactivity

In this step, you'll add tappable heart icons to each row.
When the user taps an entry in the list, toggling its
"favorited" state, that word pairing is added or removed from a
set of saved favorites.

<ol markdown="1">
<li markdown="1"> Add a `_saved` Set to RandomWordsState. This Set stores
    the word pairings that the user favorited. Set is preferred to List
    because a properly implemented Set does not allow duplicate entries.

<!-- skip -->
{% prettify dart %}
class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];

  [[highlight]]final _saved = new Set<WordPair>();[[/highlight]]

  final _biggerFont = const TextStyle(fontSize: 18.0);
  ...
}
{% endprettify %}
</li>

<li markdown="1"> In the `_buildRow` function, add an `alreadySaved`
    check to ensure that a word pairing has not already been added to
    favorites.

<!-- skip -->
{% prettify dart %}
  Widget _buildRow(WordPair pair) {
    [[highlight]]final alreadySaved = _saved.contains(pair);[[/highlight]]
    ...
  }
{% endprettify %}
</li>

<li markdown="1"> Also in `_buildRow()`, add heart-shaped icons to the
    ListTiles to enable favoriting. Later, you'll add the ability to
    interact with the heart icons.

Add the highlighted lines below:

<!-- skip -->
{% prettify dart %}
  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      [[highlight]]trailing: new Icon([[/highlight]]
        [[highlight]]alreadySaved ? Icons.favorite : Icons.favorite_border,[[/highlight]]
        [[highlight]]color: alreadySaved ? Colors.red : null,[[/highlight]]
      [[highlight]]),[[/highlight]]
    );
  }
{% endprettify %}
</li>

<li markdown="1"> Restart the app. You should now see open hearts on
    each row, but they are not yet interactive.
</li>

<li markdown="1"> Make the hearts tappable in the `_buildRow`
    function. If a word entry has already been added to favorites,
    tapping it again removes it from favorites.
    When the heart has been tapped, the function calls
    `setState()` to notify the framework that state has changed.

Add the highlighted lines:

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
      ),
      [[highlight]]onTap: () {[[/highlight]]
        [[highlight]]setState(() {[[/highlight]]
          [[highlight]]if (alreadySaved) {[[/highlight]]
            [[highlight]]_saved.remove(pair);[[/highlight]]
          [[highlight]]} else {[[/highlight]]
            [[highlight]]_saved.add(pair);[[/highlight]]
          [[highlight]]}[[/highlight]]
        [[highlight]]});[[/highlight]]
      [[highlight]]},[[/highlight]]
    );
  }
{% endprettify %}
</li>
</ol>

<aside class="alert alert-success" markdown="1">
<i class="fa fa-lightbulb-o"> </i> **Tip:**
In Flutter's react style framework, calling `setState()` triggers
a call to the `build()` method for the State object, resulting in
an update to the UI.
</aside>

Hot reload the app. You should be able to tap any row to favorite, or unfavorite,
the entry. Note that tapping a row generates an implicit ink splash animation
that emanates from the heart icon.

<center><img src="images/step5-screenshot.png" alt="screenshot at completion of 5th step"></center>

<p class="h2-like">Problems?</p>

If your app is not running correctly, you can use the code
at the following link to get back on track.

* [**lib/main.dart**](https://gist.githubusercontent.com/Sfshaza/936ce0059029a8c6e88aaa826a3789cd/raw/a3065d5c681a81eff32f75a9cd5f4d9a5b24f9ff/main.dart)

---

# Step 6: Navigate to a new screen

In this step, you'll add a new screen (called a _route_ in Flutter) that
displays the favorites. You'll learn how to navigate between the home route
and the new route.

In Flutter, the Navigator manages a stack containing the app's routes.
Pushing a route onto the Navigator's stack, updates the display to that route.
Popping a route from the Navigator's stack, returns the display to the previous
route.

<ol markdown="1">
<li markdown="1"> Add a list icon to the AppBar in the build method
    for RandomWordsState.  When the user clicks the list icon, a new
    route that contains the favorites items is pushed to the Navigator,
    displaying the icon.

<aside class="alert alert-success" markdown="1">
<i class="fa fa-lightbulb-o"> </i> **Tip:**
Some widget properties take a single widget (`child`), and other properties,
such as `action`, take an array of widgets (`children`),
as indicated by the square brackets (`[]`).
</aside>

Add the icon and its corresponding action to the build method:

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
          [[highlight]]new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),[[/highlight]]
        [[highlight]]],[[/highlight]]
      ),
      body: _buildSuggestions(),
    );
  }
  ...
}
{% endprettify %}
</li>

<li markdown="1"> Add a `_pushSaved()` function to the RandomWordsState class.

<!-- skip -->
{% prettify dart %}
class RandomWordsState extends State<RandomWords> {
  ...
  [[highlight]]void _pushSaved() {[[/highlight]]
  [[highlight]]}[[/highlight]]
}
{% endprettify %}

Hot reload the app. The list icon appears in the app bar.
Tapping it does nothing yet, because the `_pushSaved` function is empty.
</li>

<li markdown="1"> When the user taps the list icon in the app bar,
    build a route and push it to the Navigator's stack.
    This action changes the screen to display the new route.

The content for the new page is built in MaterialPageRoute's `builder`
property, in an anonymous function.

Add the call to Navigator.push, as shown by the highlighted code,
which pushes the route to the Navigator's stack.

<!-- skip -->
{% prettify dart %}
  [[highlight]]void _pushSaved() {[[/highlight]]
    [[highlight]]Navigator.of(context).push([[/highlight]]
    [[highlight]]);[[/highlight]]
  [[highlight]]}[[/highlight]]
{% endprettify %}
</li>

<li markdown="1"> Add the MaterialPageRoute and its builder. For now,
    add the code that generates the ListTile rows. The `divideTiles()`
    method of ListTile adds horizontal spacing between each ListTile.
    The `divided` variable holds the final rows, converted to a list
    by the convenience function, `toList()`.

<!-- skip -->
{% prettify dart %}
  void _pushSaved() {
    Navigator.of(context).push(
      [[highlight]]new MaterialPageRoute([[/highlight]]
        [[highlight]]builder: (context) {[[/highlight]]
          [[highlight]]final tiles = _saved.map([[/highlight]]
            [[highlight]](pair) {[[/highlight]]
              [[highlight]]return new ListTile([[/highlight]]
                [[highlight]]title: new Text([[/highlight]]
                  [[highlight]]pair.asPascalCase,[[/highlight]]
                  [[highlight]]style: _biggerFont,[[/highlight]]
                [[highlight]]),[[/highlight]]
              [[highlight]]);[[/highlight]]
            [[highlight]]},[[/highlight]]
          [[highlight]]);[[/highlight]]
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
{% endprettify %}
</li>

<li markdown="1"> The builder property returns a Scaffold,
    containing the app bar for the new route, named
    "Saved Suggestions." The body of the new route
    consists of a ListView containing the ListTiles rows;
    each row is separated by a divider.

Add the highlighted code below:

<!-- skip -->
{% prettify dart %}
  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile
            .divideTiles(
              context: context,
              tiles: tiles,
            )
            .toList();

          [[highlight]]return new Scaffold([[/highlight]]
            [[highlight]]appBar: new AppBar([[/highlight]]
              [[highlight]]title: new Text('Saved Suggestions'),[[/highlight]]
            [[highlight]]),[[/highlight]]
            [[highlight]]body: new ListView(children: divided),[[/highlight]]
          [[highlight]]);[[/highlight]]
        },
      ),
    );
  }
{% endprettify %}
</li>

<li markdown="1"> Hot reload the app. Favorite some of the selections and
    tap the list icon in the app bar. The new route appears containing
    the favorites. Note that the Navigator adds a "Back" button to the
    app bar. You did not have to explicitly implement Navigator.pop.
    Tap the back button to return to the home route.
</li>
</ol>

<center><img src="images/step6a-screenshot.png" alt="screenshot at completion of 6th step"><img src="images/step6b-screenshot.png" alt="second route"></center>

<p class="h2-like">Problems?</p>

    If your app is not running correctly, you can use the code
at the following link to get back on track.

* [**lib/main.dart**](https://gist.github.com/Sfshaza/bc5547e112e4dc3a1aa87afdf917caeb)

---
# Step 7: Change the UI using Themes

In this final step, you'll play with the app's theme. The
_theme_ controls the look and feel of your app. You can use
the default theme, which is dependent on the physical device
or emulator, or you can customize the theme to reflect your branding.

<ol markdown="1">
<li markdown="1"> You can easily change an app's theme by configuring
    the ThemeData class.  Your app currently uses the default theme,
    but you'll be changing the primary color to be white.

Change the app's theme to white by adding the highlighted code to MyApp:

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

<li markdown="1"> Hot reload the app. Notice that the entire background is white,
even the app bar.
</li>

<li markdown="1"> As an exercise for the reader, use
[ThemeData](https://docs.flutter.io/flutter/material/ThemeData-class.html)
to change other aspects of the  UI. The
[Colors](https://docs.flutter.io/flutter/material/Colors-class.html)
class in the Material library provides many color constants you can play with,
and hot reload makes experimenting with the UI quick and easy.
</li>
</ol>

<center><img src="images/step7-themes.png" alt="screenshot at completion of 7th step"></center>

<p class="h2-like">Problems?</p>

If you've gotten off track, use the code from the following link
to see the code for the final app.

* [**lib/main.dart**](https://gist.githubusercontent.com/Sfshaza/c07c91a4061fce4b5eacaaf4d82e4993/raw/4001a72c0133b97c8e16bdeb3195ca03525696bd/main.dart)

---

# Well done!

You've written an interactive Flutter app that runs on both iOS and Android.
In this codelab, you've:

* Created a Flutter app from the ground up.
* Written Dart code.
* Leveraged an external, third party library.
* Used hot reload for a faster development cycle.
* Implemented a stateful widget, adding interactivity to your app.
* Created a lazily loaded, infinite scrolling list displayed with a
  ListView and ListTiles.
* Created a route and added logic for moving between the home route
  and the new route.
* Learned about changing the look of your app's UI using Themes.

<p class="h2-like">Next step</p>

[Next step: Learn More](/get-started/learn-more/)
