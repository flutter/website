---
title: Write your first Flutter app on the web
description: How to create a Flutter web app.
short-title: Write your first web app
js:
  - defer: true
    url: /assets/js/inject_dartpad.js
---

<?code-excerpt path-base="get-started/codelab_web"?>

:::tip
This codelab walks you through writing
your first Flutter app on the web, specifically.
You might prefer to try
[another codelab][first_flutter_codelab]
that takes a more generic approach.
Note that the codelab on this page
does work on mobile and desktop
once you download and configure the appropriate tooling.
:::

<img src="/assets/images/docs/get-started/sign-up.gif" alt="The web app that you'll be building." class='site-image-right'>

This is a guide to creating your first Flutter **web** app.
If you are familiar with object-oriented programming,
and concepts such as variables, loops, and conditionals,
you can complete this tutorial.
You don't need previous experience with Dart,
mobile, or web programming.

## What you'll build {:.no_toc}

You'll implement a simple web app that displays a sign in screen.
The screen contains three text fields:  first name,
last name, and username. As the user fills out the fields,
a progress bar animates along the top of the sign in area.
When all three fields are filled in, the progress bar displays
in green along the full width of the sign in area,
and the **Sign up** button becomes enabled.
Clicking the **Sign up** button causes a welcome screen
to animate in from the bottom of the screen.

The animated GIF shows how the app works at the completion of this lab.

:::secondary What you'll learn
* How to write a Flutter app that looks natural on the web.
* Basic structure of a Flutter app.
* How to implement a Tween animation.
* How to implement a stateful widget.
* How to use the debugger to set breakpoints.
:::

:::secondary What you'll use
You need three pieces of software to complete this lab:

* [Flutter SDK][]
* [Chrome browser][]
* [Text editor or IDE][editor]

While developing, run your web app in Chrome,
so you can debug with Dart DevTools 
(also call Flutter DevTools).
:::

## Step 0: Get the starter web app

You'll start with a simple web app that we provide for you.

<ol>
<li>Enable web development.<br>
At the command line, perform the following command to
make sure that you have Flutter installed correctly.

```console
$ flutter doctor
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, {{site.appnow.flutter}}, on macOS darwin-arm64, locale en)
[✓] Android toolchain - develop for Android devices (Android SDK version {{site.appnow.android_sdk}})
[✓] Xcode - develop for iOS and macOS (Xcode {{site.appnow.xcode}})
[✓] Chrome - develop for the web
[✓] Android Studio (version {{site.appnow.android_studio}})
[✓] VS Code (version {{site.appnow.vscode}})
[✓] Connected device (4 available)
[✓] HTTP Host Availability

• No issues found!
```

If you see "flutter: command not found",
then make sure that you have installed the
[Flutter SDK][] and that it's in your path.

It's okay if the Android toolchain, Android Studio,
and the Xcode tools aren't installed,
since the app is intended for the web only.
If you later want this app to work on mobile,
you'll need to do additional installation and setup.
</li>

<li>

List the devices.<br>
To ensure that web _is_ installed,
list the devices available.
You should see something like the following:

```console
$ flutter devices
4 connected devices:

sdk gphone64 arm64 (mobile) • emulator-5554                        •
android-arm64  • Android 13 (API 33) (emulator)
iPhone 14 Pro Max (mobile)  • 45A72BE1-2D4E-4202-9BB3-D6AE2601BEF8 • ios
• com.apple.CoreSimulator.SimRuntime.iOS-16-0 (simulator)
macOS (desktop)             • macos                                •
darwin-arm64   • macOS 12.6 21G115 darwin-arm64
Chrome (web)                • chrome                               •
web-javascript • Google Chrome 105.0.5195.125
```

The **Chrome** device automatically starts Chrome and enables the use
of the Flutter DevTools tooling.

</li>

<li>

The starting app is displayed in the following DartPad.

