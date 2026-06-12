---
title: "Request Android permissions"
description: "Request and manage Android permissions from jni code using a plugin"
---

## Overview

This page details a means to use `jnigen` to wrap native Android code and package that functionality
as a plugin. It demonstrates requesting and querying Android permissions natively from Flutter.

With this flow, one only has to edit a single file on the Android side.

The code for [this plugin][] can be found here.

## How It Works

### `jnigen` Setup

```dart

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
      androidSdkConfig: AndroidSdkConfig(addGradleDeps: true, androidExample: 'example/'),
      classes: [
        // provided by Android OS
        'android.app.Application',
        'androidx.activity.ComponentActivity',
        'androidx.fragment.app.FragmentActivity',
        'androidx.activity.result.ActivityResult',
        'androidx.core.app.ActivityCompat',
        'androidx.activity.result.ActivityResultCallback',
        'androidx.activity.result.ActivityResultLauncher',
        'androidx.activity.result.contract.ActivityResultContract',
        'android.content.Intent',
        //'android.content.Context',
        'androidx.core.content.ContextCompat',
        'android.Manifest',
        'android.content.pm.PackageManager'
      ],
    ),
  );
}

```

### Plugin implementation

```dart
import 'package:flutter/foundation.dart';

import 'permissions_plugin_platform_interface.dart';
import 'gen/android.g.dart';
import 'package:jni/jni.dart';

class PermissionsPlugin {
  Future<String?> getPlatformVersion() {
    return PermissionsPluginPlatform.instance.getPlatformVersion();
  }

  //
  bool checkPermission(JObject context, String permission) {
    // Returns a simple true or false if the permission has been granted
    var result = ContextCompat.checkSelfPermission(
      context,
      permission.toJString(),
    );
    return result == PackageManager.PERMISSION_GRANTED ? true : false;
  }

  int checkAndRequestPermission(
    JObject context,
    String permission,
    Function callback,
  ) {
    // Do I have permission?
    if (ContextCompat.checkSelfPermission(context, permission.toJString()) ==
        PackageManager.PERMISSION_GRANTED) {
      callback();
    } else if (ActivityCompat.shouldShowRequestPermissionRationale(
          Jni.androidActivity(PlatformDispatcher.instance.engineId!),
          permission.toJString(),
        ) ==
        true) {
      // Has the user denied the permission before?
      // Give a reason why I need the permission
      // and allow a re-request
      print("I should ask for permission");
      // TODO Flow to show UI to reshow perms dialog
      return -2;
    } else {
      // Ask for permission
      ActivityCompat.requestPermissions(
        Jni.androidActivity(PlatformDispatcher.instance.engineId!),
        JArray.of(JString.type, [permission.toJString()]),
        0,
      );
    }
    return 0;
  }
}

```

### Using the plugin in an app 

Using this implementation of permissions means you only need to edit one bit of Android code to
add the possible permissions into the app's `AndroidManifest.xml` file. If the permission
does not exist in that file, `checkAndRequestPermission` will fail silently.

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.CAMERA"/>

    <application ... />
```

#### Initialize the plugin

```dart
class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _permissionsPlugin = PermissionsPlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }
  // ...
}
```

Here is how the two implemented functions look on the Dart side.

```dart
// Returns true or false if the permission has been granted
_permissionsPlugin.checkPermission(
    Jni.androidApplicationContext,
    "android.permission.CAMERA"
);


// Check for the permission and run execute a callback if allowed
_permissionsPlugin.checkAndRequestPermission(
        Jni.androidApplicationContext,
        "android.permission.CAMERA",
        () { /* Code to run if the permission was granted */},
      );

```



```dart
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_platformVersion\n'),
              FilledButton(
                child: Text("Request Camera Permissions"),
                onPressed: () {
_permissionsPlugin.checkAndRequestPermission(
        Jni.androidApplicationContext,
        "android.permission.CAMERA",
        () {},
      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  
```

[this plugin]: https://github.com/flutter/demos/tree/main/native_interop_demos/permissions_plugin
