---
title: Leveraging Apple's System APIs and Frameworks
description: Learn about Flutter plugins that offer equivalent functionalities to Apple's frameworks
---

When you come from iOS development, you might need to find
Flutter plugins that offer the same abilities as Apple's system
libraries. This might include accessing device hardware or interacting
with specific frameworks like `HealthKit` or `MapKit`.

For an overview of how the SwiftUI framework compares to Flutter,
see [Flutter for SwiftUI developers][].

### Introducing Flutter plugins
Dart calls libraries that contain platform-specific code _plugins_.
When developing an app with Flutter, you use _plugins_ to interact
with system libraries.

In your Dart code, you use the plugin's Dart API to call the native
code from the system library being used. This means that you can write
the code to call the Dart API. The API then makes it work for all
platforms that the plugin supports.

To learn more about plugins, see [Using packages][].
Though this page links to some popular plugins,
you can find thousands more, along with examples,
on [pub.dev][]. The following table does not endorse any particular plugin.
If you can't find a package that meets your need,
you can create your own or use platform channels directly in your project.
To learn more, see [Writing platform-specific code][].

### Adding a plugin to your project
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

<table class="table table-striped nowrap">
<tr>
<th markdown="1">
Use Case
</th>
<th markdown="1">
Apple Framework or Class
</th>
<th markdown="1">
Flutter Plugin
</th>
</tr>

<tr>
<td markdown="1">
Access the photo library
</td>
<td markdown="1">
* `PhotoKit`<br>using the `Photos` and `PhotosUI ` frameworks
* `UIImagePickerController`
</td>
<td markdown="1">
[`image_picker`][]
</td>
</tr>

<tr>
<td markdown="1">
Access the camera
</td>
<td markdown="1">
`UIImagePickerController`<br>using the `.camera` `sourceType`
</td>
<td markdown="1">
[`image_picker`][]
</td>
</tr>

<tr>
<td markdown="1">
Use advanced camera features
</td>
<td markdown="1">
`AVFoundation`
</td>
<td markdown="1">
[`camera`][]
</td>
</tr>

<tr>
<td markdown="1">
Offer In-app purchases
</td>
<td markdown="1">
`StoreKit`
</td>
<td markdown="1">
[`in_app_purchase`][][^1]
</td>
</tr>

<tr>
<td markdown="1">
Process payments
</td>
<td markdown="1">
`PassKit`
</td>
<td markdown="1">
[`pay`][][^2]
</td>
</tr>

<tr>
<td markdown="1">
Send push notifications
</td>
<td markdown="1">
`UserNotifications`
</td>
<td markdown="1">
[`firebase_messaging`][][^3]
</td>
</tr>

<tr>
<td markdown="1">
Access GPS coordinates
</td>
<td markdown="1">
`CoreLocation`
</td>
<td markdown="1">
[`geolocator`][]
</td>
</tr>

<tr>
<td markdown="1">
Access sensor data[^4]
</td>
<td markdown="1">
`CoreMotion`
</td>
<td markdown="1">
[`sensors_plus`][]
</td>
</tr>

<tr>
<td markdown="1">
Embed maps
</td>
<td markdown="1">
`MapKit`
</td>
<td markdown="1">
[`google_maps_flutter`][]
</td>
</tr>

<tr>
<td markdown="1">
Make network requests
</td>
<td markdown="1">
`URLSession`
</td>
<td markdown="1">
[`http`][]
</td>
</tr>

<tr>
<td markdown="1">
Store key-values
</td>
<td markdown="1">
* `@AppStorage` property wrapper
* `NSUserDefaults`
</td>
<td markdown="1">
[`shared_preferences`][]
</td>
</tr>

<tr>
<td markdown="1">
Persist to a database
</td>
<td markdown="1">
`CoreData` or SQLite
</td>
<td markdown="1">
[`sqflite`][]
</td>
</tr>

<tr>
<td markdown="1">
Access health data
</td>
<td markdown="1">
`HealthKit`
</td>
<td markdown="1">
[`health`][]
</td>
</tr>

<tr>
<td markdown="1">
Use machine learning
</td>
<td markdown="1">
`CoreML`
</td>
<td markdown="1">
[`google_ml_kit`][][^5]
</td>
</tr>

<tr>
<td markdown="1">
Recognize text
</td>
<td markdown="1">
`VisionKit`
</td>
<td markdown="1">
[`google_ml_kit`][][^5]
</td>
</tr>

<tr>
<td markdown="1">
Recognize speech
</td>
<td markdown="1">
`Speech`
</td>
<td markdown="1">
[`speech_to_text`][]
</td>
</tr>

<tr>
<td markdown="1">
Use augmented reality
</td>
<td markdown="1">
`ARKit`
</td>
<td markdown="1">
[`ar_flutter_plugin`][]
</td>
</tr>

<tr>
<td markdown="1">
Access weather data
</td>
<td markdown="1">
`WeatherKit`
</td>
<td markdown="1">
[`weather`][][^6]
</td>
</tr>

<tr>
<td markdown="1">
Access and manage contacts
</td>
<td markdown="1">
`Contacts`
</td>
<td markdown="1">
[`contacts_service`][]
</td>
</tr>

<tr>
<td markdown="1">
Expose quick actions on the home screen
</td>
<td markdown="1">
`UIApplicationShortcutItem`
</td>
<td markdown="1">
[`quick_actions`][]
</td>
</tr>

<tr>
<td markdown="1">
Index items in Spotlight search
</td>
<td markdown="1">
`CoreSpotlight`
</td>
<td markdown="1">
[`flutter_core_spotlight`][]
</td>
</tr>

<tr>
<td markdown="1">
Configure, update and communicate with Widgets
</td>
<td markdown="1">
`WidgetKit`
</td>
<td markdown="1">
[`home_widget`][]
</td>
</tr>

</table>

[^1]: Supports both Google Play Store on Android and Apple App Store on iOS.
[^2]: Adds Google Pay payments on Android and Apple Pay payments on iOS.
[^3]: Uses Firebase Cloud Messaging and integrates with APNs.
[^4]: Includes sensors like accelerometer, gyroscope, etc.
[^5]: Uses Google's ML Kit and supports various features like text recognition, face detection, image labeling, landmark recognition, and barcode scanning. You can also create a custom model with Firebase. To learn more, see [Use a custom TensorFlow Lite model with Flutter][].
[^6]: Uses the [OpenWeatherMap API][]. Other packages exist that can pull from different weather APIs.

[Flutter for SwiftUI developers]: {{site.url}}/get-started/flutter-for/swiftui-devs
[Using packages]: {{site.url}}/packages-and-plugins/using-packages
[pub.dev]: {{site.pub-pkg}}
[`shared_preferences`]: {{site.pub-pkg}}/shared_preferences
[`http`]: {{site.pub-pkg}}/http
[`sensors_plus`]: {{site.pub-pkg}}/sensors_plus
[`geolocator`]: {{site.pub-pkg}}/geolocator
[`image_picker`]: {{site.pub-pkg}}/image_picker
[`pubspec.yaml`]: {{site.url}}/tools/pubspec
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
[Writing platform-specific code]: {{site.url}}/platform-integration/platform-channels
[`camera`]: {{site.pub-pkg}}/camera
[`flutter_core_spotlight`]: {{site.pub-pkg}}/flutter_core_spotlight
[`home_widget`]: {{site.pub-pkg}}/home_widget