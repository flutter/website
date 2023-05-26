---
title: Install help
description: This page describes some common installation issues new Flutter users have run into and offers suggestions to resolve them.
---

This page describes some common installation issues new Flutter users have 
encountered and offers suggestions on how to resolve them.
If you are still experiencing problems, consider reaching out to any of
the resources listed under [community support channels][].
To add a topic to this page or make a correction,
you can file an issue or a pull request using the buttons at the top of the page.

## Get the Flutter SDK


### Unable to find the `flutter` command

__What does this issue look like?__

When you try to run the `flutter` command, the console fails to find it. On
Windows, the error usually looks like this:

```
'flutter' is not recognized as an internal or external command operable program or batch file
```

__Explanation and suggestions__

You might have missed steps to add Flutter to the PATH environment variable. On
Windows, you can follow the process demonstrated in [this
video](https://youtu.be/0SRvmcsRu2w?t=137). 

If you’ve already [set up VS Code][set up VS Code] for Flutter development, you
can use the Flutter extension’s “Locate SDK” prompt to identify the location of
your `flutter` folder.

See also: [Configuring PATH and Environment Variables - Dart Code][config path]


### Flutter in special folders


__What does this issue look like?__

Running your Flutter project produces an error like the following:

```
The Flutter SDK is installed in a protected folder and may not function correctly.
Please move the SDK to a location that is user-writable without Administration permissions and restart.
```

__Explanation and suggestions__

On Windows, this usually happens when Flutter is installed in a directory like
`C:\Program Files\` that requires elevated privileges. Try relocating flutter to
a different folder such as `C:\src\flutter`.


## Android setup

### Having multiple versions of Java installed

__What does this issue look like?__ 

The command `flutter doctor --android-licenses` fails.
Running `flutter doctor –verbose` gives an error message like 
the following:

```
java.lang.UnsupportedClassVersionError: com/android/prefs/AndroidLocationsProvider 
has been compiled by a more recent version of the Java Runtime (class file version 55.0), 
this version of the Java Runtime only recognizes class file versions up to 52.0
```

__Explanation and suggestions__

The error occurs when an older version of Java Development Kit (JDK) is
installed on your computer. 

If you don’t need multiple versions of Java, uninstall existing JDKs from your
computer. Flutter will automatically use the JDK included in Android Studio. 

If you do need another version of Java, try the workaround described in [this
Github issue][java binary path] until a long-term solution is implemented. 


See also: [flutter doctor --android-licenses not working due to
    java.lang.UnsupportedClassVersionError - Stack Overflow][so java version]


### `cmdline-tools` component is missing


__What does this issue look like?__

The `flutter doctor` command complains that the
`cmdline-tools` are missing from the Android toolchain.
For example:


```
[!] Android toolchain - develop for Android devices (Android SDK version 33.0.2) 
    • Android SDK at C:\Users\My PC\AppData\Local\Android\sdk 
    X cmdline-tools component is missing 
```


__Explanation and suggestions__

The easiest way you get cmdline-tools is through the SDK Manager in Android
Studio. To open the SDK Manager from Android Studio, click **Tools > SDK
Manager** from the menu bar. 


*   Select the latest Android SDK (or a specific version your app requires),
    Android SDK Command-line Tools, and Android SDK Build-Tools. 
*   Click the **Apply** button to have the selected artifacts installed.

![Android Studio SDK
Manager](/assets/images/docs/get-started/install_android_tools.png)


If you're not using Android Studio, you can download tools using the
[sdkmanager][sdkmanager] command-line tool.


## Other problems


### Exit code 69


__What does this issue look like?__

After running a `flutter` command, you get an error with “exit code: 69” as
shown in the example below:

```
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

The issue is related to networking. Here are a few things you can try to
troubleshoot this:

*   Check your internet connection. Make sure that you are connected to the
    internet and that your connection is stable.
*   Restart your devices, including your computer and networking equipment.
*   Use a VPN. A VPN can help to bypass any restrictions that may be preventing
    you from connecting to the network.
*   If you have tried all of these steps and you are still getting the error,
print out verbose logs with the `flutter doctor -v` command and ask for help in
one of the [community support channels][].


## Community support

The Flutter community is helpful and welcoming. If none of the above solves your
installation issue, you may consider asking for support from the following
channels:

*   [/r/flutterhelp](https://www.reddit.com/r/flutterhelp/) on Reddit
*   [/r/flutterdev](https://discord.gg/rflutterdev) on Discord. There’s an
    `install-and-setup` channel on this server. 
*   [StackOverflow](https://stackoverflow.com/). Search answers with keywords 
such as "[flutter] install" or post a new question.

To be respectful to everyone’s time, try to search the archive for a similar
issue first before you post a new one. 


[community support channels]: #community-support
[java binary path]: https://github.com/flutter/flutter/issues/106416#issuecomment-1522198064
[so java version]: https://stackoverflow.com/questions/75328050/
[set up VS Code]: https://docs.flutter.dev/get-started/editor
[config path]: https://dartcode.org/docs/configuring-path-and-environment-variables/
[sdkmanager]: https://developer.android.com/studio/command-line/sdkmanager