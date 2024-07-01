Replace `plugin_name` throughout this guide with the name of your plugin.
The below example uses `ios`, replace `ios` with `macos`/`darwin` as applicable.

1. Enable the Swift Package Manager feature.

2. Start by creating a directory under the `ios`, `macos`, and/or `darwin`
   directories.
   Name this new directory the name of the platform package.

   <pre>
   /plugin_name/plugin_name_ios/ios/<b>plugin_name_ios</b>
   </pre>

3. Within this new directory, create the following files/directories:

    - Package.swift (file)
    - Sources (directory)
    - Sources/plugin_name_ios (directory)
    - Sources/plugin_name_ios/include (directory)
    - Sources/plugin_name_ios/include/plugin_name_ios (directory)
    - Sources/plugin_name_ios/include/plugin_name_ios/.gitkeep (file)
      - This is needed to ensure the directory is committed, even if empty.
        Can be removed if files are added to the directory.

   <pre>
   /plugin_name/plugin_name_ios/ios/plugin_name_ios/<b>Package.swift</b>
   /plugin_name/plugin_name_ios/ios/plugin_name_ios/<b>Sources</b>
   /plugin_name/plugin_name_ios/ios/plugin_name_ios/<b>Sources/plugin_name_ios</b>
   /plugin_name/plugin_name_ios/ios/plugin_name_ios/<b>Sources/plugin_name_ios/include</b>
   /plugin_name/plugin_name_ios/ios/plugin_name_ios/<b>Sources/plugin_name_ios/include/plugin_name_ios</b>
   /plugin_name/plugin_name_ios/ios/plugin_name_ios/<b>Sources/plugin_name_ios/include/plugin_name_ios/.gitkeep</b>
   </pre>

4. Use the following template in the `Package.swift` file:

   ```swift title="Package.swift"
   // swift-tools-version: 5.9
   // The swift-tools-version declares the minimum version of Swift required to build this package.
   
   import PackageDescription
   
   let package = Package(
       name: "plugin_name_ios",
       platforms: [
           .iOS("12.0"),
           .macOS("10.14")
       ],
       products: [
           // If the plugin name contains "_", replace with "-" for the library name
           .library(name: "plugin-name-ios", targets: ["plugin_name_ios"])
       ],
       dependencies: [],
       targets: [
           .target(
               name: "plugin_name_ios",
               dependencies: [],
               resources: [
                   // If your plugin requires a privacy manifest, for example if it uses any required
                   // reason APIs, update the PrivacyInfo.xcprivacy file to describe your plugin's
                   // privacy impact, and then uncomment these lines. For more information, see
                   // https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
                   // .process("PrivacyInfo.xcprivacy"),
   
                   // If you have other resources that need to be bundled with your plugin, refer to
                   // the following instructions to add them:
                   // https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package
               ],
               cSettings: [
                   .headerSearchPath("include/plugin_name_ios")
               ]
           )
       ]
   )
   ```

   :::note
   If the plugin name contains `_`, the library name must be a `-` separated
   version of the plugin name.
   :::

5. If your plugin has a `PrivacyInfo.xcprivacy` file, move it to
   `Sources/plugin_name_ios/PrivacyInfo.xcprivacy` and uncomment the resource in
   the `Package.swift` file.


   ```swift title="Package.swift"
               resources: [
                   // If your plugin requires a privacy manifest, for example if it uses any required
                   // reason APIs, update the PrivacyInfo.xcprivacy file to describe your plugin's
                   // privacy impact, and then uncomment these lines. For more information, see
                   // https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
                   [!.process("PrivacyInfo.xcprivacy"),!]
   
                   // If you have other resources that need to be bundled with your plugin, refer to
                   // the following instructions to add them:
                   // https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package
               ],
   ```

6. Move any resource files from `ios/Assets` to `Sources/plugin_name_ios`
   (or a subdirectory). Then add them to your `Package.swift` file if
   applicable.
   For more instructions, see
   [https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package](https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package).

7. Move any public headers from `ios/Classes` to
   `Sources/plugin_name_ios/include/plugin_name_ios`.

    * If you're unsure which headers are public, check your `podspec` for
      `public_header_files`. If not found, that means all of your headers were
      public.
      You should consider whether or not you want all of your headers to be
      public.

    * The `pluginClass` defined in your pubspec.yaml must be public and within
      this directory.

