### Use frameworks in Xcode and Flutter framework as podspec {:#method-c .no_toc}

#### Approach {:#method-c-approach}

This method generates Flutter as a CocoaPods podspec instead of
distributing the large `Flutter.xcframework` to other developers,
machines, or continuous integration systems.
Flutter still generates iOS frameworks for your compiled Dart code,
and for each of your Flutter plugins.
Embed these frameworks and update your existing application's build settings.

#### Requirements {:#method-c-reqs}

No additional software or hardware requirements are needed for this method.
Use this method in the following use cases:

* Members of your team can't install the Flutter SDK and CocoaPods
* You don't want to use CocoaPods as a dependency manager in existing iOS apps

#### Limitations {:#method-c-limits}

{% render docs/add-to-app/ios-project/limits-common-deps.md %}

This method only works with the `beta` or `stable` [release channels][].

[release channels]: /release/upgrade#switching-flutter-channels

#### Example project structure {:#method-c-structure}

{% render docs/add-to-app/ios-project/embed-framework-directory-tree.md %}

#### Add Flutter engine to your Podfile

Host apps using CocoaPods can add the Flutter engine to their Podfile.

```ruby title="MyApp/Podfile"
pod 'Flutter', :podspec => '/path/to/MyApp/Flutter/[![build mode]!]/Flutter.podspec'
```

:::note
You must hard code the `[build mode]` value.
For example, use `Debug` if you need to use `flutter attach`
and `Release` when you're ready to ship.
:::

#### Link and embed app and plugin frameworks

{% render docs/add-to-app/ios-project/link-and-embed.md %}
