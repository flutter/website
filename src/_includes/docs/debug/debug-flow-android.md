{{site.alert.note}}
  If you want to use the [GNU Project Debugger][] to debug the
  Flutter engine running within an Android app process,
  check out [`flutter_gdb`][].
{{site.alert.end}}

[GNU Project Debugger]: https://www.sourceware.org/gdb/
[`flutter_gdb`]: https://github.com/flutter/engine/blob/main/sky/tools/flutter_gdb

1. To generate the needed Android platform dependencies,
   run the `flutter build` command.

   ```terminal
   $ flutter build appbundle --debug
   ```

1. Open the `lib/main.dart` file in Android Studio.

1. Click the debug icon
   (![Tiny green bug superimposed with a light green filled circle](/assets/images/docs/testing/debugging/native/android-studio/debug-run.png)).
   This opens the **Debug** pane and launches the app.
   Wait for the app to launch on the device and for the debug pane to
   indicate **Connected**.
   The debugger takes longer to launch the first time.
   Subsequent launches start faster.

   This Flutter app contains two buttons and one link:

   - **Launch in browser**: This button opens this page in the
     default browser of your device.
   - **Launch in app**: This button opens this page within your app.

     !['Flutter app showing two buttons to open flutter.dev in a browser or within the app'](/assets/images/docs/testing/debugging/native/launch-flutter-dev.png){:width="50%"}
     <div markdown="1">
     Flutter app showing two buttons to open flutter.dev in a browser or within the app.
     </div>

1. Click the **Attach debugger to Android process** button.
   (![Tiny green bug superimposed with a light grey arrow](/assets/images/docs/testing/debugging/native/android-studio/attach-process-button.png))

    {{site.alert.tip}}
      If this button doesn't appear in the **Projects** menu bar, verify that
      you opened Flutter _application_ project but _not a Flutter plugin_.
    {{site.alert.end}}

1. The **process** dialog displays one entry for each connected device.
   Select **show all processes** to display available processes for each
   device.

1. Choose the process to which you want to attach.
   In following screenshot, the `com.example.my_app` process
   using the **Emulator Pixel_5_API_33** was selected.

   !['Flutter app in Android device displaying two buttons and a link.'](/assets/images/docs/testing/debugging/native/android-studio/attach-process-dialog.png){:width="50%"}
   <div markdown="1">
   Flutter app in Android device displaying two buttons and a link.
   </div>

1. Locate the tab for **Android Debugger** in the **Debug** pane.

1. In the **Project** pane, expand
   **_app_name__android > android > app > src > main > java > io.flutter plugins**.

1. Double click **GeneratedProjectRegistrant** to open the
   Java code in the **Edit** pane.
   
   !['The Android Project view highlighting the GeneratedPluginRegistrant.java file.'](/assets/images/docs/testing/debugging/native/android-studio/debug-open-java-code.png){:width="100%"}
   <div markdown="1">
   The Android Project view highlighting the `GeneratedPluginRegistrant.java` file.
   </div>

At the end of this procedure, both the Dart and Android debuggers interact
with the same process.
Use either, or both, to set breakpoints, examine stack, resume execution
and the like. In other words, debug!

![The Dart debug pane with two breakpoints set in `lib/main.dart`](/assets/images/docs/testing/debugging/native/dart-debugger.png){:width="100%"}
<div markdown="1">
The Dart debug pane with two breakpoints set in `lib/main.dart`.
</div>

!['The Android debug pane with one breakpoint set in GeneratedPluginRegistrant.java.'](/assets/images/docs/testing/debugging/native/android-studio/debugger-active.png)
<div markdown="1">
The Android debug pane with one breakpoint set in GeneratedPluginRegistrant.java.
</div>

[`url_launcher`]: {{site.url}}/examples/testing/oem_debugging