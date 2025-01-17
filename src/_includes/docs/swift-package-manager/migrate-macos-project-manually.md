Once you [turn on Swift Package Manager][], the Flutter CLI tries to migrate
your project to use Swift Package Manager the next time you run your app
using the CLI.

However, the Flutter CLI tool might be unable to migrate your project
automatically if there are unexpected modifications.

If the automatic migration fails, use the steps below to add Swift Package
Manager integration to a project manually.

Before migrating manually, [file an issue][]; this helps the Flutter team
improve the automatic migration process.
Include the error message and, if possible, include a copy of
the following files in your issue:

* `macos/Runner.xcodeproj/project.pbxproj`
* `macos/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme`
  (or the xcscheme for the flavor used)

### Step 1: Add FlutterGeneratedPluginSwiftPackage Package Dependency {:.no_toc}

1. Open your app (`macos/Runner.xcworkspace`) in Xcode.
1. Navigate to **Package Dependencies** for the project.

   {% render docs/captioned-image.liquid,
   image:"development/packages-and-plugins/swift-package-manager/package-dependencies.png",
   caption:"The project's package dependencies" %}

1. Click <span class="material-symbols">add</span>.
1. In the dialog that opens, click the **Add Local...**.
1. Navigate to `macos/Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage`
   and click the **Add Package**.
1. Ensure that it's added to the Runner Target and click **Add Package**.

   {% render docs/captioned-image.liquid,
   image:"development/packages-and-plugins/swift-package-manager/choose-package-products.png",
   caption:"Ensure that the package is added to the `Runner` target" %}

1. Ensure that `FlutterGeneratedPluginSwiftPackage` was added to **Frameworks,
   Libraries, and Embedded Content**.

   {% render docs/captioned-image.liquid,
   image:"development/packages-and-plugins/swift-package-manager/add-generated-framework.png",
   caption:"Ensure that `FlutterGeneratedPluginSwiftPackage` was added to **Frameworks, Libraries, and Embedded Content**" %}

### Step 2: Add Run Prepare Flutter Framework Script Pre-Action {:.no_toc}

**The following steps must be completed for each flavor.**

1. Go to **Product > Scheme > Edit Scheme**.
1. Expand the **Build** section in the left side bar.
1. Click **Pre-actions**.
1. Click the <span class="material-symbols">add</span> button
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

   {% render docs/captioned-image.liquid,
   image:"development/packages-and-plugins/swift-package-manager/add-flutter-pre-action.png",
   caption:"Add **Run Prepare Flutter Framework Script** build pre-action" %}

### Step 3: Run app {:.no_toc}

1. Run the app in Xcode.
1. Ensure that  **Run Prepare Flutter Framework Script** runs as a pre-action
   and that `FlutterGeneratedPluginSwiftPackage` is a target dependency.

   {% render docs/captioned-image.liquid,
   image:"development/packages-and-plugins/swift-package-manager/flutter-pre-action-build-log.png",
   caption:"Ensure `Run Prepare Flutter Framework Script` runs as a pre-action" %}

1. Ensure that the app runs on the command line with `flutter run`.

[turn on Swift Package Manager]: /packages-and-plugins/swift-package-manager/for-app-developers/#how-to-turn-on-swift-package-manager
[file an issue]: {{site.github}}/flutter/flutter/issues/new?template=2_bug.yml
