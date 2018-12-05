---
title: Write your first Flutter app, part 1
short-title: Write your first app
prev:
  title: Test drive
  path: /get-started/test-drive
next:
  title: Learn more
  path: /get-started/learn-more
---

{% asset get-started/startup-namer-part-1 alt="The app that you'll be building" class='site-image-right' %}

This is a guide to creating your first Flutter app. If you
are familiar with object-oriented code and basic programming
concepts such as variables, loops, and conditionals,
you can complete this tutorial. You don’t need
previous experience with Dart or mobile programming.

This guide is part 1 of a two-part codelab. You can find
[part 2](https://codelabs.developers.google.com/codelabs/first-flutter-app-pt2)
on [Google Developers](https://codelabs.developers.google.com).
[Part 1](https://codelabs.developers.google.com/codelabs/first-flutter-app-pt1)
can also be found on [Google Developers](https://codelabs.developers.google.com).

## What you'll build in part 1
{:.no_toc}

You’ll implement a simple mobile app that generates proposed names for a
startup company. The user can select and unselect names,
saving the best ones. The code lazily generates names.
As the user scrolls, more names are generated.
There is no limit to how far a user can scroll.

The animated GIF shows how the app works at the completion of part 1.

{{site.alert.secondary}}
  <h4 class="no_toc">What you’ll learn in part 1</h4>

  * How to write a Flutter app that looks natural on both iOS and Android.
  * Basic structure of a Flutter app.
  * Finding and using packages to extend functionality.
  * Using hot reload for a quicker development cycle.
  * How to implement a stateful widget.
  * How to create an infinite, lazily loaded list.

  In [part 2](https://codelabs.developers.google.com/codelabs/first-flutter-app-pt2)
  of this codelab, you'll add interactivity, modify the app's theme, and
  add the ability to navigate to a new screen (called a _route_ in Flutter).
{{site.alert.end}}

{{site.alert.secondary}}
  <h4 class="no_toc">What you'll use</h4>

  You need two pieces of software to complete this lab: the
  [Flutter SDK](/get-started/install) and [an editor](/get-started/editor).
  This codelab assumes Android Studio, but you can use your preferred
  editor.

  You can run this codelab using any of the following devices:

  * A physical device ([Android](install/macos#set-up-your-android-device)
    or [iOS](install/macos#deploy-to-ios-devices)) connected to your
    computer and set to developer mode.
  * The [iOS simulator](install/macos#set-up-the-ios-simulator).
  * The [Android emulator](install/macos#set-up-the-android-emulator).
{{site.alert.end}}

## Step 1: Create the starter Flutter app

Create a simple, templated Flutter app, using the instructions in
[Getting Started with your first Flutter app.](/get-started/test-drive#create-app)
Name the project **startup_namer** (instead of _myapp_).

{{site.alert.tip}}
  If you don't see "New Flutter Project" as an option in your IDE, make
  sure you have the [plugins installed for Flutter and
  Dart](/get-started/editor).
{{site.alert.end}}

In this codelab, you'll mostly be editing **lib/main.dart**,
where the Dart code lives.

 1. Replace the contents of `lib/main.dart`.<br>
    Delete all of the code from **lib/main.dart**.
    Replace with the following code, which displays "Hello World" in the center
    of the screen.

    ```dart
    import 'package:flutter/material.dart';

    void main() => runApp(MyApp());

    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Welcome to Flutter',
          home: Scaffold(
            appBar: AppBar(
              title: Text('Welcome to Flutter'),
            ),
            body: Center(
              child: Text('Hello World'),
            ),
          ),
        );
      }
    }
    ```

    {{site.alert.tip}}
      When pasting code into your app, indentation can become skewed.
      You can fix this automatically with the Flutter tools:

      * Android Studio / IntelliJ IDEA: Right-click the code and
        select **Reformat Code with dartfmt**.
      * VS Code: Right-click and select **Format Document**.
      * Terminal: Run `flutter format <filename>`.
    {{site.alert.end}}

 2. [Run the app](/get-started/test-drive#androidstudio) by clicking
    the green arrow in the IDE.
    You should see either Android or iOS output, depending on your device.

    {% indent %}
      {% include android-ios-figure-pair.md image="hello-world.png" alt="Hello world app" %}
    {% endindent %}

    {{site.alert.tip}}
      The first time you run on a physical device, it can take awhile to load.
      After this, you can use hot reload for quick updates. **Save** also
      performs a hot reload if the app is running.
    {{site.alert.end}}

### Observations
{:.no_toc}

* This example creates a Material app.
  [Material](https://material.io/guidelines/) is a visual design language
  that is standard on mobile and the web. Flutter offers a rich set
  of Material widgets.
* The `main()` method uses arrow (`=>`) notation.
  Use arrow notation for one-line functions or methods.
* The app extends `StatelessWidget` which makes the app itself a
  widget. In Flutter, almost everything is a widget, including
  alignment, padding, and layout.
* The `Scaffold` widget, from the Material library,
  provides a default app bar, title, and a body property that
  holds the widget tree for the home screen. The widget subtree
  can be quite complex.
* A widget’s main job is to provide a `build()` method
  that describes how to display the widget in terms of other,
  lower level widgets.
* The body for this example consists of a `Center` widget containing
  a `Text` child widget. The Center widget aligns its widget subtree
  to the center of the screen.

## Step 2: Use an external package

In this step, you’ll start using an open-source package named
[english_words](https://pub.dartlang.org/packages/english_words),
which contains a few thousand of the most used
English words plus some utility functions.

You can find the english_words package, as well as many other open source
packages, on [the Package site](https://pub.dartlang.org/flutter/).

 1. The pubspec file manages the assets and dependencies for a Flutter app.
    In **pubspec.yaml**, add **english_words** (3.1.0 or higher)
    to the dependencies list.
    Add the highlighted line below:

    {% prettify yaml %}
      dependencies:
        flutter:
          sdk: flutter

        cupertino_icons: ^0.1.0
        [[highlight]]english_words: ^3.1.0[[/highlight]]
    {% endprettify %}

 2. While viewing the pubspec in Android Studio's editor view,
    click **Packages get**. This pulls the package into
    your project. You should see the following in the console:

    ```terminal
    > flutter packages get
    Running "flutter packages get" in startup_namer...
    Process finished with exit code 0
    ```

    Performing `Packages get` also auto-generates the `pubspec.lock`
    file with a list of all packages pulled into the project and
    their version numbers.

 3. In **lib/main.dart**, import the new package:

    <!-- skip -->
    {% prettify dart %}
      import 'package:flutter/material.dart';
      [[highlight]]import 'package:english_words/english_words.dart';[[/highlight]]
    {% endprettify %}

    As you type, Android Studio gives you suggestions for libraries to
    import. It then renders the import string in gray, letting you
    know that the imported library is unused (so far).

 4. Use the English words package to generate the text instead of
    using the string "Hello World".

    Make the following changes:

    <!-- skip -->
    {% prettify dart %}
      import 'package:flutter/material.dart';
      import 'package:english_words/english_words.dart';

      void main() => runApp(MyApp());

      class MyApp extends StatelessWidget {
        @override
        Widget build(BuildContext context) {
          [[highlight]]final wordPair = WordPair.random();[[/highlight]]
          return MaterialApp(
            title: 'Welcome to Flutter',
            home: Scaffold(
              appBar: AppBar(
                title: Text('Welcome to Flutter'),
              ),
              body: Center(
                //child: Text([[highlight]]'Hello World'[[/highlight]]), // Replace the highlighted text...
                child: Text([[highlight]]wordPair.asPascalCase[[/highlight]]),  // With this highlighted text.
              ),
            ),
          );
        }
      }
    {% endprettify %}

    {{site.alert.note}}
      "Pascal case" (also known as "upper camel case"),
      means that each word in the string, including the first one,
      begins with an uppercase letter. So, "uppercamelcase" becomes
      "UpperCamelCase".
    {{site.alert.end}}

 5. If the app is running, use the hot reload button
    <i class="material-icons align-bottom">offline_bolt</i>
    to update the running app. Each time you click hot reload,
    or save the project, you should see a different word pair,
    chosen at random, in the running app.
    This is because the word pairing is generated inside the build
    method, which is run each time the MaterialApp requires rendering,
    or when toggling the Platform in Flutter Inspector.

    {% indent %}
      {% include android-ios-figure-pair.md image="step2.png" alt="App at completion of second step" %}
    {% endindent %}

### Problems?
{:.no_toc}

If your app is not running correctly, look for typos. If needed,
use the code at the following links to get back on track.

* [pubspec.yaml]({{site.codelab-code-url}}/startup_namer/2_end_of_use_package/pubspec.yaml)
* [lib/main.dart]({{site.codelab-code-url}}/startup_namer/2_end_of_use_package/lib/main.dart)

## Step 3: Add a Stateful widget

State<em>less</em> widgets are immutable, meaning that their
properties can’t change&mdash;all values are final.

State<em>ful</em> widgets maintain state that might change
during the lifetime of the widget. Implementing a stateful
widget requires at least two classes: 1) a StatefulWidget class
that creates an instance of 2) a State class. The StatefulWidget
class is, itself, immutable, but the State class persists over the
lifetime of the widget.

In this step, you’ll add a stateful widget, `RandomWords`, which creates
its `State` class, `RandomWordsState`. You'll then use `RandomWords` as
a child inside the existing `MyApp` stateless widget.

 1. Create a minimal state class. Add the following to the bottom
    of `main.dart`:

    <!-- skip -->
    {% prettify dart %}
      class RandomWordsState extends State<RandomWords> {
        // TODO Add build method
      }
    {% endprettify %}

    Notice the declaration `State<RandomWords>`. This indicates that we're
    using the generic
    [State](https://docs.flutter.io/flutter/widgets/State-class.html)
    class specialized for use with `RandomWords`. Most of the app's logic
    and state resides here&mdash;it maintains the state for the `RandomWords`
    widget. This class saves the generated word pairs, which grows infinitely
    as the user scrolls, and favorite word pairs (in
    [part 2](https://codelabs.developers.google.com/codelabs/first-flutter-app-pt2)),
    as the user adds or removes them from the list by toggling the heart icon.

    `RandomWordsState` depends on the `RandomWords` class. You'll add that next.

 2. Add the stateful `RandomWords` widget to `main.dart`.
    The `RandomWords` widget does little else beside creating its State class:

    <!-- skip -->
    {% prettify dart %}
      [[highlight]]class RandomWords extends StatefulWidget {[[/highlight]]
        [[highlight]]@override[[/highlight]]
        [[highlight]]RandomWordsState createState() => new RandomWordsState();[[/highlight]]
      [[highlight]]}[[/highlight]]
    {% endprettify %}

    After adding the state class, the IDE complains that
    the class is missing a build method. Next, you'll add a basic
    build method that generates the word pairs by moving the
    word generation code from `MyApp` to `RandomWordsState`.

 3. Add the `build()` method to `RandomWordsState`:

    <!-- skip -->
    {% prettify dart %}
      class RandomWordsState extends State<RandomWords> {
        [[highlight]]@override[[/highlight]]
        [[highlight]]Widget build(BuildContext context) {[[/highlight]]
          [[highlight]]final wordPair = WordPair.random();[[/highlight]]
          [[highlight]]return Text(wordPair.asPascalCase);[[/highlight]]
        [[highlight]]}[[/highlight]]
      }
    {% endprettify %}

 4. Remove the word generation code from `MyApp`:

    <!-- skip -->
    {% prettify dart %}
      class MyApp extends StatelessWidget {
        @override
        Widget build(BuildContext context) {
          [[strike]]final wordPair = WordPair.random();[[/strike]]  // Delete this line

          return MaterialApp(
            title: 'Welcome to Flutter',
            home: Scaffold(
              appBar: AppBar(
                title: Text('Welcome to Flutter'),
              ),
              body: Center(
                //child: [[highlight]]Text(wordPair.asPascalCase),[[/highlight]] // Change the highlighted text to...
                child: [[highlight]]RandomWords(),[[/highlight]] // ... this highlighted text
              ),
            ),
          );
        }
      }
    {% endprettify %}

 5. Restart the app.
    The app should behave as before, displaying a word
    pairing each time you hot reload or save the app.

{{site.alert.tip}}
  If you see the following warning on a hot reload, consider restarting
  the app:

  **Reloading...<br>
  Some program elements were changed during reload but did not run when
  the view was reassembled; you may need to restart the app (by pressing "R")
  for the changes to have an effect.**

  It may be a false positive, but restarting ensures that your changes
  are reflected in the app's UI.
{{site.alert.end}}


### Problems?
{:.no_toc}

If your app is not running correctly, you can use the code
at the following link to get back on track.

* [lib/main.dart]({{site.codelab-code-url}}/startup_namer/3_end_of_add_stateful_widget/lib/main.dart)

## Step 4: Create an infinite scrolling ListView

In this step, you'll expand `RandomWordsState` to generate
and display a list of word pairings. As the user scrolls, the list
displayed in a `ListView` widget, grows infinitely. `ListView`'s
`builder` factory constructor allows you to build a list view
lazily, on demand.

 1. Add a `_suggestions` list to the `RandomWordsState`
    class for saving suggested word pairings.
    Also, add a `_biggerFont` variable for making the font size larger.

    {{site.alert.tip}}
      Prefixing an identifier with an underscore [enforces
      privacy](https://www.dartlang.org/guides/language/language-tour)
      in the Dart
      language.
    {{site.alert.end}}

    <!-- skip -->
    {% prettify dart %}
      class RandomWordsState extends State<RandomWords> {
        [[highlight]]final _suggestions = <WordPair>[];[[/highlight]]

        [[highlight]]final _biggerFont = const TextStyle(fontSize: 18.0);[[/highlight]]
        ...
      }
    {% endprettify %}

    Next, you'll add a `_buildSuggestions()` function to the `RandomWordsState`
    class. This method builds the `ListView` that displays the suggested
    word pairing.

    The `ListView` class provides a builder property, `itemBuilder`, that's a
    factory builder and callback function specified as an anonymous function.
    Two parameters are passed to the function&mdash;the `BuildContext`,
    and the row iterator, `i`. The iterator begins at 0 and increments
    each time the function is called, once for every suggested word pairing.
    This model allows the suggested list to grow infinitely as the user scrolls.

 2. Add the entire `_buildSuggestions()` function, shown
    below, to the `RandomWordsState` class (delete the comments, if you prefer).

    <!-- skip -->
    {% prettify dart %}
      class RandomWordsState extends State<RandomWords> {
        ...
        [[highlight]]Widget _buildSuggestions() {[[/highlight]]
          [[highlight]]return ListView.builder([[/highlight]]
            [[highlight]]padding: const EdgeInsets.all(16.0),[[/highlight]]
            // The itemBuilder callback is called once per suggested word pairing,
            // and places each suggestion into a ListTile row.
            // For even rows, the function adds a ListTile row for the word pairing.
            // For odd rows, the function adds a Divider widget to visually
            // separate the entries. Note that the divider may be difficult
            // to see on smaller devices.
            [[highlight]]itemBuilder: (context, i) {[[/highlight]]
              // Add a one-pixel-high divider widget before each row in theListView.
              [[highlight]]if (i.isOdd) return Divider();[[/highlight]]

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

    The `_buildSuggestions()` function calls `_buildRow()` once per
    word pair. This function displays each new pair in a `ListTile`,
    which allows you to make the rows more attractive in the next step.

 3. Add a `_buildRow()` function to `RandomWordsState`:

    <!-- skip -->
    {% prettify dart %}
      class RandomWordsState extends State<RandomWords> {
        ...

        [[highlight]]Widget _buildRow(WordPair pair) {[[/highlight]]
          [[highlight]]return ListTile([[/highlight]]
            [[highlight]]title: Text([[/highlight]]
              [[highlight]]pair.asPascalCase,[[/highlight]]
              [[highlight]]style: _biggerFont,[[/highlight]]
            [[highlight]]),[[/highlight]]
          [[highlight]]);[[/highlight]]
        [[highlight]]}[[/highlight]]
      }
    {% endprettify %}

 4. Update the `build` method for RandomWordsState to use
    `_buildSuggestions()`, rather than directly calling the word
    generation library.
    ([Scaffold](https://docs.flutter.io/flutter/material/Scaffold-class.html)
    implements the basic Material Design visual layout.)

    <!-- skip -->
    {% prettify dart %}
      class RandomWordsState extends State<RandomWords> {
        ...
        @override
        Widget build(BuildContext context) {
          [[strike]]final wordPair = WordPair.random();[[/strike]] // Delete these two lines.
          [[strike]]return Text(wordPair.asPascalCase);[[/strike]]
          [[highlight]]return Scaffold ([[/highlight]]
            [[highlight]]appBar: AppBar([[/highlight]]
              [[highlight]]title: Text('Startup Name Generator'),[[/highlight]]
            [[highlight]]),[[/highlight]]
            [[highlight]]body: _buildSuggestions(),[[/highlight]]
          [[highlight]]);[[/highlight]]
        }
        ...
      }
    {% endprettify %}

 5. Update the build method for MyApp, changing the title,
    and changing the home to be a RandomWords widget.

    Replace the original method with the highlighted build method below:

    <!-- skip -->
    {% prettify dart %}
      class MyApp extends StatelessWidget {
        @override
        [[highlight]]Widget build(BuildContext context) {[[/highlight]]
          [[highlight]]return MaterialApp([[/highlight]]
            [[highlight]]title: 'Startup Name Generator',[[/highlight]]
            [[highlight]]home: RandomWords(),[[/highlight]]
          [[highlight]]);[[/highlight]]
        [[highlight]]}[[/highlight]]
      }
    {% endprettify %}

 6. Restart the app. You should see a list of word pairings
    no matter how far you scroll.

    {% indent %}
      {% include android-ios-figure-pair.md image="step4-infinite-list.png" alt="App at completion of fourth step" %}
    {% endindent %}

### Problems?
{:.no_toc}

If your app is not running correctly, you can use the code
at the following link to get back on track.

* [lib/main.dart]({{site.codelab-code-url}}/startup_namer/4_end_of_infinite_list/lib/main.dart)

## Next steps
{:.no_toc}

{% include app-figure.md
    class="site-image-right" img-class="border"
    image="startup-namer.gif" caption="The app from part 2" %}

Congratulations!

You've written an interactive Flutter app that runs on both iOS and Android.
In this codelab, you've:

* Created a Flutter app from the ground up.
* Written Dart code.
* Leveraged an external, third-party library.
* Used hot reload for a faster development cycle.
* Implemented a stateful widget.
* Created a lazily loaded, infinite scrolling list.

If you would like to extend this app, proceed to
[part 2](https://codelabs.developers.google.com/codelabs/first-flutter-app-pt2)
on the
[Google Developers Codelabs](https://codelabs.developers.google.com) site,
where you add the following functionality:

* Implement interactivity by adding a clickable heart icon to save
  favorite pairings.
* Implement navigation to a new route by adding a new screen
  containing the saved favorites.
* Modify the theme color, making an all-white app.
