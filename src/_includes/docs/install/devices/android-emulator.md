#### Set up the Android emulator
{:.no_toc}

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
