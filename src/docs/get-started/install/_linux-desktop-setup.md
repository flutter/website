## Linux setup

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

### Additional Linux requirements

For Linux desktop development,
you need the following in addition to the Flutter SDK:

* [Clang][]
* [CMake][]
* [GTK development headers][]
* [Ninja build][]
* [pkg-config][]

Run the following command

```terminal
$ sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev
```

[Clang]: https://clang.llvm.org/
[CMake]: https://cmake.org/
[GTK development headers]: https://developer.gnome.org/gtk3/3.2/gtk-getting-started.html
[Installing snapd]: https://snapcraft.io/docs/installing-snapd
[Ninja build]: https://ninja-build.org/
[pkg-config]: https://www.freedesktop.org/wiki/Software/pkg-config/

### Enable desktop support

At the command line, perform the following command to enable desktop support

```terminal
$ flutter config --enable-linux-desktop
```

For more information, see [Desktop support for Flutter][]

[Desktop support for Flutter]: https://flutter.dev/desktop