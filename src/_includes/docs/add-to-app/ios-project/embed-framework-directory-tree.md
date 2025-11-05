The following example assumes that you want to generate the
frameworks to `/path/to/MyApp/Flutter/`.

```console
$ flutter build ios-framework --output=/path/to/MyApp/Flutter/
```

Run this _every time_ you change code in your Flutter module.

The resulting project structure should resemble this directory tree.

<FileTree>

- /path/to/MyApp/
  - Flutter/
    - Debug/
      - Flutter.xcframework
      - App.xcframework
      - FlutterPluginRegistrant.xcframework (If you have plugins with iOS-platform code)
      - example_plugin.xcframework (One framework file for each plugin)
    - Profile/
      - Flutter.xcframework
      - App.xcframework
      - FlutterPluginRegistrant.xcframework
      - example_plugin.xcframework
    - Release/
      - Flutter.xcframework
      - App.xcframework
      - FlutterPluginRegistrant.xcframework
      - example_plugin.xcframework

</FileTree>

:::warning
Always use `Flutter.xcframework` and `App.xcframework` bundles
located in the same directory.
Mixing `.xcframework` imports from different directories
(like `Profile/Flutter.xcframework` with `Debug/App.xcframework`)
causes runtime crashes.
:::
