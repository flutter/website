---
title: Flutter Changelog 0.0.21 - 1.0.0
short-title: Flutter Changelog up to 1.0.0
description: Archived Changelog wiki page, containing release information between Flutter 0.0.21 and 1.0.0.
---

_This page is a dump of the old Changelog page from the Flutter wiki up until
[Flutter release notes](release-notes) were published in flutter.dev._

## Changes through and including 1.0.0

* Skia and engine rolls to address the following:
  * [video_player image distortion problem after last flutter update 0.11.3](https://github.com/flutter/flutter/issues/24402)
  * [Green, flickering bar over camera preview](https://github.com/flutter/flutter/issues/24289)
  * [Image rendering issues on Adreno 3xx devices after upgrade from 0.9.4 to 0.10.2](https://github.com/flutter/flutter/issues/24517)
* Engine rolls to fix 
  * [Prepend [NSLocale currentLocale] for first locale on iOS to ensure countryCode exists. Allow language-only locales.](https://github.com/flutter/engine/issues/6995)
  * [Changes to unblock Fuchsia roll](https://github.com/flutter/engine/issues/6949)
* Various fixes to tooling for documentation, documentation, and documentation accompanying the templates.

## Changes since v0.10.2
* [flutter/engine#6883](https://github.com/flutter/engine/pull/6883) - FlutterViewController will no longer load your app's splash screen by default.  The implementation of that has been moved to a new method `loadDefaultSplashScreenView`.
* [#23755](https://github.com/flutter/flutter/pull/23755) Removed direct dependency of flutter_test on `package:test`. Flutter now requires test version 1.5.1 and mockito version 4.0.0. 

  ### Breaking change:
  This requires adding an explicit dependency to your pubspec.yaml: 
  ```yaml
  dev_dependencies:
    test: ^1.5.1
  ```
* [#24024](https://github.com/flutter/flutter/pull/24024) and [flutter/engine#6760](https://github.com/flutter/engine/pull/6760) Upgraded harfbuzz to 2.1.0, Significantly improved text layout, and zero-width-joiner (zwj) support for better emojis on iOS.
* [#23417](https://github.com/flutter/flutter/pull/23417) provide `null` when locale is unavailable or invalid instead of `_`.
* [#23583](https://github.com/flutter/flutter/pull/23583) Improved localization algorithm with scriptCodes and full preferred locales list support, breaking changes to callbacks when locales are changed (pass list instead of single locale).

### v0.11.0
* [#23320](https://github.com/flutter/flutter/pull/23320) Adds back swipe gesture support for Cupertino navigation bars' cross-page transitions.
* [#23320](https://github.com/flutter/flutter/pull/23322) Adds support for Hero transitions across multiple Navigators.

## Changes in v0.10.2 (since v0.9.4) - beta 10

### v0.10.2
* [#23194](https://github.com/flutter/flutter/pull/23194) Adds CupertinoTextField, an iOS styled text entry field.
* [#23221](https://github.com/flutter/flutter/pull/23221) Adds RTL support for Cupertino navigation bars' cross-page transitions.

### v0.10.1
* [#22977](https://github.com/flutter/flutter/pull/22977) replaces most of `Null` by `void`. See [the mail proposing this change](https://groups.google.com/forum/#!topic/flutter-dev/b7TKGqERNTM).
* [#22985](https://github.com/flutter/flutter/pull/22985) Implement correct orthographic projection
* [#23104](https://github.com/flutter/flutter/pull/23104) Update wrapping message
* [#22924](https://github.com/flutter/flutter/pull/22924) Support for disabling interactive TextField caret and selection
* [#22870](https://github.com/flutter/flutter/pull/22870) Use new `mixin` syntax for super-mixins
* [#22022](https://github.com/flutter/flutter/pull/22022) allow command line option "--project-name" in flutter create
* [#23126](https://github.com/flutter/flutter/pull/23126) Dispatch a Flutter.Navigation event each time navigation occurs.
* [#23183](https://github.com/flutter/flutter/pull/23183) Fix bug where gradle build rule would rerun on switching from
* [#22394](https://github.com/flutter/flutter/pull/22394) Fix out of range spring simulation in ClampingScrollSimulation
* [#23174](https://github.com/flutter/flutter/pull/23174) enable lint prefer_void_to_null
* [#23184](https://github.com/flutter/flutter/pull/23184) TextTheme.apply() should not assume non-null TextStyle fields
* [#23168](https://github.com/flutter/flutter/pull/23168) Added Mongolian (mn) translations
* [#23167](https://github.com/flutter/flutter/pull/23167) Fix disabled formfield validation
* [#23015](https://github.com/flutter/flutter/pull/23015) Finalize editing when hitting the enter key on a single line TextField
* [#23021](https://github.com/flutter/flutter/pull/23021) Make it easier to use CocoaPods to Add2App for iOS
* [#22825](https://github.com/flutter/flutter/pull/22825) fix Curves.bounceInOut math
* [#22977](https://github.com/flutter/flutter/pull/22977) Prefer void to null
* [#22822](https://github.com/flutter/flutter/pull/22822) Adds callback for Long Press Up
* [#18770](https://github.com/flutter/flutter/pull/18770) Add `disabledHint` to DropdownButton
* [#21657](https://github.com/flutter/flutter/pull/21657) Make AndroidView take gesture recognizer factories.
* [#22449](https://github.com/flutter/flutter/pull/22449) Add support for text shadows
* [flutter/engine#6644](https://github.com/flutter/engine/pull/6644) Add BoxHeightStyle and BoxWidthStyle as arguments to Paragraph.getBoxesForRange() to obtain various styles of enclosing boxes.
* Skia update that changes the low level implementation of blurs and anti aliasing, which may break golden tests.

### v0.9.7
* [flutter/engine#6393](https://github.com/flutter/engine/pull/6393) adds nullability annotations to Android MethodChannel/MethodCall.

### v0.9.6
* [#21251](https://github.com/flutter/flutter/pull/21251) adds CupertinoDatePicker, an iOS-style picker control that supports a date mode and a date + time mode. 

## Changes in v0.9.4 (since v0.8.2 ) - beta 9

### v0.9.4

* [#21715](https://github.com/flutter/flutter/pull/21715), The default MaterialPageRoute transition is now defined by the Theme. Added (optional) support for Android P style page transitions. The MaterialPageRoute support for "hosting" another route to reuse its buildTransitions() method was removed because PageTransitionsBuilders, including CupertinoPageTransitionBuilder, are standalone objects.

### v0.9.3

* [#22108](https://github.com/flutter/flutter/pull/22108) changed the output of `flutter doctor` slightly, which may affect automated scripts that depended on the exact output.

### v0.9.2

* [#21540](https://github.com/flutter/flutter/pull/21540) added a `transform()` method to [`Animatable`](https://docs.flutter.io/flutter/animation/Animatable-class.html). It is implemented by `Tween` (the main subclass of `Animatable`) but classes that subclass `Animatable` directly will need to implement it. Typically the existing `evaluate()` method can be changed to implement `transform()` instead, using the value given by the argument to `transform()` rather than the current value of the animation provided to `evaluate()`. `evaluate()` now has a default implementation that defers to `transform()`.

## Changes in v0.8.2 (since v0.7.3) - beta 8

### v0.7.4
* [#20322](https://github.com/flutter/flutter/pull/20322) performs parallax transitions between `CupertinoNavigationBar`s and `CupertinoSliverNavigationBar`s when navigating between pages.

## Changes in v0.7.3 (since v0.6.0) - beta 7

### v0.7.3
* [#20966](https://github.com/flutter/flutter/pull/20966) adds `CupertinoTimerPicker`.

### v0.7.2
* [#20929](https://github.com/flutter/flutter/pull/20929) fixes bug where `CupertinoPageScaffold` wasn't insetting its content when the keyboard is shown.

### v0.7.1
* [#19637](https://github.com/flutter/flutter/pull/19637) `CupertinoNavigationBar` and `CupertinoSliverNavigationBar` now auto-populate their title and back button labels based on their `CupertinoPageRoute.title`.

## Changes in v0.6.0 (since v0.5.1) - beta 6

### v0.6.0
* Dart SDK updated to a Dart 2 build (2.1.0-dev.0.0). Package and plugin authors should ensure their `pubspec.yaml` files include a Dart SDK constraint with an upper bound of `<3.0.0`. See the [Getting ready for Dart 2 post](https://medium.com/dartlang/getting-ready-for-dart-2-and-making-your-packages-look-great-on-the-pub-site-118464d7f59d) for details.
* [#19025](https://github.com/flutter/flutter/pull/19025) renamed `CupertinoRefreshControl` to `CupertinoSliverRefreshControl` for consistency.
* [#19317](https://github.com/flutter/flutter/pull/19317) Add cursorWidth and cursorRadius to TextField (Material) cursor.
* [#20116](https://github.com/flutter/flutter/pull/20116) reduced release binary sizes by ~2MB
* [#20267](https://github.com/flutter/flutter/pull/20267) adds `CupertinoSegmentedControl'.
* [#19232](https://github.com/flutter/flutter/pull/19232) adds `CupertinoActionSheet` for iOS-style bottom pop-up sheets.
* [#20101](https://github.com/flutter/flutter/pull/20101) improves `CupertinoScrollbar` visual fidelity during overscrolls.
* [#19789](https://github.com/flutter/flutter/pull/19789) adds support for infinite scrolling and looped scrolling for `CupertinoPicker`.
* [#18381](https://github.com/flutter/flutter/pull/18381) improves visual fidelity of `CupertinoAlertDialog`.

### v0.5.8
* [#19284](https://github.com/flutter/flutter/pull/19284) adds multi-column `CupertinoPicker` support for off-axis cylindrical projection.

### v0.5.7
* [#18469](https://github.com/flutter/flutter/pull/18469) added a `CupertinoApp` for creating iOS styled apps.

### v0.5.6
* [#18614](https://github.com/flutter/flutter/pull/18614) added `isInstanceOf` as a function exported from Flutter, because package:matcher has deprecated its implementation of `isInstanceOf`.
* [flutter/engine#5517](https://github.com/flutter/engine/pull/5517) enabled the `--sync-async` Dart flag.

### v0.5.5

* [#18488](https://github.com/flutter/flutter/pull/18488) made the `--debug-port` argument to `flutter trace` required, because the previous behaviour was unreliable and caused flaky tests.

### v0.5.2

* [#18096](https://github.com/flutter/flutter/pull/18096) changed the rendering of the character counter in text fields to more closely match the Material design specifications.

## Changes in v0.5.1 (since v0.3.2) - beta 5

### v0.5.0

* [#17661](https://github.com/flutter/flutter/pull/17661) changed the layout and size of `ListTile` to better conform to the latest Material design specs.

* [#17620](https://github.com/flutter/flutter/pull/17620) slightly reduces the default dimensions of `Checkbox`, `Radio`, and `Switch` to better conform to the latest Material design specs.

* [#17637](https://github.com/flutter/flutter/pull/17637) updates `Checkbox`, `Radio`, and `Switch` to use the `ThemeData` `toggleableActiveColor`. If you are using a light theme and are not specifying an `accentColor` in your `ThemeData`, these controls will now use a higher contrast shade from the primary swatch.

* [#17586](https://github.com/flutter/flutter/pull/17586) added a new `background` property to `TextStyle`. Subclasses must ensure that this property is handled in constructors and `copyWith`.

## Changes in v0.4.4 (since v0.3.2) - beta 4

### v0.4.0
* [#17021](https://github.com/flutter/flutter/pull/17021) added implicit a11y scrolling for iOS. For this, viewports define a cache extend before the leading as well as after the trailing edge and slivers are expected to provide semantics information if they fall into the cache extent.

  ### Breaking change
  With this change, children of a viewport that are currently not visible in the viewport are now considered off-stage. To find them in a test, specify `skipOffstage: false` on the Finder.

### v0.3.6

* [#17094](https://github.com/flutter/flutter/pull/17094) introduced the ability to do golden image testing in widget tests.  Within a widget test, you can now use the following matcher to ensure that your widget's rasterized image matches a golden file (e.g. `foo.png`):

  ```dart
  await expectLater(find.byType(MyWidget), matchesGoldenFile('foo.png'));
  ```

  ### Breaking change

  One of the consequences of this change is that all tests run through `flutter test` now explicitly depend on `package:flutter_test`.  Users of `flutter test` will need to update their `pubspec.yaml` file to include the following if it does not already exist:

  ```
  dev_dependencies:
    flutter_test:
      sdk: flutter
  ```

  If your `pubspec.yaml` does not contain the requisite dependency, and you run `flutter test`, you will see errors of the following form:

  ```
  compiler message: Error: Could not resolve the package 'flutter_test' in 'package:flutter_test/flutter_test.dart'.
  ```

### v0.3.3

* [flutter/engine#5060](https://github.com/flutter/engine/pull/5060) introduced the ability to encode a `dart:ui Image` into a PNG via `Image.toByteData()`.  Callers wishing to get encoded bytes may pass the `format` argument, like so:

  ```dart
  image.toByteData(format: ui.ImageByteFormat.png);
  ```

## Changes in v0.3.2 (since v0.3.1) - beta 3

## Changes in v0.3.1 (since v0.2.8) - beta 2 update

We are aware of a potential problem with certificate validation in the `HttpClient` implementation.
To follow our investigation, see [Dart issue 32936](https://github.com/dart-lang/sdk/issues/32936).

### v0.3.1

* [flutter/engine#4932](https://github.com/flutter/engine/pull/4932) introduced a new shell embedding API with numerous new features.  In particular, a single process can now host multiple Flutter shells.

* [flutter/engine#4762](https://github.com/flutter/engine/pull/4762) and [flutter/engine#5008](https://github.com/flutter/engine/pull/5008) introduced `Image.toByteData()`, which is used to get the raw RGBA bytes of an `Image` instance in `dart:ui`.

* [#16721](https://github.com/flutter/flutter/pull/16721) scroll motion starts on iOS has been fine tuned to avoid a jump when the scroll first starts moving and to more closely mirror native behavior.

### v0.2.11

* [#16039](https://github.com/flutter/flutter/pull/16039) and [#16447](https://github.com/flutter/flutter/pull/16447) substantially revised the `Chip` implementation, added new chip types: `InputChip`, `ChoiceChip`, `FilterChip`, `ActionChip`, and updated the appearance of chips.

### v0.2.9

* [#16187](https://github.com/flutter/flutter/pull/16187) updated the `Card` widget's shape and elevation.

### Dart changes since Flutter v0.2.8

* `dart:async`: Removed the deprecated `defaultValue` parameter on `Stream.firstWhere` and `Stream.lastWhere`.
* `dart:core`: Added `tryParse` static method to `int`, `double`, `num`, `BigInt`, `Uri` and `DateTime`, and deprecated `onError` parameter on `int.parse`, `double.parse`, and `num.parse`.
* The `new` keyword can now always be omitted. The `const` keyword is required to create a constant expression, although within the expression, further `const` keywords can also be omitted.

## Changes in v0.2.8 (since v0.2.3) - beta 2

### v0.2.8

* [#16040](https://github.com/flutter/flutter/pull/16040) adds an API to let `CupertinoTabScaffold`'s current tab be programmatically changed via its `CupertinoTabBar`'s `currentIndex`.

### v0.2.5

* [#15416](https://github.com/flutter/flutter/pull/15416) removed `package:http` from Flutter and replaced all usages with the `HttpClient` from `dart:io`. If you use `package:http` you must add it as a dependency in your `pubspec.yaml` to continue using it.

  `createHttpClient()` was also removed after being marked deprecated. To change how the framework creates http clients, you can use [HttpOverrides](https://docs.flutter.io/flutter/dart-io/HttpOverrides-class.html) from `dart:io` to provide your own `createHttpClient()` callback globally or per zone.

  More details are available [in the announcement](https://groups.google.com/forum/#!topic/flutter-dev/AnqDqgQ6vus).

* [#15871](https://github.com/flutter/flutter/pull/15871) changed the default configuration of the `AndroidManifest.xml` created by `flutter create`.  "screenLayout" and "density" are now included by default in the configChanges attribute, preventing flutter apps from restarting when these change.

* [#15324](https://github.com/flutter/flutter/pull/15324) adds a new CupertinoRefreshControl widget styled after the iOS pull-to-refresh pattern. Demo available in the Flutter Gallery.

### v0.2.4

* [#15565](https://github.com/flutter/flutter/pull/15565) turned Dart 2 mode on by default.  To run in Dart 1 mode, you can still use `--no-preview-dart-2`.

  More details are available [in the announcement](https://groups.google.com/d/msg/flutter-dev/H8dDhWg_c8I/_Ql78q_6AgAJ).

* [#15537](https://github.com/flutter/flutter/pull/15537) removed SemanticsSortOrder. From now on traversal sorting is done among sibling nodes only.

  More details available [in the announcement](https://groups.google.com/forum/#!topic/flutter-dev/iCoLnW31heE).

* [#15484](https://github.com/flutter/flutter/pull/15484) changed the meaning of the `TextFormField` `initialValue` constructor parameter.

  The TextFormField initialValue parameter no longer unconditionally initializes the text property of its TextEditingController. If you create a TextFormField and provide a controller, the initialValue must be null, which is now the default. If you're providing a controller you can specify it's initial text value with the TextEditingController text property.

  > #### Before
  >     new TextFormField(
  >       initialValue: 'Hello World',
  >       controller: _myTextEditingController,
  >     );
  >
  > #### After
  >     new TextFormField(
  >       controller: _myTextEditingController ..text = 'Hello World',
  >     )
  >     // Or more typically:
  >     _myTextEditingController = new TextEditingController(
  >       text: 'Hello World',
  >     );
  >     new TextFormField(
  >       controller: _myTextEditingController,
  >     );

* [#15303](https://github.com/flutter/flutter/pull/15303) updated the `showDialog` function to take a builder and deprecated the `widget` parameter.

  > #### Before
  >     showDialog(context: context, child: new Text('hello'))
  >
  > #### After
  >     showDialog(context: context, builder: (BuildContext context) => new Text('hello'))

* [#15265](https://github.com/flutter/flutter/pull/15265) updated `ThemeData` to use the primary color of a `MaterialColor` instead of unconditionally using the 500 shade for light themes.  The color values remain unchanged.

  > #### Before
  >     expect(widget.color, Colors.blue.shade500) // primary color
  >
  > #### After
  >     expect(widget.color, Colors.blue) // primary color

* [#15548](https://github.com/flutter/flutter/pull/15548) adds debugging flags `debugDisableClipLayers`, `debugDisablePhysicalShapeLayers` and `debugDisableOpacityLayers` to help with performance diagnosis of rasterizing speed.

## Changes in v0.2.3 (since v0.1.5) - beta 1 update

### v0.2.0

* [flutter/engine#4742](https://github.com/flutter/engine/pull/4742) updated assets to be read directly out of the APK on Android. As a result, leading slashes are no longer supported in image asset paths:

  > #### Before
  >     new Image.asset('/foo/bar.png')
  >
  > #### After:
  >     new Image.asset('foo/bar.png')

### v0.1.9

* [#14901](https://github.com/flutter/flutter/pull/14901) A [Slider](https://docs.flutter.io/flutter/material/Slider-class.html) visual update changed the colors, opacities, and the value indicator shape and behavior. It also removed the "`thumbOpenAtMin`" flag from the Slider class, which is no longer needed, and can be emulated by the custom thumb shape support.

## Changes in v0.1.5 (since v0.1.4) - beta 1.1

### v0.1.5

* [#14714](https://github.com/flutter/flutter/pull/14714) fixed the groovy script for the Flutter Gallery, thus fixing [#14912](https://github.com/flutter/flutter/issues/14912).

## Changes in v0.1.4 (since v0.0.20) - beta 1

### v0.1.3

* [#14702](https://github.com/flutter/flutter/pull/14702) removed the `engineDartVersion` getter from the flutter tool's `Version` class.

### v0.1.1

* [flutter/engine#4607](https://github.com/flutter/engine/pull/4607) and [#14601](https://github.com/flutter/flutter/pull/14601) removed default constructors from the following `dart:ui` classes:

  * `Codec`
  * `FrameInfo`
  * `Gradient`
  * `Image`
  * `Paragraph`
  * `Picture`
  * `Scene`
  * `SemanticsUpdate`
  * `Shader`

  The default constructors were removed to prevent the creation of uninitialized instances of these classes (and in certain cases to prevent extending these classes). These classes should be instantiated only by the Flutter engine or through named constructors (if provided).

### v0.0.24

* [#14410](https://github.com/flutter/flutter/pull/14410) contained a breaking API change to `ButtonTheme`:

  * The constructors `ButtonTheme()` and `ButtonTheme.bar()` are no longer `const` constructible
  * `ButtonTheme.textTheme` is now `ButtonTheme.data.textTheme`
  * `ButtonTheme.minWidth` is now `ButtonTheme.data.minWidth`
  * `ButtonTheme.height` is now `ButtonTheme.data.height`
  * `ButtonTheme.padding` is now `ButtonTheme.data.padding`

* [#14410](https://github.com/flutter/flutter/pull/14410) changed the hierarchy of `FlatButton` and `RaisedButton` - they both inherit from `RawMaterialButton` now rather than from `MaterialButton`.

* [#14410](https://github.com/flutter/flutter/pull/14410) changed `RaisedButton` to no longer cast a shadow when disabled.

### v0.0.23

* [#14343](https://github.com/flutter/flutter/pull/14343) revised how copy, cut, and paste works for EditableText: The abstract class TextSelectionControls has new methods canCopy, canCut, etc. to determine if those actions are available. The TextSelectionDelegate interface now requires an additional method bringIntoView(TextPosition position) to scroll a TextPosition into the visible part of a TextField. Furthermore, that interface is no longer implemented by TextSelectionOverlay. In its place EditableTextState should be used, which implements that interface. See also: [flutter-dev/IHPndyUDy0M](https://groups.google.com/forum/#!topic/flutter-dev/IHPndyUDy0M)

#### Sliver APIs

* [#14449](https://github.com/flutter/flutter/pull/14449) replaces the `SliverGridLayout.estimateMaxScrollOffset` method by the `SliverGridLayout.computeMaxScrollOffset` method. This new method must report an accurate value, not just an estimate. This was necessary to fix a bug where a finite `SliverGrid` could not handle being scrolled off the top of the screen (because we had no way to determine how much content it had).

  For similar reasons, the `RenderSliverBoxChildManager` interface has a new getter, `childCount`, which must return a non-null value if `createChild` can return null. In practice, it is unusual to implement this interface, so this should have no effect. It is more common to implement the widgets-layer equivalent, `SliverChildDelegate`. This interface already had an `estimatedChildCount` getter. The getter continues to exist, though its semantics have been adjusted a little to require that the returned value be accurate if the `build` method on the delegate ever returns null.

### v0.0.21

* [#13734](https://github.com/flutter/flutter/pull/13734), [#14055](https://github.com/flutter/flutter/pull/14055), and [#14177](https://github.com/flutter/flutter/pull/14177) substantially revised the InputDecorator et al. widgets. The layout of the input decorator's parts has changed a little, which means that the internal layout of text fields has changed as well. Tests that depend on the internal geometry of text fields will need to be updated.

  In addition, `hideDivider: true` must be replaced by the new `border: InputBorder.none`. This is part of our making it easier to customize how inputs are rendered; you can now also provide a custom InputBorder subclass if you have particularly novel desires for your input decoration.

* [#4528](https://github.com/flutter/engine/pull/4528) and [#14011](https://github.com/flutter/flutter/pull/14011) deprecated support for big integers in the standard platform channel message/method codecs, to be made unavailable following a four week grace period. This change is a consequence of the transition to Dart
2.0 where the `int` type is no longer unlimited size.

* [#4487](https://github.com/flutter/engine/pull/4487) replaces all uses of the `RequestPermissionResult` callback concept in `io.flutter.plugin.common.PluginRegistry` with `RequestPermissionsResult`, adding a missing `s` to align with the corresponding Android SDK concept.

  The old API has been deprecated and will be made unavailable in a later release. There will be a grace period of at least four weeks between the release that introduces the deprecation and the release that makes the old API unavailable.
  