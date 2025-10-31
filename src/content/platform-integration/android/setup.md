---
title: Set up Android development
description: >-
  Configure your development environment to
  run, build, and deploy Flutter apps for Android devices.
---

Learn how to set up your development environment
to run, build, and deploy Flutter apps for Android devices.

:::note
If you haven't set up Flutter already,
visit and follow the [Get started with Flutter][] guide first.

If you've already installed Flutter,
ensure that it's [up to date][].
:::

[Get started with Flutter]: /get-started
[up to date]: /install/upgrade

## Choose your development platform {: #dev-platform}

The instructions on this page are configured to cover
setting up Android development on a **Windows**{:.selected-os-text} device.

If you'd like to follow the instructions for a different OS,
please select one of the following.

<OSSelector />

## Set up Android tooling {: #set-up-tooling}

With Android Studio, you can run Flutter apps on
a physical Android device or an Android Emulator.

If you haven't done so already,
install and set up the latest stable version of [Android Studio][].

 1. <h3>Install prerequisites libraries</h3>

    If you're developing on Linux, first install the
    [prerequisite collection of 32-bit libraries][64bit-libs]
    that Android Studio requires.
    {: .linux-only}

 1. <h3>Install Android Studio</h3>

    If you haven't done so already, [install and set up][as-install]
    the latest stable version of [Android Studio][].

    If you already have Android Studio installed,
    ensure that it's [up to date][as-update].

 1. <h3>Install Android SDK and tools</h3>

    1. Launch **Android Studio**.

    1. Open the **SDK Manager** settings dialog.

       1. If the **Welcome to Android Studio** dialog is open,
          click the **More Actions** button that follows the
          **New Project** and **Open** buttons,
          then click **SDK Manager** from the dropdown menu.

       1. If you have a project open,
          go to **Tools** <span aria-label="and then">></span> **SDK Manager**.

       {: type="a"}

    1. If the **SDK Platforms** tab is not open, switch to it.

    1. Verify that the first entry with an **API Level** of
       **36** has been selected.

       If the **Status** column displays
       **Update available** or **Not installed**:

       1. Select the checkbox for that entry or row.

       1. Click **Apply**.

       1. When the **Confirm Change** dialog displays, click **OK**.

          The **SDK Component Installer** dialog displays with a
          progress indicator.

       1. When the installation finishes, click **Finish**.

       {: type="a"}

    1. Switch to the **SDK Tools** tab.

    1. Verify that the following SDK Tools have been selected:

       - **Android SDK Build-Tools**
       - **Android SDK Command-line Tools**
       - **Android Emulator**
       - **Android SDK Platform-Tools**

    1. If the **Status** column for any of the preceding tools displays
       **Update available** or **Not installed**:

       1. Select the checkbox for the necessary tools.

       1. Click **Apply**.

       1. When the **Confirm Change** dialog displays, click **OK**.

          The **SDK Component Installer** dialog displays with a
          progress indicator.

       1. When the installation finishes, click **Finish**.

       {: type="a"}

   1. <h3>Agree to the Android licenses</h3>

      Before you can use Flutter and after you install all prerequisites,
      agree to the licenses of the Android SDK platform.

      1. Open your preferred terminal.

      1. Run the following command to review and sign the SDK licenses.

         ```console
         $ flutter doctor --android-licenses
         ```

      1. Read and accept any necessary licenses.

         If you haven't accepted each of the SDK licenses previously,
         you'll need to review and agree to them before developing for Android.

         Before agreeing to the terms of each license,
         read each with care.

         Once you've accepted all the necessary licenses successfully,
         you should see output similar to the following:

         ```console
         All SDK package licenses accepted.
         ```

{: .steps}

[Android Studio]: https://developer.android.com/studio
[64bit-libs]: https://developer.android.com/studio/install#64bit-libs
[as-install]: https://developer.android.com/studio/install
[as-update]: https://developer.android.com/studio/intro/update

## Set up an Android device {: #set-up-devices}

You can debug Flutter apps on physical Android devices or
by running them on an Android emulator.

<Tabs key="android-emulator-or-not">
<Tab name="Android emulator">

