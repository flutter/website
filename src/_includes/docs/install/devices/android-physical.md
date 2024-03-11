#### Set up your target Android device

{% include docs/help-link.md location='android-device' section='#android-setup' %}

{% assign devos = include.devos %}
{% assign target = include.target %}
{% assign compiler = include.compiler %}
{% assign time = include.time %}

To configure your Flutter app to run on a physical Android device,
you need an Android device running {{site.targetmin.android}} or later.

1. Enable **Developer options** and **USB debugging** on your device
   as described in the
   [Android documentation]({{site.android-dev}}/studio/debug/dev-options).

1. [Optional] To leverage wireless debugging,
   enable **Wireless debugging** on your device as described in the
   [Android documentation]({{site.android-dev}}/studio/run/device#wireless).

{%- if devos == 'Windows' %}

1. Install the [Google USB Driver]({{site.android-dev}}/studio/run/win-usb).

{% endif %}

1. Plug your device into your {{devos}} computer.
   If your device prompts you, authorize your computer to access your device.

1. Verify that Flutter recognizes your connected Android device.

   {%- if devos == 'Windows' %}

   In PowerShell, run:

   ```terminal
   c:\> flutter devices
   ```

   {% elsif devos == 'macOS' %}

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
