## Android setup

### Install Android Studio

To develop Flutter apps for Android, you can use a Mac, Windows, or Linux
(64-bit) machine.

Flutter requires Android Studio to be installed and configured:

1. Download and install [Android Studio](https://developer.android.com/studio/index.html).

1. Start Android Studio, and go through the 'Android Studio Setup Wizard'. This
will install the latest Android SDK, Android SDK Platform-Tools, and Android SDK
Build-Tools, which are required by Flutter when developing for Android.

### Set up your Android device

To prepare to run and test your Flutter app on an Android device, you'll need an
Android device running Android 4.1 (API level 16) or higher.

1. Enable developer mode on your device by visiting **Settings>System>About phone** and
tapping the **Build number** line seven times.
2. In **Settings>System>Developer options**, enable **USB debugging**.
3. Using a USB cable, plug your phone into your computer. If prompted on your
device, authorize your computer to access your device.
4. In the terminal, run the `flutter devices` command to verify that Flutter recognizes your
connected Android device.
5. Start your app by running `flutter run`.

By default, Flutter uses the version of the Android SDK where your `adb` tool is based. If
you want Flutter to use a different installation of the Android SDK, you must set the
`ANDROID_HOME` environment variable to that installation directory.

### Set up the Android emulator

To prepare to run and test your Flutter app on the Android emulator, follow these steps:

1. Enable [VM acceleration](https://developer.android.com/studio/run/emulator-acceleration.html) on your machine.
1. Launch **Android Studio>Tools>Android>AVD Manager** and select **Create Virtual Device**.
1. Choose a device definition and select **Next**.
1. Select one or more system images for the Android versions you want to emulate, 
   and select **Next**. An _x86_ or _x86\_64_ image is recommended.
1. Under Emulated Performance, select **Hardware - GLES 2.0** to enable 
[hardware acceleration](https://developer.android.com/studio/run/emulator-acceleration.html). 
1. Verify the AVD configuration is correct, and select **Finish**.

   For details on the above steps, see [Managing AVDs](https://developer.android.com/studio/run/managing-avds.html).
1. In Android Virtual Device Manager, click **Run** in the toolbar.
   The emulator starts up and displays the default canvas for your selected OS version
   and device.
1. Start your app by running `flutter run`. The connected device name is
   `Android SDK built for <platform>`, where _platform_ is the chip family, such as x86.
