Once you [turn on Swift Package Manager][], the Flutter CLI tries to migrate
your project the next time you run your app using the CLI.
This migration updates your Xcode project to use Swift Package Manager to
add Flutter plugin dependencies.

To migrate your project:

1. [Turn on Swift Package Manager][].

2. Run the iOS app using the Flutter CLI.

   If your iOS project doesn't have Swift Package Manager integration yet, the
   Flutter CLI tries to migrate your project and outputs something like:

   ```console
   $ flutter run
   Adding Swift Package Manager integration...
   ```

   The automatic iOS migration modifies the
   `ios/Runner.xcodeproj/project.pbxproj` and
   `ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme` files.

3. If the Flutter CLI's automatic migration fails, follow the steps in
   [add Swift Package Manager integration manually][manualIntegration].

[Optional] To check if your project is migrated:

1. Run the app in Xcode.
2. Ensure that  **Run Prepare Flutter Framework Script** runs as a pre-action
   and that `FlutterGeneratedPluginSwiftPackage` is a target dependency.

   {% render docs/captioned-image.liquid,
   image:"development/packages-and-plugins/swift-package-manager/flutter-pre-action-build-log.png",
   caption:"Ensure **Run Prepare Flutter Framework Script** runs as a pre-action" %}

[Turn on Swift Package Manager]: /packages-and-plugins/swift-package-manager/for-app-developers/#how-to-turn-on-swift-package-manager
[manualIntegration]: /packages-and-plugins/swift-package-manager/for-app-developers/#add-to-a-flutter-app-manually
