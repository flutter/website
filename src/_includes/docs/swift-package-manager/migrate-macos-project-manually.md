Once you [enable Swift Package Manager][] support, the Flutter CLI tries to
migrate your project to add Swift Package Manager integration.
This makes your project download the Swift packages that your Flutter
plugins depend on.

However, the Flutter CLI might be unable to migrate your project if you've
modified it significantly.

Please [file a bug][] before migrating manually to help the Flutter team improve
the automatic migration.
Please include the error message you received and consider including a copy of
the of the following files in your bug report:

* `macos/Runner.xcodeproj/project.pbxproj`
* `macos/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme`
  (or the xcscheme for the flavor used)

### Step 1: Add FlutterGeneratedPluginSwiftPackage Package Dependency {:.no_toc}

1. Open your app (`macos/Runner.xcworkspace`) in Xcode.
2. Navigate to **Package Dependencies** for the project.

   {% render docs/captioned-image.liquid,
   image:"development/packages-and-plugins/swift-package-manager/package-dependencies.png",
   caption:"The project's package dependencies" %}

3. Click the **+** button.
4. In the dialog that opens, click the **Add Local...** button.
5. Navigate to `macos/Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage`
   and click the **Add Package** button.
6. Ensure that it's added to the Runner Target and click the **Add Package**
   button.

   {% render docs/captioned-image.liquid,
   image:"development/packages-and-plugins/swift-package-manager/choose-package-products.png",
   caption:"Ensure that the package is added to the `Runner` target" %}

7. Ensure that `FlutterGeneratedPluginSwiftPackage` was added to **Frameworks,
   Libraries, and Embedded Content**.

   {% render docs/captioned-image.liquid,
   image:"development/packages-and-plugins/swift-package-manager/add-generated-framework.png",
   caption:"Ensure that `FlutterGeneratedPluginSwiftPackage` was added to **Frameworks, Libraries, and Embedded Content**" %}

### Step 2: Add Run Prepare Flutter Framework Script Pre-Action {:.no_toc}

**The following steps must be completed for each flavor.**

1. Select **Product > Scheme > Edit Scheme**.
2. Click the **>** next to **Build** in the left side bar.
3. Select **Pre-actions**.
4. Click the **+** button and select **New Run Script Action** from the menu.
5. Click the **Run Script** title and change it to:

   ```plaintext
   Run Prepare Flutter Framework Script
   ```

6. Change the **Provide build settings from** to the `Runner` target.
7. Input the following in the text box:

   ```sh
   "$FLUTTER_ROOT"/packages/flutter_tools/bin/macos_assemble.sh prepare
   ```

   {% render docs/captioned-image.liquid,
   image:"development/packages-and-plugins/swift-package-manager/add-flutter-pre-action.png",
   caption:"Add **Run Prepare Flutter Framework Script** build pre-action" %}

### Step 3: Run app {:.no_toc}

1. Run the app in Xcode.
2. Ensure that `FlutterGeneratedPluginSwiftPackage` is a target dependency and
   that `Run Prepare Flutter Framework Script` runs as a pre-action.

   {% render docs/captioned-image.liquid,
   image:"development/packages-and-plugins/swift-package-manager/flutter-pre-action-build-log.png",
   caption:"Ensure `Run Prepare Flutter Framework Script` runs as a pre-action" %}

3. Ensure that the app runs on the command line with `flutter run`.

[enable Swift Package Manager]: /packages-and-plugins/swift-package-manager/for-app-developers/#how-to-enable-swift-package-manager
[file a bug]: {{site.github}}/flutter/flutter/issues/new?template=2_bug.yml
