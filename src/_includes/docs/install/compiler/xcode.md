## Configure iOS development

{% assign prompt1='$' %}
{% assign os = include.os %}
{% assign target = include.target %}

### Configure Xcode

To develop Flutter apps for {{os}}, install Xcode to compile to native bytecode.

1. To configure the command-line tools to use the installed version of Xcode,
   run the following commands.

    ```terminal
    {{prompt1}} sudo sh -c 'xcode-select -s /Applications/Xcode.app/Contents/Developer && xcodebuild -runFirstLaunch'
    ```

   To use the latest version of Xcode, use this path.
   If you need to use a different version, specify that path instead.

{% if target=="mobile-ios" %}

1. To install the iOS Simulator, run the following command.

    ```terminal
    {{prompt1}} xcodebuild -downloadPlatform iOS
    ```

{% endif %}

1. Sign the Xcode license agreement.

    ```terminal
    {{prompt1}} sudo xcodebuild -license
    ```

Try to keep to the current version of Xcode.

{% if target=="mobile-ios" %}

### Configure your target iOS device

With Xcode, you can run Flutter apps on an iOS device or on the simulator.

{% comment %} Nav tabs {% endcomment -%}
<ul class="nav nav-tabs" id="ios-devices-vp" role="tablist">
    <li class="nav-item">
        <a class="nav-link active" id="virtual-tab" href="#virtual" role="tab" aria-controls="virtual" aria-selected="true">Virtual Device</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" id="physical-tab" href="#physical" role="tab" aria-controls="physical" aria-selected="false">Physical Device</a>
    </li>
</ul>

{% comment %} Tab panes {% endcomment -%}
<div class="tab-content">

<div class="tab-pane active" id="virtual" role="tabpanel" aria-labelledby="virtual-tab" markdown="1">

{% include docs/install/devices/ios-simulator.md os=include.os %}

</div>

<div class="tab-pane" id="physical" role="tabpanel" aria-labelledby="physical-tab" markdown="1">

{% include docs/install/devices/ios-physical.md os=include.os %}

</div>
</div>
{% comment %} End: Tab panes. {% endcomment -%}

{% endif %}

### Install CocoaPods

If your apps depend on [Flutter plugins][] with native {{os}} code,
install [CocoaPods][cocoapods].
This program bundles various dependencies across Flutter and {{os}} code.

To install and set up CocoaPods, run the following commands:

1. Install `cocoapods` following the
   [CocoaPods install guide][cocoapods].

   ```terminal
   $ sudo gem install cocoapods
   ```
1. Launch your preferred text editor.

1. Open the Zsh environmental variable file `~/.zshenv` in your text editor.

1. Copy the following line and paste it at the end of your `~/.zshenv` file.

   ```conf
   export PATH=$HOME/.gem/bin:$PATH
   ```

1. Save your `~/.zshenv` file.

1. To apply this change, restart all open terminal sessions.

[Flutter plugins]: {{site.url}}/packages-and-plugins/developing-packages#types
[cocoapods]: https://guides.cocoapods.org/using/getting-started.html#installation
