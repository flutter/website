---
title: "How to Create Stateless Widgets"
description: "When getting started with Flutter, one of the first things you need to learn about is stateless widgets. We recorded a series that covers…"
publishDate: 2019-02-14
author: aguinis
image: images/0GoTVv7PbwxvjCh4S.webp
category: tutorial
layout: blog
---

When getting started with Flutter, one of the first things you need to learn about is stateless widgets. We recorded a series that covers stateless widgets, stateful widgets, inherited widgets, and keys.

In the following video, I go over what a Flutter widget is, and how to use StatelessWidgets in a Flutter app:

<YoutubeEmbed id="wE7khGHVkYY" title="How to Create Stateless Widgets - Flutter Widgets 101 Ep. 1" fullwidth="true"/>


For those that prefer to read articles over watching videos, this post explains what Flutter widgets are, how they combine to become interfaces, and how to compose a UI with stateless widgets.

## Part 1 — Making a dog app using stateless widgets

To keep things quick, I’m starting with a basic app here. It contains a Scaffold widget, an AppBar widget, and a couple Text widgets that display info about my yellow Labrador, Rocky.

<DashImage figure src="images/0GoTVv7PbwxvjCh4S.webp" />


Widgets are the basic building blocks of a Flutter app. Each one is an immutable declaration of an aspect of the user interface, and they can take on many tasks.

For example, there are:

* structural widgets — like a button or menu

* stylistic widgets that propagate a font or color scheme

* layout-related widgets — like padding

* and many more

You can also compose new widgets from existing widgets, so the combinations are endless. Let me show you what I mean.

Say I want a color behind my dog’s name.

I can do that by wrapping the Text widget with a DecoratedBox.

```dart
import 'package:flutter/material.dart';

void main() {
 runApp(new DogApp());
}

class DogApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'My Dog App',
     home: Scaffold(
       appBar: AppBar(
         title: Text('Yellow Lab'),
       ),
       body: Center(
         child: DecoratedBox( // here is where I added my DecoratedBox
           decoration: BoxDecoration(color: Colors.lightBlueAccent),
           child: Text('Rocky'),
         ),
       ),
     ),
   );
 }
}

```

And now my text widget has a background color.

<DashImage figure src="images/1bk-ErE0V-mSofAW6dze8jQ.webp" />


Maybe I’d like padding around the text.

I can accomplish that by adding a padding widget. I’ll specify 8 logical pixels of padding around Rocky’s name.

```dart
import 'package:flutter/material.dart';

void main() {
 runApp(new DogApp());
}

class DogApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'My Dog App',
     home: Scaffold(
       appBar: AppBar(
         title: Text('Yellow Lab'),
       ),
       body: Center(
         child: DecoratedBox(
           decoration: BoxDecoration(color: Colors.lightBlueAccent),
           child: Padding(
             padding: const EdgeInsets.all(8.0)
             child: Text('Rocky'),
           ),
         ),
       ),
     ),
   );
 }
```

And now I’ve got padding.

<DashImage figure src="images/1dH1_jmYHx1UxfioPteGiKQ.webp" />


This process of putting widgets together is what we call “composition.” I’m composing my interface by combining simple widgets, each of which handles one particular job: Padding pads things, DecoratedBox decorates a box, and so on.

Now, let’s say I go to the animal shelter and meet a couple yellow labs I can’t live without. I can add a Column widget inside the Center widget, and add their names.

```dart
import 'package:flutter/material.dart';

void main() {
 runApp(new DogApp());
}

class DogApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'My Dog App',
     home: Scaffold(
       appBar: AppBar(
         title: Text('Yellow Lab'),
       ),
       body: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             DecoratedBox(
               decoration: BoxDecoration(color: Colors.lightBlueAccent),
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text('Rocky'),
               ),
             ),
             DecoratedBox(
               decoration: BoxDecoration(color: Colors.lightBlueAccent),
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text('Spot'),
               ),
             ),
             DecoratedBox(
               decoration: BoxDecoration(color: Colors.lightBlueAccent),
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text('Fido'),
               ),
             ),
           ],
         ),
       ),
     ),
   );
 }
}

```

I use a widget called SizedBox to add blank space between them, which results in this:

<DashImage figure src="images/1NW7SMJnwzENu3avGQpDgAg.webp" />


But you know, I’ve got a lot of repeated code(also called *boilerplate*) in these three name boxes. Wouldn’t it be great if I could make my own widget that takes a name and handled the details for me?

Well, I can.

I’ll make a StatelessWidget, and call it DogName. A stateless widget is a widget that’s composed of children (which is why it contains a build() method) and doesn’t contain any mutable state that it needs to track. When I say mutable state, I mean any properties that change over time. For example, a text box containing a string that the user updates, or a data stream that updates an arrivals/departures display.

```dart
class DogName extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
  }
}
```

This widget doesn’t have any of that. It just needs a string for a name, which won’t change, so StatelessWidget is a perfect fit. I can even make this string final, too.

```dart
class DogName extends StatelessWidget {
 final String name;

 @override
 Widget build(BuildContext context) {
 }
}
```

I can specify the string via the constructor, and because all of its properties are final, I can mark this as a const constructor.

