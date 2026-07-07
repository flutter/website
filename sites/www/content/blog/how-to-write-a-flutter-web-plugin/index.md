---
title: "How to Write a Flutter Web Plugin"
description: "Introduction"
publishDate: 2019-11-20
author: harry_terkelsen
image: images/1UTowUOvpkFW35rcuJ3Lf1w.png
category: tutorial
layout: blog
---

Do you want to add support for a Flutter plugin? This article will show you how web support was added to the [url_launcher](https://pub.dev/packages/url_launcher) plugin. Before you read this article, you should already be familiar with plugin development and the concepts in [Developing plugin packages](https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin).

## Example: package:url_launcher

First, let’s create an example app that uses `package:url_launcher`, so you can verify that it works correctly.

**Setup**

In order to use web plugins, you need to be on the Flutter dev channel. Make sure that you’re on the dev channel by running:

```
$ flutter channel dev
$ flutter upgrade
```


Now, you need to enable web support so that Flutter can set up your app to run on the web:

```
$ flutter config --enable-web
```


Now, create a directory named `url_launcher_example`(let’s assume `~/url_launcher_example`), and create a Flutter project in it:

```
$ mkdir “~/url_launcher_example”
$ cd “~/url_launcher_example”
$ flutter create .
```


**Use `package:url_launcher`**

Our example app will have just a button that launches google.com.

First, update the pubspec so that you depend on `package:url_launcher`. In `pubspec.yaml`, under `dependencies`, add the line (highlighted in bold):

```
name: url_launcher_example
 ...
dependencies:
  flutter:
    sdk: flutter
  **url_launcher: 5.2.3**
  ...
```


Now, replace the entire contents of `lib/main.dart` with the following:

```dart
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

void main() => runApp(UrlLauncherExample());

class UrlLauncherExample extends StatelessWidget {
  static const String _title = 'URL Launcher Example';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: LaunchButton(),
      ),
    );
  }
}

class LaunchButton extends StatelessWidget {
  LaunchButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: _launch,
        child: Text(
          'Launch!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  void _launch() {
    launch('https://www.google.com');
  }
}

```

Verify that the app works by running it on your Android or iOS device, or simulator by running the app normally with `flutter run`. The app should look like this screenshot. Try clicking the **Launch**! button and verify that it opens Google.

<DashImage figure src="images/1UTowUOvpkFW35rcuJ3Lf1w.png" alt="URL Launcher Example app" caption="URL Launcher Example app" />


Now, you can run the same app on the web with `flutter run -d chrome`. The app should open and render just like the mobile version, but clicking **Launch**! does nothing. Let’s start writing the web plugin for `url_launcher`.

## **Creating `package:url_launcher_web`**

Create a new directory called `url_launcher_web` (let’s assume `~/url_launcher_web`):

```
$ mkdir “~/url_launcher_web”
$ cd “~/url_launcher_web”
```


Unfortunately, there is no template for web plugins currently (that is, you can’t use `flutter create`), so you’ll have to create the plugin manually. But, before you start coding, some discussion is in order about how this is actually going to be implemented.

**Looking into `package:url_launcher`**

Let’s take a look at how `package:url_launcher` is implemented, so you know what to do for `package:url_launcher_web`. The main code can be found [here](https://github.com/flutter/plugins/blob/f04b3c8565ca9d2dac1f7f1ee8a44f41f97fe542/packages/url_launcher/url_launcher/lib/url_launcher.dart). These are the main bits you should care about:

```dart
const MethodChannel _channel = MethodChannel('plugins.flutter.io/url_launcher');

Future<bool> launch(
  String urlString, {
  ...
}) async {
  assert(urlString != null);
  final bool result = await _channel.invokeMethod<bool>(
    'launch',
    <String, Object>{
      'url': urlString,
      ...
      },
  );
  ...
  return result;
}
```

Almost all Flutter plugins are written like this. They create a `MethodChannel`, and then the plugin works by sending a method call on the channel to the “platform-side” (that is, Android or iOS) of the plugin. So, the way this plugin works on Android is that there is some code, written in Java, that registers a `MethodChannel` on the Android side. The `MethodChannel` waits for method calls, which call the required Android code to launch a URL. In order to get this plugin working on the web, you need to do the same thing as in the Android and iOS implementations, create a `MethodChannel` that waits for method calls, and when the `MethodChannel` receives them, launches the given URL.

**Implementing `package:url_launcher_web`**

Web implementations of Flutter plugins are written as Dart packages. Let’s begin with the `pubspec.yaml`. Assuming you’re in your `url_launcher_web` directory you created earlier, create a file named `pubspec.yaml`, and paste the following code in the file:

```yaml
name: url_launcher_web
version: 0.0.1

flutter:
  plugin:
    platforms:
      web:
        pluginClass: UrlLauncherPlugin
        fileName: url_launcher_web.dart

dependencies:
  flutter:
    sdk: flutter
  flutter_web_plugins:
    sdk: flutter

environment:
  sdk: ">=2.0.0-dev.28.0 <3.0.0"
  flutter: ">=1.5.0 <2.0.0"
```

Some key things to note:

* The `platforms:` section contains a section for `web:` that declares the name of the class where you will implement the plugin, as well as the filename containing the class.

* The `flutter_web_plugins` dependency lets you register the web implementation of `url_launcher`.

We declared that our implementation will be a class named `UrlLauncherPlugin` and be written in `url_launcher_web.dart`, so let’s write that class now. Make sure you create a `lib/` directory first, then edit `lib/url_launcher_web.dart`, and paste the following code in the file:

```dart
import 'dart:async';
import 'dart:html' as html;

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

class UrlLauncherPlugin {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
        'plugins.flutter.io/url_launcher',
        const StandardMethodCodec(),
        registrar.messenger);
    final UrlLauncherPlugin instance = UrlLauncherPlugin();
    channel.setMethodCallHandler(instance.handleMethodCall);
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'launch':
        final String url = call.arguments['url'];
        return _launch(url);
      default:
        throw PlatformException(
            code: 'Unimplemented',
            details: "The url_launcher plugin for web doesn't implement "
                "the method '${call.method}'");
    }
  }


  bool _launch(String url) {
    return html.window.open(url, '') != null;
  }
}
```

There are several key points to note in our implementation, let’s go over them one by one.

**Registering the plugin with `registerWith`**

Just as on Android or iOS, web plugins need to do some initialization before the app runs. This is done in the static `registerWith` method, which takes a `Registrar` (which comes from `package:flutter_web_plugins`).

In this case, we are registering a `MethodChannel` to listen for incoming messages from the app. Note how we initialize the `MethodChannel` with `registrar.messenger`. All `MethodChannel`s have a `BinaryMessenger` that they use to send and receive messages. By default, a `MethodChannel` uses the default `BinaryMessenger` defined in Flutter. The `BinaryMessenger` sends messages from the app to the platform side, but we are writing a plugin that is on the platform side and should receive messages from the app, so we need to initialize the `MethodChannel` with a different `BinaryMessenger`. Luckily, the `Registrar` that is passed to the plugin in `registerWith` has a messenger that does the right thing. By initializing our `MethodChannel` with it, we now have a `MethodChannel` that receives method calls from the app.

**Handling method calls**

The `MethodChannel` we created registered `handleMethodCall` as its method call handler. This means that any time the app-side `MethodChannel` (the one created in `package:url_launcher`) sends a method call to the platform-side `MethodChannel` (the one we created in `registerWith`) this method call handler is invoked.

If the handler receives a method call to the `‘launch’` method, then it invokes `_launch`, which simply opens a new window with the given URL.

## Using the web plugin in the example app

Our web plugin is looking good! Now, we need to use it from the example app we created earlier.

Modify the pubspec in `~/url_launcher_example` to add a dependency to `~/url_launcher_web`. Your change should look something like this. (Make sure to use the correct path for where you actually put your directories):

```
dependencies:
  flutter:
    sdk: flutter
  url_launcher: 5.2.3
  **url_launcher_web:
    path: ../url_launcher_web**
```


Now, run the example app again with `flutter run -d chrome`. Try clicking the **Launch**! button. It should open google.com in a new tab.

Congratulations! You successfully added web support to a Flutter plugin!