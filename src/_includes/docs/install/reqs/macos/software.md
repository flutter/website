{% if include.target == 'desktop' or include.target == 'mobile-ios' -%}

* [Xcode][] to debug and compile native Swift or ObjectiveC code.
* [CocoaPods][] to compile native code and Dart code together.

{% elsif include.target == 'mobile-android' -%}

* [Android Studio][] {{site.appmin.android_studio}} to debug and compile
  Java or Kotlin code for Android.
  Flutter requires the full version of Android Studio.

{% elsif include.target == 'web' -%}

* [Google Chrome][] to debug JavaScript code for web apps.

{% else -%}

* [Xcode][] to debug and compile native Swift or ObjectiveC code.
* [CocoaPods][] to compile native code and Dart code together.
* [Android Studio][] {{site.appmin.android_studio}} to debug and compile
  Java or Kotlin code for Android.
  Flutter requires the full version of Android Studio.
* The latest version of [Google Chrome][] to debug JavaScript code for web apps.

{% endif -%}

[Android Studio]: https://developer.android.com/studio/install#mac
[Xcode]: {{site.apple-dev}}/xcode/
[CocoaPods]: https://cocoapods.org/
[Google Chrome]: https://www.google.com/chrome/dr/download/
