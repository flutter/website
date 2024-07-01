---
title: Swift Package Manager for plugin authors
description: How to add Swift Package Manager compatibility to iOS and macOS plugins
diff2html: true
---

Flutter is migrating to [Swift Package Manager][] to manage iOS and macOS native
dependencies.
This is an experimental feature that may change in the future.
It is currently only available on the [`master` channel][].
Flutter will continue to support CocoaPods until further notice.

Swift Package Manager adoption will be gradual.

Flutter recommends that Flutter plugins support _both_ Swift Package Manager
and CocoaPods until further notice.

:::tip
If you find a bug in Flutter's Swift Package Manager feature,
please [open an issue][].
:::

[Swift Package Manager]: https://www.swift.org/documentation/package-manager/
[`master` channel]: /release/upgrade#switching-flutter-channels
[open an issue]: {{site.github}}/flutter/flutter/issues/new?template=2_bug.yml

{% include docs/swift-package-manager/how-to-enable-disable.md %}

## Adding Swift Package Manager support to an existing Flutter plugin

{% tabs %}
{% tab "Swift plugin" %}

{% include docs/swift-package-manager/migrate-swift-plugin.md %}

{% endtab %}
{% tab "Objective-C plugin" %}

{% include docs/swift-package-manager/migrate-objective-c-plugin.md %}

{% endtab %}
{% endtabs %}

## Updating unit tests in plugin example app

If your plugin has native XCTests, you may need to update them to work with
Swift Package Manager if one of the following is true:

* You're using a CocoaPod dependency for the test.
* Your plugin is explicitly set to `type: .dynamic` in its Package.swift file.

To update your unit tests:

1. Open your `example/ios/Runner.xcworkspace` in Xcode.

2. If you were using a CocoaPod dependency for tests, such as `OCMock`,
   you'll want to remove it from your Podfile.

   ```diff2html
   --- a/ios/Podfile
   +++ b/ios/Podfile
   @@ -33,7 +33,6 @@ target 'Runner' do
      target 'RunnerTests' do
        inherit! :search_paths
   
   -    pod 'OCMock', '3.5'
      end
    end
   ```

   Then in the terminal, run `pod install` in the `plugin_name_ios/example/ios`
   directory.

3. Navigate to Package Dependencies for the project.

   {% render docs/captioned-image.liquid,
   image:"development/packages-and-plugins/swift-package-manager/package-dependencies.png",
   caption:"The project's package dependencies" %}

4. Click the `+` button and add any test-only dependencies by searching for them
   in the top right search bar.

   {% render docs/captioned-image.liquid,
   image:"development/packages-and-plugins/swift-package-manager/search-for-ocmock.png",
   caption:"Search for test-only dependencies" %}

   :::note
   OCMock uses unsafe build flags and can only be used if targeted by commit.
   `fe1661a3efed11831a6452f4b1a0c5e6ddc08c3d` is the commit for the 3.9.3
   version.
   :::

5. Ensure the dependency is added to the `RunnerTests` Target and click the
   `Add Package` button.

   {% render docs/captioned-image.liquid,
   image:"development/packages-and-plugins/swift-package-manager/choose-package-products-test.png",
   caption:"Ensure the dependency is added to the `RunnerTests` target" %}

6. If you've explicitly set your plugin's library type to `.dynamic` in its
   Package.swift file
   ([not recommended by Apple][library type recommendations]),
   you'll also need to add it as a dependency to the `RunnerTests` target.

   1. First, ensure `RunnerTests` has a `Link Binary With Libraries` Build
      Phase.
   
      {% render docs/captioned-image.liquid,
      image:"development/packages-and-plugins/swift-package-manager/runner-tests-link-binary-with-libraries.png",
      caption:"The `Link Binary With Libraries` Build Phase in the `RunnerTests` target" %}

   2. If it does not already exist, create one by selecting the `+` button and
      selecting `New Link Binary With Libraries Phase`.

      {% render docs/captioned-image.liquid,
      image:"development/packages-and-plugins/swift-package-manager/add-runner-tests-link-binary-with-libraries.png",
      caption:"Add `Link Binary With Libraries` Build Phase" %}

   3. Navigate to Package Dependencies for the project.

   4. Click the `+` button.

   5. Click the `Add Local...` button on the bottom of the dialog that opens.

   6. Navigate to `plugin_name/plugin_name_ios/ios/plugin_name_ios` and click
      the `Add Package` button.

   7. Ensure it is added to the `RunnerTests` target and click the `Add Package`
      button.

7. Ensure tests pass Product > Test.

[library type recommendations]: https://developer.apple.com/documentation/packagedescription/product/library(name:type:targets:)