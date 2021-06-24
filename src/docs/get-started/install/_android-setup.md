## Android setup

{{site.alert.note}}
  Flutter relies on a full installation of Android Studio to supply
  its Android platform dependencies. However, you can write your
  Flutter apps in a number of editors; a later step discusses that.
{{site.alert.end}}

### Install Android Studio

 1. Download and install [Android Studio]({{site.android-dev}}/studio).
 1. Start Android Studio, and go through the 'Android Studio Setup Wizard'.
    This installs the latest Android SDK, Android SDK Command-line Tools,
    and Android SDK Build-Tools, which are required by Flutter
    when developing for Android.
 1. Run `flutter doctor` to confirm that Flutter has located
    your installation of Android Studio. If Flutter cannot locate it,
    run `flutter config --android-studio-dir <directory>` to set the
    directory that Android Studio is installed to.

### Set up your Android device

To prepare to run and test your Flutter app on an Android device,
you need an Android device running Android 4.1 (API level 16) or higher.

 1. Enable **Developer options** and **USB debugging** on your device.
    Detailed instructions are available in the
    [Android documentation]({{site.android-dev}}/studio/debug/dev-options).
 1. Windows-only: Install the [Google USB
    Driver]({{site.android-dev}}/studio/run/win-usb).
 1. Using a USB cable, plug your phone into your computer. If prompted on your
    device, authorize your computer to access your device.
 1. In the terminal, run the `flutter devices` command to verify that
    Flutter recognizes your connected Android device.  By default,
    Flutter uses the version of the Android SDK where your `adb`
    tool is based. If you want Flutter to use a different installation
    of the Android SDK, you must set the `ANDROID_SDK_ROOT` environment
    variable to that installation directory.

### Set up the Android emulator

To prepare to run and test your Flutter app on the Android emulator,
follow these steps:

 1. Enable
    [VM acceleration]({{site.android-dev}}/studio/run/emulator-acceleration)
    on your machine.
 1. Launch **Android Studio**, click the **AVD Manager**
    icon, and select **Create Virtual Device...**
    * In older versions of Android Studio, you should instead
    launch **Android Studio > Tools > Android > AVD Manager** and select
    **Create Virtual Device...**. (The **Android** submenu is only present
    when inside an Android project.)
    * If you do not have a project open, you can choose 
    **Configure > AVD Manager** and select **Create Virtual Device...**
 1. Choose a device definition and select **Next**.
 1. Select one or more system images for the Android versions you want
    to emulate, and select **Next**.
    An _x86_ or _x86\_64_ image is recommended.
 1. Under Emulated Performance, select **Hardware - GLES 2.0** to enable
    [hardware
    acceleration]({{site.android-dev}}/studio/run/emulator-acceleration).
 1. Verify the AVD configuration is correct, and select **Finish**.

    For details on the above steps, see [Managing
    AVDs]({{site.android-dev}}/studio/run/managing-avds).
 1. In Android Virtual Device Manager, click **Run** in the toolbar.
    The emulator starts up and displays the default canvas for your
    selected OS version and device.

### Agree to Android Licenses

Before you can use Flutter, you must agree to the
licenses of the Android SDK platform. This step should be done after
you have installed the tools listed above.

 1. Make sure that you have a version of Java 8 installed and that your 
    `JAVA_HOME` environment variable is set to the JDK's folder.
    
    Android Studio versions 2.2 and higher come with a JDK, so this should
    already be done.
 1. Open an elevated console window and run the following command to begin
    signing licenses.
    ```terminal
    $ flutter doctor --android-licenses
    ```
 1. Review the terms of each license carefully before agreeing to them.
 1. Once you are done agreeing with licenses, run `flutter doctor` again
    to confirm that you are ready to use Flutter.
