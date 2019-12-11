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

{% asset get-started/sign-in alt="The web app that you'll be building" class='site-image-right' %}

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
If you see "flutter: command not found",
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
Click the **Run** button to run the example.
Note that you can type into the text fields,
but the Sign up button is disabled.
</li>

<li markdown="1">Copy the code.<br>
Click the clipboard icon in the upper right of the
code pane to copy the Dart code to your clipboard.
</li>

<li markdown="1">Create a new Flutter project.<br>
From your IDE, editor, or at the command line,
[create a new Flutter project][] and name it `signin_example`.
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
called the `State` class. In this lab,
all of your edits will be made to the private `_SignUpFormState` class.

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
It’s a `FlatButton` with a blue background,
white text that says **Sign up** and, when pressed,
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
</li>

<li markdown="1">Add the `_showWelcomeScreen` method.<br>
Fix the error reported by the analyzer that `_showWelcomeScreen`
is not defined. Directly above the `build()` method,
add the following function:

<!-- skip -->
```dart
void _showWelcomeScreen() {
   Navigator.of(context)
       .push(MaterialPageRoute(builder: (context) => WelcomeScreen()));
}
```
</li>

<li markdown="1">Run the app.<br>
The **Sign up** button should now be enabled.
Click it to bring up the welcome screen.
Note how it animates in from the bottom.
You get that behavior for free.
</li>
</ol>

### Problems?
{:.no_toc}

If your app is not running correctly, look for typos.
If needed, use the code at the following link to get back on track.

