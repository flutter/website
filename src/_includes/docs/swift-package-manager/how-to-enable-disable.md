## How to enable Swift Package Manager

Flutter's Swift Package Manager feature is disabled by default.
To enable it:

1. Switch to Flutter's `master` channel:

   ```sh
   flutter channel master
   flutter upgrade
   ```

2. Enable the Swift Package Manager feature:

   ```sh
   flutter config --enable-swift-package-manager
   ```

Running an app using the Flutter CLI will migrate it to add Swift Package
Manager support.
This makes your project download the Swift packages that
your Flutter plugins depend on.

:::note
Flutter will fallback to CocoaPods for dependencies that do not support Swift
Package Manager yet.
:::

## How to disable Swift Package Manager

Disabling Swift Package Manager will cause Flutter to use CocoaPods for all
dependencies.
However, Swift Package Manager will remain integrated with your project.
To remove this integration,
follow the ["How to remove Swift Package Manager integration"][] instructions.

:::tip
If you find a bug in Flutter's Swift Package Manager feature,
please [open an issue][].
:::

### Disable for a single project

In the project's pubspec.yaml, under the `flutter` section,
add `disable-swift-package-manager: true`.

```yaml title="pubspec.yaml"
# The following section is specific to Flutter packages.
flutter:
  disable-swift-package-manager: true
```

### Disable globally for all projects

Run the following command:

```sh
flutter config --no-enable-swift-package-manager
```

["How to remove Swift Package Manager integration"]: /packages-and-plugins/swift-package-manager/for-app-developers#how-to-remove-swift-package-manager-integration
[open an issue]: {{site.github}}/flutter/flutter/issues/new?template=2_bug.yml