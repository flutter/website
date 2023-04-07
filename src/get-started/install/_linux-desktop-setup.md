## Linux setup

### Additional Linux requirements

For Linux desktop development,
you need the following in addition to the Flutter SDK:

* [Clang][]
* [CMake][]
* [GTK development headers][]
* [Ninja build][]
* [pkg-config][]
* [liblzma-dev][] This might be necessary

Run the following command

```terminal
$ sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev
```

[Clang]: https://clang.llvm.org/
[CMake]: https://cmake.org/
[GTK development headers]: https://developer.gnome.org/gtk3/3.2/gtk-getting-started.html
[Installing snapd]: https://snapcraft.io/docs/installing-snapd
[Ninja build]: https://ninja-build.org/
[pkg-config]: https://www.freedesktop.org/wiki/Software/pkg-config/
[liblzma-dev]: https://packages.debian.org/sid/liblzma-dev
