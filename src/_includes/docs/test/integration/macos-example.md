```console
$ flutter test integration_test
Resolving dependencies... 
Downloading packages... 
  flutter_lints 3.0.2 (4.0.0 available)
> leak_tracker 10.0.4 (was 10.0.0) (10.0.5 available)
> leak_tracker_flutter_testing 3.0.3 (was 2.0.1) (3.0.5 available)
> leak_tracker_testing 3.0.1 (was 2.0.1)
  lints 3.0.0 (4.0.0 available)
  material_color_utilities 0.8.0 (0.11.1 available)
> meta 1.12.0 (was 1.11.0) (1.15.0 available)
> test_api 0.7.0 (was 0.6.1) (0.7.1 available)
> vm_service 14.2.1 (was 13.0.0) (14.2.2 available)
Changed 6 dependencies!
8 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.

Connected devices:

macOS (desktop)                 • macos                 • darwin-arm64   • macOS 14.4.1 23E224 darwin-arm64
Mac Designed for iPad (desktop) • mac-designed-for-ipad • darwin         • macOS 14.4.1 23E224 darwin-arm64
Chrome (web)                    • chrome                • web-javascript • Google Chrome 124.0.6367.208

No wireless devices were found.

[1]: macOS (macos)
[2]: Mac Designed for iPad (mac-designed-for-ipad)
[3]: Chrome (chrome)
Please choose one (or "q" to quit): 1

00:01 +0: loading /path/to/counter_app/integration_test/app_test.dart        R
00:02 +0: loading /path/to/counter_app/integration_test/app_test.dart    846ms
00:03 +0: loading /path/to/counter_app/integration_test/app_test.dart        B

Building macOS application...
✓ Built build/macos/Build/Products/Debug/counter_app.app
00:32 +1: All tests passed!
```
