---
title: Use a native language debugger
short-title: debuggers
description: How to connect a native debugger to your running Flutter app.
---

<?code-excerpt path-base="testing/native_debugging"?>

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

- To debug iOS code written in Swift or ObjectiveC, you can use Xcode.
- To debug Android code written in Java or Kotlin, you can use Gradle.
- To debug Windows code written in C++, you can use Visual Studio.

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
    $ flutter create my_app
    ```

    ```terminal
    Creating project my_app...
    Resolving dependencies in my_app... 
    Got dependencies in my_app.
    Wrote 129 files.

    All done!
    You can find general documentation for Flutter at: https://docs.flutter.dev/
    Detailed API documentation is available at: https://api.flutter.dev/
    If you prefer video documentation, consider: https://www.youtube.com/c/flutterdev

    In order to run your application, type:

      $ cd my_app
      $ flutter run

    Your application code is in my_app/lib/main.dart.
    ```

    ```terminal
    $ cd my_app
    ```

1. Open the `lib\main.dart` file in the Flutter app using
   VS Code.

1. Click the bug icon
   (![VS Code's bug icon to trigger the debugging mode of a Flutter app](/assets/images/docs/testing/debugging/vscode-ui/icons/debug.png)).
   This opens the following panes in VS Code:

   - **Debug**
   - **Debug Console**
   - **Widget Inspector**

   The first time you run the debugger takes the longest.

{% comment %}
   ![VS Code window with debug panes opened](/assets/images/docs/testing/debugging/vscode-ui/screens/vscode-debugger.png){:width="100%"}
{% endcomment %}

1. Test the debugger.

   a. In `main.dart`, click on line 67.

   b. Type <kbd>Shift</kbd> + <kbd>F9</kbd>.
      This adds a breakpoint where the
      `_counter` variable increments.

   c. In the app, click the **+** button
      to increment the counter. The app pauses.

{% comment %}
      ![Flutter test app paused](/assets/images/docs/testing/debugging/native/macos/basic-app.png){:width="50%"}
      <div markdown="1">{:.figure-caption}
      Default Flutter app as rendered on macOS.
      </div>
{% endcomment %}

    d. At this point, VS Code displays:

      - In the **Editor Groups**:
        - The highlighted breakpoint in `main.dart`
        - The widget hierarchy for the Flutter app
          in the **Widget Tree** of the **Widget Inspector** 
      - In the **side bar**:
        - The state of the app in the **Call Stack** section
        - The value of the `this` local variable in the **Variables** section
      - In the **panel**:
        - The log of the Flutter app in the **Debug console**

{% comment %}
      ![VS Code window with Flutter app paused](/assets/images/docs/testing/debugging/vscode-ui/screens/vscode-debugger-paused.png){:width="100%"}
{% endcomment %}

### VS Code Flutter debugger

The Flutter plugin for VS Code adds a number of components
to the VS Code user interface.

#### Changes to VS Code interface

When launched, the Flutter debugger adds debugging tools to the
VS Code interface.

The following screenshot and table explain the purpose of each tool.

![VS Code with the Flutter plugin UI additions](/assets/images/docs/testing/debugging/vscode-ui/screens/debugger-parts.png)

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
go to **View** > **Appearance** > **Panel Position**.

#### VS Code Flutter debugging toolbar

The toolbar allows you to debug as any debugger.
You can step in, out, and over Dart statements, hot reload or resume the app.

![Flutter debugger toolbar in VS Code](/assets/images/docs/testing/debugging/vscode-ui/screens/debug-toolbar.png)

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

    <details>
    <summary>Expand to see Flutter code for this example</summary>

    <?code-excerpt title="lib/main.dart"?>
    ```dart
    // Copyright 2023 The Flutter Authors. All rights reserved.
    // Use of this source code is governed by a BSD-style license that can be
    // found in the LICENSE file.

    import 'package:flutter/material.dart';
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
            useMaterial3: true,
            colorSchemeSeed: Colors.purple,
            brightness: Brightness.light,
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
                FilledButton(
                  onPressed: () => setState(() {
                    _launched = _launchInBrowser(toLaunch);
                  }),
                  child: const Text('Launch in browser'),
                ),
                const Padding(padding: EdgeInsets.all(16)),
                FilledButton(
                  onPressed: () => setState(() {
                    _launched = _launchInWebViewOrVC(toLaunch);
                  }),
                  child: const Text('Launch in app'),
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

    </details>

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

## Debug Dart and native language code at the same time

### Debug Dart and Android code using Android Studio

To debug native Android code, you need a Flutter app that contains
Android code. In this section, you learn how to connect
the Dart and Gradle debuggers to your app.
You don't need VS Code to debug both Dart and Android code.
This guide includes the VS Code instructions to be consistent
with the Xcode and Visual Studio guides.

These section uses the same example Flutter `url_launcher` app created
in [Update test Flutter app](#update-test-flutter-app).

{% include docs/debug/debug-flow-android.md %}

### Debug Dart and iOS code using Xcode

To debug iOS code, you need a Flutter app that contains iOS code.
In this section, you learn to connect two debuggers to your app:
Flutter via VS Code and Xcode. You need to run both VS Code and Xcode.

These section uses the same example Flutter `url_launcher` app created
in [Update test Flutter app](#update-test-flutter-app).

{% include docs/debug/debug-flow-ios.md %}

### Debug Dart and macOS code using Xcode

To debug macOS code, you need a Flutter app that contains macOS code.
In this section, you learn to connect two debuggers to your app:
Flutter via VS Code and Xcode. You need to run both VS Code and Xcode.

These section uses the same example Flutter `url_launcher` app created
in [Update test Flutter app](#update-test-flutter-app).

{% include docs/debug/debug-flow-macos.md %}

### Debug Dart and C++ code using Visual Studio

To debug C++ code, you need a Flutter app that contains C++ code.
In this section, you learn to connect two debuggers to your app:
Flutter via VS Code and Visual Studio.
You need to run both VS Code and Visual Studio.

These section uses the same example Flutter `url_launcher` app created
in [Update test Flutter app](#update-test-flutter-app).

{% include docs/debug/debug-flow-windows.md %}

## Resources

Check out the following resources on debugging Flutter, iOS, and Android:

### Flutter

- [Debugging Flutter apps][]
- [Flutter inspector][] and the [DevTools][] docs.
- [Performance profiling][]

[Debugging Flutter apps]: {{site.url}}/testing/debugging
[Performance profiling]: {{site.url}}/perf/ui-performance

### Android

You can find the following debugging resources on
[developer.android.com][].

- [Debug your app][]
- [Android Debug Bridge (adb)][]

### iOS and macOS

You can find the following debugging resources on
[developer.apple.com][].

- [Debugging][]
- [Instruments Help][]

### Windows

You can find debugging resources on [Microsoft Learn][].

- [Visual Studio Debugger][]
- [Learn to debug C++ code using Visual Studio][]

[Android Debug Bridge (adb)]: {{site.android-dev}}/studio/command-line/adb
[Debug your app]: {{site.android-dev}}/studio/debug
[Debugging]: {{site.apple-dev}}/support/debugging/
[developer.android.com]: {{site.android-dev}}
[developer.apple.com]: {{site.apple-dev}}
[DevTools]: {{site.url}}/tools/devtools
[Flutter inspector]: {{site.url}}/tools/devtools/inspector
[Instruments Help]: https://help.apple.com/instruments/mac/current/
[Microsoft Learn]: https://learn.microsoft.com/en-us/visualstudio/
[Visual Studio Debugger]: https://learn.microsoft.com/en-us/visualstudio/debugger/?view=vs-2022
[Learn to debug C++ code using Visual Studio]: https://learn.microsoft.com/en-us/visualstudio/debugger/getting-started-with-the-debugger-cpp?view=vs-2022
