## Configure Android development

### Configure the Android toolchain in Android Studio

{% include docs/help-link.md location='android-studio' section='#android-setup' %}

{% comment %} Nav tabs {% endcomment -%}
<ul class="nav nav-tabs" id="android-studio-start" role="tablist">
    <li class="nav-item">
        <a class="nav-link active" id="first-start-tab" href="#first-start" role="tab" aria-controls="first-start" aria-selected="true">First time using Android Studio</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" id="later-start-tab" href="#later-start" role="tab" aria-controls="later-start" aria-selected="false">Current Android Studio User</a>
    </li>
</ul>

{% comment %} Tab panes {% endcomment -%}
<div class="tab-content">

<div class="tab-pane active" id="first-start" role="tabpanel" aria-labelledby="first-start-tab" markdown="1">

1. Start **Android Studio**.

   The **Welcome to Android Studio** dialog displays.

1. Follow the **Android Studio Setup Wizard**.

1. Install the following components:

   * **Android SDK Platform, API {{ site.appnow.android_sdk }}**
   * **Android SDK Command-line Tools**
   * **Android SDK Build-Tools**
   * **Android SDK Platform-Tools**
   * **Android Emulator**

</div>

<div class="tab-pane" id="later-start" role="tabpanel" aria-labelledby="later-start-tab" markdown="1">

1. Start **Android Studio**.

1. Go to the **Settings** dialog to view the **SDK Manager**.

   1. If you have a project open,
      go to **Tools** <span aria-label="and then">></span> **SDK Manager**.

   1. If the **Welcome to Android Studio** dialog displays,
      click the **More Options** icon that follows the **Open** button
      and click **SDK Manager** from the dropdown menu.

1. Click **SDK Platforms**.

1. Verify that **Android API {{ site.appnow.android_sdk }}** has been selected.

   If the **Status** column displays **Update available** or **Not installed**:

   {:type="a"}
   1. Select **Android API {{ site.appnow.android_sdk }}**.

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

</div>
</div>
{% comment %} End: Tab panes. {% endcomment -%}

### Configure your target Android device

{% comment %} Nav tabs {% endcomment -%}
<ul class="nav nav-tabs" id="android-devices-vp" role="tablist">
    <li class="nav-item">
        <a class="nav-link active" id="virtual-tab" href="#virtual" role="tab" aria-controls="virtual" aria-selected="true">Virtual Device</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" id="physical-tab" href="#physical" role="tab" aria-controls="physical" aria-selected="false">Physical Device</a>
    </li>
</ul>

{% comment %} Tab panes {% endcomment -%}
<div class="tab-content">

<div class="tab-pane active" id="virtual" role="tabpanel" aria-labelledby="virtual-tab" markdown="1">

{% include docs/install/devices/android-emulator.md os=include.os %}

</div>

<div class="tab-pane" id="physical" role="tabpanel" aria-labelledby="physical-tab" markdown="1">

{% include docs/install/devices/android-physical.md os=include.os %}

</div>
</div>
{% comment %} End: Tab panes. {% endcomment -%}

### Agree to Android licenses

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
   [========================================] 100% Computing updates...
   All SDK package licenses accepted.
   ```

   You can skip the next step.

1. Before agreeing to the terms of each license,
   read each with care.

#### Troubleshooting licensing issues
{:.no_toc}

<details markdown="1">
<summary>How to fix the error of finding Java install</summary>

You might have an issue with the Android SDK locating the Java SDK.

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

Look for your `JAVA_HOME` path in your appropriate shell resource file.

Change it from:

```conf
export JAVA_HOME="/Applications/Android\ Studio.app/Contents/jre/Contents/Home"
```

to:

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
