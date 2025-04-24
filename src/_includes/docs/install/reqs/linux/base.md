## Software requirements

To write and compile Flutter code for {{include.target}},
you must have the following version of {{include.os}} and the listed
software packages.

{% render docs/install/admonitions/install-dart.md %}

### Operating system

{% if include.os == 'Linux' %}
{%- capture supported-os %}
Debian Linux {{site.devmin.linux.debian}} or later
and Ubuntu Linux {{site.devmin.linux.ubuntu}} or later
{% endcapture -%}
{% else %}
{% assign supported-os = 'ChromeOS' %}
{% endif %}

Flutter supports {{supported-os}}.

### Development tools {:.no_toc}

{% include docs/install/reqs/linux/software.md target=include.target os=include.os %}

{% render docs/install/reqs/flutter-sdk/flutter-doctor-precedence.md %}

The developers of the preceding software provide support for those products.
To troubleshoot installation issues, consult that product's documentation.

# Configure a text editor or IDE

You can build apps with Flutter using any text editor or
integrated development environment (IDE) combined with
Flutter's command-line tools.

Using an IDE with a Flutter extension or plugin provides code completion,
syntax highlighting, widget editing assists, debugging, and other features.

Popular options include:

* [Visual Studio Code][vscode] {{site.appmin.vscode}} or later
  with the [Flutter extension for VS Code][].
* [Android Studio][] {{site.appmin.android_studio}} or later
  with the [Flutter plugin for IntelliJ][].
* [IntelliJ IDEA][] {{site.appmin.intellij_idea}} or later
  with the [Flutter plugin for IntelliJ][].

:::recommend
The Flutter team recommends installing [Visual Studio Code][vscode]
{{site.appmin.vscode}} or later and the [Flutter extension for VS Code][].
This combination simplifies installing the Flutter SDK.
:::

[Android Studio]: https://developer.android.com/studio/install#linux
[IntelliJ IDEA]: https://www.jetbrains.com/help/idea/installation-guide.html
[vscode]: https://code.visualstudio.com/docs/setup/linux
[Flutter extension for VS Code]: https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter
[Flutter plugin for IntelliJ]: https://plugins.jetbrains.com/plugin/9212-flutter
