## Configure iOS development

{% assign prompt1='$' %}

### Configure Xcode

To develop Flutter apps for iOS, install Xcode to compile to native bytecode.

1. To configure the Xcode command-line tools to use the installed version,
   run the following commands.

    ```terminal
    {{prompt1}} sudo sh -c 'xcode-select -s /Applications/Xcode.app/Contents/Developer && xcodebuild -runFirstLaunch'
    ```

   To use the latest version of Xcode, use this path.
   If you need to use a different version, specify that path instead.

1. To install the iOS Simulator, run the following command.

    ```terminal
    {{prompt1}} xcodebuild -downloadPlatform iOS
    ```

1. Sign the Xcode license agreement.

    ```terminal
    {{prompt1}} sudo xcodebuild -license
    ```

Try to keep to the current version of Xcode.

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

### Install CocoaPods

If your apps depend on [Flutter plugins][] with native iOS code,
install CocoaPods. CocoaPods handles the bundling of various dependencies
across Flutter and iOS code.

To [Install and set up CocoaPods][], run the following commands:

```terminal
{{prompt1}} sudo gem install cocoapods
```

{{site.alert.note}}
  The default version of Ruby requires `$ {{prompt1}} sudo` to install the CocoaPods gem.
  If you are using a Ruby Version manager, you might need to run without `$ {{prompt1}} sudo`.

  Additionally, if you are installing on an [Apple Silicon Mac][],
  run the command:

  ```terminal
  {{prompt1}} sudo gem uninstall ffi && $ {{prompt1}} sudo gem install ffi -- --enable-libffi-alloc
  ```

{{site.alert.end}}

[Flutter plugins]: {{site.url}}/packages-and-plugins/developing-packages#types
[Install and set up CocoaPods]: https://guides.cocoapods.org/using/getting-started.html#installation
[Apple Silicon Mac]: https://support.apple.com/en-us/HT211814
