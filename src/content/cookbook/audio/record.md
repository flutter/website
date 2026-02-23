---
title: Record or stream audio input
description: >-
  Learn how to record or stream audio input in
  your Flutter app using the record package.
---

This recipe demonstrates how to use the [`record` package][] to add
audio recording and streaming capabilities to your Flutter app.
To get started using the package, follow these steps:

[`record` package]: {{site.pub-pkg}}/record

## 1. Add the package dependency

To add `package:record` as a dependency, use `flutter pub add`:

```console
$ flutter pub add record
```

## 2. Initialize an `AudioRecorder`

Initialize an `AudioRecorder` object. This is the primary object
that controls the recording process.

```dart
import 'package:record/record.dart';

final recorder = AudioRecorder();
```

## 3. Request user permission

Before recording, you need to request user permission.
You might also need to add platform-specific permission configurations.
Refer to the [`record` package][] documentation for details.

```dart
final recorder = AudioRecorder();
if (await recorder.hasPermission()) {
  // Permission granted, proceed with recording.
} else {
  // Permission denied.
}
```

## 4. Create a recording configuration

Create and configure a `RecordConfig` object to specify the record settings,
such as the encoder, sample rate, and channel number.
You can also enable features like auto gain, echo cancellation,
and noise suppression.

```dart
final recordConfig = RecordConfig(
  encoder: AudioEncoder.pcm16bits,
  sampleRate: 24000,
  numChannels: 1,
  autoGain: true,
  echoCancel: true,
  noiseSuppress: true,
);
```

## 5. Start recording to a file

To start recording to a file,
call the `start` method on the `AudioRecorder`,
passing in the `recordConfig` you defined
and the path where the file should be stored.

```dart
// TODO: Specify the path where the audio file should be saved.
final audioFilePath = 'myRecording.wav';
await recorder.start(recordConfig, path: audioFilePath);
```

## 6. Control an ongoing recording

You can control an ongoing recording using the
`pause`, `resume`, and `stop` methods on the `AudioRecorder`.

```dart
await recorder.pause();
await recorder.resume();
await recorder.stop();
```

## 7. [Optional] Record to an audio stream

To stream audio, use the `startStream` method.
This returns a [stream][] of audio data.

```dart
final stream = await recorder.startStream(recordConfig);
stream.listen((audioChunk) {
  // Process the audio data. For example, send it to a server.
});
```

[stream]: {{site.api}}/flutter/dart-async/Stream-class.html

## 8. Stop recording

To stop the recording and get the path to the saved file,
call the asynchronous `stop` method on the `AudioRecorder`.

```dart
final path = await recorder.stop();
print('Recording stopped. File saved to: $path');
```

## 9. Dispose of the recorder

When you are finished using the `AudioRecorder`,
remember to call its `dispose` method to release its resources.

```dart
await recorder.dispose();
```

## Supported formats and encodings

The `record` package supports various encoders and file formats,
but support varies by platform.
For the full list of supported encoders per platform,
check out the package's [encoding support table][].

For more detailed information and examples,
visit the [`record` package][] page on pub.dev or
check out the `record` Package of the Week video.

<div class="video-wrapper">
  <YouTubeEmbed id="Vv2A_nUL1tw" title="record - Package of the Week"></YouTubeEmbed>
</div>

[encoding support table]: {{site.pub-pkg}}/record#file
