---
title: Set up Flutter flavors for iOS and macOS
shortTitle: Flavors (iOS and macOS)
description: >
  How to create Flutter flavors for an iOS or macOS app.
---

This guide shows you how to create Flutter flavors for an
iOS or macOS app.

## Overview

A Flutter flavor is basically a collection of settings that
define how a specific version of your app should be built
and run. For example, a flavor could determine which icon,
app name, API key, feature flag, and logging level is
associated with a specific version of your app.

If you want to create Flutter flavors for an iOS app, you'll
need to do so in Xcode. Xcode does not have a concept called
"flavor". Instead, you'll need to set up something called a
scheme and attach custom configurations to it.

The following illustrates an example of two Flutter flavors
(staging, production) as Xcode schemes with custom Xcode
configurations assigned to them:

<table class="table table-striped">
  <thead>
    <tr>
      <th>Scheme</th>
      <th>Configurations for the scheme</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>staging</td>
      <td>
        Debug-staging</br>
        Profile-staging</br>
        Release-staging</br>
      </td>
    </tr>
    <tr>
      <td>production</td>
      <td>
        Debug-production</br>
        Profile-production</br>
        Release-production</br>
      </td>
    </tr>
  </tbody>
</table>

## Configure Xcode schemes

The following steps show how to configure two Xcode schemes
called `staging` and `production` for your Flutter iOS
project. You can also use these steps to set up a
macOS project by replacing any reference to `iOS`
with `macOS`.

For a seamless workflow, we've started with a
new Flutter project called `flavors_example`, but you can
always start with an existing project.

1.  Create a new Flutter project called `flavors_example`.

    ```console title="console"
    $ flutter create flavors_example
    ```

1.  Open the default Xcode workspace for the iOS version of
    the `flavors_example` project.

    ```console title="console"
    $ cd flavors_example && open ios/Runner.xcworkspace
    ```

1.  Open the `flavors_example` project in the
    Xcode project navigator:

    * Open the **project navigator**
      (**View** > **Navigators** > **Project**).

    * In the **project navigator**, at the top, select
      **Runner**.

1.  Create schemes in Xcode:

    * Open the **New Scheme** window
      (**Product > Scheme > New Scheme**).

    * In the **Target** field, select **Runner**.

    * In the **Name** box, enter `staging`.

    * Click **Okay** to add the new scheme.

    * Repeat the previous steps for a scheme called
      `production`.

    * When finished, check to make sure that you
      have the following schemes:

      ![Schemes for Flutter flavors](/assets/images/docs/flavors/flavors-ios-schemes.png){:width="100%"}

    :::note
    By default the new schemes are shared. The schemes must
    be shared for Flutter flavors to work properly. To
    double-check that sharing is enabled, open the
    **Manage Schemes** window
    (**Product > Scheme > Manage Schemes**) and make sure
    that the **Shared** checkbox to the right of your new
    scheme is checked.
    :::

1.  Create configurations for the schemes in Xcode:

    * In the **project navigator**, select **Runner**.

    * In the main window under **PROJECT**, select
      **Runner**.

    * Open the **Info tab** if it isn’t open.

    * Go to the **Configurations** section and add new
      `Debug` configurations.

      * Click **+**, select
        **Duplicate "Debug" configuration**, and name the
        new configuration `Debug-staging`.
      * Click **+**, select
        **Duplicate "Debug" configuration**, and name the
        new configuration `Debug-production`.

    * Repeat the previous step for the
      `Release` configurations and the
      `Profile` configurations.

    * When finished, check to make sure that you
      have the following configurations:

      ![Scheme configurations for Flutter flavors](/assets/images/docs/flavors/flavors-ios-scheme-configurations.png){:width="100%"}

    :::note
    The scheme name (example: `staging`) that is appended to
    a configuration name must be lowercase if you want to
    use it with the Flutter CLI command.
    :::

    :::note
    Your configurations should be based on your
    `Debug.xconfig`, `Profile.xcconfig`, and
    `Release.xcconfig` files, not the
    `Pods-Runner.xcconfigs` file. You can check this by
    expanding the configuration names in Xcode.
    :::

