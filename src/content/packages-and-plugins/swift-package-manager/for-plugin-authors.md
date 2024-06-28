---
title: Swift Package Manager for plugin authors
description: How to add Swift Package Manager compatibility to iOS and macOS plugins
---

Flutter is migrating to Swift Package Manager to manage iOS and macOS native dependencies.
This is an experimental feature that may change in the future.
It is currently only available on the [`master` channel](https://docs.flutter.dev/release/upgrade#switching-flutter-channels).
Flutter will continue to support CocoaPods until further notice.

Swift Package Manager adoption will be gradual.

Flutter recommends that Flutter plugins support _both_ Swift Package Manager
and CocoaPods until further notice.

:::tip
If you find a bug in Flutter's Swift Package Manager feature,
please [open an issue](https://github.com/flutter/flutter/issues/new?template=2_bug.yml).
:::

{% include docs/swift-package-manager/how-to-enable-disable.md %}

## Adding Swift Package Manager support to an existing Flutter plugin

{% tabs %}
{% tab "Objective-C" %}

Replace `plugin_name` throughout this guide with the name of your plugin.
The below example uses `ios`, replace `ios` with `macos`/`darwin` as applicable.

1. Enable the Swift Package Manager feature.

2. Start by creating a directory under the `ios`, `macos`, and/or `darwin` directories.
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
      - Needed to ensure the directory is committed, even if empty. Can be removed if files are added to the directory.

<pre>
/plugin_name/plugin_name_ios/ios/plugin_name_ios/<b>Package.swift</b>
/plugin_name/plugin_name_ios/ios/plugin_name_ios/<b>Sources</b>
/plugin_name/plugin_name_ios/ios/plugin_name_ios/<b>Sources/plugin_name_ios</b>
/plugin_name/plugin_name_ios/ios/plugin_name_ios/<b>Sources/plugin_name_ios/include</b>
/plugin_name/plugin_name_ios/ios/plugin_name_ios/<b>Sources/plugin_name_ios/include/plugin_name_ios</b>
/plugin_name/plugin_name_ios/ios/plugin_name_ios/<b>Sources/plugin_name_ios/include/plugin_name_ios/.gitkeep</b>
</pre>

4. Use the following template in the `Package.swift`

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

* **If the plugin name contains `_`, the library name must be a `-` separated version of the plugin name.**
5. If your plugin has a `PrivacyInfo.xcprivacy`, move it to `Sources/plugin_name_ios/PrivacyInfo.xcprivacy` and uncomment the resource in the Package.swift.

```diff title="Package.swift"
            resources: [
                // If your plugin requires a privacy manifest, for example if it uses any required
                // reason APIs, update the PrivacyInfo.xcprivacy file to describe your plugin's
                // privacy impact, and then uncomment these lines. For more information, see
                // https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
-                // .process("PrivacyInfo.xcprivacy"),
+                .process("PrivacyInfo.xcprivacy"),

                // If you have other resources that need to be bundled with your plugin, refer to
                // the following instructions to add them:
                // https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package
            ],
```
6. Move any resource files from `ios/Assets` to `Sources/plugin_name_ios` (or a subdirectory). Then add them to your Package.swift if applicable. See https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package for more instructions.
7. Move any public headers from `ios/Classes` to `Sources/plugin_name_ios/include/plugin_name_ios`
    * If you're unsure which headers are public, check your `podspec` for `public_header_files`. If not found, that means all of your headers were public. You should consider whether or not you want all of your headers to be public.
    * The `pluginClass` defined in your pubspec.yaml must be public and within this directory.
8. Handling modulemap (skip this step if not using a custom modulemap)

    If you're using a modulemap for CocoaPods to create a Test submodule, consider removing it for Swift Package Manager. Note that this will make all public headers available via the module.

    To remove the modulemap for Swift Package Manager but keep it for CocoaPods, exclude the modulemap and umbrella header in the plugin's Package.swift. The example below assumes they are located within the `Sources/plugin_name_ios/include` directory.

    ```diff title="Package.swift"
            .target(
                name: "plugin_name_ios",
                dependencies: [],
    +           exclude: ["include/cocoapods_plugin_name_ios.modulemap", "include/plugin_name_ios-umbrella.h"],
    ```

    If you want to keep your unit tests compatible with both CocoaPods and Swift Package Manager, you can try the following:
    ```diff
    @import plugin_name_ios;
    - @import plugin_name_ios.Test;
    + #if __has_include(<plugin_name_ios/plugin_name_ios-umbrella.h>)
    +   @import plugin_name_ios.Test;
    + #endif
    ```

    If you would like to use a custom modulemap with your Swift package,
    please refer to [Swift Package Manager's documentation](https://github.com/apple/swift-package-manager/blob/main/Documentation/Usage.md#creating-c-language-targets).

9. Move all remaining files from `ios/Classes` to `Sources/plugin_name_ios`
10. `ios/Assets`, `ios/Resources`, `ios/Classes` should now be empty and can be deleted
11. If your header files were previously within the same directory as your implementation files, you may need to change your import statements.

    For example, if the following changes were made:
    * `ios/Classes/PublicHeaderFile.h` --> `Sources/plugin_name_ios/include/plugin_name_ios/PublicHeaderFile.h`
    * `ios/Classes/ImplementationFile.m` --> `Sources/plugin_name_ios/ImplementationFile.m`

    Within `ImplementationFile.m`, the import would change:
    ```diff
    - #import "PublicHeaderFile.h"
    + #import "./include/plugin_name_ios/PublicHeaderFile.h"
    ```

12. If using pigeon, you'll want to update your pigeon input file

    ```diff
    - objcHeaderOut: 'ios/Classes/messages.g.h',
    + objcHeaderOut: 'ios/plugin_name_ios/Sources/plugin_name_ios/messages.g.h',
    - objcSourceOut: 'ios/Classes/messages.g.m',
    + objcSourceOut: 'ios/plugin_name_ios/Sources/plugin_name_ios/messages.g.m',
    ```

    If your `objcHeaderOut` file is no longer within the same directory as the `objcSourceOut`, you can change the `#import` using `ObjcOptions.headerIncludePath`:

    ```diff
    objcHeaderOut: 'ios/plugin_name_ios/Sources/plugin_name_ios/include/plugin_name_ios/messages.g.h',
    objcSourceOut: 'ios/plugin_name_ios/Sources/plugin_name_ios/messages.g.m',
    + objcOptions: ObjcOptions(
    +   headerIncludePath: './include/plugin_name_ios/messages.g.h',
    + ),
    ```

13. Update your Package.swift with any customizations you may need
    1. Open `/plugin_name/plugin_name_ios/ios/plugin_name_ios/` in Xcode
        * If package does not show any files in Xcode, quit Xcode (Xcode > Quit Xcode) and reopen
        * You don't need to edit your Package.swift through Xcode, but Xcode will provide helpful feedback
        * If Xcode isn't updating after you make a change, try clicking File > Packages > Reset Package Caches
    2. [Add dependencies](https://developer.apple.com/documentation/packagedescription/package/dependency)
    3. If your package must be linked explicitly `static` or `dynamic` ([not recommended](https://developer.apple.com/documentation/packagedescription/product/library(name:type:targets:))), update the [Product](https://developer.apple.com/documentation/packagedescription/product) to define the type
    ```swift title="Package.swift"
    products: [
        .library(name: "plugin-name-ios", type: .static, targets: ["plugin_name_ios"])
    ],
    ```
    4. Make any other customizations - see https://developer.apple.com/documentation/packagedescription for more info on how to write a Package.swift.
    5. If you add additional targets to your Package.swift, try to name them uniquely. If your target name conflicts with another target from another package, this can cause issues that may require manual intervention to be able to use your plugin.

14. Update your `plugin_name_ios.podspec` to point to new paths.
```diff title="plugin_name_ios.podspec"
- s.source_files = 'Classes/**/*.{h,m}'
+ s.source_files = 'plugin_name_ios/Sources/plugin_name_ios/**/*.{h,m}'

- s.public_header_files = 'Classes/**/*.h'
+ s.public_header_files = 'plugin_name_ios/Sources/plugin_name_ios/include/**/*.h'

- s.module_map = 'Classes/cocoapods_plugin_name_ios.modulemap'
+ s.module_map = 'plugin_name_ios/Sources/plugin_name_ios/include/cocoapods_plugin_name_ios.modulemap'

- s.resource_bundles = {'plugin_name_ios_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
+ s.resource_bundles = {'plugin_name_ios_privacy' => ['plugin_name_ios/Sources/plugin_name_ios/PrivacyInfo.xcprivacy']}
```

15. Update getting of resources from bundle to use `SWIFTPM_MODULE_BUNDLE`
```objc
#if SWIFT_PACKAGE
   NSBundle *bundle = SWIFTPM_MODULE_BUNDLE;
 #else
   NSBundle *bundle = [NSBundle bundleForClass:[self class]];
 #endif
 NSURL *imageURL = [bundle URLForResource:@"image" withExtension:@"jpg"];
```
  * Note: `SWIFTPM_MODULE_BUNDLE` will only work if there are actual resources (either [defined in the Package.swift](https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package#Explicitly-declare-or-exclude-resources) or [automatically included by Xcode](https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package#:~:text=Xcode%20detects%20common%20resource%20types%20for%20Apple%20platforms%20and%20treats%20them%20as%20a%20resource%20automatically)). Otherwise, it will fail.

16. If your `plugin_name_ios/Sources/plugin_name_ios/include` directory only contains a `.gitkeep`,
    you'll want update your `.gitignore` to include the following:

    ```txt title=".gitignore"
    !.gitkeep
    ```

    Then run `flutter pub publish --dry-run` to ensure the `include` directory will be published.

17. Verify plugin still works with CocoaPods
    1. Disable Swift Package Manager
      ```sh
      flutter config --no-enable-swift-package-manager
      ```
    2. Run `flutter run` with the example app and ensure it builds and runs
    3. Run CocoaPods validation lints
    ```sh
    pod lib lint ios/plugin_name_ios.podspec  --configuration=Debug --skip-tests --use-modular-headers --use-libraries
    ```
    ```sh
    pod lib lint ios/plugin_name_ios.podspec  --configuration=Debug --skip-tests --use-modular-headers
    ```
18. Verify plugin works with Swift Package Manager
    1. Enable Swift Package Manager
      ```sh
      flutter config --enable-swift-package-manager
      ```
    2. Run `flutter run` with the example app and ensure it builds and runs
    3. Open the example app in Xcode and ensure Package Dependencies show in the left Project Navigator

19. Verify tests pass
  * **If your plugin has Native unit tests (XCTest), make sure you also complete "Updating unit tests in plugin example app" below.**
  * [Follow instructions for testing plugins](https://docs.flutter.dev/testing/testing-plugins)

{% endtab %}
{% tab "Swift" %}

Replace `plugin_name` throughout this guide with the name of your plugin.
The below example uses `ios`, replace `ios` with `macos`/`darwin` as applicable.

1. Enable the Swift Package Manager feature.

2. Start by creating a directory under the `ios`, `macos`, and/or `darwin` directories. Name this new directory the name of the platform package.

<pre>
/plugin_name/plugin_name_ios/ios/<b>plugin_name_ios</b>
</pre>

3. Within this new directory, create the following files/directories:
    - Package.swift (file)
    - Sources (directory)
    - Sources/plugin_name_ios (directory)

<pre>
/plugin_name/plugin_name_ios/ios/plugin_name_ios/<b>Package.swift</b>
/plugin_name/plugin_name_ios/ios/plugin_name_ios/<b>Sources</b>
/plugin_name/plugin_name_ios/ios/plugin_name_ios/<b>Sources/plugin_name_ios</b>
</pre>

4. Use the following template in the `Package.swift`
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
            ]
        )
    ]
)
```

* **If the plugin name contains `_`, the library name must be a `-` separated version of the plugin name.**

5. If your plugin has a `PrivacyInfo.xcprivacy`, move it to `Sources/plugin_name_ios/PrivacyInfo.xcprivacy` and uncomment the resource in the Package.swift.
```diff
            resources: [
                // If your plugin requires a privacy manifest, for example if it uses any required
                // reason APIs, update the PrivacyInfo.xcprivacy file to describe your plugin's
                // privacy impact, and then uncomment these lines. For more information, see
                // https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
-                // .process("PrivacyInfo.xcprivacy"),
+                .process("PrivacyInfo.xcprivacy"),

                // If you have other resources that need to be bundled with your plugin, refer to
                // the following instructions to add them:
                // https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package
            ],
```
6. Move any resource files from `ios/Assets` to `Sources/plugin_name_ios` (or a subdirectory). Then add them to your Package.swift if applicable. See https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package for more instructions.
7. Move all files from `ios/Classes` to `Sources/plugin_name_ios`
8. `ios/Assets`, `ios/Resources`, `ios/Classes` should now be empty and can be deleted
9. If using pigeon, you'll want to update your pigeon input file
```diff
- swiftOut: 'ios/Classes/messages.g.swift',
+ swiftOut: 'ios/plugin_name_ios/Sources/plugin_name_ios/messages.g.swift',
```

10. Update your Package.swift with any customizations you may need
    1. Open `/plugin_name/plugin_name_ios/ios/plugin_name_ios/` in Xcode
        * If package does not show any files in Xcode, quit Xcode (Xcode > Quit Xcode) and reopen
        * You don't need to edit your Package.swift through Xcode, but Xcode will provide helpful feedback
        * If Xcode isn't updating after you make a change, try clicking File > Packages > Reset Package Caches
    2. [Add dependencies](https://developer.apple.com/documentation/packagedescription/package/dependency)
    3. If your package must be linked explicitly `static` or `dynamic`, update the [Product](https://developer.apple.com/documentation/packagedescription/product) to define the type
    ```swift title="Package.swift"
    products: [
        .library(name: "plugin-name-ios", type: .static, targets: ["plugin_name_ios"])
    ],
    ```
    4. Make any other customizations - see https://developer.apple.com/documentation/packagedescription for more info on how to write a Package.swift.
    5. If you add additional targets to your Package.swift, try to name them uniquely. If your target name conflicts with another target from another package, this can cause issues that may require manual intervention to be able to use your plugin.
11. Update your `plugin_name_ios.podspec` to point to new paths.
```diff
- s.source_files = 'Classes/**/*.swift'
+ s.source_files = 'plugin_name_ios/Sources/plugin_name_ios/**/*.swift'

- s.resource_bundles = {'plugin_name_ios_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
+ s.resource_bundles = {'plugin_name_ios_privacy' => ['plugin_name_ios/Sources/plugin_name_ios/PrivacyInfo.xcprivacy']}
```

12. Update getting of resources from bundle to use `Bundle.module`
```swift
#if SWIFT_PACKAGE
     let settingsURL = Bundle.module.url(forResource: "image", withExtension: "jpg")
#else
     let settingsURL = Bundle(for: Self.self).url(forResource: "image", withExtension: "jpg")
#endif
```
  * Note: `Bundle.module` will only work if there are actual resources (either [defined in the Package.swift](https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package#Explicitly-declare-or-exclude-resources) or [automatically included by Xcode](https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package#:~:text=Xcode%20detects%20common%20resource%20types%20for%20Apple%20platforms%20and%20treats%20them%20as%20a%20resource%20automatically)). Otherwise, it will fail.
13. Verify plugin still works with CocoaPods
    1. Disable Swift Package Manager
    ```sh
    flutter config --no-enable-swift-package-manager
    ```
    2. Run `flutter run` with the example app and ensure it builds and runs
    3. Run CocoaPods validation lints
    ```sh
    pod lib lint ios/plugin_name_ios.podspec  --configuration=Debug --skip-tests --use-modular-headers --use-libraries
    ```
    ```sh
    pod lib lint ios/plugin_name_ios.podspec  --configuration=Debug --skip-tests --use-modular-headers
    ```
14. Verify plugin works with Swift Package Manager
    1. Enable Swift Package Manager
    ```sh
    flutter config --enable-swift-package-manager
    ```
    2. Run `flutter run` with the example app and ensure it builds and runs
    3. Open the example app in Xcode and ensure Package Dependencies show in the left Project Navigator
15. Verify tests pass
  * **If your plugin has Native unit tests (XCTest), make sure you also complete "Updating unit tests in plugin example app" below.**
  * [Follow instructions for testing plugins](https://docs.flutter.dev/testing/testing-plugins)
</details>

## Updating unit tests in plugin example app

If your plugin has native XCTests, you may need to update them to work with Swift Package Manager if one of the following is true:
  * You're using a CocoaPod dependency for the test
  * Your plugin is explicitly set to `type: .dynamic` in its Package.swift

1. Open your `example/ios/Runner.xcworkspace` in Xcode
2. If you were using a CocoaPod dependency for tests, such as `OCMock`, you'll want to remove it from your Podfile

```diff title="plugin_name_ios.podspec"
target 'RunnerTests' do
  inherit! :search_paths
-  pod 'OCMock', '3.5'
end`
```

Then in the terminal, run `pod install` in the `plugin_name_ios/example/ios` directory

3. Navigate to Package Dependencies for the project

![Screenshot 2024-04-05 at 10 13 56 AM](https://github.com/flutter/flutter/assets/15619084/0d862f5f-8bff-41df-9cf4-3f56b1957230)

4. Click the `+` button and add any test-only dependencies by searching for them in the top right search bar.

![Screenshot 2024-04-09 at 3 11 21 PM](https://github.com/flutter/flutter/assets/15619084/9e88c220-97d6-48f8-91ce-0b0ce72f50fa)

Note: OCMock uses unsafe build flags and can only be used if targeted by commit. `fe1661a3efed11831a6452f4b1a0c5e6ddc08c3d` is the commit for the 3.9.3 version.

5. Ensure it is added to the `RunnerTests` Target and click the `Add Package` button

![Screenshot 2024-04-09 at 3 12 12 PM](https://github.com/flutter/flutter/assets/15619084/06424d39-e317-4360-8b99-571fd3f046f2)

6. If you've explicitly set your plugin's library type to `.dynamic` in its Package.swift ([not recommended](https://developer.apple.com/documentation/packagedescription/product/library(name:type:targets:))), you'll also need to add it as a dependency to the `RunnerTests` target.
   1. First, ensure `RunnerTests` has a `Link Binary With Libraries` Build Phase
   ![Screenshot 2024-04-19 at 3 14 56 PM](https://github.com/flutter/flutter/assets/15619084/64a050f1-c1e0-4ed5-a2fc-87002d3bf72b)

   2. If it does not already exist, create one by selecting the `+` button and selecting `New Link Binary With Libraries Phase`
   ![Screenshot 2024-04-19 at 3 13 01 PM](https://github.com/flutter/flutter/assets/15619084/0ca159c1-8b57-4789-aad6-d7020a1907a0)

   3. Navigate to Package Dependencies for the project
   4. Click the `+` button
   5. Click the `Add Local...` button on the bottom of the dialog that opens
   6. Navigate to `plugin_name/plugin_name_ios/ios/plugin_name_ios` and click the `Add Package` button
   7. Ensure it is added to the `RunnerTests` target and click the `Add Package` button

7. Ensure tests pass Product > Test

{% endtab %}
{% endtabs %}
