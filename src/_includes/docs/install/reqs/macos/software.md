{% assign target = include.target %}

{% case target %}
{% when 'desktop','mobile-ios' -%}

* [Xcode][] {{site.appnow.xcode}} to debug and compile native Swift or ObjectiveC code.
* [CocoaPods][] {{site.appnow.cocoapods}} to compile enable Flutter plugins in your native apps.
* Git {{site.appmin.github_mac}} or later to manage source code.
  This installs as part of the Xcode installation.
  * To check if you have `git` installed, type `git version` in your Terminal.
  * If you don't have `git` installed, use [Homebrew][].
  * If you have `homebrew` installed, type `brew install git`.

{% when 'mobile-android' -%}

* [Android Studio][] {{site.appmin.android_studio}} to debug and compile
  Java or Kotlin code for Android.
  Flutter requires the full version of Android Studio.
* [Git][] {{site.appmin.github_mac}} or later to manage source code.
  * To check if you have `git` installed, type `git version` in your Terminal.
  * If you don't have `git` installed, use [Homebrew][].
  * If you have `homebrew` installed, type `brew install git`.

{% when 'web' -%}

* [Google Chrome][] to debug JavaScript code for web apps.
* [Git][] {{site.appmin.github_mac}} or later to manage source code.
  * To check if you have `git` installed, type `git version` in your Terminal.
  * If you don't have `git` installed, use [Homebrew][].
  * If you have `homebrew` installed, type `brew install git`.

{% else -%}

* [Xcode][] {{site.appnow.xcode}} to debug and compile native Swift or ObjectiveC code.
* [CocoaPods][] {{site.appnow.cocoapods}} to compile enable Flutter plugins in your native apps.
* [Android Studio][] {{site.appmin.android_studio}} to debug and compile
  Java or Kotlin code for Android.
  Flutter requires the full version of Android Studio.
* The latest version of [Google Chrome][] to debug JavaScript code for web apps.
* Git {{site.appmin.github_mac}} or later to manage source code.
  This installs as part of the Xcode installation.
  To verify that you have `git` installed, type `git version` in your Terminal.

{% endcase -%}

[Homebrew]: https://brew.sh/
[Git]: https://formulae.brew.sh/formula/git
[Android Studio]: https://developer.android.com/studio/install#mac
[Xcode]: {{site.apple-dev}}/xcode/
[CocoaPods]: https://cocoapods.org/
[Google Chrome]: https://www.google.com/chrome/dr/download/
