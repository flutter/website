---
title: "Calling Native APIs with jnigen"
description: "Use an Android API directly from Flutter code"
---

## Overview

`jnigen` stands for Java Native Interface GENeration. It is a means for 
calling native Java and Kotlin (JVM) code from Dart. It builds upon the FFI (Foreign Function Interface) package that C-based languages use. 

## How It Works 

Before we can use a native interop call in an application, we need to do a little setup. 

The APISummarizer is a tool that reads source and bytecode to determine which classes and functions are present. The abstract syntax tree defining the desired classes is read to create Dart versions with modifications to account for the differences between the Java platform and Dart.


<img src='/assets/images/android/jni-call-lifecycle-light.png' class="text-center diagram-wrap" alt="Node tree">



:::warning
There is an alternate method of specifying generation output using a `jnigen.yaml` file.
That method is considered deprecated.
:::


### Step 1: Create a new app project

### Step 2: Add `jni` and `jnigen` as dependencies 

```sh
dart pub add jni
dart pub add jnigen --dev
```

To make sure that Android OS APIs and whatever dependencies are available to `jnigen`, run the following to build
an Android apk of the application.

```sh
flutter build apk
```

### Step 3: Set configuration of Dart bindings
There is a Dart API in `jnigen` to specify the properties your generated should have. You will create
a Dart file. `tool/jnigen.dart` is the convention but you can create it anywhere. The file needs at
minimum a single function call to `generateJniBindings` that accepts a `Config` object as a parameter.

Here is a minimal configuration file. 

```dart
import 'dart:io';

import 'package:jnigen/jnigen.dart';

void main(List<String> args) {
  final packageRoot = Platform.script.resolve('../');
  generateJniBindings(
    Config(
      outputConfig: OutputConfig(
        dartConfig: DartCodeOutputConfig(
          path: packageRoot.resolve('lib/gen/'),
          structure: OutputStructure.packageStructure,
        ),
      ),
      classes: [
        // Core Java classes are generally available
        // like java.util.ArrayList, etc
        
        // Android OS classes are also available
        // provided `flutter build apk` is run 
        // before this function
        
        // 'java.util.ArrayList',
        // 'android.widget.Toast',
      ],
    ),
  );


```

The `Config` object is a Dart API for specifying:

* the location of developer-created source code,
* the final location of the generated Dart code,
* dependencies to download from online repositories, and,
* specifics of the Android version to build against.

```dart
Config({
    required OutputConfig outputConfig,
    required List<String> classes, 
    Set<Experiment?>? experiments, 
    List<Uri>? sourcePath,
    List<Uri>? classPath,
    String? preamble,
    Map<String, String>? customClassBody, 
    AndroidSdkConfig? androidSdkConfig, 
    MavenDownloads? mavenDownloads, 
    SummarizerOptions? summarizerOptions, 
    List<String>? nonNullAnnotations, 
    List<String>? nullableAnnotations, 
    Level logLevel = Level.INFO,
    String? dumpJsonTo, 
    List<Uri>? imports, 
    List<Visitor>? visitors
})
```

Here is the final configuration file to generate Dart bindings to show an Android `Toast` message.

```dart
import 'dart:io';

import 'package:jnigen/jnigen.dart';

void main(List<String> args) {
  final packageRoot = Platform.script.resolve('../');
  generateJniBindings(
    Config(
      outputConfig: OutputConfig(
        dartConfig: DartCodeOutputConfig(
          path: packageRoot.resolve('lib/gen/android.g.dart'),
          structure: OutputStructure.singleFile,
        ),
      ),
      androidSdkConfig: AndroidSdkConfig(addGradleDeps: true),
      classes: [
        'android.widget.Toast', // provided by Android OS
      ],
    ),
  );
}

```

Finally, run

```sh
dart tool/jnigen.dart
```


### Step 4: Call Dart bindings

```dart
// Retrieves an Android context to pass with native calls
JObject context = Jni.androidApplicationContext;

/// Display DateTime retrieved from Dart
void showToast() {
  final message = 'The time is now ${DateTime.now()}';

// Corresponds  to this second signature
// public static Toast makeText (Context context,
//              CharSequence text,
//                int duration)
// First one uses R namespace resources
  Toast.makeText$1(context, message.toJString(), Toast.LENGTH_LONG)!.show();
}
```

Here is the full `main.dart` file.

:::note
Java/Kotlin and Dart differ on support of overloaded functions, that's to say functions that use the same
name but differ on return type, parameter type, or number of parameters.

To compensate for this, when Dart bindings are built, overloaded functions take the form of 
`functionName$<number>`. At present, they are parsed in the order that they appear in the files
so there might not be a correlation between number and type of parameters and the eventual Dart identifier.
:::

```dart

import 'package:android_toast_demo/gen/android/os/_package.dart';
import 'package:android_toast_demo/gen/android/widget/_package.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jni/jni.dart';


JObject context = Jni.androidApplicationContext;


/// Display DateTime retrieved from Dart
void showToast() {
  final message = 'The time is now ${DateTime.now()}';

// Corresponds  to this second signature
// public static Toast makeText (Context context,
//              CharSequence text,
//                int duration)
// First one uses R namespace resources
  Toast.makeText$1(context, message.toJString(), Toast.LENGTH_LONG)!.show();
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Show Time'),
              onPressed: () => showToast(),
            ),
          ],
        ),
      ),
    );
  }
}

```
