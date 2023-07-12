#### PowerShell or Command Prompt

To generate the needed Windows platform dependencies,
run the `flutter build` command.

```terminal
$ flutter build windows --debug
```

#### VS Code

1. Open the `lib/main.dart` file.

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

     !['Flutter app showing two buttons to open flutter.dev in a browser or within the app'](/assets/images/docs/testing/debugging/native/windows/url-launcher-app.png){:width="50%"}
     <div markdown="1">
     Flutter app showing two buttons to open flutter.dev in a browser or within the app.
     </div>

#### Visual Studio

1. From the **Debug** menu, select **Attach to Process**.
   You can also press <kbd>Control</kbd> + <kbd>Alt</kbd> + <kbd>P</kbd>.
1. From the **Attach to Process** dialog box, choose `my_app.exe`.

   ![Selecting my_app from the Attach to Process dialog box](/assets/images/docs/testing/debugging/native/visual-studio/attach-to-process-dialog.png){:width="100%"}

   Visual Studio starts monitoring the Flutter app.

   ![Visual Studio debugger running and monitoring the Flutter app](/assets/images/docs/testing/debugging/native/visual-studio/debugger-active.png){:width="100%"}