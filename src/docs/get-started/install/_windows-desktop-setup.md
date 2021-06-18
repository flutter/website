## Windows setup

{{site.alert.warning}}
  **Beta (Win32) and Dev (UWP)!**
  This area covers Windows desktop support,
  which is available in beta release (Win32)
  and alpha release (UWP).

  The Win32 variant still has notable feature gaps,
  including accessibility support, while the
  UWP variant is still in very active development.

  You can try a beta snapshot of Win32 desktop support
  on the stable channel, or you can keep up
  with the latest changes to desktop on the
  `beta` channel. For Windows UWP you need
  to be on the `dev` channel.

  For more information, see the **Desktop**
  section in [What's new in Flutter 2.2][],
  a free article on Medium.
{{site.alert.end}}

[What's new in Flutter 2.2]: {{site.flutter-medium}}/whats-new-in-flutter-2-2-fd00c65e2039

### Additional Windows requirements

For Windows desktop development,
you need the following in addition to the Flutter SDK:

* [Visual Studio 2019][] (not to be confused with
  Visual Studio _Code_). For Win32 you need the
  "Desktop development with C++" workload installed,
  including all of its default components. For UWP
  you need the "Universal Windows Platform development"
  workload installed, with the optional UWP C++ tools.

[Visual Studio 2019]: https://visualstudio.microsoft.com/downloads/

### Enable desktop support

At the command line,
perform the following command to enable Win32 desktop support:

```terminal
$ flutter config --enable-windows-desktop
```

For Windows UWP desktop support perform the following commands to switch to
the `dev` channel, upgrade Flutter, and enable UWP.

```terminal
$ flutter channel dev
$ flutter upgrade
$ flutter config --enable-windows-uwp-desktop
```

For more information, see [Desktop support for Flutter][]

[Desktop support for Flutter]: /desktop
