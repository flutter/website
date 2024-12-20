To migrate your macOS project to add Swift Package Manager integration:

1. Turn on the Swift Package Manager app migration:

   ```sh
   flutter config --enable-swift-package-manager-migration
   ```

1. Run the macOS app using the Flutter CLI.

   If your macOS project doesn't have Swift Package Manager integration yet, the
   Flutter CLI tries to migrate your project and outputs something like:

   ```console
   $ flutter run -d macos
   Adding Swift Package Manager integration...
   ```

   The automatic iOS migration modifies the
   `macos/Runner.xcodeproj/project.pbxproj` and
   `macos/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme` files.

1. If the Flutter CLI's automatic migration fails, follow the steps in
   [add Swift Package Manager integration manually][manualIntegration].

If your app supports iOS, you will need to repeat these steps for your
iOS project.

[manualIntegration]: /packages-and-plugins/swift-package-manager/for-app-developers/#add-to-a-flutter-app-manually