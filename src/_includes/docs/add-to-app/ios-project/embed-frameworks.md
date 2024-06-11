### Embed frameworks in Xcode {:#method-b .no_toc}

#### Approach {:#method-b-approach}

In this second method, edit your existing Xcode project,
generate the necessary frameworks, and embed them in your app. You need to create three iOS frameworks: for the Flutter engine, for your compiled Dart code, and for all Flutter plugins in Xcode. Embed these frameworks and update your existing application's build settings.

Every time you change code in your Flutter module,
run `flutter build ios-framework`.

#### Requirements {:#method-b-reqs}

No additional software or hardware requirements are needed for this method.
Use this method in the following use cases:

* Members of your team can't install the Flutter SDK and CocoaPods
* You don't want to use CocoaPods as a dependency manager in existing iOS apps

#### Limitations {:#method-b-limits}

{% render docs/add-to-app/ios-project/limits-common-deps.md %}

#### Example project structure {:#method-b-structure}

The following example assumes that you want to generate the
frameworks to `/path/to/MyApp/Flutter/`.

```console
$ flutter build ios-framework --output=/path/to/MyApp/Flutter/
```

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
Always put `Flutter.xcframework` and `App.xcframework` from the same directory.
Mixing `.xcframework` imports from different directories
(like `Profile/Flutter.xcframework` with `Debug/App.xcframework`)
causes runtime crashes.
:::

#### Procedures

You can either link or embed the generated frameworks
into your existing app in Xcode.
Use the method that is best for your project.

##### Link on the frameworks

Continuing with this example,
you can drag the frameworks from
the `/path/to/MyApp/Flutter/Release/` directory in the Finder
to your target's
**Build Settings > Build Phases > Link Binary With Libraries** settings.

You must also open `MyApp.xcodeproj/project.pbxproj` (from Finder)
and replace `path = Flutter/Release/example.xcframework;`
with `path = "Flutter/$(CONFIGURATION)/example.xcframework";`
for all added frameworks. The double quotes (`"`) are necessary.

In the target's build settings, add `$(PROJECT_DIR)/Flutter/Release/`
to the **Framework Search Paths** (`FRAMEWORK_SEARCH_PATHS`).

{% render docs/captioned-image.liquid, image:"development/add-to-app/ios/project-setup/framework-search-paths.png", caption:"Update Framework Search Paths in Xcode" %}

:::tip
To use the simulator, embed the Debug version of the Flutter frameworks
in your Debug build configuration.
To do this, use `$(PROJECT_DIR)/Flutter/$(CONFIGURATION)`
in the **Framework Search Paths** (`FRAMEWORK_SEARCH_PATHS`) build setting.
This embeds the Release frameworks in the Release configuration,
and the Debug frameworks in the Debug Configuration.
:::

##### Embed the frameworks

To load the generated dynamic frameworks at runtime,
embed them into your app.

:::important
Plugins might produce [static or dynamic frameworks][].
Static frameworks should be linked on, but never embedded.
If you embed a static framework into your iOS app,
you can't publish that app to the App Store.
Publishing fails with a
**Found an unexpected Mach-O header code** archive error.
:::

After linking the frameworks, they should display in the
**Frameworks, Libraries, and Embedded Content**
section of your target's **General** settings.

To embed the dynamic frameworks, select **Embed & Sign**.
They then appear under **Embed Frameworks** within **Build Phases** as shown.

{% render docs/captioned-image.liquid, image:"development/add-to-app/ios/project-setup/embed-xcode.png", caption:"Embed frameworks in Xcode" %}

You should now be able to build the project in Xcode using `⌘B`.