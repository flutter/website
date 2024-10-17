---
title: Breaking changes and migration guides
short-title: Breaking changes
description: A list of migration guides for breaking changes in Flutter.
---

As described in the [breaking change policy][],
on occasion we publish guides
for migrating code across a breaking change.

To be notified about future breaking changes,
join the groups [Flutter announce][] and [Dart announce][].

When facing Dart errors after upgrading Flutter,
consider using the [`dart fix`][] command
to automatically migrate your code.
Not every breaking change is supported in this way,
but many are.

To avoid being broken by future versions of Flutter,
consider submitting your tests to our [test registry].

## Breaking changes by release

The following guides are available. They are sorted by
release, and listed in alphabetical order:

[breaking change policy]: /release/compatibility-policy
[Flutter announce]: {{site.groups}}/forum/#!forum/flutter-announce
[Dart announce]: {{site.groups}}/a/dartlang.org/g/announce
[`dart fix`]: /tools/flutter-fix
[test registry]: {{site.github}}/flutter/tests

### Not yet released to stable

* [`Color` wide gamut support][]
* [Remove invalid parameters for `InputDecoration.collapsed`][]
* [Stop generating `AssetManifest.json`][]
* [Deprecate `TextField.canRequestFocus`][]
* [Set default for SystemUiMode to Edge-to-Edge][]
* [Introduce new Material 3 `Slider` shapes][]

[`Color` wide gamut support]: /release/breaking-changes/wide-gamut-framework
[Remove invalid parameters for `InputDecoration.collapsed`]: /release/breaking-changes/input-decoration-collapsed
[Stop generating `AssetManifest.json`]: /release/breaking-changes/asset-manifest-dot-json
[Deprecate `TextField.canRequestFocus`]: /release/breaking-changes/can-request-focus
[Set default for SystemUiMode to Edge-to-Edge]: /release/breaking-changes/default-systemuimode-edge-to-edge
[Introduce new Material 3 `Slider` shapes]: /release/breaking-changes/introduce-new-slider-shapes

<a id="released-in-flutter-324" aria-hidden="true"></a>
### Released in Flutter 3.24

* [Navigator's page APIs breaking change][]
* [Generic types in `PopScope`][]
* [Deprecate `ButtonBar` in favor of `OverflowBar`][]
* [New APIs for Android plugins that render to a `Surface`][]

[Navigator's page APIs breaking change]: /release/breaking-changes/navigator-and-page-api
[Generic types in `PopScope`]: /release/breaking-changes/popscope-with-result
[Deprecate `ButtonBar` in favor of `OverflowBar`]: /release/breaking-changes/deprecate-buttonbar
[New APIs for Android plugins that render to a `Surface`]: /release/breaking-changes/android-surface-plugins

<a id="released-in-flutter-322" aria-hidden="true"></a>
### Released in Flutter 3.22

* [Deprecated API removed after v3.19][]
* [Rename `MaterialState` to `WidgetState`][]
* [Introduce new `ColorScheme` roles][]
* [Dropping support for Android KitKat][]
* [Nullable `PageView.controller`][]
* [Rename `MemoryAllocations` to `FlutterMemoryAllocations`][]

[Deprecated API removed after v3.19]: /release/breaking-changes/3-19-deprecations
[Rename `MaterialState` to `WidgetState`]: /release/breaking-changes/material-state
[Introduce new `ColorScheme` roles]: /release/breaking-changes/new-color-scheme-roles
[Dropping support for Android KitKat]: /release/breaking-changes/android-kitkat-deprecation
[Nullable `PageView.controller`]: /release/breaking-changes/pageview-controller
[Rename `MemoryAllocations` to `FlutterMemoryAllocations`]: /release/breaking-changes/flutter-memory-allocations

<a id="released-in-flutter-319" aria-hidden="true"></a>
### Released in Flutter 3.19

* [Deprecated API removed after v3.16][]
* [Migrate RawKeyEvent/RawKeyboard system to KeyEvent/HardwareKeyboard system][]
* [Deprecate imperative apply of Flutter's Gradle plugins][]
* [Default multitouch scrolling][]
* [Accessibility traversal order of tooltip changed][]

[Deprecated API removed after v3.16]: /release/breaking-changes/3-16-deprecations
[Migrate RawKeyEvent/RawKeyboard system to KeyEvent/HardwareKeyboard system]: /release/breaking-changes/key-event-migration
[Deprecate imperative apply of Flutter's Gradle plugins]: /release/breaking-changes/flutter-gradle-plugin-apply
[Default multitouch scrolling]: /release/breaking-changes/multi-touch-scrolling
[Accessibility traversal order of tooltip changed]: /release/breaking-changes/tooltip-semantics-order

<a id="released-in-flutter-316" aria-hidden="true"></a>
### Released in Flutter 3.16

* [Migrating to Material 3][]
* [Migrate ShortcutActivator and ShortcutManager to KeyEvent system][]
* [The `ThemeData.useMaterial3` property is now set to true by default][]
* [Deprecated API removed after v3.13][]
* [Customize tabs alignment using the new `TabBar.tabAlignment` property][]
* [Deprecate `textScaleFactor` in favor of `TextScaler`][]
* [Android 14 nonlinear font scaling enabled][]
* [Deprecate `describeEnum` and update `EnumProperty` to be type strict][]
* [Deprecated just-in-time navigation pop APIs for Android Predictive Back][]
* [Deprecated `Paint.enableDithering`][]
* [Updated default text styles for menus][]
* [Windows: External windows should notify Flutter engine of lifecycle changes][]
* [Windows build path changed to add the target architecture][]

[Migrating to Material 3]: /release/breaking-changes/material-3-migration
[Migrate ShortcutActivator and ShortcutManager to KeyEvent system]: /release/breaking-changes/shortcut-key-event-migration
[The `ThemeData.useMaterial3` property is now set to true by default]: /release/breaking-changes/material-3-default
[Deprecated API removed after v3.13]: /release/breaking-changes/3-13-deprecations
[Customize tabs alignment using the new `TabBar.tabAlignment` property]: /release/breaking-changes/tab-alignment
[Deprecate `textScaleFactor` in favor of `TextScaler`]: /release/breaking-changes/deprecate-textscalefactor
[Android 14 nonlinear font scaling enabled]: /release/breaking-changes/android-14-nonlinear-text-scaling-migration
[Deprecate `describeEnum` and update `EnumProperty` to be type strict]: /release/breaking-changes/describe-enum
[Deprecated just-in-time navigation pop APIs for Android Predictive Back]: /release/breaking-changes/android-predictive-back
[Deprecated `Paint.enableDithering`]: /release/breaking-changes/paint-enableDithering
[Updated default text styles for menus]: /release/breaking-changes/menus-text-style
[Windows: External windows should notify Flutter engine of lifecycle changes]: /release/breaking-changes/win-lifecycle-process-function
[Windows build path changed to add the target architecture]: /release/breaking-changes/windows-build-architecture

<a id="released-in-flutter-313" aria-hidden="true"></a>
### Released in Flutter 3.13

* [Added missing `dispose()` for some disposable objects in Flutter][]
* [Deprecated API removed after v3.10][]
* [Added AppLifecycleState.hidden][] enum value
* [Moved ReorderableListView's localized strings][] from material to widgets localizations
* [Removed `ignoringSemantics`][] properties
* [Deprecated `RouteInformation.location`][] and its related APIs
* [Updated EditableText scroll into view behavior][]
* [Migrate a Windows project to ensure the window is shown][]
* [Updated `Checkbox.fillColor` behavior][]

[Added missing `dispose()` for some disposable objects in Flutter]: /release/breaking-changes/dispose
[Deprecated API removed after v3.10]: /release/breaking-changes/3-10-deprecations
[Added AppLifecycleState.hidden]: /release/breaking-changes/add-applifecyclestate-hidden
[Moved ReorderableListView's localized strings]: /release/breaking-changes/material-localized-strings
[Removed `ignoringSemantics`]: /release/breaking-changes/ignoringsemantics-migration
[Deprecated `RouteInformation.location`]: /release/breaking-changes/route-information-uri
[Updated EditableText scroll into view behavior]: /release/breaking-changes/editable-text-scroll-into-view
[Migrate a Windows project to ensure the window is shown]: /release/breaking-changes/windows-show-window-migration
[Updated `Checkbox.fillColor` behavior]: /release/breaking-changes/checkbox-fillColor

<a id="released-in-flutter-310" aria-hidden="true"></a>
### Released in Flutter 3.10

* [Dart 3 changes in Flutter v3.10 and later][]
* [Deprecated API removed after v3.7][]
* [Insert content text input client][]
* [Deprecated the window singleton][]
* [Resolve the Android Java Gradle error][]
* [Require one data variant for `ClipboardData` constructor][]
* ["Zone mismatch" message][]

[Dart 3 changes in Flutter v3.10 and later]: {{site.dart-site}}/resources/dart-3-migration
[Deprecated API removed after v3.7]: /release/breaking-changes/3-7-deprecations
[Insert Content Text Input Client]: /release/breaking-changes/insert-content-text-input-client
[Deprecated the window singleton]: /release/breaking-changes/window-singleton
[Resolve the Android Java Gradle error]: /release/breaking-changes/android-java-gradle-migration-guide
[Require one data variant for `ClipboardData` constructor]: /release/breaking-changes/clipboard-data-required
["Zone mismatch" message]: /release/breaking-changes/zone-errors

<a id="released-in-flutter-37" aria-hidden="true"></a>
### Released in Flutter 3.7

* [Deprecated API removed after v3.3][]
* [Replaced parameters for customizing context menus with a generic widget builder][]
* [iOS FlutterViewController splashScreenView made nullable][]
* [Migrate `of` to non-nullable return values, and add `maybeOf`][]
* [Removed RouteSettings.copyWith][]
* [ThemeData's toggleableActiveColor property has been deprecated][]
* [Migrate a Windows project to support dark title bars][]

[Replaced parameters for customizing context menus with a generic widget builder]: /release/breaking-changes/context-menus
[Deprecated API removed after v3.3]: /release/breaking-changes/3-3-deprecations
[iOS FlutterViewController splashScreenView made nullable]: /release/breaking-changes/ios-flutterviewcontroller-splashscreenview-nullable
[Migrate `of` to non-nullable return values, and add `maybeOf`]: /release/breaking-changes/supplemental-maybeOf-migration
[Removed RouteSettings.copyWith]: /release/breaking-changes/routesettings-copywith-migration
[ThemeData's toggleableActiveColor property has been deprecated]: /release/breaking-changes/toggleable-active-color
[Migrate a Windows project to support dark title bars]: /release/breaking-changes/windows-dark-mode

<a id="released-in-flutter-33" aria-hidden="true"></a>
### Released in Flutter 3.3

* [Adding ImageProvider.loadBuffer][]
* [Default PrimaryScrollController on Desktop][]
* [Trackpad gestures can trigger GestureRecognizer][]
* [Migrate a Windows project to set version information][]

[Adding ImageProvider.loadBuffer]: /release/breaking-changes/image-provider-load-buffer
[Default PrimaryScrollController on Desktop]: /release/breaking-changes/primary-scroll-controller-desktop
[Trackpad gestures can trigger GestureRecognizer]: /release/breaking-changes/trackpad-gestures
[Migrate a Windows project to set version information]: /release/breaking-changes/windows-version-information

### Released in Flutter 3

* [Deprecated API removed after v2.10][]
* [Migrate useDeleteButtonTooltip to deleteButtonTooltipMessage of Chips][]
* [Page transitions replaced by ZoomPageTransitionsBuilder][]

[Deprecated API removed after v2.10]: /release/breaking-changes/2-10-deprecations
[Page transitions replaced by ZoomPageTransitionsBuilder]: /release/breaking-changes/page-transition-replaced-by-ZoomPageTransitionBuilder
[Migrate useDeleteButtonTooltip to deleteButtonTooltipMessage of Chips]: /release/breaking-changes/chip-usedeletebuttontooltip-migration

<a id="released-in-flutter-210" aria-hidden="true"></a>
### Released in Flutter 2.10

* [Deprecated API removed after v2.5][]
* [Raw images on Web uses correct origin and colors][]
* [Required Kotlin version][]
* [Scribble Text Input Client][]

[Deprecated API removed after v2.5]: /release/breaking-changes/2-5-deprecations
[Raw images on Web uses correct origin and colors]: /release/breaking-changes/raw-images-on-web-uses-correct-origin-and-colors
[Required Kotlin version]: /release/breaking-changes/kotlin-version
[Scribble Text Input Client]: /release/breaking-changes/scribble-text-input-client

<a id="released-in-flutter-25" aria-hidden="true"></a>
### Released in Flutter 2.5

* [Default drag scrolling devices][]
* [Deprecated API removed after v2.2][]
* [Change the enterText method to move the caret to the end of the input text][]
* [GestureRecognizer cleanup][]
* [Introducing package:flutter_lints][]
* [Replace AnimationSheetBuilder.display with collate][]
* [ThemeData's accent properties have been deprecated][]
* [Transition of platform channel test interfaces to flutter_test package][]
* [Using HTML slots to render platform views in the web][]
* [Migrate a Windows project to the idiomatic run loop][]

[Change the enterText method to move the caret to the end of the input text]: /release/breaking-changes/enterText-trailing-caret
[Default drag scrolling devices]: /release/breaking-changes/default-scroll-behavior-drag
[Deprecated API removed after v2.2]: /release/breaking-changes/2-2-deprecations
[GestureRecognizer cleanup]: /release/breaking-changes/gesture-recognizer-add-allowed-pointer
[Introducing package:flutter_lints]: /release/breaking-changes/flutter-lints-package
[Replace AnimationSheetBuilder.display with collate]: /release/breaking-changes/animation-sheet-builder-display
[ThemeData's accent properties have been deprecated]: /release/breaking-changes/theme-data-accent-properties
[Transition of platform channel test interfaces to flutter_test package]: /release/breaking-changes/mock-platform-channels
[Using HTML slots to render platform views in the web]: /release/breaking-changes/platform-views-using-html-slots-web
[Migrate a Windows project to the idiomatic run loop]: /release/breaking-changes/windows-run-loop

### Reverted change in 2.2

The following breaking change was reverted in release 2.2:

**[Network Policy on iOS and Android][]**<br>
:  Introduced in version: 2.0.0<br>
   Reverted in version:   2.2.0

[Network Policy on iOS and Android]: /release/breaking-changes/network-policy-ios-android

<a id="released-in-flutter-22" aria-hidden="true"></a>
### Released in Flutter 2.2

* [Default Scrollbars on Desktop][]

[Default Scrollbars on Desktop]: /release/breaking-changes/default-desktop-scrollbars

### Released in Flutter 2

* [Added BuildContext parameter to TextEditingController.buildTextSpan][]
* [Android ActivityControlSurface attachToActivity signature change][]
* [Android FlutterMain.setIsRunningInRobolectricTest testing API removed][]
* [Clip behavior][]
* [Deprecated API removed after v1.22][]
* [Dry layout support for RenderBox][]
* [Eliminating nullOk Parameters][]
* [Material Chip button semantics][]
* [SnackBars managed by the ScaffoldMessenger][]
* [TextSelectionTheme migration][]
* [Transition of platform channel test interfaces to flutter_test package][]
* [Use maxLengthEnforcement instead of maxLengthEnforced][]

[Added BuildContext parameter to TextEditingController.buildTextSpan]: /release/breaking-changes/buildtextspan-buildcontext
[Android ActivityControlSurface attachToActivity signature change]: /release/breaking-changes/android-activity-control-surface-attach
[Android FlutterMain.setIsRunningInRobolectricTest testing API removed]: /release/breaking-changes/android-setIsRunningInRobolectricTest-removed
[Clip behavior]: /release/breaking-changes/clip-behavior
[Deprecated API removed after v1.22]: /release/breaking-changes/1-22-deprecations
[Dry layout support for RenderBox]: /release/breaking-changes/renderbox-dry-layout
[Eliminating nullOk Parameters]: /release/breaking-changes/eliminating-nullok-parameters
[Material Chip button semantics]: /release/breaking-changes/material-chip-button-semantics
[SnackBars managed by the ScaffoldMessenger]: /release/breaking-changes/scaffold-messenger
[TextSelectionTheme migration]: /release/breaking-changes/text-selection-theme
[Use maxLengthEnforcement instead of maxLengthEnforced]: /release/breaking-changes/use-maxLengthEnforcement-instead-of-maxLengthEnforced
[Transition of platform channel test interfaces to flutter_test package]: /release/breaking-changes/mock-platform-channels

<a id="released-in-flutter-122" aria-hidden="true"></a>
### Released in Flutter 1.22

* [Android v1 embedding app and plugin creation deprecation][]
* [Cupertino icons 1.0.0][]
* [The new Form, FormField auto-validation API][]


[Android v1 embedding app and plugin creation deprecation]: /release/breaking-changes/android-v1-embedding-create-deprecation
[Cupertino icons 1.0.0]: /release/breaking-changes/cupertino-icons-1.0.0
[The new Form, FormField auto-validation API]: /release/breaking-changes/form-field-autovalidation-api

<a id="released-in-flutter-120" aria-hidden="true"></a>
### Released in Flutter 1.20

* [Actions API revision][]
* [Adding TextInputClient.currentAutofillScope property][]
* [New Buttons and Button Themes][]
* [Dialogs' Default BorderRadius][]
* [More Strict Assertions in the Navigator and the Hero Controller Scope][]
* [The Route Transition record and Transition delegate updates][]
* [The RenderEditable needs to be laid out before hit testing][]
* [Reversing the dependency between the scheduler and services layer][]
* [Semantics Order of the Overlay Entries in Modal Routes][]
* [showAutocorrectionPromptRect method added to TextInputClient][]
* [TestWidgetsFlutterBinding.clock][]
* [TextField requires MaterialLocalizations][]

[Actions API revision]: /release/breaking-changes/actions-api-revision
[Adding TextInputClient.currentAutofillScope property]: /release/breaking-changes/add-currentAutofillScope-to-TextInputClient
[New Buttons and Button Themes]: /release/breaking-changes/buttons
[Dialogs' Default BorderRadius]: /release/breaking-changes/dialog-border-radius
[More Strict Assertions in the Navigator and the Hero Controller Scope]: /release/breaking-changes/hero-controller-scope
[Reversing the dependency between the scheduler and services layer]: /release/breaking-changes/services-scheduler-dependency-reversed
[The RenderEditable needs to be laid out before hit testing]: /release/breaking-changes/rendereditable-layout-before-hit-test
[Semantics Order of the Overlay Entries in Modal Routes]: /release/breaking-changes/modal-router-semantics-order
[showAutocorrectionPromptRect method added to TextInputClient]: /release/breaking-changes/add-showAutocorrectionPromptRect
[TestWidgetsFlutterBinding.clock]: /release/breaking-changes/test-widgets-flutter-binding-clock
[TextField requires MaterialLocalizations]: /release/breaking-changes/text-field-material-localizations
[The Route Transition record and Transition delegate updates]: /release/breaking-changes/route-transition-record-and-transition-delegate

<a id="released-in-flutter-117" aria-hidden="true"></a>
### Released in Flutter 1.17

* [Adding 'linux' and 'windows' to TargetPlatform enum][]
* [Annotations return local position relative to object][]
* [Container color optimization][]
* [CupertinoTabBar requires Localizations parent][]
* [Generic type of ParentDataWidget changed to ParentData][]
* [ImageCache and ImageProvider changes][]
* [ImageCache large images][]
* [MouseTracker moved to rendering][]
* [MouseTracker no longer attaches annotations][]
* [Nullable CupertinoTheme.brightness][]
* [Rebuild optimization for OverlayEntries and Routes][]
* [Scrollable AlertDialog][]
* [TestTextInput state reset][]
* [TextInputClient currentTextEditingValue][]
* [The forgetChild() method must call super][]
* [The Route and Navigator refactoring][]
* [FloatingActionButton and ThemeData's accent properties][]

[Adding 'linux' and 'windows' to TargetPlatform enum]: /release/breaking-changes/target-platform-linux-windows
[Annotations return local position relative to object]: /release/breaking-changes/annotations-return-local-position-relative-to-object
[Container color optimization]: /release/breaking-changes/container-color
[CupertinoTabBar requires Localizations parent]: /release/breaking-changes/cupertino-tab-bar-localizations
[Generic type of ParentDataWidget changed to ParentData]: /release/breaking-changes/parent-data-widget-generic-type
[ImageCache and ImageProvider changes]: /release/breaking-changes/image-cache-and-provider
[ImageCache large images]: /release/breaking-changes/imagecache-large-images
[MouseTracker moved to rendering]: /release/breaking-changes/mouse-tracker-moved-to-rendering
[MouseTracker no longer attaches annotations]: /release/breaking-changes/mouse-tracker-no-longer-attaches-annotations
[Nullable CupertinoTheme.brightness]: /release/breaking-changes/nullable-cupertinothemedata-brightness
[Rebuild optimization for OverlayEntries and Routes]: /release/breaking-changes/overlay-entry-rebuilds
[Replace AnimationSheetBuilder.display with collate]: /release/breaking-changes/animation-sheet-builder-display
[Scrollable AlertDialog]: /release/breaking-changes/scrollable-alert-dialog
[TestTextInput state reset]: /release/breaking-changes/test-text-input
[TextInputClient currentTextEditingValue]: /release/breaking-changes/text-input-client-current-value
[The forgetChild() method must call super]: /release/breaking-changes/forgetchild-call-super
[The Route and Navigator refactoring]: /release/breaking-changes/route-navigator-refactoring
[FloatingActionButton and ThemeData's accent properties]: /release/breaking-changes/fab-theme-data-accent-properties
