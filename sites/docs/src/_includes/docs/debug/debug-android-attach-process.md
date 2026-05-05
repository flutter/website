1. Click the **Attach debugger to Android process** button.
   (![Tiny green bug superimposed with a light grey arrow](/assets/images/docs/testing/debugging/native/android-studio/attach-process-button.png))

    :::tip
    If this button doesn't appear in the **Projects** menu bar, verify that
    you opened Flutter _application_ project but _not a Flutter plugin_.
    :::

1. The **process** dialog displays one entry for each connected device.
   Select **show all processes** to display available processes for each
   device.

1. Choose the process to which you want to attach.
   For this guide, select the `com.example.my_app` process
   using the **Emulator Pixel_5_API_33**.

{% comment %}

   @atsansone - 2023-07-24

   These screenshots were commented out for two reasons known for most docs:

   1. The docs should stand on their own.
   2. These screenshots would be painful to maintain.

   If reader feedback urges their return, these will be uncommented.

   ![Attach to Process dialog box open in Android Studio](/assets/images/docs/testing/debugging/native/android-studio/attach-process-dialog.png)
   <div class="figure-caption">

   Flutter app in Android device displaying two buttons.

   </div>
{% endcomment %}

1. Locate the tab for **Android Debugger** in the **Debug** pane.

1. In the **Project** pane, expand
   **my_app_android** <span aria-label="and then">></span>
   **android** <span aria-label="and then">></span>
   **app** <span aria-label="and then">></span>
   **src** <span aria-label="and then">></span>
   **main** <span aria-label="and then">></span>
   **java** <span aria-label="and then">></span>
   **io.flutter plugins**.

1. Double click **GeneratedProjectRegistrant** to open the
   Java code in the **Edit** pane.

{% comment %}
   !['The Android Project view highlighting the GeneratedPluginRegistrant.java file.'](/assets/images/docs/testing/debugging/native/android-studio/debug-open-java-code.png){:width="100%"}
   <div class="figure-caption">

   The Android Project view highlighting the `GeneratedPluginRegistrant.java` file.

   </div>
{% endcomment %}

At the end of this procedure, both the Dart and Android debuggers interact
with the same process.
Use either, or both, to set breakpoints, examine stack, resume execution
and the like. In other words, debug!

{% comment %}
![The Dart debug pane with two breakpoints set in `lib/main.dart`](/assets/images/docs/testing/debugging/native/dart-debugger.png){:width="100%"}
<div class="figure-caption">

The Dart debug pane with two breakpoints set in `lib/main.dart`.

</div>
{% endcomment %}

{% comment %}
!['The Android debug pane with one breakpoint set in GeneratedPluginRegistrant.java.'](/assets/images/docs/testing/debugging/native/android-studio/debugger-active.png)
<div class="figure-caption">

The Android debug pane with one breakpoint set in GeneratedPluginRegistrant.java.

</div>
{% endcomment %}
