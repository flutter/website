{% if include.target == 'desktop' -%}

* [Visual Studio 2022][] to debug and compile native C++ Windows code.
  Make sure to install the **Desktop development with C++** workload.
  This enables building Windows app including all of its default components.
  **Visual Studio** is an IDE separate from **[Visual Studio _Code_][]**.

{% elsif include.target == 'mobile' -%}

* [Android Studio][] {{site.appmin.android_studio}} to debug and compile
  Java or Kotlin code for Android.
  Flutter requires the full version of Android Studio.

{% elsif include.target == 'web' -%}

* [Google Chrome][] to debug JavaScript code for web apps.

{% else -%}

* [Visual Studio 2022][] to debug and compile native C++ Windows code.
  Make sure to install the **Desktop development with C++** workload.
  This enables building Windows app including all of its default components.
  **Visual Studio** is an IDE separate from **[Visual Studio _Code_][]**.
* [Android Studio][] {{site.appmin.android_studio}} to debug and compile
  Java or Kotlin code for Android.
  Flutter requires the full version of Android Studio.
* The latest version of [Google Chrome][] to debug JavaScript code for web apps.

{% endif -%}

[Android Studio]: https://developer.android.com/studio/install#windows
[Visual Studio 2022]: https://learn.microsoft.com/visualstudio/install/install-visual-studio?view=vs-2022
[Google Chrome]: https://www.google.com/chrome/dr/download/
[Visual Studio _Code_]: https://code.visualstudio.com/