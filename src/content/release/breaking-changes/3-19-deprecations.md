---
title: Deprecated API removed after v3.19
description: >-
  After reaching end of life, the following deprecated APIs
  were removed from Flutter.
---

## Summary

In accordance with Flutter's [Deprecation Policy][],
deprecated APIs that reached end of life after the
3.19 stable release have been removed.

All affected APIs have been compiled into this
primary source to aid in migration.
To further aid your migration, check out this
[quick reference sheet][].

[Deprecation Policy]: {{site.repo.flutter}}/blob/master/docs/contributing/Tree-hygiene.md#deprecations
[quick reference sheet]: /go/deprecations-removed-after-3-19

## Changes

This section lists the deprecations by the package and affected class.

### `TextTheme`

Package: flutter
Supported by Flutter Fix: yes

Several `TextStyle` properties of `TextTheme` were deprecated in v3.1 to support new
stylings from the Material Design specification. They
are listed in the following table alongside the appropriate replacement in the
new API.

| Deprecation | New API |
|---|---|
| headline1	| displayLarge |
| headline2	| displayMedium |
| headline3	| displaySmall |
| headline4	| headlineMedium |
| headline5	| headlineSmall |
| headline6	| titleLarge |
| subtitle1	| titleMedium |
| subtitle2	| titleSmall |
| bodyText1	| bodyLarge |
| bodyText2	| bodyMedium |
| caption	  | bodySmall |
| button	  | labelLarge |
| overline	| labelSmall |

**Migration guide**

Code before migration:

```dart
// TextTheme
// Base constructor
TextTheme(
  headline1: headline1Style,
  headline2: headline2Style,
  headline3: headline3Style,
  headline4: headline4Style,
  headline5: headline5Style,
  headline6: headline6Style,
  subtitle1: subtitle1Style,
  subtitle2: subtitle2Style,
  bodyText1: bodyText1Style,
  bodyText2: bodyText2Style,
  caption: captionStyle,
  button: buttonStyle,
  overline: overlineStyle,
);

// copyWith
TextTheme.copyWith(
  headline1: headline1Style,
  headline2: headline2Style,
  headline3: headline3Style,
  headline4: headline4Style,
  headline5: headline5Style,
  headline6: headline6Style,
  subtitle1: subtitle1Style,
  subtitle2: subtitle2Style,
  bodyText1: bodyText1Style,
  bodyText2: bodyText2Style,
  caption: captionStyle,
  button: buttonStyle,
  overline: overlineStyle,
);

// Getters
TextStyle style;
style = textTheme.headline1,
style = textTheme.headline2,
style = textTheme.headline3,
style = textTheme.headline4,
style = textTheme.headline5,
style = textTheme.headline6,
style = textTheme.subtitle1,
style = textTheme.subtitle2,
style = textTheme.bodyText1,
style = textTheme.bodyText2,
style = textTheme.caption,
style = textTheme.button,
style = textTheme.overline,
```

Code after migration:

```dart
// TextTheme
// Base constructor
TextTheme(
  displayLarge: headline1Style,
  displayMedium: headline2Style,
  displaySmall: headline3Style,
  headlineMedium: headline4Style,
  headlineSmall: headline5Style,
  titleLarge: headline6Style,
  titleMedium: subtitle1Style,
  titleSmall: subtitle2Style,
  bodyLarge: bodyText1Style,
  bodyMedium: bodyText2Style,
  bodySmall: captionStyle,
  labelLarge: buttonStyle,
  labelSmall: overlineStyle,
);

TextTheme.copyWith(
  displayLarge: headline1Style,
  displayMedium: headline2Style,
  displaySmall: headline3Style,
  headlineMedium: headline4Style,
  headlineSmall: headline5Style,
  titleLarge: headline6Style,
  titleMedium: subtitle1Style,
  titleSmall: subtitle2Style,
  bodyLarge: bodyText1Style,
  bodyMedium: bodyText2Style,
  bodySmall: captionStyle,
  labelLarge: buttonStyle,
  labelSmall: overlineStyle,
);

TextStyle style;
style = textTheme.displayLarge;
style = textTheme.displayMedium;
style = textTheme.displaySmall;
style = textTheme.headlineMedium;
style = textTheme.headlineSmall;
style = textTheme.titleLarge;
style = textTheme.titleMedium;
style = textTheme.titleSmall;
style = textTheme.bodyLarge;
style = textTheme.bodyMedium;
style = textTheme.bodySmall;
style = textTheme.labelLarge;
style = textTheme.labelSmall;
```

**References**

API documentation:

* [`TextTheme`][]

Relevant PRs:

