---
title: Set up iOS development
short-title: Set up iOS
description: >-
  Configure your development environment to
  run, build, and deploy Flutter apps for iOS devices.
---

Learn how to set up your development environment
to run, build, and deploy Flutter apps for iOS devices.

:::note
If you haven't set up Flutter already,
visit and follow the [Get started with Flutter][] guide first.

If you have already installed Flutter,
ensure that it's [up to date][].
:::

[Get started with Flutter]: /get-started/install
[up to date]: /install/upgrade

## Install Xcode

With Xcode, you can run Flutter apps on
an iOS physical device or on the iOS Simulator.

If you haven't done so already,
install and set up [Xcode][].

[Xcode]: https://developer.apple.com/xcode/

Configure Xcode's command-line tools:

```console
$ sudo sh -c 'xcode-select -s /Applications/Xcode.app/Contents/Developer && xcodebuild -runFirstLaunch'
```

Sign the Xcode license agreement:

```console
$ sudo xcodebuild -license
```

## Install Rosetta

If you are developing on an [Apple Silicon][] (ARM) Mac,
[install Rosetta 2][].

```console
sudo softwareupdate --install-rosetta --agree-to-license
```

[Apple Silicon]: https://support.apple.com/en-us/116943
[install Rosetta 2]: https://support.apple.com/en-us/102527

## Install CocoaPods

To support [Flutter plugins][] that use native iOS code,
install [CocoaPods][cocoapods].
CocoaPods bundles various dependencies that
support connecting Flutter to native iOS code.

Install `cocoapods` following the
[CocoaPods installation guide][cocoapods].

[cocoapods]: https://guides.cocoapods.org/using/getting-started.html#installation
[Flutter plugin]: /packages-and-plugins/developing-packages#types

## Configure your target iOS device

We recommend starting with the iOS Simulator as
it's easier to get setup than a physical iOS device.
However, you should also test your app on an actual
physical device.

{% tabs "ios-simulator-or-physical-device" %}
{% tab "Simulator" %}

### Configure your iOS Simulator {:.no_toc}

Use the following steps:

1. To install the iOS Simulator, run the following command:

    ```console
    $ xcodebuild -downloadPlatform iOS
    ```

1. Start the Simulator with the following command:

    ```console
    $ open -a Simulator
    ```

{% endtab %}
{% tab "Physical device" %}

Set up each iOS device on which you want to test.

### Configure your physical iOS device {:#attach .no_toc}

1. Attach your iOS device to the USB port on your Mac.

1. On first connecting an iOS device to your Mac,
   your device will display the **Trust this computer?** dialog.

1. Click **Trust**.

   ![Trust Mac][]

### Enable Developer Mode {: .no_toc}

Apple requires enabling **[Developer Mode][]**
on the device to protect against malicious software.

1. Tap on **Settings** <span aria-label="and then">></span>
   **Privacy & Security** <span aria-label="and then">></span>
   **Developer Mode**.

1. Tap to toggle **Developer Mode** to **On**.

1. Restart the device.

1. When the **Turn on Developer Mode?** dialog appears,
   tap **Turn On**.

### Create a developer code signing certificate {: .no_toc}

To send your app to a physical iOS device,
_even_ for testing, you must establish trust
between your Mac and the device.
In addition to trusting the device when that
popup appears, you must upload a signed
developer certificate to your device.

To create a signed development certificate,
you need an Apple ID.
If you don't have one, create one.
You must also enroll in the [Apple Developer][] program
and create an [Apple Developer account][]. If you
are just _testing_ your app on an iOS device,
a personal Apple Developer account is free and works.

:::note Apple Developer program
When you want to _deploy_ your app to the
App Store, you will need to upgrade your
personal Apple Developer account to
a professional account.
:::

### Prepare the device {: .no_toc}

Find your **Profiles & Device Management** menu under
**Settings**. (The exact location can vary by device.)
Toggle your certificate to **Enable**.

:::note
If you can't find **VPN & Device Management** menu,
run your app on your iOS device once, then try again.
:::

1. Under the **Developer App** heading,
   you should find your certificate.

1. Tap the certificate.

1. Tap **Trust "&lt;certificate&gt;"**.

1. When the dialog displays, tap **Trust**.

If the **codesign wants to access key...** dialog appears:

1. Enter your macOS password.

1. Tap **Always Allow**.

[Trust Mac]: /assets/images/docs/setup/trust-computer.png
[Developer Mode]: {{site.apple-dev}}/documentation/xcode/enabling-developer-mode-on-a-device
[Apple Developer]: {{site.apple-dev}}/programs/
[Apple Developer account]: {{site.apple-dev}}/account

{% endtab %}
{% endtabs %}

---


Follow the instructions in the output for software
you might need to install or further tasks to perform.

## Start developing for iOS {: #start-developing}

**Congratulations.**
You can now start developing and testing Flutter apps on iOS!

<div class="card-grid link-cards">
  <div class="card filled-card list-card">
    <div class="card-leading">
      <img src="/assets/images/decorative/pointing-the-way.png" height="160" aria-hidden="true" alt="Dash helping you explore Flutter learning resources.">
    </div>
    <div class="card-header">
      <span class="card-title">Continue learning Flutter</span>
    </div>
    <div class="card-content">
      <ul>
        <li>
          <a class="text-button" href="/get-started/codelab">Write your first app</a>
        </li>
        <li>
          <a class="text-button" href="/get-started/fundamentals">Learn the fundamentals</a>
        </li>
        <li>
          <a class="text-button" href="https://www.youtube.com/watch?v=b_sQ9bMltGU&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG">Explore Flutter widgets</a>
        </li>
        <li>
          <a class="text-button" href="/reference/learning-resources">Check out samples</a>
        </li>
        <li>
          <a class="text-button" href="/resources/bootstrap-into-dart">Learn about Dart</a>
        </li>
      </ul>
    </div>
  </div>
  <div class="card filled-card list-card">
    <div class="card-leading">
      <img src="/assets/images/decorative/flutter-on-phone.svg" height="160" aria-hidden="true" alt="A representation of Flutter on multiple devices.">
    </div>
    <div class="card-header">
      <span class="card-title">Build for iOS</span>
    </div>
    <div class="card-content">
      <ul>
        <li>
          <a class="text-button" href="/deployment/ios">Build and deploy to iOS</a>
        </li>
        <li>
          <a class="text-button" href="/platform-integration/ios/c-interop">Bind to native iOS code</a>
        </li>
        <li>
          <a class="text-button" href="/platform-integration/ios/apple-frameworks">Leverage system frameworks</a>
        </li>
        <li>
          <a class="text-button" href="/platform-integration/ios/platform-views">Embed native iOS views</a>
        </li>
        <li>
          <a class="text-button" href="/packages-and-plugins/swift-package-manager/for-app-developers">Use Swift Package Manager</a>
        </li>
      </ul>
    </div>
  </div>
</div>

