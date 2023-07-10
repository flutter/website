#### Terminal

To generate the needed iOS platform dependencies,
run the `flutter build` command.

```terminal
$ flutter build ios --config-only --no-codesign --debug
```

#### XCode

1. Open `ios/Runner.xcworkspace` from your Flutter app directory.
1. Run this Runner as a normal app in Xcode.
1. Select the correct device using the **Scheme** menu in the toolbar.

    ![Selecting iPhone 14 in the Scheme menu in the Xcode toolbar](/assets/images/docs/testing/debugging/oem/xcode-select-device.png){:width="100%"}

#### VS Code

1. Open the command palette.
   (<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd>
   or **View** > **Command Palette...**)
1. Type `debug`.
1. Click the **Debug: Attach to Flutter on Device** command.

   !['Running the Debug: Attach to Flutter on Device command in VS Code.'](/assets/images/docs/development/add-to-app/debugging/vscode-attach.png)