To set up your development environment to
run a Flutter app on an Android emulator, follow these steps:

 1. <h3>Set up your development device</h3>

    Enable [VM acceleration][] on your development computer.

 1. <h3>Set up a new emulator</h3>

    1. Start **Android Studio**.

    1. Open the **Device Manager** settings dialog.

       1. If the **Welcome to Android Studio** dialog is open,
          click the **More Actions** button that follows the
          **New Project** and **Open** buttons,
          then select **Virtual Device Manager** from the dropdown menu.

       1. If you have a project open,
          go to **Tools** <span aria-label="and then">></span>
          **Device Manager**.

       {: type="a"}

    1. Click the **Create Virtual Device** button that appears as a `+` icon.

       The **Virtual Device Configuration** dialog displays.

    1. Select either **Phone** or **Tablet** under **Form Factor**.

    1. Select a device definition. You can browse or search for the device.

    1. Click **Next**.

    1. If the option is provided,
       select either **x86 Images** or **ARM Images** depending on
       if your development computer is an x64 or Arm64 device.

    1. Select one system image for the Android version you want to emulate.

       1. If the desired image has a **Download** icon to the left
          of the system image name, click it.

          The **SDK Component Installer** dialog displays with a
          progress indicator.

       1. When the download completes, click **Finish**.

       {: type="a"}

    1. Click **Additional settings** in the top tab bar and
       scroll to **Emulated Performance**.

    1. From the **Graphics acceleration** dropdown menu,
       select an option that mentions **Hardware**.

       This enables [hardware acceleration][], improving render performance.

    1. Verify your virtual device configuration.
       If it is correct, click **Finish**.

       To learn more about virtual devices,
       check out [Create and manage virtual devices][].

 1. <h3>Try running the emulator</h3>

    In the **Device Manager** dialog,
    click the **Run** icon to the right of your desired virtual device.

    The emulator should start up and display the default canvas for
    your selected Android OS version and device.

{: .steps}

[VM acceleration]: {{site.android-dev}}/studio/run/emulator-acceleration#accel-vm
[hardware acceleration]: {{site.android-dev}}/studio/run/emulator-acceleration
[Create and manage virtual devices]: {{site.android-dev}}/studio/run/managing-avds

</Tab>
<Tab name="Physical device">

To set up your development environment to
run a Flutter app on a physical Android device, follow these steps:

 1. <h3>Configure your device</h3>

    Enable **Developer options** and **USB debugging** on your device
    as described in [Configure on-device developer options][].

 1. <h3>Enable wireless debugging</h3>

    To leverage wireless debugging,
    enable **Wireless debugging** on your device as described in
    [Connect to your device using Wi-Fi][].
    {: .windows-only}

 1. <h3>Install platform prerequisites</h3>

    If you're developing on Windows, first install the necessary
    USB driver for your particular device as described in
    [Install OEM USB drivers][].

 1. <h3>Connect your device</h3>

    Plug your device into your computer.
    If your device prompts you,
    authorize your computer to access your Android device.

 1. <h3>Verify the device connection</h3>

    To verify that Flutter recognizes your connected Android device,
    run `flutter devices` in your preferred terminal:

    ```console
    $ flutter devices
    ```

    Your device should be found and show up as a connected device.

{: .steps}

[Configure on-device developer options]: {{site.android-dev}}/studio/debug/dev-options
[Connect to your device using Wi-Fi]: {{site.android-dev}}/studio/run/device#wireless
[Install OEM USB drivers]: {{site.android-dev}}/studio/run/oem-usb

</Tab>
</Tabs>

## Validate your setup {: #validate-setup}

 1. <h3>Check for toolchain issues</h3>

    To check for any issues with your Android development setup,
    run the `flutter doctor` command in your preferred terminal:

    ```console
    $ flutter doctor
    ```

    If you see any errors or tasks to complete under
    the **Android toolchain** or **Android Studio** sections,

    Complete any mentioned tasks and then
    run `flutter doctor` again to verify any changes.

 1. <h3>Check for Android devices</h3>

    To ensure you set up your emulator and/or physical Android device correctly,
    run `flutter emulators` and `flutter devices` in your preferred terminal:

    ```console
    $ flutter emulators && flutter devices
    ```

    Depending on if you set up an emulator or a device,
    at least one should output an entry with the platform marked as **android**.

 1. <h3>Troubleshoot setup issues</h3>

    If you need help resolving any setup issues,
    check out [Install and setup troubleshooting][].

    If you still have issues or questions,
    reach out on one of the Flutter [community][] channels.

{: .steps}

[Install and setup troubleshooting]: /install/troubleshoot#android-setup
[community]: {{site.main-url}}/community

## Start developing for Android {: #start-developing}

Congratulations!
Now that you've set up Android development for Flutter,
you can continue your Flutter learning journey while testing on Android
or begin improving integration with Android.

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
      <span class="card-title">Build for Android</span>
    </div>
    <div class="card-content">
      <ul>
        <li>
          <a class="text-button" href="/deployment/android">Build and deploy to Android</a>
        </li>
        <li>
          <a class="text-button" href="/platform-integration/android/c-interop">Bind to native Android code</a>
        </li>
        <li>
          <a class="text-button" href="/platform-integration/android/splash-screen">Add a splash screen</a>
        </li>
        <li>
          <a class="text-button" href="/platform-integration/android/platform-views">Embed native Android views</a>
        </li>
        <li>
          <a class="text-button" href="/platform-integration/android/predictive-back">Support predictive back</a>
        </li>
      </ul>
    </div>
  </div>
</div>
