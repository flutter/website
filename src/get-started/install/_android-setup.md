# Android Setup

{{site.alert.note}}
Flutter relies on a full installation of Android Studio to supply its Android platform dependencies. However, you can write your Flutter apps in a number of editors; we will discuss that later on.
{{site.alert.end}}

## Install Android Studio

{% include_relative _help-link.md location='android-studio' section='#android-setup' %}

There are two primary ways to install Android Studio: 

1. **Download and install Android Studio from the official website.**

   Visit the [official Android Studio download page](\{{site.android-dev}}/studio) and follow the instructions to download and install Android Studio.

2. **Install using Snap (For Linux-based operating systems)**

   ```terminal
   $ sudo snap install android-studio --classic
   ```

After installation, start Android Studio and go through the 'Android Studio Setup Wizard'. This initial setup will not automatically install all necessary Android SDKs and tools.

Following the setup, you'll need to manually install the latest Android SDK, Android SDK Command-line Tools, and Android SDK Build-Tools, all of which are necessary for Flutter when developing for Android. You can find these tools in the "SDK Manager" in Android Studio.

## Set up your Android device

{% include_relative _help-link.md location='android-device' section='#android-setup' %}

To prepare to run and test your Flutter app on an Android device, you need an Android device running Android 4.1 (API level 16) or higher.

1. Enable **Developer options** and **USB debugging** on your device. Detailed instructions are available in the [Android documentation](\{{site.android-dev}}/studio/debug/dev-options).
2. [Optional] To leverage wireless debugging, enable **Wireless debugging** on your device. Detailed instructions are available in the [Android documentation](\{{site.android-dev}}/studio/run/device#wireless).
3. Windows-only: Install the [Google USB Driver](\{{site.android-dev}}/studio/run/win-usb).
4. Using a USB cable, plug your phone into your computer. If prompted on your device, authorize your computer to access your device.
5. In the terminal, run the `flutter devices` command to verify that Flutter recognizes your connected Android device. 

By default, Flutter uses the version of the Android SDK where your `adb` tool is based. If you want Flutter to use a different installation of the Android SDK, you must set the `ANDROID_SDK_ROOT` environment variable to that installation directory.

## Set up the Android emulator

{% include_relative _help-link.md location='android-emulator' section='#android-setup' %}

To prepare to run and test your Flutter app on the Android emulator, follow these steps:

1. Enable [VM acceleration](\{{site.android-dev}}/studio/run/emulator-acceleration#accel-vm) on your machine.
2. Launch **Android Studio**, click the **Device Manager** icon, and select **Create Device** under **Virtual** tab...
   * In older versions of Android Studio, you should instead launch **Android Studio > Tools > Android > AVD Manager** and select **Create Virtual Device...**. (The **Android** submenu is only present when inside an Android project.)
   * If you do not have a project open, you can choose **3-Dot Menu / More Actions > Virtual Device Manager** and select **Create Device...**
3. Choose a device definition and select **Next**.
4. Select one or more system images for the Android versions you want to emulate, and select **Next**. An _x86_ or _x86\_64_ image is recommended.
5. Under Emulated Performance, select **Hardware - GLES 2.0** to enable [hardware acceleration](\{{site.android-dev}}/studio/run/emulator-acceleration).
6. Verify the AVD configuration is correct, and select **Finish**. For details on the above steps, see [Managing AVDs](\{{site.android-dev}}/studio/run/managing-avds).
7. In Android Virtual Device Manager, click **Run** in the toolbar. The emulator starts up and displays the default canvas for your selected OS version and device.

## Agree to Android Licenses

{% include_relative _help-link.md location='android-licenses' section='#android-setup' %}

Before you can use Flutter, you must agree to the licenses of the Android SDK platform. This step should be done after you have installed the tools listed above.

1. Open an elevated console window and run the following command to begin signing licenses.
    ```terminal
    $ flutter doctor --android-licenses
    ```
2. Review the terms of each license carefully before agreeing to them.
3. Once you are done agreeing with licenses, run `flutter doctor` again to confirm that you are ready to use Flutter.

## Install Google Chrome

There are two primary ways to install Google Chrome:

1. **Download and install Google Chrome from the official website.**

   Visit the [official Google Chrome download page](https://www.google.com/chrome/) and follow the instructions to download the .deb package. To install the package, open your file explorer, navigate to the downloaded .deb file, right click on it, and select 'Open With Software Install'. Follow the prompts to complete the installation.

2. **Install using command line (For Linux-based operating systems)**

   Open a terminal and execute the following commands:

   ```terminal
   $ wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
   $ sudo dpkg -i google-chrome-stable_current_amd64.deb
   ```
   If you encounter any dependency issues, you can resolve them by running:

   ```terminal
   $ sudo apt-get install -f
   ```

   This will install any missing dependencies on your system.
