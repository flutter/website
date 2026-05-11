---
title: Code formatting
description: >-
  Flutter's code formatter formats your code
  following recommended style guidelines.
---


While your code might follow any preferred style&mdash;in our
experience&mdash;teams of developers might find it more productive to:

* Have a single, shared style, and
* Enforce this style through automatic formatting.

The alternative is often tiring formatting debates during code reviews,
where time might be better spent on code behavior rather than code style.

## Automatically formatting code in VS Code

Install the `Flutter` extension (see [VS Code setup][])
to get automatic formatting of code in VS Code.

To automatically format the code in the current source code window,
right-click in the code window and select `Format Document`.
You can add a keyboard shortcut to this VS Code **Preferences**.

To automatically format code whenever you save a file, set the
`editor.formatOnSave` setting to `true`.

[VS Code setup]: /tools/vs-code#setup

## Automatically formatting code in Android Studio and IntelliJ

Install the `Dart` plugin (see [Android Studio and IntelliJ setup][])
to get automatic formatting of code in Android Studio and IntelliJ.
To format your code in the current source code window:

* On macOS,
  press <kbd>Cmd</kbd> + <kbd>Option</kbd> + <kbd>L</kbd>.
* On Windows and Linux,
  press <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>L</kbd>.

Android Studio and IntelliJ also provide a checkbox named
**Format code on save** on the Flutter page in **Preferences**
on macOS or **Settings** on Windows and Linux.
This option corrects formatting in the current file when you save it.

[Android Studio and IntelliJ setup]: /tools/android-studio#setup

## Automatically formatting code with the `dart` command

To correct code formatting in the command line interface (CLI),
run the `dart format` command:

```console
$ dart format path1 path2 [...]
```

To learn more about the Dart formatter,
check out the dart.dev docs on [`dart format`][].

[`dart format`]: {{site.dart-site}}/tools/dart-format
