
## Configure Android development

{% case include.devos %}
{% when 'Windows' -%}
   {% assign terminal='PowerShell' %}
   {% assign prompt='C:\>' %}
{% when "macOS" -%}
   {% assign terminal='your Terminal' %}
   {% assign prompt='$' %}
{% else -%}
   {% assign terminal='a shell' %}
   {% assign prompt='$' %}
{% endcase -%}

### Configure the Android toolchain in Android Studio

{% render docs/help-link.md, location:'android-studio', section:'#android-setup' %}

To create Android apps with Flutter, verify that the following Android
components have been installed.

* **Android SDK Platform, API 35**
* **Android SDK Command-line Tools**
* **Android SDK Build-Tools**
* **Android SDK Platform-Tools**
* **Android Emulator**

If you haven't installed these, or you don't know, continue with the following procedure.

Otherwise, you can skip to the [next section][check-dev].

[check-dev]: #check-your-development-setup

{% tabs "android-studio-experience" %}
{% tab "First time using Android Studio" %}

1. Launch **Android Studio**.

   The **Welcome to Android Studio** dialog displays.

1. Follow the **Android Studio Setup Wizard**.

1. Install the following components:

   * **Android SDK Platform, API 35**
   * **Android SDK Command-line Tools**
   * **Android SDK Build-Tools**
   * **Android SDK Platform-Tools**
   * **Android Emulator**

{% endtab %}
{% tab "Current Android Studio User" %}

1. Launch **Android Studio**.

1. Go to the **Settings** dialog to view the **SDK Manager**.

   1. If you have a project open,
      go to **Tools** <span aria-label="and then">></span> **SDK Manager**.

   1. If the **Welcome to Android Studio** dialog displays,
      click the **More Options** icon that follows the **Open** button
      and click **SDK Manager** from the dropdown menu.

1. Click **SDK Platforms**.

1. Verify that **Android API 35** has been selected.

   If the **Status** column displays **Update available** or **Not installed**:

   {:type="a"}
   1. Select **Android API 35**.

   1. Click **Apply**.

   1. When the **Confirm Change** dialog displays, click **OK**.

      The **SDK Quickfix Installation** dialog displays with a
      completion meter.

   1. When the install finishes, click **Finish**.

      After you installed the latest SDK,
      the **Status** column might display **Update available**.
      This means some additional system images might not be installed.
      You can ignore this and continue.

1. Click **SDK Tools**.

1. Verify that the following SDK Tools have been selected:

   * **Android SDK Command-line Tools**
   * **Android SDK Build-Tools**
   * **Android SDK Platform-Tools**
   * **Android Emulator**

1. If the **Status** column for any of the preceding tools displays
   **Update available** or **Not installed**:

   {:type="a"}
   1. Select the needed tools.

   1. Click **Apply**.

   1. When the **Confirm Change** dialog displays, click **OK**.

      The **SDK Quickfix Installation** dialog displays with a
      completion meter.

   1. When the install finishes, click **Finish**.

{% endtab %}
{% endtabs %}

### Configure your target Android device

{% tabs "android-emulator-or-not" %}
{% tab "Virtual device" %}

#### Set up the Android emulator

{% render docs/help-link.md, location:'android-emulator', section:'#android-setup' %}

{% case include.devos %}
{% when 'Windows','Linux' -%}
{% assign images = '**x86 Images**' -%}
{% when 'macOS' -%}
{% assign images = '**x86 Images** if your Mac runs on an Intel CPU or **ARM Images** if your Mac runs on an Apple CPU' -%}
{% endcase -%}

To configure your Flutter app to run in an Android emulator,
follow these steps to create and select an emulator.

