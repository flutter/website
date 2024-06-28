Once you enable the Swift Package Manager feature, the Flutter CLI will try
to migrate your project to add Swift Package Manager integration. This makes
your project download the Swift packages that your Flutter plugins depend on.

However, the Flutter CLI may be unable to migrate your project if you've
modified it significantly.

Please [file a bug](https://github.com/flutter/flutter/issues/new?template=1_activation.yml) before migrating manually to help the Flutter team improve the automatic migration.
Please include the error message you received and consider including a copy of
the of the following files in your bug report:

* `ios/Runner.xcodeproj/project.pbxproj`
* `ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme` (or the xcsheme for the flavor used)

### Step 1: Add FlutterGeneratedPluginSwiftPackage Package Dependency {:.no_toc}

1. Open your app (`ios/Runner.xcworkspace`) in Xcode
2. Navigate to Package Dependencies for the project

![Screenshot 2024-04-05 at 10 13 56 AM](https://github.com/flutter/flutter/assets/15619084/0d862f5f-8bff-41df-9cf4-3f56b1957230)

3. Click the `+` button
4. Click the `Add Local...` button on the bottom of the dialog that opens
5. Navigate to `ios/Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage` and click the `Add Package` button
6. Ensure it is added to the `Runner` target and click the `Add Package` button

![Screenshot 2024-04-05 at 10 17 21 AM](https://github.com/flutter/flutter/assets/15619084/b5bf410d-c0d4-47b0-b84c-2738002e97d4)

7. Ensure `FlutterGeneratedPluginSwiftPackage` was added to Frameworks, Libraries, and Embedded Content

![Screenshot 2024-04-05 at 10 20 12 AM](https://github.com/flutter/flutter/assets/15619084/7511e021-337c-4d14-bf14-e5804130cb0a)

### Step 2: Add Run Prepare Flutter Framework Script Pre-Action {:.no_toc}

**The following must be completed for each flavor.**

1. Next, select Product > Scheme > Edit Scheme
2. Click the `>` next to "Build" in the left side bar
3. Select Pre-actions
4. Click the `+` button and select `New Run Script Action` from the menu
5. Click the "Run Script" title and change to `Run Prepare Flutter Framework Script`.
6. Change the "Provide build settings from" to the app.
7. Input the following in the text box:
```sh
/bin/sh "$FLUTTER_ROOT/packages/flutter_tools/bin/xcode_backend.sh" prepare
```

![Screenshot 2024-04-05 at 10 24 44 AM](https://github.com/flutter/flutter/assets/15619084/f363db20-634d-46c1-9dd3-9f4a3ec9b992)

### Step 3: Run app {:.no_toc}

1. Run the app in Xcode and ensure `FlutterGeneratedPluginSwiftPackage` is a target dependency and `Run Prepare Flutter Framework Script` is being run as a pre-action.

![Screenshot 2024-04-05 at 12 31 43 PM](https://github.com/flutter/flutter/assets/15619084/ff5070c9-b42f-4930-8b15-70e8024fd3c1)

2. Also, ensure the app runs on the command line with `flutter run`.