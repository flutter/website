---
title: Play or stream sound and music with flutter_soloud
description: >-
  Learn how to play or stream audio in
  your Flutter app using the flutter_soloud package.
---

This recipe demonstrates how to integrate the [`flutter_soloud` package][]
into your Flutter application to play sound effects and
background music with low latency.
To get started using the package, follow these steps:

[`flutter_soloud` package]: {{site.pub-pkg}}/flutter_soloud

## 1. Add the package dependency

To add `package:flutter_soloud` as a dependency, use `flutter pub add`:

```console
$ flutter pub add flutter_soloud
```

## 2. Initialize `SoLoud`

Before playing any audio,
you need to initialize the `SoLoud` instance.
You can also configure playback settings like sample rate,
buffer size, and the number of channels.

```dart
import 'package:flutter_soloud/flutter_soloud.dart';

// Initialize with default settings.
await SoLoud.instance.init();

// Or configure with custom settings.
await SoLoud.instance.init(
  sampleRate: 44100,
  bufferSize: 2048,
  channels: Channels.stereo,
);
```

## 3. Load audio

The `flutter_soloud` package supports various audio formats
including MP3, WAV, OGG, and FLAC.
You can load audio from different sources.

From a local file:

```dart
final sound = await SoLoud.instance.loadFile('path/to/sound.mp3');
```

From an app asset:

```dart
final sound = await SoLoud.instance.loadAsset('assets/sound.mp3');
```

From a network URL:

```dart
final sound = await SoLoud.instance.loadUrl(
  'https://example.com/sound.mp3',
  mode: LoadMode.memory,
);
```

From bytes in memory:

```dart
// TODO: Replace with your actual audio data.
final soundBytes = Uint8List.fromList([]);

final sound = await SoLoud.instance.loadMem(
  'reference_name.mp3',
  soundBytes,
  mode: LoadMode.memory,
);
```

## 4. Play audio

Once the audio is loaded,
you can play it using `SoLoud.instance.play`.
You can also configure gapless looping.

```dart
// Play the sound.
var handle = await SoLoud.instance.play(sound);

// Play with gapless looping.
handle = await SoLoud.instance.play(
  sound,
  looping: true,
  loopingStartAt: Duration(seconds: 1),
);
```

The `play` method returns a handle that references
that particular instance of the sound being played.
You can use this handle to control the playback.

## 5. Control playback

With the handle returned from `play`,
you can perform various actions such as pausing or resuming playback:

```dart
// Toggle pause state.
SoLoud.instance.pauseSwitch(handle);
```

Seek to a specific timestamp:

```dart
SoLoud.instance.seek(handle, Duration(seconds: 5));
```

Set playback speed:

```dart
// Play twice as fast.
SoLoud.instance.setRelativePlaySpeed(handle, 2.0);
```

Adjust playback volume:

```dart
// Set playback to 50% volume.
SoLoud.instance.setVolume(handle, 0.5);
```

Fade the audio volume:

```dart
SoLoud.instance.fadeVolume(
  handle,
  0.0, // The volume to fade to.
  Duration(seconds: 2), // The duration of the fade.
);
```

Stop playback:

```dart
await SoLoud.instance.stop(handle);
```

## 6. Dispose of sound sources

When you are finished with a sound source,
remember to dispose of it to free up resources.

```dart
await SoLoud.instance.disposeSource(sound);
```

## 7. [Optional] Stream audio

The `flutter_soloud` package also supports streaming
audio data in real time.

Initialize and configure a buffer stream:

```dart
final stream = SoLoud.instance.setBufferStream(
  bufferingType: BufferingType.released,
  sampleRate: 24000,
  channels: Channels.mono,
  format: BufferType.s16le, // pcm16bits
);
```

Play the stream:

```dart
final handle = await SoLoud.instance.play(stream);
```

As your app receives audio data, add it to the stream:

```dart
// TODO: Replace with your actual audio data.
final audioChunk = Uint8List.fromList([]);

SoLoud.instance.addAudioDataStream(
  stream,
  audioChunk,
);
```

When you're done with the audio stream, mark it as complete:

```dart
SoLoud.instance.setDataIsEnded(stream);
```

## More information

For more detailed information and examples,
visit the [`flutter_soloud` package][] on pub.dev or
check out the `flutter_soloud` Package of the Week video.

<div class="video-wrapper">
  <YouTubeEmbed id="2t6Bt04EyLw" title="flutter_soloud - Package of the Week"></YouTubeEmbed>
</div>
