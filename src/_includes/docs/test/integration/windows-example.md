```powershell
PS C:\path\to\counter_app> flutter test .\integration_test\app_test.dart
Resolving dependencies...
Downloading packages...
  flutter_lints 3.0.2 (4.0.0 available)
  leak_tracker 10.0.4 (10.0.5 available)
  leak_tracker_flutter_testing 3.0.3 (3.0.5 available)
  lints 3.0.0 (4.0.0 available)
  material_color_utilities 0.8.0 (0.11.1 available)
  meta 1.12.0 (1.15.0 available)
  test_api 0.7.0 (0.7.1 available)
  vm_service 14.2.1 (14.2.2 available)
Got dependencies!
8 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.

Connected devices:

Windows (desktop) • windows • windows-x64    • Microsoft Windows [Version 10.0.22631.3593]
Chrome (web)      • chrome  • web-javascript • Google Chrome 124.0.6367.207
Edge (web)        • edge    • web-javascript • Microsoft Edge 124.0.2478.97

[1]: Windows (windows)
[2]: Chrome (chrome)
[3]: Edge (edge)

Please choose one (or "q" to quit): 1

00:00 +0: loading C:/path/to/counter_app/integration_test/app_test.dart               B
00:29 +0: loading C:/path/to/counter_app/counter_app/integration_test/app_test.dart   29.1s
√ Built build\windows\x64\runner\Debug\counter_app.exe
00:31 +1: All tests passed!
```
