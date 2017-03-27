---
layout: page
title: Flutter Setup
sidebar: home_sidebar
permalink: /setup/
---

This guide describes how to set up your development environment to run Flutter apps on
iOS or Android.

## Checklist
To start coding Flutter apps, you'll need to perform all the tasks marked Required in this checklist.
The remaining tasks can be deferred until later in the development cycle, when you're ready
to test and iterate using a simulator or physical device.

<table>
 <tr><th>Task</th><th>Required?</th></tr>
 <tr>
  <td style="width:1600px;"><a href="#system-requirements">Verify your system meets the requirements for Flutter and dependencies</a></td><td align="center">Y</td>
 </tr>
 <tr>
  <td><a href="#get-the-flutter-sdk">Clone the Flutter repo</a></td><td align="center">Y</td>
 </tr>
 <tr>
  <td><a href="#get-the-flutter-sdk">Update your path</a></td><td align="center">Y</td>
 </tr>
 <tr>
   <td><a href="#get-the-flutter-sdk">Run <code>flutter doctor</code> and resolve any issues found</a></td><td align="center">Y</td>
 </tr>
 <tr>
   <td><a href="#editor-setup">Install and configure an IntelliJ IDE to develop Flutter apps</a></td><td align="center"></td>
 </tr>
 <tr>
   <td><a href="#ios-setup">Perform iOS setup tasks to develop apps for iOS</a></td><td align="center"></td>
 </tr>
 <tr>
   <td><a href="#android-setup">Perform Android setup tasks to develop apps for Android</a></td><td align="center"></td>
 </tr>
</table>

Using an IDE is optional. However, we recommend using an IntelliJ IDE with Flutter for code completion, 
inline error checking, and visual debugging features.
{: .alert-warning}

## System requirements

To install and run Flutter, your development environment must meet these minimum requirements:

