---
title: Leveraging Apple's System APIs and Frameworks
description: Learn about Flutter plugins that offer equivalent functionalities to Apple's frameworks
---

This document is for iOS developers looking to learn about 
Flutter plugins that offer equivalent functionalities 
to Apple's system libraries. This includes accessing 
the device hardware and interacting 
with specific frameworks like `HealthKit` or `MapKit`.

<!-- Add once SwiftUI PR is merged -->
<!-- For an overview of how the SwiftUI framework compares to Flutter, 
see [Learning Flutter as a SwiftUI developer][].  -->

### Flutter plugin overview
When developing an app with Flutter, you can interact 
with system libraries using plugins. 
Dart calls libraries that contain platform-specific code _plugins_. 
With an iOS app, you can write the code in Objective-C or Swift. 

In your Dart code, you use the plugin's Dart API and 
behind the scenes the native plugin code directly calls
the system library being used. This means that you can write 
the code to call the Dart API once, 
and it works for all platforms that the plugin supports.

To learn more about plugins, see [Using packages][]. 
Though this page links to some popular plugins,
you can find thousands more, along with examples, 
on [pub.dev][]. This is not an endorsement for any plugin.
If you can't find a package that meets your need, 
you can create your own or use platform channels directly in your project. 
For more details, see [Writing platform-specific code][]. 

### Adding a plugin to your project
When using Apple frameworks within your native project, 
import it into your Swift or Objective-C file. 

Flutter requires you to run `flutter pub add package_name` 
from the root of your project. This adds 
the dependency to your [`pubspec.yaml`][] file.
After you add the dependency, `import` the package
in your Dart file. 

Occasionally, you might also need to change app settings or 
initialization logic- which should be explained in the package's 
"Readme" page on [pub.dev][].

### Flutter Plugins and Apple Frameworks

| Use Case | Apple Framework or Class | Flutter Plugin |
| -------- | --------------- | -------------- |
| Accessing the photo library | `PhotoKit` (`Photos` and `PhotosUI ` frameworks) or `UIImagePickerController` class | [`image_picker`][] |
| Accessing the camera | `UIImagePickerController` class with the `.camera` `sourceType` | [`image_picker`][] |
| Advanced camera features | `AVFoundation` | [`camera`][]  |
| In-app purchases | `StoreKit` | [`in_app_purchase`][], which supports both Google Play Store on Android and Apple App Store on iOS |
| Payment processing | `PassKit` | [`pay`][], which adds Google Pay payments on Android and Apple Pay payments on iOS. |
| Push notifications | `UserNotifications` | [`firebase_messaging`][], which uses Firebase Cloud Messaging and integrates with APNs| 
| Accessing GPS coordinates | `CoreLocation` | [`geolocator`][] |
| Accessing sensor data (e.g. accelerometer, gyroscope) | `CoreMotion`  | [`sensors_plus`][] |
| Embedding maps | `MapKit` | [`google_maps_flutter`][] |
| Network requests| `URLSession` class | [`http`][] |
| Store key-values | `@AppStorage` property wrapper or `NSUserDefaults` class| [`shared_preferences`][] |
| Persisting to a database | `CoreData` or SQLite | [`sqflite`][] |
| Accessing health data | `HealthKit`| [`health`][] |
| Leveraging machine learning | `CoreML` for integrating machine learning models into your app, or `VisionKit` for text recognition | [`google_ml_kit`][], which leverages Google's ML Kit and supports various features like text recognition, face detection, image labeling, landmark recognition, and barcode scanning. Alternatively, you can create a custom model with Firebase. For more information, see [Use a custom TensorFlow Lite model with Flutter][]. |
| Leveraging speech recognition | `Speech`| [`speech_to_text`][]|
| Leveraging augmented reality  | `ARKit`| [`ar_flutter_plugin`][]|
| Accessing weather data  | `WeatherKit`| [`weather`][] package, which uses the [OpenWeatherMap API][]. Alternatively, there are other packages that pull from different weather APIs.|
| Accessing and managing contacts | `Contacts`| [`contacts_service`][]|
| Exposing quick actions on the home screen | `UIApplicationShortcutItem` class | [`quick_actions`][]|


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
[OpenWeatherMap API]: https://openweathermap.org/api
[`sqflite`]: {{site.pub-pkg}}/sqflite
[Writing platform-specific code]: {{ site.url }}/development/platform-integration/platform-channels