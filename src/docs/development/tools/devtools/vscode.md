---
title: Install and run DevTools from VS Code
description: Learn how to install and use DevTools from VS Code.
---

## Install the VS Code extensions

To use the DevTools from VS Code, you need the [Dart extension][].
If you're debugging Flutter applications, you should also install
the [Flutter extension][].

## Start an application to debug

Start a debug session for your application by opening the root
folder of your project (the one containing `pubspec.yaml`)
in VS Code and clicking **Run > Start Debugging** (`F5`).

## Launch DevTools

Once the debug session is active and the application has started,
the **Dart: Open DevTools** command becomes available in the
VS Code command palette:

![Screenshot showing Open DevTools command]({% asset tools/vs-code/vscode_command.png @path %}){:width="100%"}

The first time you run this (and subsequently when the DevTools package
is updated), you are prompted to activate or upgrade DevTools.

![Screenshot showing Active DevTools command]({% asset tools/vs-code/vscode_install_prompt.png @path %}){:width="100%"}

Clicking the **Open** button uses `pub global activate` to activate
the DevTools package for you. Next, DevTools launches in your browser and
automatically connects to your debug session.

![Screenshot showing DevTools in a browser]({% asset tools/vs-code/vscode_show_in_browser.png @path %}){:width="100%"}

While DevTools is active, you'll see them in the status bar
of VS Code. If you've closed the browser tab,
you can click the status bar to re-launch your browser, so long
as there's still a suitable Dart/Flutter debugging session available.

![Screenshot showing DevTools in the VS Code status bar]({% asset tools/vs-code/vscode_status_bar.png @path %}){:width="100%"}

[Dart extension]: https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code
[Flutter extension]: https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter
