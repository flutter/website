## Configure Android development

### Configure Android Studio

{% include docs/help-link.md location='android-studio' section='#android-setup' %}

1. Start **Android Studio**.

1. If this is the first time you have launched Android Studio,
   follow the **Android Studio Setup Wizard**.

1. Make sure that you install the following components:

   * Android SDK Platform, API {{ site.appnow.android_sdk }}
   * Android SDK Command-line Tools
   * Android SDK Build-Tools
   * Android SDK Platform-Tools
   * Android Emulator

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

{% include docs/install/devices/android-emulator.md %}

</div>

<div class="tab-pane" id="physical" role="tabpanel" aria-labelledby="physical-tab" markdown="1">

{% include docs/install/devices/android-physical.md %}

</div>
</div>
{% comment %} End: Tab panes. {% endcomment -%}

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
