Once you enable the Swift Package Manager feature, the Flutter CLI will try
to migrate your project to add Swift Package Manager integration. This makes
your project download the Swift packages that your Flutter plugins depend on.

However, the Flutter CLI may be unable to migrate your project if you've
modified it significantly.

Please [file a bug][] before migrating manually to help the Flutter team improve
the automatic migration.
Please include the error message you received and consider including a copy of
the of the following files in your bug report:

* `macos/Runner.xcodeproj/project.pbxproj`
* `macos/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme`
  (or the xcscheme for the flavor used)

### Step 1: Add FlutterGeneratedPluginSwiftPackage Package Dependency {:.no_toc}

1. Open your app (`macos/Runner.xcworkspace`) in Xcode
2. Navigate to Package Dependencies for the project

   ![Screenshot 2024-04-05 at 10 13 56 AM](https://github.com/flutter/flutter/assets/15619084/0d862f5f-8bff-41df-9cf4-3f56b1957230)

3. Click the `+` button
4. Click the `Add Local...` button on the bottom of the dialog that opens
5. Navigate to `macos/Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage`
   and click the `Add Package` button
6. Ensure it is added to the Runner Target and click the `Add Package` button

   ![Screenshot 2024-04-05 at 10 17 21 AM](https://github.com/flutter/flutter/assets/15619084/b5bf410d-c0d4-47b0-b84c-2738002e97d4)

7. Ensure `FlutterGeneratedPluginSwiftPackage` was added to Frameworks,
   Libraries, and Embedded Content

   ![Screenshot 2024-04-05 at 10 20 12 AM](https://github.com/flutter/flutter/assets/15619084/7511e021-337c-4d14-bf14-e5804130cb0a)

### Step 2: Add Run Prepare Flutter Framework Script Pre-Action {:.no_toc}

**The following must be completed for each flavor.**

1. Next, select Product > Scheme > Edit Scheme
2. Click the `>` next to "Build" in the left side bar
3. Select Pre-actions
4. Click the `+` button and select `New Run Script Action` from the menu
5. Click the "Run Script" title and change to `Run Prepare Flutter Framework Script`.
6. Change the "Provide build settings from" to the Runner target.
7. Input the following in the text box:

   ```sh
   "$FLUTTER_ROOT"/packages/flutter_tools/bin/macos_assemble.sh prepare
   ```

   ![Screenshot 2024-04-05 at 2 22 56 PM](https://github.com/flutter/flutter/assets/15619084/c9c2e159-12ff-4230-829a-c5c72a7e31dc)

### Step 3: Run app {:.no_toc}

1. Run the app in Xcode and ensure `FlutterGeneratedPluginSwiftPackage` is a target dependency and `Run Prepare Flutter Framework Script` is being run as a pre-action.

   ![Screenshot 2024-04-05 at 12 31 43 PM](https://github.com/flutter/flutter/assets/15619084/ff5070c9-b42f-4930-8b15-70e8024fd3c1)

2. Also, ensure the app runs on the command line with `flutter run`.
