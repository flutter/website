---
title: Set up iOS development
description: >-
  Configure your development environment to
  run, build, and deploy Flutter apps for iOS devices.
---

Learn how to set up your development environment
to run, build, and deploy Flutter apps for iOS devices.

:::note
If you haven't set up Flutter already,
visit and follow [Install Flutter][] first.

If you've already installed Flutter,
ensure that it's [up to date][].
:::

[Install Flutter]: /install
[up to date]: /install/upgrade

## Set up iOS tooling {: #set-up-tooling}

With Xcode, you can run Flutter apps on
an iOS physical device or on the iOS Simulator.

 1. <h3>Install Xcode</h3>

    If you haven't done so already,
    [install and set up the latest version of Xcode][xcode].

    If you've already installed Xcode,
    update it to the latest version using the
    same installation method you used originally.

 1. <h3>Set up Xcode command-line tools</h3>

    To configure the Xcode command-line tools to use
    the version of Xcode you installed,
    run the following command in your preferred terminal:

    ```console
    $ sudo sh -c 'xcode-select -s /Applications/Xcode.app/Contents/Developer && xcodebuild -runFirstLaunch'
    ```

    If you downloaded Xcode elsewhere or need to use a different version,
    replace `/Applications/Xcode.app` with the path to your Xcode installation.

 1. <h3>Agree to the Xcode licenses</h3>

    After you've set up Xcode and configured its command-line tools,
    agree to the Xcode licenses.

    1. Open your preferred terminal.

    1. Run the following command to review and sign the Xcode licenses:

       ```console
       $ sudo xcodebuild -license
       ```

    1. Read and agree to all necessary licenses.

       Before agreeing to the terms of each license,
       read each with care.

 1. <h3>Download prerequisite tooling</h3>

    To download iOS platform support and
    the latest iOS Simulator runtimes,
    run the following command in your preferred terminal:

    ```console
    $ xcodebuild -downloadPlatform iOS
    ```

 1. <h3>Install CocoaPods (maybe)</h3>

    **As of Flutter 3.44, Swift Package Manager is the default
    package manager for iOS and macOS.
    If your project or its dependencies don't use CocoaPods,
    you don't need to install it.**

    To support [Flutter plugins][] that use native iOS or macOS code,
    install the latest version of [CocoaPods][].

    Install CocoaPods by following the
    [CocoaPods installation guide][].

    If you've already installed CocoaPods,
    update it by following the [CocoaPods update guide][].

{: .steps}

[xcode]: {{site.apple-dev}}/xcode/
[cocoapods]: https://guides.cocoapods.org/using/getting-started.html#installation
[Flutter plugins]: /packages-and-plugins/developing-packages#types
[CocoaPods installation guide]: https://guides.cocoapods.org/using/getting-started.html#installation
[CocoaPods update guide]: https://guides.cocoapods.org/using/getting-started.html#updating-cocoapods

## Set up an iOS device {: #set-up-devices}

Start with the iOS Simulator because
it is easier to set up than a physical iOS device.
However, also test your app on an actual
physical device.

<Tabs key="ios-simulator-or-physical-device">
<Tab name="Simulator">

To run your Flutter app on the iOS Simulator, follow these steps:

 1. <h3>Start the iOS Simulator</h3>

    To start the Simulator,
    run the following command in your preferred terminal:

    ```console
    $ open -a Simulator
    ```

    If you need to install a simulator for a different iOS version,
    check out [Downloading and installing additional Xcode components][]
    on the Apple Developer site.

 1. <h3>Verify simulator settings</h3>

    You can check and change the device type in the Simulator menu under
    **File** <span aria-label="and then">></span> **Open Simulator**.

 1. <h3>Run your app on the Simulator</h3>

    To start your Flutter app on the running simulator,
    navigate to your Flutter project directory and run:

    ```console
    $ flutter run
    ```

    Alternatively, select your iOS Simulator from the device selector in
    [VS Code][] or [Android Studio][],
    and launch your app with debugging enabled.

{: .steps}

[Downloading and installing additional Xcode components]: {{site.apple-dev}}/documentation/xcode/downloading-and-installing-additional-xcode-components
[VS Code]: /tools/vs-code#running-and-debugging
[Android Studio]: /tools/android-studio#running-and-debugging

</Tab>
<Tab name="Physical device">

[Flutter on latest iOS]: /platform-integration/ios/ios-latest

