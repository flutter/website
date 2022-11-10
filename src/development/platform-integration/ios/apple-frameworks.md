---
title: Leveraging Apple's System Libraries
description: Learn how to apply knowledge of Apple's APIs and frameworks when building Flutter apps.
---

This document is for iOS developers looking to apply
their existing knowledge of Apple's APIs within Flutter.
This includes accessing the device hardware and interacting 
with specific frameworks like `HealthKit` or `MapKit`.

<!-- Add once SwiftUI PR is merged -->
<!-- For an overview of how the SwiftUI framework compares to Flutter, 
see [Learning Flutter as a SwiftUI developer][].  -->

### Flutter plugin overview
When developing an app with Flutter, you can interact 
with system libraries using plugins. 
Plugins are Dart libraries that contain platform-specific code. 
In the case of an iOS app, 
the platform code can be written in Objective-C or Swift. 

In your Dart code, you use the plugin's Dart API and 
behind the scenes the native plugin code will directly call 
the system library being used. This means that you can write 
the code to call the Dart API once, 
and it will work for all the platforms 
that the plugin has been written for. 

To learn more about plugins see [Using packages][]. 
This document links out to some commonly used plugins, 
and their examples, but there are thousands more available on [pub.dev][]. 
And, if you can't find what you're looking for, you can create your own. 

### Adding a plugin to your project
When using Apple frameworks within your native project, 
you usually just need to import it into your Swift or Objective-C file. 

In Flutter, you must first run `flutter pub add package_name` 
in the terminal, from the root of your project. This adds 
the dependency to your [`pubspec.yaml`][] file. You can then import 
the package in your Dart file. 

Occasionally, you may also need to change app settings or 
initialization logic- which will be explained in the package's 
"Readme" page on [pub.dev][].

### Accessing the photo library
In Swift and Objective-C, you use `PhotoKit` and the `PhotosUI` framework
to access user photos.

In Flutter, you can use the [`image_picker`][] plugin, 
which supplies an `ImpagePicker` class that is used to 
display the user's photo library.

### Accessing the camera
In SwiftUI and UIKit, to allow your app's users to take a photo, 
you use the `UIImagePickerController` class, 
with the `.camera` `sourceType`.

In Flutter, to access the camera, 
you'll use the same [`image_picker`][] plugin that was 
referenced above. The code will look similar, 
only now the `source` for `pickImage` is the camera.

### In-app purchases
In Swift and Objective-c, you use `StoreKit` to 
offer in-app purchases.

In Flutter, you can support in-app purchases through the 
Google Play store on Android and the 
Apple App Store on iOS by using the 
[`in_app_purchase`][] plugin.

### Payment processing
In Swift and Objective-C, you use `PassKit` to process 
Apple Pay payments in your app. 

In Flutter, you can use the [`pay`][] plugin to 
add Google Pay payments on Android
 and Apple pay payments on iOS.

### Push notifications
In Swift and Objective-C, you use the `UserNotifications` 
framework for pushing user-facing notifications.

In Flutter, you can use the [`firebase_messaging`][] plugin, 
which uses Firebase Cloud Messaging. 

### Accessing GPS coordinates
In Swift and Objective-C, you use the `CLLocationManager` class, 
of the `CoreLocation` framework, 
to access the user's location. 

In Flutter, to access the user's location, 
you can use the [`geolocator`][] plugin. 

### Accessing sensor data
In Swift and Objective-C, you use the `CMMotionManager` class,
of the `CoreMotion` framework, to access sensor data
like the accelerometer or the gyroscope.

In Flutter, to read sensor data, 
you can use the [`sensors_plus`][] plugin.

### Embedding maps
In Swift and Objective-c, you use `MapKit` to embed 
Apple Maps within your app. 

In Flutter, you can embed Google Maps using the 
[`google_maps_flutter`][] plugin. 

### Network requests
In Swift and Objective-C, to make an HTTP request you use the
 `URLSession` class.

In Flutter, you can use the [`http`][] package.

### Persisting data
In SwiftUI, to persist small pieces of data in your application, 
you would likely use the `@AppStorage` property wrapper.

In Flutter, to utilize the operating system's key-value storage, 
you can use the [`shared_preferences`][] plugin. 

### Accessing health data
In Swift and Objective-C, you use the `HealthKit` framework
to access health and fitness data.

In Flutter, you can use the [`health`][] plugin 
to access `HealthKit` data.

### Leveraging machine learning
In Swift and Objective-C, you might use the `CoreML` framework 
for integrating machine learning models into your app, 
or `VisionKit` for text recognition.

In Flutter, you can leverage Google's ML Kit with the [`google_ml_kit`][] plugin. 
This supports various features like text recognition, 
face detection, image labeling, landmark recognition and barcode scanning.
Alternatively, you can create a custom model with Firebase. For more information, 
see [Use a custom TensorFlow Lite model with Flutter][].

### Leveraging speech recognition
In Swift and Objective-C, you might use the `Speech` framework for performing 
speech recognition.

In Flutter, you can use the [`speech_to_text`][] plugin, which exposes 
device specific speech recognition capabilities.

### Leveraging augmented reality 
In Swift and Objective-C, you might use the `ARKit` framework 
for creating augmented reality apps. 

In Flutter, you can use the [`ar_flutter_plugin`][]. 

### Accessing weather data
In Swift and Objective-C, you might use the `WeatherKit` framework 
for accessing weather conditions and forecasts. 

In Flutter, you can use the [`weather`][] package, 
which uses the [OpenWeatherMap API]. 
Alternatively, there are other packages 
that pull from different weather APIs.

### Accessing and managing contacts
In Swift and Objective-C, you might use the `Contacts` framework 
for accessing the user's contacts. 

In Flutter, you can use the [`contacts_service`][] plugin, 
for accessing and managing contacts.

### Adding quick actions
In Swift and Objective-C, you use the 
`UIApplicationShortcutItem` class 
for defining quick actions. Quick actions 
expose commonly used functionality on the home screen.

In Flutter, you can use the [`quick_actions`][] plugin.

<!-- [Learning Flutter as a SwiftUI developer]: -->
[Using packages]: {{ site.url }}/development/packages-and-plugins/using-packages
[pub.dev]: {{site.pub-pkg}}
[`shared_preferences`]: {{site.pub-pkg}}/shared_preferences
[`http`]: {{site.pub-pkg}}/http
[`sensors_plus`]: {{site.pub-pkg}}/sensors_plus
[`geolocator`]: {{site.pub-pkg}}/geolocator
[`image_picker`]: {{site.pub-pkg}}/image_picker
[`pubspec.yaml`]: {{ site.url }}/development/tools/pubspec
[`quick_actions`]: {{site.pub-pkg}}/quick_actions
[`in_app_purchase`]: {{site.pub-pkg}}/in_app_purchase
[`pay`]: {{site.pub-pkg}}/pay
[`firebase_messaging`]: {{site.pub-pkg}}/firebase_messaging
[`google_maps_flutter`]: {{site.pub-pkg}}/google_maps_flutter
[`google_ml_kit`]: {{site.pub-pkg}}/google_ml_kit
[Use a custom TensorFlow Lite model with Flutter]: https://firebase.google.com/docs/ml/flutter/use-custom-models
[`speech_to_text`]: {{site.pub-pkg}}/speech_to_text
[`ar_flutter_plugin`]: {{site.pub-pkg}}/ar_flutter_plugin
[`weather`]: {{site.pub-pkg}}/weather
[`contacts_service`]: {{site.pub-pkg}}/contacts_service
[`health`]: {{site.pub-pkg}}/health