---
title: Write your first Flutter app on the web
short-title: Write your first web app
---

{{site.alert.tip}}
  This codelab walks you through writing your first Flutter
  app on the web. You might prefer to try
  [writing your first Flutter app on mobile][].
  **Note that if you have downloaded and configured Android and
  iOS tooling, the completed app just works on all of these devices!**
{{site.alert.end}}

{% asset image="get-started/sign-in.gif" alt="The web app that you'll be building" class='site-image-right' %}

{% comment %}
{% endcomment %}

This is a guide to creating your first Flutter **web** app.
If you are familiar with object-oriented programming,
and concepts such as variables, loops, and conditionals,
you can complete this tutorial.
You don’t need previous experience with Dart,
mobile, or web programming.

## What you'll build
{:.no_toc}

You’ll implement a simple web app that displays a sign in screen.
The screen contains three text fields: email address,
phone number, and web site. As the user fills out the fields,
a progress bar animates along the top of the sign in area.
When all three fields are filled in, the progress bar displays
in green along the full width of the sign in area,
and the **Sign up** button becomes enabled.
Clicking the **Sign up** button causes a welcome screen
to animate in from the bottom of the screen.

The animated GIF shows how the app works at the completion of this lab.

{{site.alert.secondary}}
  <h4 class="no_toc">What you’ll learn</h4>

  * How to write a Flutter app that looks natural on the web.
  * Basic structure of a Flutter app.
  * How to implement a Tween animation.
  * How to implement a stateful widget.
  * How to use the debugger to set breakpoints.
{{site.alert.end}}

{{site.alert.secondary}}
  <h4 class="no_toc">What you'll use</h4>

  You need three pieces of software to complete this lab:

  * [Flutter SDK][]
  * [Chrome browser][]
  * [Text editor or IDE][editor]

  For a web-only codelab,
  we recommend either [IntelliJ IDEA or VS Code][editor].
  Android Studio and Xcode aren’t required.
  You can also use a text editor, if you prefer.

  While developing, run your web app in Chrome
  so you can debug with Dart DevTools.
{{site.alert.end}}

## Step 0: Get the starter web app

You'll start with a simple web app that we provide for you.

<ol markdown="1">
<li markdown="1">Enable web development.<br>
At the command line, perform the following commands to
make sure that you have the latest web support and that
it is enabled. You only need to run `flutter config` once
to enable Flutter support for web.
If you see “flutter: command not found”,
then make sure that you have installed the
[Flutter SDK][] and that it’s in your path.

```terminal
$ flutter channel beta
$ flutter upgrade
$ flutter config --enable-web
```

If you have problems enabling web development,
see [Building a web application with Flutter][].
</li>

<li markdown="1">Run `flutter doctor`.<br>
The `flutter doctor` command reports the status of the installation.
You should see something like the following:

```terminal
$ flutter doctor

[✓] Flutter: is fully installed. (Channel dev, v1.9.5, on Mac OS X 10.14.6 18G87, locale en-US)
[✗] Android toolchain - develop for Android devices: is not installed.
[✗] Xcode - develop for iOS and macOS: is not installed.
[✓] Chrome - develop for the web: is fully installed.
[!] Android Studio: is not available. (not installed)
[✓] Connected device: is fully installed. (1 available)
```

It's okay if the Android toolchain, Android Studio,
and the Xcode tools are not installed,
since our app is intended for the web only.
If you later want this app to work on mobile,
you will need to do additional installation and setup.
</li>

<li markdown="1">List the devices.<br>
To ensure that web _is_ installed,
list the devices available.
You should see something like the following:

``` terminal
$ flutter devices
2 connected devices:

Chrome     • chrome     • web-javascript • Google Chrome 78.0.3904.108
Web Server • web-server • web-javascript • Flutter Tools
```

The **Chrome** device automatically starts Chrome.
The **Web Server** starts a server that hosts the app
so that you can load it from any browser.
Use the Chrome device during development so that you can use DevTools,
and the web server when you want to test on other browsers.
</li>

<li markdown="1">The starting app is displayed in the following DartPad.

<!-- Starter sign in page app
     https://gist.github.com/1d3f66b295b4057ce6d97552cfe2698a -->

<iframe
  src="{{site.custom.dartpad.embed-flutter-prefix}}?id=1d3f66b295b4057ce6d97552cfe2698a"
  style="border: 1px solid lightgrey; margin-top: 10px; margin-bottom: 25px"
  frameborder="no" height="500" width="100%"
