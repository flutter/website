---
title: Flutter 1.22.0 release notes
short-title: 1.22.0 release notes
description: Release notes for Flutter 1.22.0.
---

This page has release notes for 1.22.0.
For information about subsequent bug-fix releases, see
[Hotfixes to the Stable Channel][].

[Hotfixes to the Stable Channel]: https://github.com/flutter/flutter/wiki/Hotfixes-to-the-Stable-Channel

## Merged PRs by labels for `flutter/flutter` 

### framework - 428 pull request(s)

[56413](https://github.com/flutter/flutter/pull/56413) Prevent viewport.showOnScreen from scrolling the viewport if the specified Rect is already visible.  (cla: yes, f: material design, f: scrolling, framework, severe: API break, waiting for tree to go green)


[58245](https://github.com/flutter/flutter/pull/58245) Automatically scale down Dialog padding for larger text scale factors (cla: yes, f: material design, framework, waiting for tree to go green)


[58640](https://github.com/flutter/flutter/pull/58640) Skip Audit - Rendering Library (a: quality, a: tests, cla: yes, framework, team, waiting for tree to go green)


[58731](https://github.com/flutter/flutter/pull/58731) Autofill save (a: text input, cla: yes, framework)


[59127](https://github.com/flutter/flutter/pull/59127) [Text Scaling][Material] Update BottomNavigationBar to show tooltips on long press. (cla: yes, f: cupertino, f: material design, framework, team)


[59623](https://github.com/flutter/flutter/pull/59623) Reduce iOS scroll damping for lists with differently sized items (a: fidelity, cla: yes, f: scrolling, framework, platform-ios, waiting for tree to go green)


[59702](https://github.com/flutter/flutter/pull/59702) New Button Universe (cla: yes, f: material design, framework, waiting for tree to go green)


[59766](https://github.com/flutter/flutter/pull/59766) FormField should autovalidate only if its content was changed (fixed) (a: text input, cla: yes, f: material design, framework, waiting for tree to go green)


[60174](https://github.com/flutter/flutter/pull/60174) Add an additional builder to DragTarget which fires on every Draggabl… (cla: yes, framework, waiting for tree to go green)


[60177](https://github.com/flutter/flutter/pull/60177) Don't move to word edge when tapping with a mouse (a: mouse, a: text input, cla: yes, f: material design, framework, waiting for tree to go green)


[60179](https://github.com/flutter/flutter/pull/60179) Implement new activity indicator for iOS14 (cla: yes, f: cupertino, framework)


[60299](https://github.com/flutter/flutter/pull/60299) Implement Router widget and widgets app api (cla: yes, f: cupertino, f: material design, framework, waiting for tree to go green)


[60337](https://github.com/flutter/flutter/pull/60337) Add ThemeData.shadowColor (cla: yes, f: material design, framework, waiting for tree to go green)


[60375](https://github.com/flutter/flutter/pull/60375) Restoration Framework (a: tests, cla: yes, framework, waiting for tree to go green)


[60446](https://github.com/flutter/flutter/pull/60446) Remove unused optional parameters of private functions. (a: tests, cla: yes, f: material design, framework, team, waiting for tree to go green)


[60479](https://github.com/flutter/flutter/pull/60479) Fix tooltip position using correct overlay to calculate render box position. (a: layout, cla: yes, f: material design, framework, waiting for tree to go green)


[60501](https://github.com/flutter/flutter/pull/60501) Make Scrollable's free scroll initial velocity matches that of iOS (a: fidelity, cla: yes, f: scrolling, framework, platform-ios, waiting for tree to go green)


[60558](https://github.com/flutter/flutter/pull/60558) Pointer event resampler (#41118) (cla: yes, f: scrolling, framework, platform-android, platform-fuchsia, platform-ios, waiting for tree to go green)


[60640](https://github.com/flutter/flutter/pull/60640) expose route settings for showModalBottomSheet (cla: yes, f: material design, f: routes, framework, waiting for tree to go green)


[60655](https://github.com/flutter/flutter/pull/60655) clean up hero controller scope (cla: yes, f: cupertino, f: material design, framework, waiting for tree to go green)


[60796](https://github.com/flutter/flutter/pull/60796) Add support in WidgetTester for an array of inputs (a: animation, a: tests, cla: yes, f: gestures, framework)


[60931](https://github.com/flutter/flutter/pull/60931) Add all system cursors (framework) (a: desktop, a: mouse, cla: yes, framework, waiting for tree to go green)


[60940](https://github.com/flutter/flutter/pull/60940) Skip Audit - Last Leftovers (a: quality, a: tests, cla: yes, f: cupertino, f: material design, framework, team, waiting for tree to go green)


[60990](https://github.com/flutter/flutter/pull/60990) Use the correct Transform in the WidgetInspector overlay (#59566) (cla: yes, f: inspector, framework, waiting for tree to go green)


[61048](https://github.com/flutter/flutter/pull/61048) Re-land "Tweaking Material Chip a11y semantics to match buttons (#60141)" (a: accessibility, cla: yes, customer: money (g3), f: material design, framework, waiting for tree to go green)


[61071](https://github.com/flutter/flutter/pull/61071) [Api docs] Updates ListTile.subtitle docs to address how TextStyle is decided (cla: yes, d: api docs, f: material design, framework, waiting for tree to go green)


[61086](https://github.com/flutter/flutter/pull/61086) Added the materialTapTargetSize to the OutlineButton Constructor (cla: yes, f: material design, framework, waiting for tree to go green)


[61104](https://github.com/flutter/flutter/pull/61104) Document the addition of LRM and RLM characters (cla: yes, framework, waiting for tree to go green)


[61123](https://github.com/flutter/flutter/pull/61123) This fixes an error in the form field example (cla: yes, d: api docs, f: material design, framework, waiting for tree to go green)


[61136](https://github.com/flutter/flutter/pull/61136) Re-land Expose height and width factor in AnimatedAlign (a: animation, cla: yes, framework, waiting for tree to go green)


[61138](https://github.com/flutter/flutter/pull/61138) Fixing patch for coming breaking change in HttpClientRequest (a: tests, cla: yes, framework)


[61171](https://github.com/flutter/flutter/pull/61171) Fix FloatingActionButtonLocation for additional test case (a: quality, f: material design, framework, waiting for tree to go green)


[61180](https://github.com/flutter/flutter/pull/61180) [Material] Allow for customizing Snack bar margin, padding, and width (cla: yes, f: material design, framework, waiting for tree to go green)


[61185](https://github.com/flutter/flutter/pull/61185) Filter profiling events by names not category (a: tests, cla: yes, framework, severe: performance)


[61188](https://github.com/flutter/flutter/pull/61188) migrate foundation to nullsafety (cla: yes, framework)


[61190](https://github.com/flutter/flutter/pull/61190) Mouse events report correct local positions (cla: yes, framework, waiting for tree to go green)


[61199](https://github.com/flutter/flutter/pull/61199) remove LICENSE/NOTICES work around (cla: yes, framework, waiting for tree to go green)


[61209](https://github.com/flutter/flutter/pull/61209) Optionally invert oversized images (a: debugging, a: error message, a: images, cla: yes, framework, tool)


[61216](https://github.com/flutter/flutter/pull/61216) InkDecoration do not paint if it's part of the tree doesn't get painted (cla: yes, f: material design, framework, waiting for tree to go green)


[61258](https://github.com/flutter/flutter/pull/61258) Adds semantics information for the popup menu item (cla: yes, f: material design, framework, waiting for tree to go green)


[61262](https://github.com/flutter/flutter/pull/61262) Renamed ContainedButton et al. to ElevatedButton et al. (cla: yes, f: material design, framework, waiting for tree to go green)


[61266](https://github.com/flutter/flutter/pull/61266) implement handlePointerEventRecord for LiveWidgetController (a: tests, cla: yes, framework, waiting for tree to go green)


[61268](https://github.com/flutter/flutter/pull/61268) Update Table docs for horizontal scrolling (cla: yes, d: api docs, documentation, f: scrolling, framework, waiting for tree to go green)


[61323](https://github.com/flutter/flutter/pull/61323) Updated Row API doc for RTL in textDirection (cla: yes, d: api docs, documentation, framework, waiting for tree to go green)


[61347](https://github.com/flutter/flutter/pull/61347) [ListTile] adds new properties to customize the tile color (cla: yes, f: material design, framework, severe: new feature, waiting for tree to go green)


[61356](https://github.com/flutter/flutter/pull/61356) Updated dataTable API doc to explicitly point sorting (cla: yes, f: material design, framework, waiting for tree to go green)


[61368](https://github.com/flutter/flutter/pull/61368) Add widget of the week videos to documentation (cla: yes, f: cupertino, f: material design, framework, waiting for tree to go green)


[61370](https://github.com/flutter/flutter/pull/61370) Remove the default shortcut mapping for GameButtonB. (cla: yes, framework, waiting for tree to go green)


[61371](https://github.com/flutter/flutter/pull/61371) Make ThemeData.shadowColor the default shadowColor in TextButton et al. (cla: yes, f: material design, framework, waiting for tree to go green)


[61375](https://github.com/flutter/flutter/pull/61375) issue 61346 route can be added and disposed in the same frame (cla: yes, framework, waiting for tree to go green)


[61377](https://github.com/flutter/flutter/pull/61377) Revert "Adds semantics information for the popup menu item (#61258)" (cla: yes, f: material design, framework)


[61385](https://github.com/flutter/flutter/pull/61385) reland "Adds semantics information for the popup menu item (#61258)" (a: accessibility, cla: yes, f: material design, framework, team, waiting for tree to go green)


[61386](https://github.com/flutter/flutter/pull/61386) Fix NestedScrollView inner ballistic activity for 0 velocity (a: quality, cla: yes, f: scrolling, framework, waiting for tree to go green)


[61388](https://github.com/flutter/flutter/pull/61388) benchmarkLive: a new `LiveTestWidgetsFlutterBindingFramePolicy` for benchmark on device (a: tests, cla: yes, framework, team, waiting for tree to go green)


[61392](https://github.com/flutter/flutter/pull/61392) Update Card example and shadowColor default (cla: yes, f: material design, framework, waiting for tree to go green)


[61394](https://github.com/flutter/flutter/pull/61394) Update the Scaffold examples; use the new button classes (cla: yes, f: material design, framework)


[61398](https://github.com/flutter/flutter/pull/61398) Prevent material switch from recreating its render object when it becomes disabled (cla: yes, f: material design, framework, waiting for tree to go green)


[61399](https://github.com/flutter/flutter/pull/61399) Document the mapping of system mouse cursors on Windows and Linux (a: desktop, a: mouse, cla: yes, framework)


[61400](https://github.com/flutter/flutter/pull/61400) fix code comments in the route route didadd method (cla: yes, framework, waiting for tree to go green)


[61401](https://github.com/flutter/flutter/pull/61401) Make scrollbar thickness and radius customizable (cla: yes, f: cupertino, f: material design, framework)


[61406](https://github.com/flutter/flutter/pull/61406) Update the golden image comparator to handle read-only image ByteData views (a: tests, cla: yes, framework, waiting for tree to go green)


[61413](https://github.com/flutter/flutter/pull/61413) [flutter_tools] update fastReassemble method for single widget reloads (cla: yes, framework, tool)


[61424](https://github.com/flutter/flutter/pull/61424) Update documentation (cla: yes, f: material design, framework)


[61425](https://github.com/flutter/flutter/pull/61425) Default textBaseline to alphabetic in Flex (cla: yes, framework, waiting for tree to go green)


[61439](https://github.com/flutter/flutter/pull/61439) Add per thumb Range Slider semantics (cla: yes, f: material design, framework, waiting for tree to go green)


[61455](https://github.com/flutter/flutter/pull/61455) Improve error reporting for RenderObject visitChildren errors (cla: yes, framework)


[61457](https://github.com/flutter/flutter/pull/61457) Add assert to Table to check for rows with null children (cla: yes, framework)


[61474](https://github.com/flutter/flutter/pull/61474) Fix Border.symmetric: phase 1 (cla: yes, framework, waiting for tree to go green)


[61479](https://github.com/flutter/flutter/pull/61479) Update MaterialState API docs (cla: yes, f: material design, framework, waiting for tree to go green)


[61485](https://github.com/flutter/flutter/pull/61485) fix intrinsic height and width for widget span (cla: yes, framework, waiting for tree to go green)


[61489](https://github.com/flutter/flutter/pull/61489) Updated date pickers to use the new TextButton in place of FlatButton. (cla: yes, f: material design, framework, waiting for tree to go green)


[61492](https://github.com/flutter/flutter/pull/61492) Updated time pickers to use the new TextButton in place of FlatButton. (cla: yes, f: material design, framework)


[61502](https://github.com/flutter/flutter/pull/61502) Update documentation for IntrinsicWidth & IntrinsicHeight (cla: yes, d: api docs, documentation, framework)


[61503](https://github.com/flutter/flutter/pull/61503) Add defaults to `showGeneralDialog()` (cla: yes, framework)


[61509](https://github.com/flutter/flutter/pull/61509) Add a E2E based performance test case (a: tests, cla: yes, framework, team, waiting for tree to go green)


[61516](https://github.com/flutter/flutter/pull/61516) Allow transparent barrierColor in showDialog methods (cla: yes, framework)


[61532](https://github.com/flutter/flutter/pull/61532) [ListTileTheme] adds properties to customize tile color at theme level (cla: yes, f: material design, framework, waiting for tree to go green)


[61540](https://github.com/flutter/flutter/pull/61540) Promote WidgetTester.ensureVisible to WidgetController (a: tests, cla: yes, framework)


[61556](https://github.com/flutter/flutter/pull/61556) fix type error in web builds (cla: yes, cp: 1.20, cp: 1.20 completed, framework)


[61570](https://github.com/flutter/flutter/pull/61570) migrate scheduler to nullsafety (cla: yes, framework, waiting for tree to go green)


[61572](https://github.com/flutter/flutter/pull/61572) Remove unused parameter from private method in widget_inspector (cla: yes, framework, waiting for tree to go green)


[61576](https://github.com/flutter/flutter/pull/61576) Corrected splash color for TextButton, ElevatedButton, OutlinedButton (cla: yes, f: material design, framework, waiting for tree to go green)


[61578](https://github.com/flutter/flutter/pull/61578) Updated obsolete button references in Scaffold, IconButton (cla: yes, f: material design, framework)


[61579](https://github.com/flutter/flutter/pull/61579) Remove unused FlutterErrorDetails subclasses (a: debugging, a: error message, a: quality, a: tests, cla: yes, framework, waiting for tree to go green)


[61581](https://github.com/flutter/flutter/pull/61581) Give better error message for describeEnum (a: error message, cla: yes, f: inspector, framework, waiting for tree to go green)


[61582](https://github.com/flutter/flutter/pull/61582) Remote returns for function expression inferred return type void. (cla: yes, framework, tool, waiting for tree to go green)


[61587](https://github.com/flutter/flutter/pull/61587) Find the target platform more accurately on the web. (cla: yes, framework, waiting for tree to go green)


[61623](https://github.com/flutter/flutter/pull/61623) Fix overflow issue caused by a long title/subtitle for the vertical stepper (cla: yes, f: material design, framework, waiting for tree to go green)


[61632](https://github.com/flutter/flutter/pull/61632) 1.20.0-7.2.pre framework cherrypicks (cla: yes, engine, framework, team)


[61636](https://github.com/flutter/flutter/pull/61636) remove usage to applyTextScaleFactorToWidgetSpan (a: accessibility, a: typography, cla: yes, framework, waiting for tree to go green)


[61648](https://github.com/flutter/flutter/pull/61648) Proposal: deprecate autovalidate parameter of the Form, FormField and TextFormField widget (cla: yes, f: material design, framework, waiting for tree to go green)


[61655](https://github.com/flutter/flutter/pull/61655) Add assert in PictureLayer.addToScene() (cla: yes, framework)


[61662](https://github.com/flutter/flutter/pull/61662) add static method to create material hero controller (cla: yes, f: material design, framework, waiting for tree to go green)


[61664](https://github.com/flutter/flutter/pull/61664) Add minWidth and height parameter into FlatButton widget (cla: yes, f: material design, framework, waiting for tree to go green)


[61666](https://github.com/flutter/flutter/pull/61666) Fix Border.symmetric: phase 2 (cla: yes, framework)


[61667](https://github.com/flutter/flutter/pull/61667) Add tests for platform views' hover behavior  (a: mouse, a: platform-views, cla: yes, framework)


[61668](https://github.com/flutter/flutter/pull/61668) Track used Android pointer IDs and reuse IDs after a pointer is released (cla: yes, framework, waiting for tree to go green)


[61671](https://github.com/flutter/flutter/pull/61671) Add no-op callbacks to platform view gesture recognizer when necessary (cla: yes, framework)


[61672](https://github.com/flutter/flutter/pull/61672) Remove TODO around deprecation (cla: yes, framework, waiting for tree to go green)


[61710](https://github.com/flutter/flutter/pull/61710) Added expandedHeight in flexibleSpace and flexibleSpaceBar (cla: yes, d: api docs, documentation, f: material design, framework, waiting for tree to go green)


[61714](https://github.com/flutter/flutter/pull/61714) Implement customizable cursor height (cla: yes, f: cupertino, f: material design, framework, waiting for tree to go green)


[61752](https://github.com/flutter/flutter/pull/61752) Allowed specifying reverseTransitionDuration in PageRouteBuilder class (cla: yes, f: routes, framework, waiting for tree to go green)


[61756](https://github.com/flutter/flutter/pull/61756) Fix `ExcludeFocus` so it won't refocus a sibling of the focused node. (cla: yes, f: focus, framework, waiting for tree to go green)


[61773](https://github.com/flutter/flutter/pull/61773) Update framePolicy docs (a: tests, cla: yes, d: api docs, documentation, framework, waiting for tree to go green)


[61778](https://github.com/flutter/flutter/pull/61778) [Material] Updated icons and fonts (cla: yes, f: material design, framework, team, tool, waiting for tree to go green)


[61779](https://github.com/flutter/flutter/pull/61779) Add a test for 3D transform with needsCompositing (cla: yes, framework, waiting for tree to go green)


[61796](https://github.com/flutter/flutter/pull/61796) Improved docs for minLines in EditableText (a: text input, cla: yes, d: api docs, documentation, framework, waiting for tree to go green)


[61841](https://github.com/flutter/flutter/pull/61841) Make sure all isolates start during flutter driver tests. (a: tests, cla: yes, framework, waiting for tree to go green)


[61844](https://github.com/flutter/flutter/pull/61844) restore nullability of FlutterError.onError (cla: yes, framework)


[61872](https://github.com/flutter/flutter/pull/61872) LiveTestWidgetsFlutterBinding support for non-touch event (a: tests, cla: yes, framework)


[61876](https://github.com/flutter/flutter/pull/61876) Revert "fix intrinsic height and width for widget span (#61485)" (cla: yes, framework)


[61900](https://github.com/flutter/flutter/pull/61900) Revert "LiveTestWidgetsFlutterBinding support for non-touch event" (a: tests, cla: yes, framework)


[61901](https://github.com/flutter/flutter/pull/61901) Reland "LiveTestWidgetsFlutterBinding support for non-touch event" (a: tests, cla: yes, framework, waiting for tree to go green)


[61916](https://github.com/flutter/flutter/pull/61916) Refactor gen_keycode: Split generators (cla: yes, framework, team)


[61940](https://github.com/flutter/flutter/pull/61940) Check if a double is NaN before converting to it int (cla: yes, framework, waiting for tree to go green)


[61941](https://github.com/flutter/flutter/pull/61941) migrate physics to nullsafety (cla: yes, framework, team, waiting for tree to go green)


[61948](https://github.com/flutter/flutter/pull/61948) Add LayoutBuilder example (cla: yes, d: api docs, d: examples, documentation, framework, waiting for tree to go green)


[61961](https://github.com/flutter/flutter/pull/61961) Improve message error for missing textBaseline (a: error message, cla: yes, framework, waiting for tree to go green)


[61963](https://github.com/flutter/flutter/pull/61963) Revert "InkDecoration do not paint if it's part of the tree doesn't g… (cla: yes, f: material design, framework)


[61973](https://github.com/flutter/flutter/pull/61973) Update viewport dimensions when scrollDirection changes (a: quality, cla: yes, f: scrolling, framework, waiting for tree to go green)


[61974](https://github.com/flutter/flutter/pull/61974) fix: MaterialColor Swatch Map comparison (cla: yes, framework, waiting for tree to go green)


[61998](https://github.com/flutter/flutter/pull/61998) A benchmark test case for measuring scroll smoothness (a: tests, cla: yes, framework, team, waiting for tree to go green)


[62008](https://github.com/flutter/flutter/pull/62008) Minor doc updates (cla: yes, framework)


[62012](https://github.com/flutter/flutter/pull/62012) Update Actions.invoke to return the result of invoking the action. (cla: yes, framework)


[62014](https://github.com/flutter/flutter/pull/62014) TextSelectionTheme support (step 1 of 3) (cla: yes, f: material design, framework)


[62052](https://github.com/flutter/flutter/pull/62052) Update the FlutterLogo colors and gradients (cla: yes, f: cupertino, f: material design, framework, team, waiting for tree to go green)


[62062](https://github.com/flutter/flutter/pull/62062) makes PopupMenuitem merge the semantics of its child (cla: yes, f: material design, framework, waiting for tree to go green)


[62071](https://github.com/flutter/flutter/pull/62071) Make it an error to break doc macros (and fix existing broken macros) (cla: yes, f: material design, framework, waiting for tree to go green)


[62072](https://github.com/flutter/flutter/pull/62072) SelectableText handles after Select All (cla: yes, f: material design, framework, waiting for tree to go green)


[62074](https://github.com/flutter/flutter/pull/62074) Fix RenderFlex crossSize for baseline alignment (P3, a: layout, cla: yes, framework, waiting for tree to go green)


[62075](https://github.com/flutter/flutter/pull/62075) Update the About dialog to use the new button API. (cla: yes, f: material design, framework, waiting for tree to go green)


[62083](https://github.com/flutter/flutter/pull/62083) Update the documentation of GlobalKey to explain why it is expensive (cla: yes, d: api docs, documentation, framework, waiting for tree to go green)


[62086](https://github.com/flutter/flutter/pull/62086) Add support for system alert sound (cla: yes, framework)


[62091](https://github.com/flutter/flutter/pull/62091) WidgetController.pump use optional duration (a: tests, cla: yes, framework, waiting for tree to go green)


[62092](https://github.com/flutter/flutter/pull/62092) Updated Material library documentation references to the old button classes. (cla: yes, f: material design, framework, waiting for tree to go green)


[62097](https://github.com/flutter/flutter/pull/62097) Add WidgetController.scrollUntilVisible (a: tests, cla: yes, framework, waiting for tree to go green)


[62099](https://github.com/flutter/flutter/pull/62099) Updated references to the old button classes to the new classes in widgets, services, and rendering packages (cla: yes, d: api docs, d: examples, documentation, f: material design, framework, waiting for tree to go green)


[62101](https://github.com/flutter/flutter/pull/62101)  Updated 'CustomClipper.shouldReclip' doc (cla: yes, d: api docs, documentation, framework, waiting for tree to go green)


[62136](https://github.com/flutter/flutter/pull/62136) Add template flutter.widgets.transitionRoute.reverseTransitionDuration (cla: yes, framework)


[62144](https://github.com/flutter/flutter/pull/62144) Revert "remove usage to applyTextScaleFactorToWidgetSpan (#61636)" (cla: yes, framework)


[62157](https://github.com/flutter/flutter/pull/62157) migrate gestures to nullsafety (cla: yes, framework, waiting for tree to go green)


[62164](https://github.com/flutter/flutter/pull/62164) Updated material and cupertino tests to use the new button classes (cla: yes, f: cupertino, f: material design, framework, waiting for tree to go green)


[62167](https://github.com/flutter/flutter/pull/62167) Ban unresolved dartdoc directives from HTML output (cla: yes, f: material design, framework, team, waiting for tree to go green)


[62195](https://github.com/flutter/flutter/pull/62195) [Material] Ensure banner reads banner theme's leading padding property (cla: yes, f: material design, framework, waiting for tree to go green)


[62220](https://github.com/flutter/flutter/pull/62220) Updated the framework tests to use the new button API. (a: accessibility, a: tests, cla: yes, f: material design, framework, waiting for tree to go green)


[62224](https://github.com/flutter/flutter/pull/62224) Fix error handling for errors with empty stack traces (cla: yes, framework)


[62239](https://github.com/flutter/flutter/pull/62239) Revert "Make sure all isolates start during flutter driver tests." (a: tests, cla: yes, framework)


[62287](https://github.com/flutter/flutter/pull/62287) Fix typos in documentation comments (cla: yes, framework, waiting for tree to go green)


[62301](https://github.com/flutter/flutter/pull/62301) Update image docs that Image.file() cashes file (cla: yes, framework, waiting for tree to go green)


[62317](https://github.com/flutter/flutter/pull/62317) Fix some broken doc references (cla: yes, f: cupertino, f: material design, framework)


[62323](https://github.com/flutter/flutter/pull/62323) Ignore unmounted parent when _debugVerifyGlobalKeyReservation for GlobalKey check (cla: yes, framework)


[62330](https://github.com/flutter/flutter/pull/62330) Use a LinkedList to improve the performances of ChangeNotifier (cla: yes, framework)


[62337](https://github.com/flutter/flutter/pull/62337) [Material] Add support for high contrast theming to Material apps (cla: yes, f: material design, framework, waiting for tree to go green)


[62338](https://github.com/flutter/flutter/pull/62338) Replace mistaken dartdoc [Foo..bar] references with [Foo.bar] (cla: yes, f: material design, framework, waiting for tree to go green)


[62350](https://github.com/flutter/flutter/pull/62350) Added OverflowBar widget (cla: yes, framework, waiting for tree to go green)


[62359](https://github.com/flutter/flutter/pull/62359) Fix SemanticsNode.rect position for nested scrollables with useTwoPan… (a: accessibility, cla: yes, f: scrolling, framework, waiting for tree to go green)


[62362](https://github.com/flutter/flutter/pull/62362) Move key event and semantics related method from WidgetTester to WidgetController (a: tests, cla: yes, framework, waiting for tree to go green)


[62367](https://github.com/flutter/flutter/pull/62367) Make dartdoc warnings fatal (& cleanup of warnings) (a: accessibility, a: internationalization, a: tests, cla: yes, f: cupertino, f: material design, framework, team, waiting for tree to go green)


[62407](https://github.com/flutter/flutter/pull/62407) [widgets] Refactor Overlay insert methods entries assert (cla: yes, framework, waiting for tree to go green)


[62415](https://github.com/flutter/flutter/pull/62415) Cache floating cursor location on start event instead of update (cla: yes, framework, waiting for tree to go green)


[62421](https://github.com/flutter/flutter/pull/62421) Export Material curves in the Material lib (cla: yes, f: material design, framework)


[62431](https://github.com/flutter/flutter/pull/62431) Revert "Export Material curves in the Material lib" (cla: yes, f: material design, framework)


[62435](https://github.com/flutter/flutter/pull/62435) Reland "Export Material curves in the Material lib" (cla: yes, f: material design, framework, waiting for tree to go green)


[62443](https://github.com/flutter/flutter/pull/62443) Fix "unresolved doc reference" in rendering layer (cla: yes, framework, waiting for tree to go green)


[62452](https://github.com/flutter/flutter/pull/62452) Fix "unresolved doc reference" in widgets layer - part 1 (cla: yes, framework, waiting for tree to go green)


[62462](https://github.com/flutter/flutter/pull/62462) separate scroll until visible implementation for lower level accessibility  (a: tests, cla: yes, framework, waiting for tree to go green)


[62471](https://github.com/flutter/flutter/pull/62471) Fix Border.symmetric: phase 3 (cla: yes, framework)


[62473](https://github.com/flutter/flutter/pull/62473) Fix 'unresolved doc reference' for material A-D (cla: yes, f: cupertino, f: material design, framework, waiting for tree to go green)


[62485](https://github.com/flutter/flutter/pull/62485) migrate animation to nullsafety (cla: yes, framework, waiting for tree to go green)


[62499](https://github.com/flutter/flutter/pull/62499) fix unresolved doc references in widgets - part 2 (cla: yes, framework, waiting for tree to go green)


[62500](https://github.com/flutter/flutter/pull/62500) Fix todo in restoration framework (cla: yes, framework, waiting for tree to go green)


[62509](https://github.com/flutter/flutter/pull/62509) Fix more unresolved doc references in material (cla: yes, f: material design, framework, waiting for tree to go green)


[62513](https://github.com/flutter/flutter/pull/62513) migrate services to nullsafety (cla: yes, framework, team)


[62520](https://github.com/flutter/flutter/pull/62520) Fix even more unresolved doc references in material (cla: yes, d: api docs, documentation, f: material design, framework, team, waiting for tree to go green)


[62552](https://github.com/flutter/flutter/pull/62552) Add comment to developers about adding new system sound types (cla: yes, framework)


[62553](https://github.com/flutter/flutter/pull/62553) After cleaning up 812 warnings: Make warnings fatal in dartdocs (cla: yes, framework, team, waiting for tree to go green)


[62582](https://github.com/flutter/flutter/pull/62582) Random unresolved doc reference fixes I missed before (a: internationalization, a: tests, cla: yes, f: material design, framework, waiting for tree to go green)


[62587](https://github.com/flutter/flutter/pull/62587) Reland "remove usage to applyTextScaleFactorToWidgetSpan" (cla: yes, framework)


[62588](https://github.com/flutter/flutter/pull/62588) Build routes even less. (cla: yes, framework, severe: API break, waiting for tree to go green, will affect goldens)


[62601](https://github.com/flutter/flutter/pull/62601) Use OverflowBar instead of ButtonBar in TimePicker (cla: yes, f: material design, framework)


[62602](https://github.com/flutter/flutter/pull/62602) Fix doc warnings for focus code (cla: yes, framework)


[62614](https://github.com/flutter/flutter/pull/62614) Make dartdoc warnings fatal for flutter_test (cla: yes, framework, team, waiting for tree to go green)


[62615](https://github.com/flutter/flutter/pull/62615) Fix SliverList scrollOffsetCorrection 0 case (cla: yes, f: scrolling, framework, severe: crash, severe: regression, waiting for tree to go green)


[62635](https://github.com/flutter/flutter/pull/62635) Fixes physics not working when StepperType.horizontal is selected (cla: yes, f: material design, framework, waiting for tree to go green)


[62640](https://github.com/flutter/flutter/pull/62640) promote WidgetTester pumpAndSettle (a: tests, cla: yes, framework, waiting for tree to go green)


[62657](https://github.com/flutter/flutter/pull/62657) Layout paragraph using the appropriate width based on its textWidthBasis (cla: yes, framework)


[62668](https://github.com/flutter/flutter/pull/62668) Ensure dark theme is used when high contrast dark theme isn't provided (a: accessibility, cla: yes, f: material design, framework, waiting for tree to go green)


[62686](https://github.com/flutter/flutter/pull/62686) Use OverflowBar instead of ButtonBar in DatePicker (cla: yes, f: material design, framework)


[62690](https://github.com/flutter/flutter/pull/62690) Fix the flexible space bar to still create a rendering object even if… (cla: yes, f: material design, framework, waiting for tree to go green)


[62695](https://github.com/flutter/flutter/pull/62695) Use OverflowBar instead of ButtonBar in DateRangePicker (cla: yes, f: material design, framework, waiting for tree to go green)


[62696](https://github.com/flutter/flutter/pull/62696) migrate part of painting to nullsafety (cla: yes, framework, waiting for tree to go green)


[62703](https://github.com/flutter/flutter/pull/62703) Use OverflowBar instead of ButtonBar in MaterialBanner (cla: yes, f: material design, framework)


[62707](https://github.com/flutter/flutter/pull/62707) Fix text escaping in the AboutListTile sample code (cla: yes, f: material design, framework, waiting for tree to go green)


[62712](https://github.com/flutter/flutter/pull/62712) Add onAppPrivateCommand to TextField (cla: yes, f: material design, framework, waiting for tree to go green)


[62715](https://github.com/flutter/flutter/pull/62715) add benchmark for ChangeNotifier.notifyListeners (cla: yes, framework, team, waiting for tree to go green)


[62729](https://github.com/flutter/flutter/pull/62729) Upadte systemNavigationBarIconBrightness docs (cla: yes, framework, waiting for tree to go green)


[62741](https://github.com/flutter/flutter/pull/62741) Deprecate iOS13 style ActivityIndicator (cla: yes, f: cupertino, framework, waiting for tree to go green)


[62755](https://github.com/flutter/flutter/pull/62755) Add punctuation for unterminated sentences in doc comments (a: accessibility, a: internationalization, a: tests, cla: yes, d: api docs, documentation, f: cupertino, f: material design, framework, tool)


[62761](https://github.com/flutter/flutter/pull/62761) Fix lifecycle clean up in the material date picker tests for screen size and semantics. (a: internationalization, cla: yes, f: material design, framework, waiting for tree to go green)


[62778](https://github.com/flutter/flutter/pull/62778) text selection affinity can be null on web (cla: yes, framework, waiting for tree to go green)


[62788](https://github.com/flutter/flutter/pull/62788) Add onTertiaryTap* to TapGestureRecognizer and GestureDetector (a: accessibility, cla: yes, framework, waiting for tree to go green)


[62795](https://github.com/flutter/flutter/pull/62795) Fix sort indicator for DataTables (cla: yes, f: material design, framework)


[62803](https://github.com/flutter/flutter/pull/62803) Address misc time picker design issues (a: internationalization, cla: yes, f: material design, framework, waiting for tree to go green)


[62805](https://github.com/flutter/flutter/pull/62805) Add “See also” links to favorite class API docs (cla: yes, d: api docs, documentation, f: material design, framework, waiting for tree to go green)


[62809](https://github.com/flutter/flutter/pull/62809) [null-safety] remove some usages of mockito (a: tests, cla: yes, framework, waiting for tree to go green)


[62820](https://github.com/flutter/flutter/pull/62820) Update skipped test comment to point to an open bug (framework, waiting for tree to go green)


[62823](https://github.com/flutter/flutter/pull/62823) Unskip the bidi semantics test. (framework, waiting for tree to go green)


[62824](https://github.com/flutter/flutter/pull/62824) Unskip a widget inspector test that doesn't seem flaky anymore. (framework, waiting for tree to go green)


[62825](https://github.com/flutter/flutter/pull/62825) Enable a scrolling fling test. (framework, waiting for tree to go green)


[62828](https://github.com/flutter/flutter/pull/62828) Add native stacktrace field for PlatformException (framework)


[62840](https://github.com/flutter/flutter/pull/62840) [ExpansionPanelList] adds elevation property (f: material design, framework, waiting for tree to go green, will affect goldens)


[62859](https://github.com/flutter/flutter/pull/62859) Add gaplessPlayback docs default discussion (d: api docs, documentation, framework, waiting for tree to go green)


[62866](https://github.com/flutter/flutter/pull/62866) [null-safety] remove quiver from flutter tests (framework, team, waiting for tree to go green)


[62868](https://github.com/flutter/flutter/pull/62868) Revert "migrate part of painting to nullsafety" (framework)


[62869](https://github.com/flutter/flutter/pull/62869) [null-safety] remove mockito from text control a11y test (framework, waiting for tree to go green)


[62872](https://github.com/flutter/flutter/pull/62872) Reland "migrate part of painting to nullsafety (#62696)" (framework, team, waiting for tree to go green)


[62891](https://github.com/flutter/flutter/pull/62891) Make _isLocalCreationLocation public (framework, waiting for tree to go green)


[62894](https://github.com/flutter/flutter/pull/62894) [null-safety] revert export of Fake from test_api (a: tests, framework, waiting for tree to go green)


[62897](https://github.com/flutter/flutter/pull/62897) Fix GestureDetector long press callback handling (framework)


[62898](https://github.com/flutter/flutter/pull/62898) Make the Skia expectation parser more resilient and update to "master_str" (a: tests, framework, team, waiting for tree to go green)


[62903](https://github.com/flutter/flutter/pull/62903) Revert "remove iOS folder (#61561)" (cp: 1.20, cp: 1.20 completed, engine, framework, team, tool)


[62904](https://github.com/flutter/flutter/pull/62904) ISSUE_TEMPLATE changes (a: triage improvements, framework, team, waiting for tree to go green)


[62913](https://github.com/flutter/flutter/pull/62913) Enable InkWell to sync its hovered state when its enabled or disabled (f: material design, framework)


[62914](https://github.com/flutter/flutter/pull/62914) revert WidgetTester.pumpAndSettle breaking change (a: tests, framework, waiting for tree to go green)


[62933](https://github.com/flutter/flutter/pull/62933) [engine] update for frameTiming (flutter/engine#20229) (framework, waiting for tree to go green)


[62936](https://github.com/flutter/flutter/pull/62936) [null-safety] remove more usage of mockito from the framework tests (f: material design, framework, waiting for tree to go green)


[62946](https://github.com/flutter/flutter/pull/62946) [null-safety] update to several framework test cases/APIs for null assertions (a: tests, cla: yes, framework, team, tool, waiting for tree to go green)


[62951](https://github.com/flutter/flutter/pull/62951) migrate part of painting to nullsafety (a: null-safety, framework, waiting for tree to go green)


[62954](https://github.com/flutter/flutter/pull/62954) fix some comment errors for clipBehavior's default value (framework, waiting for tree to go green)


[62972](https://github.com/flutter/flutter/pull/62972) non-nullable LicenseEntry.packages (framework)


[62990](https://github.com/flutter/flutter/pull/62990) [hotfix] flutter create -t plugin remove no-op iOS folder and set sdk min to 1.20.0 (engine, framework, team, tool)


[63005](https://github.com/flutter/flutter/pull/63005) Incomplete app widget error (framework, waiting for tree to go green)


[63007](https://github.com/flutter/flutter/pull/63007) Ignore dead_code hints for weak-only null checks. (framework)


[63012](https://github.com/flutter/flutter/pull/63012) Remove old button references from the Stepper widget (f: material design, framework)


[63013](https://github.com/flutter/flutter/pull/63013) Remove old button references from routes_test (framework, waiting for tree to go green)


[63026](https://github.com/flutter/flutter/pull/63026) Update to the latest localizations - Adds missing DatePicker strings and fixes manually entering date for German (a: internationalization, f: cupertino, f: material design, framework, waiting for tree to go green)


[63030](https://github.com/flutter/flutter/pull/63030) using named constructor to FrameTiming in scheduler_test.dart (a: tests, engine, framework, waiting for tree to go green)


[63034](https://github.com/flutter/flutter/pull/63034) Remove Special Handling of Norwegian Locales (a: internationalization, f: cupertino, f: material design, framework, team)


[63054](https://github.com/flutter/flutter/pull/63054) fix SingleChildScrollView clip bug (a: quality, f: scrolling, framework, waiting for tree to go green)


[63057](https://github.com/flutter/flutter/pull/63057) handler can be null in platform_channel (framework, waiting for tree to go green)


[63083](https://github.com/flutter/flutter/pull/63083) unnecessary null check (framework, waiting for tree to go green)


[63094](https://github.com/flutter/flutter/pull/63094) Fixed a typo in the DataRow API doc (f: material design, framework, waiting for tree to go green)


[63118](https://github.com/flutter/flutter/pull/63118) reland fix intrinsic height and width for widget span #61485 (framework, waiting for tree to go green)


[63131](https://github.com/flutter/flutter/pull/63131) Make Scrollables restorable (framework, waiting for tree to go green)


[63132](https://github.com/flutter/flutter/pull/63132) Fix grammar in Route doc comment (d: api docs, documentation, f: routes, framework, waiting for tree to go green)


[63142](https://github.com/flutter/flutter/pull/63142) Fix a crash when disposing tabs (f: material design, framework, waiting for tree to go green)


[63146](https://github.com/flutter/flutter/pull/63146) Fix RangeMaintainingScrollPhysics (framework)


[63147](https://github.com/flutter/flutter/pull/63147) Add clipBehavior to ListView, GridView, PageView (cla: yes, f: scrolling, framework)


[63192](https://github.com/flutter/flutter/pull/63192) Add viewport documentation breadcrumbs (cla: yes, framework, waiting for tree to go green)


[63194](https://github.com/flutter/flutter/pull/63194) API doc additions (framework, waiting for tree to go green)


[63230](https://github.com/flutter/flutter/pull/63230) Updated old button references in packages/flutter_test (a: tests, framework)


[63236](https://github.com/flutter/flutter/pull/63236) Updated use of OutlineButton in FocusTraversalPolicy API doc (framework)


[63249](https://github.com/flutter/flutter/pull/63249) Fix title color of license detail page (cla: yes, f: material design, framework, waiting for tree to go green)


[63273](https://github.com/flutter/flutter/pull/63273) Fixing code snippet example for meetsGuideline. (a: tests, d: api docs, documentation, framework, waiting for tree to go green)


[63306](https://github.com/flutter/flutter/pull/63306) Clean up some test formatting and comments (framework, waiting for tree to go green)


[63313](https://github.com/flutter/flutter/pull/63313) Small documentation typo fix (d: api docs, documentation, framework, waiting for tree to go green)


[63347](https://github.com/flutter/flutter/pull/63347) Some minor improvements to the AsyncSnapshot API (framework, waiting for tree to go green)


[63352](https://github.com/flutter/flutter/pull/63352) Clip image of BoxDecoration to circle when shape is BoxShape.circle (a: quality, framework, waiting for tree to go green)


[63390](https://github.com/flutter/flutter/pull/63390) update for WidgetTester.move and WidgetTester.fling doc (a: tests, framework, waiting for tree to go green)


[63396](https://github.com/flutter/flutter/pull/63396) Fixed an ElevatedButton API doc typo (f: material design, framework)


[63401](https://github.com/flutter/flutter/pull/63401) Make textfields restorable (cla: yes, f: cupertino, f: material design, framework)


[63405](https://github.com/flutter/flutter/pull/63405) Ensure cupertino time picker positions hours and minutes correctly for RTL (a: internationalization, f: cupertino, framework)


[63410](https://github.com/flutter/flutter/pull/63410) WidgetTester.drag with time duration (a: tests, cla: yes, framework, team, waiting for tree to go green)


[63417](https://github.com/flutter/flutter/pull/63417) Make modifier key side handling consistent among platforms (framework)


[63420](https://github.com/flutter/flutter/pull/63420) fix wrap intrinsic height calculation (a: layout, a: quality, cla: yes, framework, waiting for tree to go green)


[63426](https://github.com/flutter/flutter/pull/63426) Make RawKeyboard assert when no keys are in keysPressed when sending a key down event. (framework)


[63431](https://github.com/flutter/flutter/pull/63431) Revert "Add native stacktrace field for PlatformException" (framework)


[63434](https://github.com/flutter/flutter/pull/63434) add FrameTimingSummarizer (a: tests, framework, team, waiting for tree to go green)


[63438](https://github.com/flutter/flutter/pull/63438) More restoration documentation (cla: yes, d: api docs, d: examples, documentation, framework, team, waiting for tree to go green)


[63455](https://github.com/flutter/flutter/pull/63455) Fix SafeArea and SliverSafeArea debug flag properties (cla: yes, framework, waiting for tree to go green)


[63461](https://github.com/flutter/flutter/pull/63461) Removed the inputFormatters from the text input fields used by the Date Pickers (f: material design, framework, waiting for tree to go green)


[63495](https://github.com/flutter/flutter/pull/63495) migrate part of painting to nullsafety (framework, waiting for tree to go green)


[63497](https://github.com/flutter/flutter/pull/63497) Add dispose to restoration example (d: api docs, d: examples, documentation, framework, waiting for tree to go green)


[63502](https://github.com/flutter/flutter/pull/63502) Add native stacktrace field for PlatformException (cla: yes, framework)


[63503](https://github.com/flutter/flutter/pull/63503) Update: Documentation for ListView constructor should warn about changing widget list (cla: yes, d: api docs, documentation, framework, waiting for tree to go green)


[63515](https://github.com/flutter/flutter/pull/63515) allow null in compute for weak mode (cla: yes, framework, waiting for tree to go green)


[63523](https://github.com/flutter/flutter/pull/63523) Standardize the nullability of arguments to raw key data constructors. (a: tests, cla: yes, framework, team)


[63543](https://github.com/flutter/flutter/pull/63543) InteractiveViewer scale interpretation improvement (cla: yes, framework, waiting for tree to go green)


[63591](https://github.com/flutter/flutter/pull/63591) 1.20.2 Cherrypicks (a: internationalization, cla: yes, engine, f: material design, framework, team, tool, work in progress; do not review)


[63592](https://github.com/flutter/flutter/pull/63592) Hook up soft keyboard "next" and "previous" buttons so that they move the focus by default (cla: yes, framework)


[63595](https://github.com/flutter/flutter/pull/63595) Disables tests failing due to new semantics flag. (a: accessibility, a: tests, cla: yes, framework, waiting for tree to go green)


[63598](https://github.com/flutter/flutter/pull/63598) Add arguments for required parameters. (cla: yes, framework, team)


[63599](https://github.com/flutter/flutter/pull/63599) Ensure time picker input mode lays out correctly in RTL (a: internationalization, cla: yes, f: material design, framework, waiting for tree to go green)


[63600](https://github.com/flutter/flutter/pull/63600) Typo fix in finders.dart documentation (bySemanticsLabel) (a: tests, cla: yes, d: api docs, framework)


[63602](https://github.com/flutter/flutter/pull/63602) Ignore another dead_code hint for a weak-only null check. (cla: yes, framework, waiting for tree to go green)


[63604](https://github.com/flutter/flutter/pull/63604) Update LinearGradient docs (cla: yes, framework, waiting for tree to go green)


[63611](https://github.com/flutter/flutter/pull/63611) Revert "Fix RangeMaintainingScrollPhysics" (cla: yes, framework, waiting for tree to go green)


[63634](https://github.com/flutter/flutter/pull/63634) Improve docs for [PageStorage] (cla: yes, framework, waiting for tree to go green)


[63639](https://github.com/flutter/flutter/pull/63639) Warns when single line text fields overflow (a: tests, cla: yes, framework, waiting for tree to go green)


[63652](https://github.com/flutter/flutter/pull/63652) Add debug flag `debugProfileLayoutsEnabled` (cla: yes, framework, waiting for tree to go green)


[63668](https://github.com/flutter/flutter/pull/63668) Fix FittedBox BoxFit.scaleDown sizing (cla: yes, framework, waiting for tree to go green)


[63687](https://github.com/flutter/flutter/pull/63687) Remove decommission from RestorationBuckets (a: tests, cla: yes, framework, waiting for tree to go green)


[63692](https://github.com/flutter/flutter/pull/63692) "Draw" vs "drawer" typo (cla: yes, d: api docs, documentation, f: material design, framework, waiting for tree to go green)


[63703](https://github.com/flutter/flutter/pull/63703) migrate painting to nullsafety (cla: yes, framework, waiting for tree to go green)


[63705](https://github.com/flutter/flutter/pull/63705) Revert "Add native stacktrace field for PlatformException" (cla: yes, framework)


[63728](https://github.com/flutter/flutter/pull/63728) Provide the argument for a required parameter 'data'. (a: tests, cla: yes, framework, waiting for tree to go green)


[63754](https://github.com/flutter/flutter/pull/63754) [EditableText] Fix TextField crashed with composing and maxLength set (cla: yes, framework, waiting for tree to go green)


[63775](https://github.com/flutter/flutter/pull/63775) DecoratedBoxTransition sample code (cla: yes, framework, waiting for tree to go green)


[63776](https://github.com/flutter/flutter/pull/63776) Mention time picker theme in showTimePicker documentation (cla: yes, documentation, f: material design, framework, waiting for tree to go green)


[63784](https://github.com/flutter/flutter/pull/63784) Use reportError (over onError) everywhere (cla: yes, framework, waiting for tree to go green)


[63786](https://github.com/flutter/flutter/pull/63786) Make SelectableText work better on web (a: text input, a: typography, cla: yes, framework, platform-web, waiting for tree to go green)


[63794](https://github.com/flutter/flutter/pull/63794) Ignore/fix dead_code checks for weak-only null checks. (cla: yes, framework)


[63816](https://github.com/flutter/flutter/pull/63816) bug fix for pointer id in test gestures (a: tests, cla: yes, framework, waiting for tree to go green)


[63817](https://github.com/flutter/flutter/pull/63817) Fix some doc typo (a: tests, cla: yes, framework, waiting for tree to go green)


[63833](https://github.com/flutter/flutter/pull/63833) SizeTransition sample code (a: animation, cla: yes, d: api docs, d: examples, documentation, framework, waiting for tree to go green)


[63835](https://github.com/flutter/flutter/pull/63835) add vsync overhead to `FrameTimingSummarizer` (a: tests, cla: yes, framework, waiting for tree to go green)


[63884](https://github.com/flutter/flutter/pull/63884) updated_title_property_apidocs (cla: yes, d: api docs, documentation, framework, platform-web, waiting for tree to go green)


[63886](https://github.com/flutter/flutter/pull/63886) Add sample code for ScaleTransition (a: animation, cla: yes, d: api docs, d: examples, documentation, framework, waiting for tree to go green)


[63924](https://github.com/flutter/flutter/pull/63924) Remove TODOs added for HTTP abort() change in dart sdk (a: tests, cla: yes, framework, tool)


[63925](https://github.com/flutter/flutter/pull/63925) Fix bug when tapping ListTitle with CheckboxListTile  tristate enable (cla: yes, f: cupertino, f: material design, framework)


[63940](https://github.com/flutter/flutter/pull/63940) Add sample code to RelativePositionedTransition (a: animation, cla: yes, d: api docs, d: examples, documentation, framework, waiting for tree to go green)


[63972](https://github.com/flutter/flutter/pull/63972) Revert "Remove TODOs added for HTTP abort() change in dart sdk" (a: tests, cla: yes, framework, tool)


[63974](https://github.com/flutter/flutter/pull/63974) Move away from deprecated NoSuchMethodError to NoSuchMethodError.withInvocation (cla: yes, framework, waiting for tree to go green)


[63981](https://github.com/flutter/flutter/pull/63981) Fixed the docs of the focusColor property included in input_decorator (cla: yes, d: api docs, documentation, f: material design, framework, waiting for tree to go green)


[63994](https://github.com/flutter/flutter/pull/63994) SelectableText long press on iOS (cla: yes, f: material design, framework, waiting for tree to go green)


[64012](https://github.com/flutter/flutter/pull/64012) ClipboardStatusNotifier should handle errors in Clipboard.getData (cla: yes, framework, waiting for tree to go green)


[64046](https://github.com/flutter/flutter/pull/64046) Revert "fix wrap intrinsic height calculation" (cla: yes, framework)


[64050](https://github.com/flutter/flutter/pull/64050) 1.21.0-9.1.pre cherrypicks (cla: yes, engine, f: material design, framework, team, tool)


[64055](https://github.com/flutter/flutter/pull/64055) migrate semantics to nullsafety (a: accessibility, cla: yes, framework, waiting for tree to go green)


[64062](https://github.com/flutter/flutter/pull/64062) Revert "Prevent material switch from recreating its render object when it becomes disabled" (cla: yes, f: material design, framework, waiting for tree to go green)


[64071](https://github.com/flutter/flutter/pull/64071) [null-safety] enable null assertions for framework tests (cla: yes, framework, team, waiting for tree to go green)


[64076](https://github.com/flutter/flutter/pull/64076) remove ununsed deprecated field (cla: yes, framework, waiting for tree to go green)


[64091](https://github.com/flutter/flutter/pull/64091) Revert "Prevent viewport.showOnScreen from scrolling the viewport if the specified Rect is already visible. " (cla: yes, f: material design, framework)


[64094](https://github.com/flutter/flutter/pull/64094) Revert "Ensure time picker input mode lays out correctly in RTL" (a: internationalization, cla: yes, f: material design, framework)


[64097](https://github.com/flutter/flutter/pull/64097) [Material] Relanding fix to ensure time picker input mode lays out correctly in RTL (a: internationalization, cla: yes, f: material design, framework)


[64100](https://github.com/flutter/flutter/pull/64100) InteractiveViewer child positioning docs (cla: yes, framework, waiting for tree to go green)


[64101](https://github.com/flutter/flutter/pull/64101) ScaffoldMessenger (a: quality, cla: yes, customer: money (g3), f: material design, framework, severe: API break, severe: new feature, team, waiting for tree to go green)


[64115](https://github.com/flutter/flutter/pull/64115) Changes to initialDate for CalendarDatePicker should update the state. (cla: yes, f: material design, framework, waiting for tree to go green)


[64118](https://github.com/flutter/flutter/pull/64118) Revert "[null-safety] enable null assertions for framework tests" (cla: yes, framework, team)


[64119](https://github.com/flutter/flutter/pull/64119) Change MouseTracker's interface for clarity. Simplify MouseRegion's implementation. (a: desktop, a: mouse, cla: yes, framework)


[64120](https://github.com/flutter/flutter/pull/64120) [flutter_tools] reland: enable --null-assertions for flutter framework tests (a: accessibility, cla: yes, framework, team, waiting for tree to go green)


[64148](https://github.com/flutter/flutter/pull/64148) Update Visibility docs on maintainSize (cla: yes, d: api docs, documentation, framework, waiting for tree to go green)


[64167](https://github.com/flutter/flutter/pull/64167) Remove unused copyWith arguments in TimePickerThemeData (cla: yes, f: material design, framework, waiting for tree to go green)


[64175](https://github.com/flutter/flutter/pull/64175) feat: Text constructor, overflow, and softWrap docs (cla: yes, d: api docs, documentation, framework, waiting for tree to go green)


[64189](https://github.com/flutter/flutter/pull/64189) (insert|move|remove)ChildRenderObject Deprecation: Step 1 (cla: yes, f: cupertino, f: material design, framework)


[64199](https://github.com/flutter/flutter/pull/64199) Add native stacktrace field for PlatformException. (cla: yes, framework, waiting for tree to go green)


[64200](https://github.com/flutter/flutter/pull/64200) Ignore unnecessary casts that can go away soon. (cla: yes, framework, waiting for tree to go green)


[64217](https://github.com/flutter/flutter/pull/64217) (insert|move|remove)ChildRenderObject Deprecation: Step 2 (cla: yes, f: cupertino, f: material design, framework)


[64227](https://github.com/flutter/flutter/pull/64227) Add null safety migration annotations. (cla: yes, f: material design, framework, waiting for tree to go green)


[64235](https://github.com/flutter/flutter/pull/64235) fix: typo fixed from ENTER to SPACE (cla: yes, d: api docs, f: material design, framework, waiting for tree to go green)


[64239](https://github.com/flutter/flutter/pull/64239) The OverscrollIndicator should not overflow the scrollable view's edge (cla: yes, f: scrolling, framework, waiting for tree to go green)


[64249](https://github.com/flutter/flutter/pull/64249) Revert "(insert|move|remove)ChildRenderObject Deprecation: Step 1" (cla: yes, f: cupertino, f: material design, framework)


[64254](https://github.com/flutter/flutter/pull/64254) Re-apply "(insert|move|remove)ChildRenderObject Deprecation: Step 1" (cla: yes, f: cupertino, f: material design, framework)


[64258](https://github.com/flutter/flutter/pull/64258) update TimelineStream in `flutter_driver` (a: tests, cla: yes, framework, waiting for tree to go green)


[64267](https://github.com/flutter/flutter/pull/64267) [framework] make hit slop based on device pointer kind for drag/pan/scale gestures (a: desktop, cla: yes, f: gestures, framework)


[64268](https://github.com/flutter/flutter/pull/64268) Fix placement for SnackBarBehavior.floating (a: quality, cla: yes, f: material design, framework, severe: regression, waiting for tree to go green)


[64271](https://github.com/flutter/flutter/pull/64271) Make large jumpTo recommend deferred loading (a: images, cla: yes, f: scrolling, framework, perf: memory, severe: performance, waiting for tree to go green)


[64273](https://github.com/flutter/flutter/pull/64273) Remove remaining uses of `childToSlot` (cla: yes, f: cupertino, f: material design, framework)


[64276](https://github.com/flutter/flutter/pull/64276) Reland "fix wrap intrinsic height calculation (#63420)" (cla: yes, framework, waiting for tree to go green)


[64280](https://github.com/flutter/flutter/pull/64280) [null-safety] remove mockito from refresh control test (cla: yes, f: cupertino, framework, waiting for tree to go green)


[64284](https://github.com/flutter/flutter/pull/64284) [null-safety] remove mockito from network tests (cla: yes, framework, waiting for tree to go green)


[64295](https://github.com/flutter/flutter/pull/64295) Add rect logic to getOffsetToReveal when onlySlivers is true (cla: yes, framework, waiting for tree to go green)


[64308](https://github.com/flutter/flutter/pull/64308) Add finders for enableFlutterDriverExtension (a: tests, cla: yes, framework, waiting for tree to go green)


[64316](https://github.com/flutter/flutter/pull/64316) Add DataTableTheme to allow for themable DataTables (cla: yes, f: material design, framework, waiting for tree to go green)


[64350](https://github.com/flutter/flutter/pull/64350) Increase threshold for usage of compute for utf8 decoding on large strings to 50 KB (cla: yes, framework)


[64354](https://github.com/flutter/flutter/pull/64354) Reland "Prevent material switch from recreating its render object when it becomes disabled (#61398)" (cla: yes, f: material design, framework)


[64362](https://github.com/flutter/flutter/pull/64362) fix Container.clipBehaviour, clips the shadow in decoration (a: quality, cla: yes, framework, waiting for tree to go green, will affect goldens)


[64363](https://github.com/flutter/flutter/pull/64363) [null-safety] remove mockito from route test (cla: yes, f: cupertino, framework, waiting for tree to go green)


[64372](https://github.com/flutter/flutter/pull/64372) Revert "Increase threshold for usage of compute for utf8 decoding on large strings to 50 KB" (cla: yes, framework)


[64380](https://github.com/flutter/flutter/pull/64380) Fix TabBar jag when user interrupts ballistic scroll (cla: yes, f: material design, framework, waiting for tree to go green)


[64424](https://github.com/flutter/flutter/pull/64424) Add resampler unit test with widget (cla: yes, framework, waiting for tree to go green)


[64431](https://github.com/flutter/flutter/pull/64431) Add GestureDetector.onDoubleTapDown() (cla: yes, framework)


[64432](https://github.com/flutter/flutter/pull/64432) Reland "Make sure all isolates start during flutter driver tests" (a: tests, cla: yes, d: examples, framework, team, waiting for tree to go green)


[64441](https://github.com/flutter/flutter/pull/64441) Fix negative usableCrossAxisExtent in release mode (cla: yes, framework, waiting for tree to go green)


[64472](https://github.com/flutter/flutter/pull/64472) Update origin material button API doc with obsolete API warnings (cla: yes, f: material design, framework)


[64474](https://github.com/flutter/flutter/pull/64474) Protect against null context in action invoke in release mode (cla: yes, framework, waiting for tree to go green)


[64483](https://github.com/flutter/flutter/pull/64483) Removed deprecated ContainedButton and ContainedButtonTheme classes (cla: yes, f: material design, framework)


[64493](https://github.com/flutter/flutter/pull/64493) [null-safety] remove mockito from scrollbar test (cla: yes, framework)


[64498](https://github.com/flutter/flutter/pull/64498) Reland: Increase threshold for usage of compute for utf8 decoding on large strings to 50 KB (cla: yes, framework, tool, waiting for tree to go green)


[64513](https://github.com/flutter/flutter/pull/64513) Reland "Prevent viewport.showOnScreen from scrolling the viewport if the specified Rect is already visible.  (#56413)", reverted in #64091 (cla: yes, f: material design, f: scrolling, framework, waiting for tree to go green)


[64516](https://github.com/flutter/flutter/pull/64516) [web] Fix and enable editable_text_test.dart (a: tests, a: text input, cla: yes, framework, platform-web, team, waiting for tree to go green)


[64534](https://github.com/flutter/flutter/pull/64534) Slider paint incorrectly when the track shape is rectangular (cla: yes, f: material design, framework, waiting for tree to go green)


[64570](https://github.com/flutter/flutter/pull/64570) [web] Enable word boundary tests in editable_text_test.dart (a: tests, a: text input, a: typography, cla: yes, framework, platform-web, team, waiting for tree to go green)


[64573](https://github.com/flutter/flutter/pull/64573) Revert "Warns when single line text fields overflow (#63639)" (a: tests, cla: yes, framework)


[64584](https://github.com/flutter/flutter/pull/64584) Migrate physics tests to NNBD (cla: yes, framework, waiting for tree to go green)


[64596](https://github.com/flutter/flutter/pull/64596) Fixes router to not report route information when it is already up to… (cla: yes, framework, waiting for tree to go green)


[64599](https://github.com/flutter/flutter/pull/64599) Fix tests that use bogus objects, update TestImageInfo interface (cla: yes, f: cupertino, framework, waiting for tree to go green)


[64621](https://github.com/flutter/flutter/pull/64621) migrate rendering to nullsafety (a: tests, cla: yes, framework, waiting for tree to go green)


[64627](https://github.com/flutter/flutter/pull/64627) Slider and RangeSlider can be painted in a narrower constraint like other Material Wi… (cla: yes, f: material design, framework, waiting for tree to go green)


[64652](https://github.com/flutter/flutter/pull/64652) Revert "Reland: Increase threshold for usage of compute for utf8 decoding on large strings to 50 KB" (cla: yes, framework, tool)


[64668](https://github.com/flutter/flutter/pull/64668) Added support for lerpDuration() (cla: yes, framework, waiting for tree to go green)


[64672](https://github.com/flutter/flutter/pull/64672) Nnbd widgets (a: accessibility, cla: yes, f: cupertino, framework, team)


[64715](https://github.com/flutter/flutter/pull/64715) Clamp TabController animation value when calc _DragAnimation.value (a: animation, cla: yes, f: material design, framework, waiting for tree to go green)


[64737](https://github.com/flutter/flutter/pull/64737) Flutter Framework Beta 1.21.0-9.2.pre cherry picks (a: internationalization, cla: yes, engine, f: material design, framework, tool)


[64750](https://github.com/flutter/flutter/pull/64750) Allow for arbitrary placement in SliverGrid (cla: yes, customer: google, f: scrolling, framework, waiting for tree to go green)


[64757](https://github.com/flutter/flutter/pull/64757) Fix Gold json for digest paramset (a: tests, cla: yes, framework, team, team: infra, waiting for tree to go green)


[64760](https://github.com/flutter/flutter/pull/64760) Remove unnecessary downcasts on numeric operations. (cla: yes, framework, waiting for tree to go green)


[64776](https://github.com/flutter/flutter/pull/64776) Fix Android autofill username hint docs (cla: yes, d: api docs, framework, waiting for tree to go green)


[64791](https://github.com/flutter/flutter/pull/64791) Should have a guide for usage (and implementation) of ".of()"-style functions #4155 (cla: yes, framework, waiting for tree to go green)


[64795](https://github.com/flutter/flutter/pull/64795) Add sample code to RotationTransition (cla: yes, d: api docs, d: examples, documentation, framework, waiting for tree to go green)


[64813](https://github.com/flutter/flutter/pull/64813) Remove assert about release mode (cla: yes, framework)


[64840](https://github.com/flutter/flutter/pull/64840) Make Container always clip a decoration if it has a clip edge (cla: yes, f: cupertino, f: material design, framework)


[64855](https://github.com/flutter/flutter/pull/64855) Fixes issue, ReorderableListView destroys children even if their key-type wasn't changed (cla: yes, f: material design, framework, waiting for tree to go green)


[64879](https://github.com/flutter/flutter/pull/64879) [semantics] avoid sync* and excessive list copies (cla: yes, framework, waiting for tree to go green)


[64883](https://github.com/flutter/flutter/pull/64883) Revert "A benchmark test case for measuring scroll smoothness" (a: tests, cla: yes, framework, team)


[64885](https://github.com/flutter/flutter/pull/64885) Reland #61998 and update complex_layout ios files (a: tests, cla: yes, framework, team, waiting for tree to go green)


[64908](https://github.com/flutter/flutter/pull/64908) Match lerped values using moreOrLessEquals (cla: yes, f: cupertino, framework)


[64914](https://github.com/flutter/flutter/pull/64914) Prefer moreOrLessEquals over closeTo (cla: yes, framework)


[64915](https://github.com/flutter/flutter/pull/64915) Prefer moreOrLessEquals over closeTo (cla: yes, f: cupertino, f: material design, framework)


[64979](https://github.com/flutter/flutter/pull/64979) Expand Cupertino library comment (cla: yes, f: cupertino, framework, waiting for tree to go green)


[64982](https://github.com/flutter/flutter/pull/64982) Update Gold for new endpoint (a: tests, cla: yes, framework, team, team: infra, waiting for tree to go green)


[64984](https://github.com/flutter/flutter/pull/64984) Flutter stable framework 1.20.3 cherrypicks (a: internationalization, cla: yes, d: examples, engine, f: material design, framework, team, tool)


[64990](https://github.com/flutter/flutter/pull/64990) Revert "Reland #61998 and update complex_layout ios files" (a: tests, cla: yes, framework, team)


[65036](https://github.com/flutter/flutter/pull/65036) Update hintColor value for Material (cla: yes, f: material design, framework, waiting for tree to go green, will affect goldens)


[65049](https://github.com/flutter/flutter/pull/65049) Fixed the sliver appbar to have a fixed traversal order (a: accessibility, cla: yes, f: material design, framework, waiting for tree to go green)


[65051](https://github.com/flutter/flutter/pull/65051) Allow Developers to enable Accessibility testing on WebFlutterDriver and get the underlying webDriver (a: tests, cla: yes, framework, waiting for tree to go green)


[65060](https://github.com/flutter/flutter/pull/65060) Remove redundant import of dart:math (cla: yes, f: material design, framework, waiting for tree to go green)


[65083](https://github.com/flutter/flutter/pull/65083) Update CupertinoIcons to cupertino_icons 1.0.0 based on SF Symbols (cla: yes, f: cupertino, framework)


[65094](https://github.com/flutter/flutter/pull/65094) Fix InputDecoration contentPadding documentation words accent (cla: yes, f: material design, framework, waiting for tree to go green)


[65127](https://github.com/flutter/flutter/pull/65127) [web] Don't show handles when selection change is caused by keyboard (a: text input, cla: yes, framework, platform-web, waiting for tree to go green)


[65135](https://github.com/flutter/flutter/pull/65135) Fix RangeMaintainingScrollPhysics (cla: yes, f: scrolling, framework, waiting for tree to go green)


[65150](https://github.com/flutter/flutter/pull/65150) Expose 3 new methods with text metrics in RenderParagraph (a: typography, cla: yes, framework, waiting for tree to go green)


[65185](https://github.com/flutter/flutter/pull/65185) fix text.dart documentation (cla: yes, framework)


[65194](https://github.com/flutter/flutter/pull/65194) Disables test failing due to new semantics flag. (a: tests, cla: yes, framework)


[65199](https://github.com/flutter/flutter/pull/65199) Eliminate the need for the mockito package in animated_icons_private_test (cla: yes, f: material design, framework, waiting for tree to go green)


[65250](https://github.com/flutter/flutter/pull/65250) Fixed Tooltip widget docs. (cla: yes, f: material design, framework, waiting for tree to go green)


[65257](https://github.com/flutter/flutter/pull/65257) Revert "ScaffoldMessenger" (cla: yes, f: material design, framework)


[65273](https://github.com/flutter/flutter/pull/65273) Revert "Add finders for enableFlutterDriverExtension" (a: tests, cla: yes, framework)


[65276](https://github.com/flutter/flutter/pull/65276) Fix the test error of "Add finders for enableFlutterDriverExtension" and resubmit (a: tests, cla: yes, framework, waiting for tree to go green)


[65382](https://github.com/flutter/flutter/pull/65382) Revert "Add DataTableTheme to allow for themable DataTables (#64316)" (cla: yes, f: material design, framework, waiting for tree to go green)


[65383](https://github.com/flutter/flutter/pull/65383) Reland "Add DataTableTheme to allow for themable DataTables (#64316)" (cla: yes, f: material design, framework, waiting for tree to go green)


[65386](https://github.com/flutter/flutter/pull/65386) Flutter 1.22 candidate.10 (cla: yes, engine, f: material design, framework)


[65392](https://github.com/flutter/flutter/pull/65392) Small documentation udpate (cla: yes, framework)


[65394](https://github.com/flutter/flutter/pull/65394) SliverGridLayout API docs improvements (cla: yes, framework)


[65416](https://github.com/flutter/flutter/pull/65416) Re-land ScaffoldMessenger (cla: yes, f: material design, framework, waiting for tree to go green)


[65460](https://github.com/flutter/flutter/pull/65460) Clarified '/' route in initialRoute docs (cla: yes, framework, waiting for tree to go green)


[65482](https://github.com/flutter/flutter/pull/65482) Revert "Re-land ScaffoldMessenger" (cla: yes, f: material design, framework)


[65488](https://github.com/flutter/flutter/pull/65488) Revert "Nnbd widgets" (a: accessibility, cla: yes, f: cupertino, framework)


### team - 271 pull request(s)

[44980](https://github.com/flutter/flutter/pull/44980) Add padding around flutter api docs search input (cla: yes, team)


[55235](https://github.com/flutter/flutter/pull/55235) ignore .idea directory in dart analyzer and analyzer benchmark output in git (cla: yes, team)


[58640](https://github.com/flutter/flutter/pull/58640) Skip Audit - Rendering Library (a: quality, a: tests, cla: yes, framework, team, waiting for tree to go green)


[59114](https://github.com/flutter/flutter/pull/59114) Add support for Dart Development Service (DDS) in Flutter Tools (cla: yes, team, tool)


[59127](https://github.com/flutter/flutter/pull/59127) [Text Scaling][Material] Update BottomNavigationBar to show tooltips on long press. (cla: yes, f: cupertino, f: material design, framework, team)


[60238](https://github.com/flutter/flutter/pull/60238) Branch out android platform view perf testing (cla: yes, team)


[60446](https://github.com/flutter/flutter/pull/60446) Remove unused optional parameters of private functions. (a: tests, cla: yes, f: material design, framework, team, waiting for tree to go green)


[60632](https://github.com/flutter/flutter/pull/60632) Add locales for fil(filipino) and gsw(swiss german) to locale list, Fixes #60631 (a: internationalization, cla: yes, team, tool, waiting for tree to go green)


[60939](https://github.com/flutter/flutter/pull/60939) Add a benchmark that focuses on Paint object performance (cla: yes, team)


[60940](https://github.com/flutter/flutter/pull/60940) Skip Audit - Last Leftovers (a: quality, a: tests, cla: yes, f: cupertino, f: material design, framework, team, waiting for tree to go green)


[61007](https://github.com/flutter/flutter/pull/61007) Turn on add-to-app iOS platform unit tests (a: existing-apps, a: tests, cla: yes, platform-ios, team)


[61114](https://github.com/flutter/flutter/pull/61114) [flutter_tools] add support for enable null safety asserts (cla: yes, team, tool)


[61140](https://github.com/flutter/flutter/pull/61140) Case insensitive check flavor names against Xcode schemes (cla: yes, platform-ios, t: xcode, team, tool)


[61141](https://github.com/flutter/flutter/pull/61141) Add additional GTK keycodes for enter and tab (cla: yes, team)


[61177](https://github.com/flutter/flutter/pull/61177) use nnbd deps (team, tool)


[61196](https://github.com/flutter/flutter/pull/61196) Prefer tear offs to lambdas in test expects (cla: yes, team, tool)


[61203](https://github.com/flutter/flutter/pull/61203) Remove v1 Android create templates (cla: yes, team, tool, waiting for tree to go green)


[61205](https://github.com/flutter/flutter/pull/61205) Migrate Android views e2e to the new embedding (cla: yes, team)


[61215](https://github.com/flutter/flutter/pull/61215) Ignore .idea/* files in the analysis bot. (cla: yes, team, waiting for tree to go green)


[61257](https://github.com/flutter/flutter/pull/61257) [devicelab] This no-op change marks 3 tests to run on LUCI builders. (cla: yes, team, team: infra, waiting for tree to go green)


[61265](https://github.com/flutter/flutter/pull/61265) Added web compiler debug metadata (cla: yes, team, tool)


[61269](https://github.com/flutter/flutter/pull/61269) Parse .flutter-plugins-dependencies for add-to-app iOS modules (a: existing-apps, cla: yes, platform-ios, team, tool, waiting for tree to go green)


[61276](https://github.com/flutter/flutter/pull/61276) Revert "Add support for Dart Development Service (DDS) in Flutter Tools" (team, tool)


[61363](https://github.com/flutter/flutter/pull/61363) add new docker_attach.sh script and update README (cla: yes, team, waiting for tree to go green)


[61385](https://github.com/flutter/flutter/pull/61385) reland "Adds semantics information for the popup menu item (#61258)" (a: accessibility, cla: yes, f: material design, framework, team, waiting for tree to go green)


[61388](https://github.com/flutter/flutter/pull/61388) benchmarkLive: a new `LiveTestWidgetsFlutterBindingFramePolicy` for benchmark on device (a: tests, cla: yes, framework, team, waiting for tree to go green)


[61395](https://github.com/flutter/flutter/pull/61395) Reland "Add support for Dart Development Service (DDS) in Flutter Tools (#61276)" (cla: yes, team, tool)


[61417](https://github.com/flutter/flutter/pull/61417) Account for MotionEvent instance mutations (cla: yes, team, waiting for tree to go green)


[61482](https://github.com/flutter/flutter/pull/61482) Revert "Branch out android platform view perf testing (#60238)" (cla: yes, team)


[61488](https://github.com/flutter/flutter/pull/61488) Do not upload all pub packages into the zip bundle (cla: yes, team)


[61498](https://github.com/flutter/flutter/pull/61498) Revert "Reland "Add support for Dart Development Service (DDS) in Flutter Tools (#61276)"" (cla: yes, team, tool)


[61507](https://github.com/flutter/flutter/pull/61507) Android views using hybrid composition e2e driver test (cla: yes, team, waiting for tree to go green)


[61509](https://github.com/flutter/flutter/pull/61509) Add a E2E based performance test case (a: tests, cla: yes, framework, team, waiting for tree to go green)


[61517](https://github.com/flutter/flutter/pull/61517) [CONTRIBUTING.md] adds Contributing to Flutter article link (cla: yes, team, waiting for tree to go green)


[61552](https://github.com/flutter/flutter/pull/61552) Verbose process exceptions (cla: yes, team, tool, waiting for tree to go green)


[61554](https://github.com/flutter/flutter/pull/61554) Reland "Branch out android platform view perf testing (#60238)" (cla: yes, team)


[61564](https://github.com/flutter/flutter/pull/61564) ✒ Spell Check All `.md` Files Related to Flutter 💙 (a: internationalization, cla: yes, d: examples, team, tool, waiting for tree to go green)


[61573](https://github.com/flutter/flutter/pull/61573) Remove run_machine_concurrent_hot_reload device lab test (cla: yes, team)


[61585](https://github.com/flutter/flutter/pull/61585)  Show device diagnostic messages in doctor (cla: yes, t: flutter doctor, team, tool, waiting for tree to go green)


[61621](https://github.com/flutter/flutter/pull/61621) cleanup macrobenchmark duplicate files (cla: yes, team)


[61632](https://github.com/flutter/flutter/pull/61632) 1.20.0-7.2.pre framework cherrypicks (cla: yes, engine, framework, team)


[61633](https://github.com/flutter/flutter/pull/61633) Reland "Add support for Dart Development Service (DDS) in Flutter Tools (#61276)" (cla: yes, team, tool)


[61641](https://github.com/flutter/flutter/pull/61641) Revert "Reland "Add support for Dart Development Service (DDS) in Flutter Tools (#61276)"" (cla: yes, team, tool)


[61642](https://github.com/flutter/flutter/pull/61642) Revert "Reland "Branch out android platform view perf testing (#60238)"" (cla: yes, team)


[61646](https://github.com/flutter/flutter/pull/61646) Use device-finder instead of dev_finder is flutter code. (cla: yes, team, waiting for tree to go green)


[61647](https://github.com/flutter/flutter/pull/61647) update packages (cla: yes, team)


[61674](https://github.com/flutter/flutter/pull/61674) Revert "update packages" (cla: yes, team)


[61675](https://github.com/flutter/flutter/pull/61675) Update dependencies in hybrid android views test (cla: yes, team)


[61678](https://github.com/flutter/flutter/pull/61678) update packages (cla: yes, team, tool)


[61698](https://github.com/flutter/flutter/pull/61698) Mark flutter_gallery_ios32__transition_perf as flaky (cla: yes, team)


[61737](https://github.com/flutter/flutter/pull/61737) Mark smoke_catalina_start_up_ios as flaky (cla: yes, team)


[61748](https://github.com/flutter/flutter/pull/61748) Reland "Branch out android platform view perf testing #60238" 2nd time (cla: yes, team, waiting for tree to go green)


[61778](https://github.com/flutter/flutter/pull/61778) [Material] Updated icons and fonts (cla: yes, f: material design, framework, team, tool, waiting for tree to go green)


[61882](https://github.com/flutter/flutter/pull/61882) Reland "Add support for Dart Development Service (DDS) in Flutter Tools (#61276)" (cla: yes, team, tool)


[61909](https://github.com/flutter/flutter/pull/61909) Revert "Reland "Add support for Dart Development Service (DDS) in Flutter Tools (#61276)"" (cla: yes, team, tool)


[61916](https://github.com/flutter/flutter/pull/61916) Refactor gen_keycode: Split generators (cla: yes, framework, team)


[61918](https://github.com/flutter/flutter/pull/61918) Test dynamic surface switch (cla: yes, team, waiting for tree to go green)


[61921](https://github.com/flutter/flutter/pull/61921) Remove the flaky flag for frame policy test  (cla: yes, team, waiting for tree to go green)


[61941](https://github.com/flutter/flutter/pull/61941) migrate physics to nullsafety (cla: yes, framework, team, waiting for tree to go green)


[61975](https://github.com/flutter/flutter/pull/61975) Reland "Add support for Dart Development Service (DDS) in Flutter Tools (#61276) (cla: yes, team, tool)


[61978](https://github.com/flutter/flutter/pull/61978) bump nullsafety deps (cla: yes, team, tool, waiting for tree to go green)


[61993](https://github.com/flutter/flutter/pull/61993) Revert "Reland "Add support for Dart Development Service (DDS) in Flutter Tools (#61276)" (cla: yes, team, tool)


[61998](https://github.com/flutter/flutter/pull/61998) A benchmark test case for measuring scroll smoothness (a: tests, cla: yes, framework, team, waiting for tree to go green)


[62052](https://github.com/flutter/flutter/pull/62052) Update the FlutterLogo colors and gradients (cla: yes, f: cupertino, f: material design, framework, team, waiting for tree to go green)


[62064](https://github.com/flutter/flutter/pull/62064) Migrate gallery/transitions_perf test to e2e (a: accessibility, cla: yes, team, waiting for tree to go green)


[62082](https://github.com/flutter/flutter/pull/62082) Mark flutter_gallery_ios__transition_perf flaky during investigation (cla: yes, platform-ios, team, team: flakes)


[62085](https://github.com/flutter/flutter/pull/62085) Mark smoke_catalina_start_up_ios as not flaky (cla: yes, platform-ios, team, team: flakes, waiting for tree to go green)


[62147](https://github.com/flutter/flutter/pull/62147) Reland "Add support for Dart Development Service (DDS) in Flutter Tools (#61276)" (cla: yes, team, tool, waiting for tree to go green)


[62162](https://github.com/flutter/flutter/pull/62162) Add Crane test to the new Gallery app (cla: yes, team, waiting for tree to go green)


[62167](https://github.com/flutter/flutter/pull/62167) Ban unresolved dartdoc directives from HTML output (cla: yes, f: material design, framework, team, waiting for tree to go green)


[62217](https://github.com/flutter/flutter/pull/62217) Pass --disable-dart-dev in more places (cla: yes, team, tool)


[62218](https://github.com/flutter/flutter/pull/62218) Fix README typo (cla: yes, team, waiting for tree to go green)


[62219](https://github.com/flutter/flutter/pull/62219) Simplify macrobencharks/picture_cache (cla: yes, team, waiting for tree to go green)


[62234](https://github.com/flutter/flutter/pull/62234) Revert "bump nullsafety deps" (cla: yes, team, tool)


[62249](https://github.com/flutter/flutter/pull/62249) Add --disable-dart-dev to docs.sh (cla: yes, team)


[62251](https://github.com/flutter/flutter/pull/62251) Rather than timing out dashing, run it in background (cla: yes, team)


[62281](https://github.com/flutter/flutter/pull/62281) Sub-shard the docs shard (cla: yes, team)


[62340](https://github.com/flutter/flutter/pull/62340) Fix doc generation scripts (cla: yes, team)


[62348](https://github.com/flutter/flutter/pull/62348) Remove flaky flag for flutter_gallery_ios__transition_perf (cla: yes, team)


[62349](https://github.com/flutter/flutter/pull/62349) Macrobenchmarks e2e version bug fix (cla: yes, team, waiting for tree to go green)


[62367](https://github.com/flutter/flutter/pull/62367) Make dartdoc warnings fatal (& cleanup of warnings) (a: accessibility, a: internationalization, a: tests, cla: yes, f: cupertino, f: material design, framework, team, waiting for tree to go green)


[62368](https://github.com/flutter/flutter/pull/62368) [roll] roll to 2.10 (cla: yes, engine, team, tool)


[62372](https://github.com/flutter/flutter/pull/62372) Parse .flutter-plugins-dependencies for add-to-app iOS modules, remove no-op plugin iOS folder (a: existing-apps, cla: yes, platform-ios, team, tool)


[62386](https://github.com/flutter/flutter/pull/62386) Temporarily disable docset generation (cla: yes, team)


[62395](https://github.com/flutter/flutter/pull/62395) [gen_l10n] Synthetic package generation by default (a: internationalization, cla: yes, severe: API break, team, tool, waiting for tree to go green)


[62418](https://github.com/flutter/flutter/pull/62418) Add timeout to the devicelab runner logs (cla: yes, team)


[62430](https://github.com/flutter/flutter/pull/62430) Revert "Add Crane test to the new Gallery app" (cla: yes, team)


[62439](https://github.com/flutter/flutter/pull/62439) Bump new gallery version (cla: yes, team, waiting for tree to go green)


[62445](https://github.com/flutter/flutter/pull/62445) Add supported Luci builders for flutter repo (cla: yes, team, waiting for tree to go green)


[62495](https://github.com/flutter/flutter/pull/62495) Implement size analyzer to unzip & parse APK and AOT size snapshot to generate analysis json (cla: yes, team, tool)


[62511](https://github.com/flutter/flutter/pull/62511) Remove timeout on integration_ui_ios (cla: yes, team)


[62513](https://github.com/flutter/flutter/pull/62513) migrate services to nullsafety (cla: yes, framework, team)


[62520](https://github.com/flutter/flutter/pull/62520) Fix even more unresolved doc references in material (cla: yes, d: api docs, documentation, f: material design, framework, team, waiting for tree to go green)


[62523](https://github.com/flutter/flutter/pull/62523) Make the text field macrobenchmark work in debug mode (cla: yes, team, waiting for tree to go green)


[62525](https://github.com/flutter/flutter/pull/62525) update to use more null safe packages (cla: yes, team, tool, waiting for tree to go green)


[62529](https://github.com/flutter/flutter/pull/62529) Expose certain functions used when rolling Flutter (cla: yes, team)


[62534](https://github.com/flutter/flutter/pull/62534) [flutter_tools] deflake integration tests by running single isolate (cla: yes, team, waiting for tree to go green)


[62539](https://github.com/flutter/flutter/pull/62539) migrate macrobenchmark/multi_widget_construction test to e2e (cla: yes, team, waiting for tree to go green)


[62544](https://github.com/flutter/flutter/pull/62544) Reland "Add Crane test to the new Gallery app (#62162)" (cla: yes, team, waiting for tree to go green)


[62553](https://github.com/flutter/flutter/pull/62553) After cleaning up 812 warnings: Make warnings fatal in dartdocs (cla: yes, framework, team, waiting for tree to go green)


[62590](https://github.com/flutter/flutter/pull/62590) [flutter_tools] add snapshot analysis dependency (cla: yes, team)


[62614](https://github.com/flutter/flutter/pull/62614) Make dartdoc warnings fatal for flutter_test (cla: yes, framework, team, waiting for tree to go green)


[62623](https://github.com/flutter/flutter/pull/62623) Increase the number of shards for web tests (cla: yes, platform-web, team, team: infra, waiting for tree to go green)


[62628](https://github.com/flutter/flutter/pull/62628) Added a more generous timeout period for the keyboard animation in iOS integration tests (cla: yes, team, waiting for tree to go green)


[62630](https://github.com/flutter/flutter/pull/62630) Add integration test for plugins without ios directories (a: tests, cla: yes, platform-ios, team, waiting for tree to go green)


[62643](https://github.com/flutter/flutter/pull/62643) Remove framework_tests from cirrus. (cla: yes, team, team: infra, waiting for tree to go green)


[62646](https://github.com/flutter/flutter/pull/62646) [devicelab] Mark flutter_gallery_ios32__start_up as flaky. (cla: yes, team)


[62687](https://github.com/flutter/flutter/pull/62687) [versions] update to the latest sdk versions (cla: yes, team, tool, waiting for tree to go green)


[62704](https://github.com/flutter/flutter/pull/62704) remove flutter attach devicelab test (cla: yes, team)


[62710](https://github.com/flutter/flutter/pull/62710) Update prepare_package.dart to use the process_runner package instead having duplicate code. (cla: yes, team)


[62715](https://github.com/flutter/flutter/pull/62715) add benchmark for ChangeNotifier.notifyListeners (cla: yes, framework, team, waiting for tree to go green)


[62799](https://github.com/flutter/flutter/pull/62799) move compile/target sdk versions to 29 (a: accessibility, cla: yes, d: examples, team, tool, waiting for tree to go green)


[62814](https://github.com/flutter/flutter/pull/62814) Report failures in docs.sh (team, waiting for tree to go green)


[62816](https://github.com/flutter/flutter/pull/62816) Removed old button widget references from dev/manual_tests (team, waiting for tree to go green)


[62866](https://github.com/flutter/flutter/pull/62866) [null-safety] remove quiver from flutter tests (framework, team, waiting for tree to go green)


[62872](https://github.com/flutter/flutter/pull/62872) Reland "migrate part of painting to nullsafety (#62696)" (framework, team, waiting for tree to go green)


[62884](https://github.com/flutter/flutter/pull/62884) Revert "move compile/target sdk versions to 29" (a: accessibility, d: examples, team, tool)


[62898](https://github.com/flutter/flutter/pull/62898) Make the Skia expectation parser more resilient and update to "master_str" (a: tests, framework, team, waiting for tree to go green)


[62902](https://github.com/flutter/flutter/pull/62902) Change minimum iOS version from 8.0 to 9.0 (d: examples, platform-ios, team, tool, waiting for tree to go green)


[62903](https://github.com/flutter/flutter/pull/62903) Revert "remove iOS folder (#61561)" (cp: 1.20, cp: 1.20 completed, engine, framework, team, tool)


[62904](https://github.com/flutter/flutter/pull/62904) ISSUE_TEMPLATE changes (a: triage improvements, framework, team, waiting for tree to go green)


[62906](https://github.com/flutter/flutter/pull/62906) Add remaining benchmarks (team, waiting for tree to go green)


[62910](https://github.com/flutter/flutter/pull/62910) Add flutter_goldens_client to testing path (a: tests, team, team: infra, waiting for tree to go green)


[62920](https://github.com/flutter/flutter/pull/62920) Add a comment with a reference to issue 62919 (team, waiting for tree to go green)


[62932](https://github.com/flutter/flutter/pull/62932) Updated examples/layers to use the new button API. (d: examples, team, waiting for tree to go green)


[62946](https://github.com/flutter/flutter/pull/62946) [null-safety] update to several framework test cases/APIs for null assertions (a: tests, cla: yes, framework, team, tool, waiting for tree to go green)


[62986](https://github.com/flutter/flutter/pull/62986) Pin gallery version (team, waiting for tree to go green)


[62987](https://github.com/flutter/flutter/pull/62987) Rev json gem (team, waiting for tree to go green)


[62990](https://github.com/flutter/flutter/pull/62990) [hotfix] flutter create -t plugin remove no-op iOS folder and set sdk min to 1.20.0 (engine, framework, team, tool)


[63008](https://github.com/flutter/flutter/pull/63008) move compile/target sdk versions to 29 (#62799) (a: accessibility, d: examples, team, tool, waiting for tree to go green)


[63014](https://github.com/flutter/flutter/pull/63014) Mark nonflaky test as such (team, waiting for tree to go green)


[63017](https://github.com/flutter/flutter/pull/63017) update packages (team, tool, waiting for tree to go green)


[63021](https://github.com/flutter/flutter/pull/63021) Mark named_isolates_test flaky (team)


[63028](https://github.com/flutter/flutter/pull/63028) Remove cubic_bezier_perf.dart (team, waiting for tree to go green)


[63034](https://github.com/flutter/flutter/pull/63034) Remove Special Handling of Norwegian Locales (a: internationalization, f: cupertino, f: material design, framework, team)


[63111](https://github.com/flutter/flutter/pull/63111) Bump dartdoc to 0.32.3 and tighten doc output checker (team, waiting for tree to go green)


[63113](https://github.com/flutter/flutter/pull/63113) Revert "Add padding around flutter api docs search input" (team, waiting for tree to go green)


[63124](https://github.com/flutter/flutter/pull/63124) Measure CPU/GPU with the simple animation test (perf: energy, severe: performance, team, waiting for tree to go green)


[63128](https://github.com/flutter/flutter/pull/63128) remove flaky flag for multi_widget_construction_perf__e2e_summary (team, waiting for tree to go green)


[63197](https://github.com/flutter/flutter/pull/63197) Prepare macrobenchmarks' e2e tests for firebase test lab (team, waiting for tree to go green)


[63213](https://github.com/flutter/flutter/pull/63213) Updated old button references in dev/integration_tests/ui (team)


[63214](https://github.com/flutter/flutter/pull/63214) Updated old button references in dev/integration_tests/android_views (team)


[63215](https://github.com/flutter/flutter/pull/63215) Updated old button references in dev/integration_tests/hybrid_android_views (team)


[63232](https://github.com/flutter/flutter/pull/63232) Updated old button references in dev/integration_tests/android_semantics (a: accessibility, team)


[63245](https://github.com/flutter/flutter/pull/63245) Add framework and hostonly tests to luci presubmit. (team, waiting for tree to go green)


[63252](https://github.com/flutter/flutter/pull/63252) Bump Cirrus image Xcode version (cla: yes, platform-ios, team, team: infra)


[63257](https://github.com/flutter/flutter/pull/63257) Remove hostonly_tests from cirrus as they are now running on LUCI. (cla: yes, team)


[63336](https://github.com/flutter/flutter/pull/63336) Remove unused `l` and `--isolate-filter` tools (team, tool, waiting for tree to go green)


[63368](https://github.com/flutter/flutter/pull/63368) [gen_l10n] Absolute project path parameter (a: internationalization, team, tool, waiting for tree to go green)


[63400](https://github.com/flutter/flutter/pull/63400) Updated old button references in dev/integration_tests/flutter_gallery … cards_demo (f: material design, team)


[63402](https://github.com/flutter/flutter/pull/63402) Updated old button references in dev/integration_tests/flutter_gallery … banner_demo (f: material design, team)


[63404](https://github.com/flutter/flutter/pull/63404) Updated old button references in dev/integration_tests/flutter_gallery … drawer_demo (f: material design, team)


[63410](https://github.com/flutter/flutter/pull/63410) WidgetTester.drag with time duration (a: tests, cla: yes, framework, team, waiting for tree to go green)


[63412](https://github.com/flutter/flutter/pull/63412) Fix App.framework path in Podfile (a: existing-apps, cla: yes, platform-ios, team, tool, waiting for tree to go green)


[63430](https://github.com/flutter/flutter/pull/63430) Updated old button references in dev/integration_tests/flutter_gallery leave_behind_demo (f: material design, team)


[63432](https://github.com/flutter/flutter/pull/63432) Updated old button references in dev/integration_tests/flutter_gallery ... transformation_demo (team)


[63434](https://github.com/flutter/flutter/pull/63434) add FrameTimingSummarizer (a: tests, framework, team, waiting for tree to go green)


[63436](https://github.com/flutter/flutter/pull/63436) Trivial typo fixes to snippets documentation (cla: yes, team, waiting for tree to go green)


[63438](https://github.com/flutter/flutter/pull/63438) More restoration documentation (cla: yes, d: api docs, d: examples, documentation, framework, team, waiting for tree to go green)


[63439](https://github.com/flutter/flutter/pull/63439) Enable builds in presubmit and remove old ones. (team, waiting for tree to go green)


[63445](https://github.com/flutter/flutter/pull/63445) Pin iOS module test plugin versions (a: existing-apps, a: tests, platform-ios, team, waiting for tree to go green)


[63448](https://github.com/flutter/flutter/pull/63448) Temporarily turn off module_test_ios during investigation (platform-ios, team)


[63491](https://github.com/flutter/flutter/pull/63491) Updated old button references in dev/integration_tests/flutter_gallery ... full_screen_dialog_demo (f: material design, team)


[63492](https://github.com/flutter/flutter/pull/63492) Update prod builders. (cla: yes, team)


[63517](https://github.com/flutter/flutter/pull/63517) Move Android doctor SDK check to 29 and Cirrus images to 30 (a: accessibility, cla: yes, d: examples, team, tool)


[63518](https://github.com/flutter/flutter/pull/63518) Hide benchmark a/b results from git (cla: yes, team, waiting for tree to go green)


[63523](https://github.com/flutter/flutter/pull/63523) Standardize the nullability of arguments to raw key data constructors. (a: tests, cla: yes, framework, team)


[63532](https://github.com/flutter/flutter/pull/63532) Remove unused files (cla: yes, team, waiting for tree to go green)


[63536](https://github.com/flutter/flutter/pull/63536) [flutter_tools] move to fake_async, skip failing tests (cla: yes, team, tool, waiting for tree to go green)


[63538](https://github.com/flutter/flutter/pull/63538) Print dex when analyzing the APK (cla: yes, team, waiting for tree to go green)


[63591](https://github.com/flutter/flutter/pull/63591) 1.20.2 Cherrypicks (a: internationalization, cla: yes, engine, f: material design, framework, team, tool, work in progress; do not review)


[63593](https://github.com/flutter/flutter/pull/63593) Pin goldctl (cla: yes, team, team: infra, waiting for tree to go green)


[63594](https://github.com/flutter/flutter/pull/63594) Add win (cla: yes, team, waiting for tree to go green)


[63598](https://github.com/flutter/flutter/pull/63598) Add arguments for required parameters. (cla: yes, framework, team)


[63605](https://github.com/flutter/flutter/pull/63605) remove fuchsia_entrypoint_shim directory (cla: yes, team, tool, waiting for tree to go green)


[63608](https://github.com/flutter/flutter/pull/63608) Revert: Update prepare_package.dart to use the process_runner package instead having duplicate code. #62710 (cla: yes, team)


[63609](https://github.com/flutter/flutter/pull/63609) Clean up flutter_gallery__transition_perf (a: accessibility, cla: yes, team, waiting for tree to go green)


[63617](https://github.com/flutter/flutter/pull/63617) [flutter_tools] update size analysis version (cla: yes, team, waiting for tree to go green)


[63649](https://github.com/flutter/flutter/pull/63649) gen_l10n: support string list as preferred-supported-locales, as documented (cla: yes, team, tool)


[63726](https://github.com/flutter/flutter/pull/63726) Add windows builders to presubmit. (cla: yes, team)


[63736](https://github.com/flutter/flutter/pull/63736) Update task_names to add the platform. (cla: yes, team, waiting for tree to go green)


[63783](https://github.com/flutter/flutter/pull/63783) Add enabled flag for try builders (cla: yes, team)


[63797](https://github.com/flutter/flutter/pull/63797) add flutter_gallery__transition_perf_e2e to ios tests (cla: yes, team, waiting for tree to go green)


[63799](https://github.com/flutter/flutter/pull/63799) bug fix for flutter_gallery__transition_perf(_with_semantics) (a: accessibility, cla: yes, team)


[63801](https://github.com/flutter/flutter/pull/63801) Mark nonflaky tests as such (cla: yes, team, waiting for tree to go green)


[63804](https://github.com/flutter/flutter/pull/63804) drop xcpretty for tests (cla: yes, team)


[63815](https://github.com/flutter/flutter/pull/63815) [flutter_tools] correctly forward error only stdout in non-verbose modes (cla: yes, team, tool, waiting for tree to go green)


[63983](https://github.com/flutter/flutter/pull/63983) In macrobenchmarks e2e tests: ensureVisible => scrollUntilVisible (cla: yes, team, waiting for tree to go green)


[63995](https://github.com/flutter/flutter/pull/63995) Make cirrus tests presubmit only and add new luci tests. (cla: yes, team, waiting for tree to go green)


[64000](https://github.com/flutter/flutter/pull/64000) Rename needsMeasureCpuGpu to measureCpuGpu (cla: yes, team, waiting for tree to go green)


[64002](https://github.com/flutter/flutter/pull/64002) Increase simple animation delay and duration (cla: yes, team)


[64004](https://github.com/flutter/flutter/pull/64004) [devicelab] Enable a LUCI try builder. (cla: yes, team, waiting for tree to go green)


[64009](https://github.com/flutter/flutter/pull/64009) report list of detail files so devicelab can save them (cla: yes, team)


[64015](https://github.com/flutter/flutter/pull/64015) macrobenchmarks remove duplicate e2e driver (cla: yes, team, waiting for tree to go green)


[64020](https://github.com/flutter/flutter/pull/64020) [flutter_tool] Fix amberctl host address (cla: yes, d: examples, team, tool, waiting for tree to go green)


[64050](https://github.com/flutter/flutter/pull/64050) 1.21.0-9.1.pre cherrypicks (cla: yes, engine, f: material design, framework, team, tool)


[64056](https://github.com/flutter/flutter/pull/64056) Incorrect path.join usage might be causing Windows test failures (cla: yes, team, waiting for tree to go green)


[64060](https://github.com/flutter/flutter/pull/64060) Restore the original name of the velocity tracker microbenchmark (cla: yes, team, waiting for tree to go green)


[64067](https://github.com/flutter/flutter/pull/64067) [versions] update gallery, roll versions (cla: yes, team, waiting for tree to go green)


[64071](https://github.com/flutter/flutter/pull/64071) [null-safety] enable null assertions for framework tests (cla: yes, framework, team, waiting for tree to go green)


[64077](https://github.com/flutter/flutter/pull/64077) Mark tests as nonflaky (cla: yes, team)


[64079](https://github.com/flutter/flutter/pull/64079) update device lab manifest stage and required_agent_capabilities (cla: yes, team, waiting for tree to go green)


[64101](https://github.com/flutter/flutter/pull/64101) ScaffoldMessenger (a: quality, cla: yes, customer: money (g3), f: material design, framework, severe: API break, severe: new feature, team, waiting for tree to go green)


[64111](https://github.com/flutter/flutter/pull/64111) Fix assert in dartdoc_checker and enable asserts for our helper scripts (cla: yes, team, waiting for tree to go green)


[64112](https://github.com/flutter/flutter/pull/64112) Bump dartdoc to 0.30.4 (cla: yes, team, waiting for tree to go green)


[64116](https://github.com/flutter/flutter/pull/64116) Fix a data issue in prod_builder.json (cla: yes, team)


[64118](https://github.com/flutter/flutter/pull/64118) Revert "[null-safety] enable null assertions for framework tests" (cla: yes, framework, team)


[64120](https://github.com/flutter/flutter/pull/64120) [flutter_tools] reland: enable --null-assertions for flutter framework tests (a: accessibility, cla: yes, framework, team, waiting for tree to go green)


[64125](https://github.com/flutter/flutter/pull/64125) Remove windows docs from list of try jobs. (cla: yes, team)


[64160](https://github.com/flutter/flutter/pull/64160) [null-safety] roll to null-safe platform (cla: yes, team, tool)


[64180](https://github.com/flutter/flutter/pull/64180) Add run_if property for existing LUCI try builders (cla: yes, team)


[64185](https://github.com/flutter/flutter/pull/64185) run the test longer time for multi_widget_construction_perf (cla: yes, team)


[64186](https://github.com/flutter/flutter/pull/64186) [flutter_tools] null assertions off by default for web (cla: yes, team, tool)


[64195](https://github.com/flutter/flutter/pull/64195) [flutter_tools] update dwds, roll to null-safe file and process (cla: yes, team, tool, waiting for tree to go green)


[64201](https://github.com/flutter/flutter/pull/64201) [flutter_tools] migrate flutter_goldens, flutter_goldens client to null-safety (cla: yes, team, tool, waiting for tree to go green)


[64203](https://github.com/flutter/flutter/pull/64203) Don't fail docs-linux on release branches (cla: yes, team, tool, waiting for tree to go green)


[64255](https://github.com/flutter/flutter/pull/64255) Revert "run the test longer time for multi_widget_construction_perf" (cla: yes, team, waiting for tree to go green)


[64269](https://github.com/flutter/flutter/pull/64269) Mark e2e version of ios32 transition test nonflaky (cla: yes, team, waiting for tree to go green)


[64275](https://github.com/flutter/flutter/pull/64275) migrate flutter_gallery_sksl_warmup__transition_perf to e2e (cla: yes, team, waiting for tree to go green)


[64277](https://github.com/flutter/flutter/pull/64277) Remove windows_docs. (cla: yes, team, waiting for tree to go green)


[64331](https://github.com/flutter/flutter/pull/64331) Add web_smoke_tests to luci. (cla: yes, team)


[64341](https://github.com/flutter/flutter/pull/64341) Mark new_gallery__crane_perf as flaky (cla: yes, team, waiting for tree to go green)


[64361](https://github.com/flutter/flutter/pull/64361) Fix LUCI builders config (cla: yes, team)


[64364](https://github.com/flutter/flutter/pull/64364) Change typo profileDemos to restDemos (cla: yes, team, waiting for tree to go green)


[64432](https://github.com/flutter/flutter/pull/64432) Reland "Make sure all isolates start during flutter driver tests" (a: tests, cla: yes, d: examples, framework, team, waiting for tree to go green)


[64486](https://github.com/flutter/flutter/pull/64486) [devicelab] disable image list duration tests (cla: yes, team)


[64504](https://github.com/flutter/flutter/pull/64504) Change iOS plugin simulator archs from allow list to deny list (cla: yes, team, tool)


[64516](https://github.com/flutter/flutter/pull/64516) [web] Fix and enable editable_text_test.dart (a: tests, a: text input, cla: yes, framework, platform-web, team, waiting for tree to go green)


[64519](https://github.com/flutter/flutter/pull/64519) Re-enable image_list test with updated certificate(good for 3650 days). (cla: yes, d: examples, team)


[64570](https://github.com/flutter/flutter/pull/64570) [web] Enable word boundary tests in editable_text_test.dart (a: tests, a: text input, a: typography, cla: yes, framework, platform-web, team, waiting for tree to go green)


[64594](https://github.com/flutter/flutter/pull/64594) [null-safety] remove sound-null-safety by default, remove experiment flag (cla: yes, team)


[64609](https://github.com/flutter/flutter/pull/64609) Use Pixel4 for better wait times (cla: yes, team)


[64670](https://github.com/flutter/flutter/pull/64670) [fuchsia] Sync run test script with engine version (cla: yes, platform-fuchsia, team, team: infra, waiting for tree to go green)


[64672](https://github.com/flutter/flutter/pull/64672) Nnbd widgets (a: accessibility, cla: yes, f: cupertino, framework, team)


[64674](https://github.com/flutter/flutter/pull/64674) Avoid thinning frameworks in iOS extensions (cla: yes, platform-ios, team, tool, waiting for tree to go green)


[64676](https://github.com/flutter/flutter/pull/64676) Roll new gallery to help flaky Crane test (cla: yes, team, waiting for tree to go green)


[64729](https://github.com/flutter/flutter/pull/64729) Temporarily disable the mac/android test on LUCI (cla: yes, team)


[64736](https://github.com/flutter/flutter/pull/64736) [fuchsia] Refactor fuchsia_ctl use to a function (cla: yes, team, waiting for tree to go green)


[64757](https://github.com/flutter/flutter/pull/64757) Fix Gold json for digest paramset (a: tests, cla: yes, framework, team, team: infra, waiting for tree to go green)


[64762](https://github.com/flutter/flutter/pull/64762) Memory benchmark for showing large images in succession (cla: yes, perf: energy, perf: memory, severe: performance, team)


[64770](https://github.com/flutter/flutter/pull/64770) remove flaky flag for flutter_gallery_sksl_warmup__transition_perf_e2e (cla: yes, team, waiting for tree to go green)


[64780](https://github.com/flutter/flutter/pull/64780) Add FrameTiming delay to watchPerformance (cla: yes, team, waiting for tree to go green)


[64819](https://github.com/flutter/flutter/pull/64819) [fuchsia] Tests wait for device to be up after pave (cla: yes, team, waiting for tree to go green)


[64824](https://github.com/flutter/flutter/pull/64824) Revert "Roll new gallery to help flaky Crane test" (cla: yes, team)


[64829](https://github.com/flutter/flutter/pull/64829) Revert "Avoid thinning frameworks in iOS extensions" (cla: yes, team, tool)


[64837](https://github.com/flutter/flutter/pull/64837) [Devicelab] Temporarily remove testonly_devicelab_tests builder (cla: yes, team, waiting for tree to go green)


[64883](https://github.com/flutter/flutter/pull/64883) Revert "A benchmark test case for measuring scroll smoothness" (a: tests, cla: yes, framework, team)


[64885](https://github.com/flutter/flutter/pull/64885) Reland #61998 and update complex_layout ios files (a: tests, cla: yes, framework, team, waiting for tree to go green)


[64974](https://github.com/flutter/flutter/pull/64974) Fix typo in large_image_changer_test.dart (cla: yes, team, waiting for tree to go green)


[64977](https://github.com/flutter/flutter/pull/64977) Delete catalog generator android/ios tests (cla: yes, team, waiting for tree to go green)


[64978](https://github.com/flutter/flutter/pull/64978) devicelab: started averaging startup time for ios test (cla: yes, team, waiting for tree to go green)


[64982](https://github.com/flutter/flutter/pull/64982) Update Gold for new endpoint (a: tests, cla: yes, framework, team, team: infra, waiting for tree to go green)


[64984](https://github.com/flutter/flutter/pull/64984) Flutter stable framework 1.20.3 cherrypicks (a: internationalization, cla: yes, d: examples, engine, f: material design, framework, team, tool)


[64988](https://github.com/flutter/flutter/pull/64988) Add observatory Bonjour service to built iOS Info.plist bundle (cla: yes, platform-ios, t: xcode, team, tool)


[64990](https://github.com/flutter/flutter/pull/64990) Revert "Reland #61998 and update complex_layout ios files" (a: tests, cla: yes, framework, team)


[65025](https://github.com/flutter/flutter/pull/65025) Move gen_l10n into flutter_tools (a: internationalization, cla: yes, team, tool)


[65033](https://github.com/flutter/flutter/pull/65033) Mark large_image_changer tests as not flaky (cla: yes, team)


[65042](https://github.com/flutter/flutter/pull/65042) Attempt to fix no-response bot. (cla: yes, team, waiting for tree to go green)


[65054](https://github.com/flutter/flutter/pull/65054) Mark nonflaky tests as such (cla: yes, team)


[65109](https://github.com/flutter/flutter/pull/65109) Revert "Add observatory Bonjour service to built iOS Info.plist bundle" (cla: yes, team, tool)


[65124](https://github.com/flutter/flutter/pull/65124) Require xcode_backend.sh arguments (introduced in Flutter v0.0.7) (cla: yes, platform-ios, t: xcode, team, tool, waiting for tree to go green)


[65138](https://github.com/flutter/flutter/pull/65138) Add observatory Bonjour service to built iOS Info.plist bundle (cla: yes, platform-ios, t: xcode, team, tool)


[65141](https://github.com/flutter/flutter/pull/65141) Revert "Add observatory Bonjour service to built iOS Info.plist bundle" (cla: yes, team, tool)


[65142](https://github.com/flutter/flutter/pull/65142) Add observatory Bonjour service to built iOS Info.plist bundle (cla: yes, team, tool)


[65201](https://github.com/flutter/flutter/pull/65201) re-enable the post_backdrop_filter test with CPU/GPU measurements (cla: yes, team, waiting for tree to go green)


[65415](https://github.com/flutter/flutter/pull/65415) Remove flutter_gallery_ios32__transition_perf test (cla: yes, team, waiting for tree to go green)


[65434](https://github.com/flutter/flutter/pull/65434) [devicelab] Remove ~/.gradle after each devicelab task run (cla: yes, team, waiting for tree to go green)


[65481](https://github.com/flutter/flutter/pull/65481) Remove mac prod builder. (cla: yes, team)


[65566](https://github.com/flutter/flutter/pull/65566) Add mac builder in prod. (cla: yes, team, waiting for tree to go green)


[65571](https://github.com/flutter/flutter/pull/65571) Roll forward package:test to 1.16.0-nullsafety.4 to prepare for package:vm_service 5.0.0+1 (cla: yes, team, tool, waiting for tree to go green)


[65577](https://github.com/flutter/flutter/pull/65577) Mark `platform_views_scroll_perf_ios__timeline_summary` as flaky (cla: yes, team)


### tool - 224 pull request(s)

[55376](https://github.com/flutter/flutter/pull/55376) Add debounce support to daemon hot reload requests (cla: yes, tool, waiting for tree to go green)


[59114](https://github.com/flutter/flutter/pull/59114) Add support for Dart Development Service (DDS) in Flutter Tools (cla: yes, team, tool)


[60053](https://github.com/flutter/flutter/pull/60053) Set the application-id in the Linux shell (cla: yes, tool)


[60591](https://github.com/flutter/flutter/pull/60591) [flutter_tools] Separate style and data from AnalysisError (cla: yes, tool, waiting for tree to go green)


[60632](https://github.com/flutter/flutter/pull/60632) Add locales for fil(filipino) and gsw(swiss german) to locale list, Fixes #60631 (a: internationalization, cla: yes, team, tool, waiting for tree to go green)


[61114](https://github.com/flutter/flutter/pull/61114) [flutter_tools] add support for enable null safety asserts (cla: yes, team, tool)


[61135](https://github.com/flutter/flutter/pull/61135) Add spaces between sentences in create --platforms help text (cla: yes, tool, waiting for tree to go green)


[61139](https://github.com/flutter/flutter/pull/61139) [flutter_tools] remove globals from device manager, flutter tester (cla: yes, tool)


[61140](https://github.com/flutter/flutter/pull/61140) Case insensitive check flavor names against Xcode schemes (cla: yes, platform-ios, t: xcode, team, tool)


[61146](https://github.com/flutter/flutter/pull/61146) [flutter_tools] Unified analyze error log format (cla: yes, tool)


[61177](https://github.com/flutter/flutter/pull/61177) use nnbd deps (team, tool)


[61178](https://github.com/flutter/flutter/pull/61178) [flutter_tools] cleanups to web runner functionality (cla: yes, tool, waiting for tree to go green)


[61191](https://github.com/flutter/flutter/pull/61191) [flutter_tools] switch order of injection (cla: yes, tool, waiting for tree to go green)


[61196](https://github.com/flutter/flutter/pull/61196) Prefer tear offs to lambdas in test expects (cla: yes, team, tool)


[61198](https://github.com/flutter/flutter/pull/61198) [flutter_tools] allow unmuting of command logging (cla: yes, tool, waiting for tree to go green)


[61201](https://github.com/flutter/flutter/pull/61201) [flutter_tools] abstract logger construction (why can't I hold all these loggers) (cla: yes, tool, waiting for tree to go green)


[61203](https://github.com/flutter/flutter/pull/61203) Remove v1 Android create templates (cla: yes, team, tool, waiting for tree to go green)


[61209](https://github.com/flutter/flutter/pull/61209) Optionally invert oversized images (a: debugging, a: error message, a: images, cla: yes, framework, tool)


[61253](https://github.com/flutter/flutter/pull/61253) [flutter_tools] deflake integration test with tryToDelete (cla: yes, tool)


[61256](https://github.com/flutter/flutter/pull/61256) Fix bold not getting cleared on new line (cla: yes, tool, waiting for tree to go green)


[61261](https://github.com/flutter/flutter/pull/61261) [flutter_tools] generate a synthetic flutter_gen package on pub get (cla: yes, tool)


[61265](https://github.com/flutter/flutter/pull/61265) Added web compiler debug metadata (cla: yes, team, tool)


[61269](https://github.com/flutter/flutter/pull/61269) Parse .flutter-plugins-dependencies for add-to-app iOS modules (a: existing-apps, cla: yes, platform-ios, team, tool, waiting for tree to go green)


[61276](https://github.com/flutter/flutter/pull/61276) Revert "Add support for Dart Development Service (DDS) in Flutter Tools" (team, tool)


[61312](https://github.com/flutter/flutter/pull/61312) Add more tips for androidLicensesUnknown (cla: yes, tool, waiting for tree to go green)


[61338](https://github.com/flutter/flutter/pull/61338) Show correct errors when plugins yaml forgot the 'flutter.plugins.pla… (cla: yes, tool, waiting for tree to go green)


[61359](https://github.com/flutter/flutter/pull/61359) Add a flag for using WebSockets for the Dart Debug extension backend service (cla: yes, tool, waiting for tree to go green)


[61395](https://github.com/flutter/flutter/pull/61395) Reland "Add support for Dart Development Service (DDS) in Flutter Tools (#61276)" (cla: yes, team, tool)


[61408](https://github.com/flutter/flutter/pull/61408) Add the ability to ignore lines from coverage depending on comments (cla: yes, tool, waiting for tree to go green)


[61411](https://github.com/flutter/flutter/pull/61411) [flutter_tools] add the feature for single widget reloads (cla: yes, tool)


[61413](https://github.com/flutter/flutter/pull/61413) [flutter_tools] update fastReassemble method for single widget reloads (cla: yes, framework, tool)


[61475](https://github.com/flutter/flutter/pull/61475) [flutter_tools] turn down flutter generate (cla: yes, tool)


[61481](https://github.com/flutter/flutter/pull/61481) [flutter_tools] add feature for iOS, android, and fuchsia (cla: yes, tool)


[61484](https://github.com/flutter/flutter/pull/61484) Support Xcode patch version comparison (cla: yes, platform-ios, t: xcode, tool, waiting for tree to go green)


[61491](https://github.com/flutter/flutter/pull/61491) Remove code that morphs --sound-null-safety to --null-safety options (cla: yes, tool, waiting for tree to go green)


[61498](https://github.com/flutter/flutter/pull/61498) Revert "Reland "Add support for Dart Development Service (DDS) in Flutter Tools (#61276)"" (cla: yes, team, tool)


[61513](https://github.com/flutter/flutter/pull/61513) [flutter_tools] Make flutter git upstream configurable (cla: yes, tool, waiting for tree to go green)


[61518](https://github.com/flutter/flutter/pull/61518) Change xcodebuild to be a "slow operation" (cla: yes, t: xcode, tool)


[61535](https://github.com/flutter/flutter/pull/61535) Tweak message about debugging with web-server (cla: yes, tool)


[61548](https://github.com/flutter/flutter/pull/61548) [flutter_tools] fix typo in test code (cla: yes, tool)


[61552](https://github.com/flutter/flutter/pull/61552) Verbose process exceptions (cla: yes, team, tool, waiting for tree to go green)


[61561](https://github.com/flutter/flutter/pull/61561) [flutter_tool] remove no-op iOS folder when creating plugins. (cla: yes, targeted to release: 1.20, tool)


[61564](https://github.com/flutter/flutter/pull/61564) ✒ Spell Check All `.md` Files Related to Flutter 💙 (a: internationalization, cla: yes, d: examples, team, tool, waiting for tree to go green)


[61568](https://github.com/flutter/flutter/pull/61568) Fix build (fix references to _flutter -> flutter) (cla: yes, tool)


[61569](https://github.com/flutter/flutter/pull/61569) Updated instructions of 'flutter help attach' (cla: yes, tool, waiting for tree to go green)


[61582](https://github.com/flutter/flutter/pull/61582) Remote returns for function expression inferred return type void. (cla: yes, framework, tool, waiting for tree to go green)


[61585](https://github.com/flutter/flutter/pull/61585)  Show device diagnostic messages in doctor (cla: yes, t: flutter doctor, team, tool, waiting for tree to go green)


[61593](https://github.com/flutter/flutter/pull/61593) remove flutter update-packages from tools-tests (cla: yes, tool, waiting for tree to go green)


[61633](https://github.com/flutter/flutter/pull/61633) Reland "Add support for Dart Development Service (DDS) in Flutter Tools (#61276)" (cla: yes, team, tool)


[61634](https://github.com/flutter/flutter/pull/61634) [flutter_tools] turn off fuchsia support by default (cla: yes, tool, waiting for tree to go green)


[61640](https://github.com/flutter/flutter/pull/61640) [flutter_tools] update device discovery constructors (cla: yes, tool, waiting for tree to go green)


[61641](https://github.com/flutter/flutter/pull/61641) Revert "Reland "Add support for Dart Development Service (DDS) in Flutter Tools (#61276)"" (cla: yes, team, tool)


[61678](https://github.com/flutter/flutter/pull/61678) update packages (cla: yes, team, tool)


[61684](https://github.com/flutter/flutter/pull/61684) Skip printing rendered error text in machine mode (cla: yes, tool, waiting for tree to go green)


[61760](https://github.com/flutter/flutter/pull/61760) [flutter_tools] revert dart format changes (cla: yes, cp: 1.20, cp: 1.20 completed, tool, waiting for tree to go green)


[61762](https://github.com/flutter/flutter/pull/61762) Inject iproxy into context (cla: yes, platform-ios, tool, waiting for tree to go green)


[61766](https://github.com/flutter/flutter/pull/61766) [flutter_tools] Add plumbing for widget cache (cla: yes, tool)


[61778](https://github.com/flutter/flutter/pull/61778) [Material] Updated icons and fonts (cla: yes, f: material design, framework, team, tool, waiting for tree to go green)


[61881](https://github.com/flutter/flutter/pull/61881) [flutter_tools] Concise dart2js commands outputKernel & outputJavaScript (cla: yes, tool, waiting for tree to go green)


[61882](https://github.com/flutter/flutter/pull/61882) Reland "Add support for Dart Development Service (DDS) in Flutter Tools (#61276)" (cla: yes, team, tool)


[61909](https://github.com/flutter/flutter/pull/61909) Revert "Reland "Add support for Dart Development Service (DDS) in Flutter Tools (#61276)"" (cla: yes, team, tool)


[61912](https://github.com/flutter/flutter/pull/61912) Disable the deferred loading variant of gen_l10n_test (cla: yes, tool, waiting for tree to go green)


[61913](https://github.com/flutter/flutter/pull/61913) [flutter_tools] macOS cleanups, attach to log reader in release mode (cla: yes, tool, waiting for tree to go green)


[61975](https://github.com/flutter/flutter/pull/61975) Reland "Add support for Dart Development Service (DDS) in Flutter Tools (#61276) (cla: yes, team, tool)


[61978](https://github.com/flutter/flutter/pull/61978) bump nullsafety deps (cla: yes, team, tool, waiting for tree to go green)


[61979](https://github.com/flutter/flutter/pull/61979) Only try to get build settings if the Xcode project exists (cla: yes, platform-ios, t: xcode, tool, waiting for tree to go green)


[61993](https://github.com/flutter/flutter/pull/61993) Revert "Reland "Add support for Dart Development Service (DDS) in Flutter Tools (#61276)" (cla: yes, team, tool)


[61996](https://github.com/flutter/flutter/pull/61996) [flutter_tools] check in script for generating per library unit coverage (cla: yes, tool, waiting for tree to go green)


[62053](https://github.com/flutter/flutter/pull/62053) [flutter_tools] add flutterRoot field to JSON machine output (cla: yes, tool, waiting for tree to go green)


[62061](https://github.com/flutter/flutter/pull/62061) [flutter_tools] clean plugin dependencies file (cla: yes, tool)


[62069](https://github.com/flutter/flutter/pull/62069) [flutter_tools] remove breakpoints from paused isolate on hot restart (cla: yes, tool, waiting for tree to go green)


[62070](https://github.com/flutter/flutter/pull/62070) Detect exact device ID matches quickly (cla: yes, tool, waiting for tree to go green)


[62076](https://github.com/flutter/flutter/pull/62076) [flutter_tools] switch cache mode to reload (cla: yes, tool, waiting for tree to go green)


[62094](https://github.com/flutter/flutter/pull/62094) Ensure analytics are sent before disabling (cla: yes, tool, waiting for tree to go green)


[62096](https://github.com/flutter/flutter/pull/62096) [flutter_tools] ensure x64 is built if target-platforms is not specified (cla: yes, tool, waiting for tree to go green)


[62115](https://github.com/flutter/flutter/pull/62115) [flutter_tool] [web] Remove x-frame-options header during debug (cla: yes, tool)


[62147](https://github.com/flutter/flutter/pull/62147) Reland "Add support for Dart Development Service (DDS) in Flutter Tools (#61276)" (cla: yes, team, tool, waiting for tree to go green)


[62152](https://github.com/flutter/flutter/pull/62152) [flutter_tools] deflake fastReassemble test (cla: yes, tool, waiting for tree to go green)


[62217](https://github.com/flutter/flutter/pull/62217) Pass --disable-dart-dev in more places (cla: yes, team, tool)


[62221](https://github.com/flutter/flutter/pull/62221) Add purge-persistent-cache option to run and drive (cla: yes, tool)


[62225](https://github.com/flutter/flutter/pull/62225) Handle hyphens in iOS UDIDs (cla: yes, platform-ios, tool)


[62234](https://github.com/flutter/flutter/pull/62234) Revert "bump nullsafety deps" (cla: yes, team, tool)


[62272](https://github.com/flutter/flutter/pull/62272) [flutter_tools] fix exit label for batchfile (cla: yes, tool, waiting for tree to go green)


[62364](https://github.com/flutter/flutter/pull/62364) Wrap launching devtools in DevtoolsLauncher (cla: yes, tool, waiting for tree to go green)


[62368](https://github.com/flutter/flutter/pull/62368) [roll] roll to 2.10 (cla: yes, engine, team, tool)


[62372](https://github.com/flutter/flutter/pull/62372) Parse .flutter-plugins-dependencies for add-to-app iOS modules, remove no-op plugin iOS folder (a: existing-apps, cla: yes, platform-ios, team, tool)


[62395](https://github.com/flutter/flutter/pull/62395) [gen_l10n] Synthetic package generation by default (a: internationalization, cla: yes, severe: API break, team, tool, waiting for tree to go green)


[62426](https://github.com/flutter/flutter/pull/62426) [flutter_tools] ensure desktop builds can run without flutter_tools' package_config (cla: yes, tool, waiting for tree to go green)


[62444](https://github.com/flutter/flutter/pull/62444) 1.20.0-7.3.pre beta cherrypicks (CQ+1, cla: yes, engine, tool)


[62495](https://github.com/flutter/flutter/pull/62495) Implement size analyzer to unzip & parse APK and AOT size snapshot to generate analysis json (cla: yes, team, tool)


[62508](https://github.com/flutter/flutter/pull/62508) Temporarily disable Dart Development Service in flutter_tools (cla: yes, tool)


[62515](https://github.com/flutter/flutter/pull/62515) [plugin_template] replaces deprecated method usage for android template (cla: yes, tool, waiting for tree to go green)


[62525](https://github.com/flutter/flutter/pull/62525) update to use more null safe packages (cla: yes, team, tool, waiting for tree to go green)


[62577](https://github.com/flutter/flutter/pull/62577) Allow Flutter Web Driver testing in debug mode. (cla: yes, tool, waiting for tree to go green)


[62580](https://github.com/flutter/flutter/pull/62580) [flutter_tools] delete test that will start failing (cla: yes, tool, waiting for tree to go green)


[62593](https://github.com/flutter/flutter/pull/62593) [flutter_tools] fix formatting regression in analyze and add full coverage (cla: yes, tool, waiting for tree to go green)


[62599](https://github.com/flutter/flutter/pull/62599) [flutter_tools] update pubspec .yaml message should not be displayed when creating a new plugin (cla: yes, tool)


[62605](https://github.com/flutter/flutter/pull/62605) [flutter_tools]Set plugin template min flutter sdk version to 1.20 (cla: yes, tool, waiting for tree to go green)


[62608](https://github.com/flutter/flutter/pull/62608) Add daemon handler to start devtools (cla: yes, tool, waiting for tree to go green)


[62687](https://github.com/flutter/flutter/pull/62687) [versions] update to the latest sdk versions (cla: yes, team, tool, waiting for tree to go green)


[62697](https://github.com/flutter/flutter/pull/62697) [flutter_tools] add --analyze-size flag (cla: yes, tool, waiting for tree to go green)


[62702](https://github.com/flutter/flutter/pull/62702) Return devtools serve response instead of printing (cla: yes, tool, waiting for tree to go green)


[62755](https://github.com/flutter/flutter/pull/62755) Add punctuation for unterminated sentences in doc comments (a: accessibility, a: internationalization, a: tests, cla: yes, d: api docs, documentation, f: cupertino, f: material design, framework, tool)


[62792](https://github.com/flutter/flutter/pull/62792) Remove mistakenly added DartDevelopmentService dependency (cla: yes, tool)


[62799](https://github.com/flutter/flutter/pull/62799) move compile/target sdk versions to 29 (a: accessibility, cla: yes, d: examples, team, tool, waiting for tree to go green)


[62884](https://github.com/flutter/flutter/pull/62884) Revert "move compile/target sdk versions to 29" (a: accessibility, d: examples, team, tool)


[62888](https://github.com/flutter/flutter/pull/62888) Update error message for bad UTF-8 decoding (tool, waiting for tree to go green)


[62892](https://github.com/flutter/flutter/pull/62892) There's a bug filed about this now, so update comment. (tool, waiting for tree to go green)


[62893](https://github.com/flutter/flutter/pull/62893) Update link to bug (tool, waiting for tree to go green)


[62902](https://github.com/flutter/flutter/pull/62902) Change minimum iOS version from 8.0 to 9.0 (d: examples, platform-ios, team, tool, waiting for tree to go green)


[62903](https://github.com/flutter/flutter/pull/62903) Revert "remove iOS folder (#61561)" (cp: 1.20, cp: 1.20 completed, engine, framework, team, tool)


[62926](https://github.com/flutter/flutter/pull/62926) [flutter_tools] remove reference to flutter tool test from user generated gitignore (tool, waiting for tree to go green)


[62930](https://github.com/flutter/flutter/pull/62930) [flutter_tools] warn when main library is relocated (tool, waiting for tree to go green)


[62946](https://github.com/flutter/flutter/pull/62946) [null-safety] update to several framework test cases/APIs for null assertions (a: tests, cla: yes, framework, team, tool, waiting for tree to go green)


[62979](https://github.com/flutter/flutter/pull/62979) Add libblkid as an explicit dependancy on Linux (tool, waiting for tree to go green)


[62990](https://github.com/flutter/flutter/pull/62990) [hotfix] flutter create -t plugin remove no-op iOS folder and set sdk min to 1.20.0 (engine, framework, team, tool)


[62999](https://github.com/flutter/flutter/pull/62999) Add flutter_engine.cc to Windows wrapper build (a: desktop, platform-windows, tool, waiting for tree to go green)


[63008](https://github.com/flutter/flutter/pull/63008) move compile/target sdk versions to 29 (#62799) (a: accessibility, d: examples, team, tool, waiting for tree to go green)


[63017](https://github.com/flutter/flutter/pull/63017) update packages (team, tool, waiting for tree to go green)


[63019](https://github.com/flutter/flutter/pull/63019) [flutter_tools] flutter version reports picks up release versions (tool, waiting for tree to go green)


[63154](https://github.com/flutter/flutter/pull/63154) Update "shortcut icon" to "icon" in Web Template (tool, waiting for tree to go green)


[63250](https://github.com/flutter/flutter/pull/63250) [flutter tools] Make SizeAnalyzer support .apk files that don't use libapp.so (tool, waiting for tree to go green)


[63301](https://github.com/flutter/flutter/pull/63301) [Windows] Fix unnecessary surface creation/destruction in startup path (cla: yes, tool, waiting for tree to go green)


[63336](https://github.com/flutter/flutter/pull/63336) Remove unused `l` and `--isolate-filter` tools (team, tool, waiting for tree to go green)


[63339](https://github.com/flutter/flutter/pull/63339) Remove enableR8=true from gradle.properties (tool, waiting for tree to go green)


[63368](https://github.com/flutter/flutter/pull/63368) [gen_l10n] Absolute project path parameter (a: internationalization, team, tool, waiting for tree to go green)


[63412](https://github.com/flutter/flutter/pull/63412) Fix App.framework path in Podfile (a: existing-apps, cla: yes, platform-ios, team, tool, waiting for tree to go green)


[63416](https://github.com/flutter/flutter/pull/63416) [flutter_tools] add --null-assertions flag for debugging with null safety (tool, waiting for tree to go green)


[63433](https://github.com/flutter/flutter/pull/63433) Remove more timeouts (tool, waiting for tree to go green)


[63446](https://github.com/flutter/flutter/pull/63446) [flutter_tools] add more error context to tree shaker failure (tool, waiting for tree to go green)


[63505](https://github.com/flutter/flutter/pull/63505) Fix version parsing (cla: yes, tool)


[63517](https://github.com/flutter/flutter/pull/63517) Move Android doctor SDK check to 29 and Cirrus images to 30 (a: accessibility, cla: yes, d: examples, team, tool)


[63526](https://github.com/flutter/flutter/pull/63526) [flutter_tools] handle invalid yaml in plugin dependency (cla: yes, tool, waiting for tree to go green)


[63536](https://github.com/flutter/flutter/pull/63536) [flutter_tools] move to fake_async, skip failing tests (cla: yes, team, tool, waiting for tree to go green)


[63540](https://github.com/flutter/flutter/pull/63540) [flutter_tools] check for permission issues when copying file (cla: yes, tool, waiting for tree to go green)


[63591](https://github.com/flutter/flutter/pull/63591) 1.20.2 Cherrypicks (a: internationalization, cla: yes, engine, f: material design, framework, team, tool, work in progress; do not review)


[63605](https://github.com/flutter/flutter/pull/63605) remove fuchsia_entrypoint_shim directory (cla: yes, team, tool, waiting for tree to go green)


[63610](https://github.com/flutter/flutter/pull/63610) [flutter_tools] support code size tooling on iOS, linux, windows, macOS, and Android on Windows (cla: yes, tool)


[63612](https://github.com/flutter/flutter/pull/63612) [windows] Propagate startup errors in template (cla: yes, tool, waiting for tree to go green)


[63649](https://github.com/flutter/flutter/pull/63649) gen_l10n: support string list as preferred-supported-locales, as documented (cla: yes, team, tool)


[63697](https://github.com/flutter/flutter/pull/63697) [flutter_tools] remove most globals from build system and tests (cla: yes, tool, waiting for tree to go green)


[63707](https://github.com/flutter/flutter/pull/63707) Surface Windows build errors in non-verbose mode (a: build, a: desktop, cla: yes, platform-windows, tool, waiting for tree to go green)


[63795](https://github.com/flutter/flutter/pull/63795) Return host and port from devtools launcher (cla: yes, tool, waiting for tree to go green)


[63796](https://github.com/flutter/flutter/pull/63796) [flutter_tool] Fix some create_test.dart tests on Windows (cla: yes, tool)


[63806](https://github.com/flutter/flutter/pull/63806) [flutter_tool] Handle Windows line endings in packages_test.dart (cla: yes, tool, waiting for tree to go green)


[63810](https://github.com/flutter/flutter/pull/63810) Separate blkid in the Linux library checks (cla: yes, tool, waiting for tree to go green)


[63815](https://github.com/flutter/flutter/pull/63815) [flutter_tools] correctly forward error only stdout in non-verbose modes (cla: yes, team, tool, waiting for tree to go green)


[63818](https://github.com/flutter/flutter/pull/63818) [flutter_tools] add cache busting query param (cla: yes, tool, waiting for tree to go green)


[63829](https://github.com/flutter/flutter/pull/63829) Make deprecation notice link to website downloads (cla: yes, tool, waiting for tree to go green)


[63831](https://github.com/flutter/flutter/pull/63831) [flutter_tools] remove globals from utils (cla: yes, tool, waiting for tree to go green)


[63840](https://github.com/flutter/flutter/pull/63840) [flutter_tools] shrink fingerprinter API to currently used subset (cla: yes, tool, waiting for tree to go green)


[63867](https://github.com/flutter/flutter/pull/63867) [flutter_tools] shrink API surface of Android SDK (cla: yes, tool)


[63924](https://github.com/flutter/flutter/pull/63924) Remove TODOs added for HTTP abort() change in dart sdk (a: tests, cla: yes, framework, tool)


[63972](https://github.com/flutter/flutter/pull/63972) Revert "Remove TODOs added for HTTP abort() change in dart sdk" (a: tests, cla: yes, framework, tool)


[63976](https://github.com/flutter/flutter/pull/63976) [flutter_tools] trim trailing newline from vm service logging events (cla: yes, tool, waiting for tree to go green)


[64020](https://github.com/flutter/flutter/pull/64020) [flutter_tool] Fix amberctl host address (cla: yes, d: examples, team, tool, waiting for tree to go green)


[64021](https://github.com/flutter/flutter/pull/64021) Use real flutter root for finding pub in command integration test (a: tests, cla: yes, tool)


[64050](https://github.com/flutter/flutter/pull/64050) 1.21.0-9.1.pre cherrypicks (cla: yes, engine, f: material design, framework, team, tool)


[64065](https://github.com/flutter/flutter/pull/64065) [flutter_tools] add more info to coverage script (cla: yes, tool, waiting for tree to go green)


[64160](https://github.com/flutter/flutter/pull/64160) [null-safety] roll to null-safe platform (cla: yes, team, tool)


[64166](https://github.com/flutter/flutter/pull/64166) Add WindowProc delegation to Windows template (cla: yes, tool)


[64173](https://github.com/flutter/flutter/pull/64173) Update Windows template for wrapper file change (cla: yes, tool)


[64181](https://github.com/flutter/flutter/pull/64181) Move v1 embedding migration warning from plugin consumers to all apps (cla: yes, tool)


[64186](https://github.com/flutter/flutter/pull/64186) [flutter_tools] null assertions off by default for web (cla: yes, team, tool)


[64195](https://github.com/flutter/flutter/pull/64195) [flutter_tools] update dwds, roll to null-safe file and process (cla: yes, team, tool, waiting for tree to go green)


[64201](https://github.com/flutter/flutter/pull/64201) [flutter_tools] migrate flutter_goldens, flutter_goldens client to null-safety (cla: yes, team, tool, waiting for tree to go green)


[64203](https://github.com/flutter/flutter/pull/64203) Don't fail docs-linux on release branches (cla: yes, team, tool, waiting for tree to go green)


[64251](https://github.com/flutter/flutter/pull/64251) add different workload & add -products * to vswhere calls to check both Visual Studio IDE and standalone Build Tools. (cla: yes, tool, waiting for tree to go green)


[64403](https://github.com/flutter/flutter/pull/64403) [flutter_tools] flutter run should allow exit when make choose for devices. (cla: yes, tool, waiting for tree to go green)


[64440](https://github.com/flutter/flutter/pull/64440) Pass --verbose-logging to flutter_tester (cla: yes, tool)


[64498](https://github.com/flutter/flutter/pull/64498) Reland: Increase threshold for usage of compute for utf8 decoding on large strings to 50 KB (cla: yes, framework, tool, waiting for tree to go green)


[64504](https://github.com/flutter/flutter/pull/64504) Change iOS plugin simulator archs from allow list to deny list (cla: yes, team, tool)


[64512](https://github.com/flutter/flutter/pull/64512) [flutter_tools] refactor artifact downloading to retry zip exceptions. (cla: yes, tool, waiting for tree to go green)


[64517](https://github.com/flutter/flutter/pull/64517) Revert "Pass --verbose-logging to flutter_tester" (cla: yes, tool)


[64521](https://github.com/flutter/flutter/pull/64521) [windows] Update plugin template (cla: yes, tool)


[64524](https://github.com/flutter/flutter/pull/64524) [flutter_tools] avoid creating Android Devices if AndroidSDK cannot be found (cla: yes, tool)


[64559](https://github.com/flutter/flutter/pull/64559) [flutter_tools] handle FileSystemException thrown when attempting to decode stamp file (cla: yes, tool, waiting for tree to go green)


[64578](https://github.com/flutter/flutter/pull/64578) [flutter_tools] add analytics to code size, add more testing (cla: yes, tool)


[64587](https://github.com/flutter/flutter/pull/64587) [flutter_tools] allow disabling pwa from build command, fix run release build caching (cla: yes, tool)


[64592](https://github.com/flutter/flutter/pull/64592) Fix typo in flutter_tools --analyze-size output. (cla: yes, tool, waiting for tree to go green)


[64602](https://github.com/flutter/flutter/pull/64602) Revert "[flutter_tools] avoid creating Android Devices if AndroidSDK cannot be found" (cla: yes, tool)


[64652](https://github.com/flutter/flutter/pull/64652) Revert "Reland: Increase threshold for usage of compute for utf8 decoding on large strings to 50 KB" (cla: yes, framework, tool)


[64665](https://github.com/flutter/flutter/pull/64665) [flutter_tools] reland: avoid creating Android Devices if AndroidSDK cannot be found (cla: yes, tool)


[64671](https://github.com/flutter/flutter/pull/64671) Re-enable the Dart Development Service (DDS) (cla: yes, tool)


[64674](https://github.com/flutter/flutter/pull/64674) Avoid thinning frameworks in iOS extensions (cla: yes, platform-ios, team, tool, waiting for tree to go green)


[64737](https://github.com/flutter/flutter/pull/64737) Flutter Framework Beta 1.21.0-9.2.pre cherry picks (a: internationalization, cla: yes, engine, f: material design, framework, tool)


[64745](https://github.com/flutter/flutter/pull/64745) [flutter_tools] rethrow process exceptions as tool exit from gradle build (cla: yes, tool, waiting for customer response)


[64749](https://github.com/flutter/flutter/pull/64749) [flutter_tools] handle OsError thrown during azure detector (cla: yes, tool, waiting for tree to go green)


[64773](https://github.com/flutter/flutter/pull/64773) [flutter_tools] exit script if powershell version detection fails (cla: yes, tool, waiting for tree to go green)


[64797](https://github.com/flutter/flutter/pull/64797) Revert "Re-enable the Dart Development Service (DDS)" (cla: yes, tool)


[64802](https://github.com/flutter/flutter/pull/64802) Reland "Re-enable the Dart Development Service (DDS) (#64671)" (cla: yes, tool, waiting for tree to go green)


[64814](https://github.com/flutter/flutter/pull/64814) [flutter_tools] split project parsing/validation into separate function (cla: yes, tool)


[64829](https://github.com/flutter/flutter/pull/64829) Revert "Avoid thinning frameworks in iOS extensions" (cla: yes, team, tool)


[64834](https://github.com/flutter/flutter/pull/64834) Add --device-timeout flag to device-related commands (cla: yes, platform-ios, tool, waiting for tree to go green)


[64845](https://github.com/flutter/flutter/pull/64845) Revert "Reland "Re-enable the Dart Development Service (DDS) (#64671)"" (cla: yes, tool)


[64847](https://github.com/flutter/flutter/pull/64847) Reland "Re-enable the Dart Development Service (DDS) (#64671)" (cla: yes, tool)


[64848](https://github.com/flutter/flutter/pull/64848) [flutter_tools] add --config-only option to flutter build ios (cla: yes, tool, waiting for tree to go green)


[64878](https://github.com/flutter/flutter/pull/64878) [flutter_tools] tool exit after repeated network failure (cla: yes, tool)


[64970](https://github.com/flutter/flutter/pull/64970) [flutter_tools] remove unused zip verification (cla: yes, tool, waiting for tree to go green)


[64976](https://github.com/flutter/flutter/pull/64976) [flutter_tools] adjust index.html caching and insert cache busting URL in to main.dart.js/sw request (cla: yes, tool)


[64980](https://github.com/flutter/flutter/pull/64980) [flutter_tools] standardize patterns for integration.shard (cla: yes, tool)


[64981](https://github.com/flutter/flutter/pull/64981) Revert "Reland "Re-enable the Dart Development Service (DDS) (#64671)"" (cla: yes, tool)


[64983](https://github.com/flutter/flutter/pull/64983) Share build command flag configuration on desktop (cla: yes, tool)


[64984](https://github.com/flutter/flutter/pull/64984) Flutter stable framework 1.20.3 cherrypicks (a: internationalization, cla: yes, d: examples, engine, f: material design, framework, team, tool)


[64988](https://github.com/flutter/flutter/pull/64988) Add observatory Bonjour service to built iOS Info.plist bundle (cla: yes, platform-ios, t: xcode, team, tool)


[64992](https://github.com/flutter/flutter/pull/64992) Put the unbundled Linux executable in a subdirectory (cla: yes, tool)


[65025](https://github.com/flutter/flutter/pull/65025) Move gen_l10n into flutter_tools (a: internationalization, cla: yes, team, tool)


[65109](https://github.com/flutter/flutter/pull/65109) Revert "Add observatory Bonjour service to built iOS Info.plist bundle" (cla: yes, team, tool)


[65112](https://github.com/flutter/flutter/pull/65112) [flutter_tools] exit with helpful message if where is missing on windows (cla: yes, tool, waiting for tree to go green)


[65114](https://github.com/flutter/flutter/pull/65114) [flutter_tools] fix screenshot command in release mode and help documentation (cla: yes, tool, waiting for tree to go green)


[65124](https://github.com/flutter/flutter/pull/65124) Require xcode_backend.sh arguments (introduced in Flutter v0.0.7) (cla: yes, platform-ios, t: xcode, team, tool, waiting for tree to go green)


[65125](https://github.com/flutter/flutter/pull/65125) [flutter_tools] add EACCES to list of immediate exit tool conditions (cla: yes, tool)


[65138](https://github.com/flutter/flutter/pull/65138) Add observatory Bonjour service to built iOS Info.plist bundle (cla: yes, platform-ios, t: xcode, team, tool)


[65141](https://github.com/flutter/flutter/pull/65141) Revert "Add observatory Bonjour service to built iOS Info.plist bundle" (cla: yes, team, tool)


[65142](https://github.com/flutter/flutter/pull/65142) Add observatory Bonjour service to built iOS Info.plist bundle (cla: yes, team, tool)


[65184](https://github.com/flutter/flutter/pull/65184) [flutter_tools] prevent creation of android devices if adb is not located (cla: yes, tool, waiting for tree to go green)


[65202](https://github.com/flutter/flutter/pull/65202) Revert "[flutter_tools] split project parsing/validation into separate function" (cla: yes, tool)


[65234](https://github.com/flutter/flutter/pull/65234) Update create templates to 1.0.0 (cla: yes, tool)


[65426](https://github.com/flutter/flutter/pull/65426) [flutter_tools] remove advice about running sdkmanager directly in favor of directing to flutter.dev (cla: yes, tool, waiting for tree to go green)


[65435](https://github.com/flutter/flutter/pull/65435) [flutter_tools] alternate the name of the dill file used for hot restart (cla: yes, tool)


[65490](https://github.com/flutter/flutter/pull/65490) [flutter_tools] remove globals from tracing and add unit tests (cla: yes, tool, waiting for tree to go green)


[65493](https://github.com/flutter/flutter/pull/65493) Always use POSIX paths for generated CMake files (cla: yes, tool)


[65511](https://github.com/flutter/flutter/pull/65511) Update Windows app template (cla: yes, tool, waiting for tree to go green)


[65571](https://github.com/flutter/flutter/pull/65571) Roll forward package:test to 1.16.0-nullsafety.4 to prepare for package:vm_service 5.0.0+1 (cla: yes, team, tool, waiting for tree to go green)


### f: material design - 152 pull request(s)

[56413](https://github.com/flutter/flutter/pull/56413) Prevent viewport.showOnScreen from scrolling the viewport if the specified Rect is already visible.  (cla: yes, f: material design, f: scrolling, framework, severe: API break, waiting for tree to go green)


[58245](https://github.com/flutter/flutter/pull/58245) Automatically scale down Dialog padding for larger text scale factors (cla: yes, f: material design, framework, waiting for tree to go green)


[59127](https://github.com/flutter/flutter/pull/59127) [Text Scaling][Material] Update BottomNavigationBar to show tooltips on long press. (cla: yes, f: cupertino, f: material design, framework, team)


[59702](https://github.com/flutter/flutter/pull/59702) New Button Universe (cla: yes, f: material design, framework, waiting for tree to go green)


[59766](https://github.com/flutter/flutter/pull/59766) FormField should autovalidate only if its content was changed (fixed) (a: text input, cla: yes, f: material design, framework, waiting for tree to go green)


[60177](https://github.com/flutter/flutter/pull/60177) Don't move to word edge when tapping with a mouse (a: mouse, a: text input, cla: yes, f: material design, framework, waiting for tree to go green)


[60299](https://github.com/flutter/flutter/pull/60299) Implement Router widget and widgets app api (cla: yes, f: cupertino, f: material design, framework, waiting for tree to go green)


[60337](https://github.com/flutter/flutter/pull/60337) Add ThemeData.shadowColor (cla: yes, f: material design, framework, waiting for tree to go green)


[60446](https://github.com/flutter/flutter/pull/60446) Remove unused optional parameters of private functions. (a: tests, cla: yes, f: material design, framework, team, waiting for tree to go green)


[60479](https://github.com/flutter/flutter/pull/60479) Fix tooltip position using correct overlay to calculate render box position. (a: layout, cla: yes, f: material design, framework, waiting for tree to go green)


[60640](https://github.com/flutter/flutter/pull/60640) expose route settings for showModalBottomSheet (cla: yes, f: material design, f: routes, framework, waiting for tree to go green)


[60655](https://github.com/flutter/flutter/pull/60655) clean up hero controller scope (cla: yes, f: cupertino, f: material design, framework, waiting for tree to go green)


[60940](https://github.com/flutter/flutter/pull/60940) Skip Audit - Last Leftovers (a: quality, a: tests, cla: yes, f: cupertino, f: material design, framework, team, waiting for tree to go green)


[61048](https://github.com/flutter/flutter/pull/61048) Re-land "Tweaking Material Chip a11y semantics to match buttons (#60141)" (a: accessibility, cla: yes, customer: money (g3), f: material design, framework, waiting for tree to go green)


[61071](https://github.com/flutter/flutter/pull/61071) [Api docs] Updates ListTile.subtitle docs to address how TextStyle is decided (cla: yes, d: api docs, f: material design, framework, waiting for tree to go green)


[61086](https://github.com/flutter/flutter/pull/61086) Added the materialTapTargetSize to the OutlineButton Constructor (cla: yes, f: material design, framework, waiting for tree to go green)


[61123](https://github.com/flutter/flutter/pull/61123) This fixes an error in the form field example (cla: yes, d: api docs, f: material design, framework, waiting for tree to go green)


[61171](https://github.com/flutter/flutter/pull/61171) Fix FloatingActionButtonLocation for additional test case (a: quality, f: material design, framework, waiting for tree to go green)


[61180](https://github.com/flutter/flutter/pull/61180) [Material] Allow for customizing Snack bar margin, padding, and width (cla: yes, f: material design, framework, waiting for tree to go green)


[61216](https://github.com/flutter/flutter/pull/61216) InkDecoration do not paint if it's part of the tree doesn't get painted (cla: yes, f: material design, framework, waiting for tree to go green)


[61258](https://github.com/flutter/flutter/pull/61258) Adds semantics information for the popup menu item (cla: yes, f: material design, framework, waiting for tree to go green)


[61262](https://github.com/flutter/flutter/pull/61262) Renamed ContainedButton et al. to ElevatedButton et al. (cla: yes, f: material design, framework, waiting for tree to go green)


[61347](https://github.com/flutter/flutter/pull/61347) [ListTile] adds new properties to customize the tile color (cla: yes, f: material design, framework, severe: new feature, waiting for tree to go green)


[61356](https://github.com/flutter/flutter/pull/61356) Updated dataTable API doc to explicitly point sorting (cla: yes, f: material design, framework, waiting for tree to go green)


[61368](https://github.com/flutter/flutter/pull/61368) Add widget of the week videos to documentation (cla: yes, f: cupertino, f: material design, framework, waiting for tree to go green)


[61371](https://github.com/flutter/flutter/pull/61371) Make ThemeData.shadowColor the default shadowColor in TextButton et al. (cla: yes, f: material design, framework, waiting for tree to go green)


[61377](https://github.com/flutter/flutter/pull/61377) Revert "Adds semantics information for the popup menu item (#61258)" (cla: yes, f: material design, framework)


[61385](https://github.com/flutter/flutter/pull/61385) reland "Adds semantics information for the popup menu item (#61258)" (a: accessibility, cla: yes, f: material design, framework, team, waiting for tree to go green)


[61392](https://github.com/flutter/flutter/pull/61392) Update Card example and shadowColor default (cla: yes, f: material design, framework, waiting for tree to go green)


[61394](https://github.com/flutter/flutter/pull/61394) Update the Scaffold examples; use the new button classes (cla: yes, f: material design, framework)


[61398](https://github.com/flutter/flutter/pull/61398) Prevent material switch from recreating its render object when it becomes disabled (cla: yes, f: material design, framework, waiting for tree to go green)


[61401](https://github.com/flutter/flutter/pull/61401) Make scrollbar thickness and radius customizable (cla: yes, f: cupertino, f: material design, framework)


[61424](https://github.com/flutter/flutter/pull/61424) Update documentation (cla: yes, f: material design, framework)


[61439](https://github.com/flutter/flutter/pull/61439) Add per thumb Range Slider semantics (cla: yes, f: material design, framework, waiting for tree to go green)


[61479](https://github.com/flutter/flutter/pull/61479) Update MaterialState API docs (cla: yes, f: material design, framework, waiting for tree to go green)


[61489](https://github.com/flutter/flutter/pull/61489) Updated date pickers to use the new TextButton in place of FlatButton. (cla: yes, f: material design, framework, waiting for tree to go green)


[61492](https://github.com/flutter/flutter/pull/61492) Updated time pickers to use the new TextButton in place of FlatButton. (cla: yes, f: material design, framework)


[61532](https://github.com/flutter/flutter/pull/61532) [ListTileTheme] adds properties to customize tile color at theme level (cla: yes, f: material design, framework, waiting for tree to go green)


[61576](https://github.com/flutter/flutter/pull/61576) Corrected splash color for TextButton, ElevatedButton, OutlinedButton (cla: yes, f: material design, framework, waiting for tree to go green)


[61578](https://github.com/flutter/flutter/pull/61578) Updated obsolete button references in Scaffold, IconButton (cla: yes, f: material design, framework)


[61623](https://github.com/flutter/flutter/pull/61623) Fix overflow issue caused by a long title/subtitle for the vertical stepper (cla: yes, f: material design, framework, waiting for tree to go green)


[61648](https://github.com/flutter/flutter/pull/61648) Proposal: deprecate autovalidate parameter of the Form, FormField and TextFormField widget (cla: yes, f: material design, framework, waiting for tree to go green)


[61662](https://github.com/flutter/flutter/pull/61662) add static method to create material hero controller (cla: yes, f: material design, framework, waiting for tree to go green)


[61664](https://github.com/flutter/flutter/pull/61664) Add minWidth and height parameter into FlatButton widget (cla: yes, f: material design, framework, waiting for tree to go green)


[61710](https://github.com/flutter/flutter/pull/61710) Added expandedHeight in flexibleSpace and flexibleSpaceBar (cla: yes, d: api docs, documentation, f: material design, framework, waiting for tree to go green)


[61714](https://github.com/flutter/flutter/pull/61714) Implement customizable cursor height (cla: yes, f: cupertino, f: material design, framework, waiting for tree to go green)


[61778](https://github.com/flutter/flutter/pull/61778) [Material] Updated icons and fonts (cla: yes, f: material design, framework, team, tool, waiting for tree to go green)


[61963](https://github.com/flutter/flutter/pull/61963) Revert "InkDecoration do not paint if it's part of the tree doesn't g… (cla: yes, f: material design, framework)


[62014](https://github.com/flutter/flutter/pull/62014) TextSelectionTheme support (step 1 of 3) (cla: yes, f: material design, framework)


[62052](https://github.com/flutter/flutter/pull/62052) Update the FlutterLogo colors and gradients (cla: yes, f: cupertino, f: material design, framework, team, waiting for tree to go green)


[62062](https://github.com/flutter/flutter/pull/62062) makes PopupMenuitem merge the semantics of its child (cla: yes, f: material design, framework, waiting for tree to go green)


[62071](https://github.com/flutter/flutter/pull/62071) Make it an error to break doc macros (and fix existing broken macros) (cla: yes, f: material design, framework, waiting for tree to go green)


[62072](https://github.com/flutter/flutter/pull/62072) SelectableText handles after Select All (cla: yes, f: material design, framework, waiting for tree to go green)


[62075](https://github.com/flutter/flutter/pull/62075) Update the About dialog to use the new button API. (cla: yes, f: material design, framework, waiting for tree to go green)


[62092](https://github.com/flutter/flutter/pull/62092) Updated Material library documentation references to the old button classes. (cla: yes, f: material design, framework, waiting for tree to go green)


[62099](https://github.com/flutter/flutter/pull/62099) Updated references to the old button classes to the new classes in widgets, services, and rendering packages (cla: yes, d: api docs, d: examples, documentation, f: material design, framework, waiting for tree to go green)


[62164](https://github.com/flutter/flutter/pull/62164) Updated material and cupertino tests to use the new button classes (cla: yes, f: cupertino, f: material design, framework, waiting for tree to go green)


[62167](https://github.com/flutter/flutter/pull/62167) Ban unresolved dartdoc directives from HTML output (cla: yes, f: material design, framework, team, waiting for tree to go green)


[62195](https://github.com/flutter/flutter/pull/62195) [Material] Ensure banner reads banner theme's leading padding property (cla: yes, f: material design, framework, waiting for tree to go green)


[62220](https://github.com/flutter/flutter/pull/62220) Updated the framework tests to use the new button API. (a: accessibility, a: tests, cla: yes, f: material design, framework, waiting for tree to go green)


[62317](https://github.com/flutter/flutter/pull/62317) Fix some broken doc references (cla: yes, f: cupertino, f: material design, framework)


[62337](https://github.com/flutter/flutter/pull/62337) [Material] Add support for high contrast theming to Material apps (cla: yes, f: material design, framework, waiting for tree to go green)


[62338](https://github.com/flutter/flutter/pull/62338) Replace mistaken dartdoc [Foo..bar] references with [Foo.bar] (cla: yes, f: material design, framework, waiting for tree to go green)


[62367](https://github.com/flutter/flutter/pull/62367) Make dartdoc warnings fatal (& cleanup of warnings) (a: accessibility, a: internationalization, a: tests, cla: yes, f: cupertino, f: material design, framework, team, waiting for tree to go green)


[62421](https://github.com/flutter/flutter/pull/62421) Export Material curves in the Material lib (cla: yes, f: material design, framework)


[62431](https://github.com/flutter/flutter/pull/62431) Revert "Export Material curves in the Material lib" (cla: yes, f: material design, framework)


[62435](https://github.com/flutter/flutter/pull/62435) Reland "Export Material curves in the Material lib" (cla: yes, f: material design, framework, waiting for tree to go green)


[62473](https://github.com/flutter/flutter/pull/62473) Fix 'unresolved doc reference' for material A-D (cla: yes, f: cupertino, f: material design, framework, waiting for tree to go green)


[62509](https://github.com/flutter/flutter/pull/62509) Fix more unresolved doc references in material (cla: yes, f: material design, framework, waiting for tree to go green)


[62520](https://github.com/flutter/flutter/pull/62520) Fix even more unresolved doc references in material (cla: yes, d: api docs, documentation, f: material design, framework, team, waiting for tree to go green)


[62582](https://github.com/flutter/flutter/pull/62582) Random unresolved doc reference fixes I missed before (a: internationalization, a: tests, cla: yes, f: material design, framework, waiting for tree to go green)


[62601](https://github.com/flutter/flutter/pull/62601) Use OverflowBar instead of ButtonBar in TimePicker (cla: yes, f: material design, framework)


[62635](https://github.com/flutter/flutter/pull/62635) Fixes physics not working when StepperType.horizontal is selected (cla: yes, f: material design, framework, waiting for tree to go green)


[62668](https://github.com/flutter/flutter/pull/62668) Ensure dark theme is used when high contrast dark theme isn't provided (a: accessibility, cla: yes, f: material design, framework, waiting for tree to go green)


[62686](https://github.com/flutter/flutter/pull/62686) Use OverflowBar instead of ButtonBar in DatePicker (cla: yes, f: material design, framework)


[62690](https://github.com/flutter/flutter/pull/62690) Fix the flexible space bar to still create a rendering object even if… (cla: yes, f: material design, framework, waiting for tree to go green)


[62695](https://github.com/flutter/flutter/pull/62695) Use OverflowBar instead of ButtonBar in DateRangePicker (cla: yes, f: material design, framework, waiting for tree to go green)


[62703](https://github.com/flutter/flutter/pull/62703) Use OverflowBar instead of ButtonBar in MaterialBanner (cla: yes, f: material design, framework)


[62707](https://github.com/flutter/flutter/pull/62707) Fix text escaping in the AboutListTile sample code (cla: yes, f: material design, framework, waiting for tree to go green)


[62712](https://github.com/flutter/flutter/pull/62712) Add onAppPrivateCommand to TextField (cla: yes, f: material design, framework, waiting for tree to go green)


[62755](https://github.com/flutter/flutter/pull/62755) Add punctuation for unterminated sentences in doc comments (a: accessibility, a: internationalization, a: tests, cla: yes, d: api docs, documentation, f: cupertino, f: material design, framework, tool)


[62761](https://github.com/flutter/flutter/pull/62761) Fix lifecycle clean up in the material date picker tests for screen size and semantics. (a: internationalization, cla: yes, f: material design, framework, waiting for tree to go green)


[62795](https://github.com/flutter/flutter/pull/62795) Fix sort indicator for DataTables (cla: yes, f: material design, framework)


[62803](https://github.com/flutter/flutter/pull/62803) Address misc time picker design issues (a: internationalization, cla: yes, f: material design, framework, waiting for tree to go green)


[62805](https://github.com/flutter/flutter/pull/62805) Add “See also” links to favorite class API docs (cla: yes, d: api docs, documentation, f: material design, framework, waiting for tree to go green)


[62840](https://github.com/flutter/flutter/pull/62840) [ExpansionPanelList] adds elevation property (f: material design, framework, waiting for tree to go green, will affect goldens)


[62913](https://github.com/flutter/flutter/pull/62913) Enable InkWell to sync its hovered state when its enabled or disabled (f: material design, framework)


[62936](https://github.com/flutter/flutter/pull/62936) [null-safety] remove more usage of mockito from the framework tests (f: material design, framework, waiting for tree to go green)


[63012](https://github.com/flutter/flutter/pull/63012) Remove old button references from the Stepper widget (f: material design, framework)


[63026](https://github.com/flutter/flutter/pull/63026) Update to the latest localizations - Adds missing DatePicker strings and fixes manually entering date for German (a: internationalization, f: cupertino, f: material design, framework, waiting for tree to go green)


[63034](https://github.com/flutter/flutter/pull/63034) Remove Special Handling of Norwegian Locales (a: internationalization, f: cupertino, f: material design, framework, team)


[63040](https://github.com/flutter/flutter/pull/63040) Updated flutter_localizations picker tests to use new button classes. (a: internationalization, f: material design)


[63094](https://github.com/flutter/flutter/pull/63094) Fixed a typo in the DataRow API doc (f: material design, framework, waiting for tree to go green)


[63142](https://github.com/flutter/flutter/pull/63142) Fix a crash when disposing tabs (f: material design, framework, waiting for tree to go green)


[63249](https://github.com/flutter/flutter/pull/63249) Fix title color of license detail page (cla: yes, f: material design, framework, waiting for tree to go green)


[63396](https://github.com/flutter/flutter/pull/63396) Fixed an ElevatedButton API doc typo (f: material design, framework)


[63400](https://github.com/flutter/flutter/pull/63400) Updated old button references in dev/integration_tests/flutter_gallery … cards_demo (f: material design, team)


[63401](https://github.com/flutter/flutter/pull/63401) Make textfields restorable (cla: yes, f: cupertino, f: material design, framework)


[63402](https://github.com/flutter/flutter/pull/63402) Updated old button references in dev/integration_tests/flutter_gallery … banner_demo (f: material design, team)


[63404](https://github.com/flutter/flutter/pull/63404) Updated old button references in dev/integration_tests/flutter_gallery … drawer_demo (f: material design, team)


[63430](https://github.com/flutter/flutter/pull/63430) Updated old button references in dev/integration_tests/flutter_gallery leave_behind_demo (f: material design, team)


[63461](https://github.com/flutter/flutter/pull/63461) Removed the inputFormatters from the text input fields used by the Date Pickers (f: material design, framework, waiting for tree to go green)


[63491](https://github.com/flutter/flutter/pull/63491) Updated old button references in dev/integration_tests/flutter_gallery ... full_screen_dialog_demo (f: material design, team)


[63591](https://github.com/flutter/flutter/pull/63591) 1.20.2 Cherrypicks (a: internationalization, cla: yes, engine, f: material design, framework, team, tool, work in progress; do not review)


[63599](https://github.com/flutter/flutter/pull/63599) Ensure time picker input mode lays out correctly in RTL (a: internationalization, cla: yes, f: material design, framework, waiting for tree to go green)


[63692](https://github.com/flutter/flutter/pull/63692) "Draw" vs "drawer" typo (cla: yes, d: api docs, documentation, f: material design, framework, waiting for tree to go green)


[63776](https://github.com/flutter/flutter/pull/63776) Mention time picker theme in showTimePicker documentation (cla: yes, documentation, f: material design, framework, waiting for tree to go green)


[63925](https://github.com/flutter/flutter/pull/63925) Fix bug when tapping ListTitle with CheckboxListTile  tristate enable (cla: yes, f: cupertino, f: material design, framework)


[63981](https://github.com/flutter/flutter/pull/63981) Fixed the docs of the focusColor property included in input_decorator (cla: yes, d: api docs, documentation, f: material design, framework, waiting for tree to go green)


[63994](https://github.com/flutter/flutter/pull/63994) SelectableText long press on iOS (cla: yes, f: material design, framework, waiting for tree to go green)


[64050](https://github.com/flutter/flutter/pull/64050) 1.21.0-9.1.pre cherrypicks (cla: yes, engine, f: material design, framework, team, tool)


[64062](https://github.com/flutter/flutter/pull/64062) Revert "Prevent material switch from recreating its render object when it becomes disabled" (cla: yes, f: material design, framework, waiting for tree to go green)


[64091](https://github.com/flutter/flutter/pull/64091) Revert "Prevent viewport.showOnScreen from scrolling the viewport if the specified Rect is already visible. " (cla: yes, f: material design, framework)


[64094](https://github.com/flutter/flutter/pull/64094) Revert "Ensure time picker input mode lays out correctly in RTL" (a: internationalization, cla: yes, f: material design, framework)


[64097](https://github.com/flutter/flutter/pull/64097) [Material] Relanding fix to ensure time picker input mode lays out correctly in RTL (a: internationalization, cla: yes, f: material design, framework)


[64101](https://github.com/flutter/flutter/pull/64101) ScaffoldMessenger (a: quality, cla: yes, customer: money (g3), f: material design, framework, severe: API break, severe: new feature, team, waiting for tree to go green)


[64115](https://github.com/flutter/flutter/pull/64115) Changes to initialDate for CalendarDatePicker should update the state. (cla: yes, f: material design, framework, waiting for tree to go green)


[64167](https://github.com/flutter/flutter/pull/64167) Remove unused copyWith arguments in TimePickerThemeData (cla: yes, f: material design, framework, waiting for tree to go green)


[64189](https://github.com/flutter/flutter/pull/64189) (insert|move|remove)ChildRenderObject Deprecation: Step 1 (cla: yes, f: cupertino, f: material design, framework)


[64217](https://github.com/flutter/flutter/pull/64217) (insert|move|remove)ChildRenderObject Deprecation: Step 2 (cla: yes, f: cupertino, f: material design, framework)


[64227](https://github.com/flutter/flutter/pull/64227) Add null safety migration annotations. (cla: yes, f: material design, framework, waiting for tree to go green)


[64235](https://github.com/flutter/flutter/pull/64235) fix: typo fixed from ENTER to SPACE (cla: yes, d: api docs, f: material design, framework, waiting for tree to go green)


[64249](https://github.com/flutter/flutter/pull/64249) Revert "(insert|move|remove)ChildRenderObject Deprecation: Step 1" (cla: yes, f: cupertino, f: material design, framework)


[64254](https://github.com/flutter/flutter/pull/64254) Re-apply "(insert|move|remove)ChildRenderObject Deprecation: Step 1" (cla: yes, f: cupertino, f: material design, framework)


[64268](https://github.com/flutter/flutter/pull/64268) Fix placement for SnackBarBehavior.floating (a: quality, cla: yes, f: material design, framework, severe: regression, waiting for tree to go green)


[64273](https://github.com/flutter/flutter/pull/64273) Remove remaining uses of `childToSlot` (cla: yes, f: cupertino, f: material design, framework)


[64316](https://github.com/flutter/flutter/pull/64316) Add DataTableTheme to allow for themable DataTables (cla: yes, f: material design, framework, waiting for tree to go green)


[64354](https://github.com/flutter/flutter/pull/64354) Reland "Prevent material switch from recreating its render object when it becomes disabled (#61398)" (cla: yes, f: material design, framework)


[64380](https://github.com/flutter/flutter/pull/64380) Fix TabBar jag when user interrupts ballistic scroll (cla: yes, f: material design, framework, waiting for tree to go green)


[64472](https://github.com/flutter/flutter/pull/64472) Update origin material button API doc with obsolete API warnings (cla: yes, f: material design, framework)


[64483](https://github.com/flutter/flutter/pull/64483) Removed deprecated ContainedButton and ContainedButtonTheme classes (cla: yes, f: material design, framework)


[64513](https://github.com/flutter/flutter/pull/64513) Reland "Prevent viewport.showOnScreen from scrolling the viewport if the specified Rect is already visible.  (#56413)", reverted in #64091 (cla: yes, f: material design, f: scrolling, framework, waiting for tree to go green)


[64534](https://github.com/flutter/flutter/pull/64534) Slider paint incorrectly when the track shape is rectangular (cla: yes, f: material design, framework, waiting for tree to go green)


[64627](https://github.com/flutter/flutter/pull/64627) Slider and RangeSlider can be painted in a narrower constraint like other Material Wi… (cla: yes, f: material design, framework, waiting for tree to go green)


[64715](https://github.com/flutter/flutter/pull/64715) Clamp TabController animation value when calc _DragAnimation.value (a: animation, cla: yes, f: material design, framework, waiting for tree to go green)


[64737](https://github.com/flutter/flutter/pull/64737) Flutter Framework Beta 1.21.0-9.2.pre cherry picks (a: internationalization, cla: yes, engine, f: material design, framework, tool)


[64840](https://github.com/flutter/flutter/pull/64840) Make Container always clip a decoration if it has a clip edge (cla: yes, f: cupertino, f: material design, framework)


[64855](https://github.com/flutter/flutter/pull/64855) Fixes issue, ReorderableListView destroys children even if their key-type wasn't changed (cla: yes, f: material design, framework, waiting for tree to go green)


[64915](https://github.com/flutter/flutter/pull/64915) Prefer moreOrLessEquals over closeTo (cla: yes, f: cupertino, f: material design, framework)


[64984](https://github.com/flutter/flutter/pull/64984) Flutter stable framework 1.20.3 cherrypicks (a: internationalization, cla: yes, d: examples, engine, f: material design, framework, team, tool)


[65036](https://github.com/flutter/flutter/pull/65036) Update hintColor value for Material (cla: yes, f: material design, framework, waiting for tree to go green, will affect goldens)


[65049](https://github.com/flutter/flutter/pull/65049) Fixed the sliver appbar to have a fixed traversal order (a: accessibility, cla: yes, f: material design, framework, waiting for tree to go green)


[65060](https://github.com/flutter/flutter/pull/65060) Remove redundant import of dart:math (cla: yes, f: material design, framework, waiting for tree to go green)


[65094](https://github.com/flutter/flutter/pull/65094) Fix InputDecoration contentPadding documentation words accent (cla: yes, f: material design, framework, waiting for tree to go green)


[65199](https://github.com/flutter/flutter/pull/65199) Eliminate the need for the mockito package in animated_icons_private_test (cla: yes, f: material design, framework, waiting for tree to go green)


[65250](https://github.com/flutter/flutter/pull/65250) Fixed Tooltip widget docs. (cla: yes, f: material design, framework, waiting for tree to go green)


[65257](https://github.com/flutter/flutter/pull/65257) Revert "ScaffoldMessenger" (cla: yes, f: material design, framework)


[65382](https://github.com/flutter/flutter/pull/65382) Revert "Add DataTableTheme to allow for themable DataTables (#64316)" (cla: yes, f: material design, framework, waiting for tree to go green)


[65383](https://github.com/flutter/flutter/pull/65383) Reland "Add DataTableTheme to allow for themable DataTables (#64316)" (cla: yes, f: material design, framework, waiting for tree to go green)


[65386](https://github.com/flutter/flutter/pull/65386) Flutter 1.22 candidate.10 (cla: yes, engine, f: material design, framework)


[65416](https://github.com/flutter/flutter/pull/65416) Re-land ScaffoldMessenger (cla: yes, f: material design, framework, waiting for tree to go green)


[65482](https://github.com/flutter/flutter/pull/65482) Revert "Re-land ScaffoldMessenger" (cla: yes, f: material design, framework)


### a: tests - 72 pull request(s)

[58640](https://github.com/flutter/flutter/pull/58640) Skip Audit - Rendering Library (a: quality, a: tests, cla: yes, framework, team, waiting for tree to go green)


[60375](https://github.com/flutter/flutter/pull/60375) Restoration Framework (a: tests, cla: yes, framework, waiting for tree to go green)


[60446](https://github.com/flutter/flutter/pull/60446) Remove unused optional parameters of private functions. (a: tests, cla: yes, f: material design, framework, team, waiting for tree to go green)


[60796](https://github.com/flutter/flutter/pull/60796) Add support in WidgetTester for an array of inputs (a: animation, a: tests, cla: yes, f: gestures, framework)


[60940](https://github.com/flutter/flutter/pull/60940) Skip Audit - Last Leftovers (a: quality, a: tests, cla: yes, f: cupertino, f: material design, framework, team, waiting for tree to go green)


[61007](https://github.com/flutter/flutter/pull/61007) Turn on add-to-app iOS platform unit tests (a: existing-apps, a: tests, cla: yes, platform-ios, team)


[61138](https://github.com/flutter/flutter/pull/61138) Fixing patch for coming breaking change in HttpClientRequest (a: tests, cla: yes, framework)


[61185](https://github.com/flutter/flutter/pull/61185) Filter profiling events by names not category (a: tests, cla: yes, framework, severe: performance)


[61266](https://github.com/flutter/flutter/pull/61266) implement handlePointerEventRecord for LiveWidgetController (a: tests, cla: yes, framework, waiting for tree to go green)


[61388](https://github.com/flutter/flutter/pull/61388) benchmarkLive: a new `LiveTestWidgetsFlutterBindingFramePolicy` for benchmark on device (a: tests, cla: yes, framework, team, waiting for tree to go green)


[61406](https://github.com/flutter/flutter/pull/61406) Update the golden image comparator to handle read-only image ByteData views (a: tests, cla: yes, framework, waiting for tree to go green)


[61509](https://github.com/flutter/flutter/pull/61509) Add a E2E based performance test case (a: tests, cla: yes, framework, team, waiting for tree to go green)


[61540](https://github.com/flutter/flutter/pull/61540) Promote WidgetTester.ensureVisible to WidgetController (a: tests, cla: yes, framework)


[61579](https://github.com/flutter/flutter/pull/61579) Remove unused FlutterErrorDetails subclasses (a: debugging, a: error message, a: quality, a: tests, cla: yes, framework, waiting for tree to go green)


[61773](https://github.com/flutter/flutter/pull/61773) Update framePolicy docs (a: tests, cla: yes, d: api docs, documentation, framework, waiting for tree to go green)


[61841](https://github.com/flutter/flutter/pull/61841) Make sure all isolates start during flutter driver tests. (a: tests, cla: yes, framework, waiting for tree to go green)


[61872](https://github.com/flutter/flutter/pull/61872) LiveTestWidgetsFlutterBinding support for non-touch event (a: tests, cla: yes, framework)


[61900](https://github.com/flutter/flutter/pull/61900) Revert "LiveTestWidgetsFlutterBinding support for non-touch event" (a: tests, cla: yes, framework)


[61901](https://github.com/flutter/flutter/pull/61901) Reland "LiveTestWidgetsFlutterBinding support for non-touch event" (a: tests, cla: yes, framework, waiting for tree to go green)


[61998](https://github.com/flutter/flutter/pull/61998) A benchmark test case for measuring scroll smoothness (a: tests, cla: yes, framework, team, waiting for tree to go green)


[62091](https://github.com/flutter/flutter/pull/62091) WidgetController.pump use optional duration (a: tests, cla: yes, framework, waiting for tree to go green)


[62097](https://github.com/flutter/flutter/pull/62097) Add WidgetController.scrollUntilVisible (a: tests, cla: yes, framework, waiting for tree to go green)


[62220](https://github.com/flutter/flutter/pull/62220) Updated the framework tests to use the new button API. (a: accessibility, a: tests, cla: yes, f: material design, framework, waiting for tree to go green)


[62239](https://github.com/flutter/flutter/pull/62239) Revert "Make sure all isolates start during flutter driver tests." (a: tests, cla: yes, framework)


[62362](https://github.com/flutter/flutter/pull/62362) Move key event and semantics related method from WidgetTester to WidgetController (a: tests, cla: yes, framework, waiting for tree to go green)


[62367](https://github.com/flutter/flutter/pull/62367) Make dartdoc warnings fatal (& cleanup of warnings) (a: accessibility, a: internationalization, a: tests, cla: yes, f: cupertino, f: material design, framework, team, waiting for tree to go green)


[62462](https://github.com/flutter/flutter/pull/62462) separate scroll until visible implementation for lower level accessibility  (a: tests, cla: yes, framework, waiting for tree to go green)


[62582](https://github.com/flutter/flutter/pull/62582) Random unresolved doc reference fixes I missed before (a: internationalization, a: tests, cla: yes, f: material design, framework, waiting for tree to go green)


[62630](https://github.com/flutter/flutter/pull/62630) Add integration test for plugins without ios directories (a: tests, cla: yes, platform-ios, team, waiting for tree to go green)


[62640](https://github.com/flutter/flutter/pull/62640) promote WidgetTester pumpAndSettle (a: tests, cla: yes, framework, waiting for tree to go green)


[62755](https://github.com/flutter/flutter/pull/62755) Add punctuation for unterminated sentences in doc comments (a: accessibility, a: internationalization, a: tests, cla: yes, d: api docs, documentation, f: cupertino, f: material design, framework, tool)


[62809](https://github.com/flutter/flutter/pull/62809) [null-safety] remove some usages of mockito (a: tests, cla: yes, framework, waiting for tree to go green)


[62894](https://github.com/flutter/flutter/pull/62894) [null-safety] revert export of Fake from test_api (a: tests, framework, waiting for tree to go green)


[62898](https://github.com/flutter/flutter/pull/62898) Make the Skia expectation parser more resilient and update to "master_str" (a: tests, framework, team, waiting for tree to go green)


[62910](https://github.com/flutter/flutter/pull/62910) Add flutter_goldens_client to testing path (a: tests, team, team: infra, waiting for tree to go green)


[62914](https://github.com/flutter/flutter/pull/62914) revert WidgetTester.pumpAndSettle breaking change (a: tests, framework, waiting for tree to go green)


[62946](https://github.com/flutter/flutter/pull/62946) [null-safety] update to several framework test cases/APIs for null assertions (a: tests, cla: yes, framework, team, tool, waiting for tree to go green)


[63030](https://github.com/flutter/flutter/pull/63030) using named constructor to FrameTiming in scheduler_test.dart (a: tests, engine, framework, waiting for tree to go green)


[63230](https://github.com/flutter/flutter/pull/63230) Updated old button references in packages/flutter_test (a: tests, framework)


[63273](https://github.com/flutter/flutter/pull/63273) Fixing code snippet example for meetsGuideline. (a: tests, d: api docs, documentation, framework, waiting for tree to go green)


[63390](https://github.com/flutter/flutter/pull/63390) update for WidgetTester.move and WidgetTester.fling doc (a: tests, framework, waiting for tree to go green)


[63410](https://github.com/flutter/flutter/pull/63410) WidgetTester.drag with time duration (a: tests, cla: yes, framework, team, waiting for tree to go green)


[63434](https://github.com/flutter/flutter/pull/63434) add FrameTimingSummarizer (a: tests, framework, team, waiting for tree to go green)


[63445](https://github.com/flutter/flutter/pull/63445) Pin iOS module test plugin versions (a: existing-apps, a: tests, platform-ios, team, waiting for tree to go green)


[63523](https://github.com/flutter/flutter/pull/63523) Standardize the nullability of arguments to raw key data constructors. (a: tests, cla: yes, framework, team)


[63595](https://github.com/flutter/flutter/pull/63595) Disables tests failing due to new semantics flag. (a: accessibility, a: tests, cla: yes, framework, waiting for tree to go green)


[63600](https://github.com/flutter/flutter/pull/63600) Typo fix in finders.dart documentation (bySemanticsLabel) (a: tests, cla: yes, d: api docs, framework)


[63639](https://github.com/flutter/flutter/pull/63639) Warns when single line text fields overflow (a: tests, cla: yes, framework, waiting for tree to go green)


[63687](https://github.com/flutter/flutter/pull/63687) Remove decommission from RestorationBuckets (a: tests, cla: yes, framework, waiting for tree to go green)


[63728](https://github.com/flutter/flutter/pull/63728) Provide the argument for a required parameter 'data'. (a: tests, cla: yes, framework, waiting for tree to go green)


[63816](https://github.com/flutter/flutter/pull/63816) bug fix for pointer id in test gestures (a: tests, cla: yes, framework, waiting for tree to go green)


[63817](https://github.com/flutter/flutter/pull/63817) Fix some doc typo (a: tests, cla: yes, framework, waiting for tree to go green)


[63835](https://github.com/flutter/flutter/pull/63835) add vsync overhead to `FrameTimingSummarizer` (a: tests, cla: yes, framework, waiting for tree to go green)


[63924](https://github.com/flutter/flutter/pull/63924) Remove TODOs added for HTTP abort() change in dart sdk (a: tests, cla: yes, framework, tool)


[63972](https://github.com/flutter/flutter/pull/63972) Revert "Remove TODOs added for HTTP abort() change in dart sdk" (a: tests, cla: yes, framework, tool)


[64021](https://github.com/flutter/flutter/pull/64021) Use real flutter root for finding pub in command integration test (a: tests, cla: yes, tool)


[64258](https://github.com/flutter/flutter/pull/64258) update TimelineStream in `flutter_driver` (a: tests, cla: yes, framework, waiting for tree to go green)


[64308](https://github.com/flutter/flutter/pull/64308) Add finders for enableFlutterDriverExtension (a: tests, cla: yes, framework, waiting for tree to go green)


[64432](https://github.com/flutter/flutter/pull/64432) Reland "Make sure all isolates start during flutter driver tests" (a: tests, cla: yes, d: examples, framework, team, waiting for tree to go green)


[64516](https://github.com/flutter/flutter/pull/64516) [web] Fix and enable editable_text_test.dart (a: tests, a: text input, cla: yes, framework, platform-web, team, waiting for tree to go green)


[64570](https://github.com/flutter/flutter/pull/64570) [web] Enable word boundary tests in editable_text_test.dart (a: tests, a: text input, a: typography, cla: yes, framework, platform-web, team, waiting for tree to go green)


[64573](https://github.com/flutter/flutter/pull/64573) Revert "Warns when single line text fields overflow (#63639)" (a: tests, cla: yes, framework)


[64621](https://github.com/flutter/flutter/pull/64621) migrate rendering to nullsafety (a: tests, cla: yes, framework, waiting for tree to go green)


[64757](https://github.com/flutter/flutter/pull/64757) Fix Gold json for digest paramset (a: tests, cla: yes, framework, team, team: infra, waiting for tree to go green)


[64883](https://github.com/flutter/flutter/pull/64883) Revert "A benchmark test case for measuring scroll smoothness" (a: tests, cla: yes, framework, team)


[64885](https://github.com/flutter/flutter/pull/64885) Reland #61998 and update complex_layout ios files (a: tests, cla: yes, framework, team, waiting for tree to go green)


[64982](https://github.com/flutter/flutter/pull/64982) Update Gold for new endpoint (a: tests, cla: yes, framework, team, team: infra, waiting for tree to go green)


[64990](https://github.com/flutter/flutter/pull/64990) Revert "Reland #61998 and update complex_layout ios files" (a: tests, cla: yes, framework, team)


[65051](https://github.com/flutter/flutter/pull/65051) Allow Developers to enable Accessibility testing on WebFlutterDriver and get the underlying webDriver (a: tests, cla: yes, framework, waiting for tree to go green)


[65194](https://github.com/flutter/flutter/pull/65194) Disables test failing due to new semantics flag. (a: tests, cla: yes, framework)


[65273](https://github.com/flutter/flutter/pull/65273) Revert "Add finders for enableFlutterDriverExtension" (a: tests, cla: yes, framework)


[65276](https://github.com/flutter/flutter/pull/65276) Fix the test error of "Add finders for enableFlutterDriverExtension" and resubmit (a: tests, cla: yes, framework, waiting for tree to go green)


### f: cupertino - 35 pull request(s)

[59127](https://github.com/flutter/flutter/pull/59127) [Text Scaling][Material] Update BottomNavigationBar to show tooltips on long press. (cla: yes, f: cupertino, f: material design, framework, team)


[60179](https://github.com/flutter/flutter/pull/60179) Implement new activity indicator for iOS14 (cla: yes, f: cupertino, framework)


[60299](https://github.com/flutter/flutter/pull/60299) Implement Router widget and widgets app api (cla: yes, f: cupertino, f: material design, framework, waiting for tree to go green)


[60655](https://github.com/flutter/flutter/pull/60655) clean up hero controller scope (cla: yes, f: cupertino, f: material design, framework, waiting for tree to go green)


[60940](https://github.com/flutter/flutter/pull/60940) Skip Audit - Last Leftovers (a: quality, a: tests, cla: yes, f: cupertino, f: material design, framework, team, waiting for tree to go green)


[61368](https://github.com/flutter/flutter/pull/61368) Add widget of the week videos to documentation (cla: yes, f: cupertino, f: material design, framework, waiting for tree to go green)


[61401](https://github.com/flutter/flutter/pull/61401) Make scrollbar thickness and radius customizable (cla: yes, f: cupertino, f: material design, framework)


[61714](https://github.com/flutter/flutter/pull/61714) Implement customizable cursor height (cla: yes, f: cupertino, f: material design, framework, waiting for tree to go green)


[62052](https://github.com/flutter/flutter/pull/62052) Update the FlutterLogo colors and gradients (cla: yes, f: cupertino, f: material design, framework, team, waiting for tree to go green)


[62164](https://github.com/flutter/flutter/pull/62164) Updated material and cupertino tests to use the new button classes (cla: yes, f: cupertino, f: material design, framework, waiting for tree to go green)


[62317](https://github.com/flutter/flutter/pull/62317) Fix some broken doc references (cla: yes, f: cupertino, f: material design, framework)


[62367](https://github.com/flutter/flutter/pull/62367) Make dartdoc warnings fatal (& cleanup of warnings) (a: accessibility, a: internationalization, a: tests, cla: yes, f: cupertino, f: material design, framework, team, waiting for tree to go green)


[62473](https://github.com/flutter/flutter/pull/62473) Fix 'unresolved doc reference' for material A-D (cla: yes, f: cupertino, f: material design, framework, waiting for tree to go green)


[62741](https://github.com/flutter/flutter/pull/62741) Deprecate iOS13 style ActivityIndicator (cla: yes, f: cupertino, framework, waiting for tree to go green)


[62755](https://github.com/flutter/flutter/pull/62755) Add punctuation for unterminated sentences in doc comments (a: accessibility, a: internationalization, a: tests, cla: yes, d: api docs, documentation, f: cupertino, f: material design, framework, tool)


[63026](https://github.com/flutter/flutter/pull/63026) Update to the latest localizations - Adds missing DatePicker strings and fixes manually entering date for German (a: internationalization, f: cupertino, f: material design, framework, waiting for tree to go green)


[63034](https://github.com/flutter/flutter/pull/63034) Remove Special Handling of Norwegian Locales (a: internationalization, f: cupertino, f: material design, framework, team)


[63401](https://github.com/flutter/flutter/pull/63401) Make textfields restorable (cla: yes, f: cupertino, f: material design, framework)


[63405](https://github.com/flutter/flutter/pull/63405) Ensure cupertino time picker positions hours and minutes correctly for RTL (a: internationalization, f: cupertino, framework)


[63925](https://github.com/flutter/flutter/pull/63925) Fix bug when tapping ListTitle with CheckboxListTile  tristate enable (cla: yes, f: cupertino, f: material design, framework)


[64189](https://github.com/flutter/flutter/pull/64189) (insert|move|remove)ChildRenderObject Deprecation: Step 1 (cla: yes, f: cupertino, f: material design, framework)


[64217](https://github.com/flutter/flutter/pull/64217) (insert|move|remove)ChildRenderObject Deprecation: Step 2 (cla: yes, f: cupertino, f: material design, framework)


[64249](https://github.com/flutter/flutter/pull/64249) Revert "(insert|move|remove)ChildRenderObject Deprecation: Step 1" (cla: yes, f: cupertino, f: material design, framework)


[64254](https://github.com/flutter/flutter/pull/64254) Re-apply "(insert|move|remove)ChildRenderObject Deprecation: Step 1" (cla: yes, f: cupertino, f: material design, framework)


[64273](https://github.com/flutter/flutter/pull/64273) Remove remaining uses of `childToSlot` (cla: yes, f: cupertino, f: material design, framework)


[64280](https://github.com/flutter/flutter/pull/64280) [null-safety] remove mockito from refresh control test (cla: yes, f: cupertino, framework, waiting for tree to go green)


[64363](https://github.com/flutter/flutter/pull/64363) [null-safety] remove mockito from route test (cla: yes, f: cupertino, framework, waiting for tree to go green)


[64599](https://github.com/flutter/flutter/pull/64599) Fix tests that use bogus objects, update TestImageInfo interface (cla: yes, f: cupertino, framework, waiting for tree to go green)


[64672](https://github.com/flutter/flutter/pull/64672) Nnbd widgets (a: accessibility, cla: yes, f: cupertino, framework, team)


[64840](https://github.com/flutter/flutter/pull/64840) Make Container always clip a decoration if it has a clip edge (cla: yes, f: cupertino, f: material design, framework)


[64908](https://github.com/flutter/flutter/pull/64908) Match lerped values using moreOrLessEquals (cla: yes, f: cupertino, framework)


[64915](https://github.com/flutter/flutter/pull/64915) Prefer moreOrLessEquals over closeTo (cla: yes, f: cupertino, f: material design, framework)


[64979](https://github.com/flutter/flutter/pull/64979) Expand Cupertino library comment (cla: yes, f: cupertino, framework, waiting for tree to go green)


[65083](https://github.com/flutter/flutter/pull/65083) Update CupertinoIcons to cupertino_icons 1.0.0 based on SF Symbols (cla: yes, f: cupertino, framework)


[65488](https://github.com/flutter/flutter/pull/65488) Revert "Nnbd widgets" (a: accessibility, cla: yes, f: cupertino, framework)


### d: api docs - 34 pull request(s)

[61071](https://github.com/flutter/flutter/pull/61071) [Api docs] Updates ListTile.subtitle docs to address how TextStyle is decided (cla: yes, d: api docs, f: material design, framework, waiting for tree to go green)


[61123](https://github.com/flutter/flutter/pull/61123) This fixes an error in the form field example (cla: yes, d: api docs, f: material design, framework, waiting for tree to go green)


[61268](https://github.com/flutter/flutter/pull/61268) Update Table docs for horizontal scrolling (cla: yes, d: api docs, documentation, f: scrolling, framework, waiting for tree to go green)


[61323](https://github.com/flutter/flutter/pull/61323) Updated Row API doc for RTL in textDirection (cla: yes, d: api docs, documentation, framework, waiting for tree to go green)


[61502](https://github.com/flutter/flutter/pull/61502) Update documentation for IntrinsicWidth & IntrinsicHeight (cla: yes, d: api docs, documentation, framework)


[61710](https://github.com/flutter/flutter/pull/61710) Added expandedHeight in flexibleSpace and flexibleSpaceBar (cla: yes, d: api docs, documentation, f: material design, framework, waiting for tree to go green)


[61773](https://github.com/flutter/flutter/pull/61773) Update framePolicy docs (a: tests, cla: yes, d: api docs, documentation, framework, waiting for tree to go green)


[61796](https://github.com/flutter/flutter/pull/61796) Improved docs for minLines in EditableText (a: text input, cla: yes, d: api docs, documentation, framework, waiting for tree to go green)


[61948](https://github.com/flutter/flutter/pull/61948) Add LayoutBuilder example (cla: yes, d: api docs, d: examples, documentation, framework, waiting for tree to go green)


[62083](https://github.com/flutter/flutter/pull/62083) Update the documentation of GlobalKey to explain why it is expensive (cla: yes, d: api docs, documentation, framework, waiting for tree to go green)


[62099](https://github.com/flutter/flutter/pull/62099) Updated references to the old button classes to the new classes in widgets, services, and rendering packages (cla: yes, d: api docs, d: examples, documentation, f: material design, framework, waiting for tree to go green)


[62101](https://github.com/flutter/flutter/pull/62101)  Updated 'CustomClipper.shouldReclip' doc (cla: yes, d: api docs, documentation, framework, waiting for tree to go green)


[62520](https://github.com/flutter/flutter/pull/62520) Fix even more unresolved doc references in material (cla: yes, d: api docs, documentation, f: material design, framework, team, waiting for tree to go green)


[62755](https://github.com/flutter/flutter/pull/62755) Add punctuation for unterminated sentences in doc comments (a: accessibility, a: internationalization, a: tests, cla: yes, d: api docs, documentation, f: cupertino, f: material design, framework, tool)


[62805](https://github.com/flutter/flutter/pull/62805) Add “See also” links to favorite class API docs (cla: yes, d: api docs, documentation, f: material design, framework, waiting for tree to go green)


[62859](https://github.com/flutter/flutter/pull/62859) Add gaplessPlayback docs default discussion (d: api docs, documentation, framework, waiting for tree to go green)


[63132](https://github.com/flutter/flutter/pull/63132) Fix grammar in Route doc comment (d: api docs, documentation, f: routes, framework, waiting for tree to go green)


[63273](https://github.com/flutter/flutter/pull/63273) Fixing code snippet example for meetsGuideline. (a: tests, d: api docs, documentation, framework, waiting for tree to go green)


[63313](https://github.com/flutter/flutter/pull/63313) Small documentation typo fix (d: api docs, documentation, framework, waiting for tree to go green)


[63438](https://github.com/flutter/flutter/pull/63438) More restoration documentation (cla: yes, d: api docs, d: examples, documentation, framework, team, waiting for tree to go green)


[63497](https://github.com/flutter/flutter/pull/63497) Add dispose to restoration example (d: api docs, d: examples, documentation, framework, waiting for tree to go green)


[63503](https://github.com/flutter/flutter/pull/63503) Update: Documentation for ListView constructor should warn about changing widget list (cla: yes, d: api docs, documentation, framework, waiting for tree to go green)


[63600](https://github.com/flutter/flutter/pull/63600) Typo fix in finders.dart documentation (bySemanticsLabel) (a: tests, cla: yes, d: api docs, framework)


[63692](https://github.com/flutter/flutter/pull/63692) "Draw" vs "drawer" typo (cla: yes, d: api docs, documentation, f: material design, framework, waiting for tree to go green)


[63833](https://github.com/flutter/flutter/pull/63833) SizeTransition sample code (a: animation, cla: yes, d: api docs, d: examples, documentation, framework, waiting for tree to go green)


[63884](https://github.com/flutter/flutter/pull/63884) updated_title_property_apidocs (cla: yes, d: api docs, documentation, framework, platform-web, waiting for tree to go green)


[63886](https://github.com/flutter/flutter/pull/63886) Add sample code for ScaleTransition (a: animation, cla: yes, d: api docs, d: examples, documentation, framework, waiting for tree to go green)


[63940](https://github.com/flutter/flutter/pull/63940) Add sample code to RelativePositionedTransition (a: animation, cla: yes, d: api docs, d: examples, documentation, framework, waiting for tree to go green)


[63981](https://github.com/flutter/flutter/pull/63981) Fixed the docs of the focusColor property included in input_decorator (cla: yes, d: api docs, documentation, f: material design, framework, waiting for tree to go green)


[64148](https://github.com/flutter/flutter/pull/64148) Update Visibility docs on maintainSize (cla: yes, d: api docs, documentation, framework, waiting for tree to go green)


[64175](https://github.com/flutter/flutter/pull/64175) feat: Text constructor, overflow, and softWrap docs (cla: yes, d: api docs, documentation, framework, waiting for tree to go green)


[64235](https://github.com/flutter/flutter/pull/64235) fix: typo fixed from ENTER to SPACE (cla: yes, d: api docs, f: material design, framework, waiting for tree to go green)


[64776](https://github.com/flutter/flutter/pull/64776) Fix Android autofill username hint docs (cla: yes, d: api docs, framework, waiting for tree to go green)


[64795](https://github.com/flutter/flutter/pull/64795) Add sample code to RotationTransition (cla: yes, d: api docs, d: examples, documentation, framework, waiting for tree to go green)


### engine - 31 pull request(s)

[61270](https://github.com/flutter/flutter/pull/61270) Update engine hash for 1.20.0-7.1.pre (CQ+1, cla: yes, engine)


[61632](https://github.com/flutter/flutter/pull/61632) 1.20.0-7.2.pre framework cherrypicks (cla: yes, engine, framework, team)


[61800](https://github.com/flutter/flutter/pull/61800) re-Update engine hash for 1.20.0-7.2.pre, including 12847e8 (CQ+1, cla: yes, engine)


[62050](https://github.com/flutter/flutter/pull/62050) Revert "Roll Engine from dcc9a4048da8 to 5a73d4dc2503 (36 revisions)" (cla: yes, engine)


[62150](https://github.com/flutter/flutter/pull/62150) Manual engine roll to 4d720dd9e56ff5d008ed8cafff3a45676f403c23 (cla: yes, engine)


[62158](https://github.com/flutter/flutter/pull/62158) Manual engine roll to 602c2d81fa166c77920c2b2fdc190a6f2f257985 (cla: yes, engine)


[62163](https://github.com/flutter/flutter/pull/62163) Manual engine roll to 626244a72c5d53cc6d00c840987f9059faed511a (cla: yes, engine)


[62368](https://github.com/flutter/flutter/pull/62368) [roll] roll to 2.10 (cla: yes, engine, team, tool)


[62444](https://github.com/flutter/flutter/pull/62444) 1.20.0-7.3.pre beta cherrypicks (CQ+1, cla: yes, engine, tool)


[62705](https://github.com/flutter/flutter/pull/62705) 1.20 CP: Update engine hash to 1.20.0-7.4.pre (cla: yes, engine)


[62835](https://github.com/flutter/flutter/pull/62835) 1.20 stable: Update engine hash to 1.20.0 (engine, work in progress; do not review)


[62903](https://github.com/flutter/flutter/pull/62903) Revert "remove iOS folder (#61561)" (cp: 1.20, cp: 1.20 completed, engine, framework, team, tool)


[62937](https://github.com/flutter/flutter/pull/62937) Update engine hash to 1.20.0 w/ #20238 (engine)


[62990](https://github.com/flutter/flutter/pull/62990) [hotfix] flutter create -t plugin remove no-op iOS folder and set sdk min to 1.20.0 (engine, framework, team, tool)


[63030](https://github.com/flutter/flutter/pull/63030) using named constructor to FrameTiming in scheduler_test.dart (a: tests, engine, framework, waiting for tree to go green)


[63225](https://github.com/flutter/flutter/pull/63225) Cherrypick engine 5e9eede19290de1f288d8d3d21d390f4b3093338 (engine)


[63591](https://github.com/flutter/flutter/pull/63591) 1.20.2 Cherrypicks (a: internationalization, cla: yes, engine, f: material design, framework, team, tool, work in progress; do not review)


[63695](https://github.com/flutter/flutter/pull/63695) Cherrypick engine hash to 7c89b4191329302d31f0d491f3aedb623ac7393b (cla: yes, engine)


[63777](https://github.com/flutter/flutter/pull/63777) Cherry pick engine (cla: yes, engine)


[63969](https://github.com/flutter/flutter/pull/63969) Revert "Roll Engine from 7571e7c380fd to b300be3df32b (60 revisions)" (cla: yes, engine)


[63991](https://github.com/flutter/flutter/pull/63991) Revert "Roll Engine from 7571e7c380fd to 613be923b132 (76 revisions)" (cla: yes, engine)


[64050](https://github.com/flutter/flutter/pull/64050) 1.21.0-9.1.pre cherrypicks (cla: yes, engine, f: material design, framework, team, tool)


[64102](https://github.com/flutter/flutter/pull/64102) Move engine version to pick Harfbuzz revert (cla: yes, engine)


[64732](https://github.com/flutter/flutter/pull/64732) Cherry-pick engine c1bc5483f60fb100fe4676c609c0f092a9ee3fc9 (cla: yes, engine)


[64737](https://github.com/flutter/flutter/pull/64737) Flutter Framework Beta 1.21.0-9.2.pre cherry picks (a: internationalization, cla: yes, engine, f: material design, framework, tool)


[64984](https://github.com/flutter/flutter/pull/64984) Flutter stable framework 1.20.3 cherrypicks (a: internationalization, cla: yes, d: examples, engine, f: material design, framework, team, tool)


[65188](https://github.com/flutter/flutter/pull/65188) Revert "Roll Engine from 165abef0a2cb to e979c29a2a50 (42 revisions)" (cla: yes, engine)


[65271](https://github.com/flutter/flutter/pull/65271) Cherry pick engine #20983 (cla: yes, engine)


[65386](https://github.com/flutter/flutter/pull/65386) Flutter 1.22 candidate.10 (cla: yes, engine, f: material design, framework)


[65513](https://github.com/flutter/flutter/pull/65513) Use cherry-pick engine 76240869bda39bb256bc061c9c8d7a81b13b8dae (cla: yes, engine)


[65555](https://github.com/flutter/flutter/pull/65555) Manual roll of Engine to fee6f9e5333472a1931d00f521252901d60e0c76 (cla: yes, engine)


### documentation - 30 pull request(s)

[61268](https://github.com/flutter/flutter/pull/61268) Update Table docs for horizontal scrolling (cla: yes, d: api docs, documentation, f: scrolling, framework, waiting for tree to go green)


[61323](https://github.com/flutter/flutter/pull/61323) Updated Row API doc for RTL in textDirection (cla: yes, d: api docs, documentation, framework, waiting for tree to go green)


[61502](https://github.com/flutter/flutter/pull/61502) Update documentation for IntrinsicWidth & IntrinsicHeight (cla: yes, d: api docs, documentation, framework)


[61710](https://github.com/flutter/flutter/pull/61710) Added expandedHeight in flexibleSpace and flexibleSpaceBar (cla: yes, d: api docs, documentation, f: material design, framework, waiting for tree to go green)


[61773](https://github.com/flutter/flutter/pull/61773) Update framePolicy docs (a: tests, cla: yes, d: api docs, documentation, framework, waiting for tree to go green)


[61796](https://github.com/flutter/flutter/pull/61796) Improved docs for minLines in EditableText (a: text input, cla: yes, d: api docs, documentation, framework, waiting for tree to go green)


[61948](https://github.com/flutter/flutter/pull/61948) Add LayoutBuilder example (cla: yes, d: api docs, d: examples, documentation, framework, waiting for tree to go green)


[62083](https://github.com/flutter/flutter/pull/62083) Update the documentation of GlobalKey to explain why it is expensive (cla: yes, d: api docs, documentation, framework, waiting for tree to go green)


[62099](https://github.com/flutter/flutter/pull/62099) Updated references to the old button classes to the new classes in widgets, services, and rendering packages (cla: yes, d: api docs, d: examples, documentation, f: material design, framework, waiting for tree to go green)


[62101](https://github.com/flutter/flutter/pull/62101)  Updated 'CustomClipper.shouldReclip' doc (cla: yes, d: api docs, documentation, framework, waiting for tree to go green)


[62520](https://github.com/flutter/flutter/pull/62520) Fix even more unresolved doc references in material (cla: yes, d: api docs, documentation, f: material design, framework, team, waiting for tree to go green)


[62755](https://github.com/flutter/flutter/pull/62755) Add punctuation for unterminated sentences in doc comments (a: accessibility, a: internationalization, a: tests, cla: yes, d: api docs, documentation, f: cupertino, f: material design, framework, tool)


[62805](https://github.com/flutter/flutter/pull/62805) Add “See also” links to favorite class API docs (cla: yes, d: api docs, documentation, f: material design, framework, waiting for tree to go green)


[62859](https://github.com/flutter/flutter/pull/62859) Add gaplessPlayback docs default discussion (d: api docs, documentation, framework, waiting for tree to go green)


[63132](https://github.com/flutter/flutter/pull/63132) Fix grammar in Route doc comment (d: api docs, documentation, f: routes, framework, waiting for tree to go green)


[63273](https://github.com/flutter/flutter/pull/63273) Fixing code snippet example for meetsGuideline. (a: tests, d: api docs, documentation, framework, waiting for tree to go green)


[63313](https://github.com/flutter/flutter/pull/63313) Small documentation typo fix (d: api docs, documentation, framework, waiting for tree to go green)


[63438](https://github.com/flutter/flutter/pull/63438) More restoration documentation (cla: yes, d: api docs, d: examples, documentation, framework, team, waiting for tree to go green)


[63497](https://github.com/flutter/flutter/pull/63497) Add dispose to restoration example (d: api docs, d: examples, documentation, framework, waiting for tree to go green)


[63503](https://github.com/flutter/flutter/pull/63503) Update: Documentation for ListView constructor should warn about changing widget list (cla: yes, d: api docs, documentation, framework, waiting for tree to go green)


[63692](https://github.com/flutter/flutter/pull/63692) "Draw" vs "drawer" typo (cla: yes, d: api docs, documentation, f: material design, framework, waiting for tree to go green)


[63776](https://github.com/flutter/flutter/pull/63776) Mention time picker theme in showTimePicker documentation (cla: yes, documentation, f: material design, framework, waiting for tree to go green)


[63833](https://github.com/flutter/flutter/pull/63833) SizeTransition sample code (a: animation, cla: yes, d: api docs, d: examples, documentation, framework, waiting for tree to go green)


[63884](https://github.com/flutter/flutter/pull/63884) updated_title_property_apidocs (cla: yes, d: api docs, documentation, framework, platform-web, waiting for tree to go green)


[63886](https://github.com/flutter/flutter/pull/63886) Add sample code for ScaleTransition (a: animation, cla: yes, d: api docs, d: examples, documentation, framework, waiting for tree to go green)


[63940](https://github.com/flutter/flutter/pull/63940) Add sample code to RelativePositionedTransition (a: animation, cla: yes, d: api docs, d: examples, documentation, framework, waiting for tree to go green)


[63981](https://github.com/flutter/flutter/pull/63981) Fixed the docs of the focusColor property included in input_decorator (cla: yes, d: api docs, documentation, f: material design, framework, waiting for tree to go green)


[64148](https://github.com/flutter/flutter/pull/64148) Update Visibility docs on maintainSize (cla: yes, d: api docs, documentation, framework, waiting for tree to go green)


[64175](https://github.com/flutter/flutter/pull/64175) feat: Text constructor, overflow, and softWrap docs (cla: yes, d: api docs, documentation, framework, waiting for tree to go green)


[64795](https://github.com/flutter/flutter/pull/64795) Add sample code to RotationTransition (cla: yes, d: api docs, d: examples, documentation, framework, waiting for tree to go green)


### platform-ios - 24 pull request(s)

[59623](https://github.com/flutter/flutter/pull/59623) Reduce iOS scroll damping for lists with differently sized items (a: fidelity, cla: yes, f: scrolling, framework, platform-ios, waiting for tree to go green)


[60501](https://github.com/flutter/flutter/pull/60501) Make Scrollable's free scroll initial velocity matches that of iOS (a: fidelity, cla: yes, f: scrolling, framework, platform-ios, waiting for tree to go green)


[60558](https://github.com/flutter/flutter/pull/60558) Pointer event resampler (#41118) (cla: yes, f: scrolling, framework, platform-android, platform-fuchsia, platform-ios, waiting for tree to go green)


[61007](https://github.com/flutter/flutter/pull/61007) Turn on add-to-app iOS platform unit tests (a: existing-apps, a: tests, cla: yes, platform-ios, team)


[61140](https://github.com/flutter/flutter/pull/61140) Case insensitive check flavor names against Xcode schemes (cla: yes, platform-ios, t: xcode, team, tool)


[61269](https://github.com/flutter/flutter/pull/61269) Parse .flutter-plugins-dependencies for add-to-app iOS modules (a: existing-apps, cla: yes, platform-ios, team, tool, waiting for tree to go green)


[61484](https://github.com/flutter/flutter/pull/61484) Support Xcode patch version comparison (cla: yes, platform-ios, t: xcode, tool, waiting for tree to go green)


[61762](https://github.com/flutter/flutter/pull/61762) Inject iproxy into context (cla: yes, platform-ios, tool, waiting for tree to go green)


[61979](https://github.com/flutter/flutter/pull/61979) Only try to get build settings if the Xcode project exists (cla: yes, platform-ios, t: xcode, tool, waiting for tree to go green)


[62082](https://github.com/flutter/flutter/pull/62082) Mark flutter_gallery_ios__transition_perf flaky during investigation (cla: yes, platform-ios, team, team: flakes)


[62085](https://github.com/flutter/flutter/pull/62085) Mark smoke_catalina_start_up_ios as not flaky (cla: yes, platform-ios, team, team: flakes, waiting for tree to go green)


[62225](https://github.com/flutter/flutter/pull/62225) Handle hyphens in iOS UDIDs (cla: yes, platform-ios, tool)


[62372](https://github.com/flutter/flutter/pull/62372) Parse .flutter-plugins-dependencies for add-to-app iOS modules, remove no-op plugin iOS folder (a: existing-apps, cla: yes, platform-ios, team, tool)


[62630](https://github.com/flutter/flutter/pull/62630) Add integration test for plugins without ios directories (a: tests, cla: yes, platform-ios, team, waiting for tree to go green)


[62902](https://github.com/flutter/flutter/pull/62902) Change minimum iOS version from 8.0 to 9.0 (d: examples, platform-ios, team, tool, waiting for tree to go green)


[63252](https://github.com/flutter/flutter/pull/63252) Bump Cirrus image Xcode version (cla: yes, platform-ios, team, team: infra)


[63412](https://github.com/flutter/flutter/pull/63412) Fix App.framework path in Podfile (a: existing-apps, cla: yes, platform-ios, team, tool, waiting for tree to go green)


[63445](https://github.com/flutter/flutter/pull/63445) Pin iOS module test plugin versions (a: existing-apps, a: tests, platform-ios, team, waiting for tree to go green)


[63448](https://github.com/flutter/flutter/pull/63448) Temporarily turn off module_test_ios during investigation (platform-ios, team)


[64674](https://github.com/flutter/flutter/pull/64674) Avoid thinning frameworks in iOS extensions (cla: yes, platform-ios, team, tool, waiting for tree to go green)


[64834](https://github.com/flutter/flutter/pull/64834) Add --device-timeout flag to device-related commands (cla: yes, platform-ios, tool, waiting for tree to go green)


[64988](https://github.com/flutter/flutter/pull/64988) Add observatory Bonjour service to built iOS Info.plist bundle (cla: yes, platform-ios, t: xcode, team, tool)


[65124](https://github.com/flutter/flutter/pull/65124) Require xcode_backend.sh arguments (introduced in Flutter v0.0.7) (cla: yes, platform-ios, t: xcode, team, tool, waiting for tree to go green)


[65138](https://github.com/flutter/flutter/pull/65138) Add observatory Bonjour service to built iOS Info.plist bundle (cla: yes, platform-ios, t: xcode, team, tool)


### a: accessibility - 23 pull request(s)

[61048](https://github.com/flutter/flutter/pull/61048) Re-land "Tweaking Material Chip a11y semantics to match buttons (#60141)" (a: accessibility, cla: yes, customer: money (g3), f: material design, framework, waiting for tree to go green)


[61385](https://github.com/flutter/flutter/pull/61385) reland "Adds semantics information for the popup menu item (#61258)" (a: accessibility, cla: yes, f: material design, framework, team, waiting for tree to go green)


[61636](https://github.com/flutter/flutter/pull/61636) remove usage to applyTextScaleFactorToWidgetSpan (a: accessibility, a: typography, cla: yes, framework, waiting for tree to go green)


[62064](https://github.com/flutter/flutter/pull/62064) Migrate gallery/transitions_perf test to e2e (a: accessibility, cla: yes, team, waiting for tree to go green)


[62220](https://github.com/flutter/flutter/pull/62220) Updated the framework tests to use the new button API. (a: accessibility, a: tests, cla: yes, f: material design, framework, waiting for tree to go green)


[62359](https://github.com/flutter/flutter/pull/62359) Fix SemanticsNode.rect position for nested scrollables with useTwoPan… (a: accessibility, cla: yes, f: scrolling, framework, waiting for tree to go green)


[62367](https://github.com/flutter/flutter/pull/62367) Make dartdoc warnings fatal (& cleanup of warnings) (a: accessibility, a: internationalization, a: tests, cla: yes, f: cupertino, f: material design, framework, team, waiting for tree to go green)


[62668](https://github.com/flutter/flutter/pull/62668) Ensure dark theme is used when high contrast dark theme isn't provided (a: accessibility, cla: yes, f: material design, framework, waiting for tree to go green)


[62755](https://github.com/flutter/flutter/pull/62755) Add punctuation for unterminated sentences in doc comments (a: accessibility, a: internationalization, a: tests, cla: yes, d: api docs, documentation, f: cupertino, f: material design, framework, tool)


[62788](https://github.com/flutter/flutter/pull/62788) Add onTertiaryTap* to TapGestureRecognizer and GestureDetector (a: accessibility, cla: yes, framework, waiting for tree to go green)


[62799](https://github.com/flutter/flutter/pull/62799) move compile/target sdk versions to 29 (a: accessibility, cla: yes, d: examples, team, tool, waiting for tree to go green)


[62884](https://github.com/flutter/flutter/pull/62884) Revert "move compile/target sdk versions to 29" (a: accessibility, d: examples, team, tool)


[63008](https://github.com/flutter/flutter/pull/63008) move compile/target sdk versions to 29 (#62799) (a: accessibility, d: examples, team, tool, waiting for tree to go green)


[63232](https://github.com/flutter/flutter/pull/63232) Updated old button references in dev/integration_tests/android_semantics (a: accessibility, team)


[63517](https://github.com/flutter/flutter/pull/63517) Move Android doctor SDK check to 29 and Cirrus images to 30 (a: accessibility, cla: yes, d: examples, team, tool)


[63595](https://github.com/flutter/flutter/pull/63595) Disables tests failing due to new semantics flag. (a: accessibility, a: tests, cla: yes, framework, waiting for tree to go green)


[63609](https://github.com/flutter/flutter/pull/63609) Clean up flutter_gallery__transition_perf (a: accessibility, cla: yes, team, waiting for tree to go green)


[63799](https://github.com/flutter/flutter/pull/63799) bug fix for flutter_gallery__transition_perf(_with_semantics) (a: accessibility, cla: yes, team)


[64055](https://github.com/flutter/flutter/pull/64055) migrate semantics to nullsafety (a: accessibility, cla: yes, framework, waiting for tree to go green)


[64120](https://github.com/flutter/flutter/pull/64120) [flutter_tools] reland: enable --null-assertions for flutter framework tests (a: accessibility, cla: yes, framework, team, waiting for tree to go green)


[64672](https://github.com/flutter/flutter/pull/64672) Nnbd widgets (a: accessibility, cla: yes, f: cupertino, framework, team)


[65049](https://github.com/flutter/flutter/pull/65049) Fixed the sliver appbar to have a fixed traversal order (a: accessibility, cla: yes, f: material design, framework, waiting for tree to go green)


[65488](https://github.com/flutter/flutter/pull/65488) Revert "Nnbd widgets" (a: accessibility, cla: yes, f: cupertino, framework)


### a: internationalization - 20 pull request(s)

[60632](https://github.com/flutter/flutter/pull/60632) Add locales for fil(filipino) and gsw(swiss german) to locale list, Fixes #60631 (a: internationalization, cla: yes, team, tool, waiting for tree to go green)


[61564](https://github.com/flutter/flutter/pull/61564) ✒ Spell Check All `.md` Files Related to Flutter 💙 (a: internationalization, cla: yes, d: examples, team, tool, waiting for tree to go green)


[62367](https://github.com/flutter/flutter/pull/62367) Make dartdoc warnings fatal (& cleanup of warnings) (a: accessibility, a: internationalization, a: tests, cla: yes, f: cupertino, f: material design, framework, team, waiting for tree to go green)


[62395](https://github.com/flutter/flutter/pull/62395) [gen_l10n] Synthetic package generation by default (a: internationalization, cla: yes, severe: API break, team, tool, waiting for tree to go green)


[62582](https://github.com/flutter/flutter/pull/62582) Random unresolved doc reference fixes I missed before (a: internationalization, a: tests, cla: yes, f: material design, framework, waiting for tree to go green)


[62755](https://github.com/flutter/flutter/pull/62755) Add punctuation for unterminated sentences in doc comments (a: accessibility, a: internationalization, a: tests, cla: yes, d: api docs, documentation, f: cupertino, f: material design, framework, tool)


[62761](https://github.com/flutter/flutter/pull/62761) Fix lifecycle clean up in the material date picker tests for screen size and semantics. (a: internationalization, cla: yes, f: material design, framework, waiting for tree to go green)


[62803](https://github.com/flutter/flutter/pull/62803) Address misc time picker design issues (a: internationalization, cla: yes, f: material design, framework, waiting for tree to go green)


[63026](https://github.com/flutter/flutter/pull/63026) Update to the latest localizations - Adds missing DatePicker strings and fixes manually entering date for German (a: internationalization, f: cupertino, f: material design, framework, waiting for tree to go green)


[63034](https://github.com/flutter/flutter/pull/63034) Remove Special Handling of Norwegian Locales (a: internationalization, f: cupertino, f: material design, framework, team)


[63040](https://github.com/flutter/flutter/pull/63040) Updated flutter_localizations picker tests to use new button classes. (a: internationalization, f: material design)


[63368](https://github.com/flutter/flutter/pull/63368) [gen_l10n] Absolute project path parameter (a: internationalization, team, tool, waiting for tree to go green)


[63405](https://github.com/flutter/flutter/pull/63405) Ensure cupertino time picker positions hours and minutes correctly for RTL (a: internationalization, f: cupertino, framework)


[63591](https://github.com/flutter/flutter/pull/63591) 1.20.2 Cherrypicks (a: internationalization, cla: yes, engine, f: material design, framework, team, tool, work in progress; do not review)


[63599](https://github.com/flutter/flutter/pull/63599) Ensure time picker input mode lays out correctly in RTL (a: internationalization, cla: yes, f: material design, framework, waiting for tree to go green)


[64094](https://github.com/flutter/flutter/pull/64094) Revert "Ensure time picker input mode lays out correctly in RTL" (a: internationalization, cla: yes, f: material design, framework)


[64097](https://github.com/flutter/flutter/pull/64097) [Material] Relanding fix to ensure time picker input mode lays out correctly in RTL (a: internationalization, cla: yes, f: material design, framework)


[64737](https://github.com/flutter/flutter/pull/64737) Flutter Framework Beta 1.21.0-9.2.pre cherry picks (a: internationalization, cla: yes, engine, f: material design, framework, tool)


[64984](https://github.com/flutter/flutter/pull/64984) Flutter stable framework 1.20.3 cherrypicks (a: internationalization, cla: yes, d: examples, engine, f: material design, framework, team, tool)


[65025](https://github.com/flutter/flutter/pull/65025) Move gen_l10n into flutter_tools (a: internationalization, cla: yes, team, tool)


### d: examples - 19 pull request(s)

[61564](https://github.com/flutter/flutter/pull/61564) ✒ Spell Check All `.md` Files Related to Flutter 💙 (a: internationalization, cla: yes, d: examples, team, tool, waiting for tree to go green)


[61948](https://github.com/flutter/flutter/pull/61948) Add LayoutBuilder example (cla: yes, d: api docs, d: examples, documentation, framework, waiting for tree to go green)


[62099](https://github.com/flutter/flutter/pull/62099) Updated references to the old button classes to the new classes in widgets, services, and rendering packages (cla: yes, d: api docs, d: examples, documentation, f: material design, framework, waiting for tree to go green)


[62799](https://github.com/flutter/flutter/pull/62799) move compile/target sdk versions to 29 (a: accessibility, cla: yes, d: examples, team, tool, waiting for tree to go green)


[62884](https://github.com/flutter/flutter/pull/62884) Revert "move compile/target sdk versions to 29" (a: accessibility, d: examples, team, tool)


[62902](https://github.com/flutter/flutter/pull/62902) Change minimum iOS version from 8.0 to 9.0 (d: examples, platform-ios, team, tool, waiting for tree to go green)


[62932](https://github.com/flutter/flutter/pull/62932) Updated examples/layers to use the new button API. (d: examples, team, waiting for tree to go green)


[63008](https://github.com/flutter/flutter/pull/63008) move compile/target sdk versions to 29 (#62799) (a: accessibility, d: examples, team, tool, waiting for tree to go green)


[63438](https://github.com/flutter/flutter/pull/63438) More restoration documentation (cla: yes, d: api docs, d: examples, documentation, framework, team, waiting for tree to go green)


[63497](https://github.com/flutter/flutter/pull/63497) Add dispose to restoration example (d: api docs, d: examples, documentation, framework, waiting for tree to go green)


[63517](https://github.com/flutter/flutter/pull/63517) Move Android doctor SDK check to 29 and Cirrus images to 30 (a: accessibility, cla: yes, d: examples, team, tool)


[63833](https://github.com/flutter/flutter/pull/63833) SizeTransition sample code (a: animation, cla: yes, d: api docs, d: examples, documentation, framework, waiting for tree to go green)


[63886](https://github.com/flutter/flutter/pull/63886) Add sample code for ScaleTransition (a: animation, cla: yes, d: api docs, d: examples, documentation, framework, waiting for tree to go green)


[63940](https://github.com/flutter/flutter/pull/63940) Add sample code to RelativePositionedTransition (a: animation, cla: yes, d: api docs, d: examples, documentation, framework, waiting for tree to go green)


[64020](https://github.com/flutter/flutter/pull/64020) [flutter_tool] Fix amberctl host address (cla: yes, d: examples, team, tool, waiting for tree to go green)


[64432](https://github.com/flutter/flutter/pull/64432) Reland "Make sure all isolates start during flutter driver tests" (a: tests, cla: yes, d: examples, framework, team, waiting for tree to go green)


[64519](https://github.com/flutter/flutter/pull/64519) Re-enable image_list test with updated certificate(good for 3650 days). (cla: yes, d: examples, team)


[64795](https://github.com/flutter/flutter/pull/64795) Add sample code to RotationTransition (cla: yes, d: api docs, d: examples, documentation, framework, waiting for tree to go green)


[64984](https://github.com/flutter/flutter/pull/64984) Flutter stable framework 1.20.3 cherrypicks (a: internationalization, cla: yes, d: examples, engine, f: material design, framework, team, tool)


### f: scrolling - 16 pull request(s)

[56413](https://github.com/flutter/flutter/pull/56413) Prevent viewport.showOnScreen from scrolling the viewport if the specified Rect is already visible.  (cla: yes, f: material design, f: scrolling, framework, severe: API break, waiting for tree to go green)


[59623](https://github.com/flutter/flutter/pull/59623) Reduce iOS scroll damping for lists with differently sized items (a: fidelity, cla: yes, f: scrolling, framework, platform-ios, waiting for tree to go green)


[60501](https://github.com/flutter/flutter/pull/60501) Make Scrollable's free scroll initial velocity matches that of iOS (a: fidelity, cla: yes, f: scrolling, framework, platform-ios, waiting for tree to go green)


[60558](https://github.com/flutter/flutter/pull/60558) Pointer event resampler (#41118) (cla: yes, f: scrolling, framework, platform-android, platform-fuchsia, platform-ios, waiting for tree to go green)


[61268](https://github.com/flutter/flutter/pull/61268) Update Table docs for horizontal scrolling (cla: yes, d: api docs, documentation, f: scrolling, framework, waiting for tree to go green)


[61386](https://github.com/flutter/flutter/pull/61386) Fix NestedScrollView inner ballistic activity for 0 velocity (a: quality, cla: yes, f: scrolling, framework, waiting for tree to go green)


[61973](https://github.com/flutter/flutter/pull/61973) Update viewport dimensions when scrollDirection changes (a: quality, cla: yes, f: scrolling, framework, waiting for tree to go green)


[62359](https://github.com/flutter/flutter/pull/62359) Fix SemanticsNode.rect position for nested scrollables with useTwoPan… (a: accessibility, cla: yes, f: scrolling, framework, waiting for tree to go green)


[62615](https://github.com/flutter/flutter/pull/62615) Fix SliverList scrollOffsetCorrection 0 case (cla: yes, f: scrolling, framework, severe: crash, severe: regression, waiting for tree to go green)


[63054](https://github.com/flutter/flutter/pull/63054) fix SingleChildScrollView clip bug (a: quality, f: scrolling, framework, waiting for tree to go green)


[63147](https://github.com/flutter/flutter/pull/63147) Add clipBehavior to ListView, GridView, PageView (cla: yes, f: scrolling, framework)


[64239](https://github.com/flutter/flutter/pull/64239) The OverscrollIndicator should not overflow the scrollable view's edge (cla: yes, f: scrolling, framework, waiting for tree to go green)


[64271](https://github.com/flutter/flutter/pull/64271) Make large jumpTo recommend deferred loading (a: images, cla: yes, f: scrolling, framework, perf: memory, severe: performance, waiting for tree to go green)


[64513](https://github.com/flutter/flutter/pull/64513) Reland "Prevent viewport.showOnScreen from scrolling the viewport if the specified Rect is already visible.  (#56413)", reverted in #64091 (cla: yes, f: material design, f: scrolling, framework, waiting for tree to go green)


[64750](https://github.com/flutter/flutter/pull/64750) Allow for arbitrary placement in SliverGrid (cla: yes, customer: google, f: scrolling, framework, waiting for tree to go green)


[65135](https://github.com/flutter/flutter/pull/65135) Fix RangeMaintainingScrollPhysics (cla: yes, f: scrolling, framework, waiting for tree to go green)


### a: quality - 12 pull request(s)

[58640](https://github.com/flutter/flutter/pull/58640) Skip Audit - Rendering Library (a: quality, a: tests, cla: yes, framework, team, waiting for tree to go green)


[60940](https://github.com/flutter/flutter/pull/60940) Skip Audit - Last Leftovers (a: quality, a: tests, cla: yes, f: cupertino, f: material design, framework, team, waiting for tree to go green)


[61171](https://github.com/flutter/flutter/pull/61171) Fix FloatingActionButtonLocation for additional test case (a: quality, f: material design, framework, waiting for tree to go green)


[61386](https://github.com/flutter/flutter/pull/61386) Fix NestedScrollView inner ballistic activity for 0 velocity (a: quality, cla: yes, f: scrolling, framework, waiting for tree to go green)


[61579](https://github.com/flutter/flutter/pull/61579) Remove unused FlutterErrorDetails subclasses (a: debugging, a: error message, a: quality, a: tests, cla: yes, framework, waiting for tree to go green)


[61973](https://github.com/flutter/flutter/pull/61973) Update viewport dimensions when scrollDirection changes (a: quality, cla: yes, f: scrolling, framework, waiting for tree to go green)


[63054](https://github.com/flutter/flutter/pull/63054) fix SingleChildScrollView clip bug (a: quality, f: scrolling, framework, waiting for tree to go green)


[63352](https://github.com/flutter/flutter/pull/63352) Clip image of BoxDecoration to circle when shape is BoxShape.circle (a: quality, framework, waiting for tree to go green)


[63420](https://github.com/flutter/flutter/pull/63420) fix wrap intrinsic height calculation (a: layout, a: quality, cla: yes, framework, waiting for tree to go green)


[64101](https://github.com/flutter/flutter/pull/64101) ScaffoldMessenger (a: quality, cla: yes, customer: money (g3), f: material design, framework, severe: API break, severe: new feature, team, waiting for tree to go green)


[64268](https://github.com/flutter/flutter/pull/64268) Fix placement for SnackBarBehavior.floating (a: quality, cla: yes, f: material design, framework, severe: regression, waiting for tree to go green)


[64362](https://github.com/flutter/flutter/pull/64362) fix Container.clipBehaviour, clips the shadow in decoration (a: quality, cla: yes, framework, waiting for tree to go green, will affect goldens)


### team: infra - 9 pull request(s)

[61257](https://github.com/flutter/flutter/pull/61257) [devicelab] This no-op change marks 3 tests to run on LUCI builders. (cla: yes, team, team: infra, waiting for tree to go green)


[62623](https://github.com/flutter/flutter/pull/62623) Increase the number of shards for web tests (cla: yes, platform-web, team, team: infra, waiting for tree to go green)


[62643](https://github.com/flutter/flutter/pull/62643) Remove framework_tests from cirrus. (cla: yes, team, team: infra, waiting for tree to go green)


[62910](https://github.com/flutter/flutter/pull/62910) Add flutter_goldens_client to testing path (a: tests, team, team: infra, waiting for tree to go green)


[63252](https://github.com/flutter/flutter/pull/63252) Bump Cirrus image Xcode version (cla: yes, platform-ios, team, team: infra)


[63593](https://github.com/flutter/flutter/pull/63593) Pin goldctl (cla: yes, team, team: infra, waiting for tree to go green)


[64670](https://github.com/flutter/flutter/pull/64670) [fuchsia] Sync run test script with engine version (cla: yes, platform-fuchsia, team, team: infra, waiting for tree to go green)


[64757](https://github.com/flutter/flutter/pull/64757) Fix Gold json for digest paramset (a: tests, cla: yes, framework, team, team: infra, waiting for tree to go green)


[64982](https://github.com/flutter/flutter/pull/64982) Update Gold for new endpoint (a: tests, cla: yes, framework, team, team: infra, waiting for tree to go green)


### a: text input - 8 pull request(s)

[58731](https://github.com/flutter/flutter/pull/58731) Autofill save (a: text input, cla: yes, framework)


[59766](https://github.com/flutter/flutter/pull/59766) FormField should autovalidate only if its content was changed (fixed) (a: text input, cla: yes, f: material design, framework, waiting for tree to go green)


[60177](https://github.com/flutter/flutter/pull/60177) Don't move to word edge when tapping with a mouse (a: mouse, a: text input, cla: yes, f: material design, framework, waiting for tree to go green)


[61796](https://github.com/flutter/flutter/pull/61796) Improved docs for minLines in EditableText (a: text input, cla: yes, d: api docs, documentation, framework, waiting for tree to go green)


[63786](https://github.com/flutter/flutter/pull/63786) Make SelectableText work better on web (a: text input, a: typography, cla: yes, framework, platform-web, waiting for tree to go green)


[64516](https://github.com/flutter/flutter/pull/64516) [web] Fix and enable editable_text_test.dart (a: tests, a: text input, cla: yes, framework, platform-web, team, waiting for tree to go green)


[64570](https://github.com/flutter/flutter/pull/64570) [web] Enable word boundary tests in editable_text_test.dart (a: tests, a: text input, a: typography, cla: yes, framework, platform-web, team, waiting for tree to go green)


[65127](https://github.com/flutter/flutter/pull/65127) [web] Don't show handles when selection change is caused by keyboard (a: text input, cla: yes, framework, platform-web, waiting for tree to go green)


### t: xcode - 7 pull request(s)

[61140](https://github.com/flutter/flutter/pull/61140) Case insensitive check flavor names against Xcode schemes (cla: yes, platform-ios, t: xcode, team, tool)


[61484](https://github.com/flutter/flutter/pull/61484) Support Xcode patch version comparison (cla: yes, platform-ios, t: xcode, tool, waiting for tree to go green)


[61518](https://github.com/flutter/flutter/pull/61518) Change xcodebuild to be a "slow operation" (cla: yes, t: xcode, tool)


[61979](https://github.com/flutter/flutter/pull/61979) Only try to get build settings if the Xcode project exists (cla: yes, platform-ios, t: xcode, tool, waiting for tree to go green)


[64988](https://github.com/flutter/flutter/pull/64988) Add observatory Bonjour service to built iOS Info.plist bundle (cla: yes, platform-ios, t: xcode, team, tool)


[65124](https://github.com/flutter/flutter/pull/65124) Require xcode_backend.sh arguments (introduced in Flutter v0.0.7) (cla: yes, platform-ios, t: xcode, team, tool, waiting for tree to go green)


[65138](https://github.com/flutter/flutter/pull/65138) Add observatory Bonjour service to built iOS Info.plist bundle (cla: yes, platform-ios, t: xcode, team, tool)


### a: desktop - 6 pull request(s)

[60931](https://github.com/flutter/flutter/pull/60931) Add all system cursors (framework) (a: desktop, a: mouse, cla: yes, framework, waiting for tree to go green)


[61399](https://github.com/flutter/flutter/pull/61399) Document the mapping of system mouse cursors on Windows and Linux (a: desktop, a: mouse, cla: yes, framework)


[62999](https://github.com/flutter/flutter/pull/62999) Add flutter_engine.cc to Windows wrapper build (a: desktop, platform-windows, tool, waiting for tree to go green)


[63707](https://github.com/flutter/flutter/pull/63707) Surface Windows build errors in non-verbose mode (a: build, a: desktop, cla: yes, platform-windows, tool, waiting for tree to go green)


[64119](https://github.com/flutter/flutter/pull/64119) Change MouseTracker's interface for clarity. Simplify MouseRegion's implementation. (a: desktop, a: mouse, cla: yes, framework)


[64267](https://github.com/flutter/flutter/pull/64267) [framework] make hit slop based on device pointer kind for drag/pan/scale gestures (a: desktop, cla: yes, f: gestures, framework)


### a: animation - 6 pull request(s)

[60796](https://github.com/flutter/flutter/pull/60796) Add support in WidgetTester for an array of inputs (a: animation, a: tests, cla: yes, f: gestures, framework)


[61136](https://github.com/flutter/flutter/pull/61136) Re-land Expose height and width factor in AnimatedAlign (a: animation, cla: yes, framework, waiting for tree to go green)


[63833](https://github.com/flutter/flutter/pull/63833) SizeTransition sample code (a: animation, cla: yes, d: api docs, d: examples, documentation, framework, waiting for tree to go green)


[63886](https://github.com/flutter/flutter/pull/63886) Add sample code for ScaleTransition (a: animation, cla: yes, d: api docs, d: examples, documentation, framework, waiting for tree to go green)


[63940](https://github.com/flutter/flutter/pull/63940) Add sample code to RelativePositionedTransition (a: animation, cla: yes, d: api docs, d: examples, documentation, framework, waiting for tree to go green)


[64715](https://github.com/flutter/flutter/pull/64715) Clamp TabController animation value when calc _DragAnimation.value (a: animation, cla: yes, f: material design, framework, waiting for tree to go green)


### will affect goldens - 6 pull request(s)

[61194](https://github.com/flutter/flutter/pull/61194) Roll Engine from 9b3e3410f026 to f10f17257300 (1 revision) (severe: API break, waiting for tree to go green, will affect goldens)


[62588](https://github.com/flutter/flutter/pull/62588) Build routes even less. (cla: yes, framework, severe: API break, waiting for tree to go green, will affect goldens)


[62840](https://github.com/flutter/flutter/pull/62840) [ExpansionPanelList] adds elevation property (f: material design, framework, waiting for tree to go green, will affect goldens)


[64362](https://github.com/flutter/flutter/pull/64362) fix Container.clipBehaviour, clips the shadow in decoration (a: quality, cla: yes, framework, waiting for tree to go green, will affect goldens)


[65036](https://github.com/flutter/flutter/pull/65036) Update hintColor value for Material (cla: yes, f: material design, framework, waiting for tree to go green, will affect goldens)


[65275](https://github.com/flutter/flutter/pull/65275) Roll Engine from ac8b9c4c52ea to d1d848e8421e (15 revisions) (cla: yes, waiting for tree to go green, will affect goldens)


### platform-web - 6 pull request(s)

[62623](https://github.com/flutter/flutter/pull/62623) Increase the number of shards for web tests (cla: yes, platform-web, team, team: infra, waiting for tree to go green)


[63786](https://github.com/flutter/flutter/pull/63786) Make SelectableText work better on web (a: text input, a: typography, cla: yes, framework, platform-web, waiting for tree to go green)


[63884](https://github.com/flutter/flutter/pull/63884) updated_title_property_apidocs (cla: yes, d: api docs, documentation, framework, platform-web, waiting for tree to go green)


[64516](https://github.com/flutter/flutter/pull/64516) [web] Fix and enable editable_text_test.dart (a: tests, a: text input, cla: yes, framework, platform-web, team, waiting for tree to go green)


[64570](https://github.com/flutter/flutter/pull/64570) [web] Enable word boundary tests in editable_text_test.dart (a: tests, a: text input, a: typography, cla: yes, framework, platform-web, team, waiting for tree to go green)


[65127](https://github.com/flutter/flutter/pull/65127) [web] Don't show handles when selection change is caused by keyboard (a: text input, cla: yes, framework, platform-web, waiting for tree to go green)


### a: existing-apps - 5 pull request(s)

[61007](https://github.com/flutter/flutter/pull/61007) Turn on add-to-app iOS platform unit tests (a: existing-apps, a: tests, cla: yes, platform-ios, team)


[61269](https://github.com/flutter/flutter/pull/61269) Parse .flutter-plugins-dependencies for add-to-app iOS modules (a: existing-apps, cla: yes, platform-ios, team, tool, waiting for tree to go green)


[62372](https://github.com/flutter/flutter/pull/62372) Parse .flutter-plugins-dependencies for add-to-app iOS modules, remove no-op plugin iOS folder (a: existing-apps, cla: yes, platform-ios, team, tool)


[63412](https://github.com/flutter/flutter/pull/63412) Fix App.framework path in Podfile (a: existing-apps, cla: yes, platform-ios, team, tool, waiting for tree to go green)


[63445](https://github.com/flutter/flutter/pull/63445) Pin iOS module test plugin versions (a: existing-apps, a: tests, platform-ios, team, waiting for tree to go green)


### a: mouse - 5 pull request(s)

[60177](https://github.com/flutter/flutter/pull/60177) Don't move to word edge when tapping with a mouse (a: mouse, a: text input, cla: yes, f: material design, framework, waiting for tree to go green)


[60931](https://github.com/flutter/flutter/pull/60931) Add all system cursors (framework) (a: desktop, a: mouse, cla: yes, framework, waiting for tree to go green)


[61399](https://github.com/flutter/flutter/pull/61399) Document the mapping of system mouse cursors on Windows and Linux (a: desktop, a: mouse, cla: yes, framework)


[61667](https://github.com/flutter/flutter/pull/61667) Add tests for platform views' hover behavior  (a: mouse, a: platform-views, cla: yes, framework)


[64119](https://github.com/flutter/flutter/pull/64119) Change MouseTracker's interface for clarity. Simplify MouseRegion's implementation. (a: desktop, a: mouse, cla: yes, framework)


### severe: API break - 5 pull request(s)

[56413](https://github.com/flutter/flutter/pull/56413) Prevent viewport.showOnScreen from scrolling the viewport if the specified Rect is already visible.  (cla: yes, f: material design, f: scrolling, framework, severe: API break, waiting for tree to go green)


[61194](https://github.com/flutter/flutter/pull/61194) Roll Engine from 9b3e3410f026 to f10f17257300 (1 revision) (severe: API break, waiting for tree to go green, will affect goldens)


[62395](https://github.com/flutter/flutter/pull/62395) [gen_l10n] Synthetic package generation by default (a: internationalization, cla: yes, severe: API break, team, tool, waiting for tree to go green)


[62588](https://github.com/flutter/flutter/pull/62588) Build routes even less. (cla: yes, framework, severe: API break, waiting for tree to go green, will affect goldens)


[64101](https://github.com/flutter/flutter/pull/64101) ScaffoldMessenger (a: quality, cla: yes, customer: money (g3), f: material design, framework, severe: API break, severe: new feature, team, waiting for tree to go green)


### a: error message - 4 pull request(s)

[61209](https://github.com/flutter/flutter/pull/61209) Optionally invert oversized images (a: debugging, a: error message, a: images, cla: yes, framework, tool)


[61579](https://github.com/flutter/flutter/pull/61579) Remove unused FlutterErrorDetails subclasses (a: debugging, a: error message, a: quality, a: tests, cla: yes, framework, waiting for tree to go green)


[61581](https://github.com/flutter/flutter/pull/61581) Give better error message for describeEnum (a: error message, cla: yes, f: inspector, framework, waiting for tree to go green)


[61961](https://github.com/flutter/flutter/pull/61961) Improve message error for missing textBaseline (a: error message, cla: yes, framework, waiting for tree to go green)


### a: typography - 4 pull request(s)

[61636](https://github.com/flutter/flutter/pull/61636) remove usage to applyTextScaleFactorToWidgetSpan (a: accessibility, a: typography, cla: yes, framework, waiting for tree to go green)


[63786](https://github.com/flutter/flutter/pull/63786) Make SelectableText work better on web (a: text input, a: typography, cla: yes, framework, platform-web, waiting for tree to go green)


[64570](https://github.com/flutter/flutter/pull/64570) [web] Enable word boundary tests in editable_text_test.dart (a: tests, a: text input, a: typography, cla: yes, framework, platform-web, team, waiting for tree to go green)


[65150](https://github.com/flutter/flutter/pull/65150) Expose 3 new methods with text metrics in RenderParagraph (a: typography, cla: yes, framework, waiting for tree to go green)


### severe: performance - 4 pull request(s)

[61185](https://github.com/flutter/flutter/pull/61185) Filter profiling events by names not category (a: tests, cla: yes, framework, severe: performance)


[63124](https://github.com/flutter/flutter/pull/63124) Measure CPU/GPU with the simple animation test (perf: energy, severe: performance, team, waiting for tree to go green)


[64271](https://github.com/flutter/flutter/pull/64271) Make large jumpTo recommend deferred loading (a: images, cla: yes, f: scrolling, framework, perf: memory, severe: performance, waiting for tree to go green)


[64762](https://github.com/flutter/flutter/pull/64762) Memory benchmark for showing large images in succession (cla: yes, perf: energy, perf: memory, severe: performance, team)


### CQ+1 - 3 pull request(s)

[61270](https://github.com/flutter/flutter/pull/61270) Update engine hash for 1.20.0-7.1.pre (CQ+1, cla: yes, engine)


[61800](https://github.com/flutter/flutter/pull/61800) re-Update engine hash for 1.20.0-7.2.pre, including 12847e8 (CQ+1, cla: yes, engine)


[62444](https://github.com/flutter/flutter/pull/62444) 1.20.0-7.3.pre beta cherrypicks (CQ+1, cla: yes, engine, tool)


### cp: 1.20 - 3 pull request(s)

[61556](https://github.com/flutter/flutter/pull/61556) fix type error in web builds (cla: yes, cp: 1.20, cp: 1.20 completed, framework)


[61760](https://github.com/flutter/flutter/pull/61760) [flutter_tools] revert dart format changes (cla: yes, cp: 1.20, cp: 1.20 completed, tool, waiting for tree to go green)


[62903](https://github.com/flutter/flutter/pull/62903) Revert "remove iOS folder (#61561)" (cp: 1.20, cp: 1.20 completed, engine, framework, team, tool)


### cp: 1.20 completed - 3 pull request(s)

[61556](https://github.com/flutter/flutter/pull/61556) fix type error in web builds (cla: yes, cp: 1.20, cp: 1.20 completed, framework)


[61760](https://github.com/flutter/flutter/pull/61760) [flutter_tools] revert dart format changes (cla: yes, cp: 1.20, cp: 1.20 completed, tool, waiting for tree to go green)


[62903](https://github.com/flutter/flutter/pull/62903) Revert "remove iOS folder (#61561)" (cp: 1.20, cp: 1.20 completed, engine, framework, team, tool)


### a: layout - 3 pull request(s)

[60479](https://github.com/flutter/flutter/pull/60479) Fix tooltip position using correct overlay to calculate render box position. (a: layout, cla: yes, f: material design, framework, waiting for tree to go green)


[62074](https://github.com/flutter/flutter/pull/62074) Fix RenderFlex crossSize for baseline alignment (P3, a: layout, cla: yes, framework, waiting for tree to go green)


[63420](https://github.com/flutter/flutter/pull/63420) fix wrap intrinsic height calculation (a: layout, a: quality, cla: yes, framework, waiting for tree to go green)


### f: routes - 3 pull request(s)

[60640](https://github.com/flutter/flutter/pull/60640) expose route settings for showModalBottomSheet (cla: yes, f: material design, f: routes, framework, waiting for tree to go green)


[61752](https://github.com/flutter/flutter/pull/61752) Allowed specifying reverseTransitionDuration in PageRouteBuilder class (cla: yes, f: routes, framework, waiting for tree to go green)


[63132](https://github.com/flutter/flutter/pull/63132) Fix grammar in Route doc comment (d: api docs, documentation, f: routes, framework, waiting for tree to go green)


### severe: regression - 2 pull request(s)

[62615](https://github.com/flutter/flutter/pull/62615) Fix SliverList scrollOffsetCorrection 0 case (cla: yes, f: scrolling, framework, severe: crash, severe: regression, waiting for tree to go green)


[64268](https://github.com/flutter/flutter/pull/64268) Fix placement for SnackBarBehavior.floating (a: quality, cla: yes, f: material design, framework, severe: regression, waiting for tree to go green)


### customer: money (g3) - 2 pull request(s)

[61048](https://github.com/flutter/flutter/pull/61048) Re-land "Tweaking Material Chip a11y semantics to match buttons (#60141)" (a: accessibility, cla: yes, customer: money (g3), f: material design, framework, waiting for tree to go green)


[64101](https://github.com/flutter/flutter/pull/64101) ScaffoldMessenger (a: quality, cla: yes, customer: money (g3), f: material design, framework, severe: API break, severe: new feature, team, waiting for tree to go green)


### a: images - 2 pull request(s)

[61209](https://github.com/flutter/flutter/pull/61209) Optionally invert oversized images (a: debugging, a: error message, a: images, cla: yes, framework, tool)


[64271](https://github.com/flutter/flutter/pull/64271) Make large jumpTo recommend deferred loading (a: images, cla: yes, f: scrolling, framework, perf: memory, severe: performance, waiting for tree to go green)


### a: fidelity - 2 pull request(s)

[59623](https://github.com/flutter/flutter/pull/59623) Reduce iOS scroll damping for lists with differently sized items (a: fidelity, cla: yes, f: scrolling, framework, platform-ios, waiting for tree to go green)


[60501](https://github.com/flutter/flutter/pull/60501) Make Scrollable's free scroll initial velocity matches that of iOS (a: fidelity, cla: yes, f: scrolling, framework, platform-ios, waiting for tree to go green)


### f: gestures - 2 pull request(s)

[60796](https://github.com/flutter/flutter/pull/60796) Add support in WidgetTester for an array of inputs (a: animation, a: tests, cla: yes, f: gestures, framework)


[64267](https://github.com/flutter/flutter/pull/64267) [framework] make hit slop based on device pointer kind for drag/pan/scale gestures (a: desktop, cla: yes, f: gestures, framework)


### f: inspector - 2 pull request(s)

[60990](https://github.com/flutter/flutter/pull/60990) Use the correct Transform in the WidgetInspector overlay (#59566) (cla: yes, f: inspector, framework, waiting for tree to go green)


[61581](https://github.com/flutter/flutter/pull/61581) Give better error message for describeEnum (a: error message, cla: yes, f: inspector, framework, waiting for tree to go green)


### team: flakes - 2 pull request(s)

[62082](https://github.com/flutter/flutter/pull/62082) Mark flutter_gallery_ios__transition_perf flaky during investigation (cla: yes, platform-ios, team, team: flakes)


[62085](https://github.com/flutter/flutter/pull/62085) Mark smoke_catalina_start_up_ios as not flaky (cla: yes, platform-ios, team, team: flakes, waiting for tree to go green)


### perf: energy - 2 pull request(s)

[63124](https://github.com/flutter/flutter/pull/63124) Measure CPU/GPU with the simple animation test (perf: energy, severe: performance, team, waiting for tree to go green)


[64762](https://github.com/flutter/flutter/pull/64762) Memory benchmark for showing large images in succession (cla: yes, perf: energy, perf: memory, severe: performance, team)


### work in progress; do not review - 2 pull request(s)

[62835](https://github.com/flutter/flutter/pull/62835) 1.20 stable: Update engine hash to 1.20.0 (engine, work in progress; do not review)


[63591](https://github.com/flutter/flutter/pull/63591) 1.20.2 Cherrypicks (a: internationalization, cla: yes, engine, f: material design, framework, team, tool, work in progress; do not review)


### severe: new feature - 2 pull request(s)

[61347](https://github.com/flutter/flutter/pull/61347) [ListTile] adds new properties to customize the tile color (cla: yes, f: material design, framework, severe: new feature, waiting for tree to go green)


[64101](https://github.com/flutter/flutter/pull/64101) ScaffoldMessenger (a: quality, cla: yes, customer: money (g3), f: material design, framework, severe: API break, severe: new feature, team, waiting for tree to go green)


### platform-fuchsia - 2 pull request(s)

[60558](https://github.com/flutter/flutter/pull/60558) Pointer event resampler (#41118) (cla: yes, f: scrolling, framework, platform-android, platform-fuchsia, platform-ios, waiting for tree to go green)


[64670](https://github.com/flutter/flutter/pull/64670) [fuchsia] Sync run test script with engine version (cla: yes, platform-fuchsia, team, team: infra, waiting for tree to go green)


### a: debugging - 2 pull request(s)

[61209](https://github.com/flutter/flutter/pull/61209) Optionally invert oversized images (a: debugging, a: error message, a: images, cla: yes, framework, tool)


[61579](https://github.com/flutter/flutter/pull/61579) Remove unused FlutterErrorDetails subclasses (a: debugging, a: error message, a: quality, a: tests, cla: yes, framework, waiting for tree to go green)


### platform-windows - 2 pull request(s)

[62999](https://github.com/flutter/flutter/pull/62999) Add flutter_engine.cc to Windows wrapper build (a: desktop, platform-windows, tool, waiting for tree to go green)


[63707](https://github.com/flutter/flutter/pull/63707) Surface Windows build errors in non-verbose mode (a: build, a: desktop, cla: yes, platform-windows, tool, waiting for tree to go green)


### perf: memory - 2 pull request(s)

[64271](https://github.com/flutter/flutter/pull/64271) Make large jumpTo recommend deferred loading (a: images, cla: yes, f: scrolling, framework, perf: memory, severe: performance, waiting for tree to go green)


[64762](https://github.com/flutter/flutter/pull/64762) Memory benchmark for showing large images in succession (cla: yes, perf: energy, perf: memory, severe: performance, team)


### platform-android - 1 pull request(s)

[60558](https://github.com/flutter/flutter/pull/60558) Pointer event resampler (#41118) (cla: yes, f: scrolling, framework, platform-android, platform-fuchsia, platform-ios, waiting for tree to go green)


### f: focus - 1 pull request(s)

[61756](https://github.com/flutter/flutter/pull/61756) Fix `ExcludeFocus` so it won't refocus a sibling of the focused node. (cla: yes, f: focus, framework, waiting for tree to go green)


### customer: google - 1 pull request(s)

[64750](https://github.com/flutter/flutter/pull/64750) Allow for arbitrary placement in SliverGrid (cla: yes, customer: google, f: scrolling, framework, waiting for tree to go green)


### t: flutter doctor - 1 pull request(s)

[61585](https://github.com/flutter/flutter/pull/61585)  Show device diagnostic messages in doctor (cla: yes, t: flutter doctor, team, tool, waiting for tree to go green)


### a: triage improvements - 1 pull request(s)

[62904](https://github.com/flutter/flutter/pull/62904) ISSUE_TEMPLATE changes (a: triage improvements, framework, team, waiting for tree to go green)


### targeted to release: 1.20 - 1 pull request(s)

[61561](https://github.com/flutter/flutter/pull/61561) [flutter_tool] remove no-op iOS folder when creating plugins. (cla: yes, targeted to release: 1.20, tool)


### a: platform-views - 1 pull request(s)

[61667](https://github.com/flutter/flutter/pull/61667) Add tests for platform views' hover behavior  (a: mouse, a: platform-views, cla: yes, framework)


### a: null-safety - 1 pull request(s)

[62951](https://github.com/flutter/flutter/pull/62951) migrate part of painting to nullsafety (a: null-safety, framework, waiting for tree to go green)


### a: build - 1 pull request(s)

[63707](https://github.com/flutter/flutter/pull/63707) Surface Windows build errors in non-verbose mode (a: build, a: desktop, cla: yes, platform-windows, tool, waiting for tree to go green)


### waiting for customer response - 1 pull request(s)

[64745](https://github.com/flutter/flutter/pull/64745) [flutter_tools] rethrow process exceptions as tool exit from gradle build (cla: yes, tool, waiting for customer response)


### P3 - 1 pull request(s)

[62074](https://github.com/flutter/flutter/pull/62074) Fix RenderFlex crossSize for baseline alignment (P3, a: layout, cla: yes, framework, waiting for tree to go green)


### severe: crash - 1 pull request(s)

[62615](https://github.com/flutter/flutter/pull/62615) Fix SliverList scrollOffsetCorrection 0 case (cla: yes, f: scrolling, framework, severe: crash, severe: regression, waiting for tree to go green)



## Merged PRs by labels for `flutter/engine` 




### platform-android - 71 pull request(s)

[18339](https://github.com/flutter/engine/pull/18339) Use Android R (API 30) getInsets() to compute padding (cla: yes, platform-android)


[18643](https://github.com/flutter/engine/pull/18643) Add autofill save for iOS and Android (cla: yes, platform-android, platform-ios)


[18984](https://github.com/flutter/engine/pull/18984) bool SubmitFrame -> void SubmitFrame (cla: yes, platform-android, platform-ios, waiting for tree to go green)


[19024](https://github.com/flutter/engine/pull/19024) Implement delayed event synthesis key event handling for Android (affects: desktop, affects: engine, affects: framework, cla: yes, platform-android)


[19059](https://github.com/flutter/engine/pull/19059) Update Androidx import (cla: yes, platform-android, waiting for tree to go green)


[19501](https://github.com/flutter/engine/pull/19501) Fix NullPointerException in FlutterTextView (cla: yes, platform-android, waiting for tree to go green)


[19550](https://github.com/flutter/engine/pull/19550) Add all system cursors (engine) (cla: yes, platform-android)


[19558](https://github.com/flutter/engine/pull/19558) [Android] Prevent listener from calling JNI after detach (cla: yes, crash, platform-android)


[19583](https://github.com/flutter/engine/pull/19583) fuchsia: Enable most unittests (affects: tests, cla: yes, code health, platform-android, platform-fuchsia)


[19620](https://github.com/flutter/engine/pull/19620) [android] Pass synthesized eventType to VirtualDisplay platform views and fix memory leak (cla: yes, platform-android, waiting for tree to go green)


[19623](https://github.com/flutter/engine/pull/19623) fix FlutterViewUpdateCustomAccessibilityActions uses correct string list (cla: yes, platform-android)


[19653](https://github.com/flutter/engine/pull/19653) 1.20.0-7.1.pre engine CPs (platform-android)


[19662](https://github.com/flutter/engine/pull/19662) [android] Childview will process its motion events (cla: yes, platform-android)


[19700](https://github.com/flutter/engine/pull/19700) Fixes typo in android_context_gl.h (cla: yes, platform-android)


[19702](https://github.com/flutter/engine/pull/19702) Prevent that removeActivityResultListener() is causing an ConcurrentModificationException (cla: yes, platform-android)


[19717](https://github.com/flutter/engine/pull/19717) Add flag to indicate whether the platform supports state restoration (cla: yes, platform-android)


[19776](https://github.com/flutter/engine/pull/19776) 1.20.0-7.2.pre engine cherrypicks (cla: yes, platform-android)


[19848](https://github.com/flutter/engine/pull/19848) Cherry pick 3d104f43649d333492dfa792968c8a09af93a84c (cla: yes, platform-android, platform-ios)


[19860](https://github.com/flutter/engine/pull/19860) Support talkback in hybrid composition (cla: yes, platform-android, waiting for tree to go green)


[19864](https://github.com/flutter/engine/pull/19864) 1.20.0-7.2.pre: CP 12847e899e080104365f93843c25a3b3b5648895 (cla: yes, platform-android)


[19895](https://github.com/flutter/engine/pull/19895) Made the linter print out more information in its output and fixed bugs (cla: yes, platform-android)


[19956](https://github.com/flutter/engine/pull/19956) Revert "Implement delayed event synthesis key event handling for Android (#19024)" (cla: yes, platform-android)


[19962](https://github.com/flutter/engine/pull/19962) Use the GrDirectContext factories instead of deprecated GrContext ones (cla: yes, platform-android, platform-ios)


[19968](https://github.com/flutter/engine/pull/19968) Add missing MouseCursorPlugin destroy call (cla: yes, perf: memory, platform-android, waiting for tree to go green)


[19972](https://github.com/flutter/engine/pull/19972) Remove android view from the Mutator stack (cla: yes, platform-android)


[19986](https://github.com/flutter/engine/pull/19986) 1.20.0 CP: Remove android view from the Mutator stack (#19972) (cla: yes, platform-android)


[20092](https://github.com/flutter/engine/pull/20092) Manual roll of Dart from 24c7666def...40fd1c456e (cla: yes, platform-android, platform-ios)


[20100](https://github.com/flutter/engine/pull/20100) Wait before switching surfaces (cla: yes, platform-android, waiting for tree to go green)


[20139](https://github.com/flutter/engine/pull/20139) Add ALERT SoundType enum value (cla: yes, platform-android)


[20144](https://github.com/flutter/engine/pull/20144) Add TextInput sendAppPrivateCommand to Flutter Engine (cla: yes, platform-android)


[20180](https://github.com/flutter/engine/pull/20180) 1.20 CP: Wait before switching surfaces (#20100) (cla: yes, platform-android)


[20188](https://github.com/flutter/engine/pull/20188) Add TextInput performPrivateCommand to Flutter Engine (cla: yes, platform-android)


[20218](https://github.com/flutter/engine/pull/20218) Plumbing for setting domain network policy (cla: yes, platform-android, platform-ios)


[20238](https://github.com/flutter/engine/pull/20238) 1.20 CP: fix FlutterViewUpdateCustomAccessibilityActions uses correct string list (cla: yes, platform-android)


[20245](https://github.com/flutter/engine/pull/20245) Add FlutterFragmentActivity#getRenderMode() (cla: yes, platform-android, waiting for tree to go green)


[20280](https://github.com/flutter/engine/pull/20280) Reporting back native stacktrace to dart side for crash reporting. (cla: yes, platform-android, waiting for tree to go green)


[20303](https://github.com/flutter/engine/pull/20303) android_external_texture: Use the available GrDirectContext arg (cla: yes, platform-android)


[20393](https://github.com/flutter/engine/pull/20393) hasStrings on Android (cla: yes, platform-android)


[20486](https://github.com/flutter/engine/pull/20486) Remove the dummy rasterizer delegate now that flutter_runner is in tree, and cleanup ctor params (cla: yes, platform-android, platform-fuchsia, platform-ios, waiting for tree to go green)


[20500](https://github.com/flutter/engine/pull/20500) Create PlatformView instance right after method channel call from Dart (cla: yes, platform-android, waiting for tree to go green)


[20505](https://github.com/flutter/engine/pull/20505) Add missing nullable annotation (cla: yes, platform-android, waiting for tree to go green)


[20516](https://github.com/flutter/engine/pull/20516) Missing default focus when navigating to a page with no SemanticsNode that sets namesRoute:true (cla: yes, platform-android, waiting for tree to go green)


[20564](https://github.com/flutter/engine/pull/20564) Revert "Create PlatformView instance right after method channel call from Dart (#20500)" (cla: yes, platform-android)


[20568](https://github.com/flutter/engine/pull/20568) Reland: Create PlatformView instance right after method channel call from Dart (cla: yes, platform-android, platform-ios)


[20610](https://github.com/flutter/engine/pull/20610) Release the AccessibilityBridge when destroying a legacy FlutterView (cla: yes, platform-android, waiting for tree to go green)


[20617](https://github.com/flutter/engine/pull/20617) [embedder] Add FBO callback that takes frame info (cla: yes, platform-android, platform-ios, waiting for tree to go green)


[20622](https://github.com/flutter/engine/pull/20622) Fix NPE in PlatformViewsController.checkInputConnectionProxy (cla: yes, platform-android)


[20672](https://github.com/flutter/engine/pull/20672) [embedder] Add gl present callback that takes present info (cla: yes, platform-android, platform-ios, waiting for tree to go green)


[20701](https://github.com/flutter/engine/pull/20701) Ignore calls to AccessibilityBridge listeners after release (cla: yes, platform-android)


[20722](https://github.com/flutter/engine/pull/20722) Enable hybrid composition by default on Android (cla: yes, platform-android)


[20733](https://github.com/flutter/engine/pull/20733) Pass platform configuration to Dart VM for insecure socket policy (cla: yes, platform-android, platform-ios, waiting for tree to go green)


[20735](https://github.com/flutter/engine/pull/20735) Fix EGL_BAD_SURFACE when app is paused (cla: yes, platform-android)


[20736](https://github.com/flutter/engine/pull/20736) Reland: Implement delayed event synthesis key event handling for Android (cla: yes, platform-android)


[20745](https://github.com/flutter/engine/pull/20745) Revert "Enable hybrid composition by default on Android" (cla: yes, platform-android)


[20769](https://github.com/flutter/engine/pull/20769) Let FlutterActivity/Fragment/FragmentActivity have an app bundle path override instead of eager resolving during construction (cla: yes, platform-android)


[20789](https://github.com/flutter/engine/pull/20789) Add a java injector for testing (cla: yes, platform-android)


[20797](https://github.com/flutter/engine/pull/20797) Flutter Engine Beta 1.21.0-9.2.pre cherry picks (cla: yes, platform-android, platform-ios)


[20800](https://github.com/flutter/engine/pull/20800) Add ability to disable the raster thread merger (cla: yes, platform-android)


[20812](https://github.com/flutter/engine/pull/20812) Revert "Pass platform configuration to Dart VM for insecure socket policy" (cla: yes, platform-android, platform-ios)


[20818](https://github.com/flutter/engine/pull/20818) Revert "Pass platform configuration to Dart VM for insecure socket po… (cla: yes, platform-android, platform-ios)


[20829](https://github.com/flutter/engine/pull/20829) Reland "Pass platform configuration to Dart VM for insecure socket policy" (cla: yes, platform-android, platform-ios)


[20838](https://github.com/flutter/engine/pull/20838) Flutter 1.20.3 engine cherrypicks (cla: yes, platform-android, platform-ios)


[20842](https://github.com/flutter/engine/pull/20842) Ensure all images are closed in FlutterImageView (cla: yes, platform-android)


[20843](https://github.com/flutter/engine/pull/20843) [Android R] Sync keyboard animation with view insets vs Android 11/R/API 30 WindowInsetsAnimation (affects: engine, affects: text input, cla: yes, platform-android)


[20864](https://github.com/flutter/engine/pull/20864) Reland: Enable hybrid composition by default on Android (#20722) (cla: yes, platform-android)


[20865](https://github.com/flutter/engine/pull/20865) Add auto plugin registration to FlutterFragmentActivity as well (cla: yes, platform-android)


[20912](https://github.com/flutter/engine/pull/20912) Pass text input key events to the EventResponder if they do not yield characters (cla: yes, platform-android)


[20916](https://github.com/flutter/engine/pull/20916) Ensure the destructor is called since it destroys the `EGLSurface` before creating a new onscreen surface. (cla: yes, platform-android)


[20921](https://github.com/flutter/engine/pull/20921) [Android R] Integrate DisplayCutouts into viewportMetrics (cla: yes, platform-android, waiting for tree to go green)


[20922](https://github.com/flutter/engine/pull/20922) Increase thread priority before engine init (cla: yes, perf: speed, platform-android, severe: performance)


[21025](https://github.com/flutter/engine/pull/21025) Update Android SDK to 30r3 (cla: yes, platform-android)


### platform-ios - 47 pull request(s)

[18643](https://github.com/flutter/engine/pull/18643) Add autofill save for iOS and Android (cla: yes, platform-android, platform-ios)


[18984](https://github.com/flutter/engine/pull/18984) bool SubmitFrame -> void SubmitFrame (cla: yes, platform-android, platform-ios, waiting for tree to go green)


[19267](https://github.com/flutter/engine/pull/19267) Annotate valuePublishedByPlugin with nullable (cla: yes, platform-ios, waiting for tree to go green)


[19458](https://github.com/flutter/engine/pull/19458) Added the ability to set properties in interface builder for FlutterViewController (cla: yes, platform-ios)


[19684](https://github.com/flutter/engine/pull/19684) Refactor initial route code (cla: yes, platform-ios)


[19728](https://github.com/flutter/engine/pull/19728) Fix Mac / iOS builds (cla: yes, platform-ios)


[19785](https://github.com/flutter/engine/pull/19785) Fix loss of negative text selection ranges (cla: yes, platform-ios)


[19788](https://github.com/flutter/engine/pull/19788) Makes IOS dispatch showOnCcreen action for header semantics nodes (cla: yes, platform-ios, waiting for tree to go green)


[19819](https://github.com/flutter/engine/pull/19819) remove obsolete check on FlutterPlatformViewsController::OnCreate (cla: yes, platform-ios, waiting for tree to go green)


[19826](https://github.com/flutter/engine/pull/19826) fix On iOS, dialog titles are announced twice (cla: yes, platform-ios)


[19848](https://github.com/flutter/engine/pull/19848) Cherry pick 3d104f43649d333492dfa792968c8a09af93a84c (cla: yes, platform-android, platform-ios)


[19859](https://github.com/flutter/engine/pull/19859) Clipboard hasStrings method on iOS (cla: yes, platform-ios, waiting for tree to go green)


[19919](https://github.com/flutter/engine/pull/19919) Ensure threads are merged when tearing down the Rasterizer (cla: yes, platform-ios, waiting for tree to go green)


[19962](https://github.com/flutter/engine/pull/19962) Use the GrDirectContext factories instead of deprecated GrContext ones (cla: yes, platform-android, platform-ios)


[20050](https://github.com/flutter/engine/pull/20050) Use a single mask view to clip platform view (cla: yes, platform-ios)


[20082](https://github.com/flutter/engine/pull/20082) Ios nv12 external texture (cla: yes, platform-ios)


[20092](https://github.com/flutter/engine/pull/20092) Manual roll of Dart from 24c7666def...40fd1c456e (cla: yes, platform-android, platform-ios)


[20127](https://github.com/flutter/engine/pull/20127) [iOS] Fixes text input plugin crash (cla: yes, platform-ios)


[20167](https://github.com/flutter/engine/pull/20167) fix ios layout change cause the accessibility focus to jump randomly. (cla: yes, platform-ios)


[20181](https://github.com/flutter/engine/pull/20181) Fix iOS Keyboard stuck as UIKeyboardTypeNamePhonePad (cla: yes, platform-ios)


[20218](https://github.com/flutter/engine/pull/20218) Plumbing for setting domain network policy (cla: yes, platform-android, platform-ios)


[20348](https://github.com/flutter/engine/pull/20348) [iOS TextInput] Fixes selection clamping & composing range change logic (cla: yes, platform-ios)


[20446](https://github.com/flutter/engine/pull/20446) Engine 1.20.2 cherrypicks (cla: yes, platform-ios)


[20450](https://github.com/flutter/engine/pull/20450) Revert "Refactor initial route code (#19684)" (cla: yes, platform-ios)


[20468](https://github.com/flutter/engine/pull/20468) Refactor initial route code take 2 (cla: yes, platform-ios)


[20486](https://github.com/flutter/engine/pull/20486) Remove the dummy rasterizer delegate now that flutter_runner is in tree, and cleanup ctor params (cla: yes, platform-android, platform-fuchsia, platform-ios, waiting for tree to go green)


[20487](https://github.com/flutter/engine/pull/20487) Only create raster_thread_merge when explicitly requested by the embedding platform (cla: yes, platform-ios, waiting for tree to go green)


[20492](https://github.com/flutter/engine/pull/20492) Enable iOS plumbing for network security and add tests (cla: yes, platform-ios)


[20522](https://github.com/flutter/engine/pull/20522) Fixed the accessibility ios unit tests by sending in mock view controllers instead of views. (cla: yes, platform-ios)


[20542](https://github.com/flutter/engine/pull/20542) Started stubbing in the FlutterView property of the mock FlutterViewControllers (cla: yes, platform-ios)


[20568](https://github.com/flutter/engine/pull/20568) Reland: Create PlatformView instance right after method channel call from Dart (cla: yes, platform-android, platform-ios)


[20617](https://github.com/flutter/engine/pull/20617) [embedder] Add FBO callback that takes frame info (cla: yes, platform-android, platform-ios, waiting for tree to go green)


[20671](https://github.com/flutter/engine/pull/20671) Enable ios platform view by default (cla: yes, platform-ios, waiting for tree to go green)


[20672](https://github.com/flutter/engine/pull/20672) [embedder] Add gl present callback that takes present info (cla: yes, platform-android, platform-ios, waiting for tree to go green)


[20700](https://github.com/flutter/engine/pull/20700) Avoid passing nil to IOS accessibility announcement  (cla: yes, platform-ios, waiting for tree to go green)


[20708](https://github.com/flutter/engine/pull/20708) The `ForwardingGestureRecognizers` to have back reference to the `PlatformViewsController` so it can access `FlutterViewController` when its available  (cla: yes, platform-ios, waiting for tree to go green)


[20733](https://github.com/flutter/engine/pull/20733) Pass platform configuration to Dart VM for insecure socket policy (cla: yes, platform-android, platform-ios, waiting for tree to go green)


[20797](https://github.com/flutter/engine/pull/20797) Flutter Engine Beta 1.21.0-9.2.pre cherry picks (cla: yes, platform-android, platform-ios)


[20805](https://github.com/flutter/engine/pull/20805) Fix iOS text field input keyboard flickering & crash (cla: yes, platform-ios, waiting for tree to go green)


[20812](https://github.com/flutter/engine/pull/20812) Revert "Pass platform configuration to Dart VM for insecure socket policy" (cla: yes, platform-android, platform-ios)


[20818](https://github.com/flutter/engine/pull/20818) Revert "Pass platform configuration to Dart VM for insecure socket po… (cla: yes, platform-android, platform-ios)


[20829](https://github.com/flutter/engine/pull/20829) Reland "Pass platform configuration to Dart VM for insecure socket policy" (cla: yes, platform-android, platform-ios)


[20838](https://github.com/flutter/engine/pull/20838) Flutter 1.20.3 engine cherrypicks (cla: yes, platform-android, platform-ios)


[20960](https://github.com/flutter/engine/pull/20960) Started printing out error messages when the observatory won't be reachable because of permissions problems. (cla: yes, platform-ios)


[20980](https://github.com/flutter/engine/pull/20980) Avoid crashing and display error if the process cannot be prepared for JIT mode Dart VM. (cla: yes, platform-ios)


[20991](https://github.com/flutter/engine/pull/20991) Tweak the mdns error message (cla: yes, platform-ios)


[21029](https://github.com/flutter/engine/pull/21029) Fixed ios layout change to not refocus semantics object if the focus … (cla: yes, platform-ios)


### platform-fuchsia - 19 pull request(s)

[19396](https://github.com/flutter/engine/pull/19396) fuchsia: Remove dead code / break dependencies (affects: engine, cla: yes, code health, platform-fuchsia)


[19583](https://github.com/flutter/engine/pull/19583) fuchsia: Enable most unittests (affects: tests, cla: yes, code health, platform-android, platform-fuchsia)


[19584](https://github.com/flutter/engine/pull/19584) fuchsia: create new flutter_runner render path (affects: engine, cla: yes, platform-fuchsia)


[19792](https://github.com/flutter/engine/pull/19792) fuchsia: Allow setting thread-name (cla: yes, platform-fuchsia)


[19794](https://github.com/flutter/engine/pull/19794) Fix targets param in build_fuchsia_artifacts (cla: yes, platform-fuchsia)


[20343](https://github.com/flutter/engine/pull/20343) Dedupe sources for fuchsia shell/tests (cla: yes, platform-fuchsia)


[20422](https://github.com/flutter/engine/pull/20422) Fix broken shell_unittests on Fuchsia (affects: tests, cla: yes, platform-fuchsia)


[20427](https://github.com/flutter/engine/pull/20427) Add --unoptimized and --asan to Fuchsia builds (cla: yes, platform-fuchsia)


[20486](https://github.com/flutter/engine/pull/20486) Remove the dummy rasterizer delegate now that flutter_runner is in tree, and cleanup ctor params (cla: yes, platform-android, platform-fuchsia, platform-ios, waiting for tree to go green)


[20532](https://github.com/flutter/engine/pull/20532) Reland: "fuchsia: Remove dead code / break dependencies" (affects: engine, cla: yes, code health, platform-fuchsia)


[20638](https://github.com/flutter/engine/pull/20638) Update view attributes after creation (affects: engine, cla: yes, platform-fuchsia, waiting for tree to go green)


[20647](https://github.com/flutter/engine/pull/20647) fuchsia: Convert legacy permutations to build flag (affects: engine, affects: tests, cla: yes, code health, platform-fuchsia)


[20681](https://github.com/flutter/engine/pull/20681) fuchsia: Fix elevation issues (affects: engine, cla: yes, platform-fuchsia)


[20697](https://github.com/flutter/engine/pull/20697) fuchsia: Disable flaky test (affects: tests, cla: yes, platform-fuchsia)


[20699](https://github.com/flutter/engine/pull/20699) fuchsia: Rollback broken SDK and re-enable test (affects: tests, cla: yes, platform-fuchsia)


[20704](https://github.com/flutter/engine/pull/20704) fuchsia: Clean shell_unittests under FEMU (affects: tests, cla: yes, platform-fuchsia)


[20761](https://github.com/flutter/engine/pull/20761) fuchsia: Call out legacy rasterizer code (affects: engine, cla: yes, platform-fuchsia)


[20798](https://github.com/flutter/engine/pull/20798) [fuchsia] Link to SDK version of script (cla: yes, platform-fuchsia, waiting for tree to go green)


[20984](https://github.com/flutter/engine/pull/20984) fuchsia: Compile disabled RasterThreadMerger code (affects: tests, cla: yes, platform-fuchsia, waiting for tree to go green)


### platform-web - 14 pull request(s)

[19610](https://github.com/flutter/engine/pull/19610) [web][2/3] Implement rules of the line break algorithm (cla: yes, platform-web, waiting for tree to go green)


[19632](https://github.com/flutter/engine/pull/19632) Fixing synthesizing keys for multiple keys pressed down on flutter web (cla: yes, platform-web, waiting for tree to go green)


[19745](https://github.com/flutter/engine/pull/19745) [web][3/3] Handle surrogate during line break detection (cla: yes, platform-web)


[19787](https://github.com/flutter/engine/pull/19787) [web] Improve perf and code size of line breaker (cla: yes, platform-web, waiting for tree to go green)


[19846](https://github.com/flutter/engine/pull/19846) [web] Cache line break property lookups (cla: yes, platform-web)


[19924](https://github.com/flutter/engine/pull/19924) [web] Enable canvas measurement by default (cla: yes, platform-web)


[20067](https://github.com/flutter/engine/pull/20067) [web] Set correct defaults for text in canvas (cla: yes, platform-web)


[20208](https://github.com/flutter/engine/pull/20208) [web] Include trailing spaces in text box measurements (cla: yes, platform-web)


[20276](https://github.com/flutter/engine/pull/20276) [web] Implement support for WidgetSpan (aka paragraph placeholders) (cla: yes, platform-web)


[20278](https://github.com/flutter/engine/pull/20278) [web] Eagerly calculate relevant indices during line break detection (cla: yes, platform-web)


[20520](https://github.com/flutter/engine/pull/20520) [web] Prepare for read-only input fields (affects: text input, cla: yes, platform-web, waiting for tree to go green)


[20747](https://github.com/flutter/engine/pull/20747) [web] Make word boundary consistent with native flutter (cla: yes, platform-web)


[20767](https://github.com/flutter/engine/pull/20767) [web] Better format for line break tests (affects: tests, cla: yes, platform-web, waiting for tree to go green)


[20841](https://github.com/flutter/engine/pull/20841) [web] Change code locations for engine unit tests (cla: yes, platform-web)


### affects: engine - 10 pull request(s)

[19024](https://github.com/flutter/engine/pull/19024) Implement delayed event synthesis key event handling for Android (affects: desktop, affects: engine, affects: framework, cla: yes, platform-android)


[19396](https://github.com/flutter/engine/pull/19396) fuchsia: Remove dead code / break dependencies (affects: engine, cla: yes, code health, platform-fuchsia)


[19584](https://github.com/flutter/engine/pull/19584) fuchsia: create new flutter_runner render path (affects: engine, cla: yes, platform-fuchsia)


[19983](https://github.com/flutter/engine/pull/19983) Make EncodableValue a thin std::variant wrapper (affects: engine, cla: yes, glfw, platform-windows)


[20532](https://github.com/flutter/engine/pull/20532) Reland: "fuchsia: Remove dead code / break dependencies" (affects: engine, cla: yes, code health, platform-fuchsia)


[20638](https://github.com/flutter/engine/pull/20638) Update view attributes after creation (affects: engine, cla: yes, platform-fuchsia, waiting for tree to go green)


[20647](https://github.com/flutter/engine/pull/20647) fuchsia: Convert legacy permutations to build flag (affects: engine, affects: tests, cla: yes, code health, platform-fuchsia)


[20681](https://github.com/flutter/engine/pull/20681) fuchsia: Fix elevation issues (affects: engine, cla: yes, platform-fuchsia)


[20761](https://github.com/flutter/engine/pull/20761) fuchsia: Call out legacy rasterizer code (affects: engine, cla: yes, platform-fuchsia)


[20843](https://github.com/flutter/engine/pull/20843) [Android R] Sync keyboard animation with view insets vs Android 11/R/API 30 WindowInsetsAnimation (affects: engine, affects: text input, cla: yes, platform-android)


### affects: desktop - 9 pull request(s)

[19024](https://github.com/flutter/engine/pull/19024) Implement delayed event synthesis key event handling for Android (affects: desktop, affects: engine, affects: framework, cla: yes, platform-android)


[19597](https://github.com/flutter/engine/pull/19597) Desktop embedder ComputePlatformResolvedLocale entrypoint (affects: desktop, cla: yes)


[19896](https://github.com/flutter/engine/pull/19896) [windows] Separate the engine from the view (affects: desktop, cla: yes, platform-windows)


[20455](https://github.com/flutter/engine/pull/20455) Send locale information in the Windows embedding (affects: desktop, cla: yes, platform-windows)


[20461](https://github.com/flutter/engine/pull/20461) Send locale information in the macOS embedding (affects: desktop, cla: yes, platform-macos)


[20613](https://github.com/flutter/engine/pull/20613) [windows] Allow delegation of top-level WindowProc (affects: desktop, cla: yes, platform-windows)


[20662](https://github.com/flutter/engine/pull/20662) [windows] Mostly eliminate the state structs (affects: desktop, cla: yes, platform-windows)


[20668](https://github.com/flutter/engine/pull/20668) [windows] Add horizontal scroll support (affects: desktop, cla: yes, platform-windows)


[20760](https://github.com/flutter/engine/pull/20760) Default C++ wrapper templates to EncodableValue (affects: desktop, cla: yes, platform-windows)


### affects: tests - 8 pull request(s)

[19583](https://github.com/flutter/engine/pull/19583) fuchsia: Enable most unittests (affects: tests, cla: yes, code health, platform-android, platform-fuchsia)


[20422](https://github.com/flutter/engine/pull/20422) Fix broken shell_unittests on Fuchsia (affects: tests, cla: yes, platform-fuchsia)


[20647](https://github.com/flutter/engine/pull/20647) fuchsia: Convert legacy permutations to build flag (affects: engine, affects: tests, cla: yes, code health, platform-fuchsia)


[20697](https://github.com/flutter/engine/pull/20697) fuchsia: Disable flaky test (affects: tests, cla: yes, platform-fuchsia)


[20699](https://github.com/flutter/engine/pull/20699) fuchsia: Rollback broken SDK and re-enable test (affects: tests, cla: yes, platform-fuchsia)


[20704](https://github.com/flutter/engine/pull/20704) fuchsia: Clean shell_unittests under FEMU (affects: tests, cla: yes, platform-fuchsia)


[20767](https://github.com/flutter/engine/pull/20767) [web] Better format for line break tests (affects: tests, cla: yes, platform-web, waiting for tree to go green)


[20984](https://github.com/flutter/engine/pull/20984) fuchsia: Compile disabled RasterThreadMerger code (affects: tests, cla: yes, platform-fuchsia, waiting for tree to go green)


### platform-windows - 7 pull request(s)

[19896](https://github.com/flutter/engine/pull/19896) [windows] Separate the engine from the view (affects: desktop, cla: yes, platform-windows)


[19983](https://github.com/flutter/engine/pull/19983) Make EncodableValue a thin std::variant wrapper (affects: engine, cla: yes, glfw, platform-windows)


[20455](https://github.com/flutter/engine/pull/20455) Send locale information in the Windows embedding (affects: desktop, cla: yes, platform-windows)


[20613](https://github.com/flutter/engine/pull/20613) [windows] Allow delegation of top-level WindowProc (affects: desktop, cla: yes, platform-windows)


[20662](https://github.com/flutter/engine/pull/20662) [windows] Mostly eliminate the state structs (affects: desktop, cla: yes, platform-windows)


[20668](https://github.com/flutter/engine/pull/20668) [windows] Add horizontal scroll support (affects: desktop, cla: yes, platform-windows)


[20760](https://github.com/flutter/engine/pull/20760) Default C++ wrapper templates to EncodableValue (affects: desktop, cla: yes, platform-windows)


### code health - 4 pull request(s)

[19396](https://github.com/flutter/engine/pull/19396) fuchsia: Remove dead code / break dependencies (affects: engine, cla: yes, code health, platform-fuchsia)


[19583](https://github.com/flutter/engine/pull/19583) fuchsia: Enable most unittests (affects: tests, cla: yes, code health, platform-android, platform-fuchsia)


[20532](https://github.com/flutter/engine/pull/20532) Reland: "fuchsia: Remove dead code / break dependencies" (affects: engine, cla: yes, code health, platform-fuchsia)


[20647](https://github.com/flutter/engine/pull/20647) fuchsia: Convert legacy permutations to build flag (affects: engine, affects: tests, cla: yes, code health, platform-fuchsia)


### severe: performance - 4 pull request(s)

[20003](https://github.com/flutter/engine/pull/20003) Reland: Avoid a copy in EncodeImage (cla: yes, perf: speed, severe: performance)


[20142](https://github.com/flutter/engine/pull/20142) Create root isolate asynchronously (cla: yes, perf: speed, severe: performance)


[20466](https://github.com/flutter/engine/pull/20466) Add a service protocol for raster cache memory (cla: yes, perf: memory, severe: performance)


[20922](https://github.com/flutter/engine/pull/20922) Increase thread priority before engine init (cla: yes, perf: speed, platform-android, severe: performance)


### perf: speed - 3 pull request(s)

[20003](https://github.com/flutter/engine/pull/20003) Reland: Avoid a copy in EncodeImage (cla: yes, perf: speed, severe: performance)


[20142](https://github.com/flutter/engine/pull/20142) Create root isolate asynchronously (cla: yes, perf: speed, severe: performance)


[20922](https://github.com/flutter/engine/pull/20922) Increase thread priority before engine init (cla: yes, perf: speed, platform-android, severe: performance)


### affects: text input - 2 pull request(s)

[20520](https://github.com/flutter/engine/pull/20520) [web] Prepare for read-only input fields (affects: text input, cla: yes, platform-web, waiting for tree to go green)


[20843](https://github.com/flutter/engine/pull/20843) [Android R] Sync keyboard animation with view insets vs Android 11/R/API 30 WindowInsetsAnimation (affects: engine, affects: text input, cla: yes, platform-android)


### perf: memory - 2 pull request(s)

[19968](https://github.com/flutter/engine/pull/19968) Add missing MouseCursorPlugin destroy call (cla: yes, perf: memory, platform-android, waiting for tree to go green)


[20466](https://github.com/flutter/engine/pull/20466) Add a service protocol for raster cache memory (cla: yes, perf: memory, severe: performance)


### Work in progress (WIP) - 1 pull request(s)

[20187](https://github.com/flutter/engine/pull/20187) Enable more linting (Work in progress (WIP), cla: yes)


### affects: docs - 1 pull request(s)

[20176](https://github.com/flutter/engine/pull/20176) update nullability of drawAtlas methods and flesh out docs (affects: docs, cla: yes, waiting for tree to go green)


### affects: framework - 1 pull request(s)

[19024](https://github.com/flutter/engine/pull/19024) Implement delayed event synthesis key event handling for Android (affects: desktop, affects: engine, affects: framework, cla: yes, platform-android)


### crash - 1 pull request(s)

[19558](https://github.com/flutter/engine/pull/19558) [Android] Prevent listener from calling JNI after detach (cla: yes, crash, platform-android)


### glfw - 1 pull request(s)

[19983](https://github.com/flutter/engine/pull/19983) Make EncodableValue a thin std::variant wrapper (affects: engine, cla: yes, glfw, platform-windows)


### platform-macos - 1 pull request(s)

[20461](https://github.com/flutter/engine/pull/20461) Send locale information in the macOS embedding (affects: desktop, cla: yes, platform-macos)



## Merged PRs by labels for `flutter/plugins` 




### waiting for test harness - 14 pull request(s)

[2873](https://github.com/flutter/plugins/pull/2873) [e2e] add support to report extra information (cla: yes, waiting for test harness)


[2904](https://github.com/flutter/plugins/pull/2904) [web] Adding capability to e2e to take screenshot for web tests. (cla: yes, waiting for test harness)


[2906](https://github.com/flutter/plugins/pull/2906) [e2e] Add new e2e_driver for handling response data and performance watcher (waiting for test harness)


[2917](https://github.com/flutter/plugins/pull/2917) [e2e] revert performance tracker utilities (waiting for test harness)


[2923](https://github.com/flutter/plugins/pull/2923) [device_info] Changed directory of device_info (cla: yes, waiting for test harness)


[2929](https://github.com/flutter/plugins/pull/2929) [device_info] Platform interface added in device_info (cla: yes, waiting for test harness)


[2942](https://github.com/flutter/plugins/pull/2942) [device_info] Port device_info to use platform interface (cla: yes, waiting for test harness)


[2944](https://github.com/flutter/plugins/pull/2944) [battery] Updated README.md (cla: yes, waiting for test harness)


[2945](https://github.com/flutter/plugins/pull/2945) [google_maps_flutter_web] Port e2e tests to integration_test package. (cla: yes, waiting for test harness)


[2947](https://github.com/flutter/plugins/pull/2947) [integration_test] add support to get timeline (cla: yes, waiting for test harness)


[2974](https://github.com/flutter/plugins/pull/2974) [url_launcher_platform_interface] Add webOnlyWindowName parameter to launch() (cla: yes, waiting for test harness)


[2984](https://github.com/flutter/plugins/pull/2984) [url_launcher, url_launcher_web] Fix API dependencies. (cla: yes, waiting for test harness)


[2985](https://github.com/flutter/plugins/pull/2985) [google_maps_flutter] Fix Android unit test. (cla: yes, waiting for test harness)


[3010](https://github.com/flutter/plugins/pull/3010) [url_launcher_web] Fix a typo in a test name and fix quote consistency (cla: yes, waiting for test harness)


### in review - 1 pull request(s)

[970](https://github.com/flutter/plugins/pull/970) [share] Add sharing file support (android & ios) (cla: yes, in review)

## All merged pull requests

### Merged PRs in `flutter/flutter` from 2020-07-09T05:19:00.000 to 2020-09-10T18:17:00.000
There were 934 pull requests.

[44980](https://github.com/flutter/flutter/pull/44980) Add padding around flutter api docs search input (cla: yes, team)

[55235](https://github.com/flutter/flutter/pull/55235) ignore .idea directory in dart analyzer and analyzer benchmark output in git (cla: yes, team)

[55376](https://github.com/flutter/flutter/pull/55376) Add debounce support to daemon hot reload requests (cla: yes, tool, waiting for tree to go green)

[56413](https://github.com/flutter/flutter/pull/56413) Prevent viewport.showOnScreen from scrolling the viewport if the specified Rect is already visible.  (cla: yes, f: material design, f: scrolling, framework, severe: API break, waiting for tree to go green)

[58245](https://github.com/flutter/flutter/pull/58245) Automatically scale down Dialog padding for larger text scale factors (cla: yes, f: material design, framework, waiting for tree to go green)

[58640](https://github.com/flutter/flutter/pull/58640) Skip Audit - Rendering Library (a: quality, a: tests, cla: yes, framework, team, waiting for tree to go green)

[58731](https://github.com/flutter/flutter/pull/58731) Autofill save (a: text input, cla: yes, framework)

[59114](https://github.com/flutter/flutter/pull/59114) Add support for Dart Development Service (DDS) in Flutter Tools (cla: yes, team, tool)

[59127](https://github.com/flutter/flutter/pull/59127) [Text Scaling][Material] Update BottomNavigationBar to show tooltips on long press. (cla: yes, f: cupertino, f: material design, framework, team)

[59623](https://github.com/flutter/flutter/pull/59623) Reduce iOS scroll damping for lists with differently sized items (a: fidelity, cla: yes, f: scrolling, framework, platform-ios, waiting for tree to go green)

[59702](https://github.com/flutter/flutter/pull/59702) New Button Universe (cla: yes, f: material design, framework, waiting for tree to go green)

[59766](https://github.com/flutter/flutter/pull/59766) FormField should autovalidate only if its content was changed (fixed) (a: text input, cla: yes, f: material design, framework, waiting for tree to go green)

[60053](https://github.com/flutter/flutter/pull/60053) Set the application-id in the Linux shell (cla: yes, tool)

[60174](https://github.com/flutter/flutter/pull/60174) Add an additional builder to DragTarget which fires on every Draggabl… (cla: yes, framework, waiting for tree to go green)

[60177](https://github.com/flutter/flutter/pull/60177) Don't move to word edge when tapping with a mouse (a: mouse, a: text input, cla: yes, f: material design, framework, waiting for tree to go green)

[60179](https://github.com/flutter/flutter/pull/60179) Implement new activity indicator for iOS14 (cla: yes, f: cupertino, framework)

[60238](https://github.com/flutter/flutter/pull/60238) Branch out android platform view perf testing (cla: yes, team)

[60299](https://github.com/flutter/flutter/pull/60299) Implement Router widget and widgets app api (cla: yes, f: cupertino, f: material design, framework, waiting for tree to go green)

[60337](https://github.com/flutter/flutter/pull/60337) Add ThemeData.shadowColor (cla: yes, f: material design, framework, waiting for tree to go green)

[60375](https://github.com/flutter/flutter/pull/60375) Restoration Framework (a: tests, cla: yes, framework, waiting for tree to go green)

[60446](https://github.com/flutter/flutter/pull/60446) Remove unused optional parameters of private functions. (a: tests, cla: yes, f: material design, framework, team, waiting for tree to go green)

[60479](https://github.com/flutter/flutter/pull/60479) Fix tooltip position using correct overlay to calculate render box position. (a: layout, cla: yes, f: material design, framework, waiting for tree to go green)

[60501](https://github.com/flutter/flutter/pull/60501) Make Scrollable's free scroll initial velocity matches that of iOS (a: fidelity, cla: yes, f: scrolling, framework, platform-ios, waiting for tree to go green)

[60558](https://github.com/flutter/flutter/pull/60558) Pointer event resampler (#41118) (cla: yes, f: scrolling, framework, platform-android, platform-fuchsia, platform-ios, waiting for tree to go green)

[60591](https://github.com/flutter/flutter/pull/60591) [flutter_tools] Separate style and data from AnalysisError (cla: yes, tool, waiting for tree to go green)

[60632](https://github.com/flutter/flutter/pull/60632) Add locales for fil(filipino) and gsw(swiss german) to locale list, Fixes #60631 (a: internationalization, cla: yes, team, tool, waiting for tree to go green)

[60640](https://github.com/flutter/flutter/pull/60640) expose route settings for showModalBottomSheet (cla: yes, f: material design, f: routes, framework, waiting for tree to go green)

[60655](https://github.com/flutter/flutter/pull/60655) clean up hero controller scope (cla: yes, f: cupertino, f: material design, framework, waiting for tree to go green)

[60796](https://github.com/flutter/flutter/pull/60796) Add support in WidgetTester for an array of inputs (a: animation, a: tests, cla: yes, f: gestures, framework)

[60931](https://github.com/flutter/flutter/pull/60931) Add all system cursors (framework) (a: desktop, a: mouse, cla: yes, framework, waiting for tree to go green)

[60939](https://github.com/flutter/flutter/pull/60939) Add a benchmark that focuses on Paint object performance (cla: yes, team)

[60940](https://github.com/flutter/flutter/pull/60940) Skip Audit - Last Leftovers (a: quality, a: tests, cla: yes, f: cupertino, f: material design, framework, team, waiting for tree to go green)

[60990](https://github.com/flutter/flutter/pull/60990) Use the correct Transform in the WidgetInspector overlay (#59566) (cla: yes, f: inspector, framework, waiting for tree to go green)

[61007](https://github.com/flutter/flutter/pull/61007) Turn on add-to-app iOS platform unit tests (a: existing-apps, a: tests, cla: yes, platform-ios, team)

[61048](https://github.com/flutter/flutter/pull/61048) Re-land "Tweaking Material Chip a11y semantics to match buttons (#60141)" (a: accessibility, cla: yes, customer: money (g3), f: material design, framework, waiting for tree to go green)

[61071](https://github.com/flutter/flutter/pull/61071) [Api docs] Updates ListTile.subtitle docs to address how TextStyle is decided (cla: yes, d: api docs, f: material design, framework, waiting for tree to go green)

[61086](https://github.com/flutter/flutter/pull/61086) Added the materialTapTargetSize to the OutlineButton Constructor (cla: yes, f: material design, framework, waiting for tree to go green)

[61104](https://github.com/flutter/flutter/pull/61104) Document the addition of LRM and RLM characters (cla: yes, framework, waiting for tree to go green)

[61114](https://github.com/flutter/flutter/pull/61114) [flutter_tools] add support for enable null safety asserts (cla: yes, team, tool)

[61123](https://github.com/flutter/flutter/pull/61123) This fixes an error in the form field example (cla: yes, d: api docs, f: material design, framework, waiting for tree to go green)

[61135](https://github.com/flutter/flutter/pull/61135) Add spaces between sentences in create --platforms help text (cla: yes, tool, waiting for tree to go green)

[61136](https://github.com/flutter/flutter/pull/61136) Re-land Expose height and width factor in AnimatedAlign (a: animation, cla: yes, framework, waiting for tree to go green)

[61138](https://github.com/flutter/flutter/pull/61138) Fixing patch for coming breaking change in HttpClientRequest (a: tests, cla: yes, framework)

[61139](https://github.com/flutter/flutter/pull/61139) [flutter_tools] remove globals from device manager, flutter tester (cla: yes, tool)

[61140](https://github.com/flutter/flutter/pull/61140) Case insensitive check flavor names against Xcode schemes (cla: yes, platform-ios, t: xcode, team, tool)

[61141](https://github.com/flutter/flutter/pull/61141) Add additional GTK keycodes for enter and tab (cla: yes, team)

[61146](https://github.com/flutter/flutter/pull/61146) [flutter_tools] Unified analyze error log format (cla: yes, tool)

[61171](https://github.com/flutter/flutter/pull/61171) Fix FloatingActionButtonLocation for additional test case (a: quality, f: material design, framework, waiting for tree to go green)

[61177](https://github.com/flutter/flutter/pull/61177) use nnbd deps (team, tool)

[61178](https://github.com/flutter/flutter/pull/61178) [flutter_tools] cleanups to web runner functionality (cla: yes, tool, waiting for tree to go green)

[61180](https://github.com/flutter/flutter/pull/61180) [Material] Allow for customizing Snack bar margin, padding, and width (cla: yes, f: material design, framework, waiting for tree to go green)

[61185](https://github.com/flutter/flutter/pull/61185) Filter profiling events by names not category (a: tests, cla: yes, framework, severe: performance)

[61188](https://github.com/flutter/flutter/pull/61188) migrate foundation to nullsafety (cla: yes, framework)

[61190](https://github.com/flutter/flutter/pull/61190) Mouse events report correct local positions (cla: yes, framework, waiting for tree to go green)

[61191](https://github.com/flutter/flutter/pull/61191) [flutter_tools] switch order of injection (cla: yes, tool, waiting for tree to go green)

[61196](https://github.com/flutter/flutter/pull/61196) Prefer tear offs to lambdas in test expects (cla: yes, team, tool)

[61198](https://github.com/flutter/flutter/pull/61198) [flutter_tools] allow unmuting of command logging (cla: yes, tool, waiting for tree to go green)

[61199](https://github.com/flutter/flutter/pull/61199) remove LICENSE/NOTICES work around (cla: yes, framework, waiting for tree to go green)

[61201](https://github.com/flutter/flutter/pull/61201) [flutter_tools] abstract logger construction (why can't I hold all these loggers) (cla: yes, tool, waiting for tree to go green)

[61203](https://github.com/flutter/flutter/pull/61203) Remove v1 Android create templates (cla: yes, team, tool, waiting for tree to go green)

[61205](https://github.com/flutter/flutter/pull/61205) Migrate Android views e2e to the new embedding (cla: yes, team)

[61209](https://github.com/flutter/flutter/pull/61209) Optionally invert oversized images (a: debugging, a: error message, a: images, cla: yes, framework, tool)

[61215](https://github.com/flutter/flutter/pull/61215) Ignore .idea/* files in the analysis bot. (cla: yes, team, waiting for tree to go green)

[61216](https://github.com/flutter/flutter/pull/61216) InkDecoration do not paint if it's part of the tree doesn't get painted (cla: yes, f: material design, framework, waiting for tree to go green)

[61253](https://github.com/flutter/flutter/pull/61253) [flutter_tools] deflake integration test with tryToDelete (cla: yes, tool)

[61256](https://github.com/flutter/flutter/pull/61256) Fix bold not getting cleared on new line (cla: yes, tool, waiting for tree to go green)

[61257](https://github.com/flutter/flutter/pull/61257) [devicelab] This no-op change marks 3 tests to run on LUCI builders. (cla: yes, team, team: infra, waiting for tree to go green)

[61258](https://github.com/flutter/flutter/pull/61258) Adds semantics information for the popup menu item (cla: yes, f: material design, framework, waiting for tree to go green)

[61261](https://github.com/flutter/flutter/pull/61261) [flutter_tools] generate a synthetic flutter_gen package on pub get (cla: yes, tool)

[61262](https://github.com/flutter/flutter/pull/61262) Renamed ContainedButton et al. to ElevatedButton et al. (cla: yes, f: material design, framework, waiting for tree to go green)

[61265](https://github.com/flutter/flutter/pull/61265) Added web compiler debug metadata (cla: yes, team, tool)

[61266](https://github.com/flutter/flutter/pull/61266) implement handlePointerEventRecord for LiveWidgetController (a: tests, cla: yes, framework, waiting for tree to go green)

[61268](https://github.com/flutter/flutter/pull/61268) Update Table docs for horizontal scrolling (cla: yes, d: api docs, documentation, f: scrolling, framework, waiting for tree to go green)

[61269](https://github.com/flutter/flutter/pull/61269) Parse .flutter-plugins-dependencies for add-to-app iOS modules (a: existing-apps, cla: yes, platform-ios, team, tool, waiting for tree to go green)

[61270](https://github.com/flutter/flutter/pull/61270) Update engine hash for 1.20.0-7.1.pre (CQ+1, cla: yes, engine)

[61276](https://github.com/flutter/flutter/pull/61276) Revert "Add support for Dart Development Service (DDS) in Flutter Tools" (team, tool)

[61312](https://github.com/flutter/flutter/pull/61312) Add more tips for androidLicensesUnknown (cla: yes, tool, waiting for tree to go green)

[61323](https://github.com/flutter/flutter/pull/61323) Updated Row API doc for RTL in textDirection (cla: yes, d: api docs, documentation, framework, waiting for tree to go green)

[61338](https://github.com/flutter/flutter/pull/61338) Show correct errors when plugins yaml forgot the 'flutter.plugins.pla… (cla: yes, tool, waiting for tree to go green)

[61347](https://github.com/flutter/flutter/pull/61347) [ListTile] adds new properties to customize the tile color (cla: yes, f: material design, framework, severe: new feature, waiting for tree to go green)

[61356](https://github.com/flutter/flutter/pull/61356) Updated dataTable API doc to explicitly point sorting (cla: yes, f: material design, framework, waiting for tree to go green)

[61359](https://github.com/flutter/flutter/pull/61359) Add a flag for using WebSockets for the Dart Debug extension backend service (cla: yes, tool, waiting for tree to go green)

[61363](https://github.com/flutter/flutter/pull/61363) add new docker_attach.sh script and update README (cla: yes, team, waiting for tree to go green)

[61368](https://github.com/flutter/flutter/pull/61368) Add widget of the week videos to documentation (cla: yes, f: cupertino, f: material design, framework, waiting for tree to go green)

[61370](https://github.com/flutter/flutter/pull/61370) Remove the default shortcut mapping for GameButtonB. (cla: yes, framework, waiting for tree to go green)

[61371](https://github.com/flutter/flutter/pull/61371) Make ThemeData.shadowColor the default shadowColor in TextButton et al. (cla: yes, f: material design, framework, waiting for tree to go green)

[61375](https://github.com/flutter/flutter/pull/61375) issue 61346 route can be added and disposed in the same frame (cla: yes, framework, waiting for tree to go green)

[61377](https://github.com/flutter/flutter/pull/61377) Revert "Adds semantics information for the popup menu item (#61258)" (cla: yes, f: material design, framework)

[61385](https://github.com/flutter/flutter/pull/61385) reland "Adds semantics information for the popup menu item (#61258)" (a: accessibility, cla: yes, f: material design, framework, team, waiting for tree to go green)

[61386](https://github.com/flutter/flutter/pull/61386) Fix NestedScrollView inner ballistic activity for 0 velocity (a: quality, cla: yes, f: scrolling, framework, waiting for tree to go green)

[61388](https://github.com/flutter/flutter/pull/61388) benchmarkLive: a new `LiveTestWidgetsFlutterBindingFramePolicy` for benchmark on device (a: tests, cla: yes, framework, team, waiting for tree to go green)

[61392](https://github.com/flutter/flutter/pull/61392) Update Card example and shadowColor default (cla: yes, f: material design, framework, waiting for tree to go green)

[61394](https://github.com/flutter/flutter/pull/61394) Update the Scaffold examples; use the new button classes (cla: yes, f: material design, framework)

[61395](https://github.com/flutter/flutter/pull/61395) Reland "Add support for Dart Development Service (DDS) in Flutter Tools (#61276)" (cla: yes, team, tool)

[61398](https://github.com/flutter/flutter/pull/61398) Prevent material switch from recreating its render object when it becomes disabled (cla: yes, f: material design, framework, waiting for tree to go green)

[61399](https://github.com/flutter/flutter/pull/61399) Document the mapping of system mouse cursors on Windows and Linux (a: desktop, a: mouse, cla: yes, framework)

[61400](https://github.com/flutter/flutter/pull/61400) fix code comments in the route route didadd method (cla: yes, framework, waiting for tree to go green)

[61401](https://github.com/flutter/flutter/pull/61401) Make scrollbar thickness and radius customizable (cla: yes, f: cupertino, f: material design, framework)

[61406](https://github.com/flutter/flutter/pull/61406) Update the golden image comparator to handle read-only image ByteData views (a: tests, cla: yes, framework, waiting for tree to go green)

[61408](https://github.com/flutter/flutter/pull/61408) Add the ability to ignore lines from coverage depending on comments (cla: yes, tool, waiting for tree to go green)

[61411](https://github.com/flutter/flutter/pull/61411) [flutter_tools] add the feature for single widget reloads (cla: yes, tool)

[61413](https://github.com/flutter/flutter/pull/61413) [flutter_tools] update fastReassemble method for single widget reloads (cla: yes, framework, tool)

[61417](https://github.com/flutter/flutter/pull/61417) Account for MotionEvent instance mutations (cla: yes, team, waiting for tree to go green)

[61424](https://github.com/flutter/flutter/pull/61424) Update documentation (cla: yes, f: material design, framework)

[61425](https://github.com/flutter/flutter/pull/61425) Default textBaseline to alphabetic in Flex (cla: yes, framework, waiting for tree to go green)

[61439](https://github.com/flutter/flutter/pull/61439) Add per thumb Range Slider semantics (cla: yes, f: material design, framework, waiting for tree to go green)

[61455](https://github.com/flutter/flutter/pull/61455) Improve error reporting for RenderObject visitChildren errors (cla: yes, framework)

[61457](https://github.com/flutter/flutter/pull/61457) Add assert to Table to check for rows with null children (cla: yes, framework)

[61474](https://github.com/flutter/flutter/pull/61474) Fix Border.symmetric: phase 1 (cla: yes, framework, waiting for tree to go green)

[61475](https://github.com/flutter/flutter/pull/61475) [flutter_tools] turn down flutter generate (cla: yes, tool)

[61479](https://github.com/flutter/flutter/pull/61479) Update MaterialState API docs (cla: yes, f: material design, framework, waiting for tree to go green)

[61481](https://github.com/flutter/flutter/pull/61481) [flutter_tools] add feature for iOS, android, and fuchsia (cla: yes, tool)

[61482](https://github.com/flutter/flutter/pull/61482) Revert "Branch out android platform view perf testing (#60238)" (cla: yes, team)

[61484](https://github.com/flutter/flutter/pull/61484) Support Xcode patch version comparison (cla: yes, platform-ios, t: xcode, tool, waiting for tree to go green)

[61485](https://github.com/flutter/flutter/pull/61485) fix intrinsic height and width for widget span (cla: yes, framework, waiting for tree to go green)

[61488](https://github.com/flutter/flutter/pull/61488) Do not upload all pub packages into the zip bundle (cla: yes, team)

[61489](https://github.com/flutter/flutter/pull/61489) Updated date pickers to use the new TextButton in place of FlatButton. (cla: yes, f: material design, framework, waiting for tree to go green)

[61491](https://github.com/flutter/flutter/pull/61491) Remove code that morphs --sound-null-safety to --null-safety options (cla: yes, tool, waiting for tree to go green)

[61492](https://github.com/flutter/flutter/pull/61492) Updated time pickers to use the new TextButton in place of FlatButton. (cla: yes, f: material design, framework)

[61498](https://github.com/flutter/flutter/pull/61498) Revert "Reland "Add support for Dart Development Service (DDS) in Flutter Tools (#61276)"" (cla: yes, team, tool)

[61502](https://github.com/flutter/flutter/pull/61502) Update documentation for IntrinsicWidth & IntrinsicHeight (cla: yes, d: api docs, documentation, framework)

[61503](https://github.com/flutter/flutter/pull/61503) Add defaults to `showGeneralDialog()` (cla: yes, framework)

[61507](https://github.com/flutter/flutter/pull/61507) Android views using hybrid composition e2e driver test (cla: yes, team, waiting for tree to go green)

[61509](https://github.com/flutter/flutter/pull/61509) Add a E2E based performance test case (a: tests, cla: yes, framework, team, waiting for tree to go green)

[61513](https://github.com/flutter/flutter/pull/61513) [flutter_tools] Make flutter git upstream configurable (cla: yes, tool, waiting for tree to go green)

[61516](https://github.com/flutter/flutter/pull/61516) Allow transparent barrierColor in showDialog methods (cla: yes, framework)

[61517](https://github.com/flutter/flutter/pull/61517) [CONTRIBUTING.md] adds Contributing to Flutter article link (cla: yes, team, waiting for tree to go green)

[61518](https://github.com/flutter/flutter/pull/61518) Change xcodebuild to be a "slow operation" (cla: yes, t: xcode, tool)

[61532](https://github.com/flutter/flutter/pull/61532) [ListTileTheme] adds properties to customize tile color at theme level (cla: yes, f: material design, framework, waiting for tree to go green)

[61535](https://github.com/flutter/flutter/pull/61535) Tweak message about debugging with web-server (cla: yes, tool)

[61540](https://github.com/flutter/flutter/pull/61540) Promote WidgetTester.ensureVisible to WidgetController (a: tests, cla: yes, framework)

[61548](https://github.com/flutter/flutter/pull/61548) [flutter_tools] fix typo in test code (cla: yes, tool)

[61551](https://github.com/flutter/flutter/pull/61551) Fix/decoration equality (cla: yes, waiting for tree to go green)

[61552](https://github.com/flutter/flutter/pull/61552) Verbose process exceptions (cla: yes, team, tool, waiting for tree to go green)

[61554](https://github.com/flutter/flutter/pull/61554) Reland "Branch out android platform view perf testing (#60238)" (cla: yes, team)

[61556](https://github.com/flutter/flutter/pull/61556) fix type error in web builds (cla: yes, cp: 1.20, cp: 1.20 completed, framework)

[61561](https://github.com/flutter/flutter/pull/61561) [flutter_tool] remove no-op iOS folder when creating plugins. (cla: yes, targeted to release: 1.20, tool)

[61564](https://github.com/flutter/flutter/pull/61564) ✒ Spell Check All `.md` Files Related to Flutter 💙 (a: internationalization, cla: yes, d: examples, team, tool, waiting for tree to go green)

[61568](https://github.com/flutter/flutter/pull/61568) Fix build (fix references to _flutter -> flutter) (cla: yes, tool)

[61569](https://github.com/flutter/flutter/pull/61569) Updated instructions of 'flutter help attach' (cla: yes, tool, waiting for tree to go green)

[61570](https://github.com/flutter/flutter/pull/61570) migrate scheduler to nullsafety (cla: yes, framework, waiting for tree to go green)

[61572](https://github.com/flutter/flutter/pull/61572) Remove unused parameter from private method in widget_inspector (cla: yes, framework, waiting for tree to go green)

[61573](https://github.com/flutter/flutter/pull/61573) Remove run_machine_concurrent_hot_reload device lab test (cla: yes, team)

[61576](https://github.com/flutter/flutter/pull/61576) Corrected splash color for TextButton, ElevatedButton, OutlinedButton (cla: yes, f: material design, framework, waiting for tree to go green)

[61578](https://github.com/flutter/flutter/pull/61578) Updated obsolete button references in Scaffold, IconButton (cla: yes, f: material design, framework)

[61579](https://github.com/flutter/flutter/pull/61579) Remove unused FlutterErrorDetails subclasses (a: debugging, a: error message, a: quality, a: tests, cla: yes, framework, waiting for tree to go green)

[61581](https://github.com/flutter/flutter/pull/61581) Give better error message for describeEnum (a: error message, cla: yes, f: inspector, framework, waiting for tree to go green)

[61582](https://github.com/flutter/flutter/pull/61582) Remote returns for function expression inferred return type void. (cla: yes, framework, tool, waiting for tree to go green)

[61585](https://github.com/flutter/flutter/pull/61585)  Show device diagnostic messages in doctor (cla: yes, t: flutter doctor, team, tool, waiting for tree to go green)

[61587](https://github.com/flutter/flutter/pull/61587) Find the target platform more accurately on the web. (cla: yes, framework, waiting for tree to go green)

[61593](https://github.com/flutter/flutter/pull/61593) remove flutter update-packages from tools-tests (cla: yes, tool, waiting for tree to go green)

[61621](https://github.com/flutter/flutter/pull/61621) cleanup macrobenchmark duplicate files (cla: yes, team)

[61623](https://github.com/flutter/flutter/pull/61623) Fix overflow issue caused by a long title/subtitle for the vertical stepper (cla: yes, f: material design, framework, waiting for tree to go green)

[61632](https://github.com/flutter/flutter/pull/61632) 1.20.0-7.2.pre framework cherrypicks (cla: yes, engine, framework, team)

[61633](https://github.com/flutter/flutter/pull/61633) Reland "Add support for Dart Development Service (DDS) in Flutter Tools (#61276)" (cla: yes, team, tool)

[61634](https://github.com/flutter/flutter/pull/61634) [flutter_tools] turn off fuchsia support by default (cla: yes, tool, waiting for tree to go green)

[61636](https://github.com/flutter/flutter/pull/61636) remove usage to applyTextScaleFactorToWidgetSpan (a: accessibility, a: typography, cla: yes, framework, waiting for tree to go green)

[61640](https://github.com/flutter/flutter/pull/61640) [flutter_tools] update device discovery constructors (cla: yes, tool, waiting for tree to go green)

[61641](https://github.com/flutter/flutter/pull/61641) Revert "Reland "Add support for Dart Development Service (DDS) in Flutter Tools (#61276)"" (cla: yes, team, tool)

[61642](https://github.com/flutter/flutter/pull/61642) Revert "Reland "Branch out android platform view perf testing (#60238)"" (cla: yes, team)

[61646](https://github.com/flutter/flutter/pull/61646) Use device-finder instead of dev_finder is flutter code. (cla: yes, team, waiting for tree to go green)

[61647](https://github.com/flutter/flutter/pull/61647) update packages (cla: yes, team)

[61648](https://github.com/flutter/flutter/pull/61648) Proposal: deprecate autovalidate parameter of the Form, FormField and TextFormField widget (cla: yes, f: material design, framework, waiting for tree to go green)

[61655](https://github.com/flutter/flutter/pull/61655) Add assert in PictureLayer.addToScene() (cla: yes, framework)

[61662](https://github.com/flutter/flutter/pull/61662) add static method to create material hero controller (cla: yes, f: material design, framework, waiting for tree to go green)

[61664](https://github.com/flutter/flutter/pull/61664) Add minWidth and height parameter into FlatButton widget (cla: yes, f: material design, framework, waiting for tree to go green)

[61666](https://github.com/flutter/flutter/pull/61666) Fix Border.symmetric: phase 2 (cla: yes, framework)

[61667](https://github.com/flutter/flutter/pull/61667) Add tests for platform views' hover behavior  (a: mouse, a: platform-views, cla: yes, framework)

[61668](https://github.com/flutter/flutter/pull/61668) Track used Android pointer IDs and reuse IDs after a pointer is released (cla: yes, framework, waiting for tree to go green)

[61671](https://github.com/flutter/flutter/pull/61671) Add no-op callbacks to platform view gesture recognizer when necessary (cla: yes, framework)

[61672](https://github.com/flutter/flutter/pull/61672) Remove TODO around deprecation (cla: yes, framework, waiting for tree to go green)

[61674](https://github.com/flutter/flutter/pull/61674) Revert "update packages" (cla: yes, team)

[61675](https://github.com/flutter/flutter/pull/61675) Update dependencies in hybrid android views test (cla: yes, team)

[61678](https://github.com/flutter/flutter/pull/61678) update packages (cla: yes, team, tool)

[61684](https://github.com/flutter/flutter/pull/61684) Skip printing rendered error text in machine mode (cla: yes, tool, waiting for tree to go green)

[61698](https://github.com/flutter/flutter/pull/61698) Mark flutter_gallery_ios32__transition_perf as flaky (cla: yes, team)

[61710](https://github.com/flutter/flutter/pull/61710) Added expandedHeight in flexibleSpace and flexibleSpaceBar (cla: yes, d: api docs, documentation, f: material design, framework, waiting for tree to go green)

[61714](https://github.com/flutter/flutter/pull/61714) Implement customizable cursor height (cla: yes, f: cupertino, f: material design, framework, waiting for tree to go green)

[61737](https://github.com/flutter/flutter/pull/61737) Mark smoke_catalina_start_up_ios as flaky (cla: yes, team)

[61748](https://github.com/flutter/flutter/pull/61748) Reland "Branch out android platform view perf testing #60238" 2nd time (cla: yes, team, waiting for tree to go green)

[61752](https://github.com/flutter/flutter/pull/61752) Allowed specifying reverseTransitionDuration in PageRouteBuilder class (cla: yes, f: routes, framework, waiting for tree to go green)

[61756](https://github.com/flutter/flutter/pull/61756) Fix `ExcludeFocus` so it won't refocus a sibling of the focused node. (cla: yes, f: focus, framework, waiting for tree to go green)

[61760](https://github.com/flutter/flutter/pull/61760) [flutter_tools] revert dart format changes (cla: yes, cp: 1.20, cp: 1.20 completed, tool, waiting for tree to go green)

[61762](https://github.com/flutter/flutter/pull/61762) Inject iproxy into context (cla: yes, platform-ios, tool, waiting for tree to go green)

[61766](https://github.com/flutter/flutter/pull/61766) [flutter_tools] Add plumbing for widget cache (cla: yes, tool)

[61773](https://github.com/flutter/flutter/pull/61773) Update framePolicy docs (a: tests, cla: yes, d: api docs, documentation, framework, waiting for tree to go green)

[61778](https://github.com/flutter/flutter/pull/61778) [Material] Updated icons and fonts (cla: yes, f: material design, framework, team, tool, waiting for tree to go green)

[61779](https://github.com/flutter/flutter/pull/61779) Add a test for 3D transform with needsCompositing (cla: yes, framework, waiting for tree to go green)

[61796](https://github.com/flutter/flutter/pull/61796) Improved docs for minLines in EditableText (a: text input, cla: yes, d: api docs, documentation, framework, waiting for tree to go green)

[61800](https://github.com/flutter/flutter/pull/61800) re-Update engine hash for 1.20.0-7.2.pre, including 12847e8 (CQ+1, cla: yes, engine)

[61841](https://github.com/flutter/flutter/pull/61841) Make sure all isolates start during flutter driver tests. (a: tests, cla: yes, framework, waiting for tree to go green)

[61844](https://github.com/flutter/flutter/pull/61844) restore nullability of FlutterError.onError (cla: yes, framework)

[61872](https://github.com/flutter/flutter/pull/61872) LiveTestWidgetsFlutterBinding support for non-touch event (a: tests, cla: yes, framework)

[61876](https://github.com/flutter/flutter/pull/61876) Revert "fix intrinsic height and width for widget span (#61485)" (cla: yes, framework)

[61881](https://github.com/flutter/flutter/pull/61881) [flutter_tools] Concise dart2js commands outputKernel & outputJavaScript (cla: yes, tool, waiting for tree to go green)

[61882](https://github.com/flutter/flutter/pull/61882) Reland "Add support for Dart Development Service (DDS) in Flutter Tools (#61276)" (cla: yes, team, tool)

[61900](https://github.com/flutter/flutter/pull/61900) Revert "LiveTestWidgetsFlutterBinding support for non-touch event" (a: tests, cla: yes, framework)

[61901](https://github.com/flutter/flutter/pull/61901) Reland "LiveTestWidgetsFlutterBinding support for non-touch event" (a: tests, cla: yes, framework, waiting for tree to go green)

[61909](https://github.com/flutter/flutter/pull/61909) Revert "Reland "Add support for Dart Development Service (DDS) in Flutter Tools (#61276)"" (cla: yes, team, tool)

[61912](https://github.com/flutter/flutter/pull/61912) Disable the deferred loading variant of gen_l10n_test (cla: yes, tool, waiting for tree to go green)

[61913](https://github.com/flutter/flutter/pull/61913) [flutter_tools] macOS cleanups, attach to log reader in release mode (cla: yes, tool, waiting for tree to go green)

[61916](https://github.com/flutter/flutter/pull/61916) Refactor gen_keycode: Split generators (cla: yes, framework, team)

[61918](https://github.com/flutter/flutter/pull/61918) Test dynamic surface switch (cla: yes, team, waiting for tree to go green)

[61921](https://github.com/flutter/flutter/pull/61921) Remove the flaky flag for frame policy test  (cla: yes, team, waiting for tree to go green)

[61940](https://github.com/flutter/flutter/pull/61940) Check if a double is NaN before converting to it int (cla: yes, framework, waiting for tree to go green)

[61941](https://github.com/flutter/flutter/pull/61941) migrate physics to nullsafety (cla: yes, framework, team, waiting for tree to go green)

[61948](https://github.com/flutter/flutter/pull/61948) Add LayoutBuilder example (cla: yes, d: api docs, d: examples, documentation, framework, waiting for tree to go green)

[61961](https://github.com/flutter/flutter/pull/61961) Improve message error for missing textBaseline (a: error message, cla: yes, framework, waiting for tree to go green)

[61963](https://github.com/flutter/flutter/pull/61963) Revert "InkDecoration do not paint if it's part of the tree doesn't g… (cla: yes, f: material design, framework)

[61973](https://github.com/flutter/flutter/pull/61973) Update viewport dimensions when scrollDirection changes (a: quality, cla: yes, f: scrolling, framework, waiting for tree to go green)

[61974](https://github.com/flutter/flutter/pull/61974) fix: MaterialColor Swatch Map comparison (cla: yes, framework, waiting for tree to go green)

[61975](https://github.com/flutter/flutter/pull/61975) Reland "Add support for Dart Development Service (DDS) in Flutter Tools (#61276) (cla: yes, team, tool)

[61978](https://github.com/flutter/flutter/pull/61978) bump nullsafety deps (cla: yes, team, tool, waiting for tree to go green)

[61979](https://github.com/flutter/flutter/pull/61979) Only try to get build settings if the Xcode project exists (cla: yes, platform-ios, t: xcode, tool, waiting for tree to go green)

[61983](https://github.com/flutter/flutter/pull/61983) Update ios-deploy to version 1.11.0 (cla: yes, waiting for tree to go green)

[61993](https://github.com/flutter/flutter/pull/61993) Revert "Reland "Add support for Dart Development Service (DDS) in Flutter Tools (#61276)" (cla: yes, team, tool)

[61996](https://github.com/flutter/flutter/pull/61996) [flutter_tools] check in script for generating per library unit coverage (cla: yes, tool, waiting for tree to go green)

[61998](https://github.com/flutter/flutter/pull/61998) A benchmark test case for measuring scroll smoothness (a: tests, cla: yes, framework, team, waiting for tree to go green)

[62008](https://github.com/flutter/flutter/pull/62008) Minor doc updates (cla: yes, framework)

[62012](https://github.com/flutter/flutter/pull/62012) Update Actions.invoke to return the result of invoking the action. (cla: yes, framework)

[62014](https://github.com/flutter/flutter/pull/62014) TextSelectionTheme support (step 1 of 3) (cla: yes, f: material design, framework)

[62050](https://github.com/flutter/flutter/pull/62050) Revert "Roll Engine from dcc9a4048da8 to 5a73d4dc2503 (36 revisions)" (cla: yes, engine)

[62052](https://github.com/flutter/flutter/pull/62052) Update the FlutterLogo colors and gradients (cla: yes, f: cupertino, f: material design, framework, team, waiting for tree to go green)

[62053](https://github.com/flutter/flutter/pull/62053) [flutter_tools] add flutterRoot field to JSON machine output (cla: yes, tool, waiting for tree to go green)

[62061](https://github.com/flutter/flutter/pull/62061) [flutter_tools] clean plugin dependencies file (cla: yes, tool)

[62062](https://github.com/flutter/flutter/pull/62062) makes PopupMenuitem merge the semantics of its child (cla: yes, f: material design, framework, waiting for tree to go green)

[62064](https://github.com/flutter/flutter/pull/62064) Migrate gallery/transitions_perf test to e2e (a: accessibility, cla: yes, team, waiting for tree to go green)

[62069](https://github.com/flutter/flutter/pull/62069) [flutter_tools] remove breakpoints from paused isolate on hot restart (cla: yes, tool, waiting for tree to go green)

[62070](https://github.com/flutter/flutter/pull/62070) Detect exact device ID matches quickly (cla: yes, tool, waiting for tree to go green)

[62071](https://github.com/flutter/flutter/pull/62071) Make it an error to break doc macros (and fix existing broken macros) (cla: yes, f: material design, framework, waiting for tree to go green)

[62072](https://github.com/flutter/flutter/pull/62072) SelectableText handles after Select All (cla: yes, f: material design, framework, waiting for tree to go green)

[62074](https://github.com/flutter/flutter/pull/62074) Fix RenderFlex crossSize for baseline alignment (P3, a: layout, cla: yes, framework, waiting for tree to go green)

[62075](https://github.com/flutter/flutter/pull/62075) Update the About dialog to use the new button API. (cla: yes, f: material design, framework, waiting for tree to go green)

[62076](https://github.com/flutter/flutter/pull/62076) [flutter_tools] switch cache mode to reload (cla: yes, tool, waiting for tree to go green)

[62082](https://github.com/flutter/flutter/pull/62082) Mark flutter_gallery_ios__transition_perf flaky during investigation (cla: yes, platform-ios, team, team: flakes)

[62083](https://github.com/flutter/flutter/pull/62083) Update the documentation of GlobalKey to explain why it is expensive (cla: yes, d: api docs, documentation, framework, waiting for tree to go green)

[62085](https://github.com/flutter/flutter/pull/62085) Mark smoke_catalina_start_up_ios as not flaky (cla: yes, platform-ios, team, team: flakes, waiting for tree to go green)

[62086](https://github.com/flutter/flutter/pull/62086) Add support for system alert sound (cla: yes, framework)

[62091](https://github.com/flutter/flutter/pull/62091) WidgetController.pump use optional duration (a: tests, cla: yes, framework, waiting for tree to go green)

[62092](https://github.com/flutter/flutter/pull/62092) Updated Material library documentation references to the old button classes. (cla: yes, f: material design, framework, waiting for tree to go green)

[62094](https://github.com/flutter/flutter/pull/62094) Ensure analytics are sent before disabling (cla: yes, tool, waiting for tree to go green)

[62096](https://github.com/flutter/flutter/pull/62096) [flutter_tools] ensure x64 is built if target-platforms is not specified (cla: yes, tool, waiting for tree to go green)

[62097](https://github.com/flutter/flutter/pull/62097) Add WidgetController.scrollUntilVisible (a: tests, cla: yes, framework, waiting for tree to go green)

[62099](https://github.com/flutter/flutter/pull/62099) Updated references to the old button classes to the new classes in widgets, services, and rendering packages (cla: yes, d: api docs, d: examples, documentation, f: material design, framework, waiting for tree to go green)

[62101](https://github.com/flutter/flutter/pull/62101)  Updated 'CustomClipper.shouldReclip' doc (cla: yes, d: api docs, documentation, framework, waiting for tree to go green)

[62115](https://github.com/flutter/flutter/pull/62115) [flutter_tool] [web] Remove x-frame-options header during debug (cla: yes, tool)

[62136](https://github.com/flutter/flutter/pull/62136) Add template flutter.widgets.transitionRoute.reverseTransitionDuration (cla: yes, framework)

[62144](https://github.com/flutter/flutter/pull/62144) Revert "remove usage to applyTextScaleFactorToWidgetSpan (#61636)" (cla: yes, framework)

[62147](https://github.com/flutter/flutter/pull/62147) Reland "Add support for Dart Development Service (DDS) in Flutter Tools (#61276)" (cla: yes, team, tool, waiting for tree to go green)

[62150](https://github.com/flutter/flutter/pull/62150) Manual engine roll to 4d720dd9e56ff5d008ed8cafff3a45676f403c23 (cla: yes, engine)

[62152](https://github.com/flutter/flutter/pull/62152) [flutter_tools] deflake fastReassemble test (cla: yes, tool, waiting for tree to go green)

[62154](https://github.com/flutter/flutter/pull/62154) Disable DartDev when running device lab tests (cla: yes)

[62157](https://github.com/flutter/flutter/pull/62157) migrate gestures to nullsafety (cla: yes, framework, waiting for tree to go green)

[62158](https://github.com/flutter/flutter/pull/62158) Manual engine roll to 602c2d81fa166c77920c2b2fdc190a6f2f257985 (cla: yes, engine)

[62162](https://github.com/flutter/flutter/pull/62162) Add Crane test to the new Gallery app (cla: yes, team, waiting for tree to go green)

[62163](https://github.com/flutter/flutter/pull/62163) Manual engine roll to 626244a72c5d53cc6d00c840987f9059faed511a (cla: yes, engine)

[62164](https://github.com/flutter/flutter/pull/62164) Updated material and cupertino tests to use the new button classes (cla: yes, f: cupertino, f: material design, framework, waiting for tree to go green)

[62167](https://github.com/flutter/flutter/pull/62167) Ban unresolved dartdoc directives from HTML output (cla: yes, f: material design, framework, team, waiting for tree to go green)

[62195](https://github.com/flutter/flutter/pull/62195) [Material] Ensure banner reads banner theme's leading padding property (cla: yes, f: material design, framework, waiting for tree to go green)

[62217](https://github.com/flutter/flutter/pull/62217) Pass --disable-dart-dev in more places (cla: yes, team, tool)

[62218](https://github.com/flutter/flutter/pull/62218) Fix README typo (cla: yes, team, waiting for tree to go green)

[62219](https://github.com/flutter/flutter/pull/62219) Simplify macrobencharks/picture_cache (cla: yes, team, waiting for tree to go green)

[62220](https://github.com/flutter/flutter/pull/62220) Updated the framework tests to use the new button API. (a: accessibility, a: tests, cla: yes, f: material design, framework, waiting for tree to go green)

[62221](https://github.com/flutter/flutter/pull/62221) Add purge-persistent-cache option to run and drive (cla: yes, tool)

[62224](https://github.com/flutter/flutter/pull/62224) Fix error handling for errors with empty stack traces (cla: yes, framework)

[62225](https://github.com/flutter/flutter/pull/62225) Handle hyphens in iOS UDIDs (cla: yes, platform-ios, tool)

[62234](https://github.com/flutter/flutter/pull/62234) Revert "bump nullsafety deps" (cla: yes, team, tool)

[62239](https://github.com/flutter/flutter/pull/62239) Revert "Make sure all isolates start during flutter driver tests." (a: tests, cla: yes, framework)

[62248](https://github.com/flutter/flutter/pull/62248) Print date/time for each step taken in docs.sh (cla: yes)

[62249](https://github.com/flutter/flutter/pull/62249) Add --disable-dart-dev to docs.sh (cla: yes, team)

[62251](https://github.com/flutter/flutter/pull/62251) Rather than timing out dashing, run it in background (cla: yes, team)

[62272](https://github.com/flutter/flutter/pull/62272) [flutter_tools] fix exit label for batchfile (cla: yes, tool, waiting for tree to go green)

[62281](https://github.com/flutter/flutter/pull/62281) Sub-shard the docs shard (cla: yes, team)

[62287](https://github.com/flutter/flutter/pull/62287) Fix typos in documentation comments (cla: yes, framework, waiting for tree to go green)

[62301](https://github.com/flutter/flutter/pull/62301) Update image docs that Image.file() cashes file (cla: yes, framework, waiting for tree to go green)

[62317](https://github.com/flutter/flutter/pull/62317) Fix some broken doc references (cla: yes, f: cupertino, f: material design, framework)

[62323](https://github.com/flutter/flutter/pull/62323) Ignore unmounted parent when _debugVerifyGlobalKeyReservation for GlobalKey check (cla: yes, framework)

[62330](https://github.com/flutter/flutter/pull/62330) Use a LinkedList to improve the performances of ChangeNotifier (cla: yes, framework)

[62337](https://github.com/flutter/flutter/pull/62337) [Material] Add support for high contrast theming to Material apps (cla: yes, f: material design, framework, waiting for tree to go green)

[62338](https://github.com/flutter/flutter/pull/62338) Replace mistaken dartdoc [Foo..bar] references with [Foo.bar] (cla: yes, f: material design, framework, waiting for tree to go green)

[62340](https://github.com/flutter/flutter/pull/62340) Fix doc generation scripts (cla: yes, team)

[62348](https://github.com/flutter/flutter/pull/62348) Remove flaky flag for flutter_gallery_ios__transition_perf (cla: yes, team)

[62349](https://github.com/flutter/flutter/pull/62349) Macrobenchmarks e2e version bug fix (cla: yes, team, waiting for tree to go green)

[62350](https://github.com/flutter/flutter/pull/62350) Added OverflowBar widget (cla: yes, framework, waiting for tree to go green)

[62359](https://github.com/flutter/flutter/pull/62359) Fix SemanticsNode.rect position for nested scrollables with useTwoPan… (a: accessibility, cla: yes, f: scrolling, framework, waiting for tree to go green)

[62362](https://github.com/flutter/flutter/pull/62362) Move key event and semantics related method from WidgetTester to WidgetController (a: tests, cla: yes, framework, waiting for tree to go green)

[62364](https://github.com/flutter/flutter/pull/62364) Wrap launching devtools in DevtoolsLauncher (cla: yes, tool, waiting for tree to go green)

[62367](https://github.com/flutter/flutter/pull/62367) Make dartdoc warnings fatal (& cleanup of warnings) (a: accessibility, a: internationalization, a: tests, cla: yes, f: cupertino, f: material design, framework, team, waiting for tree to go green)

[62368](https://github.com/flutter/flutter/pull/62368) [roll] roll to 2.10 (cla: yes, engine, team, tool)

[62372](https://github.com/flutter/flutter/pull/62372) Parse .flutter-plugins-dependencies for add-to-app iOS modules, remove no-op plugin iOS folder (a: existing-apps, cla: yes, platform-ios, team, tool)

[62373](https://github.com/flutter/flutter/pull/62373) Use in-memory disk for docs shards (cla: yes)

[62386](https://github.com/flutter/flutter/pull/62386) Temporarily disable docset generation (cla: yes, team)

[62395](https://github.com/flutter/flutter/pull/62395) [gen_l10n] Synthetic package generation by default (a: internationalization, cla: yes, severe: API break, team, tool, waiting for tree to go green)

[62407](https://github.com/flutter/flutter/pull/62407) [widgets] Refactor Overlay insert methods entries assert (cla: yes, framework, waiting for tree to go green)

[62415](https://github.com/flutter/flutter/pull/62415) Cache floating cursor location on start event instead of update (cla: yes, framework, waiting for tree to go green)

[62418](https://github.com/flutter/flutter/pull/62418) Add timeout to the devicelab runner logs (cla: yes, team)

[62421](https://github.com/flutter/flutter/pull/62421) Export Material curves in the Material lib (cla: yes, f: material design, framework)

[62426](https://github.com/flutter/flutter/pull/62426) [flutter_tools] ensure desktop builds can run without flutter_tools' package_config (cla: yes, tool, waiting for tree to go green)

[62430](https://github.com/flutter/flutter/pull/62430) Revert "Add Crane test to the new Gallery app" (cla: yes, team)

[62431](https://github.com/flutter/flutter/pull/62431) Revert "Export Material curves in the Material lib" (cla: yes, f: material design, framework)

[62435](https://github.com/flutter/flutter/pull/62435) Reland "Export Material curves in the Material lib" (cla: yes, f: material design, framework, waiting for tree to go green)

[62439](https://github.com/flutter/flutter/pull/62439) Bump new gallery version (cla: yes, team, waiting for tree to go green)

[62443](https://github.com/flutter/flutter/pull/62443) Fix "unresolved doc reference" in rendering layer (cla: yes, framework, waiting for tree to go green)

[62444](https://github.com/flutter/flutter/pull/62444) 1.20.0-7.3.pre beta cherrypicks (CQ+1, cla: yes, engine, tool)

[62445](https://github.com/flutter/flutter/pull/62445) Add supported Luci builders for flutter repo (cla: yes, team, waiting for tree to go green)

[62452](https://github.com/flutter/flutter/pull/62452) Fix "unresolved doc reference" in widgets layer - part 1 (cla: yes, framework, waiting for tree to go green)

[62462](https://github.com/flutter/flutter/pull/62462) separate scroll until visible implementation for lower level accessibility  (a: tests, cla: yes, framework, waiting for tree to go green)

[62471](https://github.com/flutter/flutter/pull/62471) Fix Border.symmetric: phase 3 (cla: yes, framework)

[62473](https://github.com/flutter/flutter/pull/62473) Fix 'unresolved doc reference' for material A-D (cla: yes, f: cupertino, f: material design, framework, waiting for tree to go green)

[62485](https://github.com/flutter/flutter/pull/62485) migrate animation to nullsafety (cla: yes, framework, waiting for tree to go green)

[62495](https://github.com/flutter/flutter/pull/62495) Implement size analyzer to unzip & parse APK and AOT size snapshot to generate analysis json (cla: yes, team, tool)

[62499](https://github.com/flutter/flutter/pull/62499) fix unresolved doc references in widgets - part 2 (cla: yes, framework, waiting for tree to go green)

[62500](https://github.com/flutter/flutter/pull/62500) Fix todo in restoration framework (cla: yes, framework, waiting for tree to go green)

[62508](https://github.com/flutter/flutter/pull/62508) Temporarily disable Dart Development Service in flutter_tools (cla: yes, tool)

[62509](https://github.com/flutter/flutter/pull/62509) Fix more unresolved doc references in material (cla: yes, f: material design, framework, waiting for tree to go green)

[62511](https://github.com/flutter/flutter/pull/62511) Remove timeout on integration_ui_ios (cla: yes, team)

[62513](https://github.com/flutter/flutter/pull/62513) migrate services to nullsafety (cla: yes, framework, team)

[62515](https://github.com/flutter/flutter/pull/62515) [plugin_template] replaces deprecated method usage for android template (cla: yes, tool, waiting for tree to go green)

[62520](https://github.com/flutter/flutter/pull/62520) Fix even more unresolved doc references in material (cla: yes, d: api docs, documentation, f: material design, framework, team, waiting for tree to go green)

[62523](https://github.com/flutter/flutter/pull/62523) Make the text field macrobenchmark work in debug mode (cla: yes, team, waiting for tree to go green)

[62525](https://github.com/flutter/flutter/pull/62525) update to use more null safe packages (cla: yes, team, tool, waiting for tree to go green)

[62529](https://github.com/flutter/flutter/pull/62529) Expose certain functions used when rolling Flutter (cla: yes, team)

[62534](https://github.com/flutter/flutter/pull/62534) [flutter_tools] deflake integration tests by running single isolate (cla: yes, team, waiting for tree to go green)

[62539](https://github.com/flutter/flutter/pull/62539) migrate macrobenchmark/multi_widget_construction test to e2e (cla: yes, team, waiting for tree to go green)

[62544](https://github.com/flutter/flutter/pull/62544) Reland "Add Crane test to the new Gallery app (#62162)" (cla: yes, team, waiting for tree to go green)

[62552](https://github.com/flutter/flutter/pull/62552) Add comment to developers about adding new system sound types (cla: yes, framework)

[62553](https://github.com/flutter/flutter/pull/62553) After cleaning up 812 warnings: Make warnings fatal in dartdocs (cla: yes, framework, team, waiting for tree to go green)

[62577](https://github.com/flutter/flutter/pull/62577) Allow Flutter Web Driver testing in debug mode. (cla: yes, tool, waiting for tree to go green)

[62580](https://github.com/flutter/flutter/pull/62580) [flutter_tools] delete test that will start failing (cla: yes, tool, waiting for tree to go green)

[62582](https://github.com/flutter/flutter/pull/62582) Random unresolved doc reference fixes I missed before (a: internationalization, a: tests, cla: yes, f: material design, framework, waiting for tree to go green)

[62587](https://github.com/flutter/flutter/pull/62587) Reland "remove usage to applyTextScaleFactorToWidgetSpan" (cla: yes, framework)

[62588](https://github.com/flutter/flutter/pull/62588) Build routes even less. (cla: yes, framework, severe: API break, waiting for tree to go green, will affect goldens)

[62590](https://github.com/flutter/flutter/pull/62590) [flutter_tools] add snapshot analysis dependency (cla: yes, team)

[62593](https://github.com/flutter/flutter/pull/62593) [flutter_tools] fix formatting regression in analyze and add full coverage (cla: yes, tool, waiting for tree to go green)

[62599](https://github.com/flutter/flutter/pull/62599) [flutter_tools] update pubspec .yaml message should not be displayed when creating a new plugin (cla: yes, tool)

[62601](https://github.com/flutter/flutter/pull/62601) Use OverflowBar instead of ButtonBar in TimePicker (cla: yes, f: material design, framework)

[62602](https://github.com/flutter/flutter/pull/62602) Fix doc warnings for focus code (cla: yes, framework)

[62605](https://github.com/flutter/flutter/pull/62605) [flutter_tools]Set plugin template min flutter sdk version to 1.20 (cla: yes, tool, waiting for tree to go green)

[62608](https://github.com/flutter/flutter/pull/62608) Add daemon handler to start devtools (cla: yes, tool, waiting for tree to go green)

[62611](https://github.com/flutter/flutter/pull/62611) Alphabetize warning list (cla: yes, waiting for tree to go green)

[62614](https://github.com/flutter/flutter/pull/62614) Make dartdoc warnings fatal for flutter_test (cla: yes, framework, team, waiting for tree to go green)

[62615](https://github.com/flutter/flutter/pull/62615) Fix SliverList scrollOffsetCorrection 0 case (cla: yes, f: scrolling, framework, severe: crash, severe: regression, waiting for tree to go green)

[62623](https://github.com/flutter/flutter/pull/62623) Increase the number of shards for web tests (cla: yes, platform-web, team, team: infra, waiting for tree to go green)

[62628](https://github.com/flutter/flutter/pull/62628) Added a more generous timeout period for the keyboard animation in iOS integration tests (cla: yes, team, waiting for tree to go green)

[62630](https://github.com/flutter/flutter/pull/62630) Add integration test for plugins without ios directories (a: tests, cla: yes, platform-ios, team, waiting for tree to go green)

[62635](https://github.com/flutter/flutter/pull/62635) Fixes physics not working when StepperType.horizontal is selected (cla: yes, f: material design, framework, waiting for tree to go green)

[62640](https://github.com/flutter/flutter/pull/62640) promote WidgetTester pumpAndSettle (a: tests, cla: yes, framework, waiting for tree to go green)

[62643](https://github.com/flutter/flutter/pull/62643) Remove framework_tests from cirrus. (cla: yes, team, team: infra, waiting for tree to go green)

[62646](https://github.com/flutter/flutter/pull/62646) [devicelab] Mark flutter_gallery_ios32__start_up as flaky. (cla: yes, team)

[62657](https://github.com/flutter/flutter/pull/62657) Layout paragraph using the appropriate width based on its textWidthBasis (cla: yes, framework)

[62668](https://github.com/flutter/flutter/pull/62668) Ensure dark theme is used when high contrast dark theme isn't provided (a: accessibility, cla: yes, f: material design, framework, waiting for tree to go green)

[62686](https://github.com/flutter/flutter/pull/62686) Use OverflowBar instead of ButtonBar in DatePicker (cla: yes, f: material design, framework)

[62687](https://github.com/flutter/flutter/pull/62687) [versions] update to the latest sdk versions (cla: yes, team, tool, waiting for tree to go green)

[62690](https://github.com/flutter/flutter/pull/62690) Fix the flexible space bar to still create a rendering object even if… (cla: yes, f: material design, framework, waiting for tree to go green)

[62695](https://github.com/flutter/flutter/pull/62695) Use OverflowBar instead of ButtonBar in DateRangePicker (cla: yes, f: material design, framework, waiting for tree to go green)

[62696](https://github.com/flutter/flutter/pull/62696) migrate part of painting to nullsafety (cla: yes, framework, waiting for tree to go green)

[62697](https://github.com/flutter/flutter/pull/62697) [flutter_tools] add --analyze-size flag (cla: yes, tool, waiting for tree to go green)

[62702](https://github.com/flutter/flutter/pull/62702) Return devtools serve response instead of printing (cla: yes, tool, waiting for tree to go green)

[62703](https://github.com/flutter/flutter/pull/62703) Use OverflowBar instead of ButtonBar in MaterialBanner (cla: yes, f: material design, framework)

[62704](https://github.com/flutter/flutter/pull/62704) remove flutter attach devicelab test (cla: yes, team)

[62705](https://github.com/flutter/flutter/pull/62705) 1.20 CP: Update engine hash to 1.20.0-7.4.pre (cla: yes, engine)

[62707](https://github.com/flutter/flutter/pull/62707) Fix text escaping in the AboutListTile sample code (cla: yes, f: material design, framework, waiting for tree to go green)

[62710](https://github.com/flutter/flutter/pull/62710) Update prepare_package.dart to use the process_runner package instead having duplicate code. (cla: yes, team)

[62712](https://github.com/flutter/flutter/pull/62712) Add onAppPrivateCommand to TextField (cla: yes, f: material design, framework, waiting for tree to go green)

[62715](https://github.com/flutter/flutter/pull/62715) add benchmark for ChangeNotifier.notifyListeners (cla: yes, framework, team, waiting for tree to go green)

[62729](https://github.com/flutter/flutter/pull/62729) Upadte systemNavigationBarIconBrightness docs (cla: yes, framework, waiting for tree to go green)

[62741](https://github.com/flutter/flutter/pull/62741) Deprecate iOS13 style ActivityIndicator (cla: yes, f: cupertino, framework, waiting for tree to go green)

[62755](https://github.com/flutter/flutter/pull/62755) Add punctuation for unterminated sentences in doc comments (a: accessibility, a: internationalization, a: tests, cla: yes, d: api docs, documentation, f: cupertino, f: material design, framework, tool)

[62761](https://github.com/flutter/flutter/pull/62761) Fix lifecycle clean up in the material date picker tests for screen size and semantics. (a: internationalization, cla: yes, f: material design, framework, waiting for tree to go green)

[62778](https://github.com/flutter/flutter/pull/62778) text selection affinity can be null on web (cla: yes, framework, waiting for tree to go green)

[62788](https://github.com/flutter/flutter/pull/62788) Add onTertiaryTap* to TapGestureRecognizer and GestureDetector (a: accessibility, cla: yes, framework, waiting for tree to go green)

[62792](https://github.com/flutter/flutter/pull/62792) Remove mistakenly added DartDevelopmentService dependency (cla: yes, tool)

[62795](https://github.com/flutter/flutter/pull/62795) Fix sort indicator for DataTables (cla: yes, f: material design, framework)

[62799](https://github.com/flutter/flutter/pull/62799) move compile/target sdk versions to 29 (a: accessibility, cla: yes, d: examples, team, tool, waiting for tree to go green)

[62803](https://github.com/flutter/flutter/pull/62803) Address misc time picker design issues (a: internationalization, cla: yes, f: material design, framework, waiting for tree to go green)

[62805](https://github.com/flutter/flutter/pull/62805) Add “See also” links to favorite class API docs (cla: yes, d: api docs, documentation, f: material design, framework, waiting for tree to go green)

[62809](https://github.com/flutter/flutter/pull/62809) [null-safety] remove some usages of mockito (a: tests, cla: yes, framework, waiting for tree to go green)

[62814](https://github.com/flutter/flutter/pull/62814) Report failures in docs.sh (team, waiting for tree to go green)

[62816](https://github.com/flutter/flutter/pull/62816) Removed old button widget references from dev/manual_tests (team, waiting for tree to go green)

[62820](https://github.com/flutter/flutter/pull/62820) Update skipped test comment to point to an open bug (framework, waiting for tree to go green)

[62823](https://github.com/flutter/flutter/pull/62823) Unskip the bidi semantics test. (framework, waiting for tree to go green)

[62824](https://github.com/flutter/flutter/pull/62824) Unskip a widget inspector test that doesn't seem flaky anymore. (framework, waiting for tree to go green)

[62825](https://github.com/flutter/flutter/pull/62825) Enable a scrolling fling test. (framework, waiting for tree to go green)

[62828](https://github.com/flutter/flutter/pull/62828) Add native stacktrace field for PlatformException (framework)

[62835](https://github.com/flutter/flutter/pull/62835) 1.20 stable: Update engine hash to 1.20.0 (engine, work in progress; do not review)

[62840](https://github.com/flutter/flutter/pull/62840) [ExpansionPanelList] adds elevation property (f: material design, framework, waiting for tree to go green, will affect goldens)

[62859](https://github.com/flutter/flutter/pull/62859) Add gaplessPlayback docs default discussion (d: api docs, documentation, framework, waiting for tree to go green)

[62866](https://github.com/flutter/flutter/pull/62866) [null-safety] remove quiver from flutter tests (framework, team, waiting for tree to go green)

[62868](https://github.com/flutter/flutter/pull/62868) Revert "migrate part of painting to nullsafety" (framework)

[62869](https://github.com/flutter/flutter/pull/62869) [null-safety] remove mockito from text control a11y test (framework, waiting for tree to go green)

[62872](https://github.com/flutter/flutter/pull/62872) Reland "migrate part of painting to nullsafety (#62696)" (framework, team, waiting for tree to go green)

[62884](https://github.com/flutter/flutter/pull/62884) Revert "move compile/target sdk versions to 29" (a: accessibility, d: examples, team, tool)

[62888](https://github.com/flutter/flutter/pull/62888) Update error message for bad UTF-8 decoding (tool, waiting for tree to go green)

[62891](https://github.com/flutter/flutter/pull/62891) Make _isLocalCreationLocation public (framework, waiting for tree to go green)

[62892](https://github.com/flutter/flutter/pull/62892) There's a bug filed about this now, so update comment. (tool, waiting for tree to go green)

[62893](https://github.com/flutter/flutter/pull/62893) Update link to bug (tool, waiting for tree to go green)

[62894](https://github.com/flutter/flutter/pull/62894) [null-safety] revert export of Fake from test_api (a: tests, framework, waiting for tree to go green)

[62897](https://github.com/flutter/flutter/pull/62897) Fix GestureDetector long press callback handling (framework)

[62898](https://github.com/flutter/flutter/pull/62898) Make the Skia expectation parser more resilient and update to "master_str" (a: tests, framework, team, waiting for tree to go green)

[62902](https://github.com/flutter/flutter/pull/62902) Change minimum iOS version from 8.0 to 9.0 (d: examples, platform-ios, team, tool, waiting for tree to go green)

[62903](https://github.com/flutter/flutter/pull/62903) Revert "remove iOS folder (#61561)" (cp: 1.20, cp: 1.20 completed, engine, framework, team, tool)

[62904](https://github.com/flutter/flutter/pull/62904) ISSUE_TEMPLATE changes (a: triage improvements, framework, team, waiting for tree to go green)

[62906](https://github.com/flutter/flutter/pull/62906) Add remaining benchmarks (team, waiting for tree to go green)

[62910](https://github.com/flutter/flutter/pull/62910) Add flutter_goldens_client to testing path (a: tests, team, team: infra, waiting for tree to go green)

[62913](https://github.com/flutter/flutter/pull/62913) Enable InkWell to sync its hovered state when its enabled or disabled (f: material design, framework)

[62914](https://github.com/flutter/flutter/pull/62914) revert WidgetTester.pumpAndSettle breaking change (a: tests, framework, waiting for tree to go green)

[62920](https://github.com/flutter/flutter/pull/62920) Add a comment with a reference to issue 62919 (team, waiting for tree to go green)

[62926](https://github.com/flutter/flutter/pull/62926) [flutter_tools] remove reference to flutter tool test from user generated gitignore (tool, waiting for tree to go green)

[62930](https://github.com/flutter/flutter/pull/62930) [flutter_tools] warn when main library is relocated (tool, waiting for tree to go green)

[62932](https://github.com/flutter/flutter/pull/62932) Updated examples/layers to use the new button API. (d: examples, team, waiting for tree to go green)

[62933](https://github.com/flutter/flutter/pull/62933) [engine] update for frameTiming (flutter/engine#20229) (framework, waiting for tree to go green)

[62936](https://github.com/flutter/flutter/pull/62936) [null-safety] remove more usage of mockito from the framework tests (f: material design, framework, waiting for tree to go green)

[62937](https://github.com/flutter/flutter/pull/62937) Update engine hash to 1.20.0 w/ #20238 (engine)

[62946](https://github.com/flutter/flutter/pull/62946) [null-safety] update to several framework test cases/APIs for null assertions (a: tests, cla: yes, framework, team, tool, waiting for tree to go green)

[62951](https://github.com/flutter/flutter/pull/62951) migrate part of painting to nullsafety (a: null-safety, framework, waiting for tree to go green)

[62954](https://github.com/flutter/flutter/pull/62954) fix some comment errors for clipBehavior's default value (framework, waiting for tree to go green)

[62972](https://github.com/flutter/flutter/pull/62972) non-nullable LicenseEntry.packages (framework)

[62979](https://github.com/flutter/flutter/pull/62979) Add libblkid as an explicit dependancy on Linux (tool, waiting for tree to go green)

[62986](https://github.com/flutter/flutter/pull/62986) Pin gallery version (team, waiting for tree to go green)

[62987](https://github.com/flutter/flutter/pull/62987) Rev json gem (team, waiting for tree to go green)

[62990](https://github.com/flutter/flutter/pull/62990) [hotfix] flutter create -t plugin remove no-op iOS folder and set sdk min to 1.20.0 (engine, framework, team, tool)

[62999](https://github.com/flutter/flutter/pull/62999) Add flutter_engine.cc to Windows wrapper build (a: desktop, platform-windows, tool, waiting for tree to go green)

[63005](https://github.com/flutter/flutter/pull/63005) Incomplete app widget error (framework, waiting for tree to go green)

[63007](https://github.com/flutter/flutter/pull/63007) Ignore dead_code hints for weak-only null checks. (framework)

[63008](https://github.com/flutter/flutter/pull/63008) move compile/target sdk versions to 29 (#62799) (a: accessibility, d: examples, team, tool, waiting for tree to go green)

[63012](https://github.com/flutter/flutter/pull/63012) Remove old button references from the Stepper widget (f: material design, framework)

[63013](https://github.com/flutter/flutter/pull/63013) Remove old button references from routes_test (framework, waiting for tree to go green)

[63014](https://github.com/flutter/flutter/pull/63014) Mark nonflaky test as such (team, waiting for tree to go green)

[63017](https://github.com/flutter/flutter/pull/63017) update packages (team, tool, waiting for tree to go green)

[63019](https://github.com/flutter/flutter/pull/63019) [flutter_tools] flutter version reports picks up release versions (tool, waiting for tree to go green)

[63021](https://github.com/flutter/flutter/pull/63021) Mark named_isolates_test flaky (team)

[63026](https://github.com/flutter/flutter/pull/63026) Update to the latest localizations - Adds missing DatePicker strings and fixes manually entering date for German (a: internationalization, f: cupertino, f: material design, framework, waiting for tree to go green)

[63028](https://github.com/flutter/flutter/pull/63028) Remove cubic_bezier_perf.dart (team, waiting for tree to go green)

[63030](https://github.com/flutter/flutter/pull/63030) using named constructor to FrameTiming in scheduler_test.dart (a: tests, engine, framework, waiting for tree to go green)

[63034](https://github.com/flutter/flutter/pull/63034) Remove Special Handling of Norwegian Locales (a: internationalization, f: cupertino, f: material design, framework, team)

[63040](https://github.com/flutter/flutter/pull/63040) Updated flutter_localizations picker tests to use new button classes. (a: internationalization, f: material design)

[63054](https://github.com/flutter/flutter/pull/63054) fix SingleChildScrollView clip bug (a: quality, f: scrolling, framework, waiting for tree to go green)

[63057](https://github.com/flutter/flutter/pull/63057) handler can be null in platform_channel (framework, waiting for tree to go green)

[63083](https://github.com/flutter/flutter/pull/63083) unnecessary null check (framework, waiting for tree to go green)

[63094](https://github.com/flutter/flutter/pull/63094) Fixed a typo in the DataRow API doc (f: material design, framework, waiting for tree to go green)

[63111](https://github.com/flutter/flutter/pull/63111) Bump dartdoc to 0.32.3 and tighten doc output checker (team, waiting for tree to go green)

[63113](https://github.com/flutter/flutter/pull/63113) Revert "Add padding around flutter api docs search input" (team, waiting for tree to go green)

[63118](https://github.com/flutter/flutter/pull/63118) reland fix intrinsic height and width for widget span #61485 (framework, waiting for tree to go green)

[63124](https://github.com/flutter/flutter/pull/63124) Measure CPU/GPU with the simple animation test (perf: energy, severe: performance, team, waiting for tree to go green)

[63128](https://github.com/flutter/flutter/pull/63128) remove flaky flag for multi_widget_construction_perf__e2e_summary (team, waiting for tree to go green)

[63131](https://github.com/flutter/flutter/pull/63131) Make Scrollables restorable (framework, waiting for tree to go green)

[63132](https://github.com/flutter/flutter/pull/63132) Fix grammar in Route doc comment (d: api docs, documentation, f: routes, framework, waiting for tree to go green)

[63142](https://github.com/flutter/flutter/pull/63142) Fix a crash when disposing tabs (f: material design, framework, waiting for tree to go green)

[63146](https://github.com/flutter/flutter/pull/63146) Fix RangeMaintainingScrollPhysics (framework)

[63147](https://github.com/flutter/flutter/pull/63147) Add clipBehavior to ListView, GridView, PageView (cla: yes, f: scrolling, framework)

[63154](https://github.com/flutter/flutter/pull/63154) Update "shortcut icon" to "icon" in Web Template (tool, waiting for tree to go green)

[63192](https://github.com/flutter/flutter/pull/63192) Add viewport documentation breadcrumbs (cla: yes, framework, waiting for tree to go green)

[63194](https://github.com/flutter/flutter/pull/63194) API doc additions (framework, waiting for tree to go green)

[63197](https://github.com/flutter/flutter/pull/63197) Prepare macrobenchmarks' e2e tests for firebase test lab (team, waiting for tree to go green)

[63213](https://github.com/flutter/flutter/pull/63213) Updated old button references in dev/integration_tests/ui (team)

[63214](https://github.com/flutter/flutter/pull/63214) Updated old button references in dev/integration_tests/android_views (team)

[63215](https://github.com/flutter/flutter/pull/63215) Updated old button references in dev/integration_tests/hybrid_android_views (team)

[63225](https://github.com/flutter/flutter/pull/63225) Cherrypick engine 5e9eede19290de1f288d8d3d21d390f4b3093338 (engine)

[63230](https://github.com/flutter/flutter/pull/63230) Updated old button references in packages/flutter_test (a: tests, framework)

[63232](https://github.com/flutter/flutter/pull/63232) Updated old button references in dev/integration_tests/android_semantics (a: accessibility, team)

[63236](https://github.com/flutter/flutter/pull/63236) Updated use of OutlineButton in FocusTraversalPolicy API doc (framework)

[63245](https://github.com/flutter/flutter/pull/63245) Add framework and hostonly tests to luci presubmit. (team, waiting for tree to go green)

[63249](https://github.com/flutter/flutter/pull/63249) Fix title color of license detail page (cla: yes, f: material design, framework, waiting for tree to go green)

[63250](https://github.com/flutter/flutter/pull/63250) [flutter tools] Make SizeAnalyzer support .apk files that don't use libapp.so (tool, waiting for tree to go green)

[63252](https://github.com/flutter/flutter/pull/63252) Bump Cirrus image Xcode version (cla: yes, platform-ios, team, team: infra)

[63257](https://github.com/flutter/flutter/pull/63257) Remove hostonly_tests from cirrus as they are now running on LUCI. (cla: yes, team)

[63273](https://github.com/flutter/flutter/pull/63273) Fixing code snippet example for meetsGuideline. (a: tests, d: api docs, documentation, framework, waiting for tree to go green)

[63301](https://github.com/flutter/flutter/pull/63301) [Windows] Fix unnecessary surface creation/destruction in startup path (cla: yes, tool, waiting for tree to go green)

[63306](https://github.com/flutter/flutter/pull/63306) Clean up some test formatting and comments (framework, waiting for tree to go green)

[63313](https://github.com/flutter/flutter/pull/63313) Small documentation typo fix (d: api docs, documentation, framework, waiting for tree to go green)

[63336](https://github.com/flutter/flutter/pull/63336) Remove unused `l` and `--isolate-filter` tools (team, tool, waiting for tree to go green)

[63339](https://github.com/flutter/flutter/pull/63339) Remove enableR8=true from gradle.properties (tool, waiting for tree to go green)

[63347](https://github.com/flutter/flutter/pull/63347) Some minor improvements to the AsyncSnapshot API (framework, waiting for tree to go green)

[63352](https://github.com/flutter/flutter/pull/63352) Clip image of BoxDecoration to circle when shape is BoxShape.circle (a: quality, framework, waiting for tree to go green)

[63368](https://github.com/flutter/flutter/pull/63368) [gen_l10n] Absolute project path parameter (a: internationalization, team, tool, waiting for tree to go green)

[63390](https://github.com/flutter/flutter/pull/63390) update for WidgetTester.move and WidgetTester.fling doc (a: tests, framework, waiting for tree to go green)

[63396](https://github.com/flutter/flutter/pull/63396) Fixed an ElevatedButton API doc typo (f: material design, framework)

[63400](https://github.com/flutter/flutter/pull/63400) Updated old button references in dev/integration_tests/flutter_gallery … cards_demo (f: material design, team)

[63401](https://github.com/flutter/flutter/pull/63401) Make textfields restorable (cla: yes, f: cupertino, f: material design, framework)

[63402](https://github.com/flutter/flutter/pull/63402) Updated old button references in dev/integration_tests/flutter_gallery … banner_demo (f: material design, team)

[63404](https://github.com/flutter/flutter/pull/63404) Updated old button references in dev/integration_tests/flutter_gallery … drawer_demo (f: material design, team)

[63405](https://github.com/flutter/flutter/pull/63405) Ensure cupertino time picker positions hours and minutes correctly for RTL (a: internationalization, f: cupertino, framework)

[63410](https://github.com/flutter/flutter/pull/63410) WidgetTester.drag with time duration (a: tests, cla: yes, framework, team, waiting for tree to go green)

[63412](https://github.com/flutter/flutter/pull/63412) Fix App.framework path in Podfile (a: existing-apps, cla: yes, platform-ios, team, tool, waiting for tree to go green)

[63416](https://github.com/flutter/flutter/pull/63416) [flutter_tools] add --null-assertions flag for debugging with null safety (tool, waiting for tree to go green)

[63417](https://github.com/flutter/flutter/pull/63417) Make modifier key side handling consistent among platforms (framework)

[63420](https://github.com/flutter/flutter/pull/63420) fix wrap intrinsic height calculation (a: layout, a: quality, cla: yes, framework, waiting for tree to go green)

[63426](https://github.com/flutter/flutter/pull/63426) Make RawKeyboard assert when no keys are in keysPressed when sending a key down event. (framework)

[63430](https://github.com/flutter/flutter/pull/63430) Updated old button references in dev/integration_tests/flutter_gallery leave_behind_demo (f: material design, team)

[63431](https://github.com/flutter/flutter/pull/63431) Revert "Add native stacktrace field for PlatformException" (framework)

[63432](https://github.com/flutter/flutter/pull/63432) Updated old button references in dev/integration_tests/flutter_gallery ... transformation_demo (team)

[63433](https://github.com/flutter/flutter/pull/63433) Remove more timeouts (tool, waiting for tree to go green)

[63434](https://github.com/flutter/flutter/pull/63434) add FrameTimingSummarizer (a: tests, framework, team, waiting for tree to go green)

[63436](https://github.com/flutter/flutter/pull/63436) Trivial typo fixes to snippets documentation (cla: yes, team, waiting for tree to go green)

[63438](https://github.com/flutter/flutter/pull/63438) More restoration documentation (cla: yes, d: api docs, d: examples, documentation, framework, team, waiting for tree to go green)

[63439](https://github.com/flutter/flutter/pull/63439) Enable builds in presubmit and remove old ones. (team, waiting for tree to go green)

[63445](https://github.com/flutter/flutter/pull/63445) Pin iOS module test plugin versions (a: existing-apps, a: tests, platform-ios, team, waiting for tree to go green)

[63446](https://github.com/flutter/flutter/pull/63446) [flutter_tools] add more error context to tree shaker failure (tool, waiting for tree to go green)

[63448](https://github.com/flutter/flutter/pull/63448) Temporarily turn off module_test_ios during investigation (platform-ios, team)

[63455](https://github.com/flutter/flutter/pull/63455) Fix SafeArea and SliverSafeArea debug flag properties (cla: yes, framework, waiting for tree to go green)

[63461](https://github.com/flutter/flutter/pull/63461) Removed the inputFormatters from the text input fields used by the Date Pickers (f: material design, framework, waiting for tree to go green)

[63491](https://github.com/flutter/flutter/pull/63491) Updated old button references in dev/integration_tests/flutter_gallery ... full_screen_dialog_demo (f: material design, team)

[63492](https://github.com/flutter/flutter/pull/63492) Update prod builders. (cla: yes, team)

[63495](https://github.com/flutter/flutter/pull/63495) migrate part of painting to nullsafety (framework, waiting for tree to go green)

[63497](https://github.com/flutter/flutter/pull/63497) Add dispose to restoration example (d: api docs, d: examples, documentation, framework, waiting for tree to go green)

[63502](https://github.com/flutter/flutter/pull/63502) Add native stacktrace field for PlatformException (cla: yes, framework)

[63503](https://github.com/flutter/flutter/pull/63503) Update: Documentation for ListView constructor should warn about changing widget list (cla: yes, d: api docs, documentation, framework, waiting for tree to go green)

[63505](https://github.com/flutter/flutter/pull/63505) Fix version parsing (cla: yes, tool)

[63515](https://github.com/flutter/flutter/pull/63515) allow null in compute for weak mode (cla: yes, framework, waiting for tree to go green)

[63517](https://github.com/flutter/flutter/pull/63517) Move Android doctor SDK check to 29 and Cirrus images to 30 (a: accessibility, cla: yes, d: examples, team, tool)

[63518](https://github.com/flutter/flutter/pull/63518) Hide benchmark a/b results from git (cla: yes, team, waiting for tree to go green)

[63523](https://github.com/flutter/flutter/pull/63523) Standardize the nullability of arguments to raw key data constructors. (a: tests, cla: yes, framework, team)

[63526](https://github.com/flutter/flutter/pull/63526) [flutter_tools] handle invalid yaml in plugin dependency (cla: yes, tool, waiting for tree to go green)

[63532](https://github.com/flutter/flutter/pull/63532) Remove unused files (cla: yes, team, waiting for tree to go green)

[63536](https://github.com/flutter/flutter/pull/63536) [flutter_tools] move to fake_async, skip failing tests (cla: yes, team, tool, waiting for tree to go green)

[63538](https://github.com/flutter/flutter/pull/63538) Print dex when analyzing the APK (cla: yes, team, waiting for tree to go green)

[63540](https://github.com/flutter/flutter/pull/63540) [flutter_tools] check for permission issues when copying file (cla: yes, tool, waiting for tree to go green)

[63543](https://github.com/flutter/flutter/pull/63543) InteractiveViewer scale interpretation improvement (cla: yes, framework, waiting for tree to go green)

[63591](https://github.com/flutter/flutter/pull/63591) 1.20.2 Cherrypicks (a: internationalization, cla: yes, engine, f: material design, framework, team, tool, work in progress; do not review)

[63592](https://github.com/flutter/flutter/pull/63592) Hook up soft keyboard "next" and "previous" buttons so that they move the focus by default (cla: yes, framework)

[63593](https://github.com/flutter/flutter/pull/63593) Pin goldctl (cla: yes, team, team: infra, waiting for tree to go green)

[63594](https://github.com/flutter/flutter/pull/63594) Add win (cla: yes, team, waiting for tree to go green)

[63595](https://github.com/flutter/flutter/pull/63595) Disables tests failing due to new semantics flag. (a: accessibility, a: tests, cla: yes, framework, waiting for tree to go green)

[63598](https://github.com/flutter/flutter/pull/63598) Add arguments for required parameters. (cla: yes, framework, team)

[63599](https://github.com/flutter/flutter/pull/63599) Ensure time picker input mode lays out correctly in RTL (a: internationalization, cla: yes, f: material design, framework, waiting for tree to go green)

[63600](https://github.com/flutter/flutter/pull/63600) Typo fix in finders.dart documentation (bySemanticsLabel) (a: tests, cla: yes, d: api docs, framework)

[63602](https://github.com/flutter/flutter/pull/63602) Ignore another dead_code hint for a weak-only null check. (cla: yes, framework, waiting for tree to go green)

[63604](https://github.com/flutter/flutter/pull/63604) Update LinearGradient docs (cla: yes, framework, waiting for tree to go green)

[63605](https://github.com/flutter/flutter/pull/63605) remove fuchsia_entrypoint_shim directory (cla: yes, team, tool, waiting for tree to go green)

[63608](https://github.com/flutter/flutter/pull/63608) Revert: Update prepare_package.dart to use the process_runner package instead having duplicate code. #62710 (cla: yes, team)

[63609](https://github.com/flutter/flutter/pull/63609) Clean up flutter_gallery__transition_perf (a: accessibility, cla: yes, team, waiting for tree to go green)

[63610](https://github.com/flutter/flutter/pull/63610) [flutter_tools] support code size tooling on iOS, linux, windows, macOS, and Android on Windows (cla: yes, tool)

[63611](https://github.com/flutter/flutter/pull/63611) Revert "Fix RangeMaintainingScrollPhysics" (cla: yes, framework, waiting for tree to go green)

[63612](https://github.com/flutter/flutter/pull/63612) [windows] Propagate startup errors in template (cla: yes, tool, waiting for tree to go green)

[63617](https://github.com/flutter/flutter/pull/63617) [flutter_tools] update size analysis version (cla: yes, team, waiting for tree to go green)

[63634](https://github.com/flutter/flutter/pull/63634) Improve docs for [PageStorage] (cla: yes, framework, waiting for tree to go green)

[63639](https://github.com/flutter/flutter/pull/63639) Warns when single line text fields overflow (a: tests, cla: yes, framework, waiting for tree to go green)

[63649](https://github.com/flutter/flutter/pull/63649) gen_l10n: support string list as preferred-supported-locales, as documented (cla: yes, team, tool)

[63652](https://github.com/flutter/flutter/pull/63652) Add debug flag `debugProfileLayoutsEnabled` (cla: yes, framework, waiting for tree to go green)

[63668](https://github.com/flutter/flutter/pull/63668) Fix FittedBox BoxFit.scaleDown sizing (cla: yes, framework, waiting for tree to go green)

[63687](https://github.com/flutter/flutter/pull/63687) Remove decommission from RestorationBuckets (a: tests, cla: yes, framework, waiting for tree to go green)

[63692](https://github.com/flutter/flutter/pull/63692) "Draw" vs "drawer" typo (cla: yes, d: api docs, documentation, f: material design, framework, waiting for tree to go green)

[63695](https://github.com/flutter/flutter/pull/63695) Cherrypick engine hash to 7c89b4191329302d31f0d491f3aedb623ac7393b (cla: yes, engine)

[63697](https://github.com/flutter/flutter/pull/63697) [flutter_tools] remove most globals from build system and tests (cla: yes, tool, waiting for tree to go green)

[63703](https://github.com/flutter/flutter/pull/63703) migrate painting to nullsafety (cla: yes, framework, waiting for tree to go green)

[63705](https://github.com/flutter/flutter/pull/63705) Revert "Add native stacktrace field for PlatformException" (cla: yes, framework)

[63707](https://github.com/flutter/flutter/pull/63707) Surface Windows build errors in non-verbose mode (a: build, a: desktop, cla: yes, platform-windows, tool, waiting for tree to go green)

[63726](https://github.com/flutter/flutter/pull/63726) Add windows builders to presubmit. (cla: yes, team)

[63728](https://github.com/flutter/flutter/pull/63728) Provide the argument for a required parameter 'data'. (a: tests, cla: yes, framework, waiting for tree to go green)

[63730](https://github.com/flutter/flutter/pull/63730) Add an infra issue template (cla: yes, waiting for tree to go green)

[63736](https://github.com/flutter/flutter/pull/63736) Update task_names to add the platform. (cla: yes, team, waiting for tree to go green)

[63754](https://github.com/flutter/flutter/pull/63754) [EditableText] Fix TextField crashed with composing and maxLength set (cla: yes, framework, waiting for tree to go green)

[63775](https://github.com/flutter/flutter/pull/63775) DecoratedBoxTransition sample code (cla: yes, framework, waiting for tree to go green)

[63776](https://github.com/flutter/flutter/pull/63776) Mention time picker theme in showTimePicker documentation (cla: yes, documentation, f: material design, framework, waiting for tree to go green)

[63777](https://github.com/flutter/flutter/pull/63777) Cherry pick engine (cla: yes, engine)

[63783](https://github.com/flutter/flutter/pull/63783) Add enabled flag for try builders (cla: yes, team)

[63784](https://github.com/flutter/flutter/pull/63784) Use reportError (over onError) everywhere (cla: yes, framework, waiting for tree to go green)

[63786](https://github.com/flutter/flutter/pull/63786) Make SelectableText work better on web (a: text input, a: typography, cla: yes, framework, platform-web, waiting for tree to go green)

[63794](https://github.com/flutter/flutter/pull/63794) Ignore/fix dead_code checks for weak-only null checks. (cla: yes, framework)

[63795](https://github.com/flutter/flutter/pull/63795) Return host and port from devtools launcher (cla: yes, tool, waiting for tree to go green)

[63796](https://github.com/flutter/flutter/pull/63796) [flutter_tool] Fix some create_test.dart tests on Windows (cla: yes, tool)

[63797](https://github.com/flutter/flutter/pull/63797) add flutter_gallery__transition_perf_e2e to ios tests (cla: yes, team, waiting for tree to go green)

[63799](https://github.com/flutter/flutter/pull/63799) bug fix for flutter_gallery__transition_perf(_with_semantics) (a: accessibility, cla: yes, team)

[63801](https://github.com/flutter/flutter/pull/63801) Mark nonflaky tests as such (cla: yes, team, waiting for tree to go green)

[63804](https://github.com/flutter/flutter/pull/63804) drop xcpretty for tests (cla: yes, team)

[63806](https://github.com/flutter/flutter/pull/63806) [flutter_tool] Handle Windows line endings in packages_test.dart (cla: yes, tool, waiting for tree to go green)

[63810](https://github.com/flutter/flutter/pull/63810) Separate blkid in the Linux library checks (cla: yes, tool, waiting for tree to go green)

[63815](https://github.com/flutter/flutter/pull/63815) [flutter_tools] correctly forward error only stdout in non-verbose modes (cla: yes, team, tool, waiting for tree to go green)

[63816](https://github.com/flutter/flutter/pull/63816) bug fix for pointer id in test gestures (a: tests, cla: yes, framework, waiting for tree to go green)

[63817](https://github.com/flutter/flutter/pull/63817) Fix some doc typo (a: tests, cla: yes, framework, waiting for tree to go green)

[63818](https://github.com/flutter/flutter/pull/63818) [flutter_tools] add cache busting query param (cla: yes, tool, waiting for tree to go green)

[63829](https://github.com/flutter/flutter/pull/63829) Make deprecation notice link to website downloads (cla: yes, tool, waiting for tree to go green)

[63831](https://github.com/flutter/flutter/pull/63831) [flutter_tools] remove globals from utils (cla: yes, tool, waiting for tree to go green)

[63833](https://github.com/flutter/flutter/pull/63833) SizeTransition sample code (a: animation, cla: yes, d: api docs, d: examples, documentation, framework, waiting for tree to go green)

[63835](https://github.com/flutter/flutter/pull/63835) add vsync overhead to `FrameTimingSummarizer` (a: tests, cla: yes, framework, waiting for tree to go green)

[63839](https://github.com/flutter/flutter/pull/63839) Limit about to <200 chars in the infra issue template (cla: yes, waiting for tree to go green)

[63840](https://github.com/flutter/flutter/pull/63840) [flutter_tools] shrink fingerprinter API to currently used subset (cla: yes, tool, waiting for tree to go green)

[63867](https://github.com/flutter/flutter/pull/63867) [flutter_tools] shrink API surface of Android SDK (cla: yes, tool)

[63884](https://github.com/flutter/flutter/pull/63884) updated_title_property_apidocs (cla: yes, d: api docs, documentation, framework, platform-web, waiting for tree to go green)

[63886](https://github.com/flutter/flutter/pull/63886) Add sample code for ScaleTransition (a: animation, cla: yes, d: api docs, d: examples, documentation, framework, waiting for tree to go green)

[63924](https://github.com/flutter/flutter/pull/63924) Remove TODOs added for HTTP abort() change in dart sdk (a: tests, cla: yes, framework, tool)

[63925](https://github.com/flutter/flutter/pull/63925) Fix bug when tapping ListTitle with CheckboxListTile  tristate enable (cla: yes, f: cupertino, f: material design, framework)

[63940](https://github.com/flutter/flutter/pull/63940) Add sample code to RelativePositionedTransition (a: animation, cla: yes, d: api docs, d: examples, documentation, framework, waiting for tree to go green)

[63969](https://github.com/flutter/flutter/pull/63969) Revert "Roll Engine from 7571e7c380fd to b300be3df32b (60 revisions)" (cla: yes, engine)

[63972](https://github.com/flutter/flutter/pull/63972) Revert "Remove TODOs added for HTTP abort() change in dart sdk" (a: tests, cla: yes, framework, tool)

[63974](https://github.com/flutter/flutter/pull/63974) Move away from deprecated NoSuchMethodError to NoSuchMethodError.withInvocation (cla: yes, framework, waiting for tree to go green)

[63976](https://github.com/flutter/flutter/pull/63976) [flutter_tools] trim trailing newline from vm service logging events (cla: yes, tool, waiting for tree to go green)

[63981](https://github.com/flutter/flutter/pull/63981) Fixed the docs of the focusColor property included in input_decorator (cla: yes, d: api docs, documentation, f: material design, framework, waiting for tree to go green)

[63983](https://github.com/flutter/flutter/pull/63983) In macrobenchmarks e2e tests: ensureVisible => scrollUntilVisible (cla: yes, team, waiting for tree to go green)

[63991](https://github.com/flutter/flutter/pull/63991) Revert "Roll Engine from 7571e7c380fd to 613be923b132 (76 revisions)" (cla: yes, engine)

[63994](https://github.com/flutter/flutter/pull/63994) SelectableText long press on iOS (cla: yes, f: material design, framework, waiting for tree to go green)

[63995](https://github.com/flutter/flutter/pull/63995) Make cirrus tests presubmit only and add new luci tests. (cla: yes, team, waiting for tree to go green)

[64000](https://github.com/flutter/flutter/pull/64000) Rename needsMeasureCpuGpu to measureCpuGpu (cla: yes, team, waiting for tree to go green)

[64002](https://github.com/flutter/flutter/pull/64002) Increase simple animation delay and duration (cla: yes, team)

[64004](https://github.com/flutter/flutter/pull/64004) [devicelab] Enable a LUCI try builder. (cla: yes, team, waiting for tree to go green)

[64009](https://github.com/flutter/flutter/pull/64009) report list of detail files so devicelab can save them (cla: yes, team)

[64012](https://github.com/flutter/flutter/pull/64012) ClipboardStatusNotifier should handle errors in Clipboard.getData (cla: yes, framework, waiting for tree to go green)

[64015](https://github.com/flutter/flutter/pull/64015) macrobenchmarks remove duplicate e2e driver (cla: yes, team, waiting for tree to go green)

[64020](https://github.com/flutter/flutter/pull/64020) [flutter_tool] Fix amberctl host address (cla: yes, d: examples, team, tool, waiting for tree to go green)

[64021](https://github.com/flutter/flutter/pull/64021) Use real flutter root for finding pub in command integration test (a: tests, cla: yes, tool)

[64046](https://github.com/flutter/flutter/pull/64046) Revert "fix wrap intrinsic height calculation" (cla: yes, framework)

[64050](https://github.com/flutter/flutter/pull/64050) 1.21.0-9.1.pre cherrypicks (cla: yes, engine, f: material design, framework, team, tool)

[64055](https://github.com/flutter/flutter/pull/64055) migrate semantics to nullsafety (a: accessibility, cla: yes, framework, waiting for tree to go green)

[64056](https://github.com/flutter/flutter/pull/64056) Incorrect path.join usage might be causing Windows test failures (cla: yes, team, waiting for tree to go green)

[64060](https://github.com/flutter/flutter/pull/64060) Restore the original name of the velocity tracker microbenchmark (cla: yes, team, waiting for tree to go green)

[64062](https://github.com/flutter/flutter/pull/64062) Revert "Prevent material switch from recreating its render object when it becomes disabled" (cla: yes, f: material design, framework, waiting for tree to go green)

[64065](https://github.com/flutter/flutter/pull/64065) [flutter_tools] add more info to coverage script (cla: yes, tool, waiting for tree to go green)

[64067](https://github.com/flutter/flutter/pull/64067) [versions] update gallery, roll versions (cla: yes, team, waiting for tree to go green)

[64071](https://github.com/flutter/flutter/pull/64071) [null-safety] enable null assertions for framework tests (cla: yes, framework, team, waiting for tree to go green)

[64076](https://github.com/flutter/flutter/pull/64076) remove ununsed deprecated field (cla: yes, framework, waiting for tree to go green)

[64077](https://github.com/flutter/flutter/pull/64077) Mark tests as nonflaky (cla: yes, team)

[64079](https://github.com/flutter/flutter/pull/64079) update device lab manifest stage and required_agent_capabilities (cla: yes, team, waiting for tree to go green)

[64091](https://github.com/flutter/flutter/pull/64091) Revert "Prevent viewport.showOnScreen from scrolling the viewport if the specified Rect is already visible. " (cla: yes, f: material design, framework)

[64094](https://github.com/flutter/flutter/pull/64094) Revert "Ensure time picker input mode lays out correctly in RTL" (a: internationalization, cla: yes, f: material design, framework)

[64097](https://github.com/flutter/flutter/pull/64097) [Material] Relanding fix to ensure time picker input mode lays out correctly in RTL (a: internationalization, cla: yes, f: material design, framework)

[64100](https://github.com/flutter/flutter/pull/64100) InteractiveViewer child positioning docs (cla: yes, framework, waiting for tree to go green)

[64101](https://github.com/flutter/flutter/pull/64101) ScaffoldMessenger (a: quality, cla: yes, customer: money (g3), f: material design, framework, severe: API break, severe: new feature, team, waiting for tree to go green)

[64102](https://github.com/flutter/flutter/pull/64102) Move engine version to pick Harfbuzz revert (cla: yes, engine)

[64111](https://github.com/flutter/flutter/pull/64111) Fix assert in dartdoc_checker and enable asserts for our helper scripts (cla: yes, team, waiting for tree to go green)

[64112](https://github.com/flutter/flutter/pull/64112) Bump dartdoc to 0.30.4 (cla: yes, team, waiting for tree to go green)

[64115](https://github.com/flutter/flutter/pull/64115) Changes to initialDate for CalendarDatePicker should update the state. (cla: yes, f: material design, framework, waiting for tree to go green)

[64116](https://github.com/flutter/flutter/pull/64116) Fix a data issue in prod_builder.json (cla: yes, team)

[64118](https://github.com/flutter/flutter/pull/64118) Revert "[null-safety] enable null assertions for framework tests" (cla: yes, framework, team)

[64119](https://github.com/flutter/flutter/pull/64119) Change MouseTracker's interface for clarity. Simplify MouseRegion's implementation. (a: desktop, a: mouse, cla: yes, framework)

[64120](https://github.com/flutter/flutter/pull/64120) [flutter_tools] reland: enable --null-assertions for flutter framework tests (a: accessibility, cla: yes, framework, team, waiting for tree to go green)

[64125](https://github.com/flutter/flutter/pull/64125) Remove windows docs from list of try jobs. (cla: yes, team)

[64148](https://github.com/flutter/flutter/pull/64148) Update Visibility docs on maintainSize (cla: yes, d: api docs, documentation, framework, waiting for tree to go green)

[64160](https://github.com/flutter/flutter/pull/64160) [null-safety] roll to null-safe platform (cla: yes, team, tool)

[64166](https://github.com/flutter/flutter/pull/64166) Add WindowProc delegation to Windows template (cla: yes, tool)

[64167](https://github.com/flutter/flutter/pull/64167) Remove unused copyWith arguments in TimePickerThemeData (cla: yes, f: material design, framework, waiting for tree to go green)

[64173](https://github.com/flutter/flutter/pull/64173) Update Windows template for wrapper file change (cla: yes, tool)

[64174](https://github.com/flutter/flutter/pull/64174) Reorder issue templates (cla: yes, waiting for tree to go green)

[64175](https://github.com/flutter/flutter/pull/64175) feat: Text constructor, overflow, and softWrap docs (cla: yes, d: api docs, documentation, framework, waiting for tree to go green)

[64180](https://github.com/flutter/flutter/pull/64180) Add run_if property for existing LUCI try builders (cla: yes, team)

[64181](https://github.com/flutter/flutter/pull/64181) Move v1 embedding migration warning from plugin consumers to all apps (cla: yes, tool)

[64185](https://github.com/flutter/flutter/pull/64185) run the test longer time for multi_widget_construction_perf (cla: yes, team)

[64186](https://github.com/flutter/flutter/pull/64186) [flutter_tools] null assertions off by default for web (cla: yes, team, tool)

[64189](https://github.com/flutter/flutter/pull/64189) (insert|move|remove)ChildRenderObject Deprecation: Step 1 (cla: yes, f: cupertino, f: material design, framework)

[64195](https://github.com/flutter/flutter/pull/64195) [flutter_tools] update dwds, roll to null-safe file and process (cla: yes, team, tool, waiting for tree to go green)

[64199](https://github.com/flutter/flutter/pull/64199) Add native stacktrace field for PlatformException. (cla: yes, framework, waiting for tree to go green)

[64200](https://github.com/flutter/flutter/pull/64200) Ignore unnecessary casts that can go away soon. (cla: yes, framework, waiting for tree to go green)

[64201](https://github.com/flutter/flutter/pull/64201) [flutter_tools] migrate flutter_goldens, flutter_goldens client to null-safety (cla: yes, team, tool, waiting for tree to go green)

[64203](https://github.com/flutter/flutter/pull/64203) Don't fail docs-linux on release branches (cla: yes, team, tool, waiting for tree to go green)

[64214](https://github.com/flutter/flutter/pull/64214) Restore docs linux post submit cirrus (cla: yes)

[64217](https://github.com/flutter/flutter/pull/64217) (insert|move|remove)ChildRenderObject Deprecation: Step 2 (cla: yes, f: cupertino, f: material design, framework)

[64227](https://github.com/flutter/flutter/pull/64227) Add null safety migration annotations. (cla: yes, f: material design, framework, waiting for tree to go green)

[64235](https://github.com/flutter/flutter/pull/64235) fix: typo fixed from ENTER to SPACE (cla: yes, d: api docs, f: material design, framework, waiting for tree to go green)

[64239](https://github.com/flutter/flutter/pull/64239) The OverscrollIndicator should not overflow the scrollable view's edge (cla: yes, f: scrolling, framework, waiting for tree to go green)

[64249](https://github.com/flutter/flutter/pull/64249) Revert "(insert|move|remove)ChildRenderObject Deprecation: Step 1" (cla: yes, f: cupertino, f: material design, framework)

[64251](https://github.com/flutter/flutter/pull/64251) add different workload & add -products * to vswhere calls to check both Visual Studio IDE and standalone Build Tools. (cla: yes, tool, waiting for tree to go green)

[64254](https://github.com/flutter/flutter/pull/64254) Re-apply "(insert|move|remove)ChildRenderObject Deprecation: Step 1" (cla: yes, f: cupertino, f: material design, framework)

[64255](https://github.com/flutter/flutter/pull/64255) Revert "run the test longer time for multi_widget_construction_perf" (cla: yes, team, waiting for tree to go green)

[64258](https://github.com/flutter/flutter/pull/64258) update TimelineStream in `flutter_driver` (a: tests, cla: yes, framework, waiting for tree to go green)

[64267](https://github.com/flutter/flutter/pull/64267) [framework] make hit slop based on device pointer kind for drag/pan/scale gestures (a: desktop, cla: yes, f: gestures, framework)

[64268](https://github.com/flutter/flutter/pull/64268) Fix placement for SnackBarBehavior.floating (a: quality, cla: yes, f: material design, framework, severe: regression, waiting for tree to go green)

[64269](https://github.com/flutter/flutter/pull/64269) Mark e2e version of ios32 transition test nonflaky (cla: yes, team, waiting for tree to go green)

[64271](https://github.com/flutter/flutter/pull/64271) Make large jumpTo recommend deferred loading (a: images, cla: yes, f: scrolling, framework, perf: memory, severe: performance, waiting for tree to go green)

[64273](https://github.com/flutter/flutter/pull/64273) Remove remaining uses of `childToSlot` (cla: yes, f: cupertino, f: material design, framework)

[64275](https://github.com/flutter/flutter/pull/64275) migrate flutter_gallery_sksl_warmup__transition_perf to e2e (cla: yes, team, waiting for tree to go green)

[64276](https://github.com/flutter/flutter/pull/64276) Reland "fix wrap intrinsic height calculation (#63420)" (cla: yes, framework, waiting for tree to go green)

[64277](https://github.com/flutter/flutter/pull/64277) Remove windows_docs. (cla: yes, team, waiting for tree to go green)

[64280](https://github.com/flutter/flutter/pull/64280) [null-safety] remove mockito from refresh control test (cla: yes, f: cupertino, framework, waiting for tree to go green)

[64284](https://github.com/flutter/flutter/pull/64284) [null-safety] remove mockito from network tests (cla: yes, framework, waiting for tree to go green)

[64295](https://github.com/flutter/flutter/pull/64295) Add rect logic to getOffsetToReveal when onlySlivers is true (cla: yes, framework, waiting for tree to go green)

[64308](https://github.com/flutter/flutter/pull/64308) Add finders for enableFlutterDriverExtension (a: tests, cla: yes, framework, waiting for tree to go green)

[64316](https://github.com/flutter/flutter/pull/64316) Add DataTableTheme to allow for themable DataTables (cla: yes, f: material design, framework, waiting for tree to go green)

[64331](https://github.com/flutter/flutter/pull/64331) Add web_smoke_tests to luci. (cla: yes, team)

[64341](https://github.com/flutter/flutter/pull/64341) Mark new_gallery__crane_perf as flaky (cla: yes, team, waiting for tree to go green)

[64350](https://github.com/flutter/flutter/pull/64350) Increase threshold for usage of compute for utf8 decoding on large strings to 50 KB (cla: yes, framework)

[64354](https://github.com/flutter/flutter/pull/64354) Reland "Prevent material switch from recreating its render object when it becomes disabled (#61398)" (cla: yes, f: material design, framework)

[64361](https://github.com/flutter/flutter/pull/64361) Fix LUCI builders config (cla: yes, team)

[64362](https://github.com/flutter/flutter/pull/64362) fix Container.clipBehaviour, clips the shadow in decoration (a: quality, cla: yes, framework, waiting for tree to go green, will affect goldens)

[64363](https://github.com/flutter/flutter/pull/64363) [null-safety] remove mockito from route test (cla: yes, f: cupertino, framework, waiting for tree to go green)

[64364](https://github.com/flutter/flutter/pull/64364) Change typo profileDemos to restDemos (cla: yes, team, waiting for tree to go green)

[64372](https://github.com/flutter/flutter/pull/64372) Revert "Increase threshold for usage of compute for utf8 decoding on large strings to 50 KB" (cla: yes, framework)

[64380](https://github.com/flutter/flutter/pull/64380) Fix TabBar jag when user interrupts ballistic scroll (cla: yes, f: material design, framework, waiting for tree to go green)

[64403](https://github.com/flutter/flutter/pull/64403) [flutter_tools] flutter run should allow exit when make choose for devices. (cla: yes, tool, waiting for tree to go green)

[64424](https://github.com/flutter/flutter/pull/64424) Add resampler unit test with widget (cla: yes, framework, waiting for tree to go green)

[64431](https://github.com/flutter/flutter/pull/64431) Add GestureDetector.onDoubleTapDown() (cla: yes, framework)

[64432](https://github.com/flutter/flutter/pull/64432) Reland "Make sure all isolates start during flutter driver tests" (a: tests, cla: yes, d: examples, framework, team, waiting for tree to go green)

[64440](https://github.com/flutter/flutter/pull/64440) Pass --verbose-logging to flutter_tester (cla: yes, tool)

[64441](https://github.com/flutter/flutter/pull/64441) Fix negative usableCrossAxisExtent in release mode (cla: yes, framework, waiting for tree to go green)

[64472](https://github.com/flutter/flutter/pull/64472) Update origin material button API doc with obsolete API warnings (cla: yes, f: material design, framework)

[64474](https://github.com/flutter/flutter/pull/64474) Protect against null context in action invoke in release mode (cla: yes, framework, waiting for tree to go green)

[64483](https://github.com/flutter/flutter/pull/64483) Removed deprecated ContainedButton and ContainedButtonTheme classes (cla: yes, f: material design, framework)

[64486](https://github.com/flutter/flutter/pull/64486) [devicelab] disable image list duration tests (cla: yes, team)

[64493](https://github.com/flutter/flutter/pull/64493) [null-safety] remove mockito from scrollbar test (cla: yes, framework)

[64498](https://github.com/flutter/flutter/pull/64498) Reland: Increase threshold for usage of compute for utf8 decoding on large strings to 50 KB (cla: yes, framework, tool, waiting for tree to go green)

[64504](https://github.com/flutter/flutter/pull/64504) Change iOS plugin simulator archs from allow list to deny list (cla: yes, team, tool)

[64512](https://github.com/flutter/flutter/pull/64512) [flutter_tools] refactor artifact downloading to retry zip exceptions. (cla: yes, tool, waiting for tree to go green)

[64513](https://github.com/flutter/flutter/pull/64513) Reland "Prevent viewport.showOnScreen from scrolling the viewport if the specified Rect is already visible.  (#56413)", reverted in #64091 (cla: yes, f: material design, f: scrolling, framework, waiting for tree to go green)

[64516](https://github.com/flutter/flutter/pull/64516) [web] Fix and enable editable_text_test.dart (a: tests, a: text input, cla: yes, framework, platform-web, team, waiting for tree to go green)

[64517](https://github.com/flutter/flutter/pull/64517) Revert "Pass --verbose-logging to flutter_tester" (cla: yes, tool)

[64519](https://github.com/flutter/flutter/pull/64519) Re-enable image_list test with updated certificate(good for 3650 days). (cla: yes, d: examples, team)

[64521](https://github.com/flutter/flutter/pull/64521) [windows] Update plugin template (cla: yes, tool)

[64524](https://github.com/flutter/flutter/pull/64524) [flutter_tools] avoid creating Android Devices if AndroidSDK cannot be found (cla: yes, tool)

[64534](https://github.com/flutter/flutter/pull/64534) Slider paint incorrectly when the track shape is rectangular (cla: yes, f: material design, framework, waiting for tree to go green)

[64559](https://github.com/flutter/flutter/pull/64559) [flutter_tools] handle FileSystemException thrown when attempting to decode stamp file (cla: yes, tool, waiting for tree to go green)

[64570](https://github.com/flutter/flutter/pull/64570) [web] Enable word boundary tests in editable_text_test.dart (a: tests, a: text input, a: typography, cla: yes, framework, platform-web, team, waiting for tree to go green)

[64573](https://github.com/flutter/flutter/pull/64573) Revert "Warns when single line text fields overflow (#63639)" (a: tests, cla: yes, framework)

[64578](https://github.com/flutter/flutter/pull/64578) [flutter_tools] add analytics to code size, add more testing (cla: yes, tool)

[64584](https://github.com/flutter/flutter/pull/64584) Migrate physics tests to NNBD (cla: yes, framework, waiting for tree to go green)

[64587](https://github.com/flutter/flutter/pull/64587) [flutter_tools] allow disabling pwa from build command, fix run release build caching (cla: yes, tool)

[64592](https://github.com/flutter/flutter/pull/64592) Fix typo in flutter_tools --analyze-size output. (cla: yes, tool, waiting for tree to go green)

[64594](https://github.com/flutter/flutter/pull/64594) [null-safety] remove sound-null-safety by default, remove experiment flag (cla: yes, team)

[64596](https://github.com/flutter/flutter/pull/64596) Fixes router to not report route information when it is already up to… (cla: yes, framework, waiting for tree to go green)

[64599](https://github.com/flutter/flutter/pull/64599) Fix tests that use bogus objects, update TestImageInfo interface (cla: yes, f: cupertino, framework, waiting for tree to go green)

[64602](https://github.com/flutter/flutter/pull/64602) Revert "[flutter_tools] avoid creating Android Devices if AndroidSDK cannot be found" (cla: yes, tool)

[64609](https://github.com/flutter/flutter/pull/64609) Use Pixel4 for better wait times (cla: yes, team)

[64621](https://github.com/flutter/flutter/pull/64621) migrate rendering to nullsafety (a: tests, cla: yes, framework, waiting for tree to go green)

[64627](https://github.com/flutter/flutter/pull/64627) Slider and RangeSlider can be painted in a narrower constraint like other Material Wi… (cla: yes, f: material design, framework, waiting for tree to go green)

[64652](https://github.com/flutter/flutter/pull/64652) Revert "Reland: Increase threshold for usage of compute for utf8 decoding on large strings to 50 KB" (cla: yes, framework, tool)

[64654](https://github.com/flutter/flutter/pull/64654) remove docker_builder step (cla: yes, waiting for tree to go green)

[64665](https://github.com/flutter/flutter/pull/64665) [flutter_tools] reland: avoid creating Android Devices if AndroidSDK cannot be found (cla: yes, tool)

[64668](https://github.com/flutter/flutter/pull/64668) Added support for lerpDuration() (cla: yes, framework, waiting for tree to go green)

[64670](https://github.com/flutter/flutter/pull/64670) [fuchsia] Sync run test script with engine version (cla: yes, platform-fuchsia, team, team: infra, waiting for tree to go green)

[64671](https://github.com/flutter/flutter/pull/64671) Re-enable the Dart Development Service (DDS) (cla: yes, tool)

[64672](https://github.com/flutter/flutter/pull/64672) Nnbd widgets (a: accessibility, cla: yes, f: cupertino, framework, team)

[64674](https://github.com/flutter/flutter/pull/64674) Avoid thinning frameworks in iOS extensions (cla: yes, platform-ios, team, tool, waiting for tree to go green)

[64676](https://github.com/flutter/flutter/pull/64676) Roll new gallery to help flaky Crane test (cla: yes, team, waiting for tree to go green)

[64715](https://github.com/flutter/flutter/pull/64715) Clamp TabController animation value when calc _DragAnimation.value (a: animation, cla: yes, f: material design, framework, waiting for tree to go green)

[64729](https://github.com/flutter/flutter/pull/64729) Temporarily disable the mac/android test on LUCI (cla: yes, team)

[64732](https://github.com/flutter/flutter/pull/64732) Cherry-pick engine c1bc5483f60fb100fe4676c609c0f092a9ee3fc9 (cla: yes, engine)

[64736](https://github.com/flutter/flutter/pull/64736) [fuchsia] Refactor fuchsia_ctl use to a function (cla: yes, team, waiting for tree to go green)

[64737](https://github.com/flutter/flutter/pull/64737) Flutter Framework Beta 1.21.0-9.2.pre cherry picks (a: internationalization, cla: yes, engine, f: material design, framework, tool)

[64745](https://github.com/flutter/flutter/pull/64745) [flutter_tools] rethrow process exceptions as tool exit from gradle build (cla: yes, tool, waiting for customer response)

[64749](https://github.com/flutter/flutter/pull/64749) [flutter_tools] handle OsError thrown during azure detector (cla: yes, tool, waiting for tree to go green)

[64750](https://github.com/flutter/flutter/pull/64750) Allow for arbitrary placement in SliverGrid (cla: yes, customer: google, f: scrolling, framework, waiting for tree to go green)

[64757](https://github.com/flutter/flutter/pull/64757) Fix Gold json for digest paramset (a: tests, cla: yes, framework, team, team: infra, waiting for tree to go green)

[64760](https://github.com/flutter/flutter/pull/64760) Remove unnecessary downcasts on numeric operations. (cla: yes, framework, waiting for tree to go green)

[64762](https://github.com/flutter/flutter/pull/64762) Memory benchmark for showing large images in succession (cla: yes, perf: energy, perf: memory, severe: performance, team)

[64770](https://github.com/flutter/flutter/pull/64770) remove flaky flag for flutter_gallery_sksl_warmup__transition_perf_e2e (cla: yes, team, waiting for tree to go green)

[64773](https://github.com/flutter/flutter/pull/64773) [flutter_tools] exit script if powershell version detection fails (cla: yes, tool, waiting for tree to go green)

[64776](https://github.com/flutter/flutter/pull/64776) Fix Android autofill username hint docs (cla: yes, d: api docs, framework, waiting for tree to go green)

[64780](https://github.com/flutter/flutter/pull/64780) Add FrameTiming delay to watchPerformance (cla: yes, team, waiting for tree to go green)

[64791](https://github.com/flutter/flutter/pull/64791) Should have a guide for usage (and implementation) of ".of()"-style functions #4155 (cla: yes, framework, waiting for tree to go green)

[64795](https://github.com/flutter/flutter/pull/64795) Add sample code to RotationTransition (cla: yes, d: api docs, d: examples, documentation, framework, waiting for tree to go green)

[64797](https://github.com/flutter/flutter/pull/64797) Revert "Re-enable the Dart Development Service (DDS)" (cla: yes, tool)

[64802](https://github.com/flutter/flutter/pull/64802) Reland "Re-enable the Dart Development Service (DDS) (#64671)" (cla: yes, tool, waiting for tree to go green)

[64813](https://github.com/flutter/flutter/pull/64813) Remove assert about release mode (cla: yes, framework)

[64814](https://github.com/flutter/flutter/pull/64814) [flutter_tools] split project parsing/validation into separate function (cla: yes, tool)

[64819](https://github.com/flutter/flutter/pull/64819) [fuchsia] Tests wait for device to be up after pave (cla: yes, team, waiting for tree to go green)

[64824](https://github.com/flutter/flutter/pull/64824) Revert "Roll new gallery to help flaky Crane test" (cla: yes, team)

[64829](https://github.com/flutter/flutter/pull/64829) Revert "Avoid thinning frameworks in iOS extensions" (cla: yes, team, tool)

[64834](https://github.com/flutter/flutter/pull/64834) Add --device-timeout flag to device-related commands (cla: yes, platform-ios, tool, waiting for tree to go green)

[64837](https://github.com/flutter/flutter/pull/64837) [Devicelab] Temporarily remove testonly_devicelab_tests builder (cla: yes, team, waiting for tree to go green)

[64840](https://github.com/flutter/flutter/pull/64840) Make Container always clip a decoration if it has a clip edge (cla: yes, f: cupertino, f: material design, framework)

[64842](https://github.com/flutter/flutter/pull/64842) Allow creating blank issues (cla: yes, waiting for tree to go green)

[64845](https://github.com/flutter/flutter/pull/64845) Revert "Reland "Re-enable the Dart Development Service (DDS) (#64671)"" (cla: yes, tool)

[64847](https://github.com/flutter/flutter/pull/64847) Reland "Re-enable the Dart Development Service (DDS) (#64671)" (cla: yes, tool)

[64848](https://github.com/flutter/flutter/pull/64848) [flutter_tools] add --config-only option to flutter build ios (cla: yes, tool, waiting for tree to go green)

[64855](https://github.com/flutter/flutter/pull/64855) Fixes issue, ReorderableListView destroys children even if their key-type wasn't changed (cla: yes, f: material design, framework, waiting for tree to go green)

[64878](https://github.com/flutter/flutter/pull/64878) [flutter_tools] tool exit after repeated network failure (cla: yes, tool)

[64879](https://github.com/flutter/flutter/pull/64879) [semantics] avoid sync* and excessive list copies (cla: yes, framework, waiting for tree to go green)

[64883](https://github.com/flutter/flutter/pull/64883) Revert "A benchmark test case for measuring scroll smoothness" (a: tests, cla: yes, framework, team)

[64885](https://github.com/flutter/flutter/pull/64885) Reland #61998 and update complex_layout ios files (a: tests, cla: yes, framework, team, waiting for tree to go green)

[64908](https://github.com/flutter/flutter/pull/64908) Match lerped values using moreOrLessEquals (cla: yes, f: cupertino, framework)

[64914](https://github.com/flutter/flutter/pull/64914) Prefer moreOrLessEquals over closeTo (cla: yes, framework)

[64915](https://github.com/flutter/flutter/pull/64915) Prefer moreOrLessEquals over closeTo (cla: yes, f: cupertino, f: material design, framework)

[64970](https://github.com/flutter/flutter/pull/64970) [flutter_tools] remove unused zip verification (cla: yes, tool, waiting for tree to go green)

[64974](https://github.com/flutter/flutter/pull/64974) Fix typo in large_image_changer_test.dart (cla: yes, team, waiting for tree to go green)

[64976](https://github.com/flutter/flutter/pull/64976) [flutter_tools] adjust index.html caching and insert cache busting URL in to main.dart.js/sw request (cla: yes, tool)

[64977](https://github.com/flutter/flutter/pull/64977) Delete catalog generator android/ios tests (cla: yes, team, waiting for tree to go green)

[64978](https://github.com/flutter/flutter/pull/64978) devicelab: started averaging startup time for ios test (cla: yes, team, waiting for tree to go green)

[64979](https://github.com/flutter/flutter/pull/64979) Expand Cupertino library comment (cla: yes, f: cupertino, framework, waiting for tree to go green)

[64980](https://github.com/flutter/flutter/pull/64980) [flutter_tools] standardize patterns for integration.shard (cla: yes, tool)

[64981](https://github.com/flutter/flutter/pull/64981) Revert "Reland "Re-enable the Dart Development Service (DDS) (#64671)"" (cla: yes, tool)

[64982](https://github.com/flutter/flutter/pull/64982) Update Gold for new endpoint (a: tests, cla: yes, framework, team, team: infra, waiting for tree to go green)

[64983](https://github.com/flutter/flutter/pull/64983) Share build command flag configuration on desktop (cla: yes, tool)

[64984](https://github.com/flutter/flutter/pull/64984) Flutter stable framework 1.20.3 cherrypicks (a: internationalization, cla: yes, d: examples, engine, f: material design, framework, team, tool)

[64988](https://github.com/flutter/flutter/pull/64988) Add observatory Bonjour service to built iOS Info.plist bundle (cla: yes, platform-ios, t: xcode, team, tool)

[64990](https://github.com/flutter/flutter/pull/64990) Revert "Reland #61998 and update complex_layout ios files" (a: tests, cla: yes, framework, team)

[64992](https://github.com/flutter/flutter/pull/64992) Put the unbundled Linux executable in a subdirectory (cla: yes, tool)

[65025](https://github.com/flutter/flutter/pull/65025) Move gen_l10n into flutter_tools (a: internationalization, cla: yes, team, tool)

[65033](https://github.com/flutter/flutter/pull/65033) Mark large_image_changer tests as not flaky (cla: yes, team)

[65036](https://github.com/flutter/flutter/pull/65036) Update hintColor value for Material (cla: yes, f: material design, framework, waiting for tree to go green, will affect goldens)

[65042](https://github.com/flutter/flutter/pull/65042) Attempt to fix no-response bot. (cla: yes, team, waiting for tree to go green)

[65049](https://github.com/flutter/flutter/pull/65049) Fixed the sliver appbar to have a fixed traversal order (a: accessibility, cla: yes, f: material design, framework, waiting for tree to go green)

[65051](https://github.com/flutter/flutter/pull/65051) Allow Developers to enable Accessibility testing on WebFlutterDriver and get the underlying webDriver (a: tests, cla: yes, framework, waiting for tree to go green)

[65054](https://github.com/flutter/flutter/pull/65054) Mark nonflaky tests as such (cla: yes, team)

[65060](https://github.com/flutter/flutter/pull/65060) Remove redundant import of dart:math (cla: yes, f: material design, framework, waiting for tree to go green)

[65083](https://github.com/flutter/flutter/pull/65083) Update CupertinoIcons to cupertino_icons 1.0.0 based on SF Symbols (cla: yes, f: cupertino, framework)

[65094](https://github.com/flutter/flutter/pull/65094) Fix InputDecoration contentPadding documentation words accent (cla: yes, f: material design, framework, waiting for tree to go green)

[65109](https://github.com/flutter/flutter/pull/65109) Revert "Add observatory Bonjour service to built iOS Info.plist bundle" (cla: yes, team, tool)

[65112](https://github.com/flutter/flutter/pull/65112) [flutter_tools] exit with helpful message if where is missing on windows (cla: yes, tool, waiting for tree to go green)

[65114](https://github.com/flutter/flutter/pull/65114) [flutter_tools] fix screenshot command in release mode and help documentation (cla: yes, tool, waiting for tree to go green)

[65124](https://github.com/flutter/flutter/pull/65124) Require xcode_backend.sh arguments (introduced in Flutter v0.0.7) (cla: yes, platform-ios, t: xcode, team, tool, waiting for tree to go green)

[65125](https://github.com/flutter/flutter/pull/65125) [flutter_tools] add EACCES to list of immediate exit tool conditions (cla: yes, tool)

[65127](https://github.com/flutter/flutter/pull/65127) [web] Don't show handles when selection change is caused by keyboard (a: text input, cla: yes, framework, platform-web, waiting for tree to go green)

[65135](https://github.com/flutter/flutter/pull/65135) Fix RangeMaintainingScrollPhysics (cla: yes, f: scrolling, framework, waiting for tree to go green)

[65138](https://github.com/flutter/flutter/pull/65138) Add observatory Bonjour service to built iOS Info.plist bundle (cla: yes, platform-ios, t: xcode, team, tool)

[65139](https://github.com/flutter/flutter/pull/65139) [flutter_tools] Update ios-deploy (cla: yes, waiting for tree to go green)

[65140](https://github.com/flutter/flutter/pull/65140) [flutter_tools] update libimobiledevice and usbmuxd (cla: yes)

[65141](https://github.com/flutter/flutter/pull/65141) Revert "Add observatory Bonjour service to built iOS Info.plist bundle" (cla: yes, team, tool)

[65142](https://github.com/flutter/flutter/pull/65142) Add observatory Bonjour service to built iOS Info.plist bundle (cla: yes, team, tool)

[65150](https://github.com/flutter/flutter/pull/65150) Expose 3 new methods with text metrics in RenderParagraph (a: typography, cla: yes, framework, waiting for tree to go green)

[65184](https://github.com/flutter/flutter/pull/65184) [flutter_tools] prevent creation of android devices if adb is not located (cla: yes, tool, waiting for tree to go green)

[65185](https://github.com/flutter/flutter/pull/65185) fix text.dart documentation (cla: yes, framework)

[65188](https://github.com/flutter/flutter/pull/65188) Revert "Roll Engine from 165abef0a2cb to e979c29a2a50 (42 revisions)" (cla: yes, engine)

[65194](https://github.com/flutter/flutter/pull/65194) Disables test failing due to new semantics flag. (a: tests, cla: yes, framework)

[65199](https://github.com/flutter/flutter/pull/65199) Eliminate the need for the mockito package in animated_icons_private_test (cla: yes, f: material design, framework, waiting for tree to go green)

[65201](https://github.com/flutter/flutter/pull/65201) re-enable the post_backdrop_filter test with CPU/GPU measurements (cla: yes, team, waiting for tree to go green)

[65202](https://github.com/flutter/flutter/pull/65202) Revert "[flutter_tools] split project parsing/validation into separate function" (cla: yes, tool)

[65234](https://github.com/flutter/flutter/pull/65234) Update create templates to 1.0.0 (cla: yes, tool)

[65250](https://github.com/flutter/flutter/pull/65250) Fixed Tooltip widget docs. (cla: yes, f: material design, framework, waiting for tree to go green)

[65257](https://github.com/flutter/flutter/pull/65257) Revert "ScaffoldMessenger" (cla: yes, f: material design, framework)

[65271](https://github.com/flutter/flutter/pull/65271) Cherry pick engine #20983 (cla: yes, engine)

[65273](https://github.com/flutter/flutter/pull/65273) Revert "Add finders for enableFlutterDriverExtension" (a: tests, cla: yes, framework)

[65276](https://github.com/flutter/flutter/pull/65276) Fix the test error of "Add finders for enableFlutterDriverExtension" and resubmit (a: tests, cla: yes, framework, waiting for tree to go green)

[65382](https://github.com/flutter/flutter/pull/65382) Revert "Add DataTableTheme to allow for themable DataTables (#64316)" (cla: yes, f: material design, framework, waiting for tree to go green)

[65383](https://github.com/flutter/flutter/pull/65383) Reland "Add DataTableTheme to allow for themable DataTables (#64316)" (cla: yes, f: material design, framework, waiting for tree to go green)

[65386](https://github.com/flutter/flutter/pull/65386) Flutter 1.22 candidate.10 (cla: yes, engine, f: material design, framework)

[65392](https://github.com/flutter/flutter/pull/65392) Small documentation udpate (cla: yes, framework)

[65394](https://github.com/flutter/flutter/pull/65394) SliverGridLayout API docs improvements (cla: yes, framework)

[65415](https://github.com/flutter/flutter/pull/65415) Remove flutter_gallery_ios32__transition_perf test (cla: yes, team, waiting for tree to go green)

[65416](https://github.com/flutter/flutter/pull/65416) Re-land ScaffoldMessenger (cla: yes, f: material design, framework, waiting for tree to go green)

[65426](https://github.com/flutter/flutter/pull/65426) [flutter_tools] remove advice about running sdkmanager directly in favor of directing to flutter.dev (cla: yes, tool, waiting for tree to go green)

[65434](https://github.com/flutter/flutter/pull/65434) [devicelab] Remove ~/.gradle after each devicelab task run (cla: yes, team, waiting for tree to go green)

[65435](https://github.com/flutter/flutter/pull/65435) [flutter_tools] alternate the name of the dill file used for hot restart (cla: yes, tool)

[65460](https://github.com/flutter/flutter/pull/65460) Clarified '/' route in initialRoute docs (cla: yes, framework, waiting for tree to go green)

[65481](https://github.com/flutter/flutter/pull/65481) Remove mac prod builder. (cla: yes, team)

[65482](https://github.com/flutter/flutter/pull/65482) Revert "Re-land ScaffoldMessenger" (cla: yes, f: material design, framework)

[65488](https://github.com/flutter/flutter/pull/65488) Revert "Nnbd widgets" (a: accessibility, cla: yes, f: cupertino, framework)

[65490](https://github.com/flutter/flutter/pull/65490) [flutter_tools] remove globals from tracing and add unit tests (cla: yes, tool, waiting for tree to go green)

[65493](https://github.com/flutter/flutter/pull/65493) Always use POSIX paths for generated CMake files (cla: yes, tool)

[65511](https://github.com/flutter/flutter/pull/65511) Update Windows app template (cla: yes, tool, waiting for tree to go green)

[65513](https://github.com/flutter/flutter/pull/65513) Use cherry-pick engine 76240869bda39bb256bc061c9c8d7a81b13b8dae (cla: yes, engine)

[65555](https://github.com/flutter/flutter/pull/65555) Manual roll of Engine to fee6f9e5333472a1931d00f521252901d60e0c76 (cla: yes, engine)

[65566](https://github.com/flutter/flutter/pull/65566) Add mac builder in prod. (cla: yes, team, waiting for tree to go green)

[65571](https://github.com/flutter/flutter/pull/65571) Roll forward package:test to 1.16.0-nullsafety.4 to prepare for package:vm_service 5.0.0+1 (cla: yes, team, tool, waiting for tree to go green)

[65577](https://github.com/flutter/flutter/pull/65577) Mark `platform_views_scroll_perf_ios__timeline_summary` as flaky (cla: yes, team)

### Merged PRs in `flutter/engine` from 2020-07-09T05:19:00.000 to 2020-09-10T18:17:00.000
There were 959 pull requests.

[18339](https://github.com/flutter/engine/pull/18339) Use Android R (API 30) getInsets() to compute padding (cla: yes, platform-android)

[18643](https://github.com/flutter/engine/pull/18643) Add autofill save for iOS and Android (cla: yes, platform-android, platform-ios)

[18712](https://github.com/flutter/engine/pull/18712) Clean android/ios test scripts after LUCI change (cla: yes, waiting for tree to go green)

[18749](https://github.com/flutter/engine/pull/18749) Use the main bundle if the App bundle is not found (cla: yes)

[18800](https://github.com/flutter/engine/pull/18800) Refactor Accessibility bridge to have a  FlutterViewController (cla: yes)

[18984](https://github.com/flutter/engine/pull/18984) bool SubmitFrame -> void SubmitFrame (cla: yes, platform-android, platform-ios, waiting for tree to go green)

[19018](https://github.com/flutter/engine/pull/19018) [Example Docs] Added 'build' word, since run.sh also build project, not only run (cla: yes, waiting for tree to go green)

[19024](https://github.com/flutter/engine/pull/19024) Implement delayed event synthesis key event handling for Android (affects: desktop, affects: engine, affects: framework, cla: yes, platform-android)

[19059](https://github.com/flutter/engine/pull/19059) Update Androidx import (cla: yes, platform-android, waiting for tree to go green)

[19105](https://github.com/flutter/engine/pull/19105) Roll ANGLE to pick up warning fixes (cla: yes)

[19254](https://github.com/flutter/engine/pull/19254) Add CanvasKit platform support for Skia.setResourceCacheMaxBytes. (cla: yes)

[19260](https://github.com/flutter/engine/pull/19260) Test Framework for SKP based shader warmup (cla: yes)

[19267](https://github.com/flutter/engine/pull/19267) Annotate valuePublishedByPlugin with nullable (cla: yes, platform-ios, waiting for tree to go green)

[19270](https://github.com/flutter/engine/pull/19270) Enable lazy-async-stacks by-default in all modes (2) (cla: yes)

[19320](https://github.com/flutter/engine/pull/19320) Fix documentation of unset platform view ID (cla: yes)

[19393](https://github.com/flutter/engine/pull/19393) Clarify the relationship between PictureRecorder and Canvas (cla: yes, waiting for tree to go green)

[19396](https://github.com/flutter/engine/pull/19396) fuchsia: Remove dead code / break dependencies (affects: engine, cla: yes, code health, platform-fuchsia)

[19458](https://github.com/flutter/engine/pull/19458) Added the ability to set properties in interface builder for FlutterViewController (cla: yes, platform-ios)

[19459](https://github.com/flutter/engine/pull/19459) Implement cursor support for Windows (cla: yes)

[19470](https://github.com/flutter/engine/pull/19470) Set locale in Linux shell (cla: yes)

[19489](https://github.com/flutter/engine/pull/19489) Fix clipboard paste functionality not working (cla: yes)

[19501](https://github.com/flutter/engine/pull/19501) Fix NullPointerException in FlutterTextView (cla: yes, platform-android, waiting for tree to go green)

[19504](https://github.com/flutter/engine/pull/19504) Avoid a copy in EncodeImage (cla: yes)

[19537](https://github.com/flutter/engine/pull/19537) Refactor instantiateImageCodec/decodeImageFromPixels to provide an ImageDescriptor (cla: yes)

[19550](https://github.com/flutter/engine/pull/19550) Add all system cursors (engine) (cla: yes, platform-android)

[19557](https://github.com/flutter/engine/pull/19557) [web] Update SurfacePath to use PathRef (cla: yes)

[19558](https://github.com/flutter/engine/pull/19558) [Android] Prevent listener from calling JNI after detach (cla: yes, crash, platform-android)

[19561](https://github.com/flutter/engine/pull/19561) Linux: Use a hash table to map cursors (cla: yes)

[19562](https://github.com/flutter/engine/pull/19562) CkPaint uses SkPaint (cla: yes)

[19564](https://github.com/flutter/engine/pull/19564) using text capitalization value in web (cla: yes)

[19582](https://github.com/flutter/engine/pull/19582) switch kernel_compiler to package_config (cla: yes)

[19583](https://github.com/flutter/engine/pull/19583) fuchsia: Enable most unittests (affects: tests, cla: yes, code health, platform-android, platform-fuchsia)

[19584](https://github.com/flutter/engine/pull/19584) fuchsia: create new flutter_runner render path (affects: engine, cla: yes, platform-fuchsia)

[19597](https://github.com/flutter/engine/pull/19597) Desktop embedder ComputePlatformResolvedLocale entrypoint (affects: desktop, cla: yes)

[19606](https://github.com/flutter/engine/pull/19606) Incorporate compat info changes into flutter engine (cla: yes)

[19610](https://github.com/flutter/engine/pull/19610) [web][2/3] Implement rules of the line break algorithm (cla: yes, platform-web, waiting for tree to go green)

[19615](https://github.com/flutter/engine/pull/19615) Use identical in hashValues instead of operator== (cla: yes)

[19616](https://github.com/flutter/engine/pull/19616) Changes to fix build errors in google3. (cla: yes)

[19620](https://github.com/flutter/engine/pull/19620) [android] Pass synthesized eventType to VirtualDisplay platform views and fix memory leak (cla: yes, platform-android, waiting for tree to go green)

[19623](https://github.com/flutter/engine/pull/19623) fix FlutterViewUpdateCustomAccessibilityActions uses correct string list (cla: yes, platform-android)

[19632](https://github.com/flutter/engine/pull/19632) Fixing synthesizing keys for multiple keys pressed down on flutter web (cla: yes, platform-web, waiting for tree to go green)

[19633](https://github.com/flutter/engine/pull/19633) don't throw error for the new autofill request (cla: yes)

[19649](https://github.com/flutter/engine/pull/19649) Manual Roll of Dart dfdc7e45c5...06cb010247 (cla: yes)

[19650](https://github.com/flutter/engine/pull/19650) Manual Skia roll to c91db040ad18b9cc3236e342e9acca020eaafd10 (cla: yes)

[19652](https://github.com/flutter/engine/pull/19652) Move platform specific information to `PlatformConfiguration` class (cla: yes, waiting for tree to go green)

[19653](https://github.com/flutter/engine/pull/19653) 1.20.0-7.1.pre engine CPs (platform-android)

[19657](https://github.com/flutter/engine/pull/19657) Manual Roll of Dart 707c6404f9...dfdc7e45c5 (cla: yes)

[19658](https://github.com/flutter/engine/pull/19658) Moved to RMSE for image comparison to account for slight variations in golden image tests (cla: yes)

[19662](https://github.com/flutter/engine/pull/19662) [android] Childview will process its motion events (cla: yes, platform-android)

[19664](https://github.com/flutter/engine/pull/19664) Support decimal information on the TextInputType (cla: yes)

[19667](https://github.com/flutter/engine/pull/19667) Remove xcpretty from unit tests to see full output on test failures (cla: yes)

[19668](https://github.com/flutter/engine/pull/19668) Turn off failing XCTest attachment collection (cla: yes, waiting for tree to go green)

[19678](https://github.com/flutter/engine/pull/19678) [fuchsia] Use memory_requirements_2 extension. (cla: yes)

[19679](https://github.com/flutter/engine/pull/19679) Remove reference to dev_finder. (cla: yes)

[19684](https://github.com/flutter/engine/pull/19684) Refactor initial route code (cla: yes, platform-ios)

[19691](https://github.com/flutter/engine/pull/19691) Fix Typos (cla: yes, waiting for tree to go green)

[19694](https://github.com/flutter/engine/pull/19694) Rebuild CkPath on top of `@JS` bindings with 3.28x speed-up on the path benchmark (cla: yes)

[19700](https://github.com/flutter/engine/pull/19700) Fixes typo in android_context_gl.h (cla: yes, platform-android)

[19702](https://github.com/flutter/engine/pull/19702) Prevent that removeActivityResultListener() is causing an ConcurrentModificationException (cla: yes, platform-android)

[19711](https://github.com/flutter/engine/pull/19711) [web] Implement ulps for path ops (cla: yes)

[19717](https://github.com/flutter/engine/pull/19717) Add flag to indicate whether the platform supports state restoration (cla: yes, platform-android)

[19724](https://github.com/flutter/engine/pull/19724) ensure we do not double publish to CIPD (cla: yes)

[19725](https://github.com/flutter/engine/pull/19725) Wait for platform view to appear in iOS UI tests (cla: yes)

[19726](https://github.com/flutter/engine/pull/19726) Migrating web_analysis from Cirrus to LUCI (PART 1) (cla: yes)

[19728](https://github.com/flutter/engine/pull/19728) Fix Mac / iOS builds (cla: yes, platform-ios)

[19739](https://github.com/flutter/engine/pull/19739) Revert "Avoid a copy in EncodeImage (#19504)" (cla: yes)

[19740](https://github.com/flutter/engine/pull/19740) [fuchsia] Fix use-after-free due to raster cache (cla: yes)

[19741](https://github.com/flutter/engine/pull/19741) [null-safety] update web_sdk build rules to use package_config (cla: yes)

[19743](https://github.com/flutter/engine/pull/19743) Use option --no-sound-null-safety instead of --no-null-safety (cla: yes)

[19744](https://github.com/flutter/engine/pull/19744) Disable session_connection_unittests (cla: yes)

[19745](https://github.com/flutter/engine/pull/19745) [web][3/3] Handle surrogate during line break detection (cla: yes, platform-web)

[19746](https://github.com/flutter/engine/pull/19746) [null-safety] add null assertions to dart-flags allowlist (cla: yes, waiting for tree to go green)

[19748](https://github.com/flutter/engine/pull/19748) Move CkCanvas to new JS-interop (cla: yes)

[19753](https://github.com/flutter/engine/pull/19753) removing web analysis task from Cirrus  (cla: yes)

[19756](https://github.com/flutter/engine/pull/19756) Re-enable logging. (cla: yes)

[19759](https://github.com/flutter/engine/pull/19759) Revert "ensure we do not double publish to CIPD (#19724)" (cla: yes)

[19776](https://github.com/flutter/engine/pull/19776) 1.20.0-7.2.pre engine cherrypicks (cla: yes, platform-android)

[19780](https://github.com/flutter/engine/pull/19780) [null-safety] update use of dot packages to package_config.json (cla: yes)

[19785](https://github.com/flutter/engine/pull/19785) Fix loss of negative text selection ranges (cla: yes, platform-ios)

[19787](https://github.com/flutter/engine/pull/19787) [web] Improve perf and code size of line breaker (cla: yes, platform-web, waiting for tree to go green)

[19788](https://github.com/flutter/engine/pull/19788) Makes IOS dispatch showOnCcreen action for header semantics nodes (cla: yes, platform-ios, waiting for tree to go green)

[19791](https://github.com/flutter/engine/pull/19791) Manual Dart SDK roll (cla: yes)

[19792](https://github.com/flutter/engine/pull/19792) fuchsia: Allow setting thread-name (cla: yes, platform-fuchsia)

[19794](https://github.com/flutter/engine/pull/19794) Fix targets param in build_fuchsia_artifacts (cla: yes, platform-fuchsia)

[19796](https://github.com/flutter/engine/pull/19796) FlRenderer cleanup in preperation for Wayland support (cla: yes)

[19810](https://github.com/flutter/engine/pull/19810) [null-safety] remove package references from flutter frontend-server test, ci analyze (cla: yes, waiting for tree to go green)

[19811](https://github.com/flutter/engine/pull/19811) [tonic] Log stack trace for unhandles exceptions (cla: yes)

[19812](https://github.com/flutter/engine/pull/19812) fix and re-enable SessionConnection unit tests (cla: yes)

[19817](https://github.com/flutter/engine/pull/19817) Added a more complete docstring for SemanticsFlags (cla: yes)

[19819](https://github.com/flutter/engine/pull/19819) remove obsolete check on FlutterPlatformViewsController::OnCreate (cla: yes, platform-ios, waiting for tree to go green)

[19822](https://github.com/flutter/engine/pull/19822) Allow custom CanvasKit URL (cla: yes)

[19823](https://github.com/flutter/engine/pull/19823) Add CPU-only rendering mode for CanvasKit as a fallback (cla: yes)

[19826](https://github.com/flutter/engine/pull/19826) fix On iOS, dialog titles are announced twice (cla: yes, platform-ios)

[19842](https://github.com/flutter/engine/pull/19842) Hint freed (cla: yes, waiting for tree to go green)

[19846](https://github.com/flutter/engine/pull/19846) [web] Cache line break property lookups (cla: yes, platform-web)

[19848](https://github.com/flutter/engine/pull/19848) Cherry pick 3d104f43649d333492dfa792968c8a09af93a84c (cla: yes, platform-android, platform-ios)

[19850](https://github.com/flutter/engine/pull/19850) CanvasKit final JS-interop clean-up (cla: yes)

[19853](https://github.com/flutter/engine/pull/19853) Reland "ensure we do not double publish to CIPD #19724" (cla: yes)

[19854](https://github.com/flutter/engine/pull/19854) Remove migrated format and lint steps from the cirrus file (cla: yes)

[19859](https://github.com/flutter/engine/pull/19859) Clipboard hasStrings method on iOS (cla: yes, platform-ios, waiting for tree to go green)

[19860](https://github.com/flutter/engine/pull/19860) Support talkback in hybrid composition (cla: yes, platform-android, waiting for tree to go green)

[19864](https://github.com/flutter/engine/pull/19864) 1.20.0-7.2.pre: CP 12847e899e080104365f93843c25a3b3b5648895 (cla: yes, platform-android)

[19871](https://github.com/flutter/engine/pull/19871) Fix failing Dart analyzer checks in the web UI tests (cla: yes)

[19895](https://github.com/flutter/engine/pull/19895) Made the linter print out more information in its output and fixed bugs (cla: yes, platform-android)

[19896](https://github.com/flutter/engine/pull/19896) [windows] Separate the engine from the view (affects: desktop, cla: yes, platform-windows)

[19898](https://github.com/flutter/engine/pull/19898) [a11y-web] Semantics fix (cla: yes)

[19899](https://github.com/flutter/engine/pull/19899) Fix invalid selection handling in text plugins (cla: yes)

[19913](https://github.com/flutter/engine/pull/19913) [CanvasKit] Mark used SkPictures so they aren't deleted on the next frame. (cla: yes)

[19915](https://github.com/flutter/engine/pull/19915) Update 1.20 branch engine hash to Dart 2.9.0-21.10.beta (cla: yes)

[19919](https://github.com/flutter/engine/pull/19919) Ensure threads are merged when tearing down the Rasterizer (cla: yes, platform-ios, waiting for tree to go green)

[19924](https://github.com/flutter/engine/pull/19924) [web] Enable canvas measurement by default (cla: yes, platform-web)

[19927](https://github.com/flutter/engine/pull/19927) [web] Fixes arc scaling when counter clockwise (cla: yes)

[19948](https://github.com/flutter/engine/pull/19948) [web] Prevent crash when restore is called incorrectly after recording ends. (cla: yes)

[19956](https://github.com/flutter/engine/pull/19956) Revert "Implement delayed event synthesis key event handling for Android (#19024)" (cla: yes, platform-android)

[19960](https://github.com/flutter/engine/pull/19960) Roll CanvasKit to 0.17.2 (cla: yes)

[19962](https://github.com/flutter/engine/pull/19962) Use the GrDirectContext factories instead of deprecated GrContext ones (cla: yes, platform-android, platform-ios)

[19967](https://github.com/flutter/engine/pull/19967) Manual merge of Dart  a3815b6590...24c7666def (cla: yes)

[19968](https://github.com/flutter/engine/pull/19968) Add missing MouseCursorPlugin destroy call (cla: yes, perf: memory, platform-android, waiting for tree to go green)

[19970](https://github.com/flutter/engine/pull/19970) Add support for playing alert sound on MacOS (cla: yes)

[19972](https://github.com/flutter/engine/pull/19972) Remove android view from the Mutator stack (cla: yes, platform-android)

[19981](https://github.com/flutter/engine/pull/19981) Enabled linting on engine.cc (cla: yes)

[19983](https://github.com/flutter/engine/pull/19983) Make EncodableValue a thin std::variant wrapper (affects: engine, cla: yes, glfw, platform-windows)

[19986](https://github.com/flutter/engine/pull/19986) 1.20.0 CP: Remove android view from the Mutator stack (#19972) (cla: yes, platform-android)

[19987](https://github.com/flutter/engine/pull/19987) This makes the lint script use multiprocessing to speed it up. (cla: yes)

[19988](https://github.com/flutter/engine/pull/19988) Fix lint errors in lib/ui (cla: yes)

[19989](https://github.com/flutter/engine/pull/19989) support fallback codecs on Windows, macOS, iOS (cla: yes, waiting for tree to go green)

[19990](https://github.com/flutter/engine/pull/19990) Lint fixes for fml, tools subdirs (cla: yes)

[19991](https://github.com/flutter/engine/pull/19991) Fix lint errors in vulkan directory. (cla: yes)

[19993](https://github.com/flutter/engine/pull/19993) [fuchsia] Adds a test for clock change (cla: yes)

[20003](https://github.com/flutter/engine/pull/20003) Reland: Avoid a copy in EncodeImage (cla: yes, perf: speed, severe: performance)

[20005](https://github.com/flutter/engine/pull/20005) 4x4.png -> 2x2.png; this file is actually 2x2 (cla: yes)

[20006](https://github.com/flutter/engine/pull/20006) Improve FlRenderer interface in preperation for Wayland on Linux (cla: yes)

[20008](https://github.com/flutter/engine/pull/20008) [web] Address platform changes in the integration tests. Part 1 (cla: yes)

[20010](https://github.com/flutter/engine/pull/20010) [null-safety] fix real failures (cla: yes)

[20011](https://github.com/flutter/engine/pull/20011) remove usage of dartdev command (cla: yes)

[20013](https://github.com/flutter/engine/pull/20013) Add purge-persistent-cache (cla: yes)

[20014](https://github.com/flutter/engine/pull/20014) fix gclient runhooks for windows (cla: yes)

[20019](https://github.com/flutter/engine/pull/20019) Add Dart 2.10 annotations to the web engine sources (cla: yes)

[20023](https://github.com/flutter/engine/pull/20023) Disable the web SDK API conformance test until the analyzer is updated for Dart 2.10 (cla: yes)

[20024](https://github.com/flutter/engine/pull/20024) Upgrade the analyzer package to version 0.39.15 for Dart 2.10 support (cla: yes)

[20025](https://github.com/flutter/engine/pull/20025) Add a todo to felt (PR to rerun the tree) (cla: yes)

[20050](https://github.com/flutter/engine/pull/20050) Use a single mask view to clip platform view (cla: yes, platform-ios)

[20060](https://github.com/flutter/engine/pull/20060) both trees are red, stop running integration tests (cla: yes)

[20067](https://github.com/flutter/engine/pull/20067) [web] Set correct defaults for text in canvas (cla: yes, platform-web)

[20068](https://github.com/flutter/engine/pull/20068) fixing cirrus flag issue (cla: yes)

[20075](https://github.com/flutter/engine/pull/20075) re-enable integration tests. increase sdk version. (cla: yes)

[20082](https://github.com/flutter/engine/pull/20082) Ios nv12 external texture (cla: yes, platform-ios)

[20087](https://github.com/flutter/engine/pull/20087) Allow access to a zircon handle's koid (cla: yes)

[20090](https://github.com/flutter/engine/pull/20090) Save current screenshot as attachment in scenarios test (cla: yes)

[20092](https://github.com/flutter/engine/pull/20092) Manual roll of Dart from 24c7666def...40fd1c456e (cla: yes, platform-android, platform-ios)

[20099](https://github.com/flutter/engine/pull/20099) add supported luci builders (cla: yes)

[20100](https://github.com/flutter/engine/pull/20100) Wait before switching surfaces (cla: yes, platform-android, waiting for tree to go green)

[20106](https://github.com/flutter/engine/pull/20106) Fix usage of WeakPtr valid check (cla: yes)

[20107](https://github.com/flutter/engine/pull/20107) Migrate some Dart_WeakPersistentHandle uses to Dart_FinalizableHandle (cla: yes)

[20119](https://github.com/flutter/engine/pull/20119) Roll zlib (cla: yes)

[20121](https://github.com/flutter/engine/pull/20121) Remove confusing logs (cla: yes)

[20123](https://github.com/flutter/engine/pull/20123) add information collection for safari bots (cla: yes)

[20125](https://github.com/flutter/engine/pull/20125) Manual roll of Dart 40fd1c456e...7e8348f4ce (cla: yes)

[20127](https://github.com/flutter/engine/pull/20127) [iOS] Fixes text input plugin crash (cla: yes, platform-ios)

[20134](https://github.com/flutter/engine/pull/20134) Enable linting in flow/, and fml/ (cla: yes)

[20135](https://github.com/flutter/engine/pull/20135) Manual roll of Dart cb6ed67a73...7e8348f4ce (cla: yes)

[20138](https://github.com/flutter/engine/pull/20138) Manual roll of Dart 03e4737f31...cb6ed67a73 (cla: yes)

[20139](https://github.com/flutter/engine/pull/20139) Add ALERT SoundType enum value (cla: yes, platform-android)

[20140](https://github.com/flutter/engine/pull/20140) Fix dartdocs of dart:ui (cla: yes, waiting for tree to go green)

[20142](https://github.com/flutter/engine/pull/20142) Create root isolate asynchronously (cla: yes, perf: speed, severe: performance)

[20144](https://github.com/flutter/engine/pull/20144) Add TextInput sendAppPrivateCommand to Flutter Engine (cla: yes, platform-android)

[20156](https://github.com/flutter/engine/pull/20156) Add preliminary Windows arm64 plumbing (cla: yes)

[20163](https://github.com/flutter/engine/pull/20163) Fix parameter names (cla: yes)

[20164](https://github.com/flutter/engine/pull/20164) [web] increase number of shards. sync engine web tests same as flutter repo (cla: yes)

[20165](https://github.com/flutter/engine/pull/20165) Revert "Enable lazy-async-stacks by-default in all modes (2) (#19270)" (cla: yes)

[20166](https://github.com/flutter/engine/pull/20166) Fix Implments typo (cla: yes)

[20167](https://github.com/flutter/engine/pull/20167) fix ios layout change cause the accessibility focus to jump randomly. (cla: yes, platform-ios)

[20176](https://github.com/flutter/engine/pull/20176) update nullability of drawAtlas methods and flesh out docs (affects: docs, cla: yes, waiting for tree to go green)

[20178](https://github.com/flutter/engine/pull/20178) Remove null check for layer_tree pointer in `Animator::Render` (cla: yes, waiting for tree to go green)

[20180](https://github.com/flutter/engine/pull/20180) 1.20 CP: Wait before switching surfaces (#20100) (cla: yes, platform-android)

[20181](https://github.com/flutter/engine/pull/20181) Fix iOS Keyboard stuck as UIKeyboardTypeNamePhonePad (cla: yes, platform-ios)

[20187](https://github.com/flutter/engine/pull/20187) Enable more linting (Work in progress (WIP), cla: yes)

[20188](https://github.com/flutter/engine/pull/20188) Add TextInput performPrivateCommand to Flutter Engine (cla: yes, platform-android)

[20193](https://github.com/flutter/engine/pull/20193) Fix navigation message relay. (cla: yes)

[20194](https://github.com/flutter/engine/pull/20194) Implemented web image codec instantiation for CanvasKit. (cla: yes, waiting for tree to go green)

[20199](https://github.com/flutter/engine/pull/20199) Update code style to pass clang-tidy checks (cla: yes)

[20206](https://github.com/flutter/engine/pull/20206) Fix inconsistent import. (cla: yes)

[20208](https://github.com/flutter/engine/pull/20208) [web] Include trailing spaces in text box measurements (cla: yes, platform-web)

[20215](https://github.com/flutter/engine/pull/20215) Update 1.20.0 engine hash to Dart 2.9.0 (cla: yes)

[20216](https://github.com/flutter/engine/pull/20216) Added unit tests to the engine. (cla: yes)

[20217](https://github.com/flutter/engine/pull/20217) Disable flaky fuchsia test (cla: yes)

[20218](https://github.com/flutter/engine/pull/20218) Plumbing for setting domain network policy (cla: yes, platform-android, platform-ios)

[20229](https://github.com/flutter/engine/pull/20229) FrameTiming build start timestamp fix and add vsync start timestamp (cla: yes, waiting for tree to go green)

[20234](https://github.com/flutter/engine/pull/20234) remove leftover temporary null safety annotations (cla: yes)

[20235](https://github.com/flutter/engine/pull/20235) Migrate a few last places to GrDirectContext (cla: yes)

[20236](https://github.com/flutter/engine/pull/20236) Revert "Add preliminary Windows arm64 plumbing" (cla: yes)

[20237](https://github.com/flutter/engine/pull/20237) reducing the shard number to 8 for framework tests (cla: yes)

[20238](https://github.com/flutter/engine/pull/20238) 1.20 CP: fix FlutterViewUpdateCustomAccessibilityActions uses correct string list (cla: yes, platform-android)

[20241](https://github.com/flutter/engine/pull/20241) Remove unnecessary breaks after returns in lib/web_ui switch statements (cla: yes)

[20243](https://github.com/flutter/engine/pull/20243) Reland "Add preliminary Windows arm64 plumbing" (cla: yes)

[20245](https://github.com/flutter/engine/pull/20245) Add FlutterFragmentActivity#getRenderMode() (cla: yes, platform-android, waiting for tree to go green)

[20247](https://github.com/flutter/engine/pull/20247) Switched the linter to use the dart that comes with the engine. (cla: yes)

[20250](https://github.com/flutter/engine/pull/20250) Fix the reversal of behavior in SerializeTypefaceWithData and WithoutData (cla: yes, waiting for tree to go green)

[20256](https://github.com/flutter/engine/pull/20256) [web] Save the autofill information (cla: yes)

[20266](https://github.com/flutter/engine/pull/20266) [windows] Rework controller/engine interaction in the API (cla: yes)

[20269](https://github.com/flutter/engine/pull/20269) add a named constructor to FrameTiming (cla: yes, waiting for tree to go green)

[20272](https://github.com/flutter/engine/pull/20272) Roll CanvasKit to 0.17.3. (cla: yes)

[20276](https://github.com/flutter/engine/pull/20276) [web] Implement support for WidgetSpan (aka paragraph placeholders) (cla: yes, platform-web)

[20278](https://github.com/flutter/engine/pull/20278) [web] Eagerly calculate relevant indices during line break detection (cla: yes, platform-web)

[20279](https://github.com/flutter/engine/pull/20279) use generic name (cla: yes)

[20280](https://github.com/flutter/engine/pull/20280) Reporting back native stacktrace to dart side for crash reporting. (cla: yes, platform-android, waiting for tree to go green)

[20283](https://github.com/flutter/engine/pull/20283) Use weak references instead of resurrection, if available (cla: yes)

[20288](https://github.com/flutter/engine/pull/20288) Create scenic session with view focuser (cla: yes)

[20302](https://github.com/flutter/engine/pull/20302) Revert "fuchsia: Remove dead code / break dependencies" (cla: yes)

[20303](https://github.com/flutter/engine/pull/20303) android_external_texture: Use the available GrDirectContext arg (cla: yes, platform-android)

[20306](https://github.com/flutter/engine/pull/20306) Implement our own WebGL version detection (cla: yes)

[20310](https://github.com/flutter/engine/pull/20310) fix clipped and transformed content in HTML clip (cla: yes)

[20315](https://github.com/flutter/engine/pull/20315) Add script to compile JIT on x86 (cla: yes)

[20317](https://github.com/flutter/engine/pull/20317) Allow extending the C++ standard codec (cla: yes)

[20327](https://github.com/flutter/engine/pull/20327) Revert "fuchsia: Remove dead code / break dependencies (#19396)" (#20… (cla: yes)

[20333](https://github.com/flutter/engine/pull/20333) Roll buildroot to b8d98f419b4c32eb1d575557d2c46e8c755ceac7 (cla: yes)

[20337](https://github.com/flutter/engine/pull/20337) engineCallbackOnPresent should return false if glContext is invalid (cla: yes)

[20340](https://github.com/flutter/engine/pull/20340) remove `write` parameter from _checkScreenshot (cla: yes)

[20341](https://github.com/flutter/engine/pull/20341) CanvasKit: switch to non-overloaded arcTo methods (cla: yes)

[20343](https://github.com/flutter/engine/pull/20343) Dedupe sources for fuchsia shell/tests (cla: yes, platform-fuchsia)

[20348](https://github.com/flutter/engine/pull/20348) [iOS TextInput] Fixes selection clamping & composing range change logic (cla: yes, platform-ios)

[20349](https://github.com/flutter/engine/pull/20349) CanvasKit: memory management for image and shader classes (cla: yes)

[20350](https://github.com/flutter/engine/pull/20350) Prepare scenario app to run on Android emulator on LUCI  (cla: yes)

[20357](https://github.com/flutter/engine/pull/20357) Fix flutter#40068 Redraw issues on resize/minimize/maximize on Windows and startup in release (cla: yes, waiting for tree to go green)

[20370](https://github.com/flutter/engine/pull/20370) Paragraph.longest_line_ to account for trailing inline placeholders (cla: yes)

[20379](https://github.com/flutter/engine/pull/20379) Fix nullability warning and change registeredFonts to non-nullable (cla: yes)

[20380](https://github.com/flutter/engine/pull/20380) remove FrameTiming named constructor (cla: yes, waiting for tree to go green)

[20381](https://github.com/flutter/engine/pull/20381) Add Path iterator tests, sync verbs with skia enums, fix PathIterator.peek. (cla: yes)

[20384](https://github.com/flutter/engine/pull/20384) [web] Add comment for clip update. (cla: yes)

[20385](https://github.com/flutter/engine/pull/20385) Adds fuchsia node roles to accessibility bridge updates. (cla: yes, waiting for tree to go green)

[20387](https://github.com/flutter/engine/pull/20387) Clean-up CanvasKit canvas sizing. (cla: yes)

[20390](https://github.com/flutter/engine/pull/20390) [web] Build unit tests with dart2js instead of build_runner (cla: yes)

[20391](https://github.com/flutter/engine/pull/20391) Add Surface::GetContext() support on Fuchsia (cla: yes)

[20393](https://github.com/flutter/engine/pull/20393) hasStrings on Android (cla: yes, platform-android)

[20397](https://github.com/flutter/engine/pull/20397) Fix broken Fuchsia test (cla: yes)

[20398](https://github.com/flutter/engine/pull/20398) Fix RTTI check in EncodableValue (cla: yes)

[20399](https://github.com/flutter/engine/pull/20399) [windows] Expose the binary messenger from FlutterEngine (cla: yes)

[20410](https://github.com/flutter/engine/pull/20410) improve error messages for font-subset (cla: yes)

[20411](https://github.com/flutter/engine/pull/20411) Roll Harfbuzz to 2.7.0 (c6ca30dc757ff86416d97d358f20080b979b80c9) (cla: yes, waiting for tree to go green)

[20413](https://github.com/flutter/engine/pull/20413) Use performDeferredCleanup instead of freeGpuResources (cla: yes, waiting for tree to go green)

[20415](https://github.com/flutter/engine/pull/20415) Remove duplicated try builder for luci tasks (cla: yes)

[20417](https://github.com/flutter/engine/pull/20417) Add virtual destructors to ByteStream* (cla: yes)

[20420](https://github.com/flutter/engine/pull/20420) Add missing reply in C++ MethodChannel unit test (cla: yes)

[20421](https://github.com/flutter/engine/pull/20421) Make CkVertices a ManagedSkiaObject (cla: yes)

[20422](https://github.com/flutter/engine/pull/20422) Fix broken shell_unittests on Fuchsia (affects: tests, cla: yes, platform-fuchsia)

[20425](https://github.com/flutter/engine/pull/20425) Custom Gradle home and add .vpython file (cla: yes, waiting for tree to go green)

[20426](https://github.com/flutter/engine/pull/20426) Delete CSS paint code (cla: yes)

[20427](https://github.com/flutter/engine/pull/20427) Add --unoptimized and --asan to Fuchsia builds (cla: yes, platform-fuchsia)

[20446](https://github.com/flutter/engine/pull/20446) Engine 1.20.2 cherrypicks (cla: yes, platform-ios)

[20450](https://github.com/flutter/engine/pull/20450) Revert "Refactor initial route code (#19684)" (cla: yes, platform-ios)

[20451](https://github.com/flutter/engine/pull/20451) Populates fuchsia node actions in semantics updates. (cla: yes)

[20455](https://github.com/flutter/engine/pull/20455) Send locale information in the Windows embedding (affects: desktop, cla: yes, platform-windows)

[20459](https://github.com/flutter/engine/pull/20459) Fix broken symbols on Fuchsia embedder (cla: yes)

[20460](https://github.com/flutter/engine/pull/20460) Add enabled flag for try builders (cla: yes)

[20461](https://github.com/flutter/engine/pull/20461) Send locale information in the macOS embedding (affects: desktop, cla: yes, platform-macos)

[20465](https://github.com/flutter/engine/pull/20465) Do not access members after calling ClearDartWrapper (cla: yes, waiting for tree to go green)

[20466](https://github.com/flutter/engine/pull/20466) Add a service protocol for raster cache memory (cla: yes, perf: memory, severe: performance)

[20468](https://github.com/flutter/engine/pull/20468) Refactor initial route code take 2 (cla: yes, platform-ios)

[20470](https://github.com/flutter/engine/pull/20470) [web] update chrome version (cla: yes, waiting for tree to go green)

[20479](https://github.com/flutter/engine/pull/20479) Update to android 30r2 and roll buildroot (cla: yes)

[20480](https://github.com/flutter/engine/pull/20480) Flutter 1.21 candidate.10 (cla: yes)

[20486](https://github.com/flutter/engine/pull/20486) Remove the dummy rasterizer delegate now that flutter_runner is in tree, and cleanup ctor params (cla: yes, platform-android, platform-fuchsia, platform-ios, waiting for tree to go green)

[20487](https://github.com/flutter/engine/pull/20487) Only create raster_thread_merge when explicitly requested by the embedding platform (cla: yes, platform-ios, waiting for tree to go green)

[20488](https://github.com/flutter/engine/pull/20488) Fix unoptimized fuchsia builds (cla: yes)

[20492](https://github.com/flutter/engine/pull/20492) Enable iOS plumbing for network security and add tests (cla: yes, platform-ios)

[20494](https://github.com/flutter/engine/pull/20494) Remove doc comments in copied web interfaces (cla: yes)

[20500](https://github.com/flutter/engine/pull/20500) Create PlatformView instance right after method channel call from Dart (cla: yes, platform-android, waiting for tree to go green)

[20501](https://github.com/flutter/engine/pull/20501) Fix the legacy EncodableValue codepaths (cla: yes)

[20505](https://github.com/flutter/engine/pull/20505) Add missing nullable annotation (cla: yes, platform-android, waiting for tree to go green)

[20511](https://github.com/flutter/engine/pull/20511) Flutter 1.21 candidate.10 (cla: yes)

[20516](https://github.com/flutter/engine/pull/20516) Missing default focus when navigating to a page with no SemanticsNode that sets namesRoute:true (cla: yes, platform-android, waiting for tree to go green)

[20518](https://github.com/flutter/engine/pull/20518) Make sure ios tests fail if they fail (cla: yes)

[20520](https://github.com/flutter/engine/pull/20520) [web] Prepare for read-only input fields (affects: text input, cla: yes, platform-web, waiting for tree to go green)

[20522](https://github.com/flutter/engine/pull/20522) Fixed the accessibility ios unit tests by sending in mock view controllers instead of views. (cla: yes, platform-ios)

[20523](https://github.com/flutter/engine/pull/20523) Handle glfwGetPrimaryMonitor returning nullptr (cla: yes)

[20524](https://github.com/flutter/engine/pull/20524) Fix web_ui warnings flagged by the next Dart analyzer update (cla: yes, waiting for tree to go green)

[20528](https://github.com/flutter/engine/pull/20528) use @anonymous in some deletable Sk classes (cla: yes)

[20532](https://github.com/flutter/engine/pull/20532) Reland: "fuchsia: Remove dead code / break dependencies" (affects: engine, cla: yes, code health, platform-fuchsia)

[20538](https://github.com/flutter/engine/pull/20538) Clean up the CI scripts and make it so that they can be run from anywhere (cla: yes)

[20542](https://github.com/flutter/engine/pull/20542) Started stubbing in the FlutterView property of the mock FlutterViewControllers (cla: yes, platform-ios)

[20550](https://github.com/flutter/engine/pull/20550) Revert "[windows] Expose the binary messenger from FlutterEngine" (cla: yes)

[20551](https://github.com/flutter/engine/pull/20551) [windows] Expose the binary messenger from FlutterEngine (cla: yes)

[20557](https://github.com/flutter/engine/pull/20557) Fix font sorting problem due to iOS 14 fonts being broader (cla: yes)

[20564](https://github.com/flutter/engine/pull/20564) Revert "Create PlatformView instance right after method channel call from Dart (#20500)" (cla: yes, platform-android)

[20568](https://github.com/flutter/engine/pull/20568) Reland: Create PlatformView instance right after method channel call from Dart (cla: yes, platform-android, platform-ios)

[20572](https://github.com/flutter/engine/pull/20572) Convert format script to Dart (cla: yes)

[20575](https://github.com/flutter/engine/pull/20575) Update 1.21 engine to use Dart 2.10.0-7.2.beta (cla: yes)

[20577](https://github.com/flutter/engine/pull/20577) convert zircon and fuchsia to null-safety (cla: yes)

[20579](https://github.com/flutter/engine/pull/20579) rename "compositor"/"surface" to "canvaskit"/"html"; document conventions (cla: yes)

[20580](https://github.com/flutter/engine/pull/20580) Add null checks for CanvasElement attributes (cla: yes)

[20581](https://github.com/flutter/engine/pull/20581) Add android scenarios presubmit task. (cla: yes)

[20594](https://github.com/flutter/engine/pull/20594) Revert harfbuzz 2.7.0 (cla: yes)

[20597](https://github.com/flutter/engine/pull/20597) Revert "Add android scenarios presubmit task." (cla: yes)

[20606](https://github.com/flutter/engine/pull/20606) fuchsia: Increase timeout for flaky test (cla: yes)

[20609](https://github.com/flutter/engine/pull/20609) Roll hb to 2.7.1 (cla: yes, waiting for tree to go green)

[20610](https://github.com/flutter/engine/pull/20610) Release the AccessibilityBridge when destroying a legacy FlutterView (cla: yes, platform-android, waiting for tree to go green)

[20611](https://github.com/flutter/engine/pull/20611) Cherrypick Revert harfbuzz 2.7.0 (#20594) (cla: yes)

[20613](https://github.com/flutter/engine/pull/20613) [windows] Allow delegation of top-level WindowProc (affects: desktop, cla: yes, platform-windows)

[20614](https://github.com/flutter/engine/pull/20614) Make const_finder work with implemented and extended classes (cla: yes, waiting for tree to go green)

[20617](https://github.com/flutter/engine/pull/20617) [embedder] Add FBO callback that takes frame info (cla: yes, platform-android, platform-ios, waiting for tree to go green)

[20620](https://github.com/flutter/engine/pull/20620) Fixing autofill issue (cla: yes)

[20622](https://github.com/flutter/engine/pull/20622) Fix NPE in PlatformViewsController.checkInputConnectionProxy (cla: yes, platform-android)

[20630](https://github.com/flutter/engine/pull/20630) Remove use of ctors on Skia Vulkan struct (cla: yes)

[20635](https://github.com/flutter/engine/pull/20635) Reland: Add android scenarios presubmit task. (cla: yes)

[20638](https://github.com/flutter/engine/pull/20638) Update view attributes after creation (affects: engine, cla: yes, platform-fuchsia, waiting for tree to go green)

[20641](https://github.com/flutter/engine/pull/20641) Clean up scenario app scripts (cla: yes)

[20642](https://github.com/flutter/engine/pull/20642) Adds all the engine builders to the file used to validate tree status. (cla: yes)

[20644](https://github.com/flutter/engine/pull/20644) fix build (cla: yes)

[20647](https://github.com/flutter/engine/pull/20647) fuchsia: Convert legacy permutations to build flag (affects: engine, affects: tests, cla: yes, code health, platform-fuchsia)

[20651](https://github.com/flutter/engine/pull/20651) Use references for C++ MethodResult and EventSink (cla: yes)

[20660](https://github.com/flutter/engine/pull/20660) send newline char when input type is multiline (cla: yes, waiting for tree to go green)

[20662](https://github.com/flutter/engine/pull/20662) [windows] Mostly eliminate the state structs (affects: desktop, cla: yes, platform-windows)

[20665](https://github.com/flutter/engine/pull/20665) All shape related structs are together (cla: yes, waiting for tree to go green)

[20668](https://github.com/flutter/engine/pull/20668) [windows] Add horizontal scroll support (affects: desktop, cla: yes, platform-windows)

[20669](https://github.com/flutter/engine/pull/20669) Revert "Paragraph.longest_line_ to account for trailing inline placeholders" (cla: yes)

[20671](https://github.com/flutter/engine/pull/20671) Enable ios platform view by default (cla: yes, platform-ios, waiting for tree to go green)

[20672](https://github.com/flutter/engine/pull/20672) [embedder] Add gl present callback that takes present info (cla: yes, platform-android, platform-ios, waiting for tree to go green)

[20673](https://github.com/flutter/engine/pull/20673) Remove image sizes from Picture::GetAllocationSize (cla: yes, waiting for tree to go green)

[20678](https://github.com/flutter/engine/pull/20678) Reland "account for inline placeholders in longest line calculation (#20370)" reverted in (#20669) (cla: yes, waiting for tree to go green)

[20679](https://github.com/flutter/engine/pull/20679) Fix the format script so that it works with deleted files. (cla: yes)

[20681](https://github.com/flutter/engine/pull/20681) fuchsia: Fix elevation issues (affects: engine, cla: yes, platform-fuchsia)

[20697](https://github.com/flutter/engine/pull/20697) fuchsia: Disable flaky test (affects: tests, cla: yes, platform-fuchsia)

[20699](https://github.com/flutter/engine/pull/20699) fuchsia: Rollback broken SDK and re-enable test (affects: tests, cla: yes, platform-fuchsia)

[20700](https://github.com/flutter/engine/pull/20700) Avoid passing nil to IOS accessibility announcement  (cla: yes, platform-ios, waiting for tree to go green)

[20701](https://github.com/flutter/engine/pull/20701) Ignore calls to AccessibilityBridge listeners after release (cla: yes, platform-android)

[20704](https://github.com/flutter/engine/pull/20704) fuchsia: Clean shell_unittests under FEMU (affects: tests, cla: yes, platform-fuchsia)

[20706](https://github.com/flutter/engine/pull/20706) Fix race condition and data race in FrameInfoContainsValidWidthAndHeight. (cla: yes)

[20708](https://github.com/flutter/engine/pull/20708) The `ForwardingGestureRecognizers` to have back reference to the `PlatformViewsController` so it can access `FlutterViewController` when its available  (cla: yes, platform-ios, waiting for tree to go green)

[20721](https://github.com/flutter/engine/pull/20721) Ensure loop is woken up at the right time (cla: yes)

[20722](https://github.com/flutter/engine/pull/20722) Enable hybrid composition by default on Android (cla: yes, platform-android)

[20733](https://github.com/flutter/engine/pull/20733) Pass platform configuration to Dart VM for insecure socket policy (cla: yes, platform-android, platform-ios, waiting for tree to go green)

[20735](https://github.com/flutter/engine/pull/20735) Fix EGL_BAD_SURFACE when app is paused (cla: yes, platform-android)

[20736](https://github.com/flutter/engine/pull/20736) Reland: Implement delayed event synthesis key event handling for Android (cla: yes, platform-android)

[20745](https://github.com/flutter/engine/pull/20745) Revert "Enable hybrid composition by default on Android" (cla: yes, platform-android)

[20746](https://github.com/flutter/engine/pull/20746) Revert hint_freed (cla: yes)

[20747](https://github.com/flutter/engine/pull/20747) [web] Make word boundary consistent with native flutter (cla: yes, platform-web)

[20750](https://github.com/flutter/engine/pull/20750) Image.toByteData and Picture.toImage implementations (#3) (cla: yes)

[20754](https://github.com/flutter/engine/pull/20754) Use hint freed specifically for image disposal (cla: yes)

[20758](https://github.com/flutter/engine/pull/20758) Manual roll of Dart from 5ca1f32905 to 551e405d0b (cla: yes)

[20760](https://github.com/flutter/engine/pull/20760) Default C++ wrapper templates to EncodableValue (affects: desktop, cla: yes, platform-windows)

[20761](https://github.com/flutter/engine/pull/20761) fuchsia: Call out legacy rasterizer code (affects: engine, cla: yes, platform-fuchsia)

[20763](https://github.com/flutter/engine/pull/20763) Consolidate FlRenderer initialization into fl_renderer_start() (cla: yes)

[20765](https://github.com/flutter/engine/pull/20765) Remove support for option 'dart_custom_version_for_pub' (cla: yes)

[20767](https://github.com/flutter/engine/pull/20767) [web] Better format for line break tests (affects: tests, cla: yes, platform-web, waiting for tree to go green)

[20769](https://github.com/flutter/engine/pull/20769) Let FlutterActivity/Fragment/FragmentActivity have an app bundle path override instead of eager resolving during construction (cla: yes, platform-android)

[20770](https://github.com/flutter/engine/pull/20770) Revert "Roll Fuchsia Linux SDK from LhYt1i9FP... to al88o71XB..." (cla: yes)

[20771](https://github.com/flutter/engine/pull/20771) |MessageLoopImpl::FlushTasks| runs one task at a time (cla: yes, waiting for tree to go green)

[20778](https://github.com/flutter/engine/pull/20778) Add tests for lerpDouble (cla: yes)

[20786](https://github.com/flutter/engine/pull/20786) Guard recording_canvas against restore calls without ending recording (cla: yes)

[20789](https://github.com/flutter/engine/pull/20789) Add a java injector for testing (cla: yes, platform-android)

[20790](https://github.com/flutter/engine/pull/20790) Revert "[fuchsia] Adds a test for clock change (#19993)" (cla: yes)

[20797](https://github.com/flutter/engine/pull/20797) Flutter Engine Beta 1.21.0-9.2.pre cherry picks (cla: yes, platform-android, platform-ios)

[20798](https://github.com/flutter/engine/pull/20798) [fuchsia] Link to SDK version of script (cla: yes, platform-fuchsia, waiting for tree to go green)

[20800](https://github.com/flutter/engine/pull/20800) Add ability to disable the raster thread merger (cla: yes, platform-android)

[20802](https://github.com/flutter/engine/pull/20802) [web] Implement SceneBuilder.pushColorFilter for html (cla: yes)

[20803](https://github.com/flutter/engine/pull/20803) [web] Fix path rendering when addPolygon is chained with other verbs. (cla: yes)

[20805](https://github.com/flutter/engine/pull/20805) Fix iOS text field input keyboard flickering & crash (cla: yes, platform-ios, waiting for tree to go green)

[20812](https://github.com/flutter/engine/pull/20812) Revert "Pass platform configuration to Dart VM for insecure socket policy" (cla: yes, platform-android, platform-ios)

[20818](https://github.com/flutter/engine/pull/20818) Revert "Pass platform configuration to Dart VM for insecure socket po… (cla: yes, platform-android, platform-ios)

[20820](https://github.com/flutter/engine/pull/20820) Revert "[web] Implement SceneBuilder.pushColorFilter for html" (cla: yes)

[20821](https://github.com/flutter/engine/pull/20821) [web] Implement SceneBuilder.pushColorFilter for html (cla: yes)

[20825](https://github.com/flutter/engine/pull/20825) [web] Fix analyzer warnings in web engine. (cla: yes)

[20827](https://github.com/flutter/engine/pull/20827) [fuchsia] Add fuchsia_ctl func to test script (cla: yes, waiting for tree to go green)

[20829](https://github.com/flutter/engine/pull/20829) Reland "Pass platform configuration to Dart VM for insecure socket policy" (cla: yes, platform-android, platform-ios)

[20833](https://github.com/flutter/engine/pull/20833) Replace FlRenderer::get_visual() with FlRenderer::setup_window_attr() (cla: yes)

[20837](https://github.com/flutter/engine/pull/20837) [web] Nullability fix. Added ClipOp to EngineCanvas. (cla: yes)

[20838](https://github.com/flutter/engine/pull/20838) Flutter 1.20.3 engine cherrypicks (cla: yes, platform-android, platform-ios)

[20840](https://github.com/flutter/engine/pull/20840) adjust blur radius for HTML to match CanvasKit (cla: yes)

[20841](https://github.com/flutter/engine/pull/20841) [web] Change code locations for engine unit tests (cla: yes, platform-web)

[20842](https://github.com/flutter/engine/pull/20842) Ensure all images are closed in FlutterImageView (cla: yes, platform-android)

[20843](https://github.com/flutter/engine/pull/20843) [Android R] Sync keyboard animation with view insets vs Android 11/R/API 30 WindowInsetsAnimation (affects: engine, affects: text input, cla: yes, platform-android)

[20846](https://github.com/flutter/engine/pull/20846) [web] Fix path clip crash when reused (cla: yes)

[20848](https://github.com/flutter/engine/pull/20848) lerpDouble: add tests for NaN, infinity (cla: yes)

[20864](https://github.com/flutter/engine/pull/20864) Reland: Enable hybrid composition by default on Android (#20722) (cla: yes, platform-android)

[20865](https://github.com/flutter/engine/pull/20865) Add auto plugin registration to FlutterFragmentActivity as well (cla: yes, platform-android)

[20869](https://github.com/flutter/engine/pull/20869) Reset Shell::weak_factory_gpu_ on the raster thread (cla: yes, waiting for tree to go green)

[20871](https://github.com/flutter/engine/pull/20871) lerpDouble: stricter handling of NaN and infinity (cla: yes)

[20874](https://github.com/flutter/engine/pull/20874) Extract Dart test utilities library (cla: yes)

[20879](https://github.com/flutter/engine/pull/20879) Improve the precision of lerpDouble (cla: yes)

[20880](https://github.com/flutter/engine/pull/20880) Add integer input tests for lerpDouble (cla: yes)

[20895](https://github.com/flutter/engine/pull/20895) Enable lazy-async-stacks by-default in all modes (Take 3) (cla: yes)

[20899](https://github.com/flutter/engine/pull/20899) Member variables should appear before the |WeakPtrFactory|. (cla: yes)

[20905](https://github.com/flutter/engine/pull/20905) Fix race condition in OnPlatformViewDestroyDisablesThreadMerger (cla: yes)

[20910](https://github.com/flutter/engine/pull/20910) Wait for first frame before checking layer tree (cla: yes)

[20912](https://github.com/flutter/engine/pull/20912) Pass text input key events to the EventResponder if they do not yield characters (cla: yes, platform-android)

[20914](https://github.com/flutter/engine/pull/20914) [web] migrate from e2e to integration_test (cla: yes)

[20915](https://github.com/flutter/engine/pull/20915) improve sensitivity of BackdropFilter web tests (cla: yes)

[20916](https://github.com/flutter/engine/pull/20916) Ensure the destructor is called since it destroys the `EGLSurface` before creating a new onscreen surface. (cla: yes, platform-android)

[20921](https://github.com/flutter/engine/pull/20921) [Android R] Integrate DisplayCutouts into viewportMetrics (cla: yes, platform-android, waiting for tree to go green)

[20922](https://github.com/flutter/engine/pull/20922) Increase thread priority before engine init (cla: yes, perf: speed, platform-android, severe: performance)

[20931](https://github.com/flutter/engine/pull/20931) Clear the GL context only after submitting the frame (cla: yes)

[20932](https://github.com/flutter/engine/pull/20932) Log the results when ShellTest.Screenshot fails (cla: yes, waiting for tree to go green)

[20935](https://github.com/flutter/engine/pull/20935) Log exception in addition to the stack trace for unhandled exceptions. (cla: yes)

[20936](https://github.com/flutter/engine/pull/20936) Revert "Adds fuchsia node roles to accessibility bridge updates." (cla: yes)

[20937](https://github.com/flutter/engine/pull/20937) Revert "Create root isolate asynchronously" (cla: yes, waiting for tree to go green)

[20950](https://github.com/flutter/engine/pull/20950) Revert external size changes to Picture (cla: yes)

[20953](https://github.com/flutter/engine/pull/20953) restore FML_DCHECK removed due to a code reviewing error (cla: yes)

[20954](https://github.com/flutter/engine/pull/20954) renaming e2e tests to integration (cla: yes)

[20957](https://github.com/flutter/engine/pull/20957) Clear GL context before Gr context (cla: yes)

[20960](https://github.com/flutter/engine/pull/20960) Started printing out error messages when the observatory won't be reachable because of permissions problems. (cla: yes, platform-ios)

[20965](https://github.com/flutter/engine/pull/20965) Only clear GL context after changing the thread configuration (cla: yes, waiting for tree to go green)

[20967](https://github.com/flutter/engine/pull/20967) Manual roll of Dart b29f228f62...016e8880f0 (cla: yes)

[20974](https://github.com/flutter/engine/pull/20974) [fuchsia] Send trace events to system tracing on all configurations (cla: yes)

[20976](https://github.com/flutter/engine/pull/20976) Always set the callback during Rasterizer setup (cla: yes, waiting for tree to go green)

[20980](https://github.com/flutter/engine/pull/20980) Avoid crashing and display error if the process cannot be prepared for JIT mode Dart VM. (cla: yes, platform-ios)

[20983](https://github.com/flutter/engine/pull/20983) Don't use GetTaskQueueId() in rasterizer as it breaks Fuchsia (cla: yes, waiting for tree to go green)

[20984](https://github.com/flutter/engine/pull/20984) fuchsia: Compile disabled RasterThreadMerger code (affects: tests, cla: yes, platform-fuchsia, waiting for tree to go green)

[20986](https://github.com/flutter/engine/pull/20986) Update test Dart code to pass the latest Dart analyzer rules (cla: yes)

[20991](https://github.com/flutter/engine/pull/20991) Tweak the mdns error message (cla: yes, platform-ios)

[21001](https://github.com/flutter/engine/pull/21001) Don't use GetTaskQueueId() in rasterizer as it breaks Fuchsia (#20983) (cla: yes)

[21010](https://github.com/flutter/engine/pull/21010) Update web lerpDouble to match C++ behaviour (cla: yes)

[21025](https://github.com/flutter/engine/pull/21025) Update Android SDK to 30r3 (cla: yes, platform-android)

[21029](https://github.com/flutter/engine/pull/21029) Fixed ios layout change to not refocus semantics object if the focus … (cla: yes, platform-ios)

[21043](https://github.com/flutter/engine/pull/21043) Revert "Enable lazy-async-stacks by-default in all modes (Take 3)" (cla: yes)

[21046](https://github.com/flutter/engine/pull/21046) Check for dart2js on felt startup (cla: yes)

[21049](https://github.com/flutter/engine/pull/21049) Adds increment/decrement actions to fuchsia accessibility bridge. (cla: yes)

[21050](https://github.com/flutter/engine/pull/21050) Open a fresh dir during LoadSkSLs (cla: yes)

[21058](https://github.com/flutter/engine/pull/21058) Rename Registrar to PluginRegistrar in Win/GLFW C API (cla: yes, waiting for tree to go green)

[21060](https://github.com/flutter/engine/pull/21060) Cherrypick Dart 5e8b31a5fa48 (cla: yes)

[21061](https://github.com/flutter/engine/pull/21061) Remove the type parameter from `SkObjectFinalizationRegistry`. (cla: yes, waiting for tree to go green)

[21069](https://github.com/flutter/engine/pull/21069) Add missing <cstring> header (cla: yes)

[21075](https://github.com/flutter/engine/pull/21075) Disable a flaky Scenarios test (cla: yes)

### Merged PRs in `flutter/plugins` from 2020-07-09T05:19:00.000 to 2020-09-10T18:17:00.000
There were 65 pull requests.

[970](https://github.com/flutter/plugins/pull/970) [share] Add sharing file support (android & ios) (cla: yes, in review)

[2824](https://github.com/flutter/plugins/pull/2824) [google_sign_in] Bridge google_sign_in and googleapis. (cla: yes)

[2845](https://github.com/flutter/plugins/pull/2845) [path_provider] Use the application ID in the application support path (cla: yes)

[2848](https://github.com/flutter/plugins/pull/2848) [camera] Improving handling when camera permissions are not granted. (cla: yes)

[2866](https://github.com/flutter/plugins/pull/2866) [e2e] Fix incorrect test results when one test passes then another fails (cla: yes)

[2869](https://github.com/flutter/plugins/pull/2869) [connectivity_for_web] Fix JS Interop in release mode. (cla: yes)

[2872](https://github.com/flutter/plugins/pull/2872) [in_app_purchase] Fix the bug that prevent restored subscription transactions from being completed (cla: yes)

[2873](https://github.com/flutter/plugins/pull/2873) [e2e] add support to report extra information (cla: yes, waiting for test harness)

[2889](https://github.com/flutter/plugins/pull/2889) Make package:e2e a relative reference (cla: yes)

[2896](https://github.com/flutter/plugins/pull/2896) Revert "[path_provider] Use the application ID in the application support path" (cla: yes)

[2898](https://github.com/flutter/plugins/pull/2898) Clarify e2e readme for running on firebase test lab (cla: yes)

[2902](https://github.com/flutter/plugins/pull/2902) [in_app_purchases] Fixed typo 'manuelly' for 'manually' (cla: yes)

[2903](https://github.com/flutter/plugins/pull/2903) [google_maps_flutter(_platform_interface)] Make the plugin friendlier to the web implementation. (cla: yes)

[2904](https://github.com/flutter/plugins/pull/2904) [web] Adding capability to e2e to take screenshot for web tests. (cla: yes, waiting for test harness)

[2906](https://github.com/flutter/plugins/pull/2906) [e2e] Add new e2e_driver for handling response data and performance watcher (waiting for test harness)

[2908](https://github.com/flutter/plugins/pull/2908) [google_maps_flutter_platform_interface] Add dispose method. ()

[2909](https://github.com/flutter/plugins/pull/2909) [google_maps_flutter] Call platform.dispose on GoogleMap widget dispose. (cla: yes)

[2915](https://github.com/flutter/plugins/pull/2915) [e2e] Update code onwer. (cla: yes)

[2917](https://github.com/flutter/plugins/pull/2917) [e2e] revert performance tracker utilities (waiting for test harness)

[2918](https://github.com/flutter/plugins/pull/2918) Rename e2e -> integration_test (cla: yes)

[2921](https://github.com/flutter/plugins/pull/2921) Add README instructions for enablePendingPurchases (cla: yes)

[2922](https://github.com/flutter/plugins/pull/2922) [video_player] Set audio mix options (cla: yes)

[2923](https://github.com/flutter/plugins/pull/2923) [device_info] Changed directory of device_info (cla: yes, waiting for test harness)

[2924](https://github.com/flutter/plugins/pull/2924) [google_maps_flutter] Pin GoogleMaps cocoapod dep to last good known version (cla: yes)

[2927](https://github.com/flutter/plugins/pull/2927) [video_player_platform_interface] Add interface changes for audio mix mode (cla: yes)

[2928](https://github.com/flutter/plugins/pull/2928) Fix unguarded availability in Camera plugin (cla: yes)

[2929](https://github.com/flutter/plugins/pull/2929) [device_info] Platform interface added in device_info (cla: yes, waiting for test harness)

[2932](https://github.com/flutter/plugins/pull/2932) fixed url_launcher link in url_launcher_web README  (cla: yes)

[2933](https://github.com/flutter/plugins/pull/2933) [google_maps_flutter_web] First version of the plugin. (cla: yes)

[2934](https://github.com/flutter/plugins/pull/2934) [versions] increase package:platform constraint (cla: yes)

[2936](https://github.com/flutter/plugins/pull/2936) MORE SHARDS MEANS MORE CI (cla: yes)

[2938](https://github.com/flutter/plugins/pull/2938) Revert "[video_player] Set audio mix options (#2922)" (cla: yes)

[2939](https://github.com/flutter/plugins/pull/2939) Reland "[video_player] Set audio mix options (#2922)" (cla: yes)

[2942](https://github.com/flutter/plugins/pull/2942) [device_info] Port device_info to use platform interface (cla: yes, waiting for test harness)

[2944](https://github.com/flutter/plugins/pull/2944) [battery] Updated README.md (cla: yes, waiting for test harness)

[2945](https://github.com/flutter/plugins/pull/2945) [google_maps_flutter_web] Port e2e tests to integration_test package. (cla: yes, waiting for test harness)

[2947](https://github.com/flutter/plugins/pull/2947) [integration_test] add support to get timeline (cla: yes, waiting for test harness)

[2948](https://github.com/flutter/plugins/pull/2948) [android_intent] fix platform package dep (cla: yes)

[2950](https://github.com/flutter/plugins/pull/2950) [shared_preferences_linux] update `file` package dep version to be compatible with framework (cla: yes)

[2955](https://github.com/flutter/plugins/pull/2955) [image_picker] Updating documentation to use isEmpty check. (cla: yes)

[2956](https://github.com/flutter/plugins/pull/2956) [integration_test] Minor cleanup (cla: yes)

[2959](https://github.com/flutter/plugins/pull/2959) [path_provider, video_player] Tweak pubspecs to pass bulk analysis. (cla: yes)

[2963](https://github.com/flutter/plugins/pull/2963) [integration_test] Remove debugging statement (cla: yes)

[2964](https://github.com/flutter/plugins/pull/2964) Geodesic Polyline support in iOS (cla: yes)

[2966](https://github.com/flutter/plugins/pull/2966) Rebase previous commits (cla: yes)

[2967](https://github.com/flutter/plugins/pull/2967) [integration_test] Show stack trace of widget test errors on the platform side (cla: yes)

[2968](https://github.com/flutter/plugins/pull/2968) [video_player_platform_interface] fix `setMixIWithOthers` test channel (cla: yes)

[2969](https://github.com/flutter/plugins/pull/2969) [battery] Moved battery to subdir (cla: yes)

[2970](https://github.com/flutter/plugins/pull/2970) [video_player] Fix `setWithOthers` test (cla: yes)

[2972](https://github.com/flutter/plugins/pull/2972) [integration_test] Fix channel name for iOS, docs (cla: yes)

[2974](https://github.com/flutter/plugins/pull/2974) [url_launcher_platform_interface] Add webOnlyWindowName parameter to launch() (cla: yes, waiting for test harness)

[2975](https://github.com/flutter/plugins/pull/2975) [battery_platform_interface] Introduce package. (cla: yes)

[2977](https://github.com/flutter/plugins/pull/2977) [flutter_plugin_android_lifecycle] add no-op v2 plugin (cla: yes)

[2979](https://github.com/flutter/plugins/pull/2979) [url_launcher]Added webOnlyWindowName parameter to launch()  (cla: yes)

[2980](https://github.com/flutter/plugins/pull/2980) [battery] Port battery to use platform interface (cla: yes)

[2984](https://github.com/flutter/plugins/pull/2984) [url_launcher, url_launcher_web] Fix API dependencies. (cla: yes, waiting for test harness)

[2985](https://github.com/flutter/plugins/pull/2985) [google_maps_flutter] Fix Android unit test. (cla: yes, waiting for test harness)

[2989](https://github.com/flutter/plugins/pull/2989) Support Windows in incremental_build.sh (cla: yes)

[2992](https://github.com/flutter/plugins/pull/2992) Standardize LICENSE body text formatting (cla: yes)

[2993](https://github.com/flutter/plugins/pull/2993) Add LUCI try builders json config file (cla: yes)

[3006](https://github.com/flutter/plugins/pull/3006) [device_info_platform_interface] Typo in doc fixed (cla: yes)

[3007](https://github.com/flutter/plugins/pull/3007) [image_picker_for_web] Can't select some video file types (3gp, mp4, possibly others...) (cla: yes)

[3008](https://github.com/flutter/plugins/pull/3008) [url_launcher] Suppress deprecation warning in WebViewActivity (cla: yes)

[3010](https://github.com/flutter/plugins/pull/3010) [url_launcher_web] Fix a typo in a test name and fix quote consistency (cla: yes, waiting for test harness)

[3011](https://github.com/flutter/plugins/pull/3011) [google_maps_flutter] Fix typo in google_maps_flutter/example/map_ui.dart (cla: yes)


