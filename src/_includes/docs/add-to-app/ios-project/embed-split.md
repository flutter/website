### Use frameworks in Xcode and Flutter framework as podspec {:#method-c .no_toc}

#### Approach {:#method-c-approach}

This method generates Flutter as a CocoaPods podspec instead of
distributing the large `Flutter.xcframework` to other developers,
machines, or continuous integration systems.
Flutter still generates the `App.xcframework` and plugin frameworks
as described in Option B.

#### Requirements {:#method-c-reqs}

This method has the same requirements as Method B.

#### Limitations {:#method-c-limits}

{% render docs/add-to-app/ios-project/limits-common-deps.md %}

This method only works with the `beta` or `stable` [release channels][].

[release channels]: /release/upgrade#switching-flutter-channels

#### Example project structure {:#method-c-structure}

To generate the `Flutter.podspec` and frameworks,
run the following command in the root of your Flutter module.

```console
$ flutter build ios-framework --cocoapods --output=/path/to/MyApp/Flutter/
```

The resulting project structure should resemble this directory tree.

```plaintext
/path/to/MyApp/
└── Flutter/
    ├── Debug/
    │   ├── Flutter.podspec
    │   ├── App.xcframework
    │   ├── FlutterPluginRegistrant.xcframework
    │   └── example_plugin.xcframework (each plugin with iOS platform code is a separate framework)
    ├── Profile/
    │   ├── Flutter.podspec
    │   ├── App.xcframework
    │   ├── FlutterPluginRegistrant.xcframework
    │   └── example_plugin.xcframework
    └── Release/
        ├── Flutter.podspec
        ├── App.xcframework
        ├── FlutterPluginRegistrant.xcframework
        └── example_plugin.xcframework
```

#### Add Flutter to your Podfile

Host apps using CocoaPods can add Flutter to their Podfile.

```ruby title="MyApp/Podfile"
pod 'Flutter', :podspec => '/path/to/MyApp/Flutter/[build mode]/Flutter.podspec'
```

:::note
You must hard code the `[build mode]` value.
For example, use `Debug` if you need to use `flutter attach`
and `Release` when you're ready to ship.
:::

Link and embed the generated App.xcframework,
FlutterPluginRegistrant.xcframework,
and any plugin frameworks into your existing application
as described in Option B.