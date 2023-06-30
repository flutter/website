---
title: Use a native debugger
short-title: debuggers
description: How to connect a native debugger to your running Flutter app.
---

{{site.alert.note}}
  This guide presumes you understand general debugging,
  have installed Flutter and git, and have familiarity
  with the Dart language as well as one of the following
  languages: Java, Kotlin, Swift, or ObjectiveC.
{{site.alert.end}}

If you write Flutter apps only with Dart code,
you can debug your code using your IDE's debugger.
The Flutter team recommends VS Code.

If you write a platform-specific plugin or
using platform-specific libraries, you can debug
that portion of your code with a native debugger.

- To debug code written in Swift or ObjectiveC, you can use Xcode.
- To debug code written in Java or Kotlin, you can use Android Gradle.

This guide shows you how you can connect _two_
debuggers to your Dart app, one for Dart, and one for the native code.

## Debug Dart code

This guide describes how to use VS Code to debug your Flutter app.
You can also use your preferred IDE with the
Flutter and Dart plugins installed and configured.

## Debug Dart code using VS Code

The following procedure explains how to use the Dart debugger
with the default sample Flutter app.
The featured components in VS Code work and appear when
debugging your own Flutter project as well.

1. Create a basic Flutter app.

    ```terminal
    $ flutter create main_test_app
    ```

    ```terminal
    Creating project main_test_app...
    Resolving dependencies in main_test_app... 
    Got dependencies in main_test_app.
    Wrote 129 files.

    All done!
    You can find general documentation for Flutter at: https://docs.flutter.dev/
    Detailed API documentation is available at: https://api.flutter.dev/
    If you prefer video documentation, consider: https://www.youtube.com/c/flutterdev

    In order to run your application, type:

      $ cd main_test_app
      $ flutter run

    Your application code is in main_test_app/lib/main.dart.
    ```

    ```terminal
    $ cd main_test_app
    ```

1. Open the `lib\main.dart` file in the Flutter app using
   VS Code.

