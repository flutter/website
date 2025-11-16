---
title: Launching a Jetpack Compose activity from your Flutter application
shortTitle: Native Android activities
description: >-
  Learn how to launch native Android activities in your Flutter app.
---

<?code-excerpt path-base="platform_integration/compose_activities"?>

Native Android activities allow you to launch
fullscreen UIs that are entirely run by and on the Android platform.
You will only write Kotlin code in those views (though they might
pass messages to and receive messages from your Dart code) and
you will have access to the full breadth of native Android functionality.

Adding this functionality requires making several changes to
your Flutter app and its internal, generated Android app.
On the Flutter side, you will need to create a new
platform method channel and call its `invokeMethod` method.
On the Android side, you will need to register a matching native `MethodChannel`
to receive the signal from Dart and then launch a new activity.
Recall that all Flutter apps (when running on Android) exist within
an Android activity that is completely consumed by the Flutter app.
Thus, as you will see in the code sample, the job of the
native `MethodChannel` callback is to launch a second activity.

:::note
This page discusses how to launch native Android activities
within a Flutter app.
If you'd like to host native Android views in your Flutter app,
check out [Hosting native Android views][].
:::

[Hosting native Android views]: /platform-integration/android/platform-views

Not all Android activities use Jetpack Compose, but
this tutorial assumes you want to use Compose.

## On the Dart side

On the Dart side, create a method channel and invoke it from
a specific user interaction, like tapping a button.

<?code-excerpt "lib/launch_compose_activity_example_1.dart"?>
```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// SECTION 1: START COPYING HERE
const platformMethodChannel = MethodChannel(
  // Note: You can change this string value, but it must match
  // the `CHANNEL` attribute in the next step.
  'com.example.flutter_android_activity',
);
// SECTION 1: END COPYING HERE

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // SECTION 2: START COPYING HERE
  void _launchAndroidActivity() {
    platformMethodChannel.invokeMethod(
      // Note: You can change this value, but it must match
      // the `call.method` value in the next section.
      'launchActivity',

      // Note: You can pass any primitive data types you like.
      // To pass complex types, use package:pigeon to generate
      // matching Dart and Kotlin classes that share serialization logic.
      {'message': 'Hello from Flutter'},
    );
  }
  // SECTION 2: END COPYING HERE

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const Center(child: Text('Hello World!')),
        floatingActionButton: FloatingActionButton(
          // SECTION 3: Call `_launchAndroidActivity` somewhere.
          onPressed: _launchAndroidActivity,

          // SECTION 3: End
          tooltip: 'Launch Android activity',
          child: const Icon(Icons.launch),
        ),
      ),
    );
  }
}
```

There are 3 important values that must match across your Dart and Kotlin code:

 1. The channel name (in this sample, the value is
    `"com.example.flutter_android_activity"`).
 2. The method name (in this sample, the value is `"launchActivity"`).
 3. The structure of the data which Dart passes and
    the structure of the data which Kotlin expects to receive.
    In this case, the data is a map with a single `"message"` key.


## On the Android side

You must make changes to 4 files in the generated Android app to
ready it for launching fresh Compose activities.

