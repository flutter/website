---
title: Background processes
description: Where to find more information on implementing background processes in Flutter.
---

Have you ever wanted to execute Dart code in the background—even if
your app wasn’t the currently active app? Perhaps you wanted to implement
a process that watches the time, or that catches camera movement.
In Flutter, you can execute Dart code in the background.

The mechanism for this feature involves setting up an isolate. _Isolates_
are Dart’s model for multithreading, though an isolate differs from a
conventional thread in that it doesn’t share memory with the main program.
You’ll set up your isolate for background execution using callbacks and
a callback dispatcher.

For more information and a geofencing example that uses background
execution of Dart code, see the Medium article by Ben Konyi,
[Executing Dart in the Background with Flutter Plugins and
Geofencing][background-processes].  At the end of this article,
you’ll find links to example code, and relevant documentation for Dart,
iOS, and Android.


[background-processes]: {{site.flutter-medium}}/executing-dart-in-the-background-with-flutter-plugins-and-geofencing-2b3e40a1a124
