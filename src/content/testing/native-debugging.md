---
title: Use a native language debugger
short-title: debuggers
description: How to connect a native debugger to your running Flutter app.
---

<?code-excerpt path-base="testing/native_debugging"?>

:::note
This guide presumes you understand general debugging,
have installed Flutter and git, and have familiarity
with the Dart language as well as one of the following
languages: Java, Kotlin, Swift, or Objective-C.
:::

If you write Flutter apps only with Dart code,
you can debug your code using your IDE's debugger.
The Flutter team recommends VS Code.

If you write a platform-specific plugin or
use platform-specific libraries, you can debug
that portion of your code with a native debugger.

- To debug iOS or macOS code written in Swift or Objective-C,
  you can use Xcode.
- To debug Android code written in Java or Kotlin,
  you can use Android Studio.
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

    ```console
    $ flutter create my_app
    ```

    ```console
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

    ```console
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

   a. In `main.dart`, click on this line:

      ```dart
      _counter++;
      ```

   b. Press <kbd>Shift</kbd> + <kbd>F9</kbd>.
      This adds a breakpoint where the
      `_counter` variable increments.

   c. In the app, click the **+** button
      to increment the counter. The app pauses.

{% comment %}
      ![Flutter test app paused](/assets/images/docs/testing/debugging/native/macos/basic-app.png){:width="50%"}
      <div class="figure-caption">

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

| Highlight Color in Screenshot | Bar, Panel, or Tab  | Contents                                                                          |
|-------------------------------|---------------------|-----------------------------------------------------------------------------------|
| **Yellow**                    | Variables           | List of current values of variables in the Flutter app                            |
|                               | Watch               | List of items you chose to track in the Flutter app                               |
|                               | Call Stack          | Stack of active subroutines in the Flutter app                                    |
|                               | Breakpoints         | List of exceptions and set breakpoints that you set                               |
| **Green**                     | `<Flutter files>`   | Files that you are editing                                                        |
| **Pink**                      | Widget Inspector    | Hierarchy of widgets in the running Flutter app                                   |
| **Blue**                      | Layout Explorer     | Visual of how Flutter placed the widget you selected in the Widget Inspector      |
|                               | Widget Details Tree | List of properties of the widget selected in the Widget Inspector                 |
| **Orange**                    | Problems            | List of issues the Dart analyzer found in the current Dart file                   |
|                               | Output              | Response that the Flutter app returns when building an app                        |
|                               | Debug Console       | Logs or error messages that the Flutter app generates while debugging             |
|                               | Terminal            | System shell prompt contained in VS Code                                          |

{:.table .table-striped}

To change where the panel (in **orange**) appears in VS Code,
go to **View** > **Appearance** > **Panel Position**.

#### VS Code Flutter debugging toolbar

The toolbar allows you to debug using any debugger.
You can step in, out, and over Dart statements, hot reload, or resume the app.

![Flutter debugger toolbar in VS Code](/assets/images/docs/testing/debugging/vscode-ui/screens/debug-toolbar.png)

| Icon                                                | Action                | Default keyboard shortcut                             |
|-----------------------------------------------------|-----------------------|-------------------------------------------------------|
| {% render docs/vscode-flutter-bar/play.md %}        | Start or Resume       | <kbd>F5</kbd>                                         |
| {% render docs/vscode-flutter-bar/pause.md %}       | Pause                 | <kbd>F6</kbd>                                         |
| {% render docs/vscode-flutter-bar/step-over.md %}   | Step Over             | <kbd>F10</kbd>                                        |
| {% render docs/vscode-flutter-bar/step-into.md %}   | Step Into             | <kbd>F11</kbd>                                        |
| {% render docs/vscode-flutter-bar/step-out.md %}    | Step Out              | <kbd>Shift</kbd> + <kbd>F11</kbd>                     |
| {% render docs/vscode-flutter-bar/hot-reload.md %}  | Hot Reload            | <kbd>Ctrl</kbd> + <kbd>F5</kbd>                       |
| {% render docs/vscode-flutter-bar/hot-restart.md %} | Hot Restart           | <kbd>Shift</kbd> + <kbd>Special</kbd> + <kbd>F5</kbd> |
| {% render docs/vscode-flutter-bar/stop.md %}        | Stop                  | <kbd>Shift</kbd> + <kbd>F5</kbd>                      |
| {% render docs/vscode-flutter-bar/inspector.md %}   | Open Widget Inspector |                                                       |