* **Operating Systems**: Mac or Linux (64-bit). For Windows instructions (beta), see [Flutter on Windows](https://github.com/flutter/flutter/wiki/Flutter-on-Windows).
* **Disk Space**: 700 MB on Mac, 600 MB on Linux, 400 MB on Windows (does not include disk space for Xcode or Android Studio).
* **Tools**: Flutter depends on these command-line tools being available on your environment.
  * `bash`, `mkdir`, `rm`, `git`, `curl`, `unzip`, `which`

## Get the Flutter SDK

1. To get Flutter, use `git` to clone the repository and then add the `flutter` tool to your path:

   ```
   $ git clone https://github.com/flutter/flutter.git
   $ export PATH=`pwd`/flutter/bin:$PATH
   ```

   The above command sets your PATH variable temporarily, for the current terminal window.
   The steps for modifying this variable permanently for all terminal sessions are machine-
   specific. Typically you add a line to a file that is executed whenever you open 
   a new window:

   ```
   export PATH=$HOME/flutter/bin:$PATH
   ```
   and then run the `source <filename>` command to refresh the window. For example, 
   edit (or create) and source `$HOME/.bash_profile`.

1. Verify that the `flutter/bin` directory is now in your PATH by running:
   ```
   $ echo $PATH
   ```

1. Run the following command to see if there are any dependencies you need to install to complete
the setup:

   ```
   $ flutter doctor
   ```

   This command checks your environment and displays a report to the terminal window.
   The Dart SDK is bundled with Flutter; it is not necessary to install Dart separately.
   Check the output carefully for other software you may need to install or further 
   tasks to perform (shown in **bold** text).

   For example:
   ```
    ✗ Xcode end user license agreement not signed; open Xcode or run the command 'sudo xcodebuild -license'.

    ✗ Brew not installed; use this to install tools for iOS device development.


      Download brew at http://brew.sh/.
   ```

   The first time you run the `flutter` command, it downloads its own dependencies and compiles
itself. Subsequent runs should be much faster.

The following sections describe how to perform these tasks and finish the setup process.
You'll see in `flutter doctor` output that if you choose to use an IDE, plugins
are availabile for IntelliJ IDEA. See [IntelliJ Setup](/intellij-setup/)
for the steps to install the Flutter and Dart plugins.

Once you have installed any missing dependencies, run the `flutter doctor` command again to
verify that you’ve set everything up correctly.

The `flutter` tool uses Google Analytics to anonymously report feature usage statistics
and basic crash reports. This data is used to help improve Flutter tools over time.
Analytics is not sent on the very first run or for any runs involving `flutter config`,
so you can opt-out of analytics before any data is sent. To disable reporting, 
type `flutter config --no-analytics` and to display the current setting, type 
`flutter config`. See Google's privacy policy:[www.google.com/intl/en/policies/privacy](https://www.google.com/intl/en/policies/privacy/).
{: .alert-warning}

## Editor setup

Using our command-line tools, you can use any editor to develop Flutter applications.

We recommend using our IntelliJ plug-ins for a  [rich IDE experience](/intellij-ide/) 
supporting editing, running, and debugging Flutter apps. See [IntelliJ Setup](/intellij-setup/)
for detailed steps.

## iOS setup

_This step is optional, and can be performed at any time before
using Flutter to develop apps for iOS._

### Install Xcode

To develop Flutter apps for iOS, you need a Mac with Xcode 7.2 or newer:

1. Install Xcode 7.2 or newer (via [web download](https://developer.apple.com/xcode/) or
the [Mac App Store](https://itunes.apple.com/us/app/xcode/id497799835)).
1. Configure the Xcode command-line tools to use the newly-installed version of Xcode by
running `sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer` from
the command line.

   This is the correct path for most cases, when you want to use the latest version of Xcode.
   If you need to use a different version, specify that path instead.
1. Make sure the Xcode license agreement is signed by either opening Xcode once and confirming or
running `sudo xcodebuild -license` from the command line.

With Xcode, you’ll be able to run Flutter apps on an iOS device or on the simulator.

### Set up the iOS simulator

To prepare to run and test your Flutter app on the iOS simulator, follow these steps:

1. On your Mac, find the Simulator via Spotlight or by using the following command:

    ```
    $ open -a Simulator
    ```

2. Make sure your simulator is using a 64-bit device (iPhone 5s or later) by checking the settings
in the simulator's **Hardware > Device** menu.
3. Depending on your development machine's screen size, simulated high-screen-density iOS devices
may overflow your screen. Set the device scale under the **Window > Scale** menu in the simulator.
4. Start your app by running `flutter run`.


### Deploy to iOS devices

To deploy your Flutter app to a physical iOS device, you’ll need some additional tools, an account, and a profile:

1. Install [homebrew](http://brew.sh/).
1. Open the terminal and run these commands to install the tools for deploying Flutter apps to
iOS devices.

   ```
   $ brew update
   $ brew install --HEAD libimobiledevice
   $ brew install ideviceinstaller ios-deploy
   $ brew install cocoapods
   ```
   If any of these commands fails with an error, run `brew doctor` and follow the instructions 
   for resolving the issue.
   
1. Follow the steps defined by Apple to configure Xcode with your Apple Developer account and enable deploying with provisioning profiles. To learn how to set up your profile, see [Apple's official documentation](https://developer.apple.com/library/ios/documentation/IDEs/Conceptual/AppDistributionGuide/MaintainingProfiles/MaintainingProfiles.html).
1. Select your Development Team for the Flutter project.
   1. Open the default Xcode workspace in your project under `ios/Runner.xcworkspace`. 
   1. Select the `Runner` project in the left navigation panel.
   1. In the Target Settings page, make sure your Development Team is selected under **General > Signing > Team**.
1. Start your app by running `flutter run`.

## Android setup

_This step is optional, and can be performed at any time before
using Flutter to develop apps for Android._

### Install Android Studio

To develop Flutter apps for Android, you can use either a Mac or a Linux (64-bit) machine:

1. Install [Android Studio](https://developer.android.com/studio/index.html).

   Flutter requires the latest Android SDK and Android SDK Platform-Tools packages.
   You can verify these are up-to-date in **Android Studio>Configure>SDK Manager**,
   as described in [Update the IDE and SDK Tools](https://developer.android.com/studio/intro/update.html).

1. Add the bundled JDK directory to your PATH variable. For example, on macOS:
   ```
   $ export PATH=/Users/obiwan/Applications/Android\ Studio.app/Contents/jre/jdk/Contents/Home/bin:$PATH
   ```
   On Linux:
   ```
   $ export PATH=$HOME/Android-Studio/jre/bin:$PATH
   ```
   The above command sets your PATH variable temporarily, for the current terminal window.
   The steps for modifying this variable permanently for all terminal sessions are machine-specific. 
   For details, see [Get the Flutter SDK](#get-the-flutter-sdk).

1. Start Android Studio.

### Set up the Android emulator

To prepare to run and test your Flutter app on the Android emulator, follow these steps:

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

1. Enable developer mode on your device by visiting **`Settings > About phone`** and
tapping the **Build number** line seven times.
2. In **Settings > Developer options**, enable **USB debugging**.
3. Using a USB cable, plug your phone into your computer. If prompted on your
device, authorize your computer to access your device.
4. In the terminal, run the `flutter devices` command to verify that Flutter recognizes your
connected Android device.
5. Start your app by running `flutter run`.

By default, Flutter uses the version of the Android SDK where your `adb` tool is based. If
you want Flutter to use a different installation of the Android SDK, you must set the
`ANDROID_HOME` environment variable to that installation directory.

## Next steps

Now, follow our [Getting Started guide](/getting-started/)
to run your first Flutter app on iOS and Android.
