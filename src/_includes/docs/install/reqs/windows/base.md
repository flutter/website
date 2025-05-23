## Software requirements

To write and compile Flutter code for {{include.target}},
you must have the following version of Windows and the listed
software packages.

### Operating system

Flutter supports developing on 64-bit versions of Windows 10 and 11.

### Development tools

Download and install the Windows version of the following packages:

* [Git for Windows][] to manage Flutter versions and
  your own source code versioning.

{% if include.target == 'desktop' -%}

* [Visual Studio 2022][] to debug and compile native C++ Windows code.
  Make sure to install the **Desktop development with C++** workload.
  This enables building Windows apps, including all of its default components.
  **Visual Studio** is an IDE separate from **[Visual Studio _Code_][]**.

{% elsif include.target == 'Android' -%}

* [Android Studio][] to debug and compile Java or Kotlin code for Android.

{% elsif include.target == 'Web' -%}

* [Google Chrome][] to debug JavaScript code for web apps.

{% else -%}

* [Visual Studio 2022][] with the **Desktop development with C++** workload
  or [Build Tools for Visual Studio 2022][].
  This enables building Windows apps, including all of its default components.
  **Visual Studio** is an IDE separate from **[Visual Studio _Code_][]**.
* [Android Studio][] to debug and compile Java or Kotlin code for Android.
* The latest version of [Google Chrome][] to debug JavaScript code for web apps.

{% endif -%}

The developers of the preceding software provide support for those products.
To troubleshoot installation issues, consult that product's documentation.

[Android Studio]: https://developer.android.com/studio/install#windows
[Visual Studio 2022]: https://learn.microsoft.com/visualstudio/install/install-visual-studio?view=vs-2022
[Build Tools for Visual Studio 2022]: https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022
[Google Chrome]: https://www.google.com/chrome/dr/download/
[Visual Studio _Code_]: https://code.visualstudio.com/

## Configure a text editor or IDE

You can build apps with Flutter using any text editor or
integrated development environment (IDE) combined with
Flutter's command-line tools.

Using an IDE with a Flutter extension or plugin provides code completion,
syntax highlighting, widget editing assists, debugging, and other features.

Popular options include:

* [Visual Studio Code][] with the [Flutter extension for VS Code][].
* [Android Studio][] with the [Flutter plugin for IntelliJ][].
* [IntelliJ IDEA][] with the [Flutter plugin for IntelliJ][].

:::recommend
The Flutter team recommends installing
[Visual Studio Code][] and the [Flutter extension for VS Code][].
This combination simplifies installing the Flutter SDK.
:::

[Android Studio]: https://developer.android.com/studio/install
[IntelliJ IDEA]: https://www.jetbrains.com/help/idea/installation-guide.html
[Visual Studio Code]: https://code.visualstudio.com/docs/setup/windows
[Flutter extension for VS Code]: https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter
[Flutter plugin for IntelliJ]: https://plugins.jetbrains.com/plugin/9212-flutter
[Windows PowerShell]: https://docs.microsoft.com/powershell/scripting/install/installing-windows-powershell
[Git for Windows]: https://gitforwindows.org/
