{{site.alert.note}}
  As of Flutter's 1.19.0 dev release, the Flutter SDK
  contains the `dart` command alongside the `flutter`
  command so that you can more easily run Dart
  command-line programs. Downloading the Flutter SDK
  also downloads the compatible version of Dart,
  but if you've downloaded the Dart SDK separately,
  make sure that the Flutter version of `dart` is
  first in your path, as the two versions might not be compatible.
  The following command tells you whether the `flutter` and `dart`
  commands originate from the same `bin` directory and are
  therefore compatible.

  ```terminal
  $ which flutter dart
  /path-to-flutter-sdk/bin/flutter
  /usr/local/bin/dart
  ```

  As shown above, the two commands don't come from
  the same `bin` directory. Update your path to use
  commands from `/path-to-flutter-sdk/bin` before
  commands from `/usr/local/bin` (in this case).
  After updating your shell for the change to take effect,
  running the `which` command again
  should show that the `flutter` and `dart` commands
  now come from the same directory.

  ```terminal
  $ which flutter dart
  /path-to-flutter-sdk/bin/flutter
  /path-to-flutter-sdk/bin/dart
  ```

  To learn more about the `dart` command, run `dart -h`
  from the command line, or see the [dart tool][] page.
{{site.alert.end}}

[dart tool]: {{site.dart-site}}/tools/dart-vm
