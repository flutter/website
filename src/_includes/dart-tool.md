{{site.alert.note}}
  As of Flutter's 1.19.0 dev release, the `dart` command
  is now surfaced for you. Downloading the Flutter SDK
  also downloads the compatible version of Dart,
  but if you have downloaded the Dart SDK separately,
  make sure that the Flutter version of `dart` is listed
  first in your path, as the two versions may not be compatible.
  The following command (on macOS, linux, and chrome OS),
  tells you whether the `flutter` and `dart` commands
  originate from the same `bin` directory and are therefore
  compatible. (Some versions of Windows
  support a similar `where` command.)

  ```sh
  $ which flutter; which dart
  <path-to-flutter-sdk>/flutter-sdk/bin/flutter
  /usr/local/bin/dart
  ```

  As shown above, the two commands are not coming from
  the same `bin` directory. Update your path to use
  commands from `<path-to-flutter-sdk>/bin` before it
  uses commands from `/usr/local/bin` (in this case).
  After updating your shell for the change to take effect,
  run the command again, and you should now see:

  ```sh
  $ which flutter; which dart
  <path-to-flutter-sdk>/flutter-sdk/bin/flutter
  <path-to-flutter-sdk>/flutter-sdk/bin/dart
  ```

  To learn more about the `dart` command, run `dart -h`
  from the command line, or see the [dart client][] page
  on dart.dev.
{{site.alert.end}}

[dart client]: {{site.dart-site}}/tools/dart-vm
