Replace `plugin_name` throughout this guide with the name of your plugin.
The example below uses `ios`, replace `ios` with `macos`/`darwin` as applicable.

1. [Turn on the Swift Package Manager feature][enableSPM].

1. Start by creating a directory under the `ios`, `macos`, and/or `darwin`
   directories.
   Name this new directory the name of the platform package.

   <pre>
   plugin_name/ios/
   ├── ...
   └── <b>plugin_name/</b>
   </pre>

1. Within this new directory, create the following files/directories:

    - `Package.swift` (file)
    - `Sources` (directory)
    - `Sources/plugin_name` (directory)
    - `Sources/plugin_name/include` (directory)
    - `Sources/plugin_name/include/plugin_name` (directory)
    - `Sources/plugin_name/include/plugin_name/.gitkeep` (file)
      - This file ensures the directory is committed.
        You can remove the `.gitkeep` file if other files are added to the
        directory.

   Your plugin should look like:

   <pre>
   plugin_name/ios/
   ├── ...
   └── plugin_name/
      ├── <b>Package.swift</b>
      └── <b>Sources/plugin_name/include/plugin_name/</b>
         └── <b>.gitkeep</b>
   </pre>

1. Use the following template in the `Package.swift` file:

   ```swift title="Package.swift"
   // swift-tools-version: 5.9
   // The swift-tools-version declares the minimum version of Swift required to build this package.
   
   import PackageDescription
   
   let package = Package(
       // TODO: Update your plugin name.
       name: "plugin_name",
       platforms: [
           // TODO: Update the platforms your plugin supports.
           // If your plugin only supports iOS, remove `.macOS(...)`.
           // If your plugin only supports macOS, remove `.iOS(...)`.
           .iOS("12.0"),
           .macOS("10.14")
       ],
       products: [
           // TODO: Update your library and target names.
           // If the plugin name contains "_", replace with "-" for the library name
           .library(name: "plugin-name", targets: ["plugin_name"])
       ],
       dependencies: [],
       targets: [
           .target(
               // TODO: Update your target name.
               name: "plugin_name",
               dependencies: [],
               resources: [
                   // TODO: If your plugin requires a privacy manifest
                   // (e.g. if it uses any required reason APIs), update the PrivacyInfo.xcprivacy file
                   // to describe your plugin's privacy impact, and then uncomment this line.
                   // For more information, see:
                   // https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
                   // .process("PrivacyInfo.xcprivacy"),
   
                   // TODO: If you have other resources that need to be bundled with your plugin, refer to
                   // the following instructions to add them:
                   // https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package
               ],
               cSettings: [
                   // TODO: Update your plugin name.
                   .headerSearchPath("include/plugin_name")
               ]
           )
       ]
   )
   ```

1. Update the [supported platforms][] in your `Package.swift` file.

   ```swift title="Package.swift"
       platforms: [
           // TODO: Update the platforms your plugin supports.
           // If your plugin only supports iOS, remove `.macOS(...)`.
           // If your plugin only supports macOS, remove `.iOS(...)`.
           [!.iOS("12.0"),!]
           [!.macOS("10.14")!]
       ],
   ```

   [supported platforms]: https://developer.apple.com/documentation/packagedescription/supportedplatform

1. Update the package, library, and target names in your `Package.swift` file.

   ```swift title="Package.swift"
   let package = Package(
       // TODO: Update your plugin name.
       name: [!"plugin_name"!],
       platforms: [
           .iOS("12.0"),
           .macOS("10.14")
       ],
       products: [
           // TODO: Update your library and target names.
           // If the plugin name contains "_", replace with "-" for the library name
           .library(name: [!"plugin-name"!], targets: [[!"plugin_name"!]])
       ],
       dependencies: [],
       targets: [
           .target(
               // TODO: Update your target name.
               name: [!"plugin_name"!],
               dependencies: [],
               resources: [
                   // TODO: If your plugin requires a privacy manifest
                   // (e.g. if it uses any required reason APIs), update the PrivacyInfo.xcprivacy file
                   // to describe your plugin's privacy impact, and then uncomment this line.
                   // For more information, see:
                   // https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
                   // .process("PrivacyInfo.xcprivacy"),
   
                   // TODO: If you have other resources that need to be bundled with your plugin, refer to
                   // the following instructions to add them:
                   // https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package
               ],
               cSettings: [
                   // TODO: Update your plugin name.
                   .headerSearchPath("include/[!plugin_name!]")
               ]
           )
       ]
   )
   ```

   :::note
   If the plugin name contains `_`, the library name must be a `-` separated
   version of the plugin name.
   :::

