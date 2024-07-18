---
title: Leveraging Apple's system APIs and frameworks
description: >-
  Learn about Flutter plugins that offer equivalent
  functionalities to Apple's frameworks.
---

When you come from iOS development, you might need to find
Flutter plugins that offer the same abilities as Apple's system
libraries. This might include accessing device hardware or interacting
with specific frameworks like `HealthKit` or `MapKit`.

For an overview of how the SwiftUI framework compares to Flutter,
see [Flutter for SwiftUI developers][].

## Introducing Flutter plugins

Dart calls libraries that contain platform-specific code _plugins_,
short for "plugin package".
When developing an app with Flutter, you use _plugins_ to interact
with system libraries.

In your Dart code, you use the plugin's Dart API to call the native
code from the system library being used. This means that you can write
the code to call the Dart API. The API then makes it work for all
platforms that the plugin supports.

To learn more about plugins, see [Using packages][].
Though this page links to some popular plugins,
you can find thousands more, along with examples,
on [pub.dev][].
The following table does not endorse any particular plugin.
If you can't find a package that meets your needs,
you can create your own or
use platform channels directly in your project.
To learn more, check out [Writing platform-specific code][].

## Adding a plugin to your project

To use an Apple framework within your native project,
import it into your Swift or Objective-C file.

To add a Flutter plugin, run `flutter pub add package_name`
from the root of your project.
This adds the dependency to your [`pubspec.yaml`][] file.
After you add the dependency, add an `import` statement for the package
in your Dart file.

You might need to change app settings or initialization logic.
If that's needed, the package's "Readme" page on [pub.dev][]
should provide details.

### Flutter Plugins and Apple Frameworks

| Use Case                                       | Apple Framework or Class                                                              | Flutter Plugin               |
|------------------------------------------------|---------------------------------------------------------------------------------------|------------------------------|
| Access the photo library                       | `PhotoKit`using the `Photos` and `PhotosUI ` frameworks and `UIImagePickerController` | [`image_picker`][]           |
| Access the camera                              | `UIImagePickerController` using the `.camera` `sourceType`                            | [`image_picker`][]           |
| Use advanced camera features                   | `AVFoundation`                                                                        | [`camera`][]                 |
| Offer In-app purchases                         | `StoreKit`                                                                            | [`in_app_purchase`][][^1]    |
| Process payments                               | `PassKit`                                                                             | [`pay`][][^2]                |
| Send push notifications                        | `UserNotifications`                                                                   | [`firebase_messaging`][][^3] |
| Access GPS coordinates                         | `CoreLocation`                                                                        | [`geolocator`][]             |
| Access sensor data[^4]                         | `CoreMotion`                                                                          | [`sensors_plus`][]           |
| Embed maps                                     | `MapKit`                                                                              | [`google_maps_flutter`][]    |
| Make network requests                          | `URLSession`                                                                          | [`http`][]                   |
| Store key-values                               | `@AppStorage` property wrapper and `NSUserDefaults`                                   | [`shared_preferences`][]     |
| Persist to a database                          | `CoreData` or SQLite                                                                  | [`sqflite`][]                |
| Access health data                             | `HealthKit`                                                                           | [`health`][]                 |
| Use machine learning                           | `CoreML`                                                                              | [`google_ml_kit`][][^5]      |
| Recognize text                                 | `VisionKit`                                                                           | [`google_ml_kit`][][^5]      |
| Recognize speech                               | `Speech`                                                                              | [`speech_to_text`][]         |
| Use augmented reality                          | `ARKit`                                                                               | [`ar_flutter_plugin`][]      |
| Access weather data                            | `WeatherKit`                                                                          | [`weather`][][^6]            |
| Access and manage contacts                     | `Contacts`                                                                            | [`contacts_service`][]       |
| Expose quick actions on the home screen        | `UIApplicationShortcutItem`                                                           | [`quick_actions`][]          |
| Index items in Spotlight search                | `CoreSpotlight`                                                                       | [`flutter_core_spotlight`][] |
| Configure, update and communicate with Widgets | `WidgetKit`                                                                           | [`home_widget`][]            |

{:.table .table-striped .nowrap}

[^1]: Supports both Google Play Store on Android and Apple App Store on iOS.
[^2]: Adds Google Pay payments on Android and Apple Pay payments on iOS.
[^3]: Uses Firebase Cloud Messaging and integrates with APNs.
[^4]: Includes sensors like accelerometer, gyroscope, etc.
[^5]: Uses Google's ML Kit and supports various features like text recognition, face detection, image labeling, landmark recognition, and barcode scanning. You can also create a custom model with Firebase. To learn more, see [Use a custom TensorFlow Lite model with Flutter][].
[^6]: Uses the [OpenWeatherMap API][]. Other packages exist that can pull from different weather APIs.

[Flutter for SwiftUI developers]: /get-started/flutter-for/swiftui-devs
[Using packages]: /packages-and-plugins/using-packages
[pub.dev]: {{site.pub-pkg}}
[`shared_preferences`]: {{site.pub-pkg}}/shared_preferences
[`http`]: {{site.pub-pkg}}/http
[`sensors_plus`]: {{site.pub-pkg}}/sensors_plus
[`geolocator`]: {{site.pub-pkg}}/geolocator
[`image_picker`]: {{site.pub-pkg}}/image_picker
[`pubspec.yaml`]: /tools/pubspec
[`quick_actions`]: {{site.pub-pkg}}/quick_actions
[`in_app_purchase`]: {{site.pub-pkg}}/in_app_purchase
[`pay`]: {{site.pub-pkg}}/pay
[`firebase_messaging`]: {{site.pub-pkg}}/firebase_messaging
[`google_maps_flutter`]: {{site.pub-pkg}}/google_maps_flutter
[`google_ml_kit`]: {{site.pub-pkg}}/google_ml_kit
[Use a custom TensorFlow Lite model with Flutter]: {{site.firebase}}/docs/ml/flutter/use-custom-models
[`speech_to_text`]: {{site.pub-pkg}}/speech_to_text
[`ar_flutter_plugin`]: {{site.pub-pkg}}/ar_flutter_plugin
[`weather`]: {{site.pub-pkg}}/weather
[`contacts_service`]: {{site.pub-pkg}}/contacts_service
[`health`]: {{site.pub-pkg}}/health
[OpenWeatherMap API]: https://openweathermap.org/api
[`sqflite`]: {{site.pub-pkg}}/sqflite
[Writing platform-specific code]: /platform-integration/platform-channels
[`camera`]: {{site.pub-pkg}}/camera
[`flutter_core_spotlight`]: {{site.pub-pkg}}/flutter_core_spotlight
[`home_widget`]: {{site.pub-pkg}}/home_widget
