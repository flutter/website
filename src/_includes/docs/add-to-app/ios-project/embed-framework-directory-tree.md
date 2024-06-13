The following example assumes that you want to generate the
frameworks to `/path/to/MyApp/Flutter/`.

```console
$ flutter build ios-framework --output=/path/to/MyApp/Flutter/
```

Run this _every time_ you change code in your Flutter module.

The resulting project structure should resemble this directory tree.

```plaintext
/path/to/MyApp/
└── Flutter/
    ├── Debug/
    │   ├── Flutter.xcframework
    │   ├── App.xcframework
    │   ├── FlutterPluginRegistrant.xcframework (only if you have plugins with iOS platform code)
    │   └── example_plugin.xcframework (each plugin is a separate framework)
    ├── Profile/
    │   ├── Flutter.xcframework
    │   ├── App.xcframework
    │   ├── FlutterPluginRegistrant.xcframework
    │   └── example_plugin.xcframework
    └── Release/
        ├── Flutter.xcframework
        ├── App.xcframework
        ├── FlutterPluginRegistrant.xcframework
        └── example_plugin.xcframework
```

:::warning
Always use `Flutter.xcframework` and `App.xcframework` bundles
located in the same directory.
Mixing `.xcframework` imports from different directories
(like `Profile/Flutter.xcframework` with `Debug/App.xcframework`)
causes runtime crashes.
:::