```dart
class DogName extends StatelessWidget {
 final String name;

const DogName(this.name);

 @override
 Widget build(BuildContext context) {
  }
}

```

Now, I just need to define the build method using the same widgets, only now the Text widget displays the string from the widget’s name property.

```dart
class DogName extends StatelessWidget {
 final String name;

const DogName(this.name);

 @override
 Widget build(BuildContext context) {
   return DecoratedBox(
     decoration: BoxDecoration(color: Colors.lightBlueAccent),
     child: Padding(
       padding: const EdgeInsets.all(8.0),
       child: Text(name),
     ),
   );
 }
}

```

I use this widget to simplify the original code.

```dart
import 'package:flutter/material.dart';

void main() {
 runApp(new DogApp());
}

class DogApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'My Dog App',
     home: Scaffold(
       appBar: AppBar(
         title: Text('Yellow Lab'),
       ),
       body: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             DogName('Rocky'),
             SizedBox(height: 8.0),
             DogName('Spot'),
             SizedBox(height: 8.0),
             DogName('Fido'),
           ],
         ),
       ),
     ),
   );
 }
}

```

As you can see, this results in the same UI, but the code is tighter thanks to StatelessWidget and Flutter’s use of composition.

<DashImage figure src="images/1NW7SMJnwzENu3avGQpDgAg.webp" />


## Part 2 — Widget Trees and Element Trees

So that’s a little example of how composing with StatelessWidget works. At this point, you might ask yourself, “I see how these build methods work, but when do they get called?” Well, let’s start with just a single DogName widget.

We tend to think of apps built with Flutter as a tree of widgets, and that’s not a bad thing. But as I mentioned at the beginning, widgets are really just configurations for pieces of an app’s UI. They’re blueprints. So what are these configurations for? Elements. An element is a widget that’s been made real and mounted onscreen. The element tree represents what is actually displayed on the device at any given moment.

Each widget class has both a corresponding element class and a method to create an instance.

<DashImage figure src="images/1gG5opaiBFJ0A1ka9tZMeSQ.webp" />


StatelessWidget, for example, creates a StatelessElement.

When a widget is mounted to the tree, Flutter calls the createElement() method. Flutter asks the widget for an element, and pops that element onto the element tree with a reference back to the widget that created it.

StatefulElement then asks “I wonder if I have any children?” and calls the Widget’s build() method.

<DashImage figure src="images/10IZb-Rcyw4yBo3CXQM5zTg.webp" />


In this app, it has several. These widgets then create their own corresponding elements.

<DashImage figure src="images/17qIL1q-ZP005QS_zTt0j5A.webp" />


And those are mounted to the element tree as well.

<DashImage figure src="images/1O-D8lfgoAmMqHViU2dWuyg.webp" />


So the app now has two trees: one that represents what’s actually on the screen (the elements), and one that holds the blueprints they were made from (the widgets).

Now you might be wondering what starts the process of building and creating elements, what kicks off the whole thing, so to speak. Let me show you something you may not have noticed back at the beginning…

The DogApp class, which represents the entire app, is itself a StatelessWidget.

```dart
import 'package:flutter/material.dart';

void main() {
 runApp(new DogApp());
}

class DogApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'My Dog App',
     home: Scaffold(
       appBar: AppBar(
         title: Text('Yellow Lab'),
       ),
       body: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             DogName('Rocky'),
             SizedBox(height: 8.0),
             DogName('Spot'),
             SizedBox(height: 8.0),
             DogName('Fido'),
           ],
         ),
       ),
     ),
   );
 }
}

```

I told you that Widgets can do almost everything, right? If you look at main(), which is the entry point for the app, you can see that it calls the runApp() method, and that’s the starting point. The runApp() method takes a widget and mounts it as the app’s root element with height and width constraints that match the size of the screen.

```dart
import 'package:flutter/material.dart';

void main() {
 runApp(new DogApp());
}

class DogApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'My Dog App',
     home: Scaffold(
       appBar: AppBar(
         title: Text('Yellow Lab'),
       ),
       body: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             DogName('Rocky'),
             SizedBox(height: 8.0),
             DogName('Spot'),
             SizedBox(height: 8.0),
             DogName('Fido'),
           ],
         ),
       ),
     ),
   );
 }
}

```

Then, Flutter progresses through all of the build() methods in the widget tree, creating widgets and using them to make elements, until everything is built, mounted onscreen, and ready to be laid out and rendered.

<DashImage figure src="images/0QLq-DId9PheGXmk9.webp" />


Which is how it displays three little boxes containing the names of the yellow labs.

<DashImage figure src="images/1lRBiFALMxP8-RPAsmlk7pw.webp" />


So that’s an introduction to composing with StatelessWidgets and building an interface. One thing I didn’t mention is how to update or rebuild an interface when the data changes. That’s because StatelessWidgets don’t do that. They’re stateless, so they can’t track data over time, or trigger rebuilds on their own.

Fortunately, Flutter also has StatefulWidgets, which we’ll tell you about in the next episode of this series.

For more information about Flutter and all of its many widgets, head to [flutter.io](https://flutter.io).

You can also [watch other episodes in the series here](https://bit.ly/FlutterWidgets101) or [try a Flutter codelab](https://bit.ly/Flutter-Codelab).
