---
title: Play and pause a video
description: How to use the video_player plugin.
js:
  - defer: true
    url: /assets/js/inject_dartpad.js
---

<?code-excerpt path-base="cookbook/plugins/play_video/"?>

Playing videos is a common task in app development,
and Flutter apps are no exception. To play videos,
the Flutter team provides the [`video_player`][] plugin.
You can use the `video_player` plugin to play videos
stored on the file system, as an asset, or from the internet.

:::warning
At this time,
the `video_player` plugin doesn't work on Linux and Windows.
To learn more, check out the [`video_player`][] package.
:::

On iOS, the `video_player` plugin makes use of
[`AVPlayer`][] to handle playback. On Android,
it uses [`ExoPlayer`][].

This recipe demonstrates how to use the `video_player` package to stream a
video from the internet with basic play and pause controls using
the following steps:

  1. Add the `video_player` dependency.
  2. Add permissions to your app.
  3. Create and initialize a `VideoPlayerController`.
  4. Display the video player.
  5. Play and pause the video.

## 1. Add the `video_player` dependency

This recipe depends on one Flutter plugin: `video_player`. 
First, add this dependency to your project.

To add the `video_player` package as a dependency, run `flutter pub add`:

```console
$ flutter pub add video_player
```

## 2. Add permissions to your app

Next, update your `android` and `ios` configurations to ensure
that your app has the correct permissions to stream videos
from the internet.

### Android

Add the following permission to the `AndroidManifest.xml` file just after the
`<application>` definition. The `AndroidManifest.xml` file is found at
`<project root>/android/app/src/main/AndroidManifest.xml`.

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <application ...>

    </application>

    <uses-permission android:name="android.permission.INTERNET"/>
</manifest>
```

### iOS

For iOS, add the following to the `Info.plist` file found at
`<project root>/ios/Runner/Info.plist`.

```xml
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <true/>
</dict>
```

:::warning
The `video_player` plugin can only play asset videos in iOS simulators.
You must test network-hosted videos on physical iOS devices.
:::

### macOS

If you use network-based videos, 
[add the `com.apple.security.network.client` entitlement][mac-entitlement].

### Web

Flutter web does **not** support `dart:io`,
so avoid using the `VideoPlayerController.file` constructor for the plugin.
Using this constructor attempts to create a`VideoPlayerController.file`
that throws an `UnimplementedError`.

Different web browsers might have different video-playback capabilities,
such as supported formats or autoplay.
Check the [video_player_web] package for more web-specific information.

The `VideoPlayerOptions.mixWithOthers` option can't be implemented in web,
at least at the moment. If you use this option in web it will be silently ignored.

## 3. Create and initialize a `VideoPlayerController`

Now that you have the `video_player` plugin installed with the correct
permissions, create a `VideoPlayerController`. The
`VideoPlayerController` class allows you to connect to different types of
videos and control playback.

Before you can play videos, you must also `initialize` the controller.
This establishes the connection to the video and prepare the
controller for playback.

To create and initialize the `VideoPlayerController` do the following:

  1. Create a `StatefulWidget` with a companion `State` class
  2. Add a variable to the `State` class to store the `VideoPlayerController`
  3. Add a variable to the `State` class to store the `Future` returned from
  `VideoPlayerController.initialize`
  4. Create and initialize the controller in the `initState` method
  5. Dispose of the controller in the `dispose` method

<?code-excerpt "lib/main_step3.dart (VideoPlayerScreen)"?>
```dart
class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      ),
    );

    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Complete the code in the next step.
    return Container();
  }
}
```

## 4. Display the video player

Now, display the video. The `video_player` plugin provides the
[`VideoPlayer`][] widget to display the video initialized by
the `VideoPlayerController`.
By default, the `VideoPlayer` widget takes up as much space as possible.
This often isn't ideal for videos because they are meant
to be displayed in a specific aspect ratio, such as 16x9 or 4x3.

Therefore, wrap the `VideoPlayer` widget in an [`AspectRatio`][]
widget to ensure that the video has the correct proportions.

Furthermore, you must display the `VideoPlayer` widget after the
`_initializeVideoPlayerFuture()` completes. Use `FutureBuilder` to
display a loading spinner until the controller finishes initializing.
Note: initializing the controller does not begin playback.

<?code-excerpt "lib/main.dart (FutureBuilder)" replace="/body: //g;/^\),$/)/g"?>
```dart
// Use a FutureBuilder to display a loading spinner while waiting for the
// VideoPlayerController to finish initializing.
FutureBuilder(
  future: _initializeVideoPlayerFuture,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      // If the VideoPlayerController has finished initialization, use
      // the data it provides to limit the aspect ratio of the video.
      return AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        // Use the VideoPlayer widget to display the video.
        child: VideoPlayer(_controller),
      );
    } else {
      // If the VideoPlayerController is still initializing, show a
      // loading spinner.
      return const Center(child: CircularProgressIndicator());
    }
  },
)
```

## 5. Play and pause the video

By default, the video starts in a paused state. To begin playback,
call the [`play()`][] method provided by the `VideoPlayerController`.
To pause playback, call the [`pause()`][] method.

For this example,
add a `FloatingActionButton` to your app that displays a play
or pause icon depending on the situation.
When the user taps the button,
play the video if it's currently paused,
or pause the video if it's playing.

<?code-excerpt "lib/main.dart (FAB)" replace="/^floatingActionButton: //g;/^\),$/)/g"?>
```dart
FloatingActionButton(
  onPressed: () {
    // Wrap the play or pause in a call to `setState`. This ensures the
    // correct icon is shown.
    setState(() {
      // If the video is playing, pause it.
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        // If the video is paused, play it.
        _controller.play();
      }
    });
  },
  // Display the correct icon depending on the state of the player.
  child: Icon(
    _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
  ),
)
```

## Complete example

<?code-excerpt "lib/main.dart"?>
```dartpad title="Flutter video player hands-on example in DartPad" run="true"
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(const VideoPlayerApp());

class VideoPlayerApp extends StatelessWidget {
  const VideoPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Video Player Demo',
      home: VideoPlayerScreen(),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      ),
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Butterfly Video')),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(_controller),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
```


[`AspectRatio`]: {{site.api}}/flutter/widgets/AspectRatio-class.html
[`AVPlayer`]: {{site.apple-dev}}/documentation/avfoundation/avplayer
[`ExoPlayer`]: https://google.github.io/ExoPlayer/
[`pause()`]: {{site.pub-api}}/video_player/latest/video_player/VideoPlayerController/pause.html
[`play()`]: {{site.pub-api}}/video_player/latest/video_player/VideoPlayerController/play.html
[`video_player`]: {{site.pub-pkg}}/video_player
[`VideoPlayer`]: {{site.pub-api}}/video_player/latest/video_player/VideoPlayer-class.html
[mac-entitlement]: {{site.url}}/platform-integration/macos/building#entitlements-and-the-app-sandbox
[video_player_web]: {{site.pub-pkg}}/video_player_web