* Deprecated in [#109817][]
* Removed in [#139255][]

[`TextTheme`]: {{site.api}}/flutter/material/TextTheme-class.html

[#109817]: {{site.repo.flutter}}/pull/109817
[#139255]: {{site.repo.flutter}}/pull/139255

---

### `ThemeData`

Package: flutter
Supported by Flutter Fix: yes

Several `Color` properties of `ThemeData` were deprecated in v3.3 to support new stylings
from the Material Design specification. These colors were `errorColor`, `backgroundColor`,
 `bottomAppBarColor`, and `toggleableActiveColor`. The first two are replaced by
 properties of the `ThemeData.colorScheme`, while `bottomAppBarColor` is replaced by the
 color of the component theme, `BottomAppBarTheme`. The `toggleableActiveColor` was no
 longer used by the framework and was removed.

**Migration guide**

Code before migration:

```dart
var myTheme = ThemeData(
  //...
  errorColor: Colors.red,
  backgroundColor: Colors.blue,
  bottomAppBarColor: Colors.purple,
  toggleableActiveColor: Colors.orange,
  //...
);
var errorColor = myTheme.errorColor;
var backgroundColor = myTheme.backgroundColor;
var bottomAppBarColor = myTheme.bottomAppBarColor;
var toggleableActiveColor = myTheme.toggleableActiveColor;
```

Code after migration:

```dart
var myTheme = ThemeData(
  //...
  colorScheme: ColorScheme(
    /// ...
    error: Colors.red,
    background: Colors.blue,
  ),
  bottomAppBarTheme: BottomAppBarTheme(
    color: Colors.purple,
  ),
  //...
);
var errorColor = myTheme.colorScheme.error;
var backgroundColor = myTheme.colorScheme.background;
var bottomAppBarColor = myTheme.bottomAppBarTheme.color;
var toggleableActiveColor = Colors.orange;
```

**References**

API documentation:

* [`ThemeData`][]
* [`ColorScheme`][]
* [`BottomAppBarTheme`][]

Relevant PRs:

* Deprecated in [#110162][], [#111080][], and [#97972][]
* Removed in [#144178][], [#144080][], [#144079][], and [#144078][]

[`ThemeData`]: {{site.api}}/flutter/material/ThemeData-class.html
[`ColorScheme`]: {{site.api}}/flutter/material/ColorScheme-class.html
[`BottomAppBarTheme`]: {{site.api}}/flutter/material/BottomAppBarTheme-class.html

[#110162]: {{site.repo.flutter}}/pull/110162
[#111080]: {{site.repo.flutter}}/pull/111080
[#97972]: {{site.repo.flutter}}/pull/97972
[#144178]: {{site.repo.flutter}}/pull/144178
[#144080]: {{site.repo.flutter}}/pull/144080
[#144079]: {{site.repo.flutter}}/pull/144079
[#144078]: {{site.repo.flutter}}/pull/144078

---

### `CupertinoContextMenu.previewBuilder`

Package: flutter
Supported by Flutter Fix: yes

The `previewBuilder` was replaced by the `builder` of `CupertinoContextMenu` after
v3.4. By adding `builder`, the entirety of the animation executed by the context
menu is covered, the second half of which was performed by `previewBuilder`, and
delineated by `CupertinoContextMenu.animationOpensAt`.


**Migration guide**

Code before migration:

```dart
CupertinoContextMenu(
  previewBuilder: (BuildContext context, Animation<double> animation, Widget child) {
    return FittedBox(
      fit: BoxFit.cover,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(64.0 * animation.value),
        child: Image.asset('assets/photo.jpg'),
      ),
    );
  },
  actions: <Widget>[
    CupertinoContextMenuAction(
      child: const Text('Action one'),
      onPressed: () {},
    ),
  ],
  child: FittedBox(
    fit: BoxFit.cover,
    child: Image.asset('assets/photo.jpg'),
  ),
);
```

Code after migration:

```dart
CupertinoContextMenu(
  actions: <Widget>[
    CupertinoContextMenuAction(
      child: const Text('Action one'),
      onPressed: () {},
    ),
  ],
  builder: (BuildContext context, Animation<double> animation) {
    final Animation<BorderRadius?> borderRadiusAnimation = BorderRadiusTween(
      begin: BorderRadius.circular(0.0),
      end: BorderRadius.circular(CupertinoContextMenu.kOpenBorderRadius),
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: Interval(
          CupertinoContextMenu.animationOpensAt,
          1.0,
        ),
      ),
    );

    final Animation<Decoration> boxDecorationAnimation = DecorationTween(
      begin: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        boxShadow: <BoxShadow>[],
      ),
      end: BoxDecoration(
        color: Color(0xFFFFFFFF),
        boxShadow: CupertinoContextMenu.kEndBoxShadow,
      ),
    ).animate(
      CurvedAnimation(
        parent: animation,
        curve: Interval(
          0.0,
          CupertinoContextMenu.animationOpensAt,
        )
      )
    );

    return Container(
      decoration: animation.value < CupertinoContextMenu.animationOpensAt
        ? boxDecorationAnimation.value
        : null,
      child: FittedBox(
        fit: BoxFit.cover,
        child: ClipRRect(
          borderRadius: borderRadiusAnimation.value ?? BorderRadius.circular(0.0),
          child: SizedBox(
            height: 150,
            width: 150,
            child: Image.asset('assets/photo.jpg'),
          ),
        ),
      )
    );
   }
 )
```

**References**

API documentation:

* [`CupertinoContextMenu`][]

Relevant PRs:

* Deprecated in [#110616][]
* Removed in [#143990][]

[`CupertinoContextMenu`]: {{site.api}}/flutter/cupertino/CupertinoContextMenu-class.html

[#110616]: {{site.repo.flutter}}/pull/110616
[#143990]: {{site.repo.flutter}}/pull/143990

---

### `Scrollbar.showTrackOnHover`

Package: flutter
Supported by Flutter Fix: yes

The `showTrackOnHover` property of `Scrollbar`, and its associated component theme,
`ScrollbarThemeData.showTrackOnHover`, were replaced by the stateful property
`ScrollbarThemeData.trackVisibility` after v3.4. By utilizing `trackVisibility`,
all permutations of state can factor into revealing the scrollbar track, not
just hover.


**Migration guide**

Code before migration:

```dart
Scrollbar(
  showTrackOnHover: true,
  child: //...
);
ScrollbarThemeData(
  showTrackOnHover: true,
);
```

Code after migration:

```dart
Scrollbar(
  child: //...
);
ScrollbarThemeData(
  // This will always show the track for any state.
  trackVisibility: MaterialStateProperty<bool>.all(true),
);
// Or
ScrollbarThemeData(
  // Only show on hover.
  trackVisibility: (Set<MaterialState> states) => states.contains(MaterialState.hovered),
);
```

**References**

API documentation:

* [`Scrollbar`][]
* [`ScrollbarThemeData`][]
* [`MaterialState`][]
* [`MaterialStateProperty`][]

Relevant PRs:

* Deprecated in [#111706][]
* Removed in [#144180][]

[`Scrollbar`]: {{site.api}}/flutter/material/Scrollbar-class.html
[`ScrollbarThemeData`]: {{site.api}}/flutter/material/ScrollbarThemeData-class.html
[`MaterialState`]: {{site.api}}/flutter/material/MaterialState-class.html
[`MaterialStateProperty`]: {{site.api}}/flutter/material/MaterialStateProperty-class.html

[#111706]: {{site.repo.flutter}}/pull/111706
[#144180]: {{site.repo.flutter}}/pull/144180

---

### `KeepAliveHandle.release` method

Package: flutter
Supported by Flutter Fix: no

The `release` method of `KeepAliveHandle` was removed and replaced by calling
`dispose` after v3.3. This change was made because `release` was found to often
be called without then calling `dispose`, leading to memory leaks. The `dispose`
method executes the same functionality as `release` did now.


**Migration guide**

Code before migration:

```dart
KeepAliveHandle handle = KeepAliveHandle();
handle.release();
handle.dispose();
```

Code after migration:

```dart
KeepAliveHandle handle = KeepAliveHandle();
handle.dispose();
```

**References**

API documentation:

* [`KeepAliveHandle`][]

Relevant PRs:

* Deprecated in [#108384][]
* Removed in [#143961][]

[`KeepAliveHandle`]: {{site.api}}/flutter/widgets/KeepAliveHandle-class.html

[#108384]: {{site.repo.flutter}}/pull/108384
[#143961]: {{site.repo.flutter}}/pull/143961

---

### `InteractiveViewer.alignPanAxis`

Package: flutter
Supported by Flutter Fix: yes

The `alignPanAxis` property of `InteractiveViewer` was removed and replaced with
`panAxis` after v3.3. This change was made to enable more modes of panning in
`InteractiveViewer`.


**Migration guide**

Code before migration:

```dart
InteractiveViewer(
  alignPanAxis: true,
);
```

Code after migration:

```dart
InteractiveViewer(
  panAxis: PanAxis.aligned,
);
```

**References**

API documentation:

* [`InteractiveViewer`][]
* [`PanAxis`][]

Relevant PRs:

* Deprecated in [#109014][]
* Removed in [#142500][]

[`InteractiveViewer`]: {{site.api}}/flutter/widgets/InteractiveViewer-class.html
[`PanAxis`]: {{site.api}}/flutter/widgets/PanAxis.html

[#109014]: {{site.repo.flutter}}/pull/109014
[#142500]: {{site.repo.flutter}}/pull/142500

---

### `MediaQuery.boldTextOverride`

Package: flutter
Supported by Flutter Fix: yes

The `boldTextOverride` method of `MediaQuery` was removed and replaced with
`boldTextOf` after v3.5. This change was made as part of larger refactor of
`MediaQuery`, most notably reducing the number of rebuilds that would be
triggered by widgets that depend on it.


**Migration guide**

Code before migration:

```dart
MediaQuery.boldTextOverride(context);
```

Code after migration:

```dart
MediaQuery.boldTextOf(context)
```

**References**

API documentation:

* [`MediaQuery`][]

Relevant PRs:

* Deprecated in [#114459][]
* Removed in [#143960][]

[`MediaQuery`]: {{site.api}}/flutter/widgets/MediaQuery-class.html

[#114459]: {{site.repo.flutter}}/pull/114459
[#143960]: {{site.repo.flutter}}/pull/143960

---

### Renamed builder typedefs for `AnimatedList`

Package: flutter
Supported by Flutter Fix: no

With the addition of `AnimatedGrid`, `AnimatedList` was refactored to share a common base
class. The previously named `AnimatedListItemBuilder` and `AnimatedListRemovedItemBuilder`
were renamed to better reflect the classes they could be used with after v3.5.
Rename any references to `AnimatedItemBuilder` and `AnimatedRemovedItemBuilder`.

**References**

API documentation:

* [`AnimatedGrid`][]
* [`AnimatedList`][]
* [`AnimatedItemBuilder`][]
* [`AnimatedRemovedItemBuilder`][]

Relevant PRs:

* Deprecated in [#113793][]
* Removed in [#143974][]

[`AnimatedGrid`]: {{site.api}}/flutter/widgets/AnimatedGrid-class.html
[`AnimatedList`]: {{site.api}}/flutter/widgets/AnimatedList-class.html
[`AnimatedItemBuilder`]: {{site.api}}/flutter/widgets/AnimatedItemBuilder.html
[`AnimatedRemovedItemBuilder`]: {{site.api}}/flutter/widgets/AnimatedRemovedItemBuilder.html

[#113793]: {{site.repo.flutter}}/pull/113793
[#143974]: {{site.repo.flutter}}/pull/143974

---

### `FlutterDriver.enableAccessibility`

Package: flutter_driver
Supported by Flutter Fix: yes

The `enableAccessibility` method of `flutterDriver` was deprecated in v2.3. It
was removed and replaced with `setSemantics`. This change made is possible to
enable or disable accessibility, rather than only enable it.

**Migration guide**

Code before migration:

```dart
FlutterDriver driver = FlutterDriver.connectedTo(
  // ...
);
driver.enableAccessibility();
```

Code after migration:

```dart
FlutterDriver driver = FlutterDriver.connectedTo(
  // ...
);
driver.setSemantics(true);
```

**References**

API documentation:

* [`FlutterDriver`][]

Relevant PRs:

* Deprecated in [#82939][]
* Removed in [#143979][]

[`FlutterDriver`]: {{site.api}}/flutter/flutter_driver/FlutterDriver-class.html

[#82939]: {{site.repo.flutter}}/pull/82939
[#143979]: {{site.repo.flutter}}/pull/143979

---

### `TimelineSummary.writeSummaryToFile`

Package: flutter_driver
Supported by Flutter Fix: yes

The `writeSummaryToFile` method of `TimelineSummary` was deprecated in v2.1. It
was removed and replaced with `writeTimelineToFile`.

**Migration guide**

Code before migration:

```dart
TimelineSummary summary = TimelineSummary.summarize(
  myTimeline,
);
summary.writeSummaryToFile(
  traceName,
  pretty: true,
);
```

Code after migration:

```dart
TimelineSummary summary = TimelineSummary.summarize(
  myTimeline,
);
summary.writeTimelineToFile(
  traceName,
  pretty: true,
);
```

**References**

API documentation:

* [`TimelineSummary`][]

Relevant PRs:

* Deprecated in [#79310][]
* Removed in [#143983][]

[`TimelineSummary`]: {{site.api}}/flutter/flutter_driver/TimelineSummary-class.html

[#79310]: {{site.repo.flutter}}/pull/79310
[#143983]: {{site.repo.flutter}}/pull/143983

### `Android Platform Views on API 22 and below `

Supported by Flutter Fix: no

As of Flutter 3.0 platform views require api 23 or higher. In Flutter 3.19 we now throw UnsupportedOperationException 
when using platform views on android devices running api level 22 and below. 

**Migration guide**

Set minimum api level to 23 (or higher) or check the android api level before displaying a platform view. 

---

The [previously announced][] deprecations for context menus, relating to `ToolbarOptions`
as well as parts of `TextSelectionController` and `SelectableRegionState` were not
removed this cycle, to allow more time for migration.
Expect these deprecations to be removed in the next cycle, which will
be announced again when the time comes.

[previously announced]: https://groups.google.com/g/flutter-announce/c/8XjXpUKlnf8

---

## Timeline

In stable release: 3.22.0
