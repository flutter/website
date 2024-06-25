#### Set up your target physical iOS device

To deploy your Flutter app to a physical iPhone or iPad,
you need to do the following:

- Create an [Apple Developer][] account.
- Set up physical device deployment in Xcode.
- Create a development provisioning profile to self-sign certificates.
- Install the third-party CocoaPods dependency manager
  if your app uses Flutter plugins.

##### Create your Apple ID and Apple Developer account

To test deploying to a physical iOS device, you need an Apple ID.

To distribute your app to the App Store,
you must enroll in the Apple Developer Program.

If you only need to test deploying your app,
complete the first step and move on to the next section.

1. If you don't have an [Apple ID][], create one.

1. If you haven't enrolled in the [Apple Developer][] program, enroll now.

   To learn more about membership types,
   check out [Choosing a Membership][].

[Apple ID]: https://support.apple.com/en-us/HT204316

##### Attach your physical iOS device to your Mac {:#attach}

Configure your physical iOS device to connect to Xcode.

1. Attach your iOS device to the USB port on your Mac.

1. On first connecting your iOS device to your Mac,
   your iOS device displays the **Trust this computer?** dialog.

1. Click **Trust**.

   ![Trust Mac][]{:.mw-100}

1. When prompted, unlock your iOS device.

##### Enable Developer Mode on iOS 16 or later

Starting with iOS 16, Apple requires you to enable **[Developer Mode][]**
to protect against malicious software.
Enable Developer Mode before deploying to a device running iOS 16 or later.

1. Tap on **Settings** <span aria-label="and then">></span>
   **Privacy & Security** <span aria-label="and then">></span>
   **Developer Mode**.

1. Tap to toggle **Developer Mode** to **On**.

1. Tap **Restart**.

1. After the iOS device restarts, unlock your iOS device.

1. When the **Turn on Developer Mode?** dialog appears, tap **Turn On**.

   The dialog explains that Developer Mode requires reducing the security
   of the iOS device.

1. Unlock your iOS device.

##### Enable developer code signing certificates

To deploy to a physical iOS device, you need to establish trust with your
Mac and the iOS device.
This requires you to load signed developer certificates to your iOS device.
To sign an app in Xcode,
you need to create a development provisioning profile.

To provision your project, follow the Xcode signing flow.

1. Launch Xcode.

1. Go to **Xcode** <span aria-label="and then">></span>
   **Settings...**

   1. Go to **Xcode** <span aria-label="and then">></span>
      **Settings...**
   1. Click **Accounts**.
   1. Click **+**.
   1. Select **Apple ID** and click **Continue**.
   1. When prompted, enter your **Apple ID** and **Password**.
   1. Close the **Settings** dialog.

   Development and testing supports any Apple ID.

1. Go to **File** <span aria-label="and then">></span> **Open...**

   You can also press <kbd>Cmd</kbd> + <kbd>O</kbd>.

1. Navigate to your Flutter project directory.

1. Open the default Xcode workspace in your project: `ios/Runner.xcworkspace`.

1. Select the physical iOS device you intend to deploy to in the device
   drop-down menu to the right of the run button.

   It should appear under the **iOS devices** heading.

1. In the left navigation panel under **Targets**, select **Runner**.

1. In the **Runner** settings pane, click **Signing & Capabilities**.

1. Select **All** at the top.

1. Select **Automatically manage signing**.

1. Select a team from the **Team** dropdown menu.

   Teams are created in the **App Store Connect** section of your
   [Apple Developer Account][] page.
   If you have not created a team, you can choose a _personal team_.

   The **Team** dropdown displays that option as **Your Name (Personal Team)**.

   ![Xcode account add][]{:.mw-100}

   After you select a team, Xcode performs the following tasks:

   1. Creates and downloads a Development Certificate
   1. Registers your device with your account,
   1. Creates and downloads a provisioning profile if needed

If automatic signing fails in Xcode, verify that the project's
**General** <span aria-label="and then">></span>
**Identity** <span aria-label="and then">></span>
**Bundle Identifier** value is unique.

![Check the app's Bundle ID][]{:.mw-100}

##### Enable trust of your Mac and iOS device {:#trust}

When you attach your physical iOS device for the first time,
enable trust for both your Mac and the Development Certificate
on the iOS device.

You should have enabled trust of your Mac on your iOS device when
you [attached the device to your Mac](#attach).

##### Enable developer certificate for your iOS devices

Enabling certificates varies in different versions of iOS.

{% tabs "ios-versions" %}
{% tab "iOS 14" %}

1. Open the **Settings** app on the iOS device.

1. Tap on **General** <span aria-label="and then">></span>
   **Profiles & Device Management**.

1. Tap to toggle your Certificate to **Enable**

{% endtab %}
{% tab "iOS 15" %}

1. Open the **Settings** app on the iOS device.

1. Tap on **General** <span aria-label="and then">></span>
    **VPN & Device Management**.

1. Tap to toggle your Certificate to **Enable**.

{% endtab %}
{% tab "iOS 16 or later" %}

1. Open the **Settings** app on the iOS device.

1. Tap on **General** <span aria-label="and then">></span>
    **VPN & Device Management**.

    :::note
    If you can't find **VPN & Device Management**
    in **Settings**, run your app on your iOS device once, then try again.
    :::

1. Under the **Developer App** heading, you should find your certificate.

1. Tap your Certificate.

1. Tap **Trust "\<certificate\>"**.

1. When the dialog displays, tap **Trust**.

{% endtab %}
{% endtabs %}

If the **codesign wants to access key...** dialog displays:

1. Enter your macOS password.

1. Tap **Always Allow**.

#### Set up wireless debugging on your iOS device (Optional)

To debug your device using a Wi-Fi connection, follow this procedure.

1. Connect your iOS device to the same network as your macOS device.

1. Set a passcode for your iOS device.

1. Open **Xcode**.

1. Go to **Window** <span aria-label="and then">></span>
   **Devices and Simulators**.

   You can also press <kbd>Shift</kbd> + <kbd>Cmd</kbd> + <kbd>2</kbd>.

1. Select your iOS device.

1. Select **Connect via Network**.

1. Once the network icon appears next to the device name,
   unplug your iOS device from your Mac.

If you don't see your device listed when using `flutter run`,
extend the timeout. The timeout defaults to 10 seconds.
To extend the timeout, change the value to an integer greater than 10.

```console
$ flutter run --device-timeout 60
```

:::note Learn more about wireless debugging
* To learn more, check out
  [Apple's documentation on pairing a wireless device with Xcode][].
* To troubleshoot, check out [Apple's Developer Forums][].
* To learn how to configure wireless debugging with `flutter attach`,
  check out [Debugging your add-to-app module][].
:::

[Check the app's Bundle ID]: /assets/images/docs/setup/xcode-unique-bundle-id.png
[Choosing a Membership]: {{site.apple-dev}}/support/compare-memberships
[Trust Mac]: /assets/images/docs/setup/trust-computer.png
[Xcode account add]: /assets/images/docs/setup/xcode-account.png
[Developer Mode]: {{site.apple-dev}}/documentation/xcode/enabling-developer-mode-on-a-device
[Apple's Developer Forums]: {{site.apple-dev}}/forums/
[Debugging your add-to-app module]: /add-to-app/debugging/#wireless-debugging
[Apple's documentation on pairing a wireless device with Xcode]: https://help.apple.com/xcode/mac/9.0/index.html?localePath=en.lproj#/devbc48d1bad
[Apple Developer]: {{site.apple-dev}}/programs/
[Apple Developer Account]: {{site.apple-dev}}/account