Set up each iOS device on which you want to test.

 1. <h3>Configure your physical iOS device</h3>

    1. Attach your iOS device to the USB port on your Mac.

    1. On first connecting an iOS device to your Mac,
       your device displays the **Trust this computer?** dialog.

    1. Tap **Trust** and enter the device passcode if prompted.

       ![Trust Mac](/assets/images/docs/setup/trust-computer.png)

 1. <h3>Enable Developer Mode</h3>

    Apple requires enabling **[Developer Mode][]**
    on iOS 16 or later to protect against malicious software.

    :::note
    If the **Developer Mode** option is not visible
    under **Settings > Privacy & Security**, connect the device
    to your Mac, unlock it, and trust the computer.
    Open Xcode (or run `flutter run`) to initiate device configuration,
    which makes the option appear.
    :::

    1. Open **Settings** on your iOS device.

    1. Tap **Privacy & Security** <span aria-label="and then">></span>
       **Developer Mode**.

    1. Tap to toggle **Developer Mode** to **On**.

    1. Tap **Restart**.

    1. When the **Turn on Developer Mode?** dialog appears,
       tap **Turn On** and enter your passcode.

 1. <h3>Configure code signing in Xcode</h3>

    To deploy and test an app on a physical iOS device,
    establish trust between your Mac and the device by
    signing your app with an Apple development certificate.

    You can use a free personal Apple ID or an Apple Developer account.

    1. Open Xcode.

    1. Sign in to Xcode with your Apple Account:

       1. Open Xcode settings (**Xcode** <span aria-label="and then">></span>
          **Settings...** or press <kbd>Cmd</kbd> + <kbd>,</kbd>).

       1. Select the **Accounts** tab.

       1. Click the **+** button, select **Apple ID**, and click **Continue**.

       1. Enter your Apple ID and password to sign in.

       1. Close the settings dialog.

       {: type="a"}

    1. Open the default Xcode workspace for your Flutter app:

       ```console
       $ open ios/Runner.xcworkspace
       ```

    1. In the left project navigator, select the top-level **Runner** project.

    1. In the **Runner** target settings pane,
       select the **Signing & Capabilities** tab.

    1. Check **Automatically manage signing**.

    1. Select your development team from the **Team** dropdown menu
       (such as **Your Name (Personal Team)**).

       Xcode creates and downloads your development certificate
       and provisioning profile.

       ![Xcode account settings](/assets/images/docs/setup/xcode-account.png)

    1. If automatic signing fails, verify that your project has a unique
       **Bundle Identifier** in the **General** tab
       (for example, `com.example.yourname.appname`).

       ![Check the app's Bundle ID](/assets/images/docs/setup/xcode-unique-bundle-id.png)

    :::note Apple Developer program
    When you want to deploy your app to the App Store,
    you must upgrade your personal Apple Developer account to
    a paid [Apple Developer Program][] account.
    :::

 1. <h3>Run your app on your device</h3>

    1. Unlock your connected iOS device.

    1. In your preferred terminal,
       navigate to your Flutter project directory and run:

       ```console
       $ flutter run
       ```

       If multiple devices are connected, select your iOS device from the prompt
       or pass its ID with `flutter run -d <device-id>`.

       You can also select your device in [VS Code][] or [Android Studio][],
       or open the project in Xcode and click the **Run** button
       (<kbd>Cmd</kbd> + <kbd>R</kbd>).

 1. <h3>Trust the developer certificate on the device</h3>

    The first time you deploy to a physical device,
    trust the developer certificate on iOS:

    1. On your iOS device, open **Settings**.

    1. Tap **General** <span aria-label="and then">></span>
       **VPN & Device Management**.

    1. Under the **Developer App** section, tap your certificate name.

    1. Tap **Trust \<apple ID or certificate name\>**.

    1. When the confirmation dialog displays, tap **Trust**.

    1. If the Mac displays a **codesign wants to access key...** dialog,
       enter your macOS password and click **Always Allow**.

    1. Open your Flutter app on your device or re-run `flutter run`.

 1. <h3>(Optional) Set up wireless debugging</h3>

    To deploy and debug your app over Wi-Fi without a USB cable:

    1. Connect your iOS device to the same Wi-Fi network as your Mac.

    1. Set a passcode on your iOS device if you have not done so already.

    1. In Xcode, select **Window** <span aria-label="and then">></span>
       **Devices and Simulators**
       (or press <kbd>Shift</kbd> + <kbd>Cmd</kbd> + <kbd>2</kbd>).

    1. Select your iOS device in the left sidebar.

    1. Check **Connect via Network**.

    1. Once the network icon appears next to the device name,
       unplug your iOS device from your Mac.

{: .steps}

[Developer Mode]: {{site.apple-dev}}/documentation/xcode/enabling-developer-mode-on-a-device
[Apple Developer Program]: {{site.apple-dev}}/programs/

</Tab>
</Tabs>

## Validate your setup {: #validate-setup}

 1. <h3>Check for toolchain issues</h3>

    To check for any issues with your iOS development setup,
    run the `flutter doctor` command in your preferred terminal:

    ```console
    $ flutter doctor -v
    ```

    If you see any errors or tasks to complete
    under the **Xcode** or **CocoaPods** (if relevant) sections,
    complete and resolve them, then
    run `flutter doctor -v` again to verify your changes.

 1. <h3>Check for iOS devices</h3>

    To ensure Flutter can discover your iOS Simulator or connected iOS device,
    run `flutter devices` in your preferred terminal:

    ```console
    $ flutter devices
    ```

    You can also list available simulators with `flutter emulators`:

    ```console
    $ flutter emulators
    ```

    If you set up everything correctly,
    at least one entry should appear with the platform marked as **ios**.

 1. <h3>Troubleshoot setup issues</h3>

    If you need help resolving any setup issues,
    check out [Install and setup troubleshooting][troubleshoot].
    You can also review [iOS debugging][] in Flutter.

    If you still have issues or questions,
    reach out on one of the Flutter [community][] channels.

{: .steps}

[troubleshoot]: /install/troubleshoot
[iOS debugging]: /platform-integration/ios/ios-debugging
[community]: {{site.main-url}}/community

## Start developing for iOS {: #start-developing}

Congratulations!
Now that you've set up iOS development for Flutter,
you can continue your Flutter learning journey while testing on iOS
or begin improving integration with iOS.

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
          <a class="text-button" href="/learn/pathway">Learn the fundamentals</a>
        </li>
        <li>
          <a class="text-button" href="https://www.youtube.com/watch?v=b_sQ9bMltGU&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG">Explore Flutter widgets</a>
        </li>
        <li>
          <a class="text-button" href="/reference/learning-resources">Check out samples</a>
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
          <a class="text-button" href="/platform-integration/bind-native-code">Bind to native iOS code</a>
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