{:.table .table-striped}

## Update test Flutter app

For the remainder of this guide, you need to update the
test Flutter app. This update adds native code to debug.

1. Open the `lib/main.dart` file using your preferred IDE.

1. Replace the contents of `main.dart` with the following code.

    <details>
    <summary>Expand to see Flutter code for this example</summary>

    ```dart title="lib/main.dart"
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

      Future<void> _launchInWebView(Uri url) async {
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
            path: 'testing/native-debugging');
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
                    _launched = _launchInWebView(toLaunch);
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

1. To add the `url_launcher` package as a dependency,
   run `flutter pub add`:

    ```console
    $ flutter pub add url_launcher
    ```

    ```console
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

1. To check what changed with the codebase:

   {: type="a"}
   1. In Linux or macOS, run this `find` command.

      ```console
      $ find ./ -mmin -120 
      ```

      ```console
      ./ios/Flutter/Debug.xcconfig
      ./ios/Flutter/Release.xcconfig
      ./linux/flutter/generated_plugin_registrant.cc
      ./linux/flutter/generated_plugins.cmake
      ./macos/Flutter/Flutter-Debug.xcconfig
      ./macos/Flutter/Flutter-Release.xcconfig
      ./macos/Flutter/GeneratedPluginRegistrant.swift
      ./pubspec.lock
      ./pubspec.yaml
      ./windows/flutter/generated_plugin_registrant.cc
      ./windows/flutter/generated_plugins.cmake
      ```
   1. In Windows, run this command in the command prompt.

      ```powershell
      Get-ChildItem C:\dev\example\ -Rescurse | Where-Object {$_.LastWriteTime -gt (Get-Date).AddDays(-1)}
      ```

      ```powershell
      C:\dev\example\ios\Flutter\


      Mode                LastWriteTime         Length Name
      ----                -------------         ------ ----
                      8/1/2025   9:15 AM                Debug.xcconfig
                      8/1/2025   9:15 AM                Release.xcconfig

      C:\dev\example\linux\flutter\


      Mode                LastWriteTime         Length Name
      ----                -------------         ------ ----
                      8/1/2025   9:15 AM                generated_plugin_registrant.cc
                      8/1/2025   9:15 AM                generated_plugins.cmake

      C:\dev\example\macos\Flutter\


      Mode                LastWriteTime         Length Name
      ----                -------------         ------ ----
                      8/1/2025   9:15 AM                Flutter-Debug.xcconfig
                      8/1/2025   9:15 AM                Flutter-Release.xcconfig
                      8/1/2025   9:15 AM                GeneratedPluginRegistrant.swift

      C:\dev\example\


      Mode                LastWriteTime         Length Name
      ----                -------------         ------ ----
                      8/1/2025   9:15 AM                pubspec.lock
                      8/1/2025   9:15 AM                pubspec.yaml

      C:\dev\example\windows\flutter\


      Mode                LastWriteTime         Length Name
      ----                -------------         ------ ----
                      8/1/2025   9:15 AM                generated_plugin_registrant.cc
                      8/1/2025   9:15 AM                generated_plugins.cmake
      ```

Installing `url_launcher` added config files and code files
for all target platforms in the Flutter app directory.

## Debug Dart and native language code at the same time

This section explains how to debug the Dart code in your Flutter app
and any native code with its regular debugger.
This capability allows you to leverage Flutter's hot reload
when editing native code.

### Debug Dart and Android code using Android Studio

To debug native Android code, you need a Flutter app that contains
Android code. In this section, you learn how to connect
the Dart, Java, and Kotlin debuggers to your app.
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

Check out the following resources on debugging Flutter, iOS, Android,
macOS and Windows:

### Flutter

- [Debugging Flutter apps][]
- [Flutter inspector][] and the [DevTools][] docs
- [Performance profiling][]

[Debugging Flutter apps]: /testing/debugging
[Performance profiling]: /perf/ui-performance

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
[DevTools]: /tools/devtools
[Flutter inspector]: /tools/devtools/inspector
[Instruments Help]: https://help.apple.com/instruments/mac/current/
[Microsoft Learn]: https://learn.microsoft.com/visualstudio/
[Visual Studio Debugger]: https://learn.microsoft.com/visualstudio/debugger/?view=vs-2022
[Learn to debug C++ code using Visual Studio]: https://learn.microsoft.com/visualstudio/debugger/getting-started-with-the-debugger-cpp?view=vs-2022
