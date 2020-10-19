---
title: Using an OEM debugger
short-title: debuggers
description: How to connect an OEM debugger to your running Flutter app.
---

If you are exclusively writing Flutter apps with Dart code and not using
platform-specific libraries, or otherwise accessing platform-specific
features, you can debug your code using your IDE's debugger.
Only the first section of this guide, Debugging Dart code,
is relevant for you.

If you're writing a platform-specific plugin or using platform-specific
libraries written in Swift, ObjectiveC, Java, or Kotlin, you can debug
that portion of your code using Xcode (for iOS) or Android Gradle
(for Android).  This guide shows you how you can connect _two_
debuggers to your Dart app, one for Dart, and one for the OEM code.

## Debugging Dart code

Use your IDE for standard Dart debugging. These instructions describe Android
Studio, but you can use your preferred IDE with the Flutter and Dart
plugins installed and configured.

{{site.alert.tip}}
  Connect to a physical device when debugging, rather than an emulator or
  simulator, which don't support profile mode. For more information, see
  [Flutter's modes][].
{{site.alert.end}}

### Dart debugger

* Open your project in Android Studio. If you don't have a project yet,
  create one using the instructions in [Test drive](/docs/get-started/test-drive).

* Simultaneously bring up the Debug pane and run the app in the Console
  view by clicking the bug icon
  ({% asset 'testing/debugging/oem/debug-run.png' alt='Debug-run icon' %}).

  The first time you launch the app is the slowest.
  You should see the Debug pane appear at the bottom of the window that
  looks something like the following:

  {% asset 'testing/debugging/oem/debug-pane.png' alt='Debug pane' %}{:width="100%"}

  You can configure where the debug pane appears,
  or even tear it off to its own
  window using the gear to the right in the Debug pane bar.
  This is true for any inspector in Android Studio.

* Add a breakpoint on the `counter++` line.

* In the app, click the **+** button (FloatingActionButton,
  or FAB, for short) to increment the counter. The app pauses.

* The following screenshot shows:
  * Breakpoint in the edit pane.
  * State of the app in the debug pane, when paused at the breakpoint.
  * `this` variable expanded to display its values.

  {% asset 'testing/debugging/oem/debug-pane-action.png' alt='App status when hitting the set breakpoint' %}{:width="100%"}

You can step in, out, and over Dart statements, hot reload or resume the app,
and use the debugger in the same way you'd use any debugger.
The **5: Debug** button toggles display of the debug pane.

### Flutter inspector

There are two other features provided by the Flutter plugin that you might
find useful.  The Flutter inspector is a tool for visualizing and exploring
the Flutter widget tree and helps you:

* Understand existing layouts
* Diagnose layout issues

Toggle display of the inspector using the vertical button to the
right of the Android Studio window.

{% asset 'testing/debugging/oem/flutter-inspector.png' alt='Flutter inspector' %}

### Flutter outline

The Flutter Outline displays the build method in visual form.
Note that this might be different than the widget tree for the
build method. Toggle display of the outline using the vertical
button to the right of the AS window.

{% asset 'testing/debugging/oem/flutter-outline.png' alt='screenshot showing the Flutter inspector' %}{:width="100%"}

{% comment %}
TODO: Android Tips - How to assign a keyboard shortcut on the Mac?
{% endcomment %}

The rest of this guide shows how to set up your environment to debug OEM
code. As you'd expect, the process works differently for iOS and Android.

{% comment %}
Considere moving the info below to a new page.
{% endcomment %}

{{site.alert.tip}}
  Become a pro user of Android Studio by installing the **Presentation
  Assistant** plugin. You can find and install this plugin using
  **Preferences** > **Browsing repositories...** and start entering
  _Presen_ in the search field.

  Once installed and AS is relaunched, this plugin helps you to become a
  pro user by:

  * Showing the name and Windows/Linux/Mac shortcuts of any action you
    invoke.
  * Allowing you to search and find available actions, settings, docs,
    and so on.
  * Allowing you to toggle preferences, open up views, or run actions.
  * Allowing you to assign keyboard shortcuts (?? Can't make this work on
    Mac.)

  For example, try this:

  * While focus is in the Edit pane, enter **command-Shift-A** (Mac) or
    **shift-control-A** (Windows and Linux).
    The plugin simultaneously brings up the Find panel and shows a hint for
    performing this same operation on all three platforms.

    {% asset 'testing/debugging/oem/presentation-assistant-find-pane.png' alt='Find panel' %}{:width="100%"}
    <center>Presentation assistant's Find panel</center>

    {% asset 'testing/debugging/oem/presentation-assistant-teaches.png' alt='Find pane' %}{:width="100%"}
    <center>Presentation assistant's action hint for opening its Find panel on Mac, Windows and Linux</center>

  * Enter _attach_ to see the following:

    {% asset 'testing/debugging/oem/presentation-assistant-search-results.png' alt='Find panel' %}

  * After an update, you might enter _Flutter_ or _Dart_ to see if
    new actions are available.

  Hide the Presentation Assistant's Find panel by using **Escape**.
{{site.alert.end}}


## Debugging with Android Gradle (Android)

In order to debug OEM Android code, you need an app that contains
OEM Android code. In this section, you'll learn how to connect
two debuggers to your app: 1) the Dart debugger and,
2) the Android Gradle debugger.

