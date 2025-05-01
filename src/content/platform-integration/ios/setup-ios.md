---
title: Set up iOS development
description: >-
  Configure your development environment to
  run, build, and deploy Flutter apps for iOS devices.
short-title: Set up iOS
---

## Install Flutter

To set up your development environment for iOS,
you first need to install Flutter on your
development machine.

If you have already installed Flutter,
ensure that it's [up to date][].

:::note Did you know?
When you install or update the Flutter framework,
it also installs and updates the Dart language for you.
:::

If Flutter is installed and up to date,
continue to the next step.

[up to date]: /install/upgrade

## Install Xcode

With Xcode, you can run Flutter apps on
an iOS physical device or on the iOS Simulator.

If you haven't done so already,
install and set up [Xcode][].
If you have installed Xcode, ensure that
it's up to date and continue to the next step.
(After setting up the command-line tools
and accepting the license, as shown here.)

[Xcode]: https://developer.apple.com/xcode/

To configure Xcode's command-line tools,
use the following command:

```console
$ sudo sh -c 'xcode-select -s /Applications/Xcode.app/Contents/Developer && xcodebuild -runFirstLaunch'
```

Sign the Xcode license agreement:

```console
$ sudo xcodebuild -license
```

## Configure your target iOS device

Note that the behavior of the iOS Simulator can vary
from an actual physical device. It's easier to get
the Simulator up and running than a physical device,
which requires more setup.
For that reason, we recommend starting with the Simulator.

{% tabs "ios-simulator-or-physical-device" %}
{% tab "Simulator" %}

### Configure your iOS Simulator

Use the following steps:

1. To install the iOS Simulator, run the following command.

    ```console
    $ xcodebuild -downloadPlatform iOS
    ```

1. Start the Simulator with the following command:

    ```console
    $ open -a Simulator
    ```

1. Set your Simulator to use a 64-bit device.

   * From **Xcode**, choose a simulator device type.

     1. Go to **Window** <span aria-label="and then">></span>
        **Devices and Simulators** or press
        <kbd>Cmd</kbd> + <kbd>Shift</kbd> + <kbd>2</kbd>.

     2. Once the **Devices and Simulators** dialog opens,
        click **Simulators**.

     3. Choose a **Simulator** from the left-hand list or
        press **+** to create a new simulator.

   * From the **Simulator** app, go to
     **File** <span aria-label="and then">></span>
     **Open Simulator** <span aria-label="and then">></span>
     Choose your target iOS device.

   * To check the device version in the Simulator,
     open the **Settings** app <span aria-label="and then">></span>
     **General** <span aria-label="and then">></span>
     **About**.

1. (_Only if needed_) If you selected a simulated
   high-screen density iOS device,
   it might overflow your screen. If that occurs,
   change the presented size in the **Simulator** app.

    | **Display Size**  |                          **Menu command**                          |     **Keyboard shortcut**     |
    |:-----------------:|:------------------------------------------------------------------:|:-----------------------------:|
    | Small             | **Window** <span aria-label="and then">></span> **Physical Size**  | <kbd>Cmd</kbd> + <kbd>1</kbd> |
    | Moderate          | **Window** <span aria-label="and then">></span> **Point Accurate** | <kbd>Cmd</kbd> + <kbd>2</kbd> |
    | HD accurate       | **Window** <span aria-label="and then">></span> **Pixel Accurate** | <kbd>Cmd</kbd> + <kbd>3</kbd> |
    | Fit to screen     | **Window** <span aria-label="and then">></span> **Fit Screen**     | <kbd>Cmd</kbd> + <kbd>4</kbd> |
    
    {:.table .table-striped}

{% endtab %}
{% tab "Physical device" %}

Set up each iOS device on which you want to test.

### Configure your physical iOS device {:#attach}

1. Attach your iOS device to the USB port on your Mac.

1. On first connecting an iOS device to your Mac,
   your device will display the **Trust this computer?** dialog.

1. Click **Trust**.

   ![Trust Mac][]

### Enable Developer Mode

Apple requires enabling **[Developer Mode][]**
on the device to protect against malicious software.

1. Tap on **Settings** <span aria-label="and then">></span>
   **Privacy & Security** <span aria-label="and then">></span>
   **Developer Mode**.

1. Tap to toggle **Developer Mode** to **On**.

1. Restart the device.

1. When the **Turn on Developer Mode?** dialog appears,
   tap **Turn On**.

   The dialog explains that Developer Mode requires reducing
   the security of the iOS device.

### Create a developer code signing certificate

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
Play store, you will need to upgrade your
personal Apple Developer account to
a professional account.
:::

### Prepare the device

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

## Install CocoaPods

If your app depends on any [Flutter plugin][]
that uses native iOS code,
install [CocoaPods][cocoapods].
CocoaPods bundles various dependencies that
support connecting Flutter to native iOS code.

1. Install `cocoapods` following the
   [CocoaPods install guide][cocoapods].

   ```console
   $ sudo gem install cocoapods
   ```

1. Launch your preferred text editor to update its path variable.

1. For example, if you use Zsh, open `~/.zshenv` in your text editor.

1. Copy the following line and paste it at the end of your `~/.zshenv` file.

   ```bash
   export PATH=$HOME/.gem/bin:$PATH
   ```

1. Save your `~/.zshenv` file.

1. To apply this change, restart all open terminal sessions.

[cocoapods]: https://guides.cocoapods.org/using/getting-started.html#installation
[Flutter plugin]: /packages-and-plugins/developing-packages#types

## Check your development setup with Flutter doctor

The `flutter doctor` command validates all required components of a
complete Flutter development environment.

From the command-line, run the following command:

   ```console
   $ flutter doctor
   ```

Since these instructions did not install for Android
or desktop development, you can ignore Flutter doctor's
error reports for those components for now.

If the `flutter doctor` command returns other errors,
run it again with the verbose flag.

```console
$ flutter doctor -v
```

Follow the instructions in the output for software
you might need to install or further tasks to perform.

**Congratulations.**
You can now start developing Flutter apps for iOS!
