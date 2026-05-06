---
title: Run DevTools from VS Code
description: Learn how to launch and use DevTools from VS Code.
---

## Add the VS Code extensions

To use the DevTools from VS Code, you need the [Dart extension][].
If you're debugging Flutter applications, you should also install
the [Flutter extension][].

## Start an application to debug {: #run-and-debug}

Start a debug session for your application by opening the root
folder of your project (the one containing `pubspec.yaml`)
in VS Code and clicking **Run > Start Debugging** (`F5`).

## Launch DevTools

Once the debug session is active and the application has started,
the **Open DevTools** commands become available in the
VS Code command palette (`F1`):

![Screenshot showing Open DevTools commands](/assets/images/docs/tools/vs-code/vscode_command.png){:width="100%"}

The chosen tool will be opened embedded inside VS Code.

![Screenshot showing DevTools embedded in VS Code](/assets/images/docs/tools/vs-code/vscode_embedded.png){:width="100%"}

You can choose to have DevTools always opened
in a browser with the `dart.embedDevTools` setting,
and control whether it opens as a full window or
in a new column next to your current editor with the
`dart.devToolsLocation` setting.

A full list of Dart/Flutter settings are available on
[dartcode.org](https://dartcode.org/docs/settings/)
or in the
[VS Code settings editor](https://code.visualstudio.com/docs/getstarted/settings#_settings-editor).
Some recommendation settings for Dart/Flutter in VS Code
can also be found on
[dartcode.org](https://dartcode.org/docs/recommended-settings/).

You can also see whether DevTools is running
and launch it in a browser from the language status area
(the `{}` icon next to **Dart** in the status bar).

![Screenshot showing DevTools in the VS Code language status area](/assets/images/docs/tools/vs-code/vscode_status_bar.png){:width="100%"}

[Dart extension]: https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code
[Flutter extension]: https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter
