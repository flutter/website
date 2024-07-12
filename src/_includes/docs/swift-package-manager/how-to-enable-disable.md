## How to enable Swift Package Manager

Flutter's Swift Package Manager support is disabled by default.
To enable it:

1. Switch to Flutter's `main` channel:

   ```sh
   flutter channel main
   flutter upgrade
   ```

2. Enable the Swift Package Manager feature:

   ```sh
   flutter config --enable-swift-package-manager
   ```

Running an app using the Flutter CLI migrates it to add Swift Package Manager
integration.
This makes your project download the Swift packages that
your Flutter plugins depend on.

:::note
Flutter falls back to CocoaPods for dependencies that do not support Swift
Package Manager yet.
:::

## How to disable Swift Package Manager

:::secondary Plugin authors
Plugin authors need to disable and enable Flutter's Swift Package Manager
support for testing.
Otherwise, you likely won't need to disable this.

If you find a bug in Flutter's Swift Package Manager support,
please [open an issue][].
:::

Disabling Swift Package Manager causes Flutter to use CocoaPods for all
dependencies.
However, Swift Package Manager remains integrated with your project.
To remove this integration,
follow the [How to remove Swift Package Manager integration][removeSPM]
instructions.

### Disable for a single project

In the project's `pubspec.yaml` file, under the `flutter` section,
add `disable-swift-package-manager: true`.

```yaml title="pubspec.yaml"
# The following section is specific to Flutter packages.
flutter:
  disable-swift-package-manager: true
```

This disables Swift Package Manager for all contributors to this project.

### Disable globally for all projects

Run the following command:

```sh
flutter config --no-enable-swift-package-manager
```

This disables Swift Package Manager for the current user.

If a project is incompatible with Swift Package Manager, all contributors
need to run this command. 

[removeSPM]: /packages-and-plugins/swift-package-manager/for-app-developers#how-to-remove-swift-package-manager-integration
[open an issue]: {{site.github}}/flutter/flutter/issues/new?template=2_bug.yml
