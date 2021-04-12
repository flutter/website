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
  C:\>where flutter dart
  C:\path-to-flutter-sdk\bin\flutter
  C:\path-to-flutter-sdk\bin\flutter.bat
  C:\path-to-dart-sdk\bin\dart.exe        :: this should go after `C:\path-to-flutter-sdk\bin\` commands
  C:\path-to-flutter-sdk\bin\dart
  C:\path-to-flutter-sdk\bin\dart.bat
  ```

  As shown above, the command `dart` from the Flutter SDK doesn't come first.
  Update your path to use commands from `C:\path-to-flutter-sdk\bin\` before
  commands from `C:\path-to-dart-sdk\bin\` (in this case).
  After restarting your shell for the change to take effect,
  running the `where` command again
  should show that the `flutter` and `dart` commands
  from the same directory now come first.

  ```terminal
  C:\>where flutter dart
  C:\dev\src\flutter\bin\flutter
  C:\dev\src\flutter\bin\flutter.bat
  C:\dev\src\flutter\bin\dart
  C:\dev\src\flutter\bin\dart.bat
  C:\dev\src\dart-sdk\bin\dart.exe
  ```

  However, if you are using `PowerShell`, in it `where` is
  an alias of `Where-Object` command, so you need to use `where.exe` instead.

  ```terminal
  PS C:\> where.exe flutter dart
  ```


  To learn more about the `dart` command, run `dart -h`
  from the command line, or see the [dart tool][] page.
{{site.alert.end}}

[dart tool]: {{site.dart-site}}/tools/dart-vm
