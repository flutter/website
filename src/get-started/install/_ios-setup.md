## iOS setup

### Install Xcode

To develop Flutter apps for iOS, you need a Mac with Xcode installed.

 1. Install the latest stable version of Xcode
    (using [web download][] or the [Mac App Store][]).

 1. To configure the Xcode command-line tools to use the
    installed version, run the following commands.

    ```terminal
    $ sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
    $ sudo xcodebuild -runFirstLaunch
    ```

    To use the latest version of Xcode, use this path.
    If you need to use a different version, specify that path instead.

 1. Sign the Xcode license agreement.
    To sign the SLA, either open Xcode once and confirm or run:

    ```terminal
    $ sudo xcodebuild --license
    ```

Versions older than the latest stable version might still work,
but are not recommended for Flutter development.

With Xcode, you can run Flutter apps on an iOS device or on the simulator.

### Set up the iOS simulator

To prepare to run and test your Flutter app on the iOS simulator,
follow this procedure.

 1. To start the Simulator, run the following command:

    ```terminal
    $ open -a Simulator
    ```

 2. Set your Simulator to use a 64-bit device (iPhone 5s or later).

    - From Xcode, choose a simulator device type. Go to
      **Product** <span aria-label="and then">></span>
      **Destination** <span aria-label="and then">></span>
      Choose your target device.

    - From the Simulator app, go to
      **File** <span aria-label="and then">></span>
      **Open Simulator** <span aria-label="and then">></span>
      Choose your target iOS device

    - To check the device version in the Simulator,
      open the **Settings** app <span aria-label="and then">></span>
      **General** <span aria-label="and then">></span>
      **About**.

 3. The simulated high-screen density iOS devices might overflow your screen.
    If that appears true on your Mac, change the presented size in the
    Simulator app

    - To display the Simulator at a small size, go to
      **Window** <span aria-label="and then">></span>
      **Physical Size** or<br>press <kbd>Command</kbd> + <kbd>1</kbd>.

    - To display the Simulator at a moderate size, go to
      **Window** <span aria-label="and then">></span>
      **Point Accurate** or<br>press <kbd>Command</kbd> + <kbd>2</kbd>.

    - To display the Simulator at an HD representation, go to
      **Window** <span aria-label="and then">></span>
      **Pixel Accurate** or<br>press <kbd>Command</kbd> + <kbd>3</kbd>.
      _The Simulator defaults to this size._

    - The Simulator defaults to **Fit Screen**.
      If you need to return to that size, go to
      **Window** <span aria-label="and then">></span>
      **Fit Screen** or press <kbd>Command</kbd> + <kbd>4</kbd>.

### Deploy to physical iOS devices

To deploy your Flutter app to a physical iPhone or iPad,
you need to do the following:

- Create an [Apple Developer][] account.
- Set up physical device deployment in Xcode.
- Provision your Flutter app.
- Install the third-party CocoaPods dependency manager
  if your app uses Flutter plugins.

#### Create your Apple ID and Apple Developer account

To test deploy to a physical iOS device, you need an Apple ID.

To distribute your app to the App Store,
you must enroll in the Apple Developer Program.

If you only need to test your app, complete the first step and move on
to the next section.

1. If you don't have an [Apple ID][], create one.

1. If you haven't enrolled in the [Apple Developer][] program, enroll now.

   To learn more about membership types, see [Choosing a Membership][].

[Apple ID]: https://support.apple.com/en-us/HT204316

#### Attach your physical iOS device to your Mac {#attach}

Configure your physical iOS device to connect to Xcode.

1. Attach your iOS device to the USB port on your Mac.

1. On first connecting your iOS device to your Mac,
   your iOS device displays the **Trust this computer?** modal.

1. Click **Trust**.

   ![Trust Mac][]{:.mw-100}

#### Enable developer code signing certificates

To deploy to a physical iOS device, you need to establish trust with your
Mac and the iOS device.
This requires you to load signed developer certificates to your iOS device.
To sign an app in Xcode, you need to create a development provisioning profile.

Follow the Xcode signing flow to provision your project.

1. Open Xcode.

1. Sign in to Xcode with your Apple ID. ![Xcode account add][]{:.mw-100}
   Development and testing supports any Apple ID.

1. Go to **File** <span aria-label="and then">></span> **Open...**

   You can also press <kbd>Command</kbd> + <kbd>O</kbd>.

1. Navigate to your Flutter project directory.

1. Open the default Xcode workspace in your project: `ios/Runner.xcworkspace`.

1. Select the physical iOS device you intend to deploy to in the device
   drop-down menu to the right of the run button.

1. In the left navigation panel under **Targets**, select **Runner**.

1. In the **Runner** settings pane, click **Signing & Capabilities**.

1. Select **All** at the top.

1. Select **Automatically manage signing**.

1. Select a team from the **Team** dropdown menu.

   Teams are created in the **App Store Connect** section of your
   [Apple Developer Account][] page.
   If you have not created a team, you can choose a _personal team_.

   The **Team** dropdown displays that option as **Your Name (Personal Team)**.

   After you select a team, Xcode performs the following tasks:

   {: type="a"}
   1. Creates and downloads a Development Certificate
   1. Registers your device with your account,
   1. Creates and downloads a provisioning profile if needed

If automatic signing fails in Xcode, verify that the project's
**General** <span aria-label="and then">></span>
**Identity** <span aria-label="and then">></span>
**Bundle Identifier** value is unique.

![Check the app's Bundle ID][]{:.mw-100}

#### Enable trust of your Mac and iOS device {#trust}

When you attach your physical iOS device for the first time,
enable trust for both your Mac and the Development Certificate
on the iOS device.

##### Agree to trust your Mac

You should enabled trust of your Mac on your iOS device when
you [attached the device to your Mac](#attach).

##### Enable developer certificate for your iOS devices

Enabling certificates varies in different versions of iOS.

{% comment %} Nav tabs {% endcomment -%}
<ul class="nav nav-tabs" id="ios-versions" role="tablist">
    <li class="nav-item">
        <a class="nav-link" id="ios14-tab" href="#ios14" role="tab" aria-controls="ios14" aria-selected="true">iOS 14</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" id="ios15-tab" href="#ios15" role="tab" aria-controls="ios15" aria-selected="false">iOS 15</a>
    </li>
    <li class="nav-item">
        <a class="nav-link active" id="ios16-tab" href="#ios16" role="tab" aria-controls="ios16" aria-selected="false">iOS 16</a>
    </li>
</ul>

{% comment %} Tab panes {% endcomment -%}
<div class="tab-content">

<div class="tab-pane" id="ios14" role="tabpanel" aria-labelledby="ios14-tab" markdown="1">

1. Open the **Settings** app on the iOS device.

1. Go to **General** <span aria-label="and then">></span>
   **Profiles & Device Management**.

1. Toggle your Certificate to **Enable**

</div>

<div class="tab-pane" id="ios15" role="tabpanel" aria-labelledby="ios15-tab" markdown="1">

1. Open the **Settings** app on the iOS device.

1. Go to **General** <span aria-label="and then">></span>
    **VPN & Device Management**.

1. Toggle your Certificate to **Enable**.

</div>

<div class="tab-pane active" id="ios16" role="tabpanel" aria-labelledby="ios16-tab" markdown="1">

1. Open the **Settings** app on the iOS device.

1. Go to **Privacy & Security** <span aria-label="and then">></span>
    **Developer Mode**.

1. Toggle **Developer Mode** to on.
    iOS displays a prompt to restart your device.

1. Click **Restart**.

1. After your device restarts and you unlock your device,
    iOS asks if you want to **Turn On Developer Mode?**
    Click **Turn On**.

1. Go to **General** <span aria-label="and then">></span>
    **Device Management**.

</div>
</div>{% comment %} End: Tab panes. {% endcomment -%}

#### Optional deployment procedures

You can skip these procedures. They enable additional debugging features.

##### Set up wireless debugging on your iOS device

Follow this procedure to debug your device using a Wi-Fi connection.

To use wireless debugging:

- Connect your iOS device to the same network as your macOS device.
- Set a passcode for your iOS device.

After you connect your iOS device to your Mac:

1. Go to
   **Xcode** <span aria-label="and then">></span>
   **Window** <span aria-label="and then">></span>
   **Devices and Simulators**.
1. Select your iOS device.
1. Check **Connect via Network**.
1. Once the network icon appears next to the device name,
   unplug your iOS device from your Mac.

If you don't see your device listed when using `flutter run`,
extend the timeout. The timeout defaults to 10 seconds.
To extend the timeout, change the value to an integer greater than 10.

```terminal
flutter run --device-timeout 60
```

###### Learn more about wireless debugging

- To learn more, check out
  [Apple's documentation on pairing a wireless device with Xcode][].
- To troubleshoot, check out [Apple's Developer Forums][].
- To learn how to configure wireless debugging with `flutter attach`,
  check out [Debugging your add-to-app module][].


##### Install CocoaPods

Follow this procedure if your apps depend on [Flutter plugins][]
with native iOS code.

To [Install and set up CocoaPods][], run the following commands:

```terminal
$ sudo gem install cocoapods
```

{{site.alert.note}}
  The default version of Ruby requires `sudo` to install the CocoaPods gem.
  If you are using a Ruby Version manager, you might need to run without `sudo`.

  Additionally, if you are installing on an [Apple Silicon Mac][],
  run the command:

  ```terminal
  $ sudo gem uninstall ffi && sudo gem install ffi -- --enable-libffi-alloc
  ```
{{site.alert.end}}

[Check the app's Bundle ID]: {{site.url}}/assets/images/docs/setup/xcode-unique-bundle-id.png
[Choosing a Membership]: {{site.apple-dev}}/support/compare-memberships
[Mac App Store]: https://itunes.apple.com/us/app/xcode/id497799835
[Flutter plugins]: {{site.url}}/packages-and-plugins/developing-packages#types
[Install and set up CocoaPods]: https://guides.cocoapods.org/using/getting-started.html#installation
[Trust Mac]: {{site.url}}/assets/images/docs/setup/trust-computer.png
[web download]: {{site.apple-dev}}/xcode/
[Xcode account add]: {{site.url}}/assets/images/docs/setup/xcode-account.png
[Apple Silicon Mac]: https://support.apple.com/en-us/HT211814
[Developer Mode]: https://developer.apple.com/documentation/xcode/enabling-developer-mode-on-a-device
[Apple's Developer Forums]: {{site.apple-dev}}/forums/
[Debugging your add-to-app module]: {{site.url}}/add-to-app/debugging/#wireless-debugging
[Apple's documentation on pairing a wireless device with Xcode]: https://help.apple.com/xcode/mac/9.0/index.html?localePath=en.lproj#/devbc48d1bad
[Apple Developer]: {{site.apple-dev}}/programs/
[Apple Developer Account]: {{site.apple-dev}}/account