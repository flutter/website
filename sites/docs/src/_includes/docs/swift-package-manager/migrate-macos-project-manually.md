Migrating to SwiftPM requires updating the
`macos/Runner.xcodeproj/project.pbxproj` and
`macos/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme` files.

### Step 1: Add FlutterGeneratedPluginSwiftPackage package dependency {:.no_toc}

1. In Xcode, open `macos/Runner.xcworkspace`.
1. Navigate to **Package Dependencies** for the project.

   <DashImage image="development/packages-and-plugins/swift-package-manager/package-dependencies.png" caption="The project's package dependencies" />

1. Click the <Icon id="add" label="add/plus"></Icon> button.
1. In the dialog that opens, click the **Add Local...**.
1. Navigate to `macos/Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage`
   and click the **Add Package**.
1. Ensure that it's added to the Runner Target and click **Add Package**.

   <DashImage image="development/packages-and-plugins/swift-package-manager/choose-package-products.png" caption="Ensure that the package is added to the `Runner` target" />

1. Ensure that `FlutterGeneratedPluginSwiftPackage` was added to **Frameworks,
   Libraries, and Embedded Content**.

   <DashImage image="development/packages-and-plugins/swift-package-manager/add-generated-framework.png" caption="Ensure that `FlutterGeneratedPluginSwiftPackage` was added to **Frameworks, Libraries, and Embedded Content**" />

### Step 2: Add Run Prepare Flutter Framework Script Pre-action {:.no_toc}

**The following steps must be completed for each flavor.**

1. Go to **Product > Scheme > Edit Scheme**.
1. Expand the **Build** section in the left sidebar.
1. Click **Pre-actions**.
1. Click the <Icon id="add" label="add/plus"></Icon> button
   and select **New Run Script Action** from the menu.
1. Click the **Run Script** title and change it to:

   ```plaintext
   Run Prepare Flutter Framework Script
   ```

1. Change the **Provide build settings from** to the `Runner` target.
1. Input the following in the text box:

   ```sh
   "$FLUTTER_ROOT"/packages/flutter_tools/bin/macos_assemble.sh prepare
   ```

   <DashImage image="development/packages-and-plugins/swift-package-manager/add-flutter-pre-action.png" caption="Add **Run Prepare Flutter Framework Script** build pre-action" />

### Step 3: Run app {:.no_toc}

1. In Xcode, run the app.
1. Ensure that  **Run Prepare Flutter Framework Script** runs as a pre-action
   and that `FlutterGeneratedPluginSwiftPackage` is a target dependency.

   <DashImage image="development/packages-and-plugins/swift-package-manager/flutter-pre-action-build-log.png" caption="Ensure `Run Prepare Flutter Framework Script` runs as a pre-action" />

1. Ensure that the app runs on the command line with `flutter run`.

[file an issue]: {{site.github}}/flutter/flutter/issues/new?template=2_bug.yml
