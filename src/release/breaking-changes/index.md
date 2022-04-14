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

* [Deprecated API removed after v2.10][]
* [Page transitions replaced by ZoomPageTransitionsBuilder][]
* [Migrate useDeleteButtonTooltip to deleteButtonTooltipMessage of Chips][]
* [ThemeData's toggleableActiveColor property has been deprecated][]

[Deprecated API removed after v2.10]: {{site.url}}/release/breaking-changes/2-10-deprecations
[Page transitions replaced by ZoomPageTransitionsBuilder]: {{site.url}}/release/breaking-changes/page-transition-replaced-by-ZoomPageTransitionBuilder
[Migrate useDeleteButtonTooltip to deleteButtonTooltipMessage of Chips]: {{site.url}}/release/breaking-changes/chip-usedeletebuttontooltip-migration
[ThemeData's toggleableActiveColor property has been deprecated]: {{site.url}}/release/breaking-changes/toggleable-active-color

### Released in Flutter 2.10

* [Deprecated API removed after v2.5][]
* [Raw images on Web uses correct origin and colors][]
* [Required Kotlin version][]
* [Scribble Text Input Client][]

[Deprecated API removed after v2.5]: {{site.url}}/release/breaking-changes/2-5-deprecations
[Raw images on Web uses correct origin and colors]: {{site.url}}/release/breaking-changes/raw-images-on-web-uses-correct-origin-and-colors
[Required Kotlin version]: {{site.url}}/release/breaking-changes/kotlin-version
[Scribble Text Input Client]: {{site.url}}/release/breaking-changes/scribble-text-input-client

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

[Change the enterText method to move the caret to the end of the input text]: {{site.url}}/release/breaking-changes/enterText-trailing-caret
[Default drag scrolling devices]: {{site.url}}/release/breaking-changes/default-scroll-behavior-drag
[Deprecated API removed after v2.2]: {{site.url}}/release/breaking-changes/2-2-deprecations
[GestureRecognizer cleanup]: {{site.url}}/release/breaking-changes/gesture-recognizer-add-allowed-pointer
[Introducing package:flutter_lints]: {{site.url}}/release/breaking-changes/flutter-lints-package
[Replace AnimationSheetBuilder.display with collate]: {{site.url}}/release/breaking-changes/animation-sheet-builder-display
[ThemeData's accent properties have been deprecated]: {{site.url}}/release/breaking-changes/theme-data-accent-properties
[Transition of platform channel test interfaces to flutter_test package]: {{site.url}}/release/breaking-changes/mock-platform-channels
[Using HTML slots to render platform views in the web]: {{site.url}}/release/breaking-changes/platform-views-using-html-slots-web

### Reverted change in 2.2

The following breaking change was reverted in release 2.2:

<b>[Network Policy on iOS and Android][]</b><br>
:  Introduced in version: 2.0.0<br>
   Reverted in version:   2.2.0 (proposed)

[Network Policy on iOS and Android]: {{site.url}}/release/breaking-changes/network-policy-ios-android

### Released in Flutter 2.2

* [Default Scrollbars on Desktop][]

[Default Scrollbars on Desktop]: {{site.url}}/release/breaking-changes/default-desktop-scrollbars

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

[Added BuildContext parameter to TextEditingController.buildTextSpan]: {{site.url}}/release/breaking-changes/buildtextspan-buildcontext
[Android ActivityControlSurface attachToActivity signature change]: {{site.url}}/release/breaking-changes/android-activity-control-surface-attach
[Android FlutterMain.setIsRunningInRobolectricTest testing API removed]: {{site.url}}/release/breaking-changes/android-setIsRunningInRobolectricTest-removed
[Clip behavior]: {{site.url}}/release/breaking-changes/clip-behavior
[Deprecated API removed after v1.22]: {{site.url}}/release/breaking-changes/1-22-deprecations
[Dry layout support for RenderBox]: {{site.url}}/release/breaking-changes/renderbox-dry-layout
[Eliminating nullOk Parameters]: {{site.url}}/release/breaking-changes/eliminating-nullok-parameters
[Material Chip button semantics]: {{site.url}}/release/breaking-changes/material-chip-button-semantics
[SnackBars managed by the ScaffoldMessenger]: {{site.url}}/release/breaking-changes/scaffold-messenger
[TextSelectionTheme migration]: {{site.url}}/release/breaking-changes/text-selection-theme
[Use maxLengthEnforcement instead of maxLengthEnforced]: {{site.url}}/release/breaking-changes/use-maxLengthEnforcement-instead-of-maxLengthEnforced
[Transition of platform channel test interfaces to flutter_test package]: {{site.url}}/release/breaking-changes/mock-platform-channels

### Released in Flutter 1.22

* [Android v1 embedding app and plugin creation deprecation][]
* [Cupertino icons 1.0.0][]
* [The new Form, FormField auto-validation API][]


[Android v1 embedding app and plugin creation deprecation]: {{site.url}}/release/breaking-changes/android-v1-embedding-create-deprecation
[Cupertino icons 1.0.0]: {{site.url}}/release/breaking-changes/cupertino-icons-1.0.0
[The new Form, FormField auto-validation API]: {{site.url}}/release/breaking-changes/form-field-autovalidation-api

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

[Actions API revision]: {{site.url}}/release/breaking-changes/actions-api-revision
[Adding TextInputClient.currentAutofillScope property]: {{site.url}}/release/breaking-changes/add-currentAutofillScope-to-TextInputClient
[New Buttons and Button Themes]: {{site.url}}/release/breaking-changes/buttons
[Dialogs' Default BorderRadius]: {{site.url}}/release/breaking-changes/dialog-border-radius
[More Strict Assertions in the Navigator and the Hero Controller Scope]: {{site.url}}/release/breaking-changes/hero-controller-scope
[Reversing the dependency between the scheduler and services layer]: {{site.url}}/release/breaking-changes/services-scheduler-dependency-reversed
[The RenderEditable needs to be laid out before hit testing]: {{site.url}}/release/breaking-changes/rendereditable-layout-before-hit-test
[Semantics Order of the Overlay Entries in Modal Routes]: {{site.url}}/release/breaking-changes/modal-router-semantics-order
[showAutocorrectionPromptRect method added to TextInputClient]: {{site.url}}/release/breaking-changes/add-showAutocorrectionPromptRect
[TestWidgetsFlutterBinding.clock]: {{site.url}}/release/breaking-changes/test-widgets-flutter-binding-clock
[TextField requires MaterialLocalizations]: {{site.url}}/release/breaking-changes/text-field-material-localizations
[The Route Transition record and Transition delegate updates]: {{site.url}}/release/breaking-changes/route-transition-record-and-transition-delegate

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

[Adding 'linux' and 'windows' to TargetPlatform enum]: {{site.url}}/release/breaking-changes/target-platform-linux-windows
[Annotations return local position relative to object]: {{site.url}}/release/breaking-changes/annotations-return-local-position-relative-to-object
[breaking change policy]: {{site.url}}/resources/compatibility
[Container color optimization]: {{site.url}}/release/breaking-changes/container-color
[CupertinoTabBar requires Localizations parent]: {{site.url}}/release/breaking-changes/cupertino-tab-bar-localizations
[Generic type of ParentDataWidget changed to ParentData]: {{site.url}}/release/breaking-changes/parent-data-widget-generic-type
[ImageCache and ImageProvider changes]: {{site.url}}/release/breaking-changes/image-cache-and-provider
[ImageCache large images]: {{site.url}}/release/breaking-changes/imagecache-large-images
[MouseTracker moved to rendering]: {{site.url}}/release/breaking-changes/mouse-tracker-moved-to-rendering
[MouseTracker no longer attaches annotations]: {{site.url}}/release/breaking-changes/mouse-tracker-no-longer-attaches-annotations
[Nullable CupertinoTheme.brightness]: {{site.url}}/release/breaking-changes/nullable-cupertinothemedata-brightness
[Rebuild optimization for OverlayEntries and Routes]: {{site.url}}/release/breaking-changes/overlay-entry-rebuilds
[Replace AnimationSheetBuilder.display with collate]: {{site.url}}/release/breaking-changes/animation-sheet-builder-display
[Scrollable AlertDialog]: {{site.url}}/release/breaking-changes/scrollable-alert-dialog
[TestTextInput state reset]: {{site.url}}/release/breaking-changes/test-text-input
[TextInputClient currentTextEditingValue]: {{site.url}}/release/breaking-changes/text-input-client-current-value
[The forgetChild() method must call super]: {{site.url}}/release/breaking-changes/forgetchild-call-super
[The Route and Navigator refactoring]: {{site.url}}/release/breaking-changes/route-navigator-refactoring
[FloatingActionButton and ThemeData's accent properties]: {{site.url}}/release/breaking-changes/fab-theme-data-accent-properties
