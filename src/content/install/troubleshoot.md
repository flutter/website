---
title: Troubleshooting installation
shortTitle: Troubleshoot
description: >-
  Get help with common installation issues that new
  Flutter developers might have run into.
---

This page describes some common installation issues that
new Flutter users have encountered and offers suggestions
on how to resolve them.

If you are still experiencing problems after
using this page, consider reaching out to any of
the resources listed under [community support channels][].
To add a topic to this page or make a correction,
you can [file an issue][] or
submit a [pull request][] on GitHub.

[community support channels]: #community-support
[file an issue]: {{site.github}}/flutter/website/issues/new
[pull request]: {{site.github}}/flutter/website/pulls

## Get the Flutter SDK

### Unable to find the `flutter` command

__What does this issue look like?__

When you try to run the `flutter` command,
the console fails to find it.
The error usually looks as follows:

```plaintext
'flutter' is not recognized as an internal or external command operable program or batch file
```

Error messages on macOS and Linux could look slightly different from
the one on Windows.

__Explanation and suggestions__

Did you add Flutter to the `PATH` environment variable for your platform?
On Windows, follow these [instructions for adding a command
to your path][windows path].

If you've already [set up VS Code][] for Flutter development,
you can use the Flutter extension's **Locate SDK** prompt
to identify the location of your `flutter` folder.

See also: [Configuring PATH and Environment Variables - Dart Code][config path]

[windows path]: https://www.wikihow.com/Change-the-PATH-Environment-Variable-on-Windows
[set up VS Code]: /tools/vs-code#setup
[config path]: https://dartcode.org/docs/configuring-path-and-environment-variables/

### Flutter in special folders


__What does this issue look like?__

Running your Flutter project produces an error like the following:

```plaintext
The Flutter SDK is installed in a protected folder and may not function correctly.
Please move the SDK to a location that is user-writable without Administration permissions and restart.
```

__Explanation and suggestions__

On Windows, this usually happens when Flutter is installed
in a directory like
`C:\Program Files\` that requires elevated privileges.
Try relocating Flutter to a different folder,
such as `C:\src\flutter`.

## Android setup

### Having multiple versions of Java installed

__What does this issue look like?__

The command `flutter doctor --android-licenses` fails.
Running `flutter doctor --verbose` gives an error message
like the following:

```plaintext
java.lang.UnsupportedClassVersionError: com/android/prefs/AndroidLocationsProvider
has been compiled by a more recent version of the Java Runtime (class file version 55.0),
this version of the Java Runtime only recognizes class file versions up to 52.0
```

__Explanation and suggestions__

The error occurs when an older version of the
Java Development Kit (JDK)
is installed on your computer.

If you don't need multiple versions of Java,
uninstall existing JDKs from your computer.
Flutter automatically uses the JDK included in Android Studio.

If you do need another version of Java,
try the workaround described in
[this GitHub issue][java binary path]
until a long-term solution is implemented.
For more information,
check out the [Android Java Gradle migration guide][]
or [flutter doctor --android-licenses not working due to
    java.lang.UnsupportedClassVersionError - Stack Overflow][so java version].

[java binary path]: {{site.repo.flutter}}/issues/106416#issuecomment-1522198064
[Android Java Gradle migration guide]: /release/breaking-changes/android-java-gradle-migration-guide
[so java version]: {{site.so}}/questions/75328050/

### `cmdline-tools` component is missing

__What does this issue look like?__

The `flutter doctor` command complains that the
`cmdline-tools` are missing from the Android toolchain.
For example:

```plaintext noHighlight
[!] Android toolchain - develop for Android devices (Android SDK version 33.0.2)
    • Android SDK at C:\Users\My PC\AppData\Local\Android\sdk
    X cmdline-tools component is missing
```

__Explanation and suggestions__

The easiest way to get the cmdline-tools is through the
SDK Manager in Android Studio.
To do this, use the following instructions:

1. Open the SDK Manager from Android Studio by
   selecting **Tools > SDK Manager** from the menu bar.
2. Select the latest Android SDK
   (or a specific version that your app requires),
   Android SDK Command-line Tools, and Android SDK Build-Tools.
3. Click **Apply** to install the selected artifacts.

![Android Studio SDK Manager](/assets/images/docs/get-started/install_android_tools.png)

If you're not using Android Studio,
you can download the tools using the
[sdkmanager][] command-line tool.

[sdkmanager]: {{site.android-dev}}/studio/command-line/sdkmanager

## macOS setup

### SocketException: Send failed, OS Error: No route to host, errno = 65

__What does this issue look like?__

On macOS, the `flutter run` command produces an error like:

```plaintext
$ flutter run
Launching lib/main.dart in debug mode...
...
Installing and launching...
Oops; flutter has exited unexpectedly: "SocketException: Send failed (OS Error: No route to host, errno = 65), address = 0.0.0.0, port = 5353".
```

__Explanation and suggestions__

This issue is related to macOS permissions.

To fix this:

1. Upgrade your Flutter SDK to the latest version.

2. Open **System Settings** > **Privacy & Security** > **Local Network**.
   Toggle on the permission for all the code editors and terminals you use to
   launch Flutter apps.
   You might need to restart your code editor, terminal, and physical device.

## Other problems

### Exit code 69

__What does this issue look like?__

Running a `flutter` command produces an "exit code: 69" error,
as shown in the following example:

```plaintext
Running "flutter pub get" in flutter_tools...
Resolving dependencies in .../flutter/packages/flutter_tools... (28.0s)
Got TLS error trying to find package test at https://pub.dev/.
pub get failed
command:
".../flutter/bin/cache/dart-sdk/bin/
dart __deprecated_pub --color --directory
.../flutter/packages/flutter_tools get --example"
pub env: {
  "FLUTTER_ROOT": ".../flutter",
  "PUB_ENVIRONMENT": "flutter_cli:get",
  "PUB_CACHE": ".../.pub-cache",
}
exit code: 69
```

__Explanation and suggestions__

This issue is related to networking.
Try the following instructions to troubleshoot:

* Check your internet connection.
  Make sure that you're connected to the
  internet and that your connection is stable.
* Restart your devices, including your computer
  and networking equipment.
* Use a VPN to help to bypass any restrictions that
  might prevent you from connecting to the network.
* If you have tried all of these steps and are
  still getting the error, print out verbose logs
  with the `flutter doctor -v` command and ask for help in
  one of the [community support channels][].

[community support channels]: #community-support

## Community support

The Flutter community is helpful and welcoming.
If none of the above suggestions solves your installation issue,
consider asking for support from one of the following channels:

* [/r/flutterhelp](https://www.reddit.com/r/flutterhelp/) on Reddit
* [/r/flutterdev](https://discord.gg/rflutterdev) on Discord,
  particularly the `install-and-setup` channel on this server.
* [StackOverflow][],
  in particular, questions tagged with [#flutter][] or [#dart][].

To be respectful of everyone's time,
search the archive for a similar issue before posting a new one.

[StackOverflow]: {{site.so}}
[#dart]: {{site.so}}/questions/tagged/dart
[#flutter]: {{site.so}}/questions/tagged/flutter
