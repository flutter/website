---
title: Take a picture using the camera
description: How to use a camera plugin on mobile.
prev:
  title: Play and pause a video
  path: /docs/cookbook/plugins/play-video
next:
  title: An introduction to integration testing
  path: /docs/cookbook/testing/integration/introduction
---

<?code-excerpt path-base="../null_safety_examples/cookbook/plugins/picture_using_camera/"?>

Many apps require working with the device's cameras to
take photos and videos.  Flutter provides the [`camera`][] plugin
for this purpose. The `camera` plugin provides tools to get a list of the
available cameras, display a preview coming from a specific camera,
and take photos or videos.

This recipe demonstrates how to use the `camera` plugin to display a preview,
take a photo, and display it using the following steps:

  1. Add the required dependencies.
  2. Get a list of the available cameras.
  3. Create and initialize the `CameraController`.
  4. Use a `CameraPreview` to display the camera's feed.
  5. Take a picture with the `CameraController`.
  6. Display the picture with an `Image` widget.

## 1. Add the required dependencies

To complete this recipe, you need to add three dependencies to your app:

[`camera`][]
: Provides tools to work with the cameras on the device.

[`path_provider`][]
: Finds the correct paths to store images.

[`path`][]
: Creates paths that work on any platform.

```yaml
dependencies:
  flutter:
    sdk: flutter
  camera:
  path_provider:
  path:
```
{{site.alert.tip}}
  - For android, You must have to update `minSdkVersion` to 21 (or higher).
  - On iOS, lines below have to be added inside `ios/Runner/Info.plist` in order the access the camera.
    ```
    <key>NSCameraUsageDescription</key>
    <string>Explanation on why the camera access is needed.</string>
    ```
{{site.alert.end}}

## 2. Get a list of the available cameras

Next, get a list of available cameras using the `camera` plugin.

<?code-excerpt "lib/main.dart (init)"?>
```dart
// Ensure that plugin services are initialized so that `availableCameras()`
// can be called before `runApp()`
WidgetsFlutterBinding.ensureInitialized();

// Obtain a list of the available cameras on the device.
final cameras = await availableCameras();

// Get a specific camera from the list of available cameras.
final firstCamera = cameras.first;
```

## 3. Create and initialize the `CameraController`

Once you have a camera, use the following steps to
create and initialize a `CameraController`.
This process establishes a connection to
the device's camera that allows you to control the camera
and display a preview of the camera's feed.

  1. Create a `StatefulWidget` with a companion `State` class.
  2. Add a variable to the `State` class to store the `CameraController`.
  3. Add a variable to the `State` class to store the `Future`
     returned from `CameraController.initialize()`.
  4. Create and initialize the controller in the `initState()` method.
  5. Dispose of the controller in the `dispose()` method.

<?code-excerpt "lib/main_step3.dart (controller)"?>
```dart
// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fill this out in the next steps.
    return Container();
  }
}
```

{{site.alert.warning}}
  If you do not initialize the `CameraController`,
  you *cannot* use the camera to display a preview and take pictures.
{{site.alert.end}}

## 4. Use a `CameraPreview` to display the camera's feed

Next, use the `CameraPreview` widget from the `camera` package to
display a preview of the camera's feed.

{{site.alert.secondary}}
  **Remember** You must wait until the controller has finished
  initializing before working with the camera. Therefore,
  you must wait for the `_initializeControllerFuture()` created
  in the previous step to complete before showing a `CameraPreview`.
{{site.alert.end}}

Use a [`FutureBuilder`][] for exactly this purpose.

<?code-excerpt "lib/main.dart (FutureBuilder)" replace="/body: //g;/,$//g"?>
```dart
// You must wait until the controller is initialized before displaying the
// camera preview. Use a FutureBuilder to display a loading spinner until the
// controller has finished initializing.
FutureBuilder<void>(
  future: _initializeControllerFuture,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      // If the Future is complete, display the preview.
      return CameraPreview(_controller);
    } else {
      // Otherwise, display a loading indicator.
      return const Center(child: CircularProgressIndicator());
    }
  },
)
```

## 5. Take a picture with the `CameraController`

You can use the `CameraController` to take pictures using the
[`takePicture()`][] method, which returns an [`XFile`][],
a cross-platform, simplified `File` abstraction.
On both Android and IOS, the new image is stored in their
respective cache directories,
and the `path` to that location is returned in the `XFile`.

[`XFile`]:  {{site.pub}}/documentation/camera/latest/camera/XFile-class.html

In this example, create a `FloatingActionButton` that takes a picture
using the `CameraController` when a user taps on the button.

Taking a picture requires 2 steps:

  1. Ensure that the camera is initialized.
  2. Use the controller to take a picture and ensure that it returns a `Future<XFile>`.

It is good practice to wrap these operations in a `try / catch` block in order
to handle any errors that might occur.

<?code-excerpt "lib/main_step5.dart (FAB)" replace="/^floatingActionButton: //g;/,$//g"?>
```dart
FloatingActionButton(
  // Provide an onPressed callback.
  onPressed: () async {
    // Take the Picture in a try / catch block. If anything goes wrong,
    // catch the error.
    try {
      // Ensure that the camera is initialized.
      await _initializeControllerFuture;

      // Attempt to take a picture and then get the location
      // where the image file is saved.
      final image = await _controller.takePicture();
    } catch (e) {
      // If an error occurs, log the error to the console.
      print(e);
    }
  },
  child: const Icon(Icons.camera_alt),
)
```
## 6. Display the picture with an `Image` widget

If you take the picture successfully, you can then display the saved picture
using an `Image` widget. In this case, the picture is stored as a file on
the device.

Therefore, you must provide a `File` to the `Image.file` constructor.
You can create an instance of the `File` class by passing the path created in
the previous step.

<!-- skip -->
```dart
Image.file(File('path/to/my/picture.png'))
```

## Complete example

<?code-excerpt "lib/main.dart"?>
```dart
import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(
        // Pass the appropriate camera to the TakePictureScreen widget.
        camera: firstCamera,
      ),
    ),
  );
}

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();

            // If the picture was taken, display it on a new screen.
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  // Pass the automatically generated path to
                  // the DisplayPictureScreen widget.
                  imagePath: image.path,
                ),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}
```


[`camera`]: {{site.pub-pkg}}/camera
[`FutureBuilder`]: {{site.api}}/flutter/widgets/FutureBuilder-class.html
[`path`]: {{site.pub-pkg}}/path
[`path_provider`]: {{site.pub-pkg}}/path_provider
[`takePicture()`]: {{site.pub}}/documentation/camera/latest/camera/CameraController/takePicture.html
