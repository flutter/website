To migrate your iOS project to add Swift Package Manager integration:

1. Turn on the Swift Package Manager app migration:

   ```sh
   flutter config --enable-swift-package-manager-migration
   ```

1. Run the iOS app using the Flutter CLI.

   If your iOS project doesn't have Swift Package Manager integration yet, the
   Flutter CLI tries to migrate your project and outputs something like:

   ```console
   $ flutter run
   Adding Swift Package Manager integration...
   ```

   The automatic iOS migration modifies the
   `ios/Runner.xcodeproj/project.pbxproj` and
   `ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme` files.

1. If the Flutter CLI's automatic migration fails, follow the steps in
   [add Swift Package Manager integration manually][manualIntegration].

If your app supports macOS, you will need to repeat these steps for your
macOS project.

[Turn on Swift Package Manager]: /packages-and-plugins/swift-package-manager/for-app-developers/#how-to-turn-on-swift-package-manager
[manualIntegration]: /packages-and-plugins/swift-package-manager/for-app-developers/#add-to-a-flutter-app-manually