1. If your plugin has a [`PrivacyInfo.xcprivacy` file][], move it to
   `ios/Sources/plugin_name/PrivacyInfo.xcprivacy` and uncomment the resource in
   the `Package.swift` file.

   ```swift title="Package.swift"
               resources: [
                   // TODO: If your plugin requires a privacy manifest
                   // (e.g. if it uses any required reason APIs), update the PrivacyInfo.xcprivacy file
                   // to describe your plugin's privacy impact, and then uncomment this line.
                   // For more information, see:
                   // https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
                   [!.process("PrivacyInfo.xcprivacy"),!]
   
                   // TODO: If you have other resources that need to be bundled with your plugin, refer to
                   // the following instructions to add them:
                   // https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package
               ],
   ```

1. Move any resource files from `ios/Assets` to `ios/Sources/plugin_name`
   (or a subdirectory).
   Add the resource files to your `Package.swift` file, if applicable.
   For more instructions, see
   [https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package](https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package).

1. Move any public headers from `ios/Classes` to
   `ios/Sources/plugin_name/include/plugin_name`.

   * If you're unsure which headers are public, check your `podspec` file's
     [`public_header_files`][] attribute.
     If this attribute isn't specified, all of your headers were public.
     You should consider whether you want all of your headers to be public.

   * The `pluginClass` defined in your `pubspec.yaml` file must be public and
     within this directory.

