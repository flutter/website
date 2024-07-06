{% case include.target %}
{% when 'mobile-ios' %}
{% assign v-target = "iOS" %}
{% when 'mobile-android' %}
{% assign v-target = "Android" %}
{% else %}
{% assign v-target = include.target %}
{% endcase %}

{% render docs/install/admonitions/install-in-order.md %}

## Verify system requirements

To install and run Flutter,
your {{include.os}} environment must meet the following hardware
and software requirements.

### Hardware requirements

Your {{include.os}} Flutter development environment must meet the following
minimal hardware requirements.

|     Requirement              |                                    Minimum                               |    Recommended      |
|:-----------------------------|:------------------------------------------------------------------------:|:-------------------:|
| CPU Cores                    | 4                                                                        | 8                   |
| Memory in GB                 | 8                                                                        | 16                  |
| Display resolution in pixels | WXGA (1366 x 768)                                                        | FHD (1920 x 1080)   |
| Free disk space in GB        | {% include docs/install/reqs/macos/storage.md target=include.target %}

{:.table .table-striped}

### Software requirements

To write and compile Flutter code for {{v-target}},
install the following packages.

{% render docs/install/admonitions/install-dart.md %}

#### Operating system

Flutter supports macOS {{site.devmin.macos}} or later.
This guide presumes your Mac runs the `zsh` as your default shell.

{% include docs/install/reqs/macos/zsh-config.md target=include.target %}

{% include docs/install/reqs/macos/apple-silicon.md %}

#### Development tools

Download and install the following packages.

{% include docs/install/reqs/macos/software.md target=include.target %}

The developers of the preceding software provide support for those products.
To troubleshoot installation issues, consult that product's documentation.

{% render docs/install/reqs/flutter-sdk/flutter-doctor-precedence.md %}

#### Text editor or integrated development environment

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
  with both the [Flutter plugin for IntelliJ][] and
  the [Android plugin for IntelliJ][].

:::recommend
The Flutter team recommends installing
[Visual Studio Code][] {{site.appmin.vscode}} or later and the
[Flutter extension for VS Code][].
This combination simplifies installing the Flutter SDK.
:::

[Android Studio]: https://developer.android.com/studio/install
[IntelliJ IDEA]: https://www.jetbrains.com/help/idea/installation-guide.html
[Visual Studio Code]: https://code.visualstudio.com/docs/setup/mac
[Flutter extension for VS Code]: https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter
[Flutter plugin for IntelliJ]: https://plugins.jetbrains.com/plugin/9212-flutter
[Android plugin for IntelliJ]: https://plugins.jetbrains.com/plugin/22989-android
