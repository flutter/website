## How to turn on Swift Package Manager

Flutter's Swift Package Manager support is turned off by default.
To turn it on:

1. Upgrade to the latest Flutter SDK:

   ```sh
   flutter upgrade
   ```

1. Turn on the Swift Package Manager feature:

   ```sh
   flutter config --enable-swift-package-manager
   ```

Using the Flutter CLI to run an app [migrates the project][addSPM] to add
Swift Package Manager integration.
This makes your project download the Swift packages that
your Flutter plugins depend on.
An app with Swift Package Manager integration requires Flutter version 3.24 or
higher.
To use an older Flutter version,
you will need to [remove Swift Package Manager integration][removeSPM]
from the app.

Flutter falls back to CocoaPods for dependencies that do not support Swift
Package Manager yet.

## How to turn off Swift Package Manager

:::secondary Plugin authors
Plugin authors need to turn on and off Flutter's Swift Package Manager
support for testing.
App developers do not need to disable Swift Package Manager support,
unless they are running into issues.

If you find a bug in Flutter's Swift Package Manager support,
[open an issue][].
:::

Disabling Swift Package Manager causes Flutter to use CocoaPods for all
dependencies.
However, Swift Package Manager remains integrated with your project.
To remove Swift Package Manager integration completely from your project,
follow the [How to remove Swift Package Manager integration][removeSPM]
instructions.

### Turn off for a single project

In the project's `pubspec.yaml` file, under the `flutter` section,
add `disable-swift-package-manager: true`.

```yaml title="pubspec.yaml"
# The following section is specific to Flutter packages.
flutter:
  disable-swift-package-manager: true
```

This turns off Swift Package Manager for all contributors to this project.

### Turn off globally for all projects

Run the following command:

```sh
flutter config --no-enable-swift-package-manager
```

This turns off Swift Package Manager for the current user.

If a project is incompatible with Swift Package Manager, all contributors
need to run this command. 

[addSPM]: /packages-and-plugins/swift-package-manager/for-app-developers/#how-to-add-swift-package-manager-integration
[removeSPM]: /packages-and-plugins/swift-package-manager/for-app-developers#how-to-remove-swift-package-manager-integration
[open an issue]: {{site.github}}/flutter/flutter/issues/new?template=2_bug.yml