1. Click the bug icon
   (![VS Code's bug icon to trigger the debugging mode of a Flutter app](/assets/images/docs/testing/debugging/oem/vscode-bug.png)).
   This opens the following panes in VS Code:

   - **Debug**
   - **Debug Console**
   - **Widget Inspector**

   The first time you run the debugger takes the longest.

   ![VS Code window with debug panes opened](/assets/images/docs/testing/debugging/oem/vscode-debugger.png){:width="100%"}

1. Test the debugger.

   a. In `main.dart`, click on line 67.

   b. Type <kbd>Shift</kbd> + <kbd>F9</kbd>.
      This adds a breakpoint where the
      `_counter` variable increments.

   c. In the app, click the **+** button
      to increment the counter. The app pauses.

      ![Flutter test app paused](/assets/images/docs/testing/debugging/oem/paused-test-app.png){:width="50%"}

    d. At this point, the app displays:

      - In the **Editor Groups**:
        - The highlighted breakpoint in `main.dart`
        - The widget hierarchy for the Flutter app
          in the **Widget Tree** of the **Widget Inspector** 
      - In the **side bar**:
        - The state of the app in the **Call Stack** section
        - The value of the `this` local variable in the **Variables** section
      - In the **panel**:
        - The log of the Flutter app in the **Debug console**

      ![VS Code window with Flutter app paused](/assets/images/docs/testing/debugging/oem/vscode-debugger-paused.png){:width="100%"}

### VS Code Flutter debugger

The Flutter plugin for VS Code adds a number of components
to the VS Code user interface.

#### Changes to VS Code interface

When launched, the Flutter debugger adds debugging tools to the
VS Code interface.

The following screenshot and table explain the purpose of each tool.

![VS Code with the Flutter plugin UI additions](/assets/images/docs/testing/debugging/vscode-debugger-parts.png)

<div class="table-wrapper" markdown="1">
| Highlight Color in Screenshot | Bar, Panel, or Tab  | Contents                                                                          |
|-------------------------------|---------------------|-----------------------------------------------------------------------------------|
| **Yellow**                    | Variables           | List of current values of variables in the Flutter app                            |
|                               | Watch               | List of items you chose to track in the Flutter app                               |
|                               | Call Stack          | Stack of active subroutines in the Flutter app                                    |
|                               | Breakpoints         | List of exceptions and set breakpoints that you set                               |
| **Green**                     | `<Flutter files>`   | Files that you are editing                                                        |
| **Pink**                      | Widget Inspector    | Hierarchy of widgets in the running Flutter app                                   |
| **Blue**                      | Layout Explorer     | Visual of how the Flutter placed the widget you selected in the Widget Inspector  |
|                               | Widget Details Tree | List of properties of the widget selected in the Widget Inspector                 |
| **Orange**                    | Problems            | List of issues the Flutter linter found in the current Flutter file               |
|                               | Output              | Response that the Flutter app                                                     |
|                               | Debug Console       | Logs or error messages that the Flutter app generates while debugging             |
|                               | Terminal            | System shell prompt contained in VS Code                                          |
{:.table.table-striped}
</div>

To change where the panel (in **orange**) appears in VS Code,
go to **View** -> **Appearance** -> **Panel Position**

#### VS Code Flutter debugging toolbar

The toolbar allows you to debug as any debugger.
You can step in, out, and over Dart statements, hot reload or resume the app.

![Flutter debugger toolbar in VS Code](/assets/images/docs/testing/debugging/vscode-debug-toolbar.png)

<div class="table-wrapper" markdown="1">
| Icon                                                      | Action                | Keyboard Shortcut                                     |
|-----------------------------------------------------------|-----------------------|-------------------------------------------------------|
| {% include_relative vscode-flutter-bar/_play.md %}        | Start or Resume       | <kbd>F5</kbd>                                         |
| {% include_relative vscode-flutter-bar/_pause.md %}       | Pause                 | <kbd>F5</kbd>                                         |
| {% include_relative vscode-flutter-bar/_step-over.md %}   | Step Over             | <kbd>F10</kbd>                                        |
| {% include_relative vscode-flutter-bar/_step-into.md %}   | Step Into             | <kbd>F11</kbd>                                        |
| {% include_relative vscode-flutter-bar/_step-out.md %}    | Step Out              | <kbd>Shift</kbd> + <kbd>F11</kbd>                     |
| {% include_relative vscode-flutter-bar/_hot-reload.md %}  | Hot Reload            | <kbd>Control</kbd> + <kbd>F5</kbd>                    |
| {% include_relative vscode-flutter-bar/_hot-restart.md %} | Hot Restart           | <kbd>Shift</kbd> + <kbd>Special</kbd> + <kbd>F5</kbd> |
| {% include_relative vscode-flutter-bar/_stop.md %}        | Stop                  | <kbd>F5</kbd>                                         |
| {% include_relative vscode-flutter-bar/_inspector.md %}   | Open Widget Inspector |                                                       |
{:.table.table-striped}
</div>

[Test drive]: {{site.url}}/get-started/test-drive

## Update test Flutter app

For the remainder of this guide, you need to update the
test Flutter app. This update adds native code to debug.

1. Open the `lib/main.dart` file using your preferred IDE.

1. Replace the contents of `main.dart` with the following code.

    <?code-excerpt title="main.dart"?>
    ```dart
    // Parts are copyright 2017 The Chromium Authors. All rights reserved.
    // Use of this source code is governed by a BSD-style license that can be
    // found in the LICENSE file.

    import 'dart:async';

    import 'package:flutter/material.dart';
    import 'package:url_launcher/link.dart';
    import 'package:url_launcher/url_launcher.dart';

    void main() {
      runApp(const MyApp());
    }

    class MyApp extends StatelessWidget {
      const MyApp({super.key});

      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'URL Launcher',
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          home: const MyHomePage(title: 'URL Launcher'),
        );
      }
    }

    class MyHomePage extends StatefulWidget {
      const MyHomePage({super.key, required this.title});
      final String title;

      @override
      State<MyHomePage> createState() => _MyHomePageState();
    }

    class _MyHomePageState extends State<MyHomePage> {
      Future<void>? _launched;

      Future<void> _launchInBrowser(Uri url) async {
        if (!await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        )) {
          throw Exception('Could not launch $url');
        }
      }

      Future<void> _launchInWebViewOrVC(Uri url) async {
        if (!await launchUrl(
          url,
          mode: LaunchMode.inAppWebView,
          webViewConfiguration: const WebViewConfiguration(
              headers: <String, String>{'my_header_key': 'my_header_value'}),
        )) {
          throw Exception('Could not launch $url');
        }
      }

      Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const Text('');
        }
      }

      @override
      Widget build(BuildContext context) {
        final Uri toLaunch = Uri(
            scheme: 'https',
            host: 'docs.flutter.dev',
            path: 'testing/oem-debuggers');
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(toLaunch.toString()),
                ),
                ElevatedButton(
                  onPressed: () => setState(() {
                    _launched = _launchInBrowser(toLaunch);
                  }),
                  child: const Text('Launch in browser'),
                ),
                const Padding(padding: EdgeInsets.all(16)),
                ElevatedButton(
                  onPressed: () => setState(() {
                    _launched = _launchInWebViewOrVC(toLaunch);
                  }),
                  child: const Text('Launch in app'),
                ),
                const Padding(padding: EdgeInsets.all(16.0)),
                Link(
                  uri: Uri.parse('https://flutter.dev/'),
                  target: LinkTarget.blank,
                  builder: (BuildContext ctx, FollowLink? openLink) {
                    return TextButton.icon(
                      onPressed: openLink,
                      label: const Text('Flutter.dev'),
                      icon: const Icon(Icons.read_more),
                    );
                  },
                ),
                const Padding(padding: EdgeInsets.all(16.0)),
                FutureBuilder<void>(future: _launched, builder: _launchStatus),
              ],
            ),
          ),
        );
      }
    }
    ```

1. To add the `url_launcher` dependency, run `flutter pub add`:

    ```terminal
    $ flutter pub add url_launcher
    ```

    ```terminal
    Resolving dependencies... 
      collection 1.17.1 (1.17.2 available)
    + flutter_web_plugins 0.0.0 from sdk flutter
      matcher 0.12.15 (0.12.16 available)
      material_color_utilities 0.2.0 (0.8.0 available)
    + plugin_platform_interface 2.1.4
      source_span 1.9.1 (1.10.0 available)
      stream_channel 2.1.1 (2.1.2 available)
      test_api 0.5.1 (0.6.1 available)
    + url_launcher 6.1.11
    + url_launcher_android 6.0.36
    + url_launcher_ios 6.1.4
    + url_launcher_linux 3.0.5
    + url_launcher_macos 3.0.5
    + url_launcher_platform_interface 2.1.3
    + url_launcher_web 2.0.17
    + url_launcher_windows 3.0.6
    Changed 10 dependencies!
    ```

1. To check what changed with the codebase, run `git status`.

    ```terminal
    $ git status
    On branch main
    Changes not staged for commit:
      (use "git add <file>..." to update what will be committed)
      (use "git restore <file>..." to discard changes in working directory)
      modified:   ios/Flutter/Debug.xcconfig
      modified:   ios/Flutter/Release.xcconfig
      modified:   linux/flutter/generated_plugin_registrant.cc
      modified:   linux/flutter/generated_plugins.cmake
      modified:   macos/Flutter/Flutter-Debug.xcconfig
      modified:   macos/Flutter/Flutter-Release.xcconfig
      modified:   macos/Flutter/GeneratedPluginRegistrant.swift
      modified:   pubspec.lock
      modified:   pubspec.yaml
      modified:   windows/flutter/generated_plugin_registrant.cc
      modified:   windows/flutter/generated_plugins.cmake
    ```

    Installing `url_launcher` added config files and code files
    for all target platforms in the Flutter app directory.

## Debug Dart and Native code

### Debug Dart and Android code using Android Studio

To debug native Android code, you need a Flutter app that contains
Android code. In this section, you learn how to connect
the Dart and Android Gradle debuggers to your app.

{{site.alert.note}}
  If you want to use the [GNU Project Debugger][] to debug the
  Flutter engine running within an Android app process,
  check out [`flutter_gdb`][].
{{site.alert.end}}

[GNU Project Debugger]: https://www.sourceware.org/gdb/
[`flutter_gdb`]: https://github.com/flutter/engine/blob/main/sky/tools/flutter_gdb

1. Open the `lib/main.dart` file in Android Studio.

1. Click the debug icon
   (![Tiny green bug superimposed with a light green filled circle](/assets/images/docs/testing/debugging/oem/debug-run.png)).
   This opens the **Debug** pane and launches the app.
   Wait for the app to launch on the device and for the debug pane to
   indicate **Connected**.
   The debugger takes longer to launch the first time.
   Subsequent launches start faster.

   This Flutter app contains two buttons and one link:

   - **Launch in browser**: This button opens this page in the
     default browser of your device.
   - **Launch in app**: This button opens this page within your app.
   - **Flutter.dev**: This link opens https://flutter.dev within your app.

     !['Flutter app showing two buttons to open flutter.dev in a browser or within the app'](/assets/images/docs/testing/debugging/oem/launch-flutter-dev.png){:width="50%"}
     <div markdown="1">
     Flutter app showing two buttons to open flutter.dev in a browser or within the app.
     </div>

1. Click the **Attach debugger to Android process** button.
   (![Tiny green bug superimposed with a light grey arrow](/assets/images/docs/testing/debugging/oem/attach-process-button.png))

    {{site.alert.tip}}
      If this button doesn't appear in the **Projects** menu bar, verify that
      you opened Flutter _application_ project but _not a Flutter plugin_.
    {{site.alert.end}}

1. The **process** dialog displays one entry for each connected device.
   Select **show all processes** to display available processes for each
   device.

1. Choose the process to which you want to attach.
   In following screenshot, the `com.example.my_app` process
   using the **Emulator Pixel_5_API_33** was selected.

   !['Flutter app in Android device displaying two buttons and a link.'](/assets/images/docs/testing/debugging/oem/choose-process-dialog.png){:width="50%"}
   <div markdown="1">
   Flutter app in Android device displaying two buttons and a link.
   </div>

1. Locate the tab for **Android Debugger** in the **Debug** pane.

1. In the **Project** pane, expand
   **_app_name__android > android > app > src > main > java > io.flutter plugins**.

1. Double click **GeneratedProjectRegistrant** to open the
   Java code in the **Edit** pane.
   
   !['The Android Project view highlighting the GeneratedPluginRegistrant.java file.'](/assets/images/docs/testing/debugging/oem/debug-open-java-code.png){:width="100%"}
   <div markdown="1">
   The Android Project view highlighting the `GeneratedPluginRegistrant.java` file.
   </div>

At the end of this procedure, both the Dart and Android debuggers interact
with the same process.
Use either, or both, to set breakpoints, examine stack, resume execution
and the like. In other words, debug!

![The Dart debug pane with two breakpoints set in `lib/main.dart`](/assets/images/docs/testing/debugging/oem/dart-debugger.png){:width="100%"}
<div markdown="1">
The Dart debug pane with two breakpoints set in `lib/main.dart`.
</div>

!['The Android debug pane with one breakpoint set in GeneratedPluginRegistrant.java.'](/assets/images/docs/testing/debugging/oem/android-debugger.png)
<div markdown="1">
The Android debug pane with one breakpoint set in GeneratedPluginRegistrant.java.
</div>

[`url_launcher`]: {{site.url}}/examples/testing/oem_debugging

### Debug Dart and iOS code using Xcode

To debug iOS code, you need a Flutter app that contains iOS code.
In this section, you learn to connect two debuggers to your app:
Flutter and Xcode. You can start from VS Code or Xcode.
These procedures use the same example Flutter `url_launcher` app used
elsewhere in this guide.

1. Open `ios/Runner.xcworkspace` from your Flutter app directory.
1. Run this Runner as a normal app in Xcode.
{% include docs/debug/vscode-flutter-attach.md %}

   !['Running the Debug: Attach to Flutter on Device command in VS Code.'](/assets/images/docs/development/add-to-app/debugging/vscode-attach.png)

## Resources

Check out the following resources on debugging Flutter, iOS, and Android:

### Flutter

- [Debugging Flutter apps][]
- [Flutter inspector][], as well as the general
  [DevTools][] docs.
- [Performance profiling][]

[Debugging Flutter apps]: {{site.url}}/testing/debugging
[Performance profiling]: {{site.url}}/perf/ui-performance

### Android

You can find the following debugging resources on
[developer.android.com][].

- [Debug your app][]
- [Android Debug Bridge (adb)][]

### iOS

You can find the following debugging resources on
[developer.apple.com][].

- [Debugging][]
- [Instruments Help][]

[Android Debug Bridge (adb)]: {{site.android-dev}}/studio/command-line/adb
[Debug your app]: {{site.android-dev}}/studio/debug
[Debugging]: {{site.apple-dev}}/support/debugging/
[developer.android.com]: {{site.android-dev}}
[developer.apple.com]: {{site.apple-dev}}
[DevTools]: {{site.url}}/tools/devtools
[Flutter inspector]: {{site.url}}/tools/devtools/inspector
[Flutter's modes]: {{site.url}}/testing/build-modes
[Instruments Help]: https://help.apple.com/instruments/mac/current/