The first file requiring modifications is `android/app/build.gradle`.

 1. Add the following to the existing `android` block:

    ```groovy title="android/app/build.gradle"
    android {
      // Begin adding here
      buildFeatures {
        compose true
      }
      composeOptions {
        // https://developer.android.com/jetpack/androidx/releases/compose-kotlin
        kotlinCompilerExtensionVersion = "1.4.8"
      }
      // End adding here
    }
    ```

    Visit the [developer.android.com][] link in the code snippet and
    adjust `kotlinCompilerExtensionVersion`, as necessary.
    You should only need to do this if you
    receive errors during `flutter run` and those errors tell you
    which versions are installed on your machine.

    [developer.android.com]: {{site.android-dev}}/jetpack/androidx/releases/compose-kotlin

 2. Next, add the following block at the bottom of the file, at the root level:

    ```groovy title="android/app/build.gradle"
    dependencies {
        implementation("androidx.core:core-ktx:1.10.1")
        implementation("androidx.lifecycle:lifecycle-runtime-ktx:2.6.1")
        implementation("androidx.activity:activity-compose")
        implementation(platform("androidx.compose:compose-bom:2024.06.00"))
        implementation("androidx.compose.ui:ui")
        implementation("androidx.compose.ui:ui-graphics")
        implementation("androidx.compose.ui:ui-tooling-preview")
        implementation("androidx.compose.material:material")
        implementation("androidx.compose.material3:material3")
        testImplementation("junit:junit:4.13.2")
        androidTestImplementation("androidx.test.ext:junit:1.1.5")
        androidTestImplementation("androidx.test.espresso:espresso-core:3.5.1")
        androidTestImplementation(platform("androidx.compose:compose-bom:2023.08.00"))
        androidTestImplementation("androidx.compose.ui:ui-test-junit4")
        debugImplementation("androidx.compose.ui:ui-tooling")
        debugImplementation("androidx.compose.ui:ui-test-manifest")
    }
    ```

    The second file requiring modifications is `android/build.gradle`.

 1. Add the following buildscript block at the top of the file:

    ```groovy title="android/build.gradle"
    buildscript {
        dependencies {
            // Replace with the latest version.
            classpath 'com.android.tools.build:gradle:8.1.1'
        }
        repositories {
            google()
            mavenCentral()
        }
    }
    ```

    The third file requiring modifications is
    `android/app/src/main/AndroidManifest.xml`.

 1. In the root application block, add the following `<activity>` declaration:

    ```xml title="android/app/src/main/AndroidManifest.xml"
    <manifest xmlns:android="http://schemas.android.com/apk/res/android">
        <application
            android:label="flutter_android_activity"
            android:name="${applicationName}"
            android:icon="@mipmap/ic_launcher">

           // START COPYING HERE
            <activity android:name=".SecondActivity" android:exported="true" android:theme="@style/LaunchTheme"></activity>
           // END COPYING HERE

           <activity android:name=".MainActivity" …></activity>
          …
    </manifest>
    ```

    The fourth and final code requiring modifications is
    `android/app/src/main/kotlin/com/example/flutter_android_activity/MainActivity.kt`.
    Here you'll write Kotlin code for your desired Android functionality.

 1. Add the necessary imports at the top of the file:

    :::note
    Your imports might vary if library versions have changed or
    if you introduce different Compose classes when
    you write your own Kotlin code.
    Follow your IDE's hints for the correct imports you require.
    :::

    ```kotlin title="MainActivity.kt"
    package com.example.flutter_android_activity

    import android.content.Intent
    import android.os.Bundle
    import androidx.activity.ComponentActivity
    import androidx.activity.compose.setContent
    import androidx.compose.foundation.layout.Column
    import androidx.compose.foundation.layout.fillMaxSize
    import androidx.compose.material3.Button
    import androidx.compose.material3.MaterialTheme
    import androidx.compose.material3.Surface
    import androidx.compose.material3.Text
    import androidx.compose.ui.Modifier
    import androidx.core.app.ActivityCompat
    import io.flutter.embedding.android.FlutterActivity
    import io.flutter.embedding.engine.FlutterEngine
    import io.flutter.plugin.common.MethodCall
    import io.flutter.plugin.common.MethodChannel
    import io.flutter.plugins.GeneratedPluginRegistrant
    ```

 1. Modify the generated `MainActivity` class by adding a
    `CHANNEL` field and a `configureFlutterEngine` method:

     ```kotlin  title="MainActivity.kt"
     class MainActivity: FlutterActivity() {
         // This value must match the `MethodChannel` name in your Dart code.
         private val CHANNEL = "com.example.flutter_android_activity"

         override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
             GeneratedPluginRegistrant.registerWith(flutterEngine)

             MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                 call: MethodCall, result: MethodChannel.Result ->
                     when (call.method) {
                         // Note: This must match the first parameter passed to
                         // `platformMethodChannel.invokeMethod` in your Dart code.
                         "launchActivity" -> {
                             try {
                                 // Takes an object, in this case a String.
                                 val message = call.arguments
                                 val intent = Intent(this@MainActivity, SecondActivity::class.java)
                                 intent.putExtra("message", message.toString())
                                 startActivity(intent)
                             } catch (e: Exception){}
                                 result.success(true)
                             }
                             else -> {}
                     }
             }
         }
     }
     ```

 1. Add a second `Activity` to the bottom of the file, which you
    referenced in the previous changes to `AndroidManifest.xml`:

    ```kotlin  title="MainActivity.kt"
    class SecondActivity : ComponentActivity() {
        override fun onCreate(savedInstanceState: Bundle?) {
            super.onCreate(savedInstanceState)

            setContent {
                Surface(modifier = Modifier.fillMaxSize(), color = MaterialTheme.colorScheme.background) {
                    Column {
                        Text(text = "Second Activity")
                        // Note: This must match the shape of the data passed from your Dart code.
                        Text("" + getIntent()?.getExtras()?.getString("message"))
                        Button(onClick = {  finish() }) {
                            Text("Exit")
                        }
                    }
                }
            }
        }
    }
    ```

These steps show how to launch a native Android activity from a Flutter app,
which can sometimes be an easy way to connect to specific Android functionality.