<?code-excerpt "lib/starter.dart"?>
```dartpad title="Flutter beginning getting started hands-on example in DartPad" run="true"
import 'package:flutter/material.dart';

void main() => runApp(const SignUpApp());

class SignUpApp extends StatelessWidget {
  const SignUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const SignUpScreen(),
      },
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: const Center(
        child: SizedBox(
          width: 400,
          child: Card(
            child: SignUpForm(),
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _usernameTextController = TextEditingController();

  double _formProgress = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearProgressIndicator(value: _formProgress),
          Text('Sign up', style: Theme.of(context).textTheme.headlineMedium),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: _firstNameTextController,
              decoration: const InputDecoration(hintText: 'First name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: _lastNameTextController,
              decoration: const InputDecoration(hintText: 'Last name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: _usernameTextController,
              decoration: const InputDecoration(hintText: 'Username'),
            ),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                return states.contains(WidgetState.disabled)
                    ? null
                    : Colors.white;
              }),
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                return states.contains(WidgetState.disabled)
                    ? null
                    : Colors.blue;
              }),
            ),
            onPressed: null,
            child: const Text('Sign up'),
          ),
        ],
      ),
    );
  }
}
```

:::important
This page uses an embedded version of [DartPad][]
to display examples and exercises.
If you see empty boxes instead of DartPads,
go to the [DartPad troubleshooting page][].
:::

</li>

<li>

Run the example.<br>
Click the **Run** button to run the example.
Note that you can type into the text fields,
but the **Sign up** button is disabled.

</li>

<li>

Copy the code.<br>
Click the clipboard icon in the upper right of the
code pane to copy the Dart code to your clipboard.

</li>

<li>

Create a new Flutter project.<br>
From your IDE, editor, or at the command line,
[create a new Flutter project][] and name it `signin_example`.

</li>

<li>

Replace the contents of `lib/main.dart`
with the contents of the clipboard.

</li>
</ol>

### Observations {:.no_toc}

* The entire code for this example lives in the
  `lib/main.dart` file.
* If you know Java, the Dart language should feel very familiar.
* All of the app's UI is created in Dart code.
  For more information, see [Introduction to declarative UI][].
* The app's UI adheres to [Material Design][],
  a visual design language that runs on any device or platform.
  You can customize the Material Design widgets,
  but if you prefer something else,
  Flutter also offers the Cupertino widget library,
  which implements the current iOS design language.
  Or you can create your own custom widget library.
* In Flutter, almost everything is a [Widget][].
  Even the app itself is a widget.
  The app's UI can be described as a widget tree.

## Step 1: Show the Welcome screen

