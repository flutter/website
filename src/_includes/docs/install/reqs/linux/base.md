## Software requirements

To write and compile Flutter code for {{include.target}},
you must have the following version of {{include.os}} and the listed
software packages.

### Operating system

{% if include.os == 'Linux' %}
{%- capture supportedOs %}
Debian 11 or later
and Ubuntu 22.04 or later LTS
{% endcapture -%}
{% else %}
{% assign supportedOs = 'ChromeOS' %}
{% endif %}

Flutter supports {{supportedOs}}.

### Development tools {:.no_toc}

To develop Flutter on {{include.os}}:

{% if include.os == "ChromeOS" %}

1. Enable [Linux][] on your Chromebook.

{% endif %}

1. Install the following packages:
   [`curl`][curl], [`git`][git], [`unzip`][unzip], [`xz-utils`][xz], [`zip`][zip], `libglu1-mesa`

   ```console
   $ sudo apt-get update -y && sudo apt-get upgrade -y;
   $ sudo apt-get install -y curl git unzip xz-utils zip libglu1-mesa
   ```

{% case include.target %}
{% when 'desktop' -%}

1. To develop {{include.os}} desktop apps, use the
   following command to install these packages:
   [`clang`][clang],
   [`cmake`][cmake],
   [`ninja-build`][ninjabuild],
   [`pkg-config`][pkg-config],
   [`libgtk-3-dev`][gtk3],
   [`libstdc++-12-dev`][libstdc]

   ```console
   $ sudo apt-get install \
         clang cmake git \
         ninja-build pkg-config \
         libgtk-3-dev liblzma-dev \
         libstdc++-12-dev
   ```

[clang]: https://clang.llvm.org/
[cmake]: https://cmake.org/
[gtk3]: https://www.gtk.org/docs/installations/linux#installing-gtk3-from-packages
[ninjabuild]: https://ninja-build.org/
[pkg-config]: https://www.freedesktop.org/wiki/Software/pkg-config/
[libstdc]: https://packages.debian.org/sid/libstdc++-12-dev

{% when 'Android' -%}

1. To develop Android apps:

   {:type="a"}
   1. Install the following prerequisite packages for Android Studio:

      ```console
      $ sudo apt-get install libc6:amd64 libstdc++6:amd64 lib32z1 libbz2-1.0:amd64
      ```

   1. Install [Android Studio][] to
      debug and compile Java or Kotlin code for Android.
      Flutter requires the full version of Android Studio.

{% when 'Web' -%}

1. Install [Google Chrome][] to debug JavaScript code for web apps.

{% endcase -%}

The developers of the preceding software provide support for those products.
To troubleshoot installation issues, consult that product's documentation.

[Linux]: https://support.google.com/chromebook/answer/9145439
[curl]: https://curl.se/
[git]: https://git-scm.com/
[unzip]: https://linux.die.net/man/1/unzip
[xz]: https://xz.tukaani.org/xz-utils/
[zip]: https://linux.die.net/man/1/zip
[Android Studio]: https://developer.android.com/studio/install#linux
[Google Chrome]: https://www.google.com/chrome/dr/download/

## Configure a text editor or IDE

You can build apps with Flutter using any text editor or
integrated development environment (IDE) combined with
Flutter's command-line tools.

Using an IDE with a Flutter extension or plugin provides code completion,
syntax highlighting, widget editing assists, debugging, and other features.

Popular options include:

* [Visual Studio Code][vscode] with the [Flutter extension for VS Code][].
* [Android Studio][] with the [Flutter plugin for IntelliJ][].
* [IntelliJ IDEA][] with the [Flutter plugin for IntelliJ][].

:::recommend
The Flutter team recommends installing
[Visual Studio Code][vscode] and the [Flutter extension for VS Code][].
This combination simplifies installing the Flutter SDK.
:::

[Android Studio]: https://developer.android.com/studio/install#linux
[IntelliJ IDEA]: https://www.jetbrains.com/help/idea/installation-guide.html
[vscode]: https://code.visualstudio.com/docs/setup/linux
[Flutter extension for VS Code]: https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter
[Flutter plugin for IntelliJ]: https://plugins.jetbrains.com/plugin/9212-flutter