1.  Assign the configurations to the schemes in Xcode:

    * Open the **Manage Schemes** window
      (**Product > Scheme > Manage Schemes**).

    * Select the `staging` scheme and edit it.

    * In the following tabs, update the
      **Build Configuration** field as follows:

      * **Run**: `Debug-staging`
      * **Test**: `Debug-staging`
      * **Profile**: `Profile-staging`
      * **Analyze**: `Debug-staging`
      * **Archive**: `Release-staging`

    * Click **Close**.

    * Repeat the previous steps for the `production` scheme.

1.  If you are working with a pre-existing Flutter project
    that has at least one Podfile, update it. For more
    information, see [Update Podfiles][].

1.  To make sure that you've set up everything correctly,
    run your app on the new schemes in Xcode. You won't see
    any differences because the configuration settings
    haven't changed, but you do want to make sure that the
    app can run.

    * Select the `staging` scheme
      (**Product > Schemes > staging**).

    * To the right of `staging` in the toolbar,
      select the iOS device you want to test against. In
      the following example, the device is `iPhone 16 Pro`.

      ![Run a Flutter flavor](/assets/images/docs/flavors/flavors-ios-test-scheme.png){:width="100%"}

    * Run the app scheme (**Product > Run**).

    * Repeat the previous steps for the `production` scheme.

1.  If everything runs, you're ready to customize your
    configurations. For more information, see
    [Customize configurations][].

[Update Podfiles]: #update-podfiles
[Customize configurations]: #customize-configurations

## Launch an Xcode scheme

After you've created the schemes for an iOS app in
Xcode, you can launch a specific scheme through Xcode or
Flutter. You can also use these steps to launch a macOS
project by replacing any reference to `iOS` with `macOS`.

### Use the flavor flag (Flutter CLI)

You can launch an Xcode scheme in `Debug` mode with the
Flutter CLI using the following steps:

1.  In your IDE, start the iOS simulator.

1.  In the console, navigate to the
    `flavors_example` directory and enter the following
    command:

    ```console title="console"
    $ flutter run --flavor <xcode_scheme_name>
    ```

    * `<xcode_scheme_name>`: Replace this with the name of
      your Xcode scheme (for example, `staging` or
      `production`).

    Example:

    ```console title="console"
    $ flutter run --flavor staging
    ```

### Use the run command (Xcode)

You can launch a specific scheme in Xcode using the
following steps:

1.  Select the scheme you want to test
    (**Product > Schemes > Choose scheme**).

1.  Next to the scheme name in the toolbar, select the
    device you want to test against.

1.  Run the scheme for your app
    (**Product > Run**).

## Customize configurations

After you've added Xcode schemes, you can customize them for
your iOS app. You can also use these steps to configure a
macOS project by replacing any reference to `iOS` with
`macOS`.

### Create distinct app display names {: #create_a_distinct_app_display_name }

If you have multiple schemes, a distinct app name can
quickly identify which scheme your deployed app is using.

<img src="/assets/images/docs/flavors/flavors-ios-app-names.png" alt="Rename a Flutter flavor" width="50%">

The following steps show how to add distinct app display
names in Xcode for two schemes called `staging` and
`production` in a project called `flavors_example`.

1.  Create user-defined settings in Xcode:

    * Open the **project navigator**
      (**View > Navigators > Project**).

    * In the **project navigator**, at the top, select
      **Runner**.

    * In the main window under **TARGETS**, select
      **Runner**.

    * Open the **Build Settings** tab.

    * To the left of the Basic tab, click **+** and select
      **Add User-Defined Setting**.

    * Create a setting named `APP_DISPLAY_NAME`.

    * Expand the **APP_DISPLAY_NAME** setting.

    * Assign the following values to the following keys:

      * **Debug-production**: `Flavors prod`
      * **Debug-staging**: `Flavors staging`
      * **Profile-production**: `Flavors prod`
      * **Profile-staging**: `Flavors staging`
      * **Release-production**: `Flavors prod`
      * **Release-staging**: `Flavors staging`