1. Handling `modulemap`.

   Skip this step if your plugin does not have a `modulemap`.

   If you're using a `modulemap` for CocoaPods to create a Test submodule,
   consider removing it for Swift Package Manager.
   Note that this makes all public headers available through the module.

   To remove the `modulemap` for Swift Package Manager but keep it for
   CocoaPods, exclude the `modulemap` and umbrella header in the plugin's
   `Package.swift` file.
  
   The example below assumes the `modulemap` and umbrella header are located
   in the `ios/Sources/plugin_name/include` directory.

    ```diff2html
    --- a/Package.swift
    +++ b/Package.swift
    @@ -1,3 +1,4 @@ 
            .target(
                name: "plugin_name",
                dependencies: [],
    +           exclude: ["include/cocoapods_plugin_name.modulemap", "include/plugin_name-umbrella.h"],
    ```

    If you want to keep your unit tests compatible with both CocoaPods and
    Swift Package Manager, you can try the following:

    ```diff2html
    --- a/Tests/TestFile.m
    +++ b/Tests/TestFile.m
    @@ -1,2 +1,4 @@
    @import plugin_name;
    - @import plugin_name.Test;
    + #if __has_include(<plugin_name/plugin_name-umbrella.h>)
    +   @import plugin_name.Test;
    + #endif
    ```

    If you would like to use a custom `modulemap` with your Swift package,
    refer to [Swift Package Manager's documentation][].

1. Move all remaining files from `ios/Classes` to
   `ios/plugin_name/Sources/plugin_name`.

1. The `ios/Assets`, `ios/Resources`, and `ios/Classes` directories should now
   be empty and can be deleted.

1. If your header files are no longer in the same directory as your
   implementation files, you should update your import statements.

   For example, imagine the following migration:

   * Before:

     <pre>
     ios/Classes/
     ├── PublicHeaderFile.h
     └── ImplementationFile.m
     </pre>

   * After:

     <pre>
     ios/plugin_name_ios/Sources/plugin_name_ios/
     └── <b>include/plugin_name_ios/</b>
        └── PublicHeaderFile.h
     └── ImplementationFile.m
     </pre>

   In this example, the import statements in `ImplementationFile.m`
   should be updated:

   ```diff2html
   --- a/Sources/plugin_name_ios/ImplementationFile.m
   +++ b/Sources/plugin_name_ios/ImplementationFile.m
   @@ -1,1 +1,1 @@
   - #import "PublicHeaderFile.h"
   + #import "./include/plugin_name_ios/PublicHeaderFile.h"
   ```

1. If your plugin uses [Pigeon][], update your Pigeon input file.

   ```diff2html
   --- a/pigeons/messages.dart
   +++ b/pigeons/messages.dart
   @@ -18,8 +18,8 @@ import 'package:pigeon/pigeon.dart';
      javaOptions: JavaOptions(),
   -  objcHeaderOut: 'ios/Classes/messages.g.h',
   -  objcSourceOut: 'ios/Classes/messages.g.m',
   +  objcHeaderOut: 'ios/plugin_name_ios/Sources/plugin_name_ios/messages.g.h',
   +  objcSourceOut: 'ios/plugin_name_ios/Sources/plugin_name_ios/messages.g.m',
      copyrightHeader: 'pigeons/copyright.txt',
   ```

   If your `objcHeaderOut` file is no longer within the same directory as the
   `objcSourceOut`, you can change the `#import` using
   `ObjcOptions.headerIncludePath`:

   ```diff2html
   --- a/pigeons/messages.dart
   +++ b/pigeons/messages.dart
   @@ -18,8 +18,8 @@ import 'package:pigeon/pigeon.dart';
      javaOptions: JavaOptions(),
   -  objcHeaderOut: 'ios/Classes/messages.g.h',
   -  objcSourceOut: 'ios/Classes/messages.g.m',
   +  objcHeaderOut: 'ios/plugin_name_ios/Sources/plugin_name_ios/include/plugin_name_ios/messages.g.h',
   +  objcSourceOut: 'ios/plugin_name_ios/Sources/plugin_name_ios/messages.g.m',
   +  objcOptions: ObjcOptions(
   +    headerIncludePath: './include/plugin_name_ios/messages.g.h',
   +  ),
      copyrightHeader: 'pigeons/copyright.txt',
   ```

   Run Pigeon to re-generate its code with the latest configuration.

1. Update your `Package.swift` file with any customizations you might need.

   1. Open the `ios/plugin_name/` directory in Xcode.

   1. In Xcode, open your `Package.swift` file.
      Verify Xcode doesn't produce any warnings or errors for this file.

      :::tip
      If Xcode doesn't show any files, quit Xcode (**Xcode > Quit Xcode**) and
      reopen.

      If Xcode doesn't update after you make a change, try clicking
      **File > Packages > Reset Package Caches**.
      :::

   1. If your `ios/plugin_name.podspec` file has [CocoaPods `dependency`][]s,
      add the corresponding [Swift Package Manager dependencies][] to your
      `Package.swift` file.

   1. If your package must be linked explicitly `static` or `dynamic`
      ([not recommended by Apple][]), update the [Product][] to define the
      type:

      ```swift title="Package.swift"
      products: [
          .library(name: "plugin-name", type: .static, targets: ["plugin_name"])
      ],
      ```

   1. Make any other customizations. For more information on how to write a
      `Package.swift` file, see
      [https://developer.apple.com/documentation/packagedescription](https://developer.apple.com/documentation/packagedescription).

      :::tip
      If you add targets to your `Package.swift` file, use unique names.
      This avoids conflicts with targets from other packages.
      :::

1. Update your `ios/plugin_name.podspec` to point to new paths.

   ```diff2html
   --- a/ios/plugin_name.podspec
   +++ b/ios/plugin_name.podspec
   @@ -21,4 +21,4 @@
   - s.source_files = 'Classes/**/*.{h,m}'
   - s.public_header_files = 'Classes/**/*.h'
   - s.module_map = 'Classes/cocoapods_plugin_name.modulemap'
   - s.resource_bundles = {'plugin_name_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
   + s.source_files = 'plugin_name/Sources/plugin_name/**/*.{h,m}'
   + s.public_header_files = 'plugin_name/Sources/plugin_name/include/**/*.h'
   + s.module_map = 'plugin_name/Sources/plugin_name/include/cocoapods_plugin_name.modulemap'
   + s.resource_bundles = {'plugin_name_privacy' => ['plugin_name/Sources/plugin_name/PrivacyInfo.xcprivacy']}
   ```

1. Update loading of resources from bundle to use `SWIFTPM_MODULE_BUNDLE`:

   ```objc
   #if SWIFT_PACKAGE
      NSBundle *bundle = SWIFTPM_MODULE_BUNDLE;
    #else
      NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    #endif
    NSURL *imageURL = [bundle URLForResource:@"image" withExtension:@"jpg"];
   ```

   :::note
   `SWIFTPM_MODULE_BUNDLE` only works if there are actual resources
   (either [defined in the `Package.swift` file][Bundling resources] or
   [automatically included by Xcode][Xcode resource detection]).
   Otherwise, using `SWIFTPM_MODULE_BUNDLE` results in an error.
   :::

1. If your `ios/Sources/plugin_name/include` directory only contains a
   `.gitkeep`, you'll want update your `.gitignore` to include the following:

    ```text title=".gitignore"
    !.gitkeep
    ```

    Run `flutter pub publish --dry-run` to ensure the `include` directory
    is published.

1. Commit your plugin's changes to your version control system.

1. Verify the plugin still works with CocoaPods.

   1. Turn off Swift Package Manager:

      ```sh
      flutter config --no-enable-swift-package-manager
      ```

   1. Navigate to the plugin's example app.

      ```sh
      cd path/to/plugin/example/
      ```

   1. Ensure the plugin's example app builds and runs.

      ```sh
      flutter run
      ```

   1. Navigate to the plugin's top-level directory.

      ```sh
      cd path/to/plugin/
      ```

   1. Run CocoaPods validation lints:

      ```sh
      pod lib lint ios/plugin_name.podspec  --configuration=Debug --skip-tests --use-modular-headers --use-libraries
      ```

      ```sh
      pod lib lint ios/plugin_name.podspec  --configuration=Debug --skip-tests --use-modular-headers
      ```

1. Verify the plugin works with Swift Package Manager.

   1. Turn on Swift Package Manager:

      ```sh
      flutter config --enable-swift-package-manager
      ```

   1. Navigate to the plugin's example app.

      ```sh
      cd path/to/plugin/example/
      ```

   1. Ensure the plugin's example app builds and runs.

      ```sh
      flutter run
      ```

      :::warning
      Using the Flutter CLI to run the plugin's example app with the
      Swift Package Manager feature turned on migrates the project to add
      Swift Package Manager integration.

      **Do not commit the migration's changes to your version control system.**

      Otherwise, the plugin's example app won't build if the
      Swift Package Manager feature is turned off.

      If you accidentally commit the migration's changes to the plugin's example
      app, follow the steps to
      [undo the Swift Package Manager migration][removeSPM].
      :::

   1. Open the plugin's example app in Xcode.
      Ensure that **Package Dependencies** shows in the left
      **Project Navigator**.

1. Verify tests pass.

   * **If your plugin has native unit tests (XCTest), make sure you also
     [update unit tests in the plugin's example app][].**

   * Follow instructions for [testing plugins][].

[enableSPM]: /packages-and-plugins/swift-package-manager/for-plugin-authors#how-to-turn-on-swift-package-manager
[`PrivacyInfo.xcprivacy` file]: https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
[`public_header_files`]: https://guides.cocoapods.org/syntax/podspec.html#public_header_files
[Swift Package Manager's documentation]: {{site.github}}/apple/swift-package-manager/blob/main/Documentation/Usage.md#creating-c-language-targets
[Pigeon]: https://pub.dev/packages/pigeon
[CocoaPods `dependency`]: https://guides.cocoapods.org/syntax/podspec.html#dependency
[Swift Package Manager dependencies]: https://developer.apple.com/documentation/packagedescription/package/dependency
[not recommended by Apple]: https://developer.apple.com/documentation/packagedescription/product/library(name:type:targets:)
[Product]: https://developer.apple.com/documentation/packagedescription/product
[Bundling resources]: https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package#Explicitly-declare-or-exclude-resources
[Xcode resource detection]: https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package#:~:text=Xcode%20detects%20common%20resource%20types%20for%20Apple%20platforms%20and%20treats%20them%20as%20a%20resource%20automatically
[removeSPM]: /packages-and-plugins/swift-package-manager/for-app-developers#how-to-remove-swift-package-manager-integration
[update unit tests in the plugin's example app]: /packages-and-plugins/swift-package-manager/for-plugin-authors/#how-to-update-unit-tests-in-a-plugins-example-app
[testing plugins]: https://docs.flutter.dev/testing/testing-plugins
