
## Configure iOS development

{% assign prompt1='$' %}

### Install and configure Xcode

{% if include.attempt=="first" %}

To develop Flutter apps for {{include.target}}, install Xcode to compile to native bytecode.

1. Open the **App Store** and sign in.

1. Search for `Xcode`.

1. Click **Install**.

   The Xcode installer takes up 6+ GB of storage.
   The download make take some time.

1. To configure the command-line tools to use the installed version of Xcode,
   use the following commands.

    ```console
    {{prompt1}} sudo sh -c 'xcode-select -s /Applications/Xcode.app/Contents/Developer && xcodebuild -runFirstLaunch'
    ```

   Use this path for the latest version of Xcode.
   If you need to use a different version, specify that path instead.

1. Sign the Xcode license agreement.

    ```console
    {{prompt1}} sudo xcodebuild -license
    ```

{% else %}

This section presumes you have installed and configured Xcode when you
installed Flutter for

{%- case include.target %}
{%- when 'iOS' %}
[macOS desktop][macos-install]
{%- when 'desktop' %}
[iOS][ios-install]
{%- endcase %}
 development.

[macos-install]: /get-started/install/macos/desktop/#configure-ios-development
[ios-install]: /get-started/install/macos/mobile-ios/#configure-ios-development

{% endif %}

Try to keep to the current version of Xcode.

{% if include.target=='iOS' %}

### Configure your target iOS device

With Xcode, you can run Flutter apps on an iOS device or on the simulator.

{% tabs "ios-simulator-or-not" %}
{% tab "Virtual device" %}

{% include docs/install/devices/ios-simulator.md %}

{% endtab %}
{% tab "Physical device" %}

{% include docs/install/devices/ios-physical.md %}

{% endtab %}
{% endtabs %}

{% endif %}

{% if include.attempt=="first" %}

### Install CocoaPods

If your apps depend on [Flutter plugins][] with native {{include.target}} code,
install [CocoaPods][cocoapods].
This program bundles various dependencies across
Flutter and {{include.target}} code.

To install and set up CocoaPods, run the following commands:

1. Install `cocoapods` following the
   [CocoaPods install guide][cocoapods].

   ```console
   $ sudo gem install cocoapods
   ```
1. Launch your preferred text editor.

1. Open the Zsh environmental variable file `~/.zshenv` in your text editor.

1. Copy the following line and paste it at the end of your `~/.zshenv` file.

   ```bash
   export PATH=$HOME/.gem/bin:$PATH
   ```

1. Save your `~/.zshenv` file.

1. To apply this change, restart all open terminal sessions.

[Flutter plugins]: /packages-and-plugins/developing-packages#types

{% endif %}

[cocoapods]: https://guides.cocoapods.org/using/getting-started.html#installation