1.  Update `Info.plist` in Xcode:

    * In the project navigator, select
      **Runner > Runner > Info** to open
      `flavor_test/ios/Runner/Info.plist`.

    * Under **Information Property List**, find the
      following key and update the value for it:

      * **Key**: `CFBundleDisplayName`
      * **Value**: `$(APP_DISPLAY_NAME)`

1.  Launch the app for each scheme (`staging`, `production`)
    and check to make sure that the app display name has
    changed for each. To launch a scheme, see the steps in
    [Launch an Xcode scheme][].

[Launch an Xcode scheme]: #launch-an-xcode-scheme

### Create distinct icons

If you have multiple schemes, a distinct icon for each
configuration can help you quickly identify which scheme
your deployed app is using.

<img src="/assets/images/docs/flavors/flavors-ios-icons.png" alt="Rename a Flutter flavor" width="50%">

The following steps show how to add a distinct icon in
Xcode for two schemes called `staging` and `production` in
an iOS project called `flavors_example`.

1.  Prepare your icons:

    * Design your staging icon and production icon in the
      design tool of your choice.

    * Generate versions of the staging icon and production
      icon in the sizes that you need. Save them in
      PNG format.

      :::note
      You can use a tool like [App Icon Generator][]
      to generate the versions of your icons.
      :::

1.  Add the icons to your Xcode project:

    * Open the **project navigator**
      (**View > Navigators > Project**).

    * In the **project navigator**, select
      **Runner > Runner > Assets** to open the
      **Assets** window.

    * Complete the following steps for the staging icon:

      * Click **+  > iOS > iOS App icon**.

      * Name the icon `AppIcon-staging`.

      * Drag your staging icons into the
        **AppIcon-staging** window and make sure the icons
        are assigned to the correct sizes.

    * Repeat the previous step for the production icon.

1.  Connect the icons to your schemes:

    * Open the **project navigator**.

    * In the main window under **TARGETS**, select
      **Runner**.

    * Open the **General** tab if it's not already open.

    * Go to the **Apps Icons and Launch Screen** section and
      expand it.

    * To the right of the **App icon** field, click
      **+** and update the fields as follows:

      * **Debug-staging**: `AppIcon-staging`
      * **Profile-staging**: `AppIcon-staging`
      * **Release-staging**: `AppIcon-staging`
      * **Debug-production**: `AppIcon-production`
      * **Profile-production**: `AppIcon-production`
      * **Release-production**: `AppIcon-production`

1.  Launch the app for each scheme (`staging`, `production`)
    and check to make sure that the app icon has
    changed for each. To launch a scheme, see the steps in
    [Launch an Xcode scheme][].

[Launch an Xcode scheme]: #launch-an-xcode-scheme
[App Icon Generator]: https://www.appicon.co/

### Add distinct bundle identifiers

A bundle identifier is a unique identifier for your
application on Apple's platforms. If you are using multiple
Xcode schemes as Flutter flavors, you can have Apple treat
each scheme as a separate application. To do this, you need
to assign a different bundle identifier to each scheme.
This allows you to test new features or bug fixes in one
version of the app (for example `staging`) without affecting
another version of the app (for example, `production`).

The following steps show how to set a unique
bundle identifier for two Xcode schemes called `staging`
and `production` in an iOS project called `flavors_example`.

1.  In Xcode, open the **project navigator**
    (**View > Navigators > Project**).

1.  In the main window under **TARGETS**, select
    **Runner**.

1.  Open the **Build Settings** tab.

