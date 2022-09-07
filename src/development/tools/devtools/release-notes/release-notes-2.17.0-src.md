# DevTools 2.17.0 release notes

Dart & Flutter DevTools - A Suite of Performance Tools for Dart and Flutter

## Inspector Updates
* Added support for manually setting the package directories for your app. If you've ever loaded the Inspector and noticed that some of your widgets are not present in the Widget tree, this may be an indication that the package directories for your app have not been set or detected properly. Your package directories determine which widgets the Inspector considers to be from "your" application. If you see an empty Inspector widget tree, or if you develop widgets across multiple packages and want widgets from all these locations to show up in your tree, check the Inspector Settings dialog to ensure that your package directories are properly configured. 

    * Fix getPubRootDirectories so it works over Dart Debug Extension [#4372](https://github.com/flutter/devtools/pull/4372)
    * Adding multi-package support for pubrootdirectories [#4306](https://github.com/flutter/devtools/pull/4306)

## Performance Updates
* Added frame analysis that provides hints to do the following:
  * point users to the "Enhance Tracing" when a frame phase is the leading cause of slow UI time
  * point users to the "Raster Metrics" tab for frames with raster jank
  * point users to documentation when expensive operations like Canvas.saveLayer(), intrinsics calculations, and shader compilation are contributing to jank.
  * provides a visual breakdown of where the time in a frame was spent.

    Example analysis view for a janky frame:
 
    * Enabled frame analysis;[#4339](https://github.com/flutter/devtools/pull/4339)

## Changelog
More details about changes and fixes are available in the DevTools
[changelog](https://github.com/flutter/devtools/blob/master/CHANGELOG.md).