* Create a basic Flutter app.

* Replace `lib/main.dart` with the following example code from the
[`url_launcher`]({{site.pub}}/packages/url_launcher)
package:

{% prettify dart %}
// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'URL Launcher',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'URL Launcher'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _launched;

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    String toLaunch = 'https://flutter.dev';
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(toLaunch),
            ),
            ElevatedButton(
              onPressed: () => setState(() {
                    _launched = _launchInBrowser(toLaunch);
                  }),
              child: Text('Launch in browser'),
            ),
            Padding(padding: EdgeInsets.all(16.0)),
            ElevatedButton(
              onPressed: () => setState(() {
                    _launched = _launchInWebViewOrVC(toLaunch);
                  }),
              child: Text('Launch in app'),
            ),
            Padding(padding: EdgeInsets.all(16.0)),
            FutureBuilder<void>(future: _launched, builder: _launchStatus),
          ],
        ),
      ),
    );
  }
}
{% endprettify %}

* Add the `url_launcher` dependency to the pubspec file,
  and run flutter pub get:

```yaml
name: flutter_app
description: A new Flutter application.
version: 1.0.0+1

dependencies:
  flutter:
    sdk: flutter

  url_launcher: ^3.0.3
  cupertino_icons: ^0.1.2

dev_dependencies:
  flutter_test:
    sdk: flutter
```

* Click the debug icon
  ({% asset 'testing/debugging/oem/debug-run.png' alt='Debug-run icon' %})
  to simultaneously bring up the Debug pane and launch the app.
  Wait for the app to launch on the device, and for the debug pane to
  indicate **Connected**.
  (This can take a minute the first time but is faster for subsequent
   launches.) The app contains two buttons: 1) **Launch in browser**
   opens flutter.dev in your phone's default browser and 2) **Launch
   in app** opens flutter.dev within your app.

  {% asset 'testing/debugging/oem/launch-flutter-dev.png' alt='screenshot containing two buttons for opening flutter.dev' %}

* Click the **Attach debugger to Android process** button (
  {% asset 'testing/debugging/oem/attach-process-button.png' alt='looks like a rectangle superimposed with a tiny green bug' %} )

{{site.alert.tip}}
  If this button doesn't appear in the Projects menu bar, make sure that
  you are inside a Flutter project but <em>not a Flutter plugin</em>.
{{site.alert.end}}

* From the process dialog, you should see an entry for each connected device.
  Select **show all processes** to display available processes for each
  device.

* Choose the process you want to attach to. In this case, it's the
  `com.google.clickcount`
   (or <strong>com.<em>company</em>.<em>app_name</em></strong>)
   process for the Motorola Moto G.

  {% asset 'testing/debugging/oem/choose-process-dialog.png' alt='screenshot containing two buttons for opening flutter.dev' %}{:width="100%"}

* In the debug pane, you should now see a tab for **Android Debugger**.

* In the project pane, expand
  <nobr><strong><em>app_name</em> > android > app > src > main >
  java > io.flutter plugins</strong></nobr>.
  Double click **GeneratedProjectRegistrant** to open the
  Java code in the edit pane.

Both the Dart and OEM debuggers are interacting with the same process.
User either, or both, to set breakpoints, examine stack, resume execution...
In other words, debug!

  {% asset 'testing/debugging/oem/dart-debugger.png' alt='screenshot of Android Studio in the Dart debug pane.' %}{:width="100%"}
  <br><center>The Dart debug pane with two breakpoints set in `lib/main.dart`</center>

  {% asset 'testing/debugging/oem/android-debugger.png' alt='screenshot of Android Studio in the Android debug pane.' %}{:width="100%"}
  <br><center>The Android debug pane with one breakpoint set in
   `GeneratedPluginRegistrant.java`.
  Toggle between the debuggers by clicking the appropriate debugger in
   the Debug pane's banner.</center>

## Debugging with Xcode (iOS)

In order to debug OEM iOS code, you need an app that contains OEM iOS code.
In this section, you'll learn how to connect two debuggers to your app:
1) the Dart debugger and, 2) the Xcode debugger.

[PENDING]

## Resources

The following resources have more information on debugging Flutter,
iOS, and Android:

### Flutter

* [Debugging Flutter apps](/docs/testing/debugging)
* [Flutter inspector][], as well as the general
  [DevTools][] docs.
* [Performance Profiling](/docs/perf/rendering/ui-performance)

### Android

You can find the following debugging resources on
[developer.android.com][].

* [Debug your app][]
* [Android Debug Bridge (adb)][]

### iOS

You can find the following debugging resources on
[developer.apple.com][].

* [Debugging][]
* [Instruments Help][]


[Android Debug Bridge (adb)]: {{site.android-dev}}/studio/command-line/adb
[Debug your app]: {{site.android-dev}}/studio/debug
[Debugging]: https://developer.apple.com/support/debugging/
[developer.android.com]: {{site.android-dev}}
[developer.apple.com]: https://developer.apple.com
[DevTools]: /docs/development/tools/devtools
[Flutter inspector]: /docs/development/tools/devtools/inspector
[Flutter's modes]: /docs/testing/build-modes
[Instruments Help]: https://help.apple.com/instruments/mac/current/
