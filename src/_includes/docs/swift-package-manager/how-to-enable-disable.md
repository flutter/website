## How to turn off Swift Package Manager

:::secondary Plugin authors
Plugin authors need to turn off and on Flutter's Swift Package Manager
support for testing.
App developers do not need to turn off Swift Package Manager support
unless they are running into issues.

If you find a bug in Flutter's Swift Package Manager support,
[open an issue][].
:::

Flutter's Swift Package Manager support is on by default.
Turning off Swift Package Manager causes Flutter to use CocoaPods for all
dependencies.
However, Swift Package Manager remains integrated with your project.
To remove Swift Package Manager integration completely from your project,
follow the [How to remove Swift Package Manager integration][]
instructions.

[open an issue]: {{site.github}}/flutter/flutter/issues/new?template=2_bug.yml
[How to remove Swift Package Manager integration]: /packages-and-plugins/swift-package-manager/for-app-developers#how-to-remove-swift-package-manager-integration

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

To undo this, run the following command:

```sh
flutter config --enable-swift-package-manager
```
