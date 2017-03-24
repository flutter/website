## Android setup

_This step is optional, and can be performed at any time before
using Flutter to develop apps for Android._

### Install Android Studio

To develop Flutter apps for Android, you need to install Android Studio. After installation,
you also need to start Android Studio once, to 

1. Install [Android Studio](https://developer.android.com/studio/index.html).

   Flutter requires the latest Android SDK and Android SDK Platform-Tools packages.
   You can verify these are up-to-date in **Android Studio>Configure>SDK Manager**,
   as described in [Update the IDE and SDK Tools](https://developer.android.com/studio/intro/update.html).

1. Start Android Studio.

### Set up the Android emulator

To prepare to run and test your Flutter app on the Android emulator, follow these steps:
1. Enable Kernel-based Virtual Machine (KVM) support on your machine.
1. Define a virtual device in Android Virtual Device Manager.

#### Enable KVM
For the Android emulator, you need to configure x86 and x86_64 emulation, which 
requires the use of hardware virtualization. The steps to enable hardware virtualization 
are:

1. Reboot into the system BIOS (usually by repeatedly tapping F1 or F10 at the first page during startup).
1. In **Security > System Security**:
   1. Enable **Virtualization Technology (VTx)**
   1. Enable **Intel(R) VT-d**

1. At a bash prompt run the following commands.

   1. Install KVM support on your system:
   ```
   sudo apt-get install kvm
   ```
   1. Load the required kernel modules:
   ```
   sudo modprobe kvm-intel
   ```
   1. Add yourself to the `kvm` local group:
   ```
   sudo usermod -a -G kvm $USER
   ```
   replacing $USER with your username. You might need to log out and log in again for
this change to take effect.

   1. Verify that KVM is enabled:
   ```
   sudo /usr/sbin/kvm-ok
   ```

#### Define a virtual device
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

### Set up your Android device

To prepare to run and test your Flutter app on Android, you'll need an Android device running
Android 4.1 (API level 16) or higher.

1. Enable developer mode on your device by visiting **`Settings>About phone`** and
tapping the **Build number** line seven times.
2. In **Settings>Developer options**, enable **USB debugging**.
3. Using a USB cable, plug your phone into your computer. If prompted on your
device, authorize your computer to access your device.
4. In the terminal, run the `flutter devices` command to verify that Flutter recognizes your
connected Android device.
5. Start your app by running `flutter run`.

By default, Flutter uses the version of the Android SDK where your `adb` tool is based. If
you want Flutter to use a different installation of the Android SDK, you must set the
`ANDROID_HOME` environment variable to that installation directory.
