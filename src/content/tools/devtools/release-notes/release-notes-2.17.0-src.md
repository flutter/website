# DevTools 2.17.0 release notes

The 2.17.0 release of the Dart and Flutter DevTools
includes the following changes among other general improvements.
To learn more about DevTools, check out the
[DevTools overview](https://docs.flutter.dev/tools/devtools).

## Inspector updates

* Added support for manually setting the package directories for your app.
  If you've ever loaded the Inspector and noticed that
  some of your widgets aren't present in the widget tree, this might
  indicate that the package directories for your app
  haven't been set or detected properly.
  Your package directories determine which widgets
  the Inspector considers to be from _your_ application.
  If you see an empty Inspector widget tree,
  or if you develop widgets across multiple packages,
  and want widgets from all these locations to show up in your tree,
  check the **Inspector Settings** dialog to ensure that your package
  directories are properly configured -
  [#4306](https://github.com/flutter/devtools/pull/4306)

  ![frame_analysis](/tools/devtools/release-notes/images-2.17.0/package_directories.png "package directories")

## Performance updates

* Added a **Frame Analysis** tab to the Performance page.
  When analyzing a janky Flutter frame,
  this view provides hints for how to diagnose the jank and
  detects expensive operations that might have
  contributed to the slow frame time.
  This view also shows a breakdown of your Flutter frame time
  per phase (**Build**, **Layout**, **Paint**, and **Raster**)
  to try to guide you in the right direction -
  [#4339](https://github.com/flutter/devtools/pull/4339)

  ![frame_analysis](/tools/devtools/release-notes/images-2.17.0/frame_analysis.png "frame analysis")

## Full commit history

To find a complete list of changes since the previous release,
check out
[the diff on GitHub](https://github.com/flutter/devtools/compare/v2.16.0...v2.17.0).
