# DevTools 2.17.0 release notes

Dart & Flutter DevTools - A Suite of Performance Tools for Dart and Flutter

## Inspector Updates
* Added support for manually setting the package directories for your app.
  If you've ever loaded the Inspector and noticed that some of your widgets
  aren't present in the widget tree, this might indicate that the package directories
  for your app haven't been set or detected properly.
  Your package directories determine which widgets
  the Inspector considers to be from _your_ application.
  If you see an empty Inspector widget tree,
  or if you develop widgets across multiple packages 
  and want widgets from all these locations to show up in your tree,
  check the **Inspector Settings** dialog to ensure that your package
  directories are properly
  configured. - [#4306](https://github.com/flutter/devtools/pull/4306)

![frame_analysis]({{site.url}}/development/tools/devtools/release-notes/images-2.17.0/package_directories.png "package directories")

## Performance Updates
* Added a **Frame Analysis** tab to the Performance page.
  When analyzing a janky Flutter frame,
  this view provides hints for how to diagnose the jank and
  detects expensive operations that might have contributed
  to the slow frame time. This view also shows a breakdown of
  your Flutter frame time per phase (**Build**, **Layout**, **Paint**, and **Raster**)
  to try to guide you in the right direction
  - [#4339](https://github.com/flutter/devtools/pull/4339)

![frame_analysis]({{site.url}}/development/tools/devtools/release-notes/images-2.17.0/frame_analysis.png "frame analysis")

## Changelog
More details about changes and fixes are available in the DevTools
[changelog](https://github.com/flutter/devtools/blob/master/CHANGELOG.md).