8. Handling modulemap (skip this step if not using a custom modulemap):

    If you're using a modulemap for CocoaPods to create a Test submodule,
    consider removing it for Swift Package Manager.
    Note that this will make all public headers available via the module.

    To remove the modulemap for Swift Package Manager but keep it for CocoaPods,
    exclude the modulemap and umbrella header in the plugin's `Package.swift`
    file.
    The example below assumes they are located within the
    `Sources/plugin_name_ios/include` directory.

    ```diff2html
    --- a/Package.swift
    +++ b/Package.swift
    @@ -1,3 +1,4 @@ 
            .target(
                name: "plugin_name_ios",
                dependencies: [],
    +           exclude: ["include/cocoapods_plugin_name_ios.modulemap", "include/plugin_name_ios-umbrella.h"],
    ```

    If you want to keep your unit tests compatible with both CocoaPods and
    Swift Package Manager, you can try the following:

    ```diff2html
    --- a/Tests/TestFile.m
    +++ b/Tests/TestFile.m
    @@ -1,2 +1,4 @@
    @import plugin_name_ios;
    - @import plugin_name_ios.Test;
    + #if __has_include(<plugin_name_ios/plugin_name_ios-umbrella.h>)
    +   @import plugin_name_ios.Test;
    + #endif
    ```

    If you would like to use a custom modulemap with your Swift package,
    please refer to [Swift Package Manager's documentation][].

9. Move all remaining files from `ios/Classes` to `Sources/plugin_name_ios`.

10. `ios/Assets`, `ios/Resources`, `ios/Classes` should now be empty and
    can be deleted.

11. If your header files were previously within the same directory as your
    implementation files, you may need to change your import statements.

    For example, if the following changes were made:

    * `ios/Classes/PublicHeaderFile.h` -->
      `Sources/plugin_name_ios/include/plugin_name_ios/PublicHeaderFile.h`
    * `ios/Classes/ImplementationFile.m` -->
      `Sources/plugin_name_ios/ImplementationFile.m`

    Within `ImplementationFile.m`, the import would change:

    ```diff2html
    --- a/Sources/plugin_name_ios/ImplementationFile.m
    +++ b/Sources/plugin_name_ios/ImplementationFile.m
    @@ -1,1 +1,1 @@
    - #import "PublicHeaderFile.h"
    + #import "./include/plugin_name_ios/PublicHeaderFile.h"
    ```

12. If using Pigeon, update your Pigeon input file:

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
    +  objcHeaderOut: 'ios/plugin_name_ios/Sources/plugin_name_ios/messages.g.h',
    +  objcSourceOut: 'ios/plugin_name_ios/Sources/plugin_name_ios/messages.g.m',
    +  objcOptions: ObjcOptions(
    +    headerIncludePath: './include/plugin_name_ios/messages.g.h',
    +  ),
       copyrightHeader: 'pigeons/copyright.txt',
    ```

13. Update your `Package.swift` file with any customizations you may need.

    1. Open `/plugin_name/plugin_name_ios/ios/plugin_name_ios/` in Xcode.

        * If package does not show any files in Xcode, quit Xcode (Xcode >
          Quit Xcode) and reopen.

        * You don't need to edit your `Package.swift` file through Xcode,
          but Xcode provides helpful feedback.

        * If Xcode isn't updating after you make a change, try clicking
          File > Packages > Reset Package Caches.

    1. [Add dependencies][].

    2. If your package must be linked explicitly `static` or `dynamic`
       ([not recommended by Apple][]), update the [Product][] to define the
       type:

       ```swift title="Package.swift"
       products: [
           .library(name: "plugin-name-ios", type: .static, targets: ["plugin_name_ios"])
       ],
       ```

    3. Make any other customizations. For more information on how to write a
       Package.swift file, see
       [https://developer.apple.com/documentation/packagedescription](https://developer.apple.com/documentation/packagedescription).

       :::tip
       If you add additional targets to your `Package.swift` file,
       try to name them uniquely.
       If your target name conflicts with another target from another package,
       this can cause issues for developers that use your plugin.
       :::

1.  Update your `plugin_name_ios.podspec` to point to new paths.

    ```diff2html
    --- a/plugin_name_ios.podspec
    +++ b/plugin_name_ios.podspec
    @@ -21,4 +21,4 @@ 
    - s.source_files = 'Classes/**/*.{h,m}'
    - s.public_header_files = 'Classes/**/*.h'
    - s.module_map = 'Classes/cocoapods_plugin_name_ios.modulemap'
    - s.resource_bundles = {'plugin_name_ios_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
    + s.source_files = 'plugin_name_ios/Sources/plugin_name_ios/**/*.{h,m}'
    + s.public_header_files = 'plugin_name_ios/Sources/plugin_name_ios/include/**/*.h'
    + s.module_map = 'plugin_name_ios/Sources/plugin_name_ios/include/cocoapods_plugin_name_ios.modulemap'
    + s.resource_bundles = {'plugin_name_ios_privacy' => ['plugin_name_ios/Sources/plugin_name_ios/PrivacyInfo.xcprivacy']}
    ```

2.  Update loading of resources from bundle to use `SWIFTPM_MODULE_BUNDLE`:

    ```objc
    #if SWIFT_PACKAGE
       NSBundle *bundle = SWIFTPM_MODULE_BUNDLE;
     #else
       NSBundle *bundle = [NSBundle bundleForClass:[self class]];
     #endif
     NSURL *imageURL = [bundle URLForResource:@"image" withExtension:@"jpg"];
    ```

    :::note
    `SWIFTPM_MODULE_BUNDLE` will only work if there are actual resources
    (either [defined in the `Package.swift` file][Bundling resources] or
    [automatically included by Xcode][Xcode resource detection]).
    Otherwise, it will fail.
    :::

3.  If your `plugin_name_ios/Sources/plugin_name_ios/include` directory only
    contains a `.gitkeep`, you'll want update your `.gitignore` to include the
    following:

    ```text title=".gitignore"
    !.gitkeep
    ```

    Then run `flutter pub publish --dry-run` to ensure the `include` directory
    is published.

4.  Verify plugin still works with CocoaPods.

    1. Disable Swift Package Manager:

      ```sh
      flutter config --no-enable-swift-package-manager
      ```

    2. Run `flutter run` with the example app and ensure it builds and runs.

    3. Run CocoaPods validation lints:

    ```sh
    pod lib lint ios/plugin_name_ios.podspec  --configuration=Debug --skip-tests --use-modular-headers --use-libraries
    ```

    ```sh
    pod lib lint ios/plugin_name_ios.podspec  --configuration=Debug --skip-tests --use-modular-headers
    ```

5.  Verify plugin works with Swift Package Manager.

    1. Enable Swift Package Manager:

      ```sh
      flutter config --enable-swift-package-manager
      ```

    2. Run `flutter run` with the example app and ensure it builds and runs.

    3. Open the example app in Xcode and ensure Package Dependencies show
       in the left Project Navigator.

6.  Verify tests pass.

  * **If your plugin has Native unit tests (XCTest), make sure you also complete
    ["Updating unit tests in plugin example app"] below.**

  * Follow instructions for [testing plugins][].

[Swift Package Manager's documentation]: {{site.github}}/apple/swift-package-manager/blob/main/Documentation/Usage.md#creating-c-language-targets
[Add dependencies]: https://developer.apple.com/documentation/packagedescription/package/dependency
[not recommended by Apple]: https://developer.apple.com/documentation/packagedescription/product/library(name:type:targets:)
[Product]: https://developer.apple.com/documentation/packagedescription/product
[Bundling resources]: https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package#Explicitly-declare-or-exclude-resources
[Xcode resource detection]: https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package#:~:text=Xcode%20detects%20common%20resource%20types%20for%20Apple%20platforms%20and%20treats%20them%20as%20a%20resource%20automatically
["Updating unit tests in plugin example app"]: /packages-and-plugins/swift-package-manager/for-plugin-authors/#updating-unit-tests-in-plugin-example-app
[testing plugins]: https://docs.flutter.dev/testing/testing-plugins
