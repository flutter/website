<!-- TODO -->
Apps created before Flutter version <X.Y.Z> need to be migrated to support
Swift Package Manager.

To check if your project support Swift Package Manager:

1. Open your app (`ios/Runner.xcworkspace`) in Xcode.
1. Build your app using Xcode.
1. Ensure that **Run Prepare Flutter Framework Script** runs as a pre-action
   and that `FlutterGeneratedPluginSwiftPackage` is a target dependency.

   {% render docs/captioned-image.liquid,
   image:"development/packages-and-plugins/swift-package-manager/flutter-pre-action-build-log.png",
   caption:"Ensure **Run Prepare Flutter Framework Script** runs as a pre-action" %}
