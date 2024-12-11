---
title: "Flutter and the pubspec file"
description: "Describes the Flutter-only fields in the pubspec file."
---

:::note
This page is primarily aimed at folks who write
Flutter apps. If you write packages or plugins, 
(perhaps you want to create a federated plugin),
you should check out the
[Developing packages and plugins][] page.
:::

Every Flutter project includes a `pubspec.yaml` file,
often referred to as _the pubspec_.
A basic pubspec is generated when you create
a new Flutter project. It's located at the top
of the project tree and contains metadata about
the project that the Dart and Flutter tooling
needs to know. The pubspec is written in
[YAML][], which is human readable, but be aware
that _white space (tabs v spaces) matters_.

[YAML]: https://yaml.org/

The pubspec file specifies dependencies
that the project requires, such as particular packages
(and their versions), fonts, or image files.
It also specifies other requirements, such as 
dependencies on developer packages (like
testing or mocking packages), or particular
constraints on the version of the Flutter SDK. 

Fields common to both Dart and Flutter projects
are described in [the pubspec file][] on [dart.dev][].
This page lists _Flutter-specific_ fields
that are only valid for a Flutter project.

:::note
The first time you build your project, it
creates a `pubspec.lock` file that contains
specific versions of the included packages.
This ensures that you get the same version
the next time the project is built.
:::

[the pubspec file]: {{site.dart-site}}/tools/pub/pubspec
[dart.dev]: {{site.dart-site}}

When you create a new project with the
`flutter create` command (or by using the
equivalent button in your IDE), it creates
a pubspec for a basic Flutter app.

Here is an example of a Flutter project pubspec file.
The Flutter only fields are highlighted.

```yaml
name: <project name>
description: A new Flutter project.

publish_to: none

version: 1.0.0+1

environment:
  sdk: ^3.6.0

dependencies:
  [!flutter:!]       # Required for every Flutter project
    [!sdk: flutter!] # Required for every Flutter project
  [!flutter_localizations:!] # Required to enable localization
    [!sdk: flutter!]         # Required to enable localization

  [!cupertino_icons: ^1.0.8!] # Only required if you use Cupertino (iOS style) icons

dev_dependencies:
  [!flutter_test:!]
    [!sdk: flutter!] # Required for a Flutter project that includes tests

  [!flutter_lints: ^5.0.0!] # Contains a set of recommended lints for Flutter code

[!flutter:!]

  [!uses-material-design: true!] # Required if you use the Material icon font

  [!generate: true!] # Enables generation of localized strings from arb files

  [!assets:!]  # Lists assets, such as image files
    [!- images/a_dot_burr.jpeg!]
    [!- images/a_dot_ham.jpeg!]

  [!fonts:!]              # Required if your app uses custom fonts
    [!- family: Schyler!]
      [!fonts:!]
        [!- asset: fonts/Schyler-Regular.ttf!]
        [!- asset: fonts/Schyler-Italic.ttf!]
          [!style: italic!]
    [!- family: Trajan Pro!]
      [!fonts:!]
        [!- asset: fonts/TrajanPro.ttf!]
        [!- asset: fonts/TrajanPro_Bold.ttf!]
          [!weight: 700!]
```
 
## Assets

Common types of assets include static data
(for example, JSON files), configuration files,
icons, and images (JPEG, WebP, GIF,
animated WebP/GIF, PNG, BMP, and WBMP).

Besides listing the images that are included in the
app package, an image asset can also refer to one or more
resolution-specific "variants". For more information,
see the [resolution aware][] section of the
[Assets and images][] page.
For information on adding assets from package
dependencies, see the
[asset images in package dependencies][]
section in the same page.

[Assets and images]: /ui/assets/assets-and-images
[asset images in package dependencies]: /ui/assets/assets-and-images#from-packages
[resolution aware]: /ui/assets/assets-and-images#resolution-aware

## Fonts

As shown in the above example,
each entry in the fonts section should have a
`family` key with the font family name,
and a `fonts` key with a list specifying the
asset and other descriptors for the font.

For examples of using fonts
see the [Use a custom font][] and
[Export fonts from a package][] recipes in the
[Flutter cookbook][].

[Export fonts from a package]: /cookbook/design/package-fonts
[Flutter cookbook]: /cookbook
[Use a custom font]: /cookbook/design/fonts

## More information

For more information on packages, plugins,
and pubspec files, see the following:

* [Creating packages][] on dart.dev
* [Glossary of package terms][] on dart.dev
* [Package dependencies][] on dart.dev
* [Using packages][]
* [What not to commit][] on dart.dev

[Creating packages]: {{site.dart-site}}/guides/libraries/create-library-packages
[Developing packages and plugins]: /packages-and-plugins/developing-packages
[Federated plugins]: /packages-and-plugins/developing-packages#federated-plugins
[Glossary of package terms]: {{site.dart-site}}/tools/pub/glossary
[Package dependencies]: {{site.dart-site}}/tools/pub/dependencies
[Using packages]: /packages-and-plugins/using-packages
[What not to commit]: {{site.dart-site}}/guides/libraries/private-files#pubspeclock
