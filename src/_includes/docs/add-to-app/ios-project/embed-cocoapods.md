### Use CocoaPods and the Flutter SDK {:#method-a .no_toc}

#### Approach {:#method-a-approach}

This first method compiles the Flutter module from source each time
Xcode builds the app.
To run the script to embed your Dart and plugin code,
build your iOS app in Xcode.

CocoaPods manages dependencies for Swift projects.
You can use CocoaPods to embed your Flutter modules into
your Swift projects.

This allows rapid iteration with the most up-to-date
version of your Flutter module without running additional
commands outside of Xcode.

To learn more about CocoaPods,
consult the [CocoaPods getting started guide][].

#### Watch the video

If you learn better watching video,
watch this one that covers adding Flutter to an iOS app:

<iframe class="full-width" src="{{yt-embed}}/IIcrfrTshTs" title="Learn about how to add Flutter to an existing iOS app" {{yt-set}}></iframe>

[Watch this video on YouTube]({{yt-watch}}/IIcrfrTshTs).

#### Requirements {:#method-a-reqs}

Every developer working on your project must have a local version
of the Flutter SDK and CocoaPods installed.

#### Example project structure {:#method-a-structure}

The following example assumes that your existing app and
the Flutter module reside in sibling directories.
If you have a different directory structure,
adjust the relative paths.

```plaintext
/path/to/
├── my_flutter/
│   └── .ios/
│       └── Flutter/
│         └── podhelper.rb
└── MyApp/
    └── Podfile
```

#### Update your Podfile

Add your Flutter modules to your Podfile configuration file.

This section presumes you called your Swift app `MyApp`.

1. _(Optional)_ If your existing app lacks a `Podfile` config file,
   navigate to the root of your app directory.
   Use the `pod init` command to create the `Podfile` file.

1. Add the following lines to your `Podfile` config file
   after the `platform` declaration.

   The `podhelper.rb` script embeds your plugins,
   `Flutter.framework`, and `App.framework` into your project.

   ```ruby title="MyApp/Podfile"
   flutter_application_path = '../my_flutter'
   load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')
   ```

1. For each [Podfile target][] that needs to embed Flutter,
   add a call to the
   `install_all_flutter_pods(flutter_application_path)` method.
   Add these calls after the settings in the previous step.

   ```ruby title="MyApp/Podfile"
   target 'MyApp' do
     install_all_flutter_pods(flutter_application_path)
   end
   ```

1. In the `Podfile`'s `post_install` block,
   add a call to `flutter_post_install(installer)`.
   This block should be the last block in the `Podfile` config file.

   ```ruby title="MyApp/Podfile"
   post_install do |installer|
     flutter_post_install(installer) if defined?(flutter_post_install)
   end
   ```

1. Use the `flutter pub get` command to refresh plugins.

   When you change the Flutter dependencies in the `pubspec.yaml` file,
   run `flutter pub get` in your Flutter module directory.
   This refreshes the list of plugins that the `podhelper.rb` script reads.

1. Run the `pod install` command to embed the plugins and frameworks.

   From your iOS app project at `/path/to/MyApp`, run `pod install`.

   Your app's **Debug** and **Release** build configurations embed
   the **Debug** or **Release** [build modes of Flutter][], respectively.

   To test in profile mode, add a **Profile** build configuration to your app.

   :::tip
   `Flutter.framework` is the bundle for the Flutter engine,
   and `App.framework` is the compiled Dart code for this project.
   :::

1. Open `MyApp.xcworkspace` in Xcode.

   Verify that you're opening `MyApp.xcworkspace` and
   not opening `MyApp.xcodeproj`.
   The `.xcworkspace` file has the CocoaPod dependencies,
   the `.xcodeproj` doesn't.

1. To build the project, press <kbd>Cmd</kbd> + <kbd>B</kbd>.

To review an example `Podfile`, consult this [Flutter Podfile sample].

[build modes of Flutter]: /testing/build-modes
[CocoaPods getting started guide]: https://guides.cocoapods.org/using/using-cocoapods.html
[Podfile target]: https://guides.cocoapods.org/syntax/podfile.html#target
[Flutter Podfile sample]: {{github}}/flutter/samples/blob/main/add_to_app/plugin/ios_using_plugin/Podfile
