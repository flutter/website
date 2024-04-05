{% assign os = include.os %}
{% assign target = include.target %}

{% include docs/install/admonitions/install-in-order.md %}

## Verify system requirements

To install and run Flutter,
your {{os}} environment must meet the following hardware
and software requirements.

### Hardware requirements

Your {{os}} Flutter development environment must meet the following
minimal hardware requirements.

<div class="table-wrapper">

|     Requirement              |                                    Minimum                               |    Recommended      |
|:-----------------------------|:------------------------------------------------------------------------:|:-------------------:|
| CPU Cores                    | 4                                                                        | 8                   |
| Memory in GB                 | 8                                                                        | 16                  |
| Display resolution in pixels | WXGA (1366 x 768)                                                        | FHD (1920 x 1080)   |
| Free disk space in GB        | {% include docs/install/reqs/linux/storage.md target=target %}

{:.table .table-striped}

</div>

{% if os == 'ChromeOS' and target == 'Android' %}
To discover which hardware devices ChromeOS recommends for Android development,
consult the [ChromeOS docs][chromeos-docs].
{% endif %}

[chromeos-docs]: https://chromeos.dev/en/android-environment

### Software requirements

To write and compile Flutter code for {{target}},
you must have the following version of {{os}} and the listed
software packages.

#### Operating system

{% if os == 'Linux' %}
{%- capture supported-os %}
Debian Linux {{site.devmin.linux.debian}} or later
and Ubuntu Linux {{site.devmin.linux.ubuntu}} or later
{% endcapture -%}
{% else %}
{% assign supported-os = 'ChromeOS' %}
{% endif %}

Flutter supports {{supported-os}}.

#### Development tools {:.no_toc}

{% include docs/install/reqs/linux/software.md target=target os=os %}

{% include docs/install/reqs/flutter-sdk/flutter-doctor-precedence.md %}

The developers of the preceding software provide support for those products.
To troubleshoot installation issues, consult that product's documentation.

## Configure a text editor or IDE

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