1. Enable
    [VM acceleration]({{site.android-dev}}/studio/run/emulator-acceleration#accel-vm)
    on your development computer.

1. Start **Android Studio**.

1. Go to the **Settings** dialog to view the **Device Manager**.

   1. If you have a project open,
      go to **Tools** <span aria-label="and then">></span>
      **Device Manager**.

   1. If the **Welcome to Android Studio** dialog displays,
      click the **More Options** icon that follows the **Open** button
      and click **Device Manager** from the dropdown menu.

1. Click **Virtual**.

1. Click **Create Device**.

   The **Virtual Device Configuration** dialog displays.

1. Select either **Phone** or **Tablet** under **Category**.

1. Select a device definition. You can browse or search for the device.

1. Click **Next**.

1. Click {{images}}.

1. Click one system image for the Android version you want to emulate.

   {:type="a"}
   1. If the desired image has a **Download** icon to the right
      of the **Release Name**, click it.

      The **SDK Quickfix Installation** dialog displays with a
      completion meter.

   1. When the download completes, click **Finish**.

1. Click **Next**.

   The **Virtual Device Configuration** displays its
   **Verify Configuration** step.

1. To rename the Android Virtual Device (AVD), change the value in the
   **AVD Name** box.

1. Click **Show Advanced Settings** and scroll to **Emulated Performance**.

1. From the **Graphics** dropdown menu, select **Hardware - GLES 2.0**.

   This enables [hardware acceleration][] and improves rendering performance.

1. Verify your AVD configuration. If it is correct, click **Finish**.

   To learn more about AVDs, check out
   [Managing AVDs]({{site.android-dev}}/studio/run/managing-avds).

1. In the **Device Manager** dialog, click the **Run** icon to the right
   of your desired AVD.
   The emulator starts up and displays the default canvas for your
   selected Android OS version and device.

[hardware acceleration]: {{site.android-dev}}/studio/run/emulator-acceleration

{% endtab %}
{% tab "Physical device" %}

#### Set up your target Android device

{% render docs/help-link.md, location:'android-device', section:'#android-setup' %}

To configure your Flutter app to run on a physical Android device,
you need a [supported version of Android][supported-version].

1. Enable **Developer options** and **USB debugging** on your device
   as described in the
   [Android documentation]({{site.android-dev}}/studio/debug/dev-options).

1. [Optional] To leverage wireless debugging,
   enable **Wireless debugging** on your device as described in the
   [Android documentation]({{site.android-dev}}/studio/run/device#wireless).

{%- if include.devos == 'Windows' %}

1. Install the [Google USB Driver]({{site.android-dev}}/studio/run/win-usb).

{% endif %}

1. Plug your device into your {{include.devos}} computer.
   If your device prompts you, authorize your computer to access your device.

1. Verify that Flutter recognizes your connected Android device.

   {%- if include.devos == 'Windows' %}

   In PowerShell, run:

   ```console
   c:\> flutter devices
   ```

   {% elsif devos == 'macOS' %}

   In the Terminal, run:

   ```console
   $ flutter devices
   ```

   {% endif %}

   By default, Flutter uses the version of the Android
   SDK where your `adb` tool is based.
   To use a different Android SDK installation path with Flutter,
   set the `ANDROID_SDK_ROOT` environment variable
   to that installation directory.

{% endtab %}
{% endtabs %}

[supported-version]: /reference/supported-platforms

{% if include.attempt == 'first' %}

### Agree to Android licenses

{% render docs/help-link.md, location:'android-licenses', section:'#android-setup' %}

Before you can use Flutter and after you install all prerequisites,
agree to the licenses of the Android SDK platform.

1. Open an elevated console window.

1. Run the following command to enable signing licenses.

   ```console
   {{prompt}} flutter doctor --android-licenses
   ```

   If you accepted the Android Studio licenses at another time,
   this command returns:

   ```console
   [========================================] 100% Computing updates...
   All SDK package licenses accepted.
   ```

   You can skip the next step.

1. Before agreeing to the terms of each license,
   read each with care.

{% if include.devos == 'macOS' %}

#### Troubleshooting licensing issues

<details>
<summary>How to fix the error of finding Java install</summary>

You might have an issue with the Android SDK locating the Java SDK.

```console
$ flutter doctor --android-licenses

ERROR: JAVA_HOME is set to an invalid directory: /Applications/Android\ Studio.app/Contents/jre/Contents/Home

Please set the JAVA_HOME variable in your environment to match the
location of your Java installation.

Android sdkmanager tool was found, but failed to run
(/Users/atsansone/Library/Android/sdk/cmdline-tools/latest/bin/sdkmanager): "exited code 1".
Try re-installing or updating your Android SDK,
visit https://flutter.dev/to/macos-android-setup for detailed instructions.
```

The `flutter doctor` command returns this error because of how the `JAVA_HOME`
variable was set. When you add the path to `JAVA_HOME`, you can add a backslash
to the space between `Android` and `Studio` or enclose the entire path in
matching quotes. You cannot do _both_.

Look for your `JAVA_HOME` path in your appropriate shell resource file.

Change it from:

```bash
export JAVA_HOME="/Applications/Android\ Studio.app/Contents/jre/Contents/Home"
```

to:

```bash
export JAVA_HOME="/Applications/Android Studio.app/Contents/jre/Contents/Home"
```

Do not include the backslash between `Android` and `Studio`.

To load this updated environment variable, reload your shell.
This example uses the `zsh` resource file.

```console
source ~/.zshrc
```

</details>

{% endif %}

{% endif %}
