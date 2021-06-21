---
title: Breaking changes
description: A list of migration guides for breaking changes in Flutter.
---

As described in the [breaking change policy][],
on occasion we publish guides
for migrating code across a breaking change.

The following guides are available. They are sorted by
release, and listed in alphabetical order:

### Not yet released to stable

* [Default drag scrolling devices][]
* [Introducing package:flutter_lints][]
* [ThemeData's accent properties have been deprecated][]
* [GestureRecognizer Cleanup][]
* [Replace AnimationSheetBuilder.display with collate][]
* [Using HTML slots to render platform views in the web][]

[Default drag scrolling devices]: /docs/release/breaking-changes/default-scroll-behavior-drag
[GestureRecognizer Cleanup]: /docs/release/breaking-changes/gesture-recognizer-add-allowed-pointer
[Introducing package:flutter_lints]: /docs/release/breaking-changes/flutter-lints-package
[ThemeData's accent properties have been deprecated]: /docs/release/breaking-changes/theme-data-accent-properties
[Using HTML slots to render platform views in the web]: /docs/release/breaking-changes/platform-views-using-html-slots-web

### Reverted changes

The following breaking changes have been reverted.

<b>[Network Policy on iOS and Android][]</b><br>
:  Introduced in version: 2.0.0<br>
   Reverted in version:   2.2.0 (proposed)

[Network Policy on iOS and Android]: /docs/release/breaking-changes/network-policy-ios-android

### Released in Flutter 2.2

* [Default Scrollbars on Desktop][]

[Default Scrollbars on Desktop]: /docs/release/breaking-changes/default-desktop-scrollbars

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
* [Use maxLengthEnforcement instead of maxLengthEnforced][]
* [Transition of platform channel test interfaces to flutter_test package][]

[Added BuildContext parameter to TextEditingController.buildTextSpan]: /docs/release/breaking-changes/buildtextspan-buildcontext
[Android ActivityControlSurface attachToActivity signature change]: /docs/release/breaking-changes/android-activity-control-surface-attach
[Android FlutterMain.setIsRunningInRobolectricTest testing API removed]: /docs/release/breaking-changes/android-setIsRunningInRobolectricTest-removed
[Clip behavior]: /docs/release/breaking-changes/clip-behavior
[Deprecated API removed after v1.22]: /docs/release/breaking-changes/1-22-deprecations
[Dry layout support for RenderBox]: /docs/release/breaking-changes/renderbox-dry-layout
[Eliminating nullOk Parameters]: /docs/release/breaking-changes/eliminating-nullok-parameters
[Material Chip button semantics]: /docs/release/breaking-changes/material-chip-button-semantics
[SnackBars managed by the ScaffoldMessenger]:  /docs/release/breaking-changes/scaffold-messenger
[TextSelectionTheme migration]: /docs/release/breaking-changes/text-selection-theme
[Use maxLengthEnforcement instead of maxLengthEnforced]: /docs/release/breaking-changes/use-maxLengthEnforcement-instead-of-maxLengthEnforced
[Transition of platform channel test interfaces to flutter_test package]: /docs/release/breaking-changes/mock-platform-channels

### Released in Flutter 1.22

* [Android v1 embedding app and plugin creation deprecation][]
* [Cupertino icons 1.0.0][]
* [The new Form, FormField auto-validation API][]


[Android v1 embedding app and plugin creation deprecation]: /docs/release/breaking-changes/android-v1-embedding-create-deprecation
[Cupertino icons 1.0.0]: /docs/release/breaking-changes/cupertino-icons-1.0.0
[The new Form, FormField auto-validation API]: /docs/release/breaking-changes/form-field-autovalidation-api

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

[Actions API revision]: /docs/release/breaking-changes/actions-api-revision
[Adding TextInputClient.currentAutofillScope property]: /docs/release/breaking-changes/add-currentAutofillScope-to-TextInputClient
[New Buttons and Button Themes]: /docs/release/breaking-changes/buttons
[Dialogs' Default BorderRadius]:/docs/release/breaking-changes/dialog-border-radius
[More Strict Assertions in the Navigator and the Hero Controller Scope]: /docs/release/breaking-changes/hero-controller-scope
[Reversing the dependency between the scheduler and services layer]: /docs/release/breaking-changes/services-scheduler-dependency-reversed
[The RenderEditable needs to be laid out before hit testing]: /docs/release/breaking-changes/rendereditable-layout-before-hit-test
[Semantics Order of the Overlay Entries in Modal Routes]: /docs/release/breaking-changes/modal-router-semantics-order
[showAutocorrectionPromptRect method added to TextInputClient]: /docs/release/breaking-changes/add-showAutocorrectionPromptRect
[TestWidgetsFlutterBinding.clock]: /docs/release/breaking-changes/test-widgets-flutter-binding-clock
[TextField requires MaterialLocalizations]: /docs/release/breaking-changes/text-field-material-localizations
[The Route Transition record and Transition delegate updates]: /docs/release/breaking-changes/route-transition-record-and-transition-delegate

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

[Adding 'linux' and 'windows' to TargetPlatform enum]: /docs/release/breaking-changes/target-platform-linux-windows
[Annotations return local position relative to object]: /docs/release/breaking-changes/annotations-return-local-position-relative-to-object
[breaking change policy]: /docs/resources/compatibility
[Container color optimization]: /docs/release/breaking-changes/container-color
[CupertinoTabBar requires Localizations parent]: /docs/release/breaking-changes/cupertino-tab-bar-localizations
[Generic type of ParentDataWidget changed to ParentData]: /docs/release/breaking-changes/parent-data-widget-generic-type
[ImageCache and ImageProvider changes]: /docs/release/breaking-changes/image-cache-and-provider
[ImageCache large images]: /docs/release/breaking-changes/imagecache-large-images
[MouseTracker moved to rendering]: /docs/release/breaking-changes/mouse-tracker-moved-to-rendering
[MouseTracker no longer attaches annotations]: /docs/release/breaking-changes/mouse-tracker-no-longer-attaches-annotations
[Nullable CupertinoTheme.brightness]: /docs/release/breaking-changes/nullable-cupertinothemedata-brightness
[Rebuild optimization for OverlayEntries and Routes]: /docs/release/breaking-changes/overlay-entry-rebuilds
[Replace AnimationSheetBuilder.display with collate]: /docs/release/breaking-changes/animation-sheet-builder-display
[Scrollable AlertDialog]: /docs/release/breaking-changes/scrollable-alert-dialog
[TestTextInput state reset]: /docs/release/breaking-changes/test-text-input
[TextInputClient currentTextEditingValue]: /docs/release/breaking-changes/text-input-client-current-value
[The forgetChild() method must call super]: /docs/release/breaking-changes/forgetchild-call-super
[The Route and Navigator refactoring]: /docs/release/breaking-changes/route-navigator-refactoring
[FloatingActionButton and ThemeData's accent properties]: /docs/release/breaking-changes/fab-theme-data-accent-properties