The `SignUpForm` class is a stateful widget.
This simply means that the widget stores information
that can change, such as user input, or data from a feed.
Since widgets themselves are immutable
(can't be modified once created),
Flutter stores state information in a companion class,
called the `State` class. In this lab,
all of your edits will be made to the private
`_SignUpFormState` class.

:::tip Fun fact
The Dart compiler enforces privacy for any identifier
prefixed with an underscore. For more information,
see the [Effective Dart Style Guide][].
:::

First, in your `lib/main.dart` file,
add the following class definition for the
`WelcomeScreen` widget after the `SignUpScreen` class:

<?code-excerpt "lib/step1.dart (welcome-screen)"?>
```dart
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome!',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
```

Next, you will enable the button to display the screen
and create a method to display it.

<ol>

<li>

Locate the `build()` method for the
`_SignUpFormState` class. This is the part of the code
that builds the SignUp button.
Notice how the button is defined:
It's a `TextButton` with a blue background,
white text that says **Sign up** and, when pressed,
does nothing.

</li>

<li>

Update the `onPressed` property.<br>
Change the `onPressed` property to call the (non-existent)
method that will display the welcome screen.

Change `onPressed: null` to the following:

<?code-excerpt "lib/step1.dart (on-pressed)"?>
```dart
onPressed: _showWelcomeScreen,
```

</li>

<li>

Add the `_showWelcomeScreen` method.<br>
Fix the error reported by the analyzer that `_showWelcomeScreen`
is not defined. Directly above the `build()` method,
add the following function:

<?code-excerpt "lib/step1.dart (show-welcome-screen)"?>
```dart
void _showWelcomeScreen() {
  Navigator.of(context).pushNamed('/welcome');
}
```

</li>

<li>

Add the `/welcome` route.<br>
Create the connection to show the new screen.
In the `build()` method for `SignUpApp`,
add the following route below `'/'`:

<?code-excerpt "lib/step1.dart (welcome-route)"?>
```dart
'/welcome': (context) => const WelcomeScreen(),
```

</li>

<li>

Run the app.<br>
The **Sign up** button should now be enabled.
Click it to bring up the welcome screen.
Note how it animates in from the bottom.
You get that behavior for free.

</li>

</ol>

### Observations {:.no_toc}

* The `_showWelcomeScreen()` function is used in the `build()`
  method as a callback function. Callback functions are often
  used in Dart code and, in this case, this means
  "call this method when the button is pressed".
* The `const` keyword in front of the constructor is very
  important. When Flutter encounters a constant widget, it
  short-circuits most of the rebuilding work under the hood
  making the rendering more efficient.
* Flutter has only one `Navigator` object.
  This widget manages Flutter's screens
  (also called _routes_ or _pages_) inside a stack.
  The screen at the top of the stack is the view that
  is currently displayed. Pushing a new screen to this
  stack switches the display to that new screen.
  This is why the `_showWelcomeScreen` function pushes
  the `WelcomeScreen` onto the Navigator's stack.
  The user clicks the button and, voila,
  the welcome screen appears. Likewise,
  calling `pop()` on the `Navigator` returns to the
  previous screen. Because Flutter's navigation is
  integrated into the browser's navigation,
  this happens implicitly when clicking the browser's
  back arrow button.

## Step 2: Enable sign in progress tracking

This sign in screen has three fields.
Next, you will enable the ability to track the
user's progress on filling in the form fields,
and update the app's UI when the form is complete.

:::note
This example does **not** validate the accuracy of the user input.
That is something you can add later using form validation, if you like.
:::

<ol>
<li>

Add a method to update `_formProgress`.
In the `_SignUpFormState` class, add a new method called
`_updateFormProgress()`:

<?code-excerpt "lib/step2.dart (update-form-progress)"?>
```dart
void _updateFormProgress() {
  var progress = 0.0;
  final controllers = [
    _firstNameTextController,
    _lastNameTextController,
    _usernameTextController
  ];

  for (final controller in controllers) {
    if (controller.value.text.isNotEmpty) {
      progress += 1 / controllers.length;
    }
  }

  setState(() {
    _formProgress = progress;
  });
}
```

This method updates the `_formProgress` field based on
the number of non-empty text fields.

</li>

<li>

Call `_updateFormProgress` when the form changes.<br>
In the `build()` method of the `_SignUpFormState` class,
add a callback to the `Form` widget's `onChanged` argument.
Add the code below marked as NEW:

<?code-excerpt "lib/step2.dart (on-changed)"?>
```dart
return Form(
  onChanged: _updateFormProgress, // NEW
  child: Column(
```

</li>

<li>

Update the `onPressed` property (again).<br>
In `step 1`, you modified the `onPressed` property for the
**Sign up** button to display the welcome screen.
Now, update that button to display the welcome
screen only when the form is completely filled in:

<?code-excerpt "lib/step2.dart (on-pressed)"?>
```dart
TextButton(
  style: ButtonStyle(
    foregroundColor: WidgetStateProperty.resolveWith((states) {
      return states.contains(WidgetState.disabled)
          ? null
          : Colors.white;
    }),
    backgroundColor: WidgetStateProperty.resolveWith((states) {
      return states.contains(WidgetState.disabled)
          ? null
          : Colors.blue;
    }),
  ),
  onPressed:
      _formProgress == 1 ? _showWelcomeScreen : null, // UPDATED
  child: const Text('Sign up'),
),
```

</li>

<li>

Run the app.<br>
The **Sign up** button is initially disabled,
but becomes enabled when all three text fields contain
(any) text.

</li>
</ol>

### Observations {:.no_toc}

* Calling a widget's `setState()` method tells Flutter that the
  widget needs to be updated on screen.
  The framework then disposes of the previous immutable widget
  (and its children), creates a new one
  (with its accompanying child widget tree),
  and renders it to screen. For this to work seamlessly,
  Flutter needs to be fast.
  The new widget tree must be created and rendered to screen
  in less than 1/60th of a second to create a smooth visual
  transition—especially for an animation.
  Luckily Flutter _is_ fast.
* The `progress` field is defined as a floating value,
  and is updated in the `_updateFormProgress` method.
  When all three fields are filled in, `_formProgress` is set to 1.0.
  When `_formProgress` is set to 1.0, the `onPressed` callback is set to the
  `_showWelcomeScreen` method. Now that its `onPressed` argument is non-null, the button is enabled.
  Like most Material Design buttons in Flutter,
  [TextButton][]s are disabled by default if their `onPressed` and `onLongPress` callbacks are null.
* Notice that the `_updateFormProgress` passes a function to `setState()`.
  This is called an anonymous
  function and has the following syntax:

  ```dart
  methodName(() {...});
  ```
  
  Where `methodName` is a named function that takes an anonymous
  callback function as an argument.
* The Dart syntax in the last step that displays the
  welcome screen is:
  <?code-excerpt "lib/step2.dart (ternary)" replace="/, \/\/ UPDATED//g"?>
  ```dart
  _formProgress == 1 ? _showWelcomeScreen : null
  ```
  This is a Dart conditional assignment and has the syntax:
  `condition ? expression1 : expression2`.
  If the expression `_formProgress == 1` is true, the entire expression results
  in the value on the left hand side of the `:`, which is the
  `_showWelcomeScreen` method in this case.

## Step 2.5: Launch Dart DevTools

How do you debug a Flutter web app?
It's not too different from debugging any Flutter app.
You want to use [Dart DevTools][]!
(Not to be confused with Chrome DevTools.)

Our app currently has no bugs, but let's check it out anyway.
The following instructions for launching DevTools applies to any workflow,
but there is a shortcut if you're using IntelliJ.
See the tip at the end of this section for more information.

<ol>
<li>

Run the app.<br>
If your app isn't currently running, launch it.
Select the **Chrome** device from the pull down
and launch it from your IDE or,
from the command line, use `flutter run -d chrome`.

</li>

<li>

Get the web socket info for DevTools.<br>
At the command line, or in the IDE,
you should see a message stating something like the following:

```console
Launching lib/main.dart on Chrome in debug mode...
Building application for the web...                                11.7s
Attempting to connect to browser instance..
Debug service listening on <b>ws://127.0.0.1:54998/pJqWWxNv92s=</b>
```

Copy the address of the debug service, shown in bold.
You will need that to launch DevTools.

</li>

<li>

Ensure that the Dart and Flutter plugins are installed.<br>
If you are using an IDE,
make sure you have the Flutter and Dart plugins set up,
as described in the [VS Code][] and
[Android Studio and IntelliJ][] pages.
If you are working at the command line,
launch the DevTools server as explained in the
[DevTools command line][] page.

</li>

<li>

Connect to DevTools.<br>
When DevTools launches, you should see something
like the following:

```console
Serving DevTools at http://127.0.0.1:9100
```

Go to this URL in a Chrome browser. You should see the DevTools
launch screen. It should look like the following:

![Screenshot of the DevTools launch screen](/assets/images/docs/get-started/devtools-launch-screen.png){:width="100%"}

</li>

<li>

Connect to running app.<br>
Under **Connect to a running site**,
paste the web socket (ws) location that you copied in step 2,
and click **Connect**. You should now see Dart DevTools
running successfully in your Chrome browser:

![Screenshot of DevTools running screen](/assets/images/docs/get-started/devtools-running.png){:width="100%"}

Congratulations, you are now running Dart DevTools!

</li>
</ol>

:::note
This is not the only way to launch DevTools.
If you are using IntelliJ,
you can open DevTools by going to
**Flutter Inspector** -> **More Actions** -> **Open DevTools**:

![Screenshot of Flutter inspector with DevTools menu](/assets/images/docs/get-started/intellij-devtools.png){:width="100%"}
:::

<ol>
<li>

Set a breakpoint.<br>
Now that you have DevTools running,
select the **Debugger** tab in the blue bar along the top.
The debugger pane appears and, in the lower left,
see a list of libraries used in the example.
Select `lib/main.dart` to display your Dart code
in the center pane.

![Screenshot of the DevTools debugger](/assets/images/docs/get-started/devtools-debugging.png){:width="100%"}

</li>

<li>

Set a breakpoint.<br>
In the Dart code,
scroll down to where `progress` is updated:

<?code-excerpt "lib/step2.dart (for-loop)"?>
```dart
for (final controller in controllers) {
  if (controller.value.text.isNotEmpty) {
    progress += 1 / controllers.length;
  }
}
```

Place a breakpoint on the line with the for loop by clicking to the
left of the line number. The breakpoint now appears
in the **Breakpoints** section to the left of the window.

</li>

<li>

Trigger the breakpoint.<br>
In the running app, click one of the text fields to gain focus.
The app hits the breakpoint and pauses.
In the DevTools screen, you can see on the left
the value of `progress`, which is 0. This is to be expected,
since none of the fields are filled in.
Step through the for loop to see
the program execution.

</li>

<li>

Resume the app.<br>
Resume the app by clicking the green **Resume**
button in the DevTools window.

</li>

<li>

Delete the breakpoint.<br>
Delete the breakpoint by clicking it again, and resume the app.

</li>
</ol>

This gives you a tiny glimpse of what is possible using DevTools,
but there is lots more! For more information,
see the [DevTools documentation][].

## Step 3: Add animation for sign in progress

It's time to add animation! In this final step,
you'll create the animation for the
`LinearProgressIndicator` at the top of the sign in
area. The animation has the following behavior:

* When the app starts,
  a tiny red bar appears across the top of the sign in area.
* When one text field contains text,
  the red bar turns orange and animates 0.15
  of the way across the sign in area.
* When two text fields contain text,
  the orange bar turns yellow and animates half
  of the way across the sign in area.
* When all three text fields contain text,
  the orange bar turns green and animates all the
  way across the sign in area.
  Also, the **Sign up** button becomes enabled.

<ol>
<li>

Add an `AnimatedProgressIndicator`.<br>
At the bottom of the file, add this widget:

<?code-excerpt "lib/step3.dart (animated-progress-indicator)"?>
```dart
class AnimatedProgressIndicator extends StatefulWidget {
  final double value;

  const AnimatedProgressIndicator({
    super.key,
    required this.value,
  });

  @override
  State<AnimatedProgressIndicator> createState() {
    return _AnimatedProgressIndicatorState();
  }
}

class _AnimatedProgressIndicatorState extends State<AnimatedProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _curveAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    final colorTween = TweenSequence([
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

    _colorAnimation = _controller.drive(colorTween);
    _curveAnimation = _controller.drive(CurveTween(curve: Curves.easeIn));
  }

  @override
  void didUpdateWidget(AnimatedProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.animateTo(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => LinearProgressIndicator(
        value: _curveAnimation.value,
        valueColor: _colorAnimation,
        backgroundColor: _colorAnimation.value?.withValues(alpha: 0.4),
      ),
    );
  }
}
```

The [`didUpdateWidget`][] function updates
the `AnimatedProgressIndicatorState` whenever
`AnimatedProgressIndicator` changes.

</li>

<li>

Use the new `AnimatedProgressIndicator`.<br>
Then, replace the `LinearProgressIndicator` in the `Form`
with this new `AnimatedProgressIndicator`:

<?code-excerpt "lib/step3.dart (use-animated-progress-indicator)"?>
```dart
child: Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    AnimatedProgressIndicator(value: _formProgress), // NEW
    Text('Sign up', style: Theme.of(context).textTheme.headlineMedium),
    Padding(
```

This widget uses an `AnimatedBuilder` to animate the
progress indicator to the latest value.

</li>

<li>

Run the app.<br>
Type anything into the three fields to verify that
the animation works, and that clicking the
**Sign up** button brings up the **Welcome** screen.

</li>
</ol>

### Complete sample

<?code-excerpt "lib/main.dart"?>
```dartpad title="Flutter complete getting started hands-on example in DartPad" run="true"
import 'package:flutter/material.dart';

void main() => runApp(const SignUpApp());

class SignUpApp extends StatelessWidget {
  const SignUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const SignUpScreen(),
        '/welcome': (context) => const WelcomeScreen(),
      },
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: const Center(
        child: SizedBox(
          width: 400,
          child: Card(
            child: SignUpForm(),
          ),
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome!',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _usernameTextController = TextEditingController();

  double _formProgress = 0;

  void _updateFormProgress() {
    var progress = 0.0;
    final controllers = [
      _firstNameTextController,
      _lastNameTextController,
      _usernameTextController
    ];

    for (final controller in controllers) {
      if (controller.value.text.isNotEmpty) {
        progress += 1 / controllers.length;
      }
    }

    setState(() {
      _formProgress = progress;
    });
  }

  void _showWelcomeScreen() {
    Navigator.of(context).pushNamed('/welcome');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      onChanged: _updateFormProgress,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedProgressIndicator(value: _formProgress),
          Text('Sign up', style: Theme.of(context).textTheme.headlineMedium),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: _firstNameTextController,
              decoration: const InputDecoration(hintText: 'First name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: _lastNameTextController,
              decoration: const InputDecoration(hintText: 'Last name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              controller: _usernameTextController,
              decoration: const InputDecoration(hintText: 'Username'),
            ),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                return states.contains(WidgetState.disabled)
                    ? null
                    : Colors.white;
              }),
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                return states.contains(WidgetState.disabled)
                    ? null
                    : Colors.blue;
              }),
            ),
            onPressed: _formProgress == 1 ? _showWelcomeScreen : null,
            child: const Text('Sign up'),
          ),
        ],
      ),
    );
  }
}

class AnimatedProgressIndicator extends StatefulWidget {
  final double value;

  const AnimatedProgressIndicator({
    super.key,
    required this.value,
  });

  @override
  State<AnimatedProgressIndicator> createState() {
    return _AnimatedProgressIndicatorState();
  }
}

class _AnimatedProgressIndicatorState extends State<AnimatedProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _curveAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    final colorTween = TweenSequence([
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

    _colorAnimation = _controller.drive(colorTween);
    _curveAnimation = _controller.drive(CurveTween(curve: Curves.easeIn));
  }

  @override
  void didUpdateWidget(AnimatedProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.animateTo(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => LinearProgressIndicator(
        value: _curveAnimation.value,
        valueColor: _colorAnimation,
        backgroundColor: _colorAnimation.value?.withValues(alpha: 0.4),
      ),
    );
  }
}
```

### Observations {:.no_toc}

* You can use an `AnimationController` to run any animation.
* `AnimatedBuilder` rebuilds the widget tree when the value
  of an `Animation` changes.
* Using a `Tween`, you can interpolate between almost any value,
  in this case, `Color`.

## What next?

Congratulations!
You have created your first web app using Flutter!

If you'd like to continue playing with this example,
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

[Android Studio and IntelliJ]: /tools/devtools/android-studio
[Animation docs]: /ui/animations
[Building a form with validation]: /cookbook/forms/validation
[Chrome browser]: https://www.google.com/chrome/?brand=CHBD&gclid=CjwKCAiAws7uBRAkEiwAMlbZjlVMZCxJDGAHjoSpoI_3z_HczSbgbMka5c9Z521R89cDoBM3zAluJRoCdCEQAvD_BwE&gclsrc=aw.ds
[create a new Flutter project]: /get-started/test-drive
[Dart DevTools]: /tools/devtools
[DartPad]: {{site.dartpad}}
[DevTools command line]: /tools/devtools/cli
[DevTools documentation]: /tools/devtools
[DevTools installed]: /tools/devtools#start
[DartPad troubleshooting page]: {{site.dart-site}}/tools/dartpad/troubleshoot
[`didUpdateWidget`]: {{site.api}}/flutter/widgets/State/didUpdateWidget.html
[editor]: /get-started/editor
[Effective Dart Style Guide]: {{site.dart-site}}/guides/language/effective-dart/style#dont-use-a-leading-underscore-for-identifiers-that-arent-private
[Flutter cookbook]: /cookbook
[Flutter SDK]: /get-started/install
[Implicit animations]: /codelabs/implicit-animations
[Introduction to declarative UI]: /get-started/flutter-for/declarative
[Material Design]: {{site.material}}/get-started
[TextButton]: {{site.api}}/flutter/material/TextButton-class.html
[VS Code]: /tools/devtools/vscode
[Web samples]: {{site.repo.samples}}/tree/main/web
[Widget]: {{site.api}}/flutter/widgets/Widget-class.html
[first_flutter_codelab]: /get-started/codelab
