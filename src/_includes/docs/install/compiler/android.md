## Configure Android development

### Configure Android Studio

{% include docs/help-link.md location='android-studio' section='#android-setup' %}

1. Start **Android Studio**.

1. Go through the **Android Studio Setup Wizard**.
   This installs the required Android components listed under
   [Development tools](#development-tools).

### Set up your target Android device

{% include docs/help-link.md location='android-device' section='#android-setup' %}

To configure your Flutter app to run on a physical Android device,
you need an Android device running {{site.min.target.android}} or later.

1. Enable **Developer options** and **USB debugging** on your device
   as described in the
   [Android documentation]({{site.android-dev}}/studio/debug/dev-options).

1. [Optional] To leverage wireless debugging,
   enable **Wireless debugging** on your device as described in the
   [Android documentation]({{site.android-dev}}/studio/run/device#wireless).

{%- if include.os == 'Windows' %}

1. Install the [Google USB Driver]({{site.android-dev}}/studio/run/win-usb).

{% endif %}

1. Plug your device into your {{include.os}} computer.
   If your device prompts you, authorize your computer to access your device.

1. Verify that Flutter recognizes your connected Android device.

   {%- if include.os == 'Windows' %}

   In PowerShell, run:

   ```terminal
   c:\> flutter devices
   ```

   {% elsif include.os == 'macOS' %}

   In the Terminal, run:

   ```terminal
   $ flutter devices
   ```

   {% endif %}


   By default, Flutter uses the version of the Android
   SDK where your `adb` tool is based.
   To use a different Android SDK installation path with Flutter,
   set the `ANDROID_SDK_ROOT` environment variable
   to that installation directory.

### Set up the Android emulator

{% include docs/help-link.md location='android-emulator' section='#android-setup' %}

To configure your Flutter app to run in the Android emulator,
follow these steps:

1. Enable
    [VM acceleration]({{site.android-dev}}/studio/run/emulator-acceleration#accel-vm)
    on your development computer.

1. Launch **Android Studio**.

1. Go to **Tools** <span aria-label="and then">></span> **Device Manager**.

1. Click **Virtual**.

1. Click **Create Device**.

   The **Virtual Device Configuration** dialog displays.

    - In older versions of Android Studio, go to **Tools**
      <span aria-label="and then">></span> **Android**
      <span aria-label="and then">></span> **AVD Manager**.

      Click **Create Virtual Device...**.
      The **Android** submenu appears only when inside an Android project.

    - If you do not have a project open, you can choose
      <span class="material-icons-outlined">
      more_vert
      </span> (**More Actions**) <span aria-label="and then">></span>
      **Virtual Device Manager** and select **Create Device...**

1. Select either **Phone** or **Tablet** under **Category**.

1. Select a device definition. You can browse or search for the device.

1. Click **Next**.

1. Click **Other Images**.

1. Click one system image for the Android version you want to emulate.
   Choose an image with an ABI of **x86_64**.

   {:type="a"}
   1. If the desired image has a **Download** link to the right
      of the **Release Name**, click **Download**.

      The **SDK Quickfix Installation** dialog displays with a
      completion meter.

   1. When the download completes, click **Finish**.

1. Click **Next**.

   The **Virtual Device Configuration** displays its **Verify Configuation**
   step.

1. To rename the Android Virtual Device (AVD), change the value in the
   **AVD Name** box.

1. Click **Show Advanced Settings**.

1. Scroll to **Emulated Performance**.

1. From the **Graphics** dropdown menu, select **Hardware - GLES 2.0**.

   This enables [hardware acceleration]({{site.android-dev}}/studio/run/emulator-acceleration).

1. Verify your AVD configuration. If it is correct, click **Finish**.

   To learn more about AVDs, check out
   [Managing AVDs]({{site.android-dev}}/studio/run/managing-avds).

1. In the **Device Manager** dialog, click **Run** icon to the right
   of your desired AVD.
   The emulator starts up and displays the default canvas for your
   selected OS version and device.

### Agree to Android Licenses

{% include docs/help-link.md location='android-licenses' section='#android-setup' %}

Before you can use Flutter and after you install all prerequisites,
agree to the licenses of the Android SDK platform.

1. Open an elevated console window.

1. Run the following command to enable signing licenses.

   ```terminal
   $ flutter doctor --android-licenses
   ```

   If you accepted the Android Studio licenses at another time,
   this command returns:

   ```terminal
   All SDK package licenses accepted.======] 100% Computing updates...
   ```

   You can skip the next step.

1. Before agreeing to the terms of each license,
   read each with care.

#### Troubleshooting licensing issues
{:no_toc}

<details markdown="1">
<summary>How to fix the error of finding Java install</summary>

You may have an issue with the Android SDK locating the Java SDK.

```terminal
$ flutter doctor --android-licenses

ERROR: JAVA_HOME is set to an invalid directory: /Applications/Android\ Studio.app/Contents/jre/Contents/Home

Please set the JAVA_HOME variable in your environment to match the
location of your Java installation.

Android sdkmanager tool was found, but failed to run
(/Users/atsansone/Library/Android/sdk/cmdline-tools/latest/bin/sdkmanager): "exited code 1".
Try re-installing or updating your Android SDK,
visit https://flutter.dev/docs/get-started/install/macos#android-setup for detailed instructions.
```

The `flutter doctor` command returns this error because of how the `JAVA_HOME`
variable was set. When you add the path to `JAVA_HOME`, you can add a backslash
to the space between `Android` and `Studio` or enclose the entire path in
matching quotes. You cannot do _both_.

Look for your `JAVA_HOME` path in your appropriate shell resource file
and change it to:

```conf
export JAVA_HOME="/Applications/Android Studio.app/Contents/jre/Contents/Home"
```

Do not include the backslash between `Android` and `Studio`.

To load this updated environment variable, reload your shell.
This example uses the `zsh` resource file.

```terminal
source ~/.zshrc
```
</details>
