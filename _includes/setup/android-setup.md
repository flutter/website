## Android setup

<aside class="alert alert-success" markdown="1">
<i class="fa fa-lightbulb-o"> </i> **Note:**
Flutter relies on a full installation of Android Studio to supply
its Android platform dependencies. However, you can write your
Flutter apps in a number of editors; a later step will discuss that.
</aside>


### Install Android Studio

1. Download and install [Android Studio](https://developer.android.com/studio/index.html).

1. Start Android Studio, and go through the 'Android Studio Setup Wizard'. This
will install the latest Android SDK, Android SDK Platform-Tools, and Android SDK
Build-Tools, which are required by Flutter when developing for Android.

### Set up your Android device

To prepare to run and test your Flutter app on an Android device, you'll need an
Android device running Android 4.1 (API level 16) or higher.

1. Enable **Developer options** and **USB debugging** on your device. Detailed instructions
are available in the [Android documentation](https://developer.android.com/studio/debug/dev-options.html).
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
