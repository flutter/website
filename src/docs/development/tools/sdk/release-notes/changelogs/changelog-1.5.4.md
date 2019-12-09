---
title: Change log for Flutter 1.5.4 
short-title: 1.5.4 change log
description: Change log for Flutter 1.5.4 containing a list of all PRs merged for this release.
---

## PRs closed in this release of flutter/flutter

From Thu Feb 21 20:22:00 2019 -0800 to Wed May 1 16:56:00 2019 -0700


[21834](https://github.com/flutter/flutter/pull/21834)  Add shapeBorder option on App Bar (cla: yes, f: material design, framework)

[21896](https://github.com/flutter/flutter/pull/21896) Bottom sheet scrolling (a: animation, cla: yes, f: material design, f: routes, framework)

[22762](https://github.com/flutter/flutter/pull/22762) Add support for scrollwheels (cla: yes, f: gestures, framework)

[22810](https://github.com/flutter/flutter/pull/22810) build the gallery on PRs (cla: yes, team)

[24476](https://github.com/flutter/flutter/pull/24476) Fix text selection handles showing outside the visible text region (a: text input, cla: yes, framework)

[25164](https://github.com/flutter/flutter/pull/25164) Pan and zoom gallery demo (cla: yes, team, team: gallery)

[25202](https://github.com/flutter/flutter/pull/25202) fix #19175 How should addTime be used from a test? (a: tests, cla: yes, framework, team: gallery, waiting for tree to go green)

[26438](https://github.com/flutter/flutter/pull/26438) Breaks the moveBy call from drag and dragFrom into two separate calls and changes the default behavior of DragStartBehavior to DragStartBehavior.start (cla: yes, f: gestures, framework, severe: API break)

[26785](https://github.com/flutter/flutter/pull/26785) Document that SearchDelegate.buildResults can be called multiple time… (cla: yes, d: api docs, f: material design, framework, team: flakes, team: gallery)

[27034](https://github.com/flutter/flutter/pull/27034) Updated package template .gitignore file (cla: yes, tool)

[27205](https://github.com/flutter/flutter/pull/27205) Fix TextField height issues (a: text input, cla: no, framework)

[27217](https://github.com/flutter/flutter/pull/27217) Fix Shrine overscroll glow indicator (cla: yes, f: material design, framework, team, team: gallery)

[27435](https://github.com/flutter/flutter/pull/27435) Add lerping between LinearGradients with arbitrary number of colors and stops (cla: yes, framework, waiting for tree to go green)

[27572](https://github.com/flutter/flutter/pull/27572) Remove the flutter_shared assets directory from the Gradle script (cla: yes, tool)

[27612](https://github.com/flutter/flutter/pull/27612)  Force line height in TextFields with strut (a: text input, a: typography, cla: yes, f: cupertino, f: material design, framework, severe: API break)

[27660](https://github.com/flutter/flutter/pull/27660) Shader warm up (cla: yes, framework, severe: performance)

[27711](https://github.com/flutter/flutter/pull/27711) Make extended FAB's icon optional (a: fidelity, cla: yes, f: material design, framework)

[27712](https://github.com/flutter/flutter/pull/27712) add2app test (a: existing-apps, a: tests, cla: yes, engine, waiting for tree to go green)

[27749](https://github.com/flutter/flutter/pull/27749) Switch flutter_tools from script to app-jit snapshot. (cla: yes, tool)

[27751](https://github.com/flutter/flutter/pull/27751) Add Sample code for FlatButton #21136 (cla: yes, d: api docs, f: material design, framework)

[27811](https://github.com/flutter/flutter/pull/27811) set literal conversions (cla: yes, framework, team)

[27898](https://github.com/flutter/flutter/pull/27898) Add slight clarification to debugDeterministicCursor (a: text input, cla: yes, framework, waiting for tree to go green)

[27903](https://github.com/flutter/flutter/pull/27903) Lazily download artifacts (III): The Revenge of the Sith (cla: yes, tool)

[27904](https://github.com/flutter/flutter/pull/27904) Convert PointerEvent's toString to Diagnosticable (a: debugging, cla: yes, f: gestures, framework)

[27944](https://github.com/flutter/flutter/pull/27944) Add tests (a: tests, cla: yes, tool)

[27971](https://github.com/flutter/flutter/pull/27971) Run non-perf sensitive tests on Cirrus (a: tests, cla: yes, framework, team)

[28001](https://github.com/flutter/flutter/pull/28001) CupertinoTextField: added ability to change placeholder color (a: text input, cla: yes, f: cupertino, framework, waiting for tree to go green)

[28004](https://github.com/flutter/flutter/pull/28004) Paint backgroundColor in CircularProgressIndicator (cla: yes, f: material design, framework)

[28013](https://github.com/flutter/flutter/pull/28013) [Material] Unit test for skipping Slider tick mark due to overdensity (cla: yes, f: material design, framework)

[28017](https://github.com/flutter/flutter/pull/28017) Add more docs to BackdropFilter (cla: yes, d: api docs, framework)

[28097](https://github.com/flutter/flutter/pull/28097) Allow for gradle downloading missing SDK assets (cla: yes, t: gradle, tool)

[28125](https://github.com/flutter/flutter/pull/28125) [Gallery] Fortnightly demo moved from flutter/samples. (cla: yes, team, team: gallery)

[28152](https://github.com/flutter/flutter/pull/28152) Improve hot reload performance (cla: yes, t: hot reload, tool)

[28157](https://github.com/flutter/flutter/pull/28157) Add await to future to please analyzer (cla: yes, framework, team)

[28159](https://github.com/flutter/flutter/pull/28159) [Material] Expand BottomNavigationBar API (reprise) (cla: no, f: material design, framework)

[28163](https://github.com/flutter/flutter/pull/28163) [Material] Add ability to set shadow color and selected shadow color for chips and for chip themes (cla: yes, f: material design, framework)

[28166](https://github.com/flutter/flutter/pull/28166) Add some more CupertinoPicker doc (cla: yes, d: api docs, f: cupertino, framework)

[28168](https://github.com/flutter/flutter/pull/28168) [flutter_tool,fuchsia_tester] Only require a test source dir for coverage (a: tests, cla: yes, tool, ○ platform-fuchsia)

[28169](https://github.com/flutter/flutter/pull/28169) Add/rewrite tests for FocusScope. (a: text input, cla: yes, framework)

[28171](https://github.com/flutter/flutter/pull/28171) deploy to .dev firebase projects. (cla: yes, team)

[28172](https://github.com/flutter/flutter/pull/28172) Add backgroundColor argument to TextStyle for convenience (cla: yes, framework)

[28174](https://github.com/flutter/flutter/pull/28174) No shrinking for BackdropFilter's cull rect (cla: yes, framework, severe: API break, waiting for tree to go green)

[28175](https://github.com/flutter/flutter/pull/28175) Only call Activity.reportFullyDrawn on Lollipop or above (cla: yes, team, team: gallery)

[28193](https://github.com/flutter/flutter/pull/28193) Clean up flutter_gallery.cmx's sandbox (cla: yes, team, team: gallery)

[28214](https://github.com/flutter/flutter/pull/28214) [Material] Add the ability to theme trailing app bar actions independently from leading (cla: yes, f: material design, framework)

[28215](https://github.com/flutter/flutter/pull/28215) Minor UI tweaks to Cards demo based on internal feedback (cla: yes, team, team: gallery)

[28242](https://github.com/flutter/flutter/pull/28242) Add long-press-move support for text fields 2 (a: text input, cla: yes, f: cupertino, f: gestures, f: material design, framework, severe: API break)

[28245](https://github.com/flutter/flutter/pull/28245) [Typo] Update 'use' to 'user' (cla: yes, d: api docs, f: material design, framework)

[28264](https://github.com/flutter/flutter/pull/28264) Fix the length of the valueHelp on the --sample option for the create command, and turn on wrapping. (cla: yes, d: examples, tool)

[28280](https://github.com/flutter/flutter/pull/28280) [fuchsia] Fix paths to find and ls (cla: yes, tool, ○ platform-fuchsia)

[28281](https://github.com/flutter/flutter/pull/28281) Reduce memory benchmark perf tests outer loop to 10. (cla: yes, team)

[28290](https://github.com/flutter/flutter/pull/28290) Text selection via mouse (a: text input, cla: yes, f: gestures, framework)

[28291](https://github.com/flutter/flutter/pull/28291) Reland #27754, now that bsdiff has moved to flutter/packages. (cla: yes, team)

[28295](https://github.com/flutter/flutter/pull/28295) Revert "Allow for gradle downloading missing SDK assets" (cla: yes, tool, ▣ platform-android)

[28296](https://github.com/flutter/flutter/pull/28296) Roll the engine to 5db4b377244bae48bc21e449e616417e68c9a6b9 (cla: yes)

[28297](https://github.com/flutter/flutter/pull/28297) Test reporter (a: tests, cla: yes, team, waiting for tree to go green)

[28302](https://github.com/flutter/flutter/pull/28302) Add basic web device and run support (cla: yes, tool)

[28308](https://github.com/flutter/flutter/pull/28308) Roll engine to 043d92c48abdebdad926569bc204a59c5cf20a11 (cla: yes)

[28309](https://github.com/flutter/flutter/pull/28309) Roll engine to cb0f7ece1f251c78a07550db89d0fcb3edf61e3c (cla: yes)

[28315](https://github.com/flutter/flutter/pull/28315) Roll engine to 33bb91cc15916610261097eb971ec8a11b804d06 (cla: yes)

[28334](https://github.com/flutter/flutter/pull/28334) Remove unused --packages argument to gen_snapshot. (cla: yes, team, tool)

[28341](https://github.com/flutter/flutter/pull/28341) use deviceManager discovery in daemon protocol (cla: yes, tool)

[28343](https://github.com/flutter/flutter/pull/28343) pass --skip-build-script-checks and remove module usage (cla: yes, team)

[28346](https://github.com/flutter/flutter/pull/28346) [flutter_tool,fuchsia] Add missing dep to flutter_tool (cla: yes, team, tool)

[28349](https://github.com/flutter/flutter/pull/28349) Dynamic patching support for native code libraries. (cla: yes, t: gradle, tool, ▣ platform-android)

[28352](https://github.com/flutter/flutter/pull/28352) only perform multi-root mapping if there are multiple roots (cla: yes, tool)

[28355](https://github.com/flutter/flutter/pull/28355) Reland "Allow for gradle downloading missing SDK assets" (#28097) (cla: yes, t: gradle, tool, waiting for tree to go green, ▣ platform-android)

[28356](https://github.com/flutter/flutter/pull/28356) Log pub return code on failure on Windows (cla: yes, tool, ❖ platform-windows)

[28369](https://github.com/flutter/flutter/pull/28369) Add LICENSE test to presubmit checks (cla: yes, team)

[28370](https://github.com/flutter/flutter/pull/28370) Removed trailing whitespace from the end of the CI config (cla: yes, team)

[28371](https://github.com/flutter/flutter/pull/28371) Ensure that the DropdownButton menu respects its parents bounds (cla: yes, f: material design, framework)

[28372](https://github.com/flutter/flutter/pull/28372) V1.2.1 hotfix.1 --- cherry-pick  (cla: yes, team)

[28373](https://github.com/flutter/flutter/pull/28373) Mark non-flaky test as such (a: tests, cla: yes, team)

[28376](https://github.com/flutter/flutter/pull/28376) Revert "Shader warm up (#27660)" (cla: yes, team, team: flakes)

[28386](https://github.com/flutter/flutter/pull/28386) remove personal repo and replace with trivial example for smoke test (cla: yes, tool)

[28398](https://github.com/flutter/flutter/pull/28398) fix red build for analysis (a: typography, cla: yes, framework)

[28400](https://github.com/flutter/flutter/pull/28400) update packages (cla: yes, team)

[28431](https://github.com/flutter/flutter/pull/28431) [Gallery] Fix fortnightly analysis for consts. (cla: yes, team, team: gallery)

[28470](https://github.com/flutter/flutter/pull/28470) Throw assertion error when a Hero has a Hero child. (cla: yes, framework, waiting for tree to go green)

[28472](https://github.com/flutter/flutter/pull/28472) Add SHA256 checksums to published metadata (cla: yes, team)

[28477](https://github.com/flutter/flutter/pull/28477) Fix backspace and clear length in AnsiStatus (cla: yes, tool)

[28478](https://github.com/flutter/flutter/pull/28478) Support iOS devices reporting pressure data of 0 (cla: yes, f: cupertino, f: gestures, f: material design, ⚠ TODAY)

[28480](https://github.com/flutter/flutter/pull/28480) increase timeout (a: tests, cla: yes, team, team: flakes)

[28482](https://github.com/flutter/flutter/pull/28482) Fuschia -> Fuchsia (cla: yes, team)

[28517](https://github.com/flutter/flutter/pull/28517) remove json_schema dep again (cla: yes)

[28527](https://github.com/flutter/flutter/pull/28527) Be more strict about finding version number attached to a revision when packaging. (cla: yes, team)

[28530](https://github.com/flutter/flutter/pull/28530) Fix type issue of the timelineEvents assignment (cla: yes)

[28537](https://github.com/flutter/flutter/pull/28537) Reland "Shader warm up (#27660)" (cla: yes, framework, severe: performance)

[28540](https://github.com/flutter/flutter/pull/28540) Add animation curve slowMiddle (a: animation, cla: yes, framework, severe: new feature)

[28546](https://github.com/flutter/flutter/pull/28546) Call onTapCancel when down pointer gets cancelled (cla: yes, f: gestures, framework)

[28555](https://github.com/flutter/flutter/pull/28555) disable dart2js test (a: tests, cla: yes, team)

[28558](https://github.com/flutter/flutter/pull/28558) Fix typo (a: text input, cla: yes, d: api docs, f: material design)

[28597](https://github.com/flutter/flutter/pull/28597) Adjust remaining Cupertino route animations to match native (a: fidelity, cla: yes, f: cupertino, f: routes, waiting for tree to go green)

[28598](https://github.com/flutter/flutter/pull/28598) TextField Snippet for API Docs (cla: yes)

[28602](https://github.com/flutter/flutter/pull/28602) Allow PointerEnterEvent and PointerExitEvents to be created from any PointerEvent (a: desktop, cla: yes, f: gestures, framework, severe: API break)

[28603](https://github.com/flutter/flutter/pull/28603) select ResidentCompiler during FlutterDevice initialization (cla: yes, tool)

[28604](https://github.com/flutter/flutter/pull/28604) Add warnings and an example to the TextEditingController docs (a: text input, cla: yes, d: api docs, framework)

[28607](https://github.com/flutter/flutter/pull/28607) Roll engine to 3e4e6f5c54db7a705e6d50f7f3bddfa2ac0d6612 (cla: yes)

[28608](https://github.com/flutter/flutter/pull/28608) Roll engine to 4434a39c7d545ed47186b2f4d98cd09c8366e720 (cla: yes)

[28614](https://github.com/flutter/flutter/pull/28614) Add convex path and non-AA paint to shader warm-up (cla: yes, framework, p: firebase_performance)

[28619](https://github.com/flutter/flutter/pull/28619) Updated gallery light and dark themes (cla: yes, team, team: gallery)

[28629](https://github.com/flutter/flutter/pull/28629) Make sure everything in the Cupertino page transition can be linear when back swiping (cla: yes, f: cupertino, f: routes, framework)

[28638](https://github.com/flutter/flutter/pull/28638) Fix the test annotation used for test groups (a: tests, cla: yes, framework)

[28653](https://github.com/flutter/flutter/pull/28653) Fix ink highlight effect of RawChip (cla: yes)

[28657](https://github.com/flutter/flutter/pull/28657) Fix spelling errors. (cla: yes, framework)

[28658](https://github.com/flutter/flutter/pull/28658) Include git output into error message from channel command (cla: yes, team, tool)

[28661](https://github.com/flutter/flutter/pull/28661) Use a simpler implementation of Diagnosticable.toString when running in profile/release mode (cla: yes, framework)

[28663](https://github.com/flutter/flutter/pull/28663) Update TabController.indexIsChanging doc (cla: yes, framework)

[28666](https://github.com/flutter/flutter/pull/28666) Make RenderUiKitView reject absorbed touch events (cla: yes, framework)

[28669](https://github.com/flutter/flutter/pull/28669) Drive-by fix for TODO (cla: yes)

[28672](https://github.com/flutter/flutter/pull/28672) Support hotfix version numbers (cla: yes, tool)

[28673](https://github.com/flutter/flutter/pull/28673) Add missing trailing commas (cla: yes, team)

[28675](https://github.com/flutter/flutter/pull/28675) Update docs for ancestorWidgetOfExactType (cla: yes, d: api docs, framework, waiting for tree to go green)

[28679](https://github.com/flutter/flutter/pull/28679) Shader warm-up doc fixes (cla: yes)

[28681](https://github.com/flutter/flutter/pull/28681) Expanded Snippet for API Docs (cla: yes, d: api docs, d: examples)

[28683](https://github.com/flutter/flutter/pull/28683) Remove the old HaTS implementation on API docs (cla: yes, d: api docs)

[28684](https://github.com/flutter/flutter/pull/28684) Add capability to run build_runner tests for tool (cla: yes)

[28687](https://github.com/flutter/flutter/pull/28687) Make shader warm-up async so it can handle image (cla: yes)

[28688](https://github.com/flutter/flutter/pull/28688) Initialize the lifecycle state with initial state in window. Roll engine (19 commits) (cla: yes, customer: mulligan (g3), framework)

[28698](https://github.com/flutter/flutter/pull/28698) Roll engine to 99f3f7a9c246f1ebedc6eefd867cde250b370380 (cla: yes)

[28709](https://github.com/flutter/flutter/pull/28709) improve error messages on Text constructors (cla: yes, framework)

[28734](https://github.com/flutter/flutter/pull/28734) Update README.md (cla: yes)

[28735](https://github.com/flutter/flutter/pull/28735) [Material] Create a FloatingActionButton ThemeData and honor it within the FloatingActionButton (cla: yes, f: material design, framework)

[28736](https://github.com/flutter/flutter/pull/28736) Avoid the overhead of instantiating a generator in paintImage (cla: yes, framework)

[28746](https://github.com/flutter/flutter/pull/28746) Remove timeout from add2app test for iOS (a: tests, cla: yes, team, ⌺‬ platform-ios)

[28747](https://github.com/flutter/flutter/pull/28747) Part 1: Improve Overlay API (cla: yes, framework)

[28748](https://github.com/flutter/flutter/pull/28748) Revert "Remove the old HaTS implementation on API docs" (cla: yes, d: api docs, team)

[28749](https://github.com/flutter/flutter/pull/28749) Add minimum time gap requirement to double tap (cla: yes, f: gestures, framework)

[28751](https://github.com/flutter/flutter/pull/28751) Expose decorationThickness in TextStyle. Roll engine (12 commits) (a: typography, cla: yes, framework)

[28752](https://github.com/flutter/flutter/pull/28752) FAB Snippet for API Docs (cla: yes, d: api docs, d: examples, f: material design, framework)

[28756](https://github.com/flutter/flutter/pull/28756) Handle Cupertino back gesture interrupted by Navigator push (cla: yes, f: cupertino, framework)

[28759](https://github.com/flutter/flutter/pull/28759) switch tool tests to build runner (cla: yes)

[28799](https://github.com/flutter/flutter/pull/28799) Add semantics label to FadeInImage. (cla: yes, framework)

[28809](https://github.com/flutter/flutter/pull/28809) fix some formatting issues (cla: yes, framework, team)

[28821](https://github.com/flutter/flutter/pull/28821) [fuchsia] Permit relative entries to the fuchsia_tester (cla: yes, tool)

[28845](https://github.com/flutter/flutter/pull/28845) [Material] Fix radio ink ripple to be centered (cla: yes, f: material design, framework)

[28852](https://github.com/flutter/flutter/pull/28852) Update macOS version in tests (a: tests, cla: yes, team)

[28855](https://github.com/flutter/flutter/pull/28855) Move material iOS back swipe test to material (cla: yes, f: cupertino, framework)

[28857](https://github.com/flutter/flutter/pull/28857) Form Snippet for API Docs (cla: yes, d: api docs, d: examples, framework)

[28863](https://github.com/flutter/flutter/pull/28863) Fall-back to platform tools in Android SDK detection logic. (cla: yes, tool, waiting for tree to go green)

[28866](https://github.com/flutter/flutter/pull/28866) Add build script invalidation and snapshotting logic (cla: yes, tool)

[28873](https://github.com/flutter/flutter/pull/28873) Remove extra build_runner modes, remove flutter_build (cla: yes, tool)

[28888](https://github.com/flutter/flutter/pull/28888) Changed flutter.io to flutter.dev on each link on readme file (cla: yes, team)

[28899](https://github.com/flutter/flutter/pull/28899) Roll engine 4f54a1dd9...e6a5201f0 (cla: yes)

[28900](https://github.com/flutter/flutter/pull/28900) Add key support to cupertino button (cla: yes, f: cupertino, framework, waiting for tree to go green)

[28919](https://github.com/flutter/flutter/pull/28919) Always composite PhysicalModels (cla: yes, framework, severe: API break)

[28922](https://github.com/flutter/flutter/pull/28922) Fix crash on flutter update-packages (cla: yes)

[28933](https://github.com/flutter/flutter/pull/28933) Fix indentations of statements in BlockFunctionBody (cla: yes, framework, team)

[28938](https://github.com/flutter/flutter/pull/28938) Add a `flutter create --list-samples` command (cla: yes, tool)

[28944](https://github.com/flutter/flutter/pull/28944) fix missing variable name (cla: yes, framework, waiting for tree to go green)

[28951](https://github.com/flutter/flutter/pull/28951) Quick fix for shader warm up (cla: yes, framework)

[28953](https://github.com/flutter/flutter/pull/28953) Include platformViewId in semantics tree (cla: yes, framework, severe: API break)

[28955](https://github.com/flutter/flutter/pull/28955) Add more doc pointing to the EditableText's rudimentary nature around gesture handling (cla: yes, framework)

[28963](https://github.com/flutter/flutter/pull/28963) Fix for post submit on cirrus (cla: yes)

[28970](https://github.com/flutter/flutter/pull/28970) Fix coverage shard and print summary after test run (cla: yes, waiting for tree to go green)

[28975](https://github.com/flutter/flutter/pull/28975) Revert "Roll engine f4951df193a7..471a2c89a689 (11 commits)" (cla: yes)

[28990](https://github.com/flutter/flutter/pull/28990) Fix MouseTracker annotation leak (cla: yes, f: gestures, framework, waiting for tree to go green)

[29008](https://github.com/flutter/flutter/pull/29008) Update CupertinoTextField (cla: yes, f: cupertino, framework, waiting for tree to go green)

[29010](https://github.com/flutter/flutter/pull/29010) re-enable dart2js test (cla: yes, tool)

[29012](https://github.com/flutter/flutter/pull/29012) Remove doc references to obsolete SemanticsSortOrder (cla: yes)

[29016](https://github.com/flutter/flutter/pull/29016) make coverage work again (cla: yes)

[29020](https://github.com/flutter/flutter/pull/29020) Add integration to all targets (cla: yes)

[29023](https://github.com/flutter/flutter/pull/29023) update readme for LUCI (cla: yes)

[29024](https://github.com/flutter/flutter/pull/29024) Fix CupertinoTabView tree re-shape on view inset change (cla: yes, ⚠ TODAY)

[29025](https://github.com/flutter/flutter/pull/29025) print system time on all mac builds (a: tests, cla: yes, team)

[29030](https://github.com/flutter/flutter/pull/29030) Revert "re-enable dart2js test" (cla: yes)

[29048](https://github.com/flutter/flutter/pull/29048) Use async execution for xcodebuild commands (cla: yes, tool)

[29051](https://github.com/flutter/flutter/pull/29051) fix block formatting (cla: yes, framework, team)

[29053](https://github.com/flutter/flutter/pull/29053) Update to Container Sample Code in API Docs (cla: yes, d: api docs, d: examples, framework)

[29054](https://github.com/flutter/flutter/pull/29054) Deprecate profile() (cla: yes, framework, waiting for tree to go green)

[29056](https://github.com/flutter/flutter/pull/29056) add heartbeat (cla: yes)

[29057](https://github.com/flutter/flutter/pull/29057) Fix Flex class docs by replacing 'vertical space' with 'space on its main axis' so that the language fits both column and row. (cla: yes, framework, waiting for tree to go green)

[29062](https://github.com/flutter/flutter/pull/29062) fix windows codegen (cla: yes, tool)

[29064](https://github.com/flutter/flutter/pull/29064) Revert "Lazily download artifacts (III)" (cla: yes)

[29069](https://github.com/flutter/flutter/pull/29069) Heroes and nested Navigators (a: animation, cla: yes, framework)

[29072](https://github.com/flutter/flutter/pull/29072) Update to ListView Sample Code in API Docs (cla: yes, d: api docs, d: examples, framework)

[29073](https://github.com/flutter/flutter/pull/29073) Make sure test reporter prints out stderr, and disables Bigquery for non-contributors (a: tests, cla: yes, team)

[29093](https://github.com/flutter/flutter/pull/29093) Revert "Fix TextField height issues" (cla: yes)

[29126](https://github.com/flutter/flutter/pull/29126) Cause `flutter analyze` to fail if the analysis server experienced an error. (cla: yes, team, tool)

[29129](https://github.com/flutter/flutter/pull/29129) Update .cirrus.yml (cla: yes)

[29134](https://github.com/flutter/flutter/pull/29134) Properly escape Android SDK Manager path in error message (cla: yes, tool, waiting for tree to go green)

[29138](https://github.com/flutter/flutter/pull/29138) Update DropdownButton underline to be customizable (cla: yes, f: material design)

[29156](https://github.com/flutter/flutter/pull/29156) Fix typo in RefreshIndicator constructor API doc (cla: yes)

[29165](https://github.com/flutter/flutter/pull/29165) Docs edit for Tab Label Color (cla: yes, d: api docs, f: material design, framework)

[29171](https://github.com/flutter/flutter/pull/29171) Only run codegen at start of flutter_test (cla: yes, tool)

[29175](https://github.com/flutter/flutter/pull/29175) Ensure that animated pairs of Tabs TextStyles have matching inherited values (cla: yes, f: material design, framework)

[29179](https://github.com/flutter/flutter/pull/29179) No image shader caching in default shader warm-up (cla: yes, framework)

[29183](https://github.com/flutter/flutter/pull/29183) Implement labelPadding configuration in TabBarTheme  (cla: yes, f: material design, framework)

[29188](https://github.com/flutter/flutter/pull/29188) Fix 25807: implement move in sliver multibox widget (cla: yes, f: material design, framework, severe: API break)

[29189](https://github.com/flutter/flutter/pull/29189) MaterialButton shape should override ButtonTheme shape (cla: yes, f: material design, framework)

[29192](https://github.com/flutter/flutter/pull/29192) Update upgrade to rebase and stash local changes. (cla: yes, tool)

[29195](https://github.com/flutter/flutter/pull/29195) Add sample to forEachTween (a: animation, cla: yes, framework)

[29196](https://github.com/flutter/flutter/pull/29196) Detect and cleanup leaky processes (a: tests, cla: yes, team: flakes)

[29200](https://github.com/flutter/flutter/pull/29200) Cupertino localization step 1: add an English arb file (a: internationalization, cla: yes, f: cupertino, framework)

[29229](https://github.com/flutter/flutter/pull/29229) Install JDK and Android SDK only for integration tests (cla: yes, team, waiting for tree to go green)

[29231](https://github.com/flutter/flutter/pull/29231) Adds macOS raw keyboard mapping (a: desktop, cla: yes, framework)

[29236](https://github.com/flutter/flutter/pull/29236) Add skip to group in test_compat (a: tests, cla: yes, framework)

[29245](https://github.com/flutter/flutter/pull/29245) Fix DartDoc for UniqueKey (cla: yes, d: api docs, framework, waiting for tree to go green)

[29247](https://github.com/flutter/flutter/pull/29247) Update flutter_localizations translations (cla: yes)

[29250](https://github.com/flutter/flutter/pull/29250) Text field height attempt 2 (cla: yes, f: cupertino, f: material design, framework)

[29258](https://github.com/flutter/flutter/pull/29258) Add dump-shader-skp flag to flutter tools (cla: yes, tool)

[29273](https://github.com/flutter/flutter/pull/29273) Speculative fix for #29262 (a: tests, cla: yes, team)

[29304](https://github.com/flutter/flutter/pull/29304) Include platformViewId in semantics tree for iOS (a: accessibility, a: platform-views, cla: yes, framework, ⌺‬ platform-ios)

[29314](https://github.com/flutter/flutter/pull/29314) Revert "Always composite PhysicalModels" (cla: yes)

[29319](https://github.com/flutter/flutter/pull/29319) Revert "Speculative fix for #29262" (cla: yes)

[29321](https://github.com/flutter/flutter/pull/29321) add option for --verbose-system-logs (cla: yes)

[29329](https://github.com/flutter/flutter/pull/29329) Error message when TextSelectionOverlay finds no Overlay (cla: yes, framework)

[29330](https://github.com/flutter/flutter/pull/29330) Revert "Roll engine 31b289f277c6..b1b388f1c235 (7 commits)", Roll to 8b1a299ed instead. (cla: yes)

[29332](https://github.com/flutter/flutter/pull/29332) add assert if length of TabController and number of tabs do not match (cla: yes, f: material design, framework)

[29340](https://github.com/flutter/flutter/pull/29340) guard new formatter behind env var (a: tests, cla: yes, team)

[29342](https://github.com/flutter/flutter/pull/29342) Add semantic label finders (a: accessibility, a: tests, cla: yes, t: flutter driver)

[29363](https://github.com/flutter/flutter/pull/29363) Manual engine roll with goldens (cla: yes)

[29369](https://github.com/flutter/flutter/pull/29369) Update README.md (cla: yes, waiting for tree to go green)

[29374](https://github.com/flutter/flutter/pull/29374) Revert "Manual engine roll with goldens" (cla: yes)

[29377](https://github.com/flutter/flutter/pull/29377) Roll engine to 403337ebb893380101d1fa9cc435ce9b6cfeb22c (cla: yes)

[29383](https://github.com/flutter/flutter/pull/29383) --verbose-logging to verbose-logging in android (cla: yes)

[29385](https://github.com/flutter/flutter/pull/29385) Skip Dialog interaction on macos (cla: yes)

[29386](https://github.com/flutter/flutter/pull/29386) Use fs.identical to compare paths when finding the engine source path (cla: yes)

[29387](https://github.com/flutter/flutter/pull/29387) Make it easier to ensure semantics in widgetTests (a: accessibility, a: tests, cla: yes)

[29389](https://github.com/flutter/flutter/pull/29389) Update SDK constraints to reflect the fact that set literals are being used (cla: yes)

[29390](https://github.com/flutter/flutter/pull/29390) Make expansion panel optionally toggle its state by tapping its header. (cla: yes, f: material design, framework, severe: new feature)

[29395](https://github.com/flutter/flutter/pull/29395) Fix text selection when user is dragging in the opposite direction (a: text input, cla: yes, framework)

[29399](https://github.com/flutter/flutter/pull/29399) Enable code generation features in tool (via opt-in) (cla: yes, tool)

[29403](https://github.com/flutter/flutter/pull/29403) Disable widget inspector scroll test (cla: yes)

[29404](https://github.com/flutter/flutter/pull/29404) Improve flutter test startup time (cla: yes, tool)

[29407](https://github.com/flutter/flutter/pull/29407) [cupertino_icons] Add circle and circle_filled, for radio buttons. (cla: yes, f: cupertino, framework, waiting for tree to go green)

[29413](https://github.com/flutter/flutter/pull/29413) Fix MaterialApp's _navigatorObserver when only builder used (cla: yes, f: material design, framework)

[29434](https://github.com/flutter/flutter/pull/29434) Add builders and engine hash to fingerprint (cla: yes, tool)

[29442](https://github.com/flutter/flutter/pull/29442) Align Snippet for API Docs (cla: yes, d: api docs, d: examples, framework)

[29445](https://github.com/flutter/flutter/pull/29445) Add doc about MediaQuery to Chip (cla: yes, d: api docs, f: material design, framework)

[29451](https://github.com/flutter/flutter/pull/29451) Added opacity to cupertino switch when disabled (cla: yes, f: cupertino)

[29452](https://github.com/flutter/flutter/pull/29452) some spaces formatting (cla: yes, framework, team)

[29454](https://github.com/flutter/flutter/pull/29454) Update another SDK constraint (cla: yes, customer: fuchsia, team)

[29456](https://github.com/flutter/flutter/pull/29456) Fix for sometimes packages file is an APK (cla: yes)

[29461](https://github.com/flutter/flutter/pull/29461) Remove explicit frame schedule (cla: yes, tool)

[29463](https://github.com/flutter/flutter/pull/29463) Make real JSON in arb (cla: yes, f: cupertino, framework)

[29467](https://github.com/flutter/flutter/pull/29467) prevent stream notifications from interfering with reload (a: tests, cla: yes, team)

[29469](https://github.com/flutter/flutter/pull/29469) fix asset reloading (cla: yes, tool)

[29474](https://github.com/flutter/flutter/pull/29474) Let CupertinoTextField's clear button also call onChanged (cla: yes, f: cupertino, framework, waiting for tree to go green)

[29494](https://github.com/flutter/flutter/pull/29494) initial work on coverage generating script for tool (cla: yes, tool)

[29499](https://github.com/flutter/flutter/pull/29499) Set custom flutter_assets by add FLTAssetsPath to AppFrameworkInfo.plist (cla: yes, tool, waiting for tree to go green)

[29528](https://github.com/flutter/flutter/pull/29528) Ensure that assumed formatting of properties file is correct (cla: yes, tool)

[29532](https://github.com/flutter/flutter/pull/29532) Reland composite physical layers on all platforms (cla: yes, customer: dream (g3), customer: fuchsia, framework)

[29540](https://github.com/flutter/flutter/pull/29540) Improve Navigator documentation (cla: yes)

[29563](https://github.com/flutter/flutter/pull/29563) Avoid flickering while dragging to select text (cla: yes, f: material design, framework)

[29564](https://github.com/flutter/flutter/pull/29564) Update progress indicator API docs (cla: yes, f: material design, framework)

[29566](https://github.com/flutter/flutter/pull/29566) Manually roll engine to 5088735e5f (a: tests, cla: yes, framework)

[29568](https://github.com/flutter/flutter/pull/29568) make build runner configurable (cla: yes, team)

[29572](https://github.com/flutter/flutter/pull/29572) DropdownButton Icon customizability (cla: yes, f: material design, framework)

[29604](https://github.com/flutter/flutter/pull/29604) added friendlier error for invalid AndroidManifest.xml (cla: yes, tool, ▣ platform-android)

[29619](https://github.com/flutter/flutter/pull/29619) make literals const for @immutable constructors (cla: yes, team)

[29621](https://github.com/flutter/flutter/pull/29621) Update PULL_REQUEST_TEMPLATE.md (cla: yes, team)

[29623](https://github.com/flutter/flutter/pull/29623) Revert "Reland composite physical layers on all platforms" (cla: yes, framework)

[29625](https://github.com/flutter/flutter/pull/29625) Fix typo in flutter_tools (cla: yes, tool)

[29627](https://github.com/flutter/flutter/pull/29627) Manual engine roll for 2019-03-19 (cla: yes)

[29630](https://github.com/flutter/flutter/pull/29630) Add heart shapes to CupertinoIcons (cla: yes, f: cupertino, framework)

[29632](https://github.com/flutter/flutter/pull/29632) Enable platform views for Flutter Gallery on iOS. (cla: yes, team, team: gallery)

[29633](https://github.com/flutter/flutter/pull/29633) Download secondary SDK (cla: yes, tool)

[29638](https://github.com/flutter/flutter/pull/29638) Fix transition to stock details (cla: yes, team, team: gallery)

[29641](https://github.com/flutter/flutter/pull/29641) Fix links on homepage of API docs (cla: yes, d: api docs, framework)

[29644](https://github.com/flutter/flutter/pull/29644) Cupertino localization step 3: in-place move some material tools around to make room for cupertino (cla: yes, f: cupertino, f: material design, framework)

[29650](https://github.com/flutter/flutter/pull/29650) Cupertino localization step 4: let generated date localization combine material and cupertino locales (cla: yes, f: cupertino, f: material design, framework)

[29654](https://github.com/flutter/flutter/pull/29654) Include brackets on OutlineButton doc (cla: yes, d: api docs, f: material design, framework)

[29669](https://github.com/flutter/flutter/pull/29669) Speed up CI via mojave-flutter image (a: tests, cla: yes, team)

[29677](https://github.com/flutter/flutter/pull/29677) Fix calculation of hero rectTween when Navigator isn't fullscreen (a: animation, cla: yes, customer: solaris, framework, waiting for tree to go green)

[29684](https://github.com/flutter/flutter/pull/29684) Revert last 2 engine rolls. (cla: yes)

[29693](https://github.com/flutter/flutter/pull/29693) Use source list from the compiler to track invalidated files for hot reload. (cla: yes, t: hot reload, tool)

[29697](https://github.com/flutter/flutter/pull/29697) Embedding new diagrams for API Docs (cla: yes, d: api docs, d: examples, framework)

[29699](https://github.com/flutter/flutter/pull/29699) Fix more tests for ANSI terminals (cla: yes, tool)

[29701](https://github.com/flutter/flutter/pull/29701) Reland composite physical layers for all platforms (cla: yes, framework)

[29708](https://github.com/flutter/flutter/pull/29708) Cupertino localization step 5: add french arb as translated example (cla: yes, f: cupertino, framework)

[29721](https://github.com/flutter/flutter/pull/29721) Use Dart version in script cache check (cla: yes, tool)

[29747](https://github.com/flutter/flutter/pull/29747) Allowing adding/updating packages during hot reload (cla: yes)

[29754](https://github.com/flutter/flutter/pull/29754) Revert "Enable platform views for Flutter Gallery on iOS." (cla: yes)

[29758](https://github.com/flutter/flutter/pull/29758) Linking Higher & Lower Class Docs (cla: yes, d: api docs, framework)

[29760](https://github.com/flutter/flutter/pull/29760) some formatting of map, parameters and spaces (cla: yes, framework, team)

[29764](https://github.com/flutter/flutter/pull/29764) update fuchsia-attach to configure dev_finder location (cla: yes, tool)

[29767](https://github.com/flutter/flutter/pull/29767) Cupertino localization step 6: add a GlobalCupertinoLocalizations base class with date time formatting (cla: yes, f: cupertino)

[29768](https://github.com/flutter/flutter/pull/29768) Directly depend on frontend_server tool in fuchsia_attach (cla: yes, tool)

[29769](https://github.com/flutter/flutter/pull/29769) Add support for text selection via mouse to Cupertino text fields (cla: yes, f: cupertino, framework)

[29771](https://github.com/flutter/flutter/pull/29771) Set Max Height for ListTile trailing and leading widgets (cla: yes, f: material design, framework)

[29779](https://github.com/flutter/flutter/pull/29779) Removes unnecessary "new" in documentation (cla: yes)

[29780](https://github.com/flutter/flutter/pull/29780) Revert "Update upgrade to rebase and stash local changes." (cla: yes)

[29783](https://github.com/flutter/flutter/pull/29783) Fix cache location, artifacts, and re-enable dart2js test (cla: yes, tool)

[29785](https://github.com/flutter/flutter/pull/29785) Lazy cache 4: A New Hope (cla: yes, tool)

[29786](https://github.com/flutter/flutter/pull/29786) Update upgrade to stash local changes and reset off of hotfix branches (cla: yes, tool)

[29811](https://github.com/flutter/flutter/pull/29811) TextField Validator Height Docs (cla: yes, f: material design, framework)

[29817](https://github.com/flutter/flutter/pull/29817) roll engine to 5f8ae420c1ac61bbbb26e61251d129c879fc788d (cla: yes)

[29818](https://github.com/flutter/flutter/pull/29818) dont fail build if codegen fails (cla: yes, tool)

[29821](https://github.com/flutter/flutter/pull/29821) Cupertino localization step 1.5: fix a resource mismatch in cupertino_en.arb (cla: yes, f: cupertino, framework)

[29822](https://github.com/flutter/flutter/pull/29822) Cupertino localization step 7: modularize material specific things out of gen_localizations.dart (cla: yes, f: cupertino, framework)

[29824](https://github.com/flutter/flutter/pull/29824) Cupertino localization step 8: create a gen_cupertino_localizations and generate one for cupertino english and french (cla: yes, f: cupertino, framework)

[29860](https://github.com/flutter/flutter/pull/29860) Move binarySearch to foundation. (cla: yes, framework)

[29861](https://github.com/flutter/flutter/pull/29861) Wrap Timeline calls in assert for material/about.dart (cla: yes)

[29883](https://github.com/flutter/flutter/pull/29883) Watch wildcard directories in addition to asset bundle (cla: yes, tool)

[29885](https://github.com/flutter/flutter/pull/29885) ensure packages file is updated when using build_runner (cla: yes, tool)

[29908](https://github.com/flutter/flutter/pull/29908) Update Twitter handle @flutterio -> @FlutterDev (cla: yes, team, team: gallery)

[29928](https://github.com/flutter/flutter/pull/29928) Limit the semantic nodes ID range to 2^16 (cla: yes, framework)

[29929](https://github.com/flutter/flutter/pull/29929) Remove tranparent paint hack from BackdropFilter (cla: yes, framework)

[29938](https://github.com/flutter/flutter/pull/29938) Pass FLUTTER_TOOL_ARGS to snapshot command. (cla: yes, tool)

[29942](https://github.com/flutter/flutter/pull/29942) [fuchsia] Fix flutter_tool BUILD.gn deps (cla: yes, tool)

[29943](https://github.com/flutter/flutter/pull/29943) Remove unwanted gap between navigation bar and safe area's child (cla: yes, f: cupertino, framework)

[29946](https://github.com/flutter/flutter/pull/29946) Let CupertinoPageScaffold have tap status bar to scroll to top (cla: yes, f: cupertino)

[29980](https://github.com/flutter/flutter/pull/29980) Fix issue with account drawer header arrow rotating when setState is called (cla: yes, f: material design)

[29985](https://github.com/flutter/flutter/pull/29985) Revert "Lazy cache 4" (cla: yes)

[29986](https://github.com/flutter/flutter/pull/29986) Lazy cache 5: The Empire Strikes Back (cla: yes, tool)

[29987](https://github.com/flutter/flutter/pull/29987) update CupertinoSwitch documentation (cla: yes, d: api docs, f: cupertino, framework)

[29989](https://github.com/flutter/flutter/pull/29989) Avoid overwriting task result for non-leak checkers (a: tests, cla: yes, team, tool)

[29993](https://github.com/flutter/flutter/pull/29993) Adds the keyboard mapping for Linux (a: desktop, cla: yes, framework)

[29998](https://github.com/flutter/flutter/pull/29998) Fix edge cases of PointerEventConverter (cla: yes, framework, waiting for tree to go green)

[30019](https://github.com/flutter/flutter/pull/30019) Update to latest matcher (cla: yes, team)

[30032](https://github.com/flutter/flutter/pull/30032) Introduce --report-timings flag for flutter build aot command. (cla: yes, tool)

[30040](https://github.com/flutter/flutter/pull/30040) Implement focus traversal for desktop platforms, shoehorn edition. (a: desktop, cla: yes, framework, severe: API break)

[30048](https://github.com/flutter/flutter/pull/30048) Document that Hero needs to be present on destination page's zero frame (cla: yes, d: api docs, f: material design, framework)

[30053](https://github.com/flutter/flutter/pull/30053) Make timeout durations configurable (cla: yes, tool)

[30055](https://github.com/flutter/flutter/pull/30055) Change -c to --enable-asserts (cla: yes)

[30058](https://github.com/flutter/flutter/pull/30058) Draggable Scrollable sheet (cla: yes, framework)

[30059](https://github.com/flutter/flutter/pull/30059) Added link to Hero animation docs from Hero docs (cla: yes, d: api docs, f: material design, framework)

[30071](https://github.com/flutter/flutter/pull/30071) Move spinner `_defaultSlowWarning` message to a new line (cla: yes, tool)

[30075](https://github.com/flutter/flutter/pull/30075) Ensure that flutter run/drive/test/update_packages only downloads required artifacts (cla: yes, tool)

[30078](https://github.com/flutter/flutter/pull/30078) Add more test coverage to image handling (cla: yes, framework)

[30082](https://github.com/flutter/flutter/pull/30082) skip .dart_tool folders when running update-packages (cla: yes)

[30115](https://github.com/flutter/flutter/pull/30115) Forward missing pub commands (cla: yes, tool)

[30123](https://github.com/flutter/flutter/pull/30123) Fix OutlineInputBorder crash (cla: yes, f: material design, framework)

[30129](https://github.com/flutter/flutter/pull/30129) Fix refresh control in the gallery demo, update comments  (cla: yes, f: cupertino, framework)

[30139](https://github.com/flutter/flutter/pull/30139) Intercept errors thrown by synchronous Completers in image resolution. (cla: yes)

[30141](https://github.com/flutter/flutter/pull/30141) Fix a misuse of matchesGoldenFile() in the physical_model_test. (cla: yes)

[30145](https://github.com/flutter/flutter/pull/30145) Error message for setting shaderWarmUp too late (cla: yes)

[30153](https://github.com/flutter/flutter/pull/30153) Allow disabling experimental commands, devices on stable branch (cla: yes, tool)

[30160](https://github.com/flutter/flutter/pull/30160) Cupertino localization 1.9: add needed singular resource for cupertino_en.arb (cla: yes, f: cupertino, framework)

[30194](https://github.com/flutter/flutter/pull/30194) Change order of studies in flutter_gallery (cla: yes)

[30195](https://github.com/flutter/flutter/pull/30195) V1.4.5 hotfixes again (cla: yes)

[30198](https://github.com/flutter/flutter/pull/30198) roll engine to 82765aa77db9621dfbc50801ee2709aa0a00e04d (cla: yes)

[30201](https://github.com/flutter/flutter/pull/30201) update sample code analyzer regexp & test case (cla: yes, d: api docs, team, tool)

[30204](https://github.com/flutter/flutter/pull/30204) disable jit snapshot (cla: yes)

[30205](https://github.com/flutter/flutter/pull/30205) Add missing test case and handle wildcard removal (cla: yes)

[30206](https://github.com/flutter/flutter/pull/30206) Made the showMenu() position parameter required  (cla: yes)

[30212](https://github.com/flutter/flutter/pull/30212) Added assert to prevent complete ListTile trailing/leading horizontal expansion (cla: yes, f: material design, framework)

[30215](https://github.com/flutter/flutter/pull/30215) Check for invalid elevations (cla: yes, customer: dream (g3), customer: fuchsia, framework, severe: customer critical, ○ platform-fuchsia)

[30216](https://github.com/flutter/flutter/pull/30216) make sure flutter test asks for cache upgrades (cla: yes)

[30218](https://github.com/flutter/flutter/pull/30218) [fuchsia_tester] Plumb through the location of icudtl (cla: yes, tool)

[30219](https://github.com/flutter/flutter/pull/30219) Added helpful Material assert message (cla: yes, f: material design, framework)

[30222](https://github.com/flutter/flutter/pull/30222) Add coverage benchmark (cla: yes)

[30227](https://github.com/flutter/flutter/pull/30227) Simplify logic of TapGestureRecognizer (cla: yes, framework)

[30228](https://github.com/flutter/flutter/pull/30228) Make heroes fly on pushReplacement (cla: yes, f: routes, framework)

[30232](https://github.com/flutter/flutter/pull/30232) Revert "Ensure that flutter run/drive/test/update_packages only downloads required artifacts" (cla: yes)

[30235](https://github.com/flutter/flutter/pull/30235) Warn on uncomitted changes (cla: yes, tool)

[30254](https://github.com/flutter/flutter/pull/30254) Reland: Ensure that flutter run/drive/test/update_packages only downloads required artifacts  (cla: yes, tool)

[30275](https://github.com/flutter/flutter/pull/30275) Implement compute for async function (#16265) (cla: yes, framework)

[30276](https://github.com/flutter/flutter/pull/30276) Random trivial fixes in the animation packages (a: animation, cla: yes, framework, waiting for tree to go green)

[30304](https://github.com/flutter/flutter/pull/30304) no need .toList() before .join() (cla: yes, framework)

[30305](https://github.com/flutter/flutter/pull/30305) shorter nullable list duplications (cla: yes, framework, waiting for tree to go green)

[30327](https://github.com/flutter/flutter/pull/30327) Add "feature request" issue template (cla: yes, team)

[30339](https://github.com/flutter/flutter/pull/30339) Add buttons to gestures (a: desktop, cla: yes, framework)

[30343](https://github.com/flutter/flutter/pull/30343) ExpansionPanelList and ExpansionPanelList.radio documentation (cla: yes, d: api docs, f: material design, framework)

[30346](https://github.com/flutter/flutter/pull/30346) Make sure _handleAppFrame is only registered once per frame (cla: yes, framework)

[30348](https://github.com/flutter/flutter/pull/30348) RaisedButton Sample Code Update for Diagrams (cla: yes, d: api docs, d: examples, framework)

[30353](https://github.com/flutter/flutter/pull/30353) Fix minor typo (cla: yes, f: material design, framework)

[30390](https://github.com/flutter/flutter/pull/30390) [Material] Update slider and slider theme with new sizes, shapes, and color mappings (cla: yes, f: material design, framework)

[30398](https://github.com/flutter/flutter/pull/30398) Embedding new raised button diagram. (cla: yes, d: api docs, d: examples, framework, waiting for tree to go green)

[30414](https://github.com/flutter/flutter/pull/30414) Remove pressure customization from some pointer events (cla: yes, framework, severe: API break)

[30415](https://github.com/flutter/flutter/pull/30415) Add 29 Widget of the Week videos (cla: yes, d: api docs, framework)

[30422](https://github.com/flutter/flutter/pull/30422) Commit a navigator.pop as soon as the back swipe is lifted (cla: yes, framework)

[30428](https://github.com/flutter/flutter/pull/30428) Update repair command for Arch Linux (cla: yes, tool)

[30451](https://github.com/flutter/flutter/pull/30451) Bump dartdocs to 0.28.3 (cla: yes, d: api docs, framework)

[30452](https://github.com/flutter/flutter/pull/30452) Moar Videos (cla: yes, d: api docs, framework)

[30453](https://github.com/flutter/flutter/pull/30453) Updating sample code for BottomNavigationBar class for diagram. (cla: yes, d: api docs, d: examples, framework, waiting for tree to go green)

[30455](https://github.com/flutter/flutter/pull/30455) Prevent vertical scroll in shrine by ensuring card size fits the screen (cla: yes, f: material design, framework, team, team: gallery, waiting for tree to go green)

[30456](https://github.com/flutter/flutter/pull/30456) make shellcheck (linter) changes to bin/flutter bash script (cla: yes, tool)

[30457](https://github.com/flutter/flutter/pull/30457) Touching the screen adds `0x01` to buttons (cla: yes, framework)

[30458](https://github.com/flutter/flutter/pull/30458) [fuchsia] Fix isolate filter (cla: yes, customer: fuchsia, tool)

[30460](https://github.com/flutter/flutter/pull/30460) Fix gallery API doc URL launcher (cla: yes, team, team: gallery)

[30461](https://github.com/flutter/flutter/pull/30461) Be more explicit when ValueNotifier notifies (cla: yes, d: api docs, framework, waiting for tree to go green)

[30463](https://github.com/flutter/flutter/pull/30463) Revert "Error message for setting shaderWarmUp too late (#30145)" (cla: yes, framework, waiting for tree to go green)

[30468](https://github.com/flutter/flutter/pull/30468) Embedding diagram for BottomNavigationBar. (cla: yes, d: api docs, d: examples, framework)

[30470](https://github.com/flutter/flutter/pull/30470) Fixed Table flex column layout error #30437 (cla: yes, framework)

[30475](https://github.com/flutter/flutter/pull/30475) Trackpad mode crash fix (cla: yes, f: material design, framework, ⌺‬ platform-ios)

[30497](https://github.com/flutter/flutter/pull/30497) Add confirmDismiss example to flutter_gallery (cla: yes, f: material design, team: gallery)

[30513](https://github.com/flutter/flutter/pull/30513) Fix issue 21640: Assertion Error : '_listenerAttached': is not true (cla: yes, framework)

[30521](https://github.com/flutter/flutter/pull/30521) Provide a default IconTheme in CupertinoTheme (cla: yes, f: cupertino, framework)

[30525](https://github.com/flutter/flutter/pull/30525) Fix cursor outside of input width (cla: yes, f: material design, framework)

[30527](https://github.com/flutter/flutter/pull/30527) Cupertino localization step 11: add more translation clarifications in the instructions (cla: yes, f: cupertino, framework)

[30530](https://github.com/flutter/flutter/pull/30530) Let docker image install fastlane too for Linux (cla: yes)

[30531](https://github.com/flutter/flutter/pull/30531) Correct MaterialButton disabledColor (cla: yes)

[30535](https://github.com/flutter/flutter/pull/30535) Correctly synthesise event buttons (cla: yes, waiting for tree to go green)

[30537](https://github.com/flutter/flutter/pull/30537) Embedded images and added variations to ListTile sample code (cla: yes, d: api docs, f: material design, framework)

[30562](https://github.com/flutter/flutter/pull/30562) Replace flutter.io with flutter.dev (a: first hour, a: quality, cla: yes)

[30563](https://github.com/flutter/flutter/pull/30563) Fixed a typo in the Expanded API doc (cla: yes, d: api docs, framework)

[30570](https://github.com/flutter/flutter/pull/30570) Bump dartdocs to 0.28.3+1 (cla: yes)

[30572](https://github.com/flutter/flutter/pull/30572) [Material] Adaptive Slider constructor (cla: yes, f: material design, framework)

[30578](https://github.com/flutter/flutter/pull/30578) Mark ios-deploy version 2.0.0 as bad (cla: yes, tool)

[30579](https://github.com/flutter/flutter/pull/30579) PointerDownEvent and PointerMoveEvent default `buttons` to 1 (a: desktop, cla: yes, framework, severe: API break)

[30594](https://github.com/flutter/flutter/pull/30594) Update README.md (a: first hour, a: quality, cla: yes)

[30612](https://github.com/flutter/flutter/pull/30612) Added required parameters to FlexibleSpaceBarSettings (cla: yes, f: material design, framework)

[30626](https://github.com/flutter/flutter/pull/30626) Add sample for ValueListenable (cla: yes, d: api docs, framework)

[30640](https://github.com/flutter/flutter/pull/30640) Add `const Border.uniformSide()` (cla: yes, framework)

[30643](https://github.com/flutter/flutter/pull/30643) Add Form.onSaved (a: desktop, cla: yes, framework)

[30644](https://github.com/flutter/flutter/pull/30644) Make FormField._validate() return void (cla: yes, framework)

[30645](https://github.com/flutter/flutter/pull/30645) Add docs to FormFieldValidator (cla: yes, framework)

[30648](https://github.com/flutter/flutter/pull/30648) Allow downloading of desktop embedding artifacts (a: desktop, cla: yes, tool)

[30667](https://github.com/flutter/flutter/pull/30667) Fix additional @mustCallSuper indirect overrides and mixins (cla: yes, framework)

[30746](https://github.com/flutter/flutter/pull/30746) Baseline Aligned Row (cla: yes, f: material design, framework)

[30747](https://github.com/flutter/flutter/pull/30747) Print warning if flutter drive is run in debug (a: tests, cla: yes, t: flutter driver)

[30754](https://github.com/flutter/flutter/pull/30754) [Material] Fix showDialog crasher caused by old contexts (cla: yes, f: material design, framework)

[30755](https://github.com/flutter/flutter/pull/30755) Register Gradle wrapper as universal artifact (cla: yes)

[30760](https://github.com/flutter/flutter/pull/30760) fix cast NPE in invokeListMethod and invokeMapMethod (cla: yes, framework)

[30767](https://github.com/flutter/flutter/pull/30767) Mark cubic_bezier_perf__timeline_summary nonflaky (cla: yes)

[30792](https://github.com/flutter/flutter/pull/30792) Rename Border.uniform() -> Border.fromSide() (cla: yes, framework)

[30793](https://github.com/flutter/flutter/pull/30793) Revert "Add Form.onSaved" (cla: yes, f: material design, framework)

[30796](https://github.com/flutter/flutter/pull/30796) Unbounded TextField width error (cla: yes, f: material design, framework)

[30800](https://github.com/flutter/flutter/pull/30800) Update ListTile sample snippets to use Material Scaffold Template (cla: yes, d: api docs, f: material design, framework)

[30805](https://github.com/flutter/flutter/pull/30805) Update ExpansionPanelList Samples with Scaffold Template (cla: yes, d: api docs, f: material design, framework)

[30809](https://github.com/flutter/flutter/pull/30809)  Fix issue 23527: Exception: RenderViewport exceeded its maximum numb… (cla: yes, framework)

[30811](https://github.com/flutter/flutter/pull/30811) Make coverage, like, really fast (cla: yes, tool)

[30814](https://github.com/flutter/flutter/pull/30814) Fix StatefulWidget and StatelessWidget Sample Documentation (cla: yes, d: api docs, framework)

[30815](https://github.com/flutter/flutter/pull/30815) Make CupertinoNavigationBarBackButton correctly return an assert error (cla: yes, f: cupertino)

[30818](https://github.com/flutter/flutter/pull/30818) New flag to `flutter drive` to skip installing fresh app on device (cla: yes, tool)

[30828](https://github.com/flutter/flutter/pull/30828) add golden tests for CupertinoDatePicker (cla: yes, f: cupertino, f: date/time picker, framework)

[30829](https://github.com/flutter/flutter/pull/30829) Keep hover annotation layers in sync with the mouse detector. (a: desktop, cla: yes, framework)

[30832](https://github.com/flutter/flutter/pull/30832) Bump Android build tools to 28.0.3 in Dockerfile (cla: yes, team)

[30837](https://github.com/flutter/flutter/pull/30837) Add semanticsLabel parameter to TextSpan (cla: yes)

[30857](https://github.com/flutter/flutter/pull/30857) Added support for authentication codes for the VM service. (a: tests, cla: yes, tool)

[30862](https://github.com/flutter/flutter/pull/30862) CupertinoDatePicker initialDateTime accounts for minuteInterval  (cla: yes, f: cupertino, framework)

[30867](https://github.com/flutter/flutter/pull/30867) Add toggle for debugProfileWidgetBuilds (cla: yes, tool)

[30871](https://github.com/flutter/flutter/pull/30871) Update the upload key which seems to have trouble for some reason (a: tests, cla: yes, team)

[30873](https://github.com/flutter/flutter/pull/30873) Revert "Remove pressure customization from some pointer events" (cla: yes)

[30876](https://github.com/flutter/flutter/pull/30876) Simplify toImage future handling (cla: yes, framework)

[30880](https://github.com/flutter/flutter/pull/30880) Let `sliver.dart` `_createErrorWidget` work with other Widgets (cla: yes, framework)

[30883](https://github.com/flutter/flutter/pull/30883) Fix iTunes Transporter quirk (cla: yes)

[30884](https://github.com/flutter/flutter/pull/30884) [Material] Update TabController to support dynamic Tabs (cla: yes, f: material design, framework)

[30886](https://github.com/flutter/flutter/pull/30886) Allow mouse hover to only respond to some mouse events but not all. (cla: yes)

[30887](https://github.com/flutter/flutter/pull/30887) Add more dialog doc cross-reference (cla: yes, d: api docs)

[30898](https://github.com/flutter/flutter/pull/30898) Check that ErrorWidget.builder is not modified after test (a: tests, cla: yes, framework, waiting for tree to go green)

[30919](https://github.com/flutter/flutter/pull/30919) Manual engine roll with disabled service authentication codes (cla: yes)

[30921](https://github.com/flutter/flutter/pull/30921) Use identical instead of '==' in a constant expression. (cla: yes)

[30930](https://github.com/flutter/flutter/pull/30930) Revert "Manual engine roll with disabled service authentication codes" (cla: yes)

[30932](https://github.com/flutter/flutter/pull/30932) 2d transforms UX improvements (cla: yes, framework, team: gallery)

[30937](https://github.com/flutter/flutter/pull/30937) Backport fixes into v1.4.9 (cla: yes, team)

[30938](https://github.com/flutter/flutter/pull/30938) Update keycodes, fix a comment. (a: desktop, cla: yes, framework)

[30942](https://github.com/flutter/flutter/pull/30942) rectMoreOrLess equals, prep for 64bit rects (a: tests, cla: yes, f: material design, framework)

[30946](https://github.com/flutter/flutter/pull/30946) Add some more cupertino icons (cla: yes, f: cupertino, framework)

[30985](https://github.com/flutter/flutter/pull/30985) Add rrect contains microbenchmark (a: tests, cla: yes, severe: performance, waiting for tree to go green)

[30990](https://github.com/flutter/flutter/pull/30990) Allow profile widget builds in profile mode (cla: yes, severe: performance, team)

[30991](https://github.com/flutter/flutter/pull/30991) Use full height of the glyph for caret height on Android (a: fidelity, a: text input, a: typography, cla: yes, severe: API break)

[30995](https://github.com/flutter/flutter/pull/30995) revert last 2 engine rolls (cla: yes)

[30997](https://github.com/flutter/flutter/pull/30997) Fix the warning test by checking stderr (cla: yes)

[30998](https://github.com/flutter/flutter/pull/30998) Revert "revert last 2 engine rolls" (cla: yes)

[31000](https://github.com/flutter/flutter/pull/31000) Fix bugs in contrast guideline and improve heuristic (cla: yes)

[31005](https://github.com/flutter/flutter/pull/31005) [scenic] Remove dead view_manager ref (cla: yes, customer: fuchsia, team: gallery, ○ platform-fuchsia)

[31063](https://github.com/flutter/flutter/pull/31063) Download and handle product version of flutter patched sdk (cla: yes, tool)

[31064](https://github.com/flutter/flutter/pull/31064) Add sorting to flutter version command (cla: yes, tool)

[31073](https://github.com/flutter/flutter/pull/31073) Fuchsia step 1: add SDK version file and artifact download (cla: yes, tool)

[31074](https://github.com/flutter/flutter/pull/31074) make flutterProject option of CoverageCollector optional (cla: yes, tool)

[31088](https://github.com/flutter/flutter/pull/31088) Text field scroll physics (cla: yes, f: cupertino, f: material design, framework)

[31092](https://github.com/flutter/flutter/pull/31092) Add null checks to coverage collection (cla: yes)

[31093](https://github.com/flutter/flutter/pull/31093) Make the matchesGoldenFile docs link to an explanation of how to create golden image files (cla: yes, framework)

[31097](https://github.com/flutter/flutter/pull/31097) Fix text field selection toolbar under Opacity (cla: yes, framework)

[31109](https://github.com/flutter/flutter/pull/31109) Clarify various CupertinoTabView docs (cla: yes, f: cupertino, framework)

[31148](https://github.com/flutter/flutter/pull/31148) Bump dartdoc to 0.28.3+2 (cla: yes)

[31159](https://github.com/flutter/flutter/pull/31159) Revert "Use full height of the glyph for caret height on Android" (cla: yes, framework)

[31171](https://github.com/flutter/flutter/pull/31171) Allow disabling all fingerprint caches via environment variable (cla: yes, tool)

[31178](https://github.com/flutter/flutter/pull/31178) Add breadcrumb to docs (cla: yes)

[31205](https://github.com/flutter/flutter/pull/31205) Add desktop projects and build commands (experimental) (a: desktop, cla: yes, tool)

[31207](https://github.com/flutter/flutter/pull/31207) fix issue 12999: Make assets available during tests (cla: yes, framework, tool)

[31210](https://github.com/flutter/flutter/pull/31210) Use full height of the glyph for caret height on Android v2 (a: text input, cla: yes, framework)

[31216](https://github.com/flutter/flutter/pull/31216) Disable macOS integration tests (cla: yes)

[31218](https://github.com/flutter/flutter/pull/31218) Add run capability for macOS target (a: desktop, cla: yes, ⌘‬ platform-mac)

[31228](https://github.com/flutter/flutter/pull/31228) Fix ExpansionPanelList Duplicate Global Keys Exception (cla: yes, f: material design, framework, severe: crash)

[31229](https://github.com/flutter/flutter/pull/31229) Add flutter run support for linux and windows (a: desktop, cla: yes, tool)

[31262](https://github.com/flutter/flutter/pull/31262) Add track-widget-creation flag to attach command (cla: yes)

[31267](https://github.com/flutter/flutter/pull/31267) remove the unused hintMessage and hintId fields from the reload results (cla: yes)

[31273](https://github.com/flutter/flutter/pull/31273) add daemon.log to the daemon spec (cla: yes)

[31275](https://github.com/flutter/flutter/pull/31275) Update SnackBar to allow for support of the new style from Material spec (cla: yes, f: material design, framework)

[31277](https://github.com/flutter/flutter/pull/31277) pass track widget creation flag through to build script (a: desktop, cla: yes, tool)

[31278](https://github.com/flutter/flutter/pull/31278) add --force flag to precache (cla: yes)

[31279](https://github.com/flutter/flutter/pull/31279) Add flutter attach documentation (cla: yes)

[31282](https://github.com/flutter/flutter/pull/31282) Stop precaching the artifacts for dynamic mode. (cla: yes, tool)

[31283](https://github.com/flutter/flutter/pull/31283) Add desktop workflows to doctor (a: desktop, cla: yes, tool)

[31291](https://github.com/flutter/flutter/pull/31291) Add some docs to StatefulBuilder (cla: yes, framework)

[31294](https://github.com/flutter/flutter/pull/31294) Improve Radio Documentation with Example (cla: yes, d: api docs, f: material design, framework)

[31295](https://github.com/flutter/flutter/pull/31295) Improve ThemeData.accentColor connection to secondary color (cla: yes, d: api docs, f: material design, framework)

[31310](https://github.com/flutter/flutter/pull/31310) Updated flutter_driver to support auth codes (cla: yes)

[31315](https://github.com/flutter/flutter/pull/31315) Fixed failing tests caused by introduction of authentication codes (cla: yes)

[31316](https://github.com/flutter/flutter/pull/31316) Add InkWell docs on transitions and ink splash clipping (cla: yes, d: api docs, f: material design, framework)

[31321](https://github.com/flutter/flutter/pull/31321) Fixed flutter_attach_test not respecting authentication codes (cla: yes)

[31326](https://github.com/flutter/flutter/pull/31326) Add more shuffle cupertino icons (cla: yes, f: cupertino, framework)

[31329](https://github.com/flutter/flutter/pull/31329) Add Xcode build script for macOS target (a: desktop, cla: yes, tool, ⌘‬ platform-mac)

[31332](https://github.com/flutter/flutter/pull/31332) iOS selection handles are invisible (cla: yes, framework, ⌺‬ platform-ios)

[31339](https://github.com/flutter/flutter/pull/31339) Revert "[Material] Update slider and slider theme with new sizes, shapes, and color mappings" (cla: yes)

[31342](https://github.com/flutter/flutter/pull/31342) check if project exists before regenerating platform specific tooling (cla: yes, tool)

[31359](https://github.com/flutter/flutter/pull/31359) Remove support for building dynamic patches on Android (cla: yes, tool)

[31395](https://github.com/flutter/flutter/pull/31395) Roll engine ca31a7c57bad..206cab6e7013 (11 commits) (cla: yes)

[31399](https://github.com/flutter/flutter/pull/31399) add ignorable track-widget-creation flag to build aot (cla: yes, tool)

[31400](https://github.com/flutter/flutter/pull/31400) add printError messages and tool exit to android device (cla: yes, tool)

[31404](https://github.com/flutter/flutter/pull/31404) throw toolExit instead of rethrowing on filesystem exceptions (cla: yes, tool)

[31406](https://github.com/flutter/flutter/pull/31406) if there is no .ios or ios sub-project, don't attempt building for iOS (cla: yes, tool)

[31419](https://github.com/flutter/flutter/pull/31419) Add a note about events coming from the server (cla: yes, tool)

[31420](https://github.com/flutter/flutter/pull/31420) Add more breadcrumb docs to Transformation (cla: yes, framework)

[31421](https://github.com/flutter/flutter/pull/31421) Add Widget of the Week video to SizedBox (cla: yes, framework)

[31434](https://github.com/flutter/flutter/pull/31434) Add more context to flutter create sample (cla: yes)

[31446](https://github.com/flutter/flutter/pull/31446) Allow filtering devices to only those supported by current project (cla: yes, tool)

[31451](https://github.com/flutter/flutter/pull/31451) Set SYMROOT as absolute in Generated.xcconfig for macOS (cla: yes)

[31452](https://github.com/flutter/flutter/pull/31452) Remove engine tests (a: tests, cla: yes, team, waiting for tree to go green)

[31454](https://github.com/flutter/flutter/pull/31454) Improve docs to address flutter/flutter#31202 (cla: yes)

[31456](https://github.com/flutter/flutter/pull/31456) Relax the string matching for path in test (cla: yes)

[31461](https://github.com/flutter/flutter/pull/31461) Revert "Implement focus traversal for desktop platforms, shoehorn edition. (#30040)" (cla: yes)

[31463](https://github.com/flutter/flutter/pull/31463) Disable all Dart fingerprinters (cla: yes)

[31464](https://github.com/flutter/flutter/pull/31464) CupertinoPicker fidelity revision (a: fidelity, cla: yes, f: cupertino, f: date/time picker, framework)

[31486](https://github.com/flutter/flutter/pull/31486) fix precedence issue (cla: yes, team: gallery)

[31491](https://github.com/flutter/flutter/pull/31491) Allow adb stdout to contain the port number without failing (cla: yes, tool, ▣ platform-android)

[31493](https://github.com/flutter/flutter/pull/31493) Keycode generation doc fix (a: desktop, cla: yes, d: api docs, framework)

[31497](https://github.com/flutter/flutter/pull/31497) Revert "Fix 25807: implement move for sliver multibox widget (#29188)" (cla: yes, framework)

[31502](https://github.com/flutter/flutter/pull/31502) Improve Tabs documentation (cla: yes, d: api docs, f: material design, framework)

[31505](https://github.com/flutter/flutter/pull/31505) add desktop artifacts to run/target_platform selectors (cla: yes)

[31515](https://github.com/flutter/flutter/pull/31515) Support local engine and asset sync for macOS (cla: yes, tool)

[31520](https://github.com/flutter/flutter/pull/31520) Don't add empty OpacityLayer to the engine (cla: yes, engine, framework)

[31526](https://github.com/flutter/flutter/pull/31526) replace no-op log reader with real implementation (cla: yes, tool)

[31538](https://github.com/flutter/flutter/pull/31538) Fix typo in docs (cla: yes, f: material design, framework)

[31561](https://github.com/flutter/flutter/pull/31561) Add support for Tooltip hover (cla: yes)

[31562](https://github.com/flutter/flutter/pull/31562) Allow all tests to run with --update-goldens. (cla: yes)

[31564](https://github.com/flutter/flutter/pull/31564) [Material] Update slider and slider theme with new sizes, shapes, and color mappings (2nd attempt) (cla: yes)

[31566](https://github.com/flutter/flutter/pull/31566) TimePicker moves to minute mode after hour selection (cla: yes, f: material design, framework)

[31567](https://github.com/flutter/flutter/pull/31567) Remove need for build/name scripts on Linux desktop (a: desktop, cla: yes)

[31568](https://github.com/flutter/flutter/pull/31568) fix transform assert (cla: yes, framework)

[31569](https://github.com/flutter/flutter/pull/31569) Roll engine to 3e47b4bb39bb4993f03a278ea7b1c11ee6459b06 (cla: yes)

[31578](https://github.com/flutter/flutter/pull/31578) Add support for the Kazakh language (cla: yes)

[31582](https://github.com/flutter/flutter/pull/31582) Issues/31511 (cla: yes)

[31584](https://github.com/flutter/flutter/pull/31584) Capture JSON RPC errors that presently get swallowed (cla: yes)

[31591](https://github.com/flutter/flutter/pull/31591) make sure we exit early if the Runner.xcodeproj file is missing (cla: yes, tool)

[31600](https://github.com/flutter/flutter/pull/31600) Re-enable const (cla: yes, framework, waiting for tree to go green)

[31614](https://github.com/flutter/flutter/pull/31614) [Re-Land] Implement focus traversal for desktop platforms. (cla: yes)

[31616](https://github.com/flutter/flutter/pull/31616) Make FlutterPlatform public so we can start testing/refactoring it (cla: yes)

[31619](https://github.com/flutter/flutter/pull/31619) Fix the documentation for UiKitView#creationParams (cla: yes, framework)

[31621](https://github.com/flutter/flutter/pull/31621) Add check that xcode project configuration is not missing (cla: yes)

[31622](https://github.com/flutter/flutter/pull/31622) refactor context to be implicit-downcast safe (cla: yes)

[31623](https://github.com/flutter/flutter/pull/31623) fix edge swiping and dropping back at starting point (cla: yes, f: cupertino, framework)

[31634](https://github.com/flutter/flutter/pull/31634) Improve canvas example in sample dart ui app (cla: yes, d: api docs, d: examples, framework)

[31638](https://github.com/flutter/flutter/pull/31638) Fix doc link (cla: yes)

[31642](https://github.com/flutter/flutter/pull/31642) Refactor the test compiler into a separate library (cla: yes)

[31687](https://github.com/flutter/flutter/pull/31687) Center iOS caret, remove constant offsets that do not scale (a: text input, cla: yes, framework, ⌺‬ platform-ios)

[31692](https://github.com/flutter/flutter/pull/31692) Revert "Add support for Tooltip hover (#31561)" (cla: yes)

[31693](https://github.com/flutter/flutter/pull/31693) Adds a note to Radio's/RadioListTile's onChange (cla: yes, d: api docs, f: material design, framework)

[31696](https://github.com/flutter/flutter/pull/31696) Attempt to reduce usage of runtimeType (cla: yes, framework)

[31736](https://github.com/flutter/flutter/pull/31736) update packages and unpin build (cla: yes, tool)

[31757](https://github.com/flutter/flutter/pull/31757) Make FlutterProject factories synchronous (cla: yes, tool)

[31759](https://github.com/flutter/flutter/pull/31759) Remove deprecated commands (cla: yes, tool)

[31761](https://github.com/flutter/flutter/pull/31761) Support clipBehavior changes in hot reload (cla: yes, framework)

[31762](https://github.com/flutter/flutter/pull/31762) Remove trailing whitespace from README template (cla: yes)

[31765](https://github.com/flutter/flutter/pull/31765) Initial sketch of tools testbed (cla: yes, tool)

[31771](https://github.com/flutter/flutter/pull/31771) Fix a simple typo (cla: yes)

[31795](https://github.com/flutter/flutter/pull/31795) Revert "update packages and unpin build" (cla: yes)

[31800](https://github.com/flutter/flutter/pull/31800) Revert "Fix text field selection toolbar under Opacity" (cla: yes)

[31801](https://github.com/flutter/flutter/pull/31801) Revert "Add buttons to gestures" (cla: yes)

[31802](https://github.com/flutter/flutter/pull/31802) Reland "Fix text field selection toolbar under Opacity (#31097)" (cla: yes, framework)

[31804](https://github.com/flutter/flutter/pull/31804) only build asset when there is asset declared in pubspec (cla: yes, framework, tool)

[31807](https://github.com/flutter/flutter/pull/31807) Make const available for classes that override AssetBundle (cla: yes, tool)

[31812](https://github.com/flutter/flutter/pull/31812) Fix #31764: Show appropriate error message when fonts pubspec.yaml isn't iterable (cla: yes, tool)

[31815](https://github.com/flutter/flutter/pull/31815) remove assert (cla: yes)

[31819](https://github.com/flutter/flutter/pull/31819) Redo: Add buttons to gestures (a: desktop, cla: yes, framework)

[31832](https://github.com/flutter/flutter/pull/31832) Allow DSS to be dragged when its children do not fill extent (cla: yes, f: scrolling, framework, waiting for tree to go green)

[31835](https://github.com/flutter/flutter/pull/31835) Cherry-pick ADB CrOS fix to beta (cla: yes, tool)

[31860](https://github.com/flutter/flutter/pull/31860) Fix prefer_const_constructors (cla: yes)

[31862](https://github.com/flutter/flutter/pull/31862) iOS selection handles are invisible (#31332) (cla: yes)

[31868](https://github.com/flutter/flutter/pull/31868) Handle notification errors (cla: yes, tool, waiting for tree to go green)

[31871](https://github.com/flutter/flutter/pull/31871) Pick up v1.5.4-hotfix-2 engine for flutter 1.5.4 hotfix branch (cla: yes)

[31874](https://github.com/flutter/flutter/pull/31874) add stderr to log processor for desktop (cla: yes)

[31876](https://github.com/flutter/flutter/pull/31876) Revert "fix edge swiping and dropping back at starting point" (cla: yes)

[31886](https://github.com/flutter/flutter/pull/31886) Revert "Handle notification errors" (cla: yes)


## PRs closed in this release of flutter/engine

From Thu Feb 21 20:22:00 2019 -0800 to Wed May 1 16:56:00 2019 -0700


[7494](https://github.com/flutter/engine/pull/7494) Add engine support for scrollwheel events (cla: yes)

[7776](https://github.com/flutter/engine/pull/7776) Support ContextWrapper when instantiating a FlutterView. (cla: yes)

[7783](https://github.com/flutter/engine/pull/7783) Refactor ios play input sound logic. (cla: yes)

[7803](https://github.com/flutter/engine/pull/7803) [re-land] Use all font managers to discover fonts for strut. (cla: yes)

[7828](https://github.com/flutter/engine/pull/7828) Revert Versions API (cla: yes)

[7851](https://github.com/flutter/engine/pull/7851) Improve path metrics tests and docs (cla: yes)

[7888](https://github.com/flutter/engine/pull/7888) Reland #7777 with proper LICENSE (cla: yes)

[7896](https://github.com/flutter/engine/pull/7896) Android Embedding PR 6: Introduce FlutterView structure with FlutterSurfaceView and FlutterTextureView. (cla: yes)

[7906](https://github.com/flutter/engine/pull/7906) Do not add ghost runs for trailing whitespace if the text is ellipsized (cla: yes)

[7908](https://github.com/flutter/engine/pull/7908) Link dart:* sources into engine for debugger source support (affects: dev experience, affects: engine, cla: yes)

[7911](https://github.com/flutter/engine/pull/7911) Reland "PerformanceOverlayLayer golden test (#7863)" (cla: yes)

[7912](https://github.com/flutter/engine/pull/7912) Android PR 7: Introduce structure of FlutterActivity and FlutterFragment (cla: yes)

[7913](https://github.com/flutter/engine/pull/7913) Revert dart rolls (cla: yes)

[7914](https://github.com/flutter/engine/pull/7914) Allow embedder to specify a vsync waiter. (cla: yes)

[7915](https://github.com/flutter/engine/pull/7915) Embedder API for setting the persistent cache path (cla: yes)

[7916](https://github.com/flutter/engine/pull/7916) Revert "Revert "Revert "Reland PerformanceOverlayLayer golden test (#… (cla: yes)

[7917](https://github.com/flutter/engine/pull/7917) Allow embedders to add events to the timeline. (cla: yes)

[7919](https://github.com/flutter/engine/pull/7919) fix Memory leak when using PlatformView [IOS] #24714 (cla: yes)

[7923](https://github.com/flutter/engine/pull/7923) Move canvas clear after preroll (cla: yes)

[7925](https://github.com/flutter/engine/pull/7925) Make the layout of dynamic patch bundle similar to APK. (cla: yes)

[7926](https://github.com/flutter/engine/pull/7926) Remove unused FML file export.h (cla: yes)

[7927](https://github.com/flutter/engine/pull/7927) Dynamic patching support for native code libraries. (cla: yes)

[7928](https://github.com/flutter/engine/pull/7928) New setting to decide whether we want the engine to load ICU mapping. (cla: yes)

[7929](https://github.com/flutter/engine/pull/7929) Do not clear FlutterJNI state when a FlutterView is detached (cla: yes)

[7937](https://github.com/flutter/engine/pull/7937) fix sendLocales on old android versions (cla: yes)

[7942](https://github.com/flutter/engine/pull/7942) Correct FlutterSemanticsNode member name style (cla: yes)

[7946](https://github.com/flutter/engine/pull/7946) Android Embedding PR 8: Add FlutterEngine attachment/detachment to FlutterView (cla: yes)

[7947](https://github.com/flutter/engine/pull/7947) Android Embedding PR 9: Introduce an AndroidTouchProcessor to convert MotionEvents to Flutter touch data. (cla: yes)

[7953](https://github.com/flutter/engine/pull/7953) libtxt: remove a debug log message in ComputeStrut (cla: yes)

[7954](https://github.com/flutter/engine/pull/7954) Fixed an Android keyboard entry bug that was introduced by the embedding refactor. (#28438) (cla: yes)

[7960](https://github.com/flutter/engine/pull/7960) Android Embedding PR 10: Add system channels to FlutterEngine. (cla: yes)

[7964](https://github.com/flutter/engine/pull/7964) Fix cursor jumping when typing some special characters. (cla: yes)

[7967](https://github.com/flutter/engine/pull/7967) Add api 21 check to LocalizationChannel.java (cla: yes)

[7968](https://github.com/flutter/engine/pull/7968) Switch flutter's dart sdk to full and add dartdevc libraries (cla: yes)

[7972](https://github.com/flutter/engine/pull/7972) Android Embedding PR 11: Add FlutterEngine to FlutterFragment. (cla: yes)

[7973](https://github.com/flutter/engine/pull/7973) Suppress deprecation warning for usage of Configuration.locale (cla: yes)

[7974](https://github.com/flutter/engine/pull/7974) Android Embedding PR 12: Add lifecycle methods to FlutterActivity. (cla: yes)

[7975](https://github.com/flutter/engine/pull/7975) [macos] Add hover support to FLEViewController (cla: yes)

[7978](https://github.com/flutter/engine/pull/7978) Refactor web configuration/ Add dartdevc (cla: yes)

[7979](https://github.com/flutter/engine/pull/7979) Android Embedding PR 13: Integrated text input, keyevent input, and some other channel comms in FlutterView. (cla: yes)

[7982](https://github.com/flutter/engine/pull/7982) Fix deleting text when the last character is some special characters on IOS (cla: yes)

[7985](https://github.com/flutter/engine/pull/7985) Add async events to pipeline flows. (cla: yes)

[7986](https://github.com/flutter/engine/pull/7986) Check for a null pressure range for motion events (cla: yes)

[7988](https://github.com/flutter/engine/pull/7988) Provide batching for semantics updates (cla: yes)

[7990](https://github.com/flutter/engine/pull/7990) Improve performance of Locale.toString (cla: yes)

[7991](https://github.com/flutter/engine/pull/7991) Select MPL instead of LGPL (cla: yes)

[7993](https://github.com/flutter/engine/pull/7993) Fix two typos in embedder.h (cla: yes)

[7997](https://github.com/flutter/engine/pull/7997) Fix spelling errors in dartdocs (cla: yes)

[7999](https://github.com/flutter/engine/pull/7999) Buffer lifecycle in WindowData (cla: yes)

[8000](https://github.com/flutter/engine/pull/8000) Android Embedding PR 14: Almost done with FlutterFragment. (cla: yes)

[8001](https://github.com/flutter/engine/pull/8001) Fix incorrect transformation matrix (cla: yes)

[8005](https://github.com/flutter/engine/pull/8005) A11y callback (cla: yes)

[8006](https://github.com/flutter/engine/pull/8006) Guard against using Android API not defined in API level 16 & 17 (cla: yes)

[8007](https://github.com/flutter/engine/pull/8007) Add overloads for lookup that lets you specify a bundle (cla: yes)

[8008](https://github.com/flutter/engine/pull/8008) Expose decorationThickness to dart:ui (cla: yes)

[8010](https://github.com/flutter/engine/pull/8010) Revert "Buffer lifecycle in WindowData" (cla: yes)

[8011](https://github.com/flutter/engine/pull/8011) Build engine for iOS on presubmit (cla: yes)

[8023](https://github.com/flutter/engine/pull/8023) Start of linting Android embedding (cla: yes)

[8024](https://github.com/flutter/engine/pull/8024) [fuchsia] Fix snapshot BUILD.gn file for Fuchsia roll (cla: yes)

[8026](https://github.com/flutter/engine/pull/8026) [platform_views] Fix duplicated touch event pass down to flutter view from platform view.  (cla: yes)

[8029](https://github.com/flutter/engine/pull/8029) Android Embedding PR15: Add Viewport Metrics to FlutterView (cla: yes)

[8030](https://github.com/flutter/engine/pull/8030) Add missing kHasImplicitScrolling enum value (cla: yes)

[8032](https://github.com/flutter/engine/pull/8032) Re-land "Buffer lifecycle in WindowData" (cla: yes)

[8033](https://github.com/flutter/engine/pull/8033) Add missing values to semantics action enums (cla: yes)

[8034](https://github.com/flutter/engine/pull/8034) Android Embedding PR 16: Add touch support to FlutterView. (cla: yes)

[8036](https://github.com/flutter/engine/pull/8036) add lint script for Android with baseline (cla: yes)

[8041](https://github.com/flutter/engine/pull/8041) [platform_views]remove an unnecessary extra statement. (cla: yes)

[8043](https://github.com/flutter/engine/pull/8043) Minor cleanups to CONTRIBUTING.md (cla: yes)

[8044](https://github.com/flutter/engine/pull/8044) Improve elevation bounds for physical shape layers (cla: yes)

[8045](https://github.com/flutter/engine/pull/8045) Merge only gpu and platform threads for platform views, fix deadlock. (cla: yes)

[8046](https://github.com/flutter/engine/pull/8046) Fix weak pointer use violations in shell and platform view. (cla: yes)

[8047](https://github.com/flutter/engine/pull/8047) Add clang static analysis support to gn wrapper (cla: yes)

[8048](https://github.com/flutter/engine/pull/8048) Guard against NewAPI failures (cla: yes)

[8049](https://github.com/flutter/engine/pull/8049) Add read-only persistent cache (cla: yes)

[8050](https://github.com/flutter/engine/pull/8050) Skip skp files in license check (cla: yes)

[8051](https://github.com/flutter/engine/pull/8051) Used named conditionals for platform specific dependencies and suppress Android and Windows hooks on Mac. (cla: yes)

[8052](https://github.com/flutter/engine/pull/8052) remove extra source files (cla: yes)

[8053](https://github.com/flutter/engine/pull/8053) Remove redundant thread checker in FML. (cla: yes)

[8054](https://github.com/flutter/engine/pull/8054) Correct URL for Cirrus CI build status badge (cla: yes)

[8055](https://github.com/flutter/engine/pull/8055) Adds a platfromViewId to SemanticsNode (cla: yes)

[8056](https://github.com/flutter/engine/pull/8056) Send scroll events from the macOS shell (cla: yes)

[8061](https://github.com/flutter/engine/pull/8061) Android Embedding PR 17: Clarify AccessibilityBridge. (cla: yes)

[8065](https://github.com/flutter/engine/pull/8065) add signal to pointer kinds (cla: yes)

[8066](https://github.com/flutter/engine/pull/8066) Revert "add signal to pointer kinds" (cla: yes)

[8071](https://github.com/flutter/engine/pull/8071) Only build a full Dart SDK when building for the host system (cla: yes)

[8072](https://github.com/flutter/engine/pull/8072) Delay the vsync callback till the frame start time specified by embedder. (cla: yes)

[8073](https://github.com/flutter/engine/pull/8073) Update a11y word forward/back enum names (cla: yes)

[8074](https://github.com/flutter/engine/pull/8074) Add script to help generate PR messages (cla: yes, waiting for tree to go green)

[8077](https://github.com/flutter/engine/pull/8077) Mark const extern (cla: yes)

[8078](https://github.com/flutter/engine/pull/8078) only partial rule revert (cla: yes)

[8079](https://github.com/flutter/engine/pull/8079) Fix text.dart height docs (cla: yes)

[8080](https://github.com/flutter/engine/pull/8080) Only build full sdk on release to speed up bots (cla: yes)

[8084](https://github.com/flutter/engine/pull/8084) Move android_sdk_downloader so I can more easily deprecate it (cla: yes)

[8085](https://github.com/flutter/engine/pull/8085) Remove deprecated libraries from snapshot (cla: yes)

[8087](https://github.com/flutter/engine/pull/8087) Drop android_sdk_downloader in favor of cipd (cla: yes)

[8089](https://github.com/flutter/engine/pull/8089) Allow embedders to post tasks onto the render thread. (cla: yes)

[8090](https://github.com/flutter/engine/pull/8090) Android linter prints to the console by default (cla: yes)

[8093](https://github.com/flutter/engine/pull/8093) Clarify arguments to FlutterEngineOnVsync. (cla: yes)

[8094](https://github.com/flutter/engine/pull/8094) Add support for trace counters with variable arguments and instrument the raster cache. (cla: yes)

[8095](https://github.com/flutter/engine/pull/8095) Integrated AndroidTouchProcessor within the old FlutterView (cla: yes)

[8096](https://github.com/flutter/engine/pull/8096) Log non-kSuccess returns from embedder API calls. (cla: yes)

[8098](https://github.com/flutter/engine/pull/8098) Do not cache gclient sync (cla: yes)

[8099](https://github.com/flutter/engine/pull/8099) Use right stream for Java, on mac try to autoselect Java 1.8 (cla: yes)

[8102](https://github.com/flutter/engine/pull/8102) Fix typo (cla: yes)

[8103](https://github.com/flutter/engine/pull/8103) Guard initialization of touch exploration listener (cla: yes)

[8105](https://github.com/flutter/engine/pull/8105) Support dartdevc, dart2js with shared source files, dartdevc sdk (cla: yes)

[8106](https://github.com/flutter/engine/pull/8106) Fix the Windows build (cla: yes)

[8109](https://github.com/flutter/engine/pull/8109) Android Embedding PR 19: Add accessibility to new FlutterView. (cla: yes)

[8114](https://github.com/flutter/engine/pull/8114) Improve shadow doc in PhysicalShapeLayer (cla: yes)

[8115](https://github.com/flutter/engine/pull/8115) Add Views V2 support for Fuchsia (cla: yes)

[8122](https://github.com/flutter/engine/pull/8122) Revert "Add support for trace counters with variable arguments and instrument the raster cache." (cla: yes)

[8124](https://github.com/flutter/engine/pull/8124) Use final state passed to dart before initialization as the initial lifecycleState. (cla: yes)

[8126](https://github.com/flutter/engine/pull/8126) Bugfix #29203: NPE in getAccessibilityProvider in old FlutterView. (cla: yes)

[8139](https://github.com/flutter/engine/pull/8139) Look up ICU symbols based on the path to libflutter.so as a fallback (cla: yes)

[8140](https://github.com/flutter/engine/pull/8140) Reland PerformanceOverlayLayer golden test (cla: yes)

[8141](https://github.com/flutter/engine/pull/8141) Fix TextStyle decode misalignment (cla: yes)

[8142](https://github.com/flutter/engine/pull/8142) Typo "fast an inline" to "fast and inline" (cla: yes)

[8143](https://github.com/flutter/engine/pull/8143) Fix indexing error in dart:ui TextStyle.toString (cla: yes)

[8145](https://github.com/flutter/engine/pull/8145) Reland "Add support for trace counters with variable arguments and instrument the raster cache." (cla: yes)

[8147](https://github.com/flutter/engine/pull/8147) Add “full-dart-debug” that disabled optimizations in the Dart VM. (cla: yes)

[8148](https://github.com/flutter/engine/pull/8148) Add dump-shader-skp switch to help ShaderWarmUp (cla: yes)

[8149](https://github.com/flutter/engine/pull/8149) Encode scroll motion events in the Android touch processor (cla: yes)

[8150](https://github.com/flutter/engine/pull/8150) Disable build_ios task due to lack of credits. (cla: yes)

[8151](https://github.com/flutter/engine/pull/8151) [Skia] Rollback Skia to 29d5dec9a0783a033b921dc483fb98d565d684f6 (cla: yes)

[8153](https://github.com/flutter/engine/pull/8153) Revert "Disable build_ios task due to lack of credits." (cla: yes)

[8154](https://github.com/flutter/engine/pull/8154) Suppress deprecation warning for use of Build.CPU_ABI (cla: yes)

[8155](https://github.com/flutter/engine/pull/8155) Ensure that typed data is released within SendPlatformMessage scope. (cla: yes)

[8156](https://github.com/flutter/engine/pull/8156) Add a11y support for embedded iOS platform view (cla: yes)

[8157](https://github.com/flutter/engine/pull/8157) Anti-Aliasing for shape layers (cla: yes)

[8159](https://github.com/flutter/engine/pull/8159) Initial import of GLFW Linux shell from FDE (cla: yes)

[8160](https://github.com/flutter/engine/pull/8160) Add a build dependencies script for Linux desktop (cla: yes)

[8166](https://github.com/flutter/engine/pull/8166) Do not pass short-lived buffers as labels to Dart_TimelineEvent (cla: yes)

[8168](https://github.com/flutter/engine/pull/8168) Add an allocator specific check to ensure that strings passed to the timeline are not heap allocated. (cla: yes)

[8170](https://github.com/flutter/engine/pull/8170) Bugfix: Prevent crash when responding to a platform message after FlutterJNI detaches from native. (cla: yes)

[8171](https://github.com/flutter/engine/pull/8171) Add docs for helpful commands to fix format (cla: yes)

[8172](https://github.com/flutter/engine/pull/8172) Add frame and target time metadata to vsync events and connect platform vsync events using flows. (cla: yes)

[8174](https://github.com/flutter/engine/pull/8174) [scenic][SCN-1054] Move back off of SetTranslationRH (cla: yes)

[8175](https://github.com/flutter/engine/pull/8175) Keep overlays_gr_context_ in sync with the overlay surface (cla: yes)

[8180](https://github.com/flutter/engine/pull/8180) Fix log level typo from ERROR to INFO (cla: yes)

[8181](https://github.com/flutter/engine/pull/8181) Fix include of libzx. (cla: yes)

[8182](https://github.com/flutter/engine/pull/8182) Ensure that Picture::RasterizeToImage destroys Dart persistent values on the UI thread (cla: yes)

[8183](https://github.com/flutter/engine/pull/8183) Clip to clip_rect instead of paint bounds (cla: yes)

[8185](https://github.com/flutter/engine/pull/8185) Simplify the fallback waiter and add traces for vsync scheduling overhead. (cla: yes)

[8196](https://github.com/flutter/engine/pull/8196) Add --no-full-dart-sdk option to GN (cla: yes)

[8202](https://github.com/flutter/engine/pull/8202) [platform_view] iOSP platformView composition optimize. (cla: yes, platform-ios)

[8203](https://github.com/flutter/engine/pull/8203) Export FlutterSemanticsUpdateNotification and improve docs (cla: yes)

[8204](https://github.com/flutter/engine/pull/8204) Disable build_ios due to large queue times. (cla: yes)

[8206](https://github.com/flutter/engine/pull/8206) Define the dart_platform_sdk GN variable only on host targets (cla: yes)

[8208](https://github.com/flutter/engine/pull/8208) Plumb a reference of PlatformViewsController and AccessibilityBridge to each other (cla: yes)

[8210](https://github.com/flutter/engine/pull/8210) Correct greater than or equal logic in offset base (cla: yes)

[8214](https://github.com/flutter/engine/pull/8214) libtxt: more accurate tracking of run positioning and width for justified text (cla: yes)

[8217](https://github.com/flutter/engine/pull/8217) Allow exported __const on iOS (cla: yes)

[8218](https://github.com/flutter/engine/pull/8218) [ios] Set contentsScale before we commit CATransaction (cla: yes)

[8219](https://github.com/flutter/engine/pull/8219) Send macOS keyboard data to the engine (cla: yes)

[8221](https://github.com/flutter/engine/pull/8221) Moved io.flutter.embedding.engine.android package to io.flutter.embedding.android (cla: yes)

[8227](https://github.com/flutter/engine/pull/8227) Add the Linux desktop setup script to Dockerfile (cla: yes)

[8229](https://github.com/flutter/engine/pull/8229) Have the AccessibilityBridge attach/detach itself to the (cla: yes)

[8230](https://github.com/flutter/engine/pull/8230) Remove jsoncpp from desktop Linux shell setup (cla: yes)

[8231](https://github.com/flutter/engine/pull/8231) Removed Activity reference from AccessibilityBridge by using a View for insets instead of the Activity (cla: yes)

[8233](https://github.com/flutter/engine/pull/8233) Enable Linux shell build (cla: yes)

[8234](https://github.com/flutter/engine/pull/8234) Use the GPU thread for Android surface on-screen context lifecycle operations (cla: yes)

[8237](https://github.com/flutter/engine/pull/8237) Mirror Android platform views a11y tree in the Flutter a11y tree. (cla: yes)

[8241](https://github.com/flutter/engine/pull/8241) fix video player dismiss when there is a iOS platform view (cla: yes)

[8246](https://github.com/flutter/engine/pull/8246) Remove more forced crashes from FlutterJNI (cla: yes)

[8247](https://github.com/flutter/engine/pull/8247) Fix incorrect vertices colors length check (cla: yes)

[8249](https://github.com/flutter/engine/pull/8249) Allow specifying an alternate Mac host SDK. (cla: yes)

[8250](https://github.com/flutter/engine/pull/8250) Delegate a11y events and action to/from embedded Android platform views. (cla: yes)

[8251](https://github.com/flutter/engine/pull/8251) Fixed service isolate not being initialized correctly due to bad name (cla: yes)

[8253](https://github.com/flutter/engine/pull/8253) Add platformViewId to stub_ui (cla: yes)

[8254](https://github.com/flutter/engine/pull/8254) Do not drop the DartExecutor's message handler when a FlutterNativeView is detached from the FlutterView (cla: yes)

[8256](https://github.com/flutter/engine/pull/8256) check that public API of dart:ui conforms to web implementation (cla: yes)

[8265](https://github.com/flutter/engine/pull/8265) Linking Higher & Lower Class Docs (affects: docs, cla: yes)

[8273](https://github.com/flutter/engine/pull/8273) Allow embedders to specify their own task runner interfaces. (cla: yes)

[8274](https://github.com/flutter/engine/pull/8274) [ui] Add null check in FontWeight.lerp (Work in progress (WIP), cla: yes, prod: API break)

[8276](https://github.com/flutter/engine/pull/8276) Make it easy to write embedder unit tests by creating a fixture and config builder. (cla: yes)

[8277](https://github.com/flutter/engine/pull/8277) Roll buildroot to 9c7b023ff266ee58b00fe60326fa1db910a087f3 (cla: yes)

[8293](https://github.com/flutter/engine/pull/8293) [vulkan] Add FUCHSIA external sem/mem extensions (cla: yes)

[8295](https://github.com/flutter/engine/pull/8295) Fixing links between higher and lower classes. (affects: docs, cla: yes)

[8296](https://github.com/flutter/engine/pull/8296) Migrate existing embedder unit tests to use the fixture. (cla: yes)

[8297](https://github.com/flutter/engine/pull/8297) [fuchsia] Add missing trace macros (cla: yes)

[8299](https://github.com/flutter/engine/pull/8299) Enable lambda like native callbacks in tests and add support for custom entrypoints. (cla: yes)

[8308](https://github.com/flutter/engine/pull/8308) Map glfw into third_party, and roll buildroot (cla: yes)

[8309](https://github.com/flutter/engine/pull/8309) Allow specification of std::functions as native entrypoints from Dart code. (cla: yes)

[8312](https://github.com/flutter/engine/pull/8312) Revert "Allow specification of std::functions as native entrypoints from Dart code." (cla: yes)

[8317](https://github.com/flutter/engine/pull/8317) Android Embedding PR22: Polish - FlutterActivity Intent factories, FlutterFragment control of render modes, FlutterSurfaceView transparent until rendering is ready. (cla: yes)

[8318](https://github.com/flutter/engine/pull/8318) Reduce z-fighting on Scenic (cla: yes)

[8319](https://github.com/flutter/engine/pull/8319) Fix "PointerEvent" flow end event (cla: yes)

[8325](https://github.com/flutter/engine/pull/8325) [fuchsia] Disable FML_TRACE_COUNTER events to unblock roll (cla: yes)

[8327](https://github.com/flutter/engine/pull/8327) Build GLFW from source for Linux shell (cla: yes)

[8329](https://github.com/flutter/engine/pull/8329) Reland "Allow specification of std::functions as native entrypoints from Dart code." (cla: yes)

[8330](https://github.com/flutter/engine/pull/8330) Create a new resource loading EGL context for each PlatformView instance on Android (cla: yes)

[8331](https://github.com/flutter/engine/pull/8331) Build Windows shell (cla: yes)

[8333](https://github.com/flutter/engine/pull/8333) Allow delegation of a11y events from nodes that were not yet traversed (cla: yes)

[8334](https://github.com/flutter/engine/pull/8334) Remove use of epoxy from Linux shell (cla: yes)

[8335](https://github.com/flutter/engine/pull/8335) Add super call in FLEView reshape (cla: yes)

[8336](https://github.com/flutter/engine/pull/8336) Fix Windows build. (cla: yes)

[8337](https://github.com/flutter/engine/pull/8337) Cleanups to run_tests.sh script (cla: yes)

[8338](https://github.com/flutter/engine/pull/8338) Remove the standalone a11y test runners and merge its tests into embedder_unittests. (cla: yes)

[8339](https://github.com/flutter/engine/pull/8339) Fix typos (cla: yes)

[8343](https://github.com/flutter/engine/pull/8343) Reset min log levels on each engine launch. (cla: yes)

[8345](https://github.com/flutter/engine/pull/8345) Build precompiled sdk and analyzer summary for dartdevc (cla: yes)

[8346](https://github.com/flutter/engine/pull/8346) Introduce unit tests and refactor web dart:ui into "package" (cla: yes)

[8353](https://github.com/flutter/engine/pull/8353) Revert "Build precompiled sdk and analyzer summary for dartdevc" (cla: yes)

[8354](https://github.com/flutter/engine/pull/8354) Rename threshold to access_threshold (cla: yes)

[8355](https://github.com/flutter/engine/pull/8355) Create ddc summary file and precompiled sdk (cla: yes)

[8358](https://github.com/flutter/engine/pull/8358) Allow per-platform customization of the default Skia font manager (cla: yes)

[8359](https://github.com/flutter/engine/pull/8359) update buildroot dep for PR #227 (cla: yes)

[8360](https://github.com/flutter/engine/pull/8360) Remove old Fuchsia external mem,sem extensions (cla: yes)

[8362](https://github.com/flutter/engine/pull/8362) Ensure OpacityLayer to have a single child (cla: yes)

[8368](https://github.com/flutter/engine/pull/8368) libtxt: track the start and end x positions of glyph blobs for more accurate rendering of text decorations (cla: yes)

[8369](https://github.com/flutter/engine/pull/8369) GN Format all files in the engine. (cla: yes)

[8371](https://github.com/flutter/engine/pull/8371) Add a GN format presubmit. (cla: yes)

[8373](https://github.com/flutter/engine/pull/8373) Move libdart selection into its own target in //flutter/runtime. (cla: yes)

[8374](https://github.com/flutter/engine/pull/8374) [flutter_tester] Accept --icu-data-file-path (cla: yes)

[8375](https://github.com/flutter/engine/pull/8375) Allow running runtime_unittests in AOT mode. (cla: yes)

[8376](https://github.com/flutter/engine/pull/8376) Check for hover motion events in AndroidTouchProcessor (cla: yes)

[8377](https://github.com/flutter/engine/pull/8377) Handle null values in TextInputConfiguration.actionLabel JSON (cla: yes)

[8379](https://github.com/flutter/engine/pull/8379) Allow native entrypoint registration for runtime unittests. (cla: yes)

[8380](https://github.com/flutter/engine/pull/8380) Delay platform view removal to submitFrame. (cla: yes)

[8381](https://github.com/flutter/engine/pull/8381) Remove unused DartVM::IsKernelMapping (cla: yes)

[8382](https://github.com/flutter/engine/pull/8382) Add missing import to functional for Windows. (cla: yes)

[8387](https://github.com/flutter/engine/pull/8387) Make the resource context primary on iOS (cla: yes)

[8393](https://github.com/flutter/engine/pull/8393) Don't access a11y APIs with reflection starting Android P. (cla: yes)

[8397](https://github.com/flutter/engine/pull/8397) Separate the data required to bootstrap the VM into its own class. (cla: yes)

[8400](https://github.com/flutter/engine/pull/8400) Make sure FlutterViewController flushs all pending touches when no longer active (cla: yes)

[8402](https://github.com/flutter/engine/pull/8402) Enable shutting down all root isolates in a VM. (cla: yes)

[8406](https://github.com/flutter/engine/pull/8406) Revert "Separate the data required to bootstrap the VM into its own class." (cla: yes)

[8407](https://github.com/flutter/engine/pull/8407) [fuchsia] Exclude glfw from the Fuchsia host build (cla: yes)

[8410](https://github.com/flutter/engine/pull/8410) [txt] Add back FontCollection::SetDefaultFontManager (cla: yes)

[8411](https://github.com/flutter/engine/pull/8411) Added new Android embedding packages to javadoc generation. (cla: yes)

[8412](https://github.com/flutter/engine/pull/8412) Pass environment defines to compile flutter platform step. (cla: yes)

[8414](https://github.com/flutter/engine/pull/8414) Separate the data required to bootstrap the VM into its own class. (cla: yes)

[8416](https://github.com/flutter/engine/pull/8416) Add scroll wheel support to desktop GLFW shell (cla: yes)

[8417](https://github.com/flutter/engine/pull/8417) Remove use of DART_CHECK_VALID. (cla: yes)

[8419](https://github.com/flutter/engine/pull/8419) Support message loops whose tasks are executed concurrently. (cla: yes)

[8421](https://github.com/flutter/engine/pull/8421) dart:ui Locale: add toLanguageTag() (cla: yes)

[8425](https://github.com/flutter/engine/pull/8425) Roll buildroot (cla: yes)

[8427](https://github.com/flutter/engine/pull/8427) Eliminate unused displayBounds parameter (cla: yes)

[8429](https://github.com/flutter/engine/pull/8429) Make AccessibilityViewEmbedder final (cla: yes)

[8431](https://github.com/flutter/engine/pull/8431) Revert "Enable shutting down all root isolates in a VM." (cla: yes)

[8435](https://github.com/flutter/engine/pull/8435) Add window title/icon support to GLFW shell (cla: yes)

[8439](https://github.com/flutter/engine/pull/8439) update to use SkTileMode (cla: yes)

[8442](https://github.com/flutter/engine/pull/8442) Build windows engine on GCE (cla: yes)

[8446](https://github.com/flutter/engine/pull/8446) Add scripts that prepares our windows VM image (cla: yes)

[8448](https://github.com/flutter/engine/pull/8448) Android Embedding PR24: Allow FlutterActivity to provide an engine, also adjust FlutterFragment timing to avoid Activity launch lag. (cla: yes)

[8456](https://github.com/flutter/engine/pull/8456) More detailed comments for engine build windows VM (cla: yes)

[8457](https://github.com/flutter/engine/pull/8457) Enable shutting down all root isolates in a VM. (cla: yes)

[8460](https://github.com/flutter/engine/pull/8460) Android Embedding PR25: Prevent black rectangle when launching FlutterActivity (cla: yes)

[8461](https://github.com/flutter/engine/pull/8461) Log the correct function on error in the embedder. (cla: yes)

[8462](https://github.com/flutter/engine/pull/8462) Document the leak_vm flag. (cla: yes)

[8465](https://github.com/flutter/engine/pull/8465) Android Embedding PR26: Offer an async version of FlutterMain's ensure initialization complete. (cla: yes)

[8467](https://github.com/flutter/engine/pull/8467) Initialize OpacityLayer's matrix to identity (cla: yes)

[8472](https://github.com/flutter/engine/pull/8472) [Docs] Correcting link to contributing guide. (affects: docs, cla: yes, easy fix)

[8473](https://github.com/flutter/engine/pull/8473) Roll dart back to 907c514c8937cf76e (cla: yes)

[8477](https://github.com/flutter/engine/pull/8477) Add trace events for creating minikin fonts (cla: yes)

[8490](https://github.com/flutter/engine/pull/8490) Remove unused variable (cla: yes)

[8496](https://github.com/flutter/engine/pull/8496) [scenic] Remove unused mozart.internal (cla: yes)

[8497](https://github.com/flutter/engine/pull/8497) Wire up support for Dart fixtures in shell_unittests. (cla: yes)

[8498](https://github.com/flutter/engine/pull/8498) Move constant definitions out embedder.h (cla: yes)

[8499](https://github.com/flutter/engine/pull/8499) Route FlutterEventTracer events to Fuchsia tracing for Fuchsia (cla: yes)

[8500](https://github.com/flutter/engine/pull/8500) Get rid of the macro for accessing the current test name. (cla: yes)

[8503](https://github.com/flutter/engine/pull/8503) [scenic][SCN-1054] remove dangling uses of SetTranslationRH (cla: yes)

[8504](https://github.com/flutter/engine/pull/8504) Android Embedding PR27: Fix SurfaceView flicker in Fragment transactions (cla: yes)

[8511](https://github.com/flutter/engine/pull/8511) switch to newer APIs for shaders and filters (cla: yes)

[8515](https://github.com/flutter/engine/pull/8515) Add windows host_debug_unopt build test (cla: yes)

[8517](https://github.com/flutter/engine/pull/8517) Rename the blink namespace to flutter. (cla: yes)

[8518](https://github.com/flutter/engine/pull/8518) Remove the unused EnableBlink flag. (cla: yes)

[8520](https://github.com/flutter/engine/pull/8520) Rename the shell namespace to flutter. (cla: yes)

[8523](https://github.com/flutter/engine/pull/8523) Remove redundant specification of the |flutter| namespace in the engine. (cla: yes)

[8524](https://github.com/flutter/engine/pull/8524) Change Rect internal representation from Float32List to Float64List (cla: yes)

[8525](https://github.com/flutter/engine/pull/8525) Merge flutter/synchronization contents into fml. (cla: yes)

[8527](https://github.com/flutter/engine/pull/8527) Added support for authentication codes for the VM service (cla: yes)

[8528](https://github.com/flutter/engine/pull/8528) Redo a fix for cull rect calculation on TransformLayers with a perspective transform (cla: yes)

[8530](https://github.com/flutter/engine/pull/8530) Tight Paragraph Width (cla: yes)

[8531](https://github.com/flutter/engine/pull/8531) Add an option to build the GLFW shell on macOS (cla: yes)

[8534](https://github.com/flutter/engine/pull/8534) Use code cache dir for engine cache (#14704). (cla: yes)

[8536](https://github.com/flutter/engine/pull/8536) Android Embedding PR28: Report app is active to Flutter in FlutterFragment.onResume() instead of onPostResume() forwarded from Activity. (cla: yes)

[8537](https://github.com/flutter/engine/pull/8537) Correct nullability for FlutterStandardReader (cla: yes)

[8538](https://github.com/flutter/engine/pull/8538) Add null check in FLETextInputPlugin (cla: yes)

[8540](https://github.com/flutter/engine/pull/8540) Android Embedding PR29: Improve FlutterFragment construction API + engine config API. (cla: yes)

[8541](https://github.com/flutter/engine/pull/8541) Eliminate unused write to local (cla: yes)

[8545](https://github.com/flutter/engine/pull/8545) Revert "Change Rect internal representation from Float32List to Float64List (#8524)" (cla: yes)

[8546](https://github.com/flutter/engine/pull/8546) [font_collection] Add missing semicolon (cla: yes)

[8548](https://github.com/flutter/engine/pull/8548) Initialize OpacityLayer's matrix to identity (#8467) (cla: yes)

[8549](https://github.com/flutter/engine/pull/8549) [fuchsia] Add flutter:: to scene_host.cc (cla: yes)

[8550](https://github.com/flutter/engine/pull/8550) Export extern constants in embedder.h (cla: yes)

[8551](https://github.com/flutter/engine/pull/8551) Android Embedding PR30: Make FlutterView focusable so that the keyboard can interact with it. (cla: yes)

[8555](https://github.com/flutter/engine/pull/8555) Roll Dart 15b11b018364ce03...a8f3a5dae6203d10 (cla: yes)

[8557](https://github.com/flutter/engine/pull/8557) Update README.md (cla: yes)

[8562](https://github.com/flutter/engine/pull/8562) Add missing <memory> include to text_input_model.h (cla: yes)

[8563](https://github.com/flutter/engine/pull/8563) Remove unused import in FlutterActivityDelegate (cla: yes)

[8565](https://github.com/flutter/engine/pull/8565) Make Rect and RRect use 64 bit doubles, and make them const-able (cla: yes)

[8581](https://github.com/flutter/engine/pull/8581) Remove the flutter_aot GN argument. (cla: yes)

[8583](https://github.com/flutter/engine/pull/8583) Pipe Z bounds from ViewportMetrics to Flow (cla: yes)

[8585](https://github.com/flutter/engine/pull/8585) Check that TransformLayer has a finite matrix (cla: yes)

[8591](https://github.com/flutter/engine/pull/8591) Glitchiness with Tab Characters (cla: yes)

[8592](https://github.com/flutter/engine/pull/8592) Variant type for C++ client wrapper (cla: yes)

[8593](https://github.com/flutter/engine/pull/8593) Roll buildroot to ce7b5c786a12927c9e0b4543af267d48c52e0b3a (cla: yes)

[8594](https://github.com/flutter/engine/pull/8594) Enable VM service authentication codes by default (cla: yes)

[8598](https://github.com/flutter/engine/pull/8598) Implement StandardMethodCodec for C++ shells (cla: yes)

[8600](https://github.com/flutter/engine/pull/8600) Add desktop shell unittests to test script (cla: yes)

[8605](https://github.com/flutter/engine/pull/8605) Allow building without python2 (cla: yes)

[8608](https://github.com/flutter/engine/pull/8608) [fuchsia] Fix SceneUpdateContext for new PaintContext field (cla: yes)

[8611](https://github.com/flutter/engine/pull/8611) Add FLEPluginRegistry for macOS (cla: yes)

[8612](https://github.com/flutter/engine/pull/8612) Remove call to SkFont::setLinearMetrics (cla: yes)

[8615](https://github.com/flutter/engine/pull/8615) Rename flow namespace to flutter (cla: yes)

[8616](https://github.com/flutter/engine/pull/8616) Add a unit test for PhysicalShapeLayer (cla: yes)

[8617](https://github.com/flutter/engine/pull/8617) Fixes a typo in comment (affects: docs, cla: yes)

[8618](https://github.com/flutter/engine/pull/8618) Test saving compilation traces. (cla: yes)

[8621](https://github.com/flutter/engine/pull/8621) Avoid manually shutting down engine managed isolates. (cla: yes)

[8622](https://github.com/flutter/engine/pull/8622) Assert that all VM launches in the process have the same opinion on whether the VM should be leaked in the process. (cla: yes)

[8623](https://github.com/flutter/engine/pull/8623) Add an adjustment to the line width check in LineBreaker::addWordBreak (cla: yes)

[8625](https://github.com/flutter/engine/pull/8625) Add support for authentication codes via MDNS on iOS (cla: yes)

[8626](https://github.com/flutter/engine/pull/8626) Avoid leaking the VM in runtime_unittests and update failing tests. (cla: yes)

[8627](https://github.com/flutter/engine/pull/8627) Revert "Add a unit test for PhysicalShapeLayer" (cla: yes)

[8628](https://github.com/flutter/engine/pull/8628) Avoid leaking the VM in the shell unittests and assert VM state in existing tests. (cla: yes)

[8633](https://github.com/flutter/engine/pull/8633) Reland elevation test (cla: yes)

[8634](https://github.com/flutter/engine/pull/8634) Merge runtime lifecycle unittests into the base test target. (cla: yes)

[8635](https://github.com/flutter/engine/pull/8635) Remove unnecessary DartIO::EntropySource wrapper (cla: yes)

[8637](https://github.com/flutter/engine/pull/8637) Generate layer unique id for raster cache key (cla: yes)

[8638](https://github.com/flutter/engine/pull/8638) Custom RTL handling for ghost runs, NotoNaskhArabic test font (cla: yes)

[8640](https://github.com/flutter/engine/pull/8640) Remove DartSnapshotBuffer and dry up snapshot resolution logic. (cla: yes)

[8642](https://github.com/flutter/engine/pull/8642) Remove unused Settings::ToString. (cla: yes)

[8643](https://github.com/flutter/engine/pull/8643) Allow specifying the Mac SDK path as an environment variable to //flutter/tools/gn (cla: yes)

[8644](https://github.com/flutter/engine/pull/8644) Revert "Remove DartSnapshotBuffer and dry up snapshot resolution logic." (cla: yes)

[8645](https://github.com/flutter/engine/pull/8645) Reland "Remove DartSnapshotBuffer and dry up snapshot resolution logic". (cla: yes)

[8646](https://github.com/flutter/engine/pull/8646) Disable auth codes for Observatory test (cla: yes)

[8649](https://github.com/flutter/engine/pull/8649) Roll buildroot to 380d0ed5c3399d5a2aaac4a66d98e3a3fda77c31 (cla: yes)

[8652](https://github.com/flutter/engine/pull/8652) Add factory methods to FileMapping that make it easy to create common mappings. (cla: yes)

[8653](https://github.com/flutter/engine/pull/8653) Cleanup references to FLX archives from the engine. (cla: yes)

[8656](https://github.com/flutter/engine/pull/8656) Only allow mappings for ICU initialization. (cla: yes)

[8657](https://github.com/flutter/engine/pull/8657) Change Vertices.indices to use a Uint16 list to more accurately reflect Skia's API (cla: yes)

[8658](https://github.com/flutter/engine/pull/8658) Allow native bindings in secondary isolates. (cla: yes)

[8659](https://github.com/flutter/engine/pull/8659) Replace ThreadLocal with ThreadLocalUniquePtr<T> (cla: yes)

[8661](https://github.com/flutter/engine/pull/8661) Put the testing lib in the flutter namespace. (cla: yes)

[8663](https://github.com/flutter/engine/pull/8663) Remove support for downloading dynamic patches on Android (cla: yes)

[8664](https://github.com/flutter/engine/pull/8664) Add framework test in engine presubmit checks (cla: yes)

[8681](https://github.com/flutter/engine/pull/8681) Revert "Custom RTL handling for ghost runs, NotoNaskhArabic test font" (cla: yes)

[8682](https://github.com/flutter/engine/pull/8682) Revert "Only allow mappings for ICU initialization." (cla: yes)

[8683](https://github.com/flutter/engine/pull/8683) Custom RTL handling for ghost runs, NotoNaskhArabic test font (cla: yes)

[8688](https://github.com/flutter/engine/pull/8688) fix toString (cla: yes)

[8689](https://github.com/flutter/engine/pull/8689) Revert "Remove unused Settings::ToString. (#8642)" (cla: yes)

[8690](https://github.com/flutter/engine/pull/8690) Revert Rect/RRect 64 bit (cla: yes)

[8692](https://github.com/flutter/engine/pull/8692) Add tests from framework (cla: yes)

[8695](https://github.com/flutter/engine/pull/8695) Reland const Rect/RRect (cla: yes)

[8698](https://github.com/flutter/engine/pull/8698) Convert animated unpremul images to premul during decode (cla: yes)

[8700](https://github.com/flutter/engine/pull/8700) Increase the memory usage estimate for EngineLayer (cla: yes)

[8704](https://github.com/flutter/engine/pull/8704) Limit the size of VirtualDisplay we create in android (cla: yes)

[8706](https://github.com/flutter/engine/pull/8706) Rename tightWidth to longestLine (cla: yes)

[8707](https://github.com/flutter/engine/pull/8707) Document that OpacityLayer's children are nonempty (cla: yes)

[8710](https://github.com/flutter/engine/pull/8710) Plumb arguments from Settings to Dart entrypoint (cla: yes)

[8712](https://github.com/flutter/engine/pull/8712) [scenic] Purge references to Mozart (cla: yes)

[8716](https://github.com/flutter/engine/pull/8716) Add Rect.fromCenter() constructor (cla: yes)

[8721](https://github.com/flutter/engine/pull/8721) Fix header include guards for fml/thread_local.h (cla: yes)

[8723](https://github.com/flutter/engine/pull/8723) Fix include paths in libtxt to prepare for upcoming Skia build change (cla: yes)

[8735](https://github.com/flutter/engine/pull/8735) Fix reflective ctor invocation in FlutterFragment (cla: yes)

[8738](https://github.com/flutter/engine/pull/8738) Revert "Increase the memory usage estimate for EngineLayer" (cla: yes)

[8742](https://github.com/flutter/engine/pull/8742) Log the sticky error during isolate shutdown (cla: yes)

[8747](https://github.com/flutter/engine/pull/8747) Fix crash when cursor ends up at invalid position (cla: yes)

[8758](https://github.com/flutter/engine/pull/8758) Check the matrix in pushTransform (cla: yes)

[8772](https://github.com/flutter/engine/pull/8772) colormatrix is now 0...1 (cla: yes)

[8780](https://github.com/flutter/engine/pull/8780) VirtualDisplay size constraint - add a comment explaining the reason (cla: yes)

[8789](https://github.com/flutter/engine/pull/8789) Roll to branched dart sdk with hotfix(dartbug.com/36772) for flutter 1.5.4 (cla: yes)

[8790](https://github.com/flutter/engine/pull/8790) Roll to branched dart sdk with two more hotfixes for flutter 1.5.4. (cla: yes)

[8792](https://github.com/flutter/engine/pull/8792) Re-create texture from pixel buffer onGrContextCreate (cla: yes)

[8793](https://github.com/flutter/engine/pull/8793) Roll buildroot to pull in Fuchsia SDK related updates. (cla: yes)

[8796](https://github.com/flutter/engine/pull/8796) Dart SDK roll for 2019-04-30 (cla: yes)


## PRs closed in this release of flutter/plugins

From Thu Feb 21 20:22:00 2019 -0800 to Wed May 1 16:56:00 2019 -0700


[721](https://github.com/flutter/plugins/pull/721) [google_sign_in]Fix filename in google_sign_in docs, which leads to crash (bugfix, cla: yes, documentation)

[742](https://github.com/flutter/plugins/pull/742) [image_picker]Fixed losing transparency of PNGs (bugfix, cla: yes, submit queue)

[790](https://github.com/flutter/plugins/pull/790) [cloud_firestore]add sample to get specific document (cla: yes, documentation, flutterfire, submit queue)

[793](https://github.com/flutter/plugins/pull/793) [video_player]Do not divide by zero (bugfix, cla: yes, submit queue)

[815](https://github.com/flutter/plugins/pull/815) [google_maps_flutter] adds support for custom icon from a byte array (PNG) (cla: yes, feature, needs love)

[927](https://github.com/flutter/plugins/pull/927) [firebase_admob]Fix typo in RewardedVideoAdd sample (bugfix, cla: yes, documentation, flutterfire, submit queue)

[963](https://github.com/flutter/plugins/pull/963) Reduce Android compiler warnings, prevent NPE (cla: yes)

[985](https://github.com/flutter/plugins/pull/985) [google_maps_flutter]add support for map tapping (cla: yes)

[991](https://github.com/flutter/plugins/pull/991) [firebase_core]Fix firebase core registration and fix firestore document observer cleanup (cla: yes)

[1008](https://github.com/flutter/plugins/pull/1008) [firebase_analytics] Add 'loginMethod' parameter to logLogin() (cla: yes, feature, flutterfire, submit queue)

[1022](https://github.com/flutter/plugins/pull/1022) [camera] Add serial dispatch_queue for camera plugin to avoid blocking the UI (bugfix, cla: yes, submit queue)

[1023](https://github.com/flutter/plugins/pull/1023) [camera]Fix CameraPreview freezes during startVideoRecording on iOS (cla: yes)

[1049](https://github.com/flutter/plugins/pull/1049) [google_maps_flutter] Widget based polyline support for google maps. (cla: yes)

[1080](https://github.com/flutter/plugins/pull/1080) [firebase_crashlytics]Firebase Crashlytics plugin (cla: yes)

[1096](https://github.com/flutter/plugins/pull/1096) [firebase_database]Return error message from DatabaseError#toString() (cla: yes, submit queue)

[1123](https://github.com/flutter/plugins/pull/1123) [video_player] Correctly report buffering status on Android (bugfix, cla: yes, submit queue)

[1142](https://github.com/flutter/plugins/pull/1142) [firebase_dynamic_links] fix dynamic link crash when creating shortlink if warnings are null (bugfix, cla: yes, flutterfire, submit queue)

[1154](https://github.com/flutter/plugins/pull/1154) [video_player] Upgrade ExoPlayer dependency to 2.9.4 (cla: yes, feature, submit queue)

[1159](https://github.com/flutter/plugins/pull/1159) [firebase_auth] Enable passwordless sign in (cla: yes, feature, flutterfire, submit queue)

[1182](https://github.com/flutter/plugins/pull/1182) [firebase_dynamic_links] sometimes got error NSPOSIXErrorDomain Code=53 in ios (bugfix, cla: yes, flutterfire, submit queue)

[1192](https://github.com/flutter/plugins/pull/1192) Flutterfire apps no longer show a confusing log message about configuring default app (cla: yes)

[1201](https://github.com/flutter/plugins/pull/1201) [connectivity] Update README.md (cla: yes, documentation, submit queue)

[1208](https://github.com/flutter/plugins/pull/1208) [firebase_storage] Support for getReferenceFromUrl (cla: yes)

[1219](https://github.com/flutter/plugins/pull/1219) [firebase_auth] update example app and README (cla: yes, documentation, feature, flutterfire)

[1223](https://github.com/flutter/plugins/pull/1223) [firebase_ml_vision] Fix crash when scanning URL QR-code on iOS (bugfix, cla: yes, submit queue)

[1229](https://github.com/flutter/plugins/pull/1229) [google_maps_flutter] Marker APIs are now widget based (Android) (bugfix, cla: yes, feature)

[1236](https://github.com/flutter/plugins/pull/1236) [webview_flutter]Allow specifying a navigation delegate(Android and Dart). (cla: yes)

[1237](https://github.com/flutter/plugins/pull/1237) [share] Changed compileSdkVersion of share plugin to 28 (cla: yes, submit queue)

[1239](https://github.com/flutter/plugins/pull/1239) [google_maps_flutter] Marker APIs are now widget based (Dart Changes) (cla: yes, documentation)

[1240](https://github.com/flutter/plugins/pull/1240) [google_maps_flutter] Marker APIs are now widget based (iOS Changes) (cla: yes, feature)

[1241](https://github.com/flutter/plugins/pull/1241) [camera] 28180 fix exif data bug for first time camera use android (cla: yes, submit queue)

[1249](https://github.com/flutter/plugins/pull/1249) [in_app_purchase] payment queue dart ios (bugfix, cla: yes, feature)

[1250](https://github.com/flutter/plugins/pull/1250) [video_player] Cast the NSInteger to long and use %ld formatter (cla: yes, submit queue)

[1251](https://github.com/flutter/plugins/pull/1251) Update android_alarm_manager with instructions on setting WAKE_LOCK permissions (cla: yes, documentation)

[1252](https://github.com/flutter/plugins/pull/1252) [In_app_purchase]SKProduct related fixes (cla: yes)

[1253](https://github.com/flutter/plugins/pull/1253) Disable analyzer error (cla: yes)

[1255](https://github.com/flutter/plugins/pull/1255) Don't register the Maps and Camera plugin for background FlutterViews. (cla: yes)

[1256](https://github.com/flutter/plugins/pull/1256) Skip Gradle's static permission check for the Maps MyLocation feature. (cla: yes)

[1257](https://github.com/flutter/plugins/pull/1257) Suppress unchecked cast warning for the PlatformViewFactory creation … (cla: yes)

[1259](https://github.com/flutter/plugins/pull/1259) [in_app_purchase] Java API for querying purchases (cla: yes)

[1261](https://github.com/flutter/plugins/pull/1261) [camera] Fixes #28350 (bugfix, cla: yes, feature, submit queue)

[1265](https://github.com/flutter/plugins/pull/1265) [image_picker] fix error if pick image from yandex disk(dropbox) (bugfix, cla: yes)

[1266](https://github.com/flutter/plugins/pull/1266) [image_picker] update Uri Authority for GooglePhotos (bugfix, cla: yes, submit queue)

[1268](https://github.com/flutter/plugins/pull/1268) [image_picker] remove unnecessary camera permmision (bugfix, cla: yes)

[1269](https://github.com/flutter/plugins/pull/1269) [image_picker] set real extension instead always jpg (cla: yes, submit queue)

[1270](https://github.com/flutter/plugins/pull/1270) [firebase_ml_vision] Incorrect link for including the ML Model pods into the example project (cla: yes, documentation, submit queue)

[1271](https://github.com/flutter/plugins/pull/1271) [google_maps_flutter] Update the sample app in README.md (cla: yes)

[1274](https://github.com/flutter/plugins/pull/1274) [cloud_firestore,firebase_database,firebase_storage] handling error nil on getFlutterError (cla: yes)

[1275](https://github.com/flutter/plugins/pull/1275) [package_info] calling new method for BuildNumber in new android versions (bugfix, cla: yes, submit queue)

[1277](https://github.com/flutter/plugins/pull/1277) [firebase_performance] Fix incorrect setting of Trace & HttpMetric attributes (cla: yes, flutterfire)

[1278](https://github.com/flutter/plugins/pull/1278) [firebase_performance] remove deprecated trace counter API usage (cla: yes, flutterfire)

[1279](https://github.com/flutter/plugins/pull/1279) [firebase_core][firebase_database]Add nil check for some static methods to avoid unwanted behaviors (cla: yes)

[1281](https://github.com/flutter/plugins/pull/1281) [in_app_purchase] Fix CI formatting errors. (cla: yes)

[1284](https://github.com/flutter/plugins/pull/1284) [in_app_purchase] Minor bugfixes and code cleanup (cla: yes)

[1285](https://github.com/flutter/plugins/pull/1285) [shared_preferences] driver test using package:test on device (cla: yes)

[1286](https://github.com/flutter/plugins/pull/1286) [in_app_purchase] Adds Dart BillingClient APIs for loading purchases (cla: yes)

[1288](https://github.com/flutter/plugins/pull/1288) [image_picker] delete original file if scaled (cla: yes)

[1289](https://github.com/flutter/plugins/pull/1289) Add missing license headers (cla: yes)

[1291](https://github.com/flutter/plugins/pull/1291) Bugfix/account for nsnull (cla: yes)

[1292](https://github.com/flutter/plugins/pull/1292) [firebase_auth] Make providerId 'const String' for easier use in switch statements (bugfix, cla: yes, flutterfire, submit queue)

[1293](https://github.com/flutter/plugins/pull/1293) [google_maps_flutter] The FloatingActionButton requires an icon (cla: yes)

[1294](https://github.com/flutter/plugins/pull/1294) Fix icon issue on ios and manifest on android (cla: yes)

[1296](https://github.com/flutter/plugins/pull/1296) [image_picker] Update pub info for #742 (cla: yes)

[1297](https://github.com/flutter/plugins/pull/1297) Update play-services-maps from 15.+ to 16.1.0 (cla: yes)

[1299](https://github.com/flutter/plugins/pull/1299) [in_app_purchase]restore purchases (cla: yes)

[1300](https://github.com/flutter/plugins/pull/1300) Add my name to firebase_performance and firebase_dynamic_links owners (cla: yes, submit queue)

[1302](https://github.com/flutter/plugins/pull/1302) [google_maps_flutter]ChangeNotifier is replaced with granular callbacks (cla: yes)

[1303](https://github.com/flutter/plugins/pull/1303) [in_app_purchase]retrieve receipt (cla: yes)

[1306](https://github.com/flutter/plugins/pull/1306) [cloud_firestore] Update firebase-firestore to 18.2.0 (cla: yes, submit queue)

[1309](https://github.com/flutter/plugins/pull/1309) [firebase_dynamic_links] Version bump for firebase_dynamic_links PR #1142 (bugfix, cla: yes, flutterfire, submit queue)

[1311](https://github.com/flutter/plugins/pull/1311) [firebase_analytics] Add resetAnalyticsData method (cla: yes)

[1314](https://github.com/flutter/plugins/pull/1314) trackCameraPosition is inferred from GoogleMap.onCameraMove (cla: yes)

[1315](https://github.com/flutter/plugins/pull/1315) [image_picker] remove unnecessary file path for video. (bugfix, cla: yes, needs love, submit queue)

[1316](https://github.com/flutter/plugins/pull/1316) [cloud_functions] Specify version for CocoaPod and handle null regions gracefully (cla: yes)

[1322](https://github.com/flutter/plugins/pull/1322) [in_app_purchase] refactoring and tests (cla: yes)

[1323](https://github.com/flutter/plugins/pull/1323) Allow specifying a navigation delegate (iOS implementation). (cla: yes)

[1324](https://github.com/flutter/plugins/pull/1324) Exclude longPress from semantics (cla: yes)

[1326](https://github.com/flutter/plugins/pull/1326) [image_picker] Update versioning for #1268 (cla: yes)

[1327](https://github.com/flutter/plugins/pull/1327) Change build link in contributors site to cirrus (cla: yes)

[1329](https://github.com/flutter/plugins/pull/1329) [firebase_messaging] Fix Changelog.md version for firebase_messaging (cla: yes, documentation, flutterfire)

[1331](https://github.com/flutter/plugins/pull/1331) [connectivity] Enable fetching current Wi-Fi network's BSSID (cla: yes, feature)

[1333](https://github.com/flutter/plugins/pull/1333) [firebase_auth] fixes Android linkWithCredential (cla: yes, flutterfire)

[1335](https://github.com/flutter/plugins/pull/1335) [webview_flutter] Add a page loaded callback (cla: yes, feature, submit queue)

[1337](https://github.com/flutter/plugins/pull/1337) [android_alarm_manager] Improve error message seen when an alarm fires and `AlarmService.setPluginRegistrant` has not been called. (bugfix, cla: yes)

[1338](https://github.com/flutter/plugins/pull/1338) Add Kaushik to maps code owners (cla: yes)

[1339](https://github.com/flutter/plugins/pull/1339) [cloud_firestore] ios check for nil snapshot in cloud_firestore error handling instead of checking for non-nil error (cla: yes)

[1341](https://github.com/flutter/plugins/pull/1341) Removed dependency on Firebase for android_alarm_manager example (cla: yes)

[1342](https://github.com/flutter/plugins/pull/1342) add driver test command to cirrus (cla: yes)

[1343](https://github.com/flutter/plugins/pull/1343) [firebase_auth] fix error code in doc of createUserWithEmailAndPassword() (cla: yes)

[1344](https://github.com/flutter/plugins/pull/1344) [shared_preferences] Update shared_preferences CHANGELOG for release (cla: yes)

[1345](https://github.com/flutter/plugins/pull/1345) [cloud_firestore] fix NoSuchMethodError regression and add test (cla: yes)

[1346](https://github.com/flutter/plugins/pull/1346) [cloud_functions] add a driver test (cla: yes)

[1348](https://github.com/flutter/plugins/pull/1348) [firebase_auth] Add a driver test (cla: yes)

[1350](https://github.com/flutter/plugins/pull/1350) [google_maps_flutter] add My location button enabled option (cla: yes)

[1352](https://github.com/flutter/plugins/pull/1352) [google_maps_flutter] Add method getVisibleRegion (cla: yes)

[1353](https://github.com/flutter/plugins/pull/1353) [firebase_messaging] Update example (cla: yes, submit queue)

[1357](https://github.com/flutter/plugins/pull/1357) Disable Android emulator testing for now to fix tests (cla: yes)

[1360](https://github.com/flutter/plugins/pull/1360) [webview_flutter] Create WebView client depending on version and hasDelegate (bugfix, cla: yes, webview)

[1361](https://github.com/flutter/plugins/pull/1361) [webview_flutter] Update changelog and bump versions. (cla: yes, submit queue)

[1364](https://github.com/flutter/plugins/pull/1364) [firebase_ml_vision] Update ImageDetector for iOS (bugfix, cla: yes, flutterfire)

[1367](https://github.com/flutter/plugins/pull/1367) [firebase_ml_vision] Android side of upgrade to new ImageLabeler (bugfix, cla: yes, flutterfire)

[1369](https://github.com/flutter/plugins/pull/1369) [webview_flutter] Refactor WebViewController to have a reference to the widget, to minimize necessary update calls. (cla: yes)

[1372](https://github.com/flutter/plugins/pull/1372) [image_picker] fix "Cancel button not visible in gallery, if camera was accessed first" (bugfix, cla: yes)

[1373](https://github.com/flutter/plugins/pull/1373) [shared_preferences] Add contains method (cla: yes, feature)

[1374](https://github.com/flutter/plugins/pull/1374) Update CONTRIBUTING.md with test info (cla: yes)

[1375](https://github.com/flutter/plugins/pull/1375) Add pull request template (cla: yes)

[1377](https://github.com/flutter/plugins/pull/1377) [firebase_admob] Update documentation to add iOS Admob ID & add iOS Admob ID in example project (cla: yes, documentation, flutterfire)

[1378](https://github.com/flutter/plugins/pull/1378) [firebase_crashlytics] Support compatibility with Swift plugins (cla: yes)

[1379](https://github.com/flutter/plugins/pull/1379) [firebase_crashlytics] Upgrade dependencies (cla: yes)

[1380](https://github.com/flutter/plugins/pull/1380) [in_app_purchase]load purchase (cla: yes, feature)

[1381](https://github.com/flutter/plugins/pull/1381) [in_app_purchase] Iap refactor (cla: yes)

[1384](https://github.com/flutter/plugins/pull/1384) Send success result for `AlarmService.initialized` method call (cla: yes)

[1385](https://github.com/flutter/plugins/pull/1385) [firebase_crashlytics]Remove white spaces to make git happy (cla: yes)

[1386](https://github.com/flutter/plugins/pull/1386) [google_maps_flutter] Add failing test verifying that only changed markers are updated (cla: yes)

[1387](https://github.com/flutter/plugins/pull/1387) [cloud_firestore] Add metadata field to DocumentSnapshot (cla: yes, feature, flutterfire)

[1388](https://github.com/flutter/plugins/pull/1388) [firebase_crashlytics] Add firebase_crashlytics for Readme. (cla: yes, documentation, flutterfire)

[1393](https://github.com/flutter/plugins/pull/1393) [camera] Fixes (#29925) (bugfix, cla: yes)

[1394](https://github.com/flutter/plugins/pull/1394) Add Crashlytics plugin to FlutterFire docs (cla: no, flutterfire, submit queue)

[1395](https://github.com/flutter/plugins/pull/1395) Add Crashlytics plugin to opensource list (cla: yes, flutterfire, submit queue)

[1398](https://github.com/flutter/plugins/pull/1398) [firebase_auth]Fix PhoneCodeAuthRetrievalTimeout callback never called (bugfix, cla: yes, flutterfire)

[1404](https://github.com/flutter/plugins/pull/1404) Bump version to 0.4.1+5 (cla: yes)

[1405](https://github.com/flutter/plugins/pull/1405) [firebase_messaging] Additional step for iOS (cla: yes, documentation, flutterfire)

[1406](https://github.com/flutter/plugins/pull/1406) [webview_flutter] Add initial e2e tests (cla: yes, feature, webview)

[1407](https://github.com/flutter/plugins/pull/1407) [firebase_crashlytics] Update README code example (cla: yes, documentation, flutterfire)

[1409](https://github.com/flutter/plugins/pull/1409) [google_maps] Add initial google_maps tests (cla: yes)

[1410](https://github.com/flutter/plugins/pull/1410) [android_alarm_manager] add type params for invokeMethod calls. (cla: yes)

[1411](https://github.com/flutter/plugins/pull/1411) [android_intent] add type params for invokeMethod calls. (cla: yes, feature)

[1412](https://github.com/flutter/plugins/pull/1412) [Battery]add type params for invokeMethod calls. (cla: yes)

[1413](https://github.com/flutter/plugins/pull/1413) [Camera]add type params for invokeMethod calls. (cla: yes)

[1414](https://github.com/flutter/plugins/pull/1414) [Cloud_firestore]add type params for invokeMethod calls. (cla: yes)

[1416](https://github.com/flutter/plugins/pull/1416) [Connectivity]add type params for invokeMethod calls. (cla: yes, feature)

[1418](https://github.com/flutter/plugins/pull/1418) [firebase_crashlytics] Rely on firebase_core to set up Firebase Analytics dependency (bugfix, cla: yes, flutterfire)

[1420](https://github.com/flutter/plugins/pull/1420) [webview_flutter] Use a pumpWidget utility in e2e tests (cla: yes)

[1421](https://github.com/flutter/plugins/pull/1421) [in_app_purchase]make payment unified APIs (cla: yes, feature)

[1424](https://github.com/flutter/plugins/pull/1424) [google_maps_flutter] Add a key parameter to the GoogleMap widget (cla: yes)

[1427](https://github.com/flutter/plugins/pull/1427) [firebase_crashlytics] Do not break debug log formatting. (cla: yes, flutterfire)

[1428](https://github.com/flutter/plugins/pull/1428) [firebase_analytics] Added Navigator.pushReplacement screen tracking (bugfix, cla: yes, feature, flutterfire)

[1429](https://github.com/flutter/plugins/pull/1429) Make sure to post javascript channel messages from the platform thread. (cla: yes)

[1430](https://github.com/flutter/plugins/pull/1430) [google_maps] Maps zoom level tests (cla: yes)

[1434](https://github.com/flutter/plugins/pull/1434) [google_map] Test zoom gestures enabled (cla: yes)

[1435](https://github.com/flutter/plugins/pull/1435) [cloud_firestore] Remove usage of `invokeMapMethod` (cla: yes)

[1436](https://github.com/flutter/plugins/pull/1436) Fix formatting in main.dart of firebase_database, firebase_storage, google_sign_in, shared_preference (cla: yes)

[1437](https://github.com/flutter/plugins/pull/1437) [firebase_crashlytics] Fix to Initialize Fabric (cla: yes, submit queue)

[1438](https://github.com/flutter/plugins/pull/1438) [google_sign_in] Handle `null` check in example app (cla: yes)

[1439](https://github.com/flutter/plugins/pull/1439) [battery] Update example in README.md (cla: yes)

[1440](https://github.com/flutter/plugins/pull/1440) [image_picker] Check camera permissions and return error (cla: yes)

[1441](https://github.com/flutter/plugins/pull/1441) [google_maps] Update android gradle version (cla: yes)

[1442](https://github.com/flutter/plugins/pull/1442) [google_maps] Add tests for rotate tilt and zoom gestures (cla: yes)

[1443](https://github.com/flutter/plugins/pull/1443) [firebase_core] Use Gradle BoM with firebase_core (cla: yes, flutterfire)

[1444](https://github.com/flutter/plugins/pull/1444) [firebase_crashlytics] Added a simple integration test (cla: yes)

[1445](https://github.com/flutter/plugins/pull/1445) [Image_picker]Android: fix original image deleted after scaling. (cla: yes)

[1447](https://github.com/flutter/plugins/pull/1447) Update changelog and pubspec for onTap (cla: yes)

[1448](https://github.com/flutter/plugins/pull/1448) [in_app_purchase] Add references to the original object for PurchaseDetails and ProductDetails (cla: yes)

[1453](https://github.com/flutter/plugins/pull/1453) [cloud_firestore] Use Gradle BoM with cloud_firestore (cla: yes)

[1455](https://github.com/flutter/plugins/pull/1455) [connectivity]Added integration test. (cla: yes, submit queue)

[1458](https://github.com/flutter/plugins/pull/1458) [firebase_auth] AuthCredential for email and link (cla: yes)

[1462](https://github.com/flutter/plugins/pull/1462) Remove BoM to avoid Gradle issues (cla: yes)

[1464](https://github.com/flutter/plugins/pull/1464) [firebase_core] fix BoM-related build incompatibility regression (cla: yes)

[1465](https://github.com/flutter/plugins/pull/1465) Integration tests for cloud_firestore and firebase_database transactions (cla: yes, flutterfire)

[1466](https://github.com/flutter/plugins/pull/1466) [cloud_firestore]remove white spaces. (cla: yes)

[1467](https://github.com/flutter/plugins/pull/1467) [cloud_firestore]remove blank line. (cla: yes)

[1468](https://github.com/flutter/plugins/pull/1468) Migrate firebase messaging plugin away from token (cla: yes)

[1470](https://github.com/flutter/plugins/pull/1470) [video_player] Android: Added missing event.put("event", "completed"); (bugfix, cla: yes)

[1471](https://github.com/flutter/plugins/pull/1471) [image_picker] Fix invalid path being returned from Google Photos (bugfix, cla: yes)

[1472](https://github.com/flutter/plugins/pull/1472) [Google_map]Enable iOS a11y by default. (cla: yes)

[1473](https://github.com/flutter/plugins/pull/1473) [package_info] Integration tests. (cla: yes)

[1474](https://github.com/flutter/plugins/pull/1474) [in_app_purchase]remove SKDownloadWrapper and related code. (cla: yes)

[1476](https://github.com/flutter/plugins/pull/1476) [cloud_firestore] support for pagination using startAtDocument, endAtDocument, etc. (cla: no, flutterfire)

[1477](https://github.com/flutter/plugins/pull/1477) [camera] Remove activity lifecycle (cla: yes, submit queue)

[1478](https://github.com/flutter/plugins/pull/1478) [google_maps_flutter] Add a bitmap descriptor that is aware of scale (cla: yes)

[1479](https://github.com/flutter/plugins/pull/1479) Adding links to the firebase_analytics  example (cla: yes)

[1483](https://github.com/flutter/plugins/pull/1483) [Image_picker] ios minimum deployment target to 8.0. (cla: yes)

[1484](https://github.com/flutter/plugins/pull/1484) [video_player] Explicitly indicate that self should be retained (cla: yes)

[1485](https://github.com/flutter/plugins/pull/1485) Fix unused vars and rename (cla: yes)

[1486](https://github.com/flutter/plugins/pull/1486) [firebase_performance] Firebase Performance integration tests (cla: yes)

[1487](https://github.com/flutter/plugins/pull/1487) [firebase_auth] Migrate FlutterAuthPlugin from deprecated APIs (cla: yes, flutterfire)

[1488](https://github.com/flutter/plugins/pull/1488) [image_picker]version fix. (cla: yes)

[1489](https://github.com/flutter/plugins/pull/1489) BitmapDescriptor#fromBytes should be consistent across platforms (cla: yes)

[1490](https://github.com/flutter/plugins/pull/1490) [firebase_analytics] Fixes errors in firebase_analytics docs (cla: yes)

[1491](https://github.com/flutter/plugins/pull/1491) [cloud_firestore] Support for atomic FieldValue.increment (cla: yes, feature, flutterfire)

[1492](https://github.com/flutter/plugins/pull/1492) [firebase_analytics] Initial integration test (cla: yes, flutterfire)

[1493](https://github.com/flutter/plugins/pull/1493) [android_alarm_manager] Added comments and refactored android_alarm_manager plugin for clarity. (cla: yes)

[1495](https://github.com/flutter/plugins/pull/1495) [in_app_purchase ]add cyanglaz to code owner. (cla: yes)

[1496](https://github.com/flutter/plugins/pull/1496) Add myself to video_player CODEOWNERS (cla: yes)

[1501](https://github.com/flutter/plugins/pull/1501) [webview_flutter] Fixed documentation for usage example of JavaScript message (cla: yes)

[1502](https://github.com/flutter/plugins/pull/1502) [connectivity] Fixes lint error by using getApplicationContext() (cla: yes)

[1503](https://github.com/flutter/plugins/pull/1503) Update firebase_auth CocoaPod dependency (cla: yes)

[1504](https://github.com/flutter/plugins/pull/1504) [firebase_storage] Return error when failing to read file (bugfix, cla: yes, flutterfire)

[1505](https://github.com/flutter/plugins/pull/1505) [image_picker] Fix path of returned File objects when picking videos (bugfix, cla: yes)

[1506](https://github.com/flutter/plugins/pull/1506) [firebase_ml_vision] Start of ML Kit integration tests (cla: yes)

[1508](https://github.com/flutter/plugins/pull/1508) [firebase_auth] Increase iOS Firebase/Auth CocoaPods dependency to 5.19 (cla: yes)

[1509](https://github.com/flutter/plugins/pull/1509) [Image_picker] Android: fix a crash when the MainActivity is destroyed after selecting the image/video.  (cla: yes)

[1511](https://github.com/flutter/plugins/pull/1511) [webview_flutter]bugfix:webview example should be statefulWidget (cla: yes)

[1512](https://github.com/flutter/plugins/pull/1512) [Image_picker] retrieve lost image. (cla: yes)

[1513](https://github.com/flutter/plugins/pull/1513) [firebase_storage] Initial integration testing (cla: yes)

[1514](https://github.com/flutter/plugins/pull/1514) [firebase_remote_config] Initial integration tests (cla: yes, flutterfire)

[1516](https://github.com/flutter/plugins/pull/1516) [webview_flutter] controller headers loadurl (cla: yes)

[1517](https://github.com/flutter/plugins/pull/1517) [in_app_purchase] Rename the unified API (cla: yes)

[1519](https://github.com/flutter/plugins/pull/1519) [image_picker] request camera permission if need (cla: yes)

[1520](https://github.com/flutter/plugins/pull/1520) [cloud_functions] update Dart API to replace call with getHttpsCallable (cla: yes, feature, flutterfire)

[1523](https://github.com/flutter/plugins/pull/1523) [firebase_performance] Deprecate incrementCounter in favor of incrementMetric (cla: yes)

[1527](https://github.com/flutter/plugins/pull/1527) Some additions to CODEOWNERS (cla: yes)

[1528](https://github.com/flutter/plugins/pull/1528) [webview_flutter] Remove un-used method params (cla: yes)

[1531](https://github.com/flutter/plugins/pull/1531) [image_picker] example app video load error fix. (bugfix, cla: yes)

[1532](https://github.com/flutter/plugins/pull/1532) [firebase_messaging] remove obsolete docs instruction (cla: yes, flutterfire)

[1533](https://github.com/flutter/plugins/pull/1533) [image_picker] version fix. (cla: yes)

[1534](https://github.com/flutter/plugins/pull/1534) [webview_flutter] Skip loadUrlWithHeaders test (cla: yes)

[1535](https://github.com/flutter/plugins/pull/1535) [webview_flutter] Test: wait for page to load before checking the content (cla: yes)

[1536](https://github.com/flutter/plugins/pull/1536) [in_app_purchase] Minor doc updates (cla: yes)

[1537](https://github.com/flutter/plugins/pull/1537) [in_app_purchase] Add auto-consume errors to PurchaseDetails (cla: yes)

[1539](https://github.com/flutter/plugins/pull/1539) [firebase_ml_vision] Update Firebase ML Vision documentation (cla: yes, documentation, flutterfire, submit queue)

[1540](https://github.com/flutter/plugins/pull/1540) [in_app_purchase] Only fetch owned purchases (cla: yes)

[1541](https://github.com/flutter/plugins/pull/1541) [image_picker] correct suffix on android. (cla: yes)

[1542](https://github.com/flutter/plugins/pull/1542) [video_player] Android: Fix ide warnings in video_player (cla: yes)

[1543](https://github.com/flutter/plugins/pull/1543) [cloud_firestore] Fix wrong FieldValue (cla: yes)

[1544](https://github.com/flutter/plugins/pull/1544) [image_picker]fix license format. (cla: yes)

[1545](https://github.com/flutter/plugins/pull/1545) [firebase_ml_vision] [share] Fix analyzer warnings from const Rect constructor. (cla: yes)

[1549](https://github.com/flutter/plugins/pull/1549) [google_maps_flutter] Support Color's alpha channel when converting to UIColor on iOS (cla: yes)

[1552](https://github.com/flutter/plugins/pull/1552) [video_player] Fix player initialization and other warnings (cla: yes)