1.  Navigate to the **Packaging** section.

1.  Expand the **Product Bundle Identifier** setting to
    see the different build configurations.

1.  For each scheme's build configuration, set the
    desired bundle identifier. For example:

    *   Debug-staging, Profile-staging, Release-staging:

        `com.example.flavorsExample.staging`

    *   Debug, Profile, Release, Debug-production,
        Profile-production, Release-production:

        `com.example.flavorsExample`

1.  Ensure that these bundle identifiers are included in
    your App ID and your App ID is [registered in your Apple Developer account][].

[registered in your Apple Developer account]: https://developer.apple.com/help/account/identifiers/register-an-app-id/

### Bundle assets

If you have assets that are only used in a specific flavor
in your app, you can configure them to only be bundled into
your app when launching that flavor. This prevents your
app bundle size from being bloated by unused assets. To
bundle assets for each flavor, add the `flavors` subfield
to the `assets` field in your project's pubspec. To learn
more, see the [`assets` field][] in
[Flutter pubspec options][].

[`assets` field]: /tools/pubspec#assets
[Flutter pubspec options]: /tools/pubspec

### Update Podfiles

If you are creating new Xcode schemes for a Flutter iOS
project and you have an iOS Podfile in an existing
Flutter project, you must update the Flutter iOS Podfile to
match the changes you made in Xcode.

The following steps show how to update your iOS Podfile to
include two new Xcode schemes called `staging` and
`production` in a Flutter project called `flavors_example`.
You can also use these steps to update a macOS
project by replacing any reference to `iOS` with `macOS`.

1. In your IDE, open the `ios/Podfile` file.
1. Make the following updates and save your changes.

    ```ruby title="flavors_example/ios/Podfile"
    project 'Runner', {
      ...
      'Debug' => :debug,
      'Debug-staging' => :debug,
      'Debug-production' => :debug,
      'Profile' => :release,
      'Profile-staging' => :release,
      'Profile-production' => :release,
      'Release' => :release,
      'Release-staging' => :release,
      'Release-production' => :release,
      ...
    ```

### Add unique build settings

You can use [build settings][] to govern your iOS build
process from compilation and linking to debugging and
distribution. One way that you can use build settings
with Flutter flavors is to assign those build settings
to Xcode build configurations. For example, you might want
to assign different API URLs to  `Debug-staging` and
`Debug-production`. For example:

```plaintext title="debug-staging-settings.xcconfig"
# Debug-staging build settings
API_BASE_URL = staging.flavors.com/api
```

```plaintext title="debug-production-settings.xcconfig"
# Debug-production build settings
API_BASE_URL = flavors.com/api
```

If you would like to add additional build settings for
a specific build configuration, see Apple's
[Adding a build configuration file to your project][].

[build settings]: https://developer.apple.com/documentation/xcode/build-settings-reference/
[Adding a build configuration file to your project]: https://developer.apple.com/documentation/xcode/adding-a-build-configuration-file-to-your-project

### Add additional customizations

This document contains a few common Xcode scheme
configurations, but there are many more that you can apply.
To learn about them, see
[Customizing the build schemes for a project][].

[Customizing the build schemes for a project]: https://developer.apple.com/documentation/xcode/customizing-the-build-schemes-for-a-project

## More information

For more information on creating and using flavors, check
out the following resources:

* [How to Setup Flutter & Firebase with Multiple Flavors
  using the FlutterFire CLI][flutterfireCLI]
* [Build flavors in Flutter (Android and iOS) with different
  Firebase projects per flavor Flutter Ready to Go][flavors-firebase]

[flutterfireCLI]: https://codewithandrea.com/articles/flutter-firebase-multiple-flavors-flutterfire-cli/
[flavors-firebase]: {{site.medium}}/@animeshjain/build-flavors-in-flutter-android-and-ios-with-different-firebase-projects-per-flavor-27c5c5dac10b
