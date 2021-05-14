## macOS setup

{{site.alert.warning}}
  **Beta!**
  This area covers desktop support,
  which is available as a beta release.
  Beta support still has notable feature gaps,
  including accessibility support.
  You can try a beta snapshot of desktop support
  on the stable channel, or you can keep up
  with the latest changes to desktop on the
  beta channel.
  For more information, see the **Desktop**
  section in [What's new in Flutter 2][],
  a free article on Medium.
{{site.alert.end}}

[What's new in Flutter 2]: {{site.flutter-medium}}/whats-new-in-flutter-2-0-fe8e95ecc65

### Additional macOS requirements

For macOS desktop development,
you need the following in addition to the Flutter SDK:

* [Xcode][]
* [CocoaPods][] if you use plugins

[CocoaPods]: https://cocoapods.org/
[Xcode]: {{site.apple-dev}}/xcode/

### Enable desktop support

At the command line, perform the following command to enable desktop support

```terminal
$ flutter config --enable-macos-desktop
```

For more information, see [Desktop support for Flutter][]

[Desktop support for Flutter]: https://flutter.dev/desktop