{% case include.target %}
{% when 'mobile-ios' %}
{% assign v-target = "iOS" %}
{% when 'mobile-android' %}
{% assign v-target = "Android" %}
{% else %}
{% assign v-target = include.target %}
{% endcase %}

## Software requirements

To write and compile Flutter code for {{v-target}},
install the following packages.

### Operating system

Flutter supports developing on macOS {{site.devmin.macos}} or later.
This guide presumes your Mac runs the `zsh` as your [default shell][zsh-mac].

Some Flutter components require the
[Rosetta 2 translation process][need-rosetta].
If you're developing on an [Apple Silicon][] (ARM) Mac,
install [Rosetta 2][rosetta]:

```console
$ sudo softwareupdate --install-rosetta --agree-to-license
```

[zsh-mac]: https://support.apple.com/en-us/102360
[Apple Silicon]: https://support.apple.com/en-us/HT211814
[rosetta]: https://support.apple.com/en-us/HT211861
[need-rosetta]: {{site.repo.this}}/pull/7119#issuecomment-1124537969

### Development tools

Download and install the following packages.

{% assign xcode = '[Xcode][] ' | append: site.appnow.xcode | append: ' to debug and compile native Swift or ObjectiveC code.' %}
{% assign cocoapods = '[CocoaPods][] ' | append: site.appnow.cocoapods | append: ' to compile and enable Flutter plugins in your native apps.' %}
{% capture android -%}
[Android Studio][] {{site.appmin.android_studio}} or later to
debug and compile Java or Kotlin code for Android.
Flutter requires the full version of Android Studio.
{% endcapture %}
{% assign chrome = "[Google Chrome][] to debug JavaScript code for web apps." %}
{% assign git-main = '[Git][] ' | append: site.appmin.git_mac | append: ' or later to manage source code.' %}
{% assign git-xcode = "The Xcode installation includes " %}
{% capture git-other -%}
To check if you have `git` installed,
type `git version` in your Terminal.
If you need to install `git`, type `brew install git`.
{% endcapture %}

{% case include.target %}
{% when 'desktop','iOS' %}

* {{xcode}} {{git-xcode}} {{git-main}}
* {{cocoapods}}

{% when 'Android' %}

* {{android}}
* {{git-main}}
  {{- git-other}}

{% when 'Web' -%}

* {{chrome}}
* {{git-main}}
  {{- git-other}}

{% endcase %}

The developers of the preceding software provide support for those products.
To troubleshoot installation issues, consult that product's documentation.

[Git]: https://formulae.brew.sh/formula/git
[Android Studio]: https://developer.android.com/studio/install#mac
[Xcode]: {{site.apple-dev}}/xcode/
[CocoaPods]: https://cocoapods.org/
[Google Chrome]: https://www.google.com/chrome/dr/download/

### Text editor or integrated development environment

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