></iframe>

{{site.alert.important}}
  This page uses an embedded version of [DartPad][]
  to display examples and exercises.
  If you see empty boxes instead of DartPads,
  go to the [DartPad troubleshooting page][].
{{site.alert.end}}
</li>

<li markdown="1">Run the example.<br>
Click the Run button to run the example.
Note that you can type into the text fields,
but the Sign up button is disabled.
</li>

<li markdown="1">Copy the code.<br>
Click the clipboard icon in the upper right of the
code pane to copy the Dart code to your clipboard.
</li>

<li markdown="1">Create a new Flutter project.<br>
From your IDE, editor, or at the command line,
[create a new Flutter project][] and name it signin_example.
</li>

<li markdown="1">Replace the contents of `lib/main.dart`
                 with the contents of the clipboard.<br>
</li>
</ol>

### Observations
{:.no_toc}

* The entire code for this example lives in the
  `lib/main.dart` file.
* If you know Java, the Dart language should feel very familiar.
* All of the app's UI is created in Dart code.
  For more information, see [Introduction to declarative UI][].
* The app’s UI adheres [Material Design][],
  a visual design language that runs on any device or platform.
  You can customize the Material Design widgets,
  but if you prefer something else,
  Flutter also offers the Cupertino widget library,
  which implements the current iOS design language.
  Or you can create your own custom widget library.
* In Flutter, most everything is a [Widget][].
  Even the app itself is a widget.
  The app’s UI can be described as a widget tree.

## Step 1: Enable the Welcome screen

It’s time to play with code! You may have noticed some comments
in the source code labeled `Step 1`, `Step 2`, and `Step 3`.
This lab leads you through the necessary changes, step by step. 

The `SignUpForm` class is a stateful widget.
This simply means that the widget stores information that can change,
such as user input, or data from a feed.
Since widgets themselves are immutable (can’t be modified once created),
Flutter stores state information in a companion class,
called the `State` class.
All of your edits will be made to the private `_SignUpFormState` class.

{{site.alert.secondary}}
  <h4 class="no_toc">Fun fact</h4>
The Dart compiler enforces privacy for any identifier
prefixed with an underscore. For more information,
see the [Effective Dart Style Guide][].
{{site.alert.end}}

The Welcome screen has already been created for you in the starter app.
Search in the code for `WelcomeScreen`&mdash;it’s
at the bottom of the file. For this step,
you enable the button to display the screen and create a method to display it.

<ol markdown="1">
<li markdown="1">Open the `lib/main.dart` file.
</li>

<li markdown="1">Locate the `_signUpFormState` class.<br>
Search for `Step 1` in the file.
You will find it inside the `build()` method for the `_SignUpFormState` class.
This is the part of the code that builds the SignUp button.
Notice how the button is defined:
It’s a FlatButton with a blue background,
white text that says *Sign up* and, when pressed,
does nothing.
</li>

<li markdown="1">Update the `onPressed` property.<br>
Change the `onPressed` property to call the (non-existent)
method that will display the welcome screen. 

Change `onPressed: null` to the following:

<!-- skip -->
```dart
onPressed: _showWelcomeScreen,

```



[Building a web application with Flutter]: /docs/get-started/web
[Chrome browser]: https://www.google.com/chrome/?brand=CHBD&gclid=CjwKCAiAws7uBRAkEiwAMlbZjlVMZCxJDGAHjoSpoI_3z_HczSbgbMka5c9Z521R89cDoBM3zAluJRoCdCEQAvD_BwE&gclsrc=aw.ds
[create a new Flutter project]: /docs/get-started/test-drive
[DartPad]: https://dartpad.dev
[DartPad troubleshooting page]: {{site.dart-site}}/tools/dartpad/troubleshoot
[editor]: /docs/get-started/editor
[Effective Dart Style Guide]: {{site.dart-site}}/guides/language/effective-dart/style#dont-use-a-leading-underscore-for-identifiers-that-arent-private
[Flutter SDK]: /docs/get-started/install
[Introduction to declarative UI]: /docs/get-started/flutter-for/declarative
[Material Design]: https://material.io/design/introduction/#
[Widget]: {{site.api}}/flutter/widgets/Widget-class.html
[writing your first Flutter app on mobile]: /docs/get-started/codelab
