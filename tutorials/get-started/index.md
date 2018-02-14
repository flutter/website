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

_Flutter_ is a mobile app SDK to help developers and designers build modern mobile apps for iOS and Android.

_Dart_ is an application programming language from Google that's easy
to learn, easy to use, and deployable everywhere. Flutter apps are
written in Dart.

### What you'll build

You'll implement a simple mobile app that proposes startup names.
The user can select and unselect proposed names, saving the best ones.
The code generates ten names at a time. As the user scrolls, new
batches of names are generated.

<center><img src="images/StartupNameGenerator-screenshot.png" alt="Screenshot of the name generator"></center>
<center>[PENDING: Temporary image - replace this with video.]</center><br><br>

The following video shows how the app works:

[PENDING: insert video]

<div class="whats-the-point" markdown="1">

<b> <a id="whats-the-point" class="anchor" href="#whats-the-point" aria-hidden="true"><span class="octicon octicon-link"></span></a>What you'll learn:</b>

* Basic structure of a Flutter app.
* Finding and using packages to extend functionality.
* Using hot reload for a quicker development cycle.
* How to implement a stateful widget.
* How to create an infinite lazily loaded list.
* How to create and navigate to a second screen.
* ...

</div>

<div class="whats-the-point" markdown="1">

<b> <a id="whats-the-point" class="anchor" href="#whats-the-point" aria-hidden="true"><span class="octicon octicon-link"></span></a>What you'll use:</b>

This tutorial requires version xxx or later of the Flutter SDK.
When you install Flutter, you get the correct version of the Dart SDK
as part of the install.

These instructions feature the Android Studio IDE, but you
can use whichever tools you prefer&mdash;Flutter and Dart plugins
are also available for VSCode and JetBrains products.
You can test your code using Flutter's Simulator or an actual
device.

See [Mit's new setup page](xxx) for information on how to set up
your environment.

</div>

## Step 1: Create a basic Flutter app

In this step, you create a Flutter app, no coding required.
Android Studio uses a template to provide all the files your
app needs.

<ol markdown="1">

<li markdown="1">Launch Android Studio <img src="images/AndroidStudioIcon.png" alt="Icon for Android Studio">
</li>

<li markdown="1">In the **Welcome to Android Studio** window, click
    **Start a New Flutter project**. A **New Flutter Project**
    form appears.
</li>

<li markdown="1">Select **Flutter Application** from the images
    that appear. Click **NEXT**.
</li>

<li markdown="1">[PENDING: A way to select a "HelloWorld" app,
    rather than the default click counting app, is coming.]
</li>

<li markdown="1">In the form that appears, enter
    **startup_namer**.
</li>

<li markdown="1">If the **Flutter SDK path** field is empty,
    enter the location of the SDK on your hard drive.
    Change the **Project location** or **Description** fields,
    if you wish. Click **NEXT**.
</li>

<li markdown="1">A **Set the package name** form appears.
    [PENDING: Do we care about this one?] Click **FINISH**.
</li>

</ol>

### What did you get?

An Android Studio project window appears, called **startup_namer**.
On your hard drive, Android Studio created a directory
with the same name that contains all the files
you'll need to create and run a simple Flutter app.
Here are the most important files:

* **lib/main.dart**: Bootstraps the application to run on a mobile
  device or a simulator. It runs on both iOS and Android. This file will
  contain all the Dart code needed for this example.
* **pubspec.yaml**: Describes this Flutter package (the app) and
  its dependencies. As you add packages or images to your app, you
  list them in the pubspec file.

### Run the app

Make sure that you have a connected device, or a running Simulator
before attempting to launch the app.

<ol markdown="1">

<li markdown="1"> Click the green "run" button
    (<img src="images/green-run.png">) at the top of the
    window.
</li>

<li markdown="1"> In the lib/main.dart file, modify the text to
    something else, such as "Bonjour le monde".
</li>

<li markdown="1"> Update the running app by clicking the
    hot reload button, which looks like a lightning bolt,
    (<img src="images/hot-reload-button.png" alt="hot reload lightning bolt image">).
</li>

</ol>

Hot reload modifies the running app without otherwise changing the
app's state. When you need a full app restart,
use the green run button, but when you want to update the running
app while preserving state, use hot reload.

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

### <img src="images/eyeball.png" alt="image of an eyeball">Observations

<ul markdown="1">

<li markdown="1"> This example creates a Material app.
</li>
<li markdown="1"> The `main` method specifies fat arrow (`=>`)
    notation, which is short hand used for one-line functions
    or methods.
</li>
<li markdown="1"> The app extends StatelessWidget which makes
    the app itself a widget.  In Flutter, most everything is a widget,
    including alignment and padding.
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
    widget, HelloWorld, creates an identical widget tree:
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


