---
title: "How it’s made: Holobooth"
description: "A virtual photo booth experience showcasing Flutter and Machine Learning"
publishDate: 2023-01-24
author: verygoodopensource
image: images/18zOCQg2Qwh_dzC4ndMzoqg.webp
category: story
layout: blog
---

Introducing the Flutter Forward [Holobooth](https://holobooth.flutter.dev/), a new experience showcasing the power of [Flutter](https://flutter.dev/), [Firebase](https://firebase.google.com/), and Machine Learning (using [MediaPipe](https://mediapipe.dev/) and [TensorFlow.js](https://tensorflow.org/js)) in a virtual photo booth experience. Start by selecting your avatar (Dash or Sparky) and transport yourself to a tropical beach, volcanic mountain, outer space, the ocean floor, or somewhere else! Since we can’t transport everyone to Nairobi to attend [Flutter Forward](https://flutter.dev/events/flutter-forward) in person, we wanted to provide a virtual experience that is just as exciting! With Holobooth, you can capture a short video to commemorate your virtual visit. Then, show your friends by sharing on Twitter or Facebook.

<DashImage figure src="images/18zOCQg2Qwh_dzC4ndMzoqg.webp" alt="Try out the Flutter Forward Holobooth at [holobooth.flutter.dev](https://holobooth.flutter.dev/)" caption="Try out the Flutter Forward Holobooth at [holobooth.flutter.dev](https://holobooth.flutter.dev/)" />

The Holobooth builds on the first version of the [Photo Booth app from Google I/O 2021](https://medium.com/flutter/how-its-made-i-o-photo-booth-3b8355d35883). Instead of taking photos of you and Dash or Sparky, Holobooth uses machine learning to control animations of Dash or Sparky using your facial expressions.

We’ll break down how our team collaborated with Google to create a more immersive and futuristic photo booth experience by tapping into the power of Google tools. We used [Flutter](https://flutter.dev/) and [Firebase](https://firebase.google.com/) to build the Holobooth app. Web ML in JavaScript allowed us to take the experience to the next level with virtual, interactive, 3D avatars. Let’s dive into how we built it!

## Detecting faces with TensorFlow.js

One of the most exciting features of the [Holobooth](https://holobooth.flutter.dev/) is the ability to map live video of your face onto a 3D model of Dash (or Sparky) as you travel through their virtual world. If your face expresses surprise, Dash’s face expresses surprise, and so on. To achieve this, we used the [camera](https://pub.dev/packages/camera) plugin for Flutter web and [TensorFlow.js](https://www.tensorflow.org/js) to detect the user’s face within the frame of the camera. More specifically, we used the [MediaPipe FaceMesh](https://github.com/tensorflow/tfjs-models/tree/master/face-landmarks-detection) model, which estimates 468 3D face landmarks in real-time, to detect features of the user’s face within the camera frame across web and mobile browsers.

<DashImage figure src="images/1_Pp7DaS5DOfQJtMfjJ3m2Q.webp" alt="Features detected with the MediaPipe FaceMesh model" caption="Features detected with the MediaPipe FaceMesh model" />

Based on the position of each facial feature, we can determine if the user is in frame, if their eyes or mouth are open, and more. As the user moves around the camera view, the MediaPipe [FaceMesh](https://github.com/tensorflow/tfjs-models/tree/master/face-landmarks-detection) model (available via the [TensorFlow.js Face Landmarks Detection package](https://github.com/tensorflow/tfjs-models/tree/master/face-landmarks-detection)) ensures that we can track the exact coordinates of the user’s features so that we can mirror them on Dash or Sparky. For more details, you can dig into the [face_geometry.dart file](https://github.com/flutter/holobooth/blob/1c5bc00f0b43dd56ea7f964b26756a5991d6502e/packages/face_geometry/lib/src/face_geometry.dart). While there isn’t an official Dart package for TensorFlow.js yet, the Dart [JS](https://pub.dev/packages/js) package allowed us to import the javascript library into a Flutter web app (see the [tensorflow_models](https://github.com/flutter/holobooth/tree/1c5bc00f0b43dd56ea7f964b26756a5991d6502e/packages/tensorflow_models) package folder for more details).

```dart
FaceGeometry({
  required tf.Face face,
  required tf.Size size,
}) : this._(
        rotation: FaceRotation(keypoints: face.keypoints),
        leftEye: LeftEyeGeometry(
          keypoints: face.keypoints,
          boundingBox: face.boundingBox,
        ),
        rightEye: RightEyeGeometry(
          keypoints: face.keypoints,
          boundingBox: face.boundingBox,
        ),
        mouth: MouthGeometry(
          keypoints: face.keypoints,
          boundingBox: face.boundingBox,
        ),
        distance: FaceDistance(
          boundingBox: face.boundingBox,
          imageSize: size,
        ),
      );

const FaceGeometry._({
  required this.rotation,
  required this.mouth,
  required this.leftEye,
  required this.rightEye,
  required this.distance,
});
```

## Animating backgrounds and avatars with Rive and TensorFlow.js

We turned to [Rive](https://rive.app/) to bring Holobooth animations to life. Rive is a web app built in Flutter that provides tools for building highly performant, lightweight, interactive animations that are easy to integrate into a Flutter app. We collaborated with talented designers at Rive and [HOPR design studio](https://www.hopr.tv/) to create animated Rive graphics that work seamlessly within our Flutter app. The animated backgrounds and avatars are Rive animations.

<DashImage figure src="images/1mvB6J_LUq2WQWJpIZ4A7IQ.gif" alt="Move your face to see the Rive model mimic your behavior" caption="Move your face to see the Rive model mimic your behavior" />

The avatars use Rive [State Machines](https://help.rive.app/editor/state-machine) that allow us to control how an avatar behaves and looks. In the Rive State Machine, designers specify all of the inputs. Inputs are values that are controlled by your app. You can think of them as the contract between design and engineering teams. Your product’s code can change the values of the inputs at any time, and the State Machine reacts to those changes.

For Holobooth, we used inputs to control things like how wide a mouth is open or closed. Using the feature detection from the [FaceMesh](https://github.com/tensorflow/tfjs-models/tree/master/face-landmarks-detection) model, we can map them to the corresponding coordinates on our avatar models. Using the StateMachineController, we transform the input from the models to determine how the avatar appears on screen.

```dart
class CharacterStateMachineController extends StateMachineController {
  CharacterStateMachineController(Artboard artboard)
      : super(
          artboard.animations.whereType<StateMachine>().firstWhere(
                (stateMachine) => stateMachine.name == 'State Machine 1',
              ),
```

For example, the avatar models have a property to measure the [openness of the mouth](https://github.com/flutter/holobooth/blob/1c5bc00f0b43dd56ea7f964b26756a5991d6502e/lib/rive/widgets/character_animation.dart) (measured from 0–1 where 0 is fully closed and 1 is fully open). If the user closes their mouth within the camera view, the app provides the corresponding value and feeds it into the avatar model so you see your avatar’s mouth also closes on the screen.

## Capturing the dynamic photo with Firebase

The main feature of Holobooth is the GIF or video that you can share to celebrate Flutter Forward. We turned to [Cloud Functions for Firebase](https://firebase.google.com/products/functions) to help us generate and upload your dynamic photo to [Cloud Storage for Firebase](https://firebase.google.com/products/storage). Once you press the camera button, the app starts capturing frames for a duration of 5 seconds. With [ffmpeg](https://www.npmjs.com/package/fluent-ffmpeg), we use a Cloud Function to convert the frames into a single GIF and video that are then uploaded to [Cloud Storage for Firebase](https://firebase.google.com/products/storage). You can choose to download your GIF or video for later viewing or to manually upload it to social media.

<DashImage figure src="images/1YV7A0DsrEyf2r3hvJ6HqNA.gif" alt="Capturing the dynamic photo" caption="Capturing the dynamic photo" />

To share your GIF directly to Twitter or Facebook, you can click the share button. You are then taken to the selected platform with a pre-populated post containing a photo of the first frame of your video. To see the full video, click on the link to your holocard — a web page that displays your video in full and a button directing visitors to try out Holobooth for themselves!

<DashImage figure src="images/1gqq0z-7kyXE0GS086zbVUw.webp" alt="Example holocard" caption="Example holocard" />

## Challenges and how we addressed them

Holobooth contains a lot of elements that are expanding what’s possible with Flutter — like using machine learning models and Rive graphics, all while ensuring a performant, smooth experience for users.

Working with TensorFlow.js was a first for us at Very Good Ventures. There are currently no official Flutter libraries, so much of our early work on this project focused on experimenting with the available models to figure out which one fit our needs. Once we settled on the landmark detection model, we then had to make sense of the data that the models output and map them onto the Rive animations. Here is an early exploration with face detection:

<DashImage figure src="images/1hdTGZAcinWlt2yR-4CLt2w.gif" alt="Early exploration of face detection" caption="Early exploration of face detection" />

The official Flutter [camera](https://pub.dev/packages/camera) plugin gave us a lot of functionality out of the box, but it currently doesn’t support streaming images on the web. For Holobooth, we [forked](https://github.com/flutter/plugins/compare/main...VGVentures:plugins:feat/camera-video-controller?expand=1) the camera plugin to add this functionality. We hope that this is supported by the [official plugin in the future](https://github.com/flutter/flutter/issues/92460).

Another challenge was optimizing for performance. Recording the screen can be an expensive operation because the app is capturing lots of data. We also had to take into account that users would be accessing this app from different browsers and devices. We wanted to ensure that the app is performant and provides a smooth experience for users no matter what device they’re using. When accessing Holobooth on desktop, video backgrounds are animated and reflect a landscape orientation. To optimize for mobile browsers, backgrounds are static and cropped to fit portrait mode orientation. Since a mobile screen is smaller than on desktop, we also optimized the resolution of image assets to reduce the initial page load and the amount of data used by the device.

For more details on how we addressed these challenges and more, you can check out the [open source code](https://github.com/flutter/holobooth). We hope that this can serve as inspiration for developers wanting to experiment with TensorFlow.js, Rive, and videos, or even those just looking to optimize their web apps.

## Looking forward

In creating this demo, we wanted to explore the potential for Flutter web apps to integrate with TensorFlow.js models in an easy, performant, and fun way. While a lot of what we’ve built is still experimental, we’re excited for the future of machine learning in Flutter apps to create delightful experiences for users on any device! Join the community conversation, let us know what you think, and how you might use machine learning in your next Flutter project.

[**Take a video in the Holobooth and share it with us on social media!**](https://holobooth.flutter.dev/)