* [lib/main.dart](https://gist.github.com/sfshaza2/25ba0bec444b5a4b71edf78d569f124c)

### Observations
{:.no_toc}

* The `_showWelcomeScreen()` function is used in the `build()`
  method as a callback function. Callback functions are often
  used in Dart code and, in this case, this means
  “call this method when the button is pressed”.
* Flutter has only one `Navigator` object.
  This widget manages Flutter’s screens
  (also called _routes_ or _pages_) inside a stack.
  The screen at the top of the stack is the view that
  is currently displayed. Pushing a new screen to this
  stack switches the display to that new screen.
  This is why the `_showWelcomeScreen` function pushes
  the `WelcomeScreen` onto the Navigator’s stack.
  The user clicks the button and, voila, the welcome screen appears.
  Likewise, calling `pop()` on the `Navigator` returns to the previous screen.
  Because Flutter’s navigation is integrated into the browser’s navigation,
  this happens implicitly when clicking the browser’s back arrow button.

## Step 2: Enable sign in progress tracking

This sign in screen has three fields.
Next, you will enable the ability to track the
user’s progress on filling in the form fields,
and update the app’s UI when the form is complete.

{{site.alert.note}}
  This example does **not** validate the accuracy of the user input.
  That is something you can add later, if you like.
{{site.alert.end}}

<ol markdown="1">
<li markdown="1">Add a `_formCompleted` field.<br>
At the top of the `_SignUpFormState` class, add a boolean
field that you'll set to true when all three fields contain text.

<!-- skip -->
```dart
class _SignUpFormState extends State<SignUpForm>
   with SingleTickerProviderStateMixin {
 <b>bool _formCompleted = false;     // NEW</b>
...
```

<li markdown="1">Add a call to `setState()`.<br>
Search for `Step 2` in the code.
Once again, it’s in the `build()` method of the `_SignUpFormState` class.
Modify the `_SignUpFormBody` widget, which contains the form’s text fields.
Add code to tell Flutter to call the `setState()`
method when all three of the text fields are filled in.
Replace the `Step 2` comment with the code below marked as **NEW**:

<!-- skip -->
```dart
       ...
       SignUpFormBody(
         onProgressChanged: (progress) {
           <b>setState(() {                          // NEW</b>
             <b>_formCompleted = progress == 1;**    // NEW</b>
           <b>});                                    // NEW</b>
         },
       ),
       ...
```
</li>

<li markdown="1">Update the `onPressed` property (again).<br>
In `step 1`, you modified the `onPressed` property for the
**Sign up** button to display the welcome screen.
Now, update that button to display the welcome
screen only when the form is completely filled in:

<!-- skip -->
```dart
...
       Container(
         height: 40,
         width: double.infinity,
         margin: EdgeInsets.all(12),
         child: FlatButton(
           color: Colors.blue,
           textColor: Colors.white,
           <b>onPressed: _formCompleted ? _showWelcomeScreen : null,  // UPDATED</b>
           child: Text('Sign up'),
         ),
...

```
</li>

<li markdown="1">Run the app.<br>
The **Sign up** button is initially disabled,
but becomes enabled when all three text fields contain (any) text.
</li>
</ol>

### Problems?
{:.no_toc}

If your app is not running correctly, look for typos.
If needed, use the code at the following link to get back on track.

* [lib/main.dart](https://gist.github.com/sfshaza2/0ce13ec7bc16e1307cabfe18e4f40cb8)

### Observations
{:.no_toc}

* Calling a widget’s `setState()` method tells Flutter that the
  widget needs to be updated on screen.
  The framework then disposes of the previous immutable widget
  (and its children), creates a new one
  (with its accompanying child widget tree),
  and renders it to screen. For this to work seamlessly,
  Flutter needs to be fast.
  The new widget tree must be created and rendered to screen
  in less than 1/60th of a second to create a smooth visual
  transition—especially for an animation.
  Luckily Flutter *is* fast.
* The `progress` field is defined as a floating value,
  and is updated in the `_formProgress` getter method.
  When all three fields are filled in, `progress` is set to 1.0.
  When `progress` is set to 1.0, `_formCompleted` is set to true.
* Notice that the function passed as an argument to `setState()`
  isn’t  bound to an identifier. This is called an anonymous
  function and has the following syntax:
  <!-- skip -->
  ```dart
  methodName(() {...});
  ```
  Where `methodName` is a named function that takes an anonymous
  callback function as an argument.
* The Dart syntax in the last step that displays the
  welcome screen is:
  <!-- skip -->
  ```dart
  onPressed: _formCompleted ? _showWelcomeScreen : null
  ```
  This is a Dart conditional assignment and has the syntax: 
  `condition ? expression1 : expression2`. 
  If `_formCompleted` is true, Dart performs the first expression
  and displays the welcome screen, otherwise,
  it performs the second expression (null) and does nothing.

## Step 2.5: Launch Dart DevTools

How do you debug a Flutter web app?
It’s not too different from debugging any Flutter app.
You want to use [Dart DevTools][]!
(Not to be confused with Chrome DevTools.)

Our app currently has no bugs, but let’s check it out anyway.
The following instructions for launching DevTools applies to any workflow,
but there is a short cut if you’re using IntelliJ.
See the tip at the end of this section for more information.

<ol markdown="1">
<li markdown="1">Run the app.<br>
If your app isn’t currently running, launch it.
From the command line, use `flutter run -d chrome`,
or select the **Chrome** device from the pull down
and launch it from your IDE.
</li>

<li markdown="1">Get the web socket info for DevTools.<br>
At the command line, or in the IDE,
you should see a message stating something like the following:

```terminal
Launching lib/main.dart on Chrome in debug mode...
Building application for the web...                                11.7s
Attempting to connect to browser instance..
Debug service listening on **ws://127.0.0.1:54998/pJqWWxNv92s=**
```
Copy the address of the debug service, shown in bold.
You will need that to launch DevTools.
</li>

<li markdown="1">Ensure that DevTools is installed.<br>
Do you have [DevTools installed][]?
If you are using an IDE,
make sure you have the Flutter and Dart plugins set up,
as described in the [VS Code][] and [Android Studio / IntelliJ][] pages.
If you are working at the command line,
launch the DevTools server as explained in the
[DevTools command line][] page.
</li>

<li markdown="1">Connect to DevTools.<br>
When DevTools launches, you should see something like the following:

```terminal
Serving DevTools at http://127.0.0.1:9100
```
Go to this URL in a Chrome browser. You should see the DevTools
launch screen. It should look like the following:

{% indent %}
  ![Screenshot of the DevTools launch screen]({% asset get-started/devtools-launch-screen.png @path %}){:width="100%"}
{% endindent %}
</li>

<li markdown="1">Connect to running app.<br>
Under **Connect to a running site**,
paste the ws location that you copied in step 2,
and click Connect. You should now see Dart DevTools
running successfully in your Chrome browser:

{% indent %}
  ![Screenshot of DevTools running screen]({% asset get-started/devtools-running.png @path %}){:width="100%"}
{% endindent %}

Congratulations, you are now running Dart DevTools!
</li>
</ol>

{{site.alert.note}}
  This is not the only way to launch DevTools.
  If you are using IntelliJ,
  you can open DevTools by going to
  **Flutter Inspector** -> **More Actions** -> **Open DevTools**:

  {% indent %}
  ![Screenshot of Flutter inspector with DevTools menu]({% asset get-started/intellij-devtools.png @path %}){:width="100%"}
  {% endindent %}
{{site.alert.end}}

<ol markdown="1">
<li markdown="1">Set a breakpoint.<br>
Now that you have DevTools running,
select the **Debugger** tab in the blue bar along the top.
The debugger pane appears and, in the lower left,
see a list of libraries used in the example.
Select `signin/main.dart` to display your Dart code
in the center pane.

{% indent %}
  ![Screenshot of the DevTools debugger]({% asset get-started/devtools-debugging.png @path %}){:width="100%"}
  [todo: replace screenshot]
{% endindent %}
</li>

<li markdown="1">Set a breakpoint.<br>
In the Dart code,
scroll down to line 61, where `_formCompleted` is updated:

<!-- skip -->
```dart
  _formCompleted = progress == 1;
```
Place a breakpoint on this line by clicking to the
left of the line number. The breakpoint now appears
in the **Breakpoints** section to the left of the window.
</li>

<li markdown="1">Trigger the breakpoint.<br>
In the running app, click one of the text fields to gain focus.
The app hits the breakpoint and pauses.
In the DevTools screen, you can see on the left
the value of `progress`, which is 0. This is to be expected,
since none of the fields are filled in.
Click the downward arrow to the left of the `this _SignUpFormState`.
You can see the value of `_formCompleted` is false, as expected.
</li>

<li markdown="1">Resume the app.<br>
Resume the app by clicking the green **Resume**
button in the DevTools window.
</li>

<li markdown="1">Delete the breakpoint.<br>
Delete the breakpoint by clicking it again, and resume the app.
</li>
</ol>

This gives you a tiny glimpse of what is possible using DevTools,
but there is lots more! For more information,
see the [DevTools documentation][].

## Step 3: Add animation for sign in progres

It’s time to add animation! In this final step,
you’ll create the animation for the top of the sign in area.
The animation has the following behavior:

* When the app starts,
  a tiny red bar appears across the top of the sign in area.
* When one text field contains text,
  the red bar turns orange and animates one-third
  of the way across the sign in area.
* When two text fields contain text,
  the orange bar turns yellow and animates two-thirds
  of the way across the sign in area.
* When all three text fields contain text,
  the orange bar turns green and animates all the
  way across the sign in area.
  Also, the **Sign up** button becomes enabled.

<ol markdown="1">
<li markdown="1">Add fields to track the animation.<br>
In the `_SignupFormState` class, search for `Step 3`&mdash;you'll
find it at the top of the class. Add a field for the `AnimationController`,
and another for the color animation:

<!--skip-->
```dart
...
class _SignUpFormState extends State<SignUpForm>
   with SingleTickerProviderStateMixin {
 <b>AnimationController animationController;  // NEW</b>
 <b>Animation<Color> colorAnimation;          // NEW</b>
 bool _formCompleted = false;
...
```
</li>

<li markdown="1">Initialize the `AnimationController`:
Define the AnimationController in `initState()`:

<!--skip-->
```dart
class _SignUpFormState extends State<SignUpForm>
   with SingleTickerProviderStateMixin {
 AnimationController animationController;
 Animation<Color> colorAnimation;
 bool _formCompleted = false;

 @override
 void initState() {
   super.initState();

   <b>animationController = AnimationController(                      //NEW</b>
       <b>vsync: this, duration: const Duration(milliseconds: 1200)); //NEW</b>
...
```
</li>

<li markdown="1">Create a `Tween` sequence.<br>
Also in `initState()`, define a `Tween` sequence consisting
of three color tweens, one for each color of the animation
(red-to-orange, orange-to-yellow, yellow-to-green).

<!--skip-->
```dart
...
   animationController = AnimationController(
       vsync: this, duration: const Duration(milliseconds: 1200));

   <b>var colorTween = TweenSequence([</b>
     <b>TweenSequenceItem(</b>
       <b>tween: ColorTween(begin: Colors.red, end: Colors.orange),</b>
       <b>weight: 1,</b>
     <b>),</b>
     <b>TweenSequenceItem(</b>
       <b>tween: ColorTween(begin: Colors.orange, end: Colors.yellow),</b>
       <b>weight: 1,</b>
     <b>),</b>
     <b>TweenSequenceItem(</b>
       <b>tween: ColorTween(begin: Colors.yellow, end: Colors.green),</b>
       <b>weight: 1,</b>
     <b>),</b>
   <b>]);</b>
...
```
</li>

<li markdown="1">Attach the tween sequence to the `AnimationController`.<br>
For the final edit in `initState()`,
define colorAnimation by chaining the `Tween` sequence to
the animation controller using the `drive()` method.

<!--skip-->
```dart
   animationController = AnimationController(
       vsync: this, duration: const Duration(milliseconds: 1200));

   var colorTween = TweenSequence([
     TweenSequenceItem(
       tween: ColorTween(begin: Colors.red, end: Colors.orange),
       weight: 1,
     ),
     TweenSequenceItem(
       tween: ColorTween(begin: Colors.orange, end: Colors.yellow),
       weight: 1,
     ),
     TweenSequenceItem(
       tween: ColorTween(begin: Colors.yellow, end: Colors.green),
       weight: 1,
     ),
   ]);

   <b>colorAnimation = animationController.drive(colorTween); //NEW</b>
 }
```
</li>

<li markdown="1">Set up the animation trigger.<br>
In the definition for the body of the form,
update the `onProgressChanged` property:
When the value of `progress` changes, trigger the animation:

<!--skip-->
```dart
       SignUpFormBody(
         onProgressChanged: (progress) {
           <b>if (!animationController.isAnimating) {     // NEW</b>
             <b>animationController.animateTo(progress);  // NEW</b>
           <b>}                                           // NEW</b>
           setState(() {
             <b>_formCompleted = progress == 1;  // UPDATED</b>
           });
         },
       ),
...
```
</li>

<li markdown="1">Set up an `AnimationBuilder`.<br>
To display the animation,
add an `AnimatedBuilder` that creates a
`LinearProgressIndicator` to the column.
The `LinearProgressIndicator` is implemented as
another anonymous function on the `builder` field:

<!--skip-->
```dart
 @override
 Widget build(BuildContext context) {
   return Column(
     mainAxisSize: MainAxisSize.min,
     children: [
       <b>AnimatedBuilder(                         // NEW</b>
         <b>animation: animationController,        // NEW</b>
         <b>builder: (context, child) {            // NEW</b>
           <b>return LinearProgressIndicator(      // NEW</b>
             <b>value: animationController.value,  // NEW</b>
             <b>valueColor: colorAnimation,        // NEW</b>
             <b>backgroundColor: colorAnimation.value.withOpacity(0.4),          // NEW</b>
           <b>);                                   // NEW</b>
         },
       ),
...
```
</li>

<li markdown="1">Run the app.<br>
Type anything into the three fields to verify that the animation works,
and that clicking the **Sign up** button brings up the Welcome screen.
</li>
</ol>


### Problems?
{:.no_toc}

If your app is not running correctly, look for typos.
If needed, use the code at the following link to get back on track.

* [lib/main.dart](https://gist.github.com/sfshaza2/9a7e10e9141b775a70a94a14bf2200b4)

### Observations
{:.no_toc}

* You can use an `AnimationController` to run any animation.
* `AnimatedBuilder` rebuilds the widget tree when the value
  of an `Animation` changes.
* Using a `Tween`, you can interpolate between almost any value,
  in this case, `Color`.

## What next?

Congratulations!
You have created your first web app using Flutter!

If you’d like to continue playing with this example,
perhaps you could add form validation.
For advice on how to do this,
see the [Building a form with validation][]
recipe in the [Flutter cookbook][].

For more information on Flutter web apps,
Dart DevTools, or Flutter animations, see the following:

* [Animation docs][]
* [Dart DevTools][]
* [Implicit animations][] codelab
* [Web samples][]


[Android Studio / IntelliJ]: /docs/development/tools/devtools/android-studio
[Animation docs]: /docs/development/ui/animations
[Building a form with validation]: /docs/cookbook/forms/validation
[Building a web application with Flutter]: /docs/get-started/web
[Chrome browser]: https://www.google.com/chrome/?brand=CHBD&gclid=CjwKCAiAws7uBRAkEiwAMlbZjlVMZCxJDGAHjoSpoI_3z_HczSbgbMka5c9Z521R89cDoBM3zAluJRoCdCEQAvD_BwE&gclsrc=aw.ds
[create a new Flutter project]: /docs/get-started/test-drive
[Dart DevTools]: /docs/development/tools/devtools/overview
[DartPad]: https://dartpad.dev
[DevTools command line]: /docs/development/tools/devtools/cli
[DevTools documentation]: /docs/development/tools/devtools
[DevTools installed]: /docs/development/tools/devtools/overview#how-do-i-install-devtools
[DartPad troubleshooting page]: {{site.dart-site}}/tools/dartpad/troubleshoot
[editor]: /docs/get-started/editor
[Effective Dart Style Guide]: {{site.dart-site}}/guides/language/effective-dart/style#dont-use-a-leading-underscore-for-identifiers-that-arent-private
[Flutter cookbook]: /docs/cookbook
[Flutter SDK]: /docs/get-started/install
[Implicit animations]: /docs/codelabs/implicit-animations
[Introduction to declarative UI]: /docs/get-started/flutter-for/declarative
[Material Design]: https://material.io/design/introduction/#
[VS Code]: /docs/development/tools/devtools/vscode
[Web samples]: {{site.github}}/flutter/samples/tree/master/web
[Widget]: {{site.api}}/flutter/widgets/Widget-class.html
[writing your first Flutter app on mobile]: /docs/get-started/codelab
