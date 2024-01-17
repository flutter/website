#### Set up the Android emulator
{:.no_toc}

{% include docs/help-link.md location='android-emulator' section='#android-setup' %}

{% if include.os=='Windows' -%}
{% assign images = '**x86 Images**' -%}
{% elsif include.os=='macOS' -%}
{% assign images = '**x86 Images** if your Mac runs on an Intel CPU or **ARM Images** if your Mac runs on an Apple CPU' -%}
{% endif -%}

To configure your Flutter app to run in the Android emulator,
follow these steps:

1. Enable
    [VM acceleration]({{site.android-dev}}/studio/run/emulator-acceleration#accel-vm)
    on your development computer.

1. Start **Android Studio**.

1. Go to the **Settings** dialog to view the **SDK Manager**.

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
   **Verify Configuation** step.

1. To rename the Android Virtual Device (AVD), change the value in the
   **AVD Name** box.

1. Click **Show Advanced Settings**.

1. Scroll to **Emulated Performance**.

1. From the **Graphics** dropdown menu, select **Hardware - GLES 2.0**.

   This enables [hardware acceleration]({{site.android-dev}}/studio/run/emulator-acceleration).

1. Verify your AVD configuration. If it is correct, click **Finish**.

   To learn more about AVDs, check out
   [Managing AVDs]({{site.android-dev}}/studio/run/managing-avds).

1. In the **Device Manager** dialog, click the **Run** icon to the right
   of your desired AVD.
   The emulator starts up and displays the default canvas for your
   selected OS version and device.
