### Use CocoaPods and the Flutter SDK {:#method-a .no_toc}

#### Approach {:#method-a-approach}

This first method uses CocoaPods to embed the Flutter modules.
CocoaPods manages dependencies for Swift projects,
including Flutter code and plugins.
Each time Xcode builds the app,
CocoaPods embeds the Flutter modules.

This allows rapid iteration with the most up-to-date
version of your Flutter module without running additional
commands outside of Xcode.

To learn more about CocoaPods,
consult the [CocoaPods getting started guide][].

#### Watch the video

If watching a video helps you learn,
this video covers adding Flutter to an iOS app:

<YouTubeEmbed id="IIcrfrTshTs" title="Step by step on how to add Flutter to an existing iOS app"></YouTubeEmbed>

#### Requirements {:#method-a-reqs}

Every developer working on your project must have a local version
of the Flutter SDK and CocoaPods installed.

#### Example project structure {:#method-a-structure}

This section assumes that your existing app and
the Flutter module reside in sibling directories.
If you have a different directory structure,
adjust the relative paths.
The example directory structure resembles the following:

```plaintext
/path/to/MyApp
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

   :::tip
   If the `pod init` command errors,
   check that you're on the latest version of CocoaPods.
   :::

1. Update your `Podfile` config file.

   1. Add the following lines after the `platform` declaration.

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

To review an example `Podfile`, consult this [Flutter Podfile sample][].

#### Embed your frameworks

At build time, Xcode packages your Dart code, each Flutter plugin,
and the Flutter engine into their own `*.xcframework` bundles.
CocoaPod's `podhelper.rb` script then embeds these
`*.xcframework` bundles into your project.

* `Flutter.xcframework` contains the Flutter engine.
* `App.xcframework` contains the compiled Dart code for this project.
* `<plugin>.xcframework` contains one Flutter plugin.

To embed the Flutter engine, your Dart code, and your Flutter plugins
into your iOS app, complete the following procedure.

1. Refresh your Flutter plugins.

   If you change the Flutter dependencies in the `pubspec.yaml` file,
   run `flutter pub get` in your Flutter module directory.
   This refreshes the list of plugins that the `podhelper.rb` script reads.

   ```console
   flutter pub get
   ```

1. Embed the plugins and frameworks with CocoaPods.

   1. Navigate to your iOS app project at `/path/to/MyApp/MyApp`.

   1. Use the `pod install` command.

      ```console
      pod install
      ```

   Your iOS app's **Debug** and **Release** build configurations embed
   the corresponding [Flutter components for that build mode][build-modes].

1. Build the project.

   1. Open `MyApp.xcworkspace` in Xcode.

      Verify that you're opening `MyApp.xcworkspace` and
      not opening `MyApp.xcodeproj`.
      The `.xcworkspace` file has the CocoaPod dependencies,
      the `.xcodeproj` doesn't.

   1. Select **Product** > **Build** or press <kbd>Cmd</kbd> + <kbd>B</kbd>.

#### Set LLDB Init File

:::warning
Set your scheme to use Flutter's LLDB Init File. Without this file, debugging
on an iOS 26 or later device may crash.
:::

1. Generate Flutter LLDB files.

   1. Within your flutter application, run the following:

   ```console
   flutter build ios --config-only
   ```

   This will generate the LLDB files in the `.ios/Flutter/ephemeral` directory.

1. Set the LLDB Init File.

   1. Go to **Product > Scheme > Edit Scheme**.

   1. Select the **Run** section in the left side bar.

   1. Set the **LLDB Init File** using the same relative path to your Flutter
      application as you put in your Podfile in the **Update your Podfile**
      section.

      ```console
      $(SRCROOT)/../my_flutter/.ios/Flutter/ephemeral/flutter_lldbinit
      ```

      If your scheme already has an **LLDB Init File**, you can add Flutter's
      LLDB file to it. The path to Flutter's LLDB Init File must be relative
      to the location of your project's LLDB Init File.

      For example, if your LLDB file is located at `/path/to/MyApp/.lldbinit`,
      you would add the following:

      ```console
      command source --relative-to-command-file "../my_flutter/.ios/Flutter/ephemeral/flutter_lldbinit"
      ```

[build-modes]: /testing/build-modes
[CocoaPods getting started guide]: https://guides.cocoapods.org/using/using-cocoapods.html
[Podfile target]: https://guides.cocoapods.org/syntax/podfile.html#target
[Flutter Podfile sample]: https://github.com/flutter/samples/blob/main/add_to_app/plugin/ios_using_plugin/Podfile
