## Software requirements

To write and compile Flutter code for {{include.target}},
you must have the following version of Windows and the listed
software packages.

{% render docs/install/admonitions/install-dart.md %}

### Operating system

Flutter supports {{site.devmin.windows}} or later.
These versions of Windows should include the required
[Windows PowerShell][] {{site.appmin.powershell}} or later.

### Development tools

Download and install the Windows version of the following packages:

* [Git for Windows][] {{site.appmin.git_win}} or later to manage source code.
{% include docs/install/reqs/windows/software.md target=include.target %}

The developers of the preceding software provide support for those products.
To troubleshoot installation issues, consult that product's documentation.

{% render docs/install/reqs/flutter-sdk/flutter-doctor-precedence.md %}

## Configure a text editor or IDE

You can build apps with Flutter using any text editor or
integrated development environment (IDE) combined with
Flutter's command-line tools.

Using an IDE with a Flutter extension or plugin provides code completion,
syntax highlighting, widget editing assists, debugging, and other features.

Popular options include:

* [Visual Studio Code][] {{site.appmin.vscode}} or later
  with the [Flutter extension for VS Code][].
* [Android Studio][] {{site.appmin.android_studio}} or later
  with the [Flutter plugin for IntelliJ][].
* [IntelliJ IDEA][] {{site.appmin.intellij_idea}} or later
  with the [Flutter plugin for IntelliJ][].

:::recommend
The Flutter team recommends installing [Visual Studio Code][]
{{site.appmin.vscode}} or later and the [Flutter extension for VS Code][].
This combination simplifies installing the Flutter SDK.
:::

[Android Studio]: https://developer.android.com/studio/install
[IntelliJ IDEA]: https://www.jetbrains.com/help/idea/installation-guide.html
[Visual Studio Code]: https://code.visualstudio.com/docs/setup/windows
[Flutter extension for VS Code]: https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter
[Flutter plugin for IntelliJ]: https://plugins.jetbrains.com/plugin/9212-flutter
[Windows PowerShell]: https://docs.microsoft.com/powershell/scripting/install/installing-windows-powershell
[Git for Windows]: https://gitforwindows.org/
