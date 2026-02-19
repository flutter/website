---
title: Record or stream audio input
description: >-
  Learn how to record or stream audio input in
  your Flutter app using the record package.
--- 


This recipe demonstrates how to use the [`record` package][] to add
audio recording and streaming capabilities to your Flutter app.
Here is an overview of the steps involved in implementing audio input:

[`record` package]: {{site.pub-pkg}}/record

1. Add the package dependency
1. Initialize an `AudioRecorder` object
1. Request user permission
1. Create and configure a `RecordConfig`
1. Start recording to a file
1. Control an ongoing recording
1. [Optional] Record to an audio stream
1. Stop the recording
1. Dispose of the recorder

## 1. Add the package dependency

To add `package:record` as a dependency, use `flutter pub add`:

```console
$ flutter pub add record
```

Then run `flutter pub get`

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
  // Permission granted, proceed with recording
} else {
  // Permission denied
}
```

## 4. Create and configure a recorder

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

Get the desired file path and call the `start` method
on the `AudioRecorder`, passing in the `recordConfig`
and the path where the file should be stored.

```dart
import 'package:path_provider/path_provider.dart'; // For getting a temporary directory

final directory = await getTemporaryDirectory();
final path = '${directory.path}/myRecord.m4a';
await recorder.start(recordConfig, path: path);
print('Recording started to: $path');
```

## 6. Control an ongoing recording

You can control an ongoing recording using `pause()`, `resume()`,
and `stop()`.

```dart
await recorder.pause();
await recorder.resume();
await recorder.stop();
```

## 7. [Optional] Record to an audio stream

To stream audio, use the `startStream` method.
This returns a stream of audio data.

```dart
final stream = await recorder.startStream(recordConfig);
stream.listen((audioChunk) {
  // Process audioChunk (e.g., send to a server)
});
```

## 8. Stop recording

To stop the recording and get the path to the saved file,
call the asynchronous `stop` method on the `AudioRecorder`.

```dart
final path = await recorder.stop();
print('Recording stopped. File saved to: $path');
```

## 9. Dispose of the recorder

When you are finished using the `AudioRecorder`,
remember to dispose() of it to release resources.

```dart
await recorder.dispose();
```

## Supported formats and encodings

The `record` package supports various file formats
and encodings across different platforms.
Some examples include:

* `aacLc`
* `aacEld`
* `aacHe`
* `amrNb`
* `amrWb`
* `opus`
* `wav`
* `flac`
* `pcm16bits`

For more detailed information and the full list of supported options,
visit the [`record` package][] page on pub.dev or check out the
following Package of the Week video.

<div class="card-grid">
  <div class="card wrapped-card outlined-card">
    <div class="card-content"> 
      <YouTubeEmbed id="v=Vv2A_nUL1tw" title="record Package of the Week"></YouTubeEmbed>
    </div>
  </div>
</div>
