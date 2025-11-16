1. To open the Flutter app directory, go to
   **File** <span aria-label="and then">></span>
   **Open Folder...** and choose the `my_app` directory.

1. Open the `lib/main.dart` file.

1. If you can build an app for more than one device,
   you must select the device first.

   Go to
   **View** <span aria-label="and then">></span>
   **Command Palette...**

   You can also press <kbd>Ctrl</kbd> / <kbd>Cmd</kbd> +
   <kbd>Shift</kbd> + <kbd>P</kbd>.

1. Type `flutter select`.

1. Click the **Flutter: Select Device** command.

1. Choose your target device.

1. Click the debug icon
   (![VS Code's bug icon to trigger the debugging mode of a Flutter app](/assets/images/docs/testing/debugging/vscode-ui/icons/debug.png)).
   This opens the **Debug** pane and launches the app.
   Wait for the app to launch on the device and for the debug pane to
   indicate **Connected**.
   The debugger takes longer to launch the first time.
   Subsequent launches start faster.

   This Flutter app contains two buttons:

   - **Launch in browser**: This button opens this page in the
     default browser of your device.
   - **Launch in app**: This button opens this page within your app.
     This button only works for iOS or Android. Desktop apps launch a browser.

{% if add == 'launch' -%}
{% render "docs/debug/vscode-flutter-attach-json.md" %}
{% endif -%}
