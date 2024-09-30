---
title: Swift Package Manager for plugin authors
description: How to add Swift Package Manager compatibility to iOS and macOS plugins
---

:::warning
Flutter is migrating to [Swift Package Manager][]
to manage iOS and macOS native dependencies.
Flutter's support of Swift Package Manager is under development.
If you find a bug in Flutter's Swift Package Manager support,
[open an issue][].
Swift Package Manager support is [off by default][].
Flutter continues to support CocoaPods.
:::

Flutter's Swift Package Manager integration has several benefits:

1. **Provides access to the Swift package ecosystem**.
   Flutter plugins can use the growing ecosystem of [Swift packages][]! 
1. **Simplifies Flutter installation**.
   Swift Package Manager is bundled with Xcode.
   In the future, you won’t need to install Ruby and CocoaPods to target iOS or
   macOS.


[Swift Package Manager]: https://www.swift.org/documentation/package-manager/
[off by default]: #how-to-turn-on-swift-package-manager
[Swift packages]: https://swiftpackageindex.com/
[open an issue]: {{site.github}}/flutter/flutter/issues/new?template=2_bug.yml

{% include docs/swift-package-manager/how-to-enable-disable.md %}

## How to add Swift Package Manager support to an existing Flutter plugin

This guide shows how to add Swift Package Manager support to a plugin that
already supports CocoaPods.
This ensures the plugin is usable by all Flutter projects.

Flutter plugins should support _both_ Swift Package Manager and CocoaPods until
further notice.

Swift Package Manager adoption will be gradual.
Plugins that don't support CocoaPods won't be usable by projects that haven't
migrated to Swift Package Manager yet.
Plugins that don't support Swift Package Manager can cause problems for projects
that have migrated.


{% tabs %}
{% tab "Swift plugin" %}

{% include docs/swift-package-manager/migrate-swift-plugin.md %}

{% endtab %}
{% tab "Objective-C plugin" %}

{% include docs/swift-package-manager/migrate-objective-c-plugin.md %}

{% endtab %}
{% endtabs %}

## How to update unit tests in a plugin's example app

If your plugin has native XCTests, you might need to update them to work with
Swift Package Manager if one of the following is true:

* You're using a CocoaPod dependency for the test.
* Your plugin is explicitly set to `type: .dynamic` in its `Package.swift` file.

To update your unit tests:

1. Open your `example/ios/Runner.xcworkspace` in Xcode.

1. If you were using a CocoaPod dependency for tests, such as `OCMock`,
   you'll want to remove it from your `Podfile` file.

   ```ruby title="ios/Podfile" diff
     target 'RunnerTests' do
       inherit! :search_paths
   
   -   pod 'OCMock', '3.5'
     end
   ```

   Then in the terminal, run `pod install` in the `plugin_name_ios/example/ios`
   directory.

1. Navigate to **Package Dependencies** for the project.

   {% render docs/captioned-image.liquid,
   image:"development/packages-and-plugins/swift-package-manager/package-dependencies.png",
   caption:"The project's package dependencies" %}

1. Click the **+** button and add any test-only dependencies by searching for
   them in the top right search bar.

   {% render docs/captioned-image.liquid,
   image:"development/packages-and-plugins/swift-package-manager/search-for-ocmock.png",
   caption:"Search for test-only dependencies" %}

   :::note
   OCMock uses unsafe build flags and can only be used if targeted by commit.
   `fe1661a3efed11831a6452f4b1a0c5e6ddc08c3d` is the commit for the 3.9.3
   version.
   :::

1. Ensure the dependency is added to the `RunnerTests` Target.

   {% render docs/captioned-image.liquid,
   image:"development/packages-and-plugins/swift-package-manager/choose-package-products-test.png",
   caption:"Ensure the dependency is added to the `RunnerTests` target" %}

1. Click the **Add Package** button.

1. If you've explicitly set your plugin's library type to `.dynamic` in its
   `Package.swift` file
   ([not recommended by Apple][library type recommendations]),
   you'll also need to add it as a dependency to the `RunnerTests` target.

   1. Ensure `RunnerTests` **Build Phases** has a **Link Binary With Libraries**
      build phase:
   
      {% render docs/captioned-image.liquid,
      image:"development/packages-and-plugins/swift-package-manager/runner-tests-link-binary-with-libraries.png",
      caption:"The `Link Binary With Libraries` Build Phase in the `RunnerTests` target" %}

      If the build phase doesn't exist already, create one.
      Click the <span class="material-symbols-outlined">add</span> and
      then click **New Link Binary With Libraries Phase**.

      {% render docs/captioned-image.liquid,
      image:"development/packages-and-plugins/swift-package-manager/add-runner-tests-link-binary-with-libraries.png",
      caption:"Add `Link Binary With Libraries` Build Phase" %}

   1. Navigate to **Package Dependencies** for the project.

   1. Click <span class="material-symbols-outlined">add</span>.

   1. In the dialog that opens, click the **Add Local...** button.

   1. Navigate to `plugin_name/plugin_name_ios/ios/plugin_name_ios` and click
      the **Add Package** button.

   1. Ensure that it's added to the `RunnerTests` target and click the
      **Add Package** button.

1. Ensure tests pass **Product > Test**.

[library type recommendations]: https://developer.apple.com/documentation/packagedescription/product/library(name:type:targets:)
