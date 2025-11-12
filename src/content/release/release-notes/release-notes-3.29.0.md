---
title: Flutter 3.29.0 release notes
shortTitle: 3.29.0 release notes
description: Release notes for Flutter 3.29.0.
skipTemplateRendering: true
---

This page has release notes for 3.29.0.
For information about subsequent bug-fix releases,
check out the Flutter [CHANGELOG][].

[CHANGELOG]: https://github.com/flutter/flutter/blob/main/CHANGELOG.md

## Flutter framework

### Framework

* Remove `gradle_deprecated_settings` test app, and remove reference from lockfile exclusion yaml by @gmackall in 161622
* Check that localization files of stocks app are up-to-date by @goderbauer in 161608
* [deps] remove no-longer-used repo deps by @devoncarew in 161605
* Fix `showLicensePage` does not inherit ambient `Theme` by @TahaTesser in 161599
* Roll Packages from 3c3bc6832b39 to d1fd6232ec33 (4 revisions) by @engine-flutter-autoroll in 161597
* Remove unused method by @robert-ancell in 161572
* update changelog for 3.27.2 release by @christopherfujino in 161569
* Roll Dart to  Version 3.7.0-323.0.dev by @a-siva in 161567
* Update changelog for 3.27.2 release by @christopherfujino in 161566
* Replace `fetch `with `gclient sync`. by @matanlurey in 161565
* [Impeller] fixes for AHB swapchains. by @jonahwilliams in 161562
* Last Engine<>Framework lint sync by @goderbauer in 161560
* Reverts "Match CupertinoPageTransitionsBuilder animation duration to CupertinoPageRoute (#160241)" by @auto-submit[bot] in 161555
* [DisplayList] remove obsolete use of Skia geometry objects in DL utils by @flar in 161553
* Mark `Mac_mokey microbenchmarks` as flakey by @jtmcdole in 161550
* Use wildcards by @goderbauer in 161548
* [canvaskit] Fix GIF decode failure by @harryterkelsen in 161536
* Copy `linux_host_engine` as `linux_host_engine_test`, removing `archives: [...]`. by @matanlurey in 161532
* Remove last two references to Cirrus CI. by @matanlurey in 161530
* Remove references to `cirrus`, mostly in doc comments. by @matanlurey in 161529
* Add route settings to CupertinoSheetRoute by @MitchellGoodwin in 161528
* Remove `WEB_SHARD_COUNT`, which no longer exists post-Cirrus. by @matanlurey in 161527
* Update package revisions to latest by @bkonyi in 161525
* [flutter_releases] Flutter stable 3.27.2 Framework Cherrypicks by @christopherfujino in 161524
* Roll Packages from 65547511c004 to 3c3bc6832b39 (16 revisions) by @engine-flutter-autoroll in 161515
* Fix paths when running clang-tidy on git diffs by @flar in 161496
* [SwiftPM] Make 'flutter build ios-framework' generate an empty Package.swift by @loic-sharma in 161464
* Migrate DisplayList unit tests to DL/Impeller geometry classes by @flar in 161453
* Propagate environment variables when `flutter drive` is invoked. by @matanlurey in 161452
* Context menu button callback docs clarification by @justinmc in 161451
* Explain more specifically how to use `flutter drive`/what it does by @matanlurey in 161450
* [android_engine_test] Remove background/foreground from surface texture trampoline test. by @jonahwilliams in 161441
* [Impeller] remove API 30 restriction for SurfaceControl testing. by @jonahwilliams in 161438
* FixForward: method was renamed by @jtmcdole in 161431
* Update InputDecoration.border documentation by @bleroux in 161415
* [Engine] Support asymmetrical rounded superellipses by @dkwingsmt in 161409
* Udpate documentation on the third_party directories by @jtmcdole in 161407
* Move the analyzer_benchmark to Mac arm64 devicelab bots by @jason-simmons in 161405
* integration_test: Add gitignore of golden image by @cbracken in 161404
* Fix link to engine docs in CONTRIBUTING.md by @goderbauer in 161401
* We no longer have a separate engine repo. by @matanlurey in 161400
* Remove Cirrus CI from Flutter goldens. by @matanlurey in 161396
* Roll Dart to Version 3.7.0-312.0.dev by @a-siva in 161394
* Replace the always omitted `CPU` environment variable with `numberOfProcessors`. by @matanlurey in 161392
* Remove `CIRRUS_TASK_NAME` from what I can tell, is always omitted on `LUCI` by @matanlurey in 161391
* Remove some miscellaneous references to Cirrus. by @matanlurey in 161390
* Remove seemingly stale web Cirrus and "Web Installer" instructions by @matanlurey in 161389
* Remove `accept_android_sdk_licenses.sh`, which appears unused. by @matanlurey in 161388
* Roll Packages from 3fc6b7ace3ff to 65547511c004 (11 revisions) by @engine-flutter-autoroll in 161379
* Fix crash when closing a window with `Alt+F4` in multi-win Flutter on Windows by @hbatagelo in 161375
* [web:a11y] treat empty tappables as buttons by @yjbanov in 161360
* Provide monitor information. by @robert-ancell in 161359
* Exclude `*texture*` as matching for `a: text input` by @matanlurey in 161354
* [Impeller] add opt in flag for SurfaceControl testing. by @jonahwilliams in 161353
* Add a virtual-display (VD) platform view test, and refactor tests a bit. by @matanlurey in 161349
* remove formatter from snippet tool by @goderbauer in 161347
* Update Style-guide-for-Flutter-repo.md by @goderbauer in 161344
* [Android] Actually remove dev dependencies from release builds by @camsim99 in 161343
* Revert "[SwiftPM] Add separate feature flag for the app migration (#158897)" by @loic-sharma in 161342
* git ignore .ccls-cache by @flar in 161340
* Reverts "[SwiftPM] Turn on by default (#161275)" by @auto-submit[bot] in 161339
* [Impeller] fix scaling of trampoline import of GLES textures into Vulkan. by @jonahwilliams in 161331
* [CP-stable] Revert "fixed keyboardDismissBehavior on scroll without a drag"  by @victorsanni in 161329
* [Impeller] reland: fix porterduff shader and handle optimized out texture binding in GLES backend. by @jonahwilliams in 161326
* Reverts "[Impeller] porter duff workarounds for Adreno GPU. (#161273)" by @auto-submit[bot] in 161318
* Marks Linux analyzer_benchmark to be flaky by @fluttergithubbot in 161307
* Marks Linux linux_desktop_impeller to be unflaky by @fluttergithubbot in 161302
* Revert "use uuid from package:uuid instead of from package:usage" by @jiahaog in 161292
* [Impeller] re-enable Adreno 630 by @jonahwilliams in 161287
* Roll Dart to Version 3.7.0-307.0.dev by @a-siva in 161278
* Revert "fixed keyboardDismissBehavior on scroll without a drag" by @victorsanni in 161277
* Support DDC library bundle format and remove support for DDC module format by @srujzs in 161276
* [SwiftPM] Turn on by default by @loic-sharma in 161275
* [Impeller] disable input attachment / self dependency on Adreno 630 and older. by @jonahwilliams in 161274
* [Impeller] porter duff workarounds for Adreno GPU. by @jonahwilliams in 161273
* Make the encoding of a `YamlNode` to a `String` more explicit. by @matanlurey in 161270
* Clear selection state when exiting select mode by @elliette in 161267
* Rename `native_driver` to `android_{driver_extensions|engine_test}` by @matanlurey in 161263
* add semantics role and tab by @chunhtai in 161260
* [Impeller] disable runtime mipmap generation on Adreno. by @jonahwilliams in 161257
* Added special case for fat width arcs by @gaaclarke in 161255
* [Impeller] Update README on preview status on Android. by @chinmaygarde in 161253
* Change timing of `onSurfaceDestroyed` to match `onSurfaceCleanup` by @matanlurey in 161252
* [Impeller] Update guidance on prebuilt artifacts. by @chinmaygarde in 161251
* Move validation logic for `.ci.yaml` to `flutter/flutter`. by @matanlurey in 161249
* [deps] remove references to archived repos by @devoncarew in 161248
* Roll Packages from 07ae98c5aff9 to 3fc6b7ace3ff (3 revisions) by @engine-flutter-autoroll in 161244
* Stamp golden files to verify engine Skia Gold is WAI. by @matanlurey in 161240
* Fixed repeated strings for incompatible Gradle or AGP version in `create` command by @kishan-dhankecha in 161223
* Migrate engine labeler to top level by @jmagman in 161212
* Remove `verbose: true` from `canvas_test.dart`. by @matanlurey in 161211
* [flutter_tools] ignore viewpost ime and samsung spam messages. by @jonahwilliams in 161199
* Proposal to deprecate `webGoldenComparator`. by @matanlurey in 161196
* [Impeller] dont generate final 1x1 mip level to work around Adreno GPU bug by @jonahwilliams in 161192
* Scale any clip path by 1 / DPR. by @eyebrowsoffire in 161190
* Rename `shellPath` to `flutterTesterBinPath`. by @matanlurey in 161189
* Fold `_FlutterTestRunnerImpl` into `FlutterTestRunner`. by @matanlurey in 161188
* [Engine] Make `SkiaGoldClient` a NOP when the branch is not `main` or `master`. by @matanlurey in 161187
* Update engine instructions for monorepo by @justinmc in 161184
* Update golden canary by @Piinks in 161183
* Updated eglConfigChoose error message and error clause. by @gaaclarke in 161178
* [CP-stable] Revert "Fix DropdownMenu does not rematch initialSelection when entries have changed" by @nate-thegrate in 161177
* Roll Packages from eb7358231e43 to 07ae98c5aff9 (29 revisions) by @engine-flutter-autoroll in 161174
* [Impeller] protect onscreen cmd buffer with render ready semaphore. by @jonahwilliams in 161140
* Fix broken link to Hot Reload gif in README by @bartekpacia in 161113
* Use the in-tree engine by default when using `--local-engine` or `--local-web-sdk` by @eyebrowsoffire in 161110
* Normalize the translation column of the color matrix. by @eyebrowsoffire in 161109
* Extract analyze test expectations from test fixture by @LongCatIsLooong in 161108
* Remove the word normalized, remove minimum/maximum. by @matanlurey in 161106
* Update `flutter_template_images` to `5.0.0`. by @matanlurey in 161105
* use uuid from package:uuid instead of from package:usage by @devoncarew in 161102
* update repo to be forward compatible with shelf_web_socket v3.0 by @devoncarew in 161101
* Update error message for when leading/trailing width exceeds `ListTile` width and add missing test by @TahaTesser in 161091
* [native_assets] Filter hook environment by @dcharkes in 161084
* [Android] Add `.cxx` directories to app template `.gitignore` by @gmackall in 161069
* rev to the latest dart-lang/http and remove older http_multi_server refs by @devoncarew in 161067
* Bump characters, collection, meta by @goderbauer in 161066
* Mark firebase_release_smoke_test unflaky by @jmagman in 161006
* Update Create Pull Request GitHub workflow reviewers by @jmagman in 161005
* Bump peter-evans/create-pull-request from 7.0.5 to 7.0.6 in the all-github-actions group by @dependabot[bot] in 161001
* Mark hot_mode_dev_cycle_macos_target__benchmark unflaky by @jmagman in 161000
* Mark integration_ui_test_test_macos unflaky by @jmagman in 160999
* Mark hello_world_macos__compile unflaky by @jmagman in 160998
* Mark complex_layout_scroll_perf_macos__timeline_summary unflaky by @jmagman in 160997
* Mark animated_complex_opacity_perf_macos__e2e_summary unflaky by @jmagman in 160996
* Update GitHub URL for failing android_semantics_integration_test bringup by @jmagman in 160993
* Mark analyzer_benchmark unflaky by @jmagman in 160991
* Mark flavors_test_macos unflaky by @jmagman in 160990
* Mark platform_channel_sample_test_macos unflaky by @jmagman in 160989
* Remove now-unnecessary command `felt analyze`. by @matanlurey in 160986
* Manual pub bump by @goderbauer in 160985
* `TestCompiler` emits why an error occurred, if applicable, and some refactors to do so by @matanlurey in 160984
* Omit hardcoded `--packages=.dart_tool/package_config.json`. by @matanlurey in 160982
* Revert: "Move `integration_test` dependencies to non-`dev_dependencies`." by @matanlurey in 160980
* Updating AVD Dependency for Android 28 Emulator by @jesswrd in 160978
* Remove support for imperative apply of Flutter Gradle Plugin by @bartekpacia in 160947
* Add `SurfaceProducer.onSurfaceCleanup`, deprecate `onSurfaceDestroyed`. by @matanlurey in 160937
* Fix docImport issues by @goderbauer in 160918
* Bump `flutter_template_images` to remove TODO. by @matanlurey in 160917
* Point to real Cocoon code in Tree-hygiene.md by @yjbanov in 160914
* Add missing DEPS to runIf by @mdebbar in 160913
* Improve Plugins That Reference V1 Embedding Error Message by @jesswrd in 160890
* Clarify where `gclient` is run from. by @chunhtai in 160889
* gclient template file clarifications by @yjbanov in 160882
* Tweak language post-merge of #160695. by @matanlurey in 160876
* apply dart_style 3.0.1 by @goderbauer in 160875
* adding my name to authors by @AbdeMohlbi in 160822
* Update docs on `Color` to be more clear about normalized channel values. by @matanlurey in 160798
* Remove bringup: true from web tests. by @eyebrowsoffire in 160788
* Consider changes to `DEPS` and `engine/**` to impact most runIf-guarded builds by @matanlurey in 160706
* Fix bash entrypoint tests by @jtmcdole in 160705
* Remove dependency on web_tests/artifacts. by @eyebrowsoffire in 160700
* [tech debt] delete unused framework-engine test scripts by @yjbanov in 160698
* Remove `--template=skeleton` and add a placeholder error message instead. by @matanlurey in 160695
* Annotate entrypoints in the "isolate spawner" files generated by `flutter test --experimental-faster-testing` by @derekxu16 in 160694
* [Impeller] move barrier setting out of render pass builder. by @jonahwilliams in 160693
* [flutter_tools] unconditionally skip bash test by @christopherfujino in 160690
* [Impeller] workarounds for slow Adreno primitive restart performance. by @jonahwilliams in 160683
* deprecate engine ci yaml roller by @christopherfujino in 160682
* Roll to dart 3.7.0-267.0.dev by @aam in 160680
* Update README.md by @goderbauer in 160677
* Enable strict_top_level_inference by @goderbauer in 160674
* [native assets] Roll dependencies by @dcharkes in 160672
* Ensure engine.version is up to date in the monorepo by @jtmcdole in 160668
* Update New-Android-version.md to include create all by @reidbaker in 160661
* [Impeller] fix device buffer nullptr on Intel macOS. by @jonahwilliams in 160645
* Revert rematching DropdownMenu.initialSelection by @bleroux in 160643
* Refactor keyboard manager tests by @robert-ancell in 160637
* Allow async platform responses in FlMockBinaryMessenger by @robert-ancell in 160636
* Remove all remaining use of mock engine by @robert-ancell in 160635
* [Impeller] Fix GLES SurfaceTexture rendering. by @jonahwilliams in 160634
* [DisplayList] Migrate DlVertices onto Impeller/DisplayList geometry classes by @flar in 160633
* [monorepo] mark local engine builds as bringup. by @jonahwilliams in 160627
* Roll dart sdk to 3.7.0-266.0.dev by @aam in 160624
* [Impeller] remove unused BliPass::EncodeCommands arg and cleanup. by @jonahwilliams in 160623
* integration_test: Ignore .build dir for iOS/macOS by @cbracken in 160614
* [monorepo] Fix tech debt cost benchmark by @jonahwilliams in 160609
* Auto-format Dart code in engine by @goderbauer in 160576
* Upstream and Origin check by @jtmcdole in 160574
* [tech debt] remove web engine windows build by @yjbanov in 160573
* `ImplicitlyAnimatedWidgetState` code cleanup by @nate-thegrate in 160567
* Change CRLF line endings to LF to match the `.gitattributes` expectations. by @matanlurey in 160557
* Use `flutter` repo for engine golds instead of `flutter-engine`. by @matanlurey in 160556
* Turn deprecation message analyze tests back on by @LongCatIsLooong in 160554
* Split build and test builders for web engine by @eyebrowsoffire in 160550
* Delete unused `engine_hash.dart` script (and test), simplify `engine_hash.sh`. by @matanlurey in 160549
* Update DEPS, remove `upstream-buildroot` by @matanlurey in 160548
* Auto-format Framework by @goderbauer in 160545
* Commit engine.realm as empty by @jtmcdole in 160541
* remove`useMaterial3: true,` in from the template by @lsaudon in 160525
* 🔊 [tool] Add a wirelessly connected device name as `displayName` by @AlexV525 in 160497
* Marks Mac_benchmark flutter_gallery_macos__compile to be flaky by @fluttergithubbot in 160496
* Implement golden-file matching for `integration_test` on Android and iOS devices by @matanlurey in 160484
* Trigger Build Part Deux by @jtmcdole in 160481
* Trigger Build by @jtmcdole in 160476
* [monorepo] remove realm checker by @yjbanov in 160457
* [flutter_tool] Change the startup message for the "flutter daemon" command by @DanTup in 160444
* Allow integration test helpers to work on substrings instead of whole strings by @mkustermann in 160437
* [native_assets] Preparation existing tests for future of other (i.e. non-Code) assets by @mkustermann in 160436
* 🐛 [tool] Installs the APK regardless of version by @AlexV525 in 160432
* Add more entry-point annotations for test-only code. by @sstrickl in 160421
* Consistently set `Cache.flutterRoot` in `create_test.dart`. by @matanlurey in 160403
* Rename and define `FlutterManifest.generateLocalizations`. by @matanlurey in 160401
* Replace `--no-implicit-pubspec-resolution` with `flutter config --explicit-package-dependencies`. by @matanlurey in 160400
* Normalize localizations with dartfmt in presubmit check by @goderbauer in 160395
* Adjust tools tests that would be broken by formatting by @goderbauer in 160393
* Fix line-dependent tests for formatting by @goderbauer in 160389
* Adjust ignores for 'dart format' by @goderbauer in 160382
* Ignore cxx folders for all of flutter/flutter by @reidbaker in 160381
* Move `integration_test` dependencies to non-`dev_dependencies`. by @matanlurey in 160380
* Migrate `mac_test.dart` to `explicit-package-dependencies`. by @matanlurey in 160375
* Formatter pre-work: Fix syntax in test_fixes by @goderbauer in 160371
* Remove more references to deprecated package:usage (executable, runner) by @andrewkolos in 160369
* Skip integration tests that consistently OOM on a Windows platform. by @matanlurey in 160368
* Fix a bug to skip `flutter_gen` when synthetic packages are disabled by @matanlurey in 160367
* Properly report `dart format` errors by @goderbauer in 160364
* Roll Packages from 56886ffe11ad to eb7358231e43 (6 revisions) by @engine-flutter-autoroll in 160351
* Set java 11 as expected java version in all templates by @reidbaker in 160349
* Update PopInvokedCallback Deprecated message by @krokyze in 160324
* Added Mohammed Chahboun to authors by @M97Chahboun in 160311
* [flutter_releases] Flutter stable 3.27.1 Framework Cherrypicks by @itsjustkevin in 160293
* Migrate `test/commands.shard` (mostly) to `explicit-package-dependencies`. by @matanlurey in 160288
* Merges changes from stable changelog to master. by @itsjustkevin in 160284
* Migrate the rest of `general.shard` to `explicit-package-dependencies`. by @matanlurey in 160280
* Migrate `test/general.shard/*plugin*` tests to `explicit-package-dependencies`. by @matanlurey in 160279
* Migrate `resident_web_runner_test.dart` to `explicit-package-dependencies`. by @matanlurey in 160278
* Migrate `hot_test.dart` to `explicit-package-dependencies`. by @matanlurey in 160277
* Migrate `test/general.shard/build_system` to `explicit-package-dependencies`. by @matanlurey in 160275
* Migrate `flutter_command_test.dart` to `explicit-package-dependencies`. by @matanlurey in 160274
* Migrate `test/general.shard/web` to `explicit-package-dependencies`. by @matanlurey in 160273
* Migrate `generate_synthetic_packages_test.dart` to `explicit-package-dependencies`. by @matanlurey in 160267
* re-enable linux packages-autoroller by @christopherfujino in 160266
* Migrate `test_compiler_test.dart` to `explicit-package-dependencies`. by @matanlurey in 160265
* Migrate `cocoapods_test.dart` to `explicit-package-dependencies`. by @matanlurey in 160264
* [Reland] Force automatic ndk download when building for Android by @gmackall in 160260
* Enable `explicit-package-dependencies` (`resident_web_runner_cold_test.dart`) by @matanlurey in 160258
* Changelog update for stable branch. by @itsjustkevin in 160253
* Add `mouseCursor` parameter to `ReorderableListView` by @ValentinVignal in 160246
* Roll Packages from cbdb48a0bcee to 56886ffe11ad (6 revisions) by @engine-flutter-autoroll in 160245
* Match CupertinoPageTransitionsBuilder animation duration to CupertinoPageRoute by @chika3742 in 160241
* Fix NavigationDrawerDestination backgroundColor obscures interactions by @bleroux in 160239
* 🐛 [tool] Do not handle directory arguments implicitly for `pub` commands by @AlexV525 in 160223
* Refactor `TestGoldenComparator` to be useful for non-web (Android, iOS) integration tests by @matanlurey in 160215
* Reverts "Force automatic ndk download when building for Android (#159756)" by @auto-submit[bot] in 160205
* Fix `Stepper` connector not being properly displayed by @nate-thegrate in 160193
* [web] Make `FLUTTER_WEB_AUTO_DETECT` false by default by @mdebbar in 160191
* [web] Enable platform view benchmarks in Skwasm by @mdebbar in 160186
* Manual pub roll with flutter_tools patch by @bkonyi in 160174
* Roll Packages from 16616ad588d7 to cbdb48a0bcee (4 revisions) by @engine-flutter-autoroll in 160170
* Add entry-point annotations for test-only code. by @sstrickl in 160158
* [flutter_releases] Flutter beta 3.28.0-0.1.pre Framework Cherrypicks by @itsjustkevin in 160112
* Fix regression to hardcoded AGP/Kotlin values in Android module templates by @gmackall in 160108
* Update changelog with 3.27 changes by @christopherfujino in 160105
* Roll Packages from 0f1fd493b893 to 16616ad588d7 (2 revisions) by @engine-flutter-autoroll in 160099
* Don't throw `StateError` when listing core devices during tool shutdown by @bkonyi in 160094
* [CP-stable]Migrate module templates to declarative application of the Flutter Gradle Plugin by @flutteractionsbot in 160090
* Add `submenuIcon` property to override the default `SubmenuButton` arrow icon by @TahaTesser in 160086
* Marks Linux android_release_builds_exclude_dev_dependencies_test to be unflaky by @fluttergithubbot in 160074
* Fix analytics enabled/disabled event not being sent when the user enables/disables analytics by @andrewkolos in 160060
* precompile generate_gradle_lockfile script BEFORE updating pub dependencies by @christopherfujino in 160059
* mark Linux packages_autoroller bringup by @christopherfujino in 160056
* Conductor output updates by @christopherfujino in 160054
* Adds splashBorderRadius property to TabBarTheme by @M97Chahboun in 160046
* [flutter_releases] Flutter stable 3.27.0 Framework Cherrypicks by @christopherfujino in 160045
* Revert "Framework sends a11y message when enabling semantics (#159163)" by @chunhtai in 160039
* Adds onHover and onLongPress to IconButton widget by @M97Chahboun in 160032
* Roll Packages from 45bcc3210fcc to 0f1fd493b893 (4 revisions) by @engine-flutter-autoroll in 160028
* Deprecate unused `ButtonStyleButton.iconAlignment` property by @TahaTesser in 160023
* Add script to check format of changed dart files by @goderbauer in 160007
* Ignore codecov/codecov-action patch version updates by @jmagman in 159996
* Bump codecov/codecov-action from 5.0.2 to 5.1.1 in the all-github-actions group across 1 directory by @dependabot[bot] in 159995
* Pin pkg:intl to 0.19.0 by @goderbauer in 159992
* Roll Packages from bc0c22d57910 to 45bcc3210fcc (20 revisions) by @engine-flutter-autoroll in 159978
* 🚀 Implements `globalPosition` and `localPosition` for `TapDragEndDetails` by @AlexV525 in 159962
* Adjust the drawing position of OutlineInputBorder by @hgraceb in 159943
* Add `mouseCursor` to `Tooltip` by @ValentinVignal in 159922
* [Web] Allow specifying the strategy on when to use <img> element to display images by @dkwingsmt in 159917
* Revert: Fix DropdownMenu rendered behind AppBar by @dkwingsmt in 159907
* Add support for injecting assets into the widget_preview_scaffold by @bkonyi in 159859
* [flutter_tools] configure shader compiler to output GLES3 shaders for Android. by @jonahwilliams in 159857
* Configure Page Width by @goderbauer in 159856
* [CP-beta]Add deprecation notice for Android x86 when building for the target by @flutteractionsbot in 159847
* Reland Fix Date picker overlay colors aren't applied on selected state by @bleroux in 159839
* [ci] Add google_adsense to 9_first_party_packages.yml by @ditman in 159827
* `CupertinoTextField` accessibility behavior on Linux should match `TextField` by @Renzo-Olivares in 159823
* Bump Dart SDK to 3.7 by @goderbauer in 159812
* Add handler for `SemanticsAction.scrollToOffset` by @LongCatIsLooong in 159811
* Updated Material 3 `Slider` Samples by @TahaTesser in 159795
* Fix `RangeSlider` thumb doesn't align with divisions, thumb padding, and rounded corners by @TahaTesser in 159792
* Reland Fix InkWell overlayColor resolution ignores selected state by @bleroux in 159784
* Migrate module templates to declarative application of the Flutter Gradle Plugin by @gmackall in 159770
* Increase timeout of Devtools tests by @Piinks in 159759
* Force automatic ndk download when building for Android by @gmackall in 159756
* Add deprecation notice for Android x86 when building for the target by @bkonyi in 159750
* Introduce Material 3 `year2023` flag to `SliderThemeData` by @TahaTesser in 159721
* Introduce Material 3 `year2023` flag to `ProgressIndicatorThemeData` by @TahaTesser in 159720
* Make native asset tests more robust against flutter upgrading its pinned dependencies by @mkustermann in 159715
* Remove some usages of package:usage by @andrewkolos in 159705
* [Widget Inspector] Only include `truncated` field in JSON response if `true` by @elliette in 159701
* fix: SelectableRegion should only finalize selection after changing by @Renzo-Olivares in 159698
* Format controller.dart of flutter_test by @hgraceb in 159667
* Fix DropdownMenu menu is detached from the text field by @bleroux in 159665
* Roll Packages from e6932b77a183 to bc0c22d57910 (2 revisions) by @engine-flutter-autoroll in 159592
* Revert "Fix InkWell overlayColor resolution ignores selected state (#159072) by @bleroux in 159589
* Revert "Fix Date picker overlay colors aren't applied on selected sta… by @bleroux in 159583
* Roll Packages from 8ecf4b010143 to e6932b77a183 (3 revisions) by @engine-flutter-autoroll in 159561
* Marks Mac_benchmark hello_world_macos__compile to be flaky by @fluttergithubbot in 159543
* Marks Mac_benchmark flutter_view_macos__start_up to be flaky by @fluttergithubbot in 159541
* Marks Linux_android_emu android_defines_test to be unflaky by @fluttergithubbot in 159538
* Ignore exhaustiveness check for some semantics tests, for now by @LongCatIsLooong in 159517
* Add `flutter widget-preview {start, clean}` commands by @bkonyi in 159510
* iPad Scribble flicker and crash by @justinmc in 159508
* [SwiftPM] Rename `SWIFT_PACKAGE_MANAGER` environment variable to `FLUTTER_SWIFT_PACKAGE_MANAGER` by @loic-sharma in 159502
* Reverts "Roll Flutter Engine from fe45a6608651 to fb6439918252 (12 revisions) (#159461)" by @auto-submit[bot] in 159498
* Roll Packages from 46aeb2b29d60 to 8ecf4b010143 (5 revisions) by @engine-flutter-autoroll in 159489
* Fix DropdownButtonFormField overlay colors management by @bleroux in 159472
* [Widget Inspector] Fix stack overflow error for Flutter web when requesting a large widget tree by @elliette in 159454
* Refactor gradle task runner to share error handler code by @chunhtai in 159452
* Update comment in analysis_options.yaml by @goderbauer in 159449
* Roll dartdoc to 8.3.0 by @goderbauer in 159448
* fix failing lint in MainActivity.kt.tmpl by @AbdeMohlbi in 159441
* Reverts "Update `image_filter_test` and `color_filter_test.dart` for Material 3 (#158985)" by @auto-submit[bot] in 159437
* [CP-beta]Do not rely on Leader/Follower to position DropdownMenu menu by @flutteractionsbot in 159436
* [ Tool ] Fix "Error: Unable to find git in your PATH" when Command Processor `AutoRun` registry key is defined by @bkonyi in 159424
* Add `mouseCursor` parameter to `Chip`s by @ValentinVignal in 159422
* Roll Packages from 920321356e45 to 46aeb2b29d60 (3 revisions) by @engine-flutter-autoroll in 159420
* Fix a failing test missed in #159108 by @LongCatIsLooong in 159407
* Test `SliverMainAxisGroup` offstage child by @yiiim in 159406
* Fix typo in flutter_command.dart by @TheJoeSchr in 159398
* [tool] Fix android tests using outdated regexs to modify templates by @Sameri11 in 159396
* Fix false positive validation result on form submission with AutovalidateMode.onUnfocus by @Mairramer in 159394
* Added spellCheckConfiguration to the constructor of CupertinoTextFormFieldRow by @sargntpi in 159385
* Reverts "Roll Flutter Engine from 6f941c961b05 to 202506d686e3 (10 revisions) (#159345)" by @auto-submit[bot] in 159360
* Reverts "Roll Flutter Engine from 202506d686e3 to 9384df4425fd (2 revisions) (#159348)" by @auto-submit[bot] in 159359
* Reland "Set stable color for semantics debugger (#157884)" by @chunhtai in 159355
* Reverts "Set stable color for semantics debugger (#157884)" by @auto-submit[bot] in 159354
* Click-and-dragging in widget selection mode updates the inspected widget in DevTools by @elliette in 159352
* Remove now unused `apk-health-tests`. Can always re-add in the future. by @matanlurey in 159349
* Replace `\r\n` code with Dart SDK standard conventions. by @matanlurey in 159346
* Fix `SafeArea` DartPad sample by @nate-thegrate in 159344
* Manually update strings after dca37ad, and turn `packages_autoroller` back on by @gmackall in 159343
* Roll Packages from 913b99ed8542 to 920321356e45 (9 revisions) by @engine-flutter-autoroll in 159338
* Move Linux packages_autoroller to bringup by @zanderso in 159336
* Fixed typos by @anisalibegic in 159331
* [native assets] Create `NativeAssetsManifest.json` instead of kernel embedding by @dcharkes in 159322
* [tool] Removes deprecated --web-renderer parameter. by @ditman in 159314
* Suppress previous route transition if current route is fullscreenDialog by @MitchellGoodwin in 159312
* Report usage of `deferred-components` to analytics. by @matanlurey in 159307
* remove unnecessary semicolon in module_plugin_loader.radle by @AbdeMohlbi in 159303
* Align comments in ` flutter_build_preview_sdk_test.dart` with build.gradle.kts usage by @AbdeMohlbi in 159299
* fix failing lint : `findByPath` requires a specific ordering of project evaluation in `flutter.groovy` by @AbdeMohlbi in 159296
* Improve UI-thread animation performance by @bernaferrari in 159288
* Add `columnWidth` Property to `DataTable` for Customizable Column Widths by @lamnhan066 in 159279
* Added additional logging to `_listCoreDevices` by @bkonyi in 159275
* Reland CupertinoPopupSurface by @davidhicks980 in 159272
* Introduce `CircularProgressIndicator.padding` for the updated M3 specs by @TahaTesser in 159271
* Roll Packages from e95f6d8fce58 to 913b99ed8542 (7 revisions) by @engine-flutter-autoroll in 159268
* Refactor bottom sheet & related widgets by @Pante in 159257
* Shut down DevTools and DDS processes if flutter_tools is killed by a signal by @jason-simmons in 159238
* Try a speculative fix for Gradle OOMs. by @matanlurey in 159234
* Add a simple golden-file test to `package:integration_test`. by @matanlurey in 159233
* Remove `RepaintBoundary` that is no longer needed. by @matanlurey in 159232
* Un-skip tests that use `flutter build apk`. by @matanlurey in 159231
* [flutter_tools] opt iOS/macOS apps out of Metal API validation via migrator, update templates in repo. by @jonahwilliams in 159228
* Add docs for setting up Android Studio to auto format Kotlin code by @gmackall in 159209
* Fix Date picker overlay colors aren't applied on selected state by @bleroux in 159203
* Roll Packages from fc4adc78aa24 to e95f6d8fce58 (6 revisions) by @engine-flutter-autoroll in 159201
* Remove dependency on [Target] and instead operate on [Architecture] by @mkustermann in 159196
* Terminate non-detached test devices on `flutter run` completion by @matanlurey in 159170
* Do a clean shutdown of the flutter_tools processes started by observatory_port_test by @jason-simmons in 159169
* Add platform-android label for all flutter_tools *android* files by @jmagman in 159166
* Framework sends a11y message when enabling semantics by @chunhtai in 159163
* Make `runner` non-nullable as it always is. by @matanlurey in 159156
* [ tool ] Fix expression evaluation not handling errors correctly by @bkonyi in 159151
* Remove `firebase_abstract_method_smoke_test` by @jesswrd in 159145
* Roll Packages from c1eabf5e32cc to fc4adc78aa24 (10 revisions) by @engine-flutter-autoroll in 159143
* fix fialing lint `Consider using 'register' to avoid unnecessary configuration` by @AbdeMohlbi in 159137
* Terminate `flutter test` when no longer needed in integration test. by @matanlurey in 159117
* Terminate the test device if the `flutter` tool is signal-killed. by @matanlurey in 159115
* [SwiftPM] Move where the migration checks feature flags by @loic-sharma in 159110
* Temporarily change tests to accommodate new `SemanticsAction` value by @LongCatIsLooong in 159108
* Bump codecov/codecov-action from 4.6.0 to 5.0.2 in the all-github-actions group by @dependabot[bot] in 159104
* Add a tag and assert some state in FlutterTestDriver tests. by @matanlurey in 159099
* [CP-beta][ tool ] Don't throw StateError when DDS fails to start by @flutteractionsbot in 159079
* Roll Packages from b164be312ca2 to c1eabf5e32cc (6 revisions) by @engine-flutter-autoroll in 159077
* Fix InkWell overlayColor resolution ignores selected state by @bleroux in 159072
* Removing redundant backticks in `flutter\packages\flutter_tools\gradle\gradle.kts` by @AbdeMohlbi in 159051
* Fix `--web-header` flag for `flutter drive` by @dtscalac in 159039
* Fix typo in gen_l10n_types.dart by @userFortyTwo in 159035
* Fix NavigationBar example overflow alignment by @yaostyle in 159034
* No longer download `android-x86-jit-release`. by @matanlurey in 159011
* [flutter triage] Update list of frequent web contributors by @yjbanov in 159008
* Define and use `flutterBin` consistently across `integration.shard`. by @matanlurey in 159007
* Style change in Flutter-Web-Triage.md by @yjbanov in 159006
* Switch `flutter_build_apk_health_tests` to use a subset of current tests. by @matanlurey in 159004
* Make the focus node on SelectableRegion optional. by @gspencergoog in 158994
* Reverts "Try running historically flaky tests first to make `flutter build apk` health tests time out more often? (#158967)" by @auto-submit[bot] in 158993
* Roll Packages from b9ac917daeb0 to b164be312ca2 (4 revisions) by @engine-flutter-autoroll in 158986
* Update `image_filter_test` and `color_filter_test.dart` for Material 3 by @TahaTesser in 158985
* Fix code asset copying logic in native asset code by @mkustermann in 158984
* Fix duplicate work in native assets release builds by @mkustermann in 158980
* Label PRs with gradle and Android paths "platform-android" by @jmagman in 158970
* Prettier merge_queue.md by @Piinks in 158969
* Try running historically flaky tests first to make `flutter build apk` health tests time out more often? by @matanlurey in 158967
* Further skip `native_assets_test`(s) that runs `flutter build apk`. by @matanlurey in 158966
* Stop generate both `.kts` and non-`.kts` gradle files for a test project. by @matanlurey in 158965
* Create merge_queue.md by @Piinks in 158959
* Add `--dry-run` to `dev/bots/test.dart`. by @matanlurey in 158956
* [CP-beta]Adds a new helpful tool exit message for SocketExceptions thrown during mdns discovery by @flutteractionsbot in 158950
* Fix flaky failure related to core_device_list.json not being found by @bkonyi in 158946
* [flutter_releases] Flutter beta 3.27.0-0.2.pre Framework Cherrypicks by @eyebrowsoffire in 158943
* Roll Packages from 26e123a6ce03 to b9ac917daeb0 (5 revisions) by @engine-flutter-autoroll in 158938
* Enable --verbose for android_plugin_skip_unsupported_test tests by @bkonyi in 158933
* Refactor native asset integration into flutter tools by @mkustermann in 158932
* Do not rely on Leader/Follower to position DropdownMenu menu by @bleroux in 158930
* Updated Material 3 Progress Indicators Samples by @TahaTesser in 158925
* Add one MenuAnchor alignment test by @bleroux in 158915
* Fix: The enableFeedback property of InkWell cannot be set to a nullab… by @StanleyCocos in 158907
* No longer pass `--verbose` to implicit `pub` calls when `flutter --verbose` is set. by @matanlurey in 158898
* [SwiftPM] Add separate feature flag for the app migration by @loic-sharma in 158897
* Try with `bringup: true` debugging why `flutter build apk` often times out. by @matanlurey in 158895
* Reverts "Marks Mac_arm64_ios hot_mode_dev_cycle_ios__benchmark to be flaky (#158242)" by @auto-submit[bot] in 158891
* Adds a skip message for analyzer by @MitchellGoodwin in 158890
* Plumbs `scrollBehavior` into `SelectableText` so that the scrollbar may be hidden by @gspencergoog in 158887
* Create new page transition for M3 by @QuncCccccc in 158881
* Temporarily skip flutter build apk for native_assets tests. by @matanlurey in 158880
* Bump AGP/Gradle/Kotlin warn versions by @gmackall in 158839
* [flutter_releases] Flutter stable 3.24.5 Framework Cherrypicks by @eyebrowsoffire in 158778
* Stream the output of `flutter build` for debugging. by @matanlurey in 158757
* [ tool ] Don't throw StateError when DDS fails to start by @bkonyi in 158744
* Update triage flow chart for SVG packages by @stuartmorgan in 158670
* Roll Packages from 72356fda4684 to 26e123a6ce03 (19 revisions) by @engine-flutter-autoroll in 158626
* docs: include Human Interface haptic information in HapticFeedback by @alestiago in 158587
* Marks Mac_x64 hot_mode_dev_cycle_macos_target__benchmark to be flaky by @fluttergithubbot in 158569
* Marks Windows windows_desktop_impeller to be unflaky by @fluttergithubbot in 158565
* Marks Mac_arm64 mac_desktop_impeller to be unflaky by @fluttergithubbot in 158564
* Marks Linux web_benchmarks_skwasm_st to be unflaky by @fluttergithubbot in 158563
* Reland Add test for dynamic_content_color.0.dart by @ValentinVignal in 158547
* Mark Mac_ios microbenchmarks_ios as flakey by @jtmcdole in 158540
* Explain how to use `flutter channel`. by @matanlurey in 158533
* force Linux plugin_test to run on Ubuntu 20.04 by @christopherfujino in 158529
* Update test to include more complete instructions for how to run tests locally, add example to andoid 11 tests as well by @reidbaker in 158528
* Avoid using platform `ProcessInfo.maxRss` in test. by @matanlurey in 158526
* Manually cherry-pick #158141 (out_dir_shared) into stable by @eyebrowsoffire in 158525
* Move `dart pub deps` call to `<Pub>.deps` and use it accordingly by @matanlurey in 158524
* [web] Remove the benchmarks of the HTML renderer by @mdebbar in 158520
* Allow `devDependencies` to be omitted and not cause a tool crash. by @matanlurey in 158518
* Reverts "Add test for `dynamic_content_color.0.dart` (#158309)" by @auto-submit[bot] in 158511
* Fix `NavigationBar` label style customization on the widget level by @TahaTesser in 158510
* Add `IconAlignment` to `ButtonStyle` and `styleFrom` methods by @TahaTesser in 158503
* hide members where possible by @andrewkolos in 158492
* add filesystem error handling to `systemTempDirectory` by @andrewkolos in 158481
* #154792 - CupertinoActionSheetAction cursor doesn't change to clickable on desktop by @srivats22 in 158470
* Fix Chip draws `InkWell.hoverColor` is drawn on top of the provided background color with `hovered` state by @TahaTesser in 158454
* Fix the drawing position of OutlineInputBorder by @hgraceb in 158440
* [SwiftPM] Simplify logic that determines if CocoaPods is used by @loic-sharma in 158409
* Clean up dependabot config, add github-action group by @jmagman in 158408
* Manually cherry-pick #158141 (`out_dir_shared`) into `beta` by @matanlurey in 158395
* Replace custom `RPCErrorCodes` with `RPCErrorKind` from `package:vm_service` by @bkonyi in 158379
* Roll Packages from bb5a25815cae to 72356fda4684 (8 revisions) by @engine-flutter-autoroll in 158378
* Support materialTapTargetSize in PopupMenuButton by @hannah-hyj in 158357
* remove redundant arguments by @pq in 158349
* Manual roll Flutter Engine from 371c86fb6b49 to bcb281cde579 by @jason-simmons in 158346
* Add clarification on review timelines in PR template by @Piinks in 158345
* Roll pub packages by @flutter-pub-roller-bot in 158337
* Fix a breakage caused by the test being unskipped. by @matanlurey in 158335
* Increase Java heap limit to 8GB for plugin integration tests using deferred components by @bkonyi in 158330
* Add flutter/package code generation instructions by @stuartmorgan in 158326
* Add recently imported packages to issue template by @stuartmorgan in 158324
* [TextInput] Add TextInputType.webSearch (#15762) by @stonemaster in 158323
* Add test for `dynamic_content_color.0.dart` by @ValentinVignal in 158309
* Fix output path for --appSizeBase by @LinXunFeng in 158302
* Roll pub packages by @flutter-pub-roller-bot in 158281
* Fix flakiness in hot_reload_test.dart by @bkonyi in 158271
* Roll Packages from 721943194945 to bb5a25815cae (6 revisions) by @engine-flutter-autoroll in 158267
* Add ability to override `NavigationDestination.label` padding for `NavigationBar` by @TahaTesser in 158260
* Marks Mac_benchmark complex_layout_scroll_perf_macos__timeline_summary to be flaky by @fluttergithubbot in 158252
* Add test for `image.loading_builder.0.dart` by @ValentinVignal in 158248
* Add test for `image.frame_builder.0.dart` by @ValentinVignal in 158247
* Marks Linux analyzer_benchmark to be flaky by @fluttergithubbot in 158244
* Marks Mac_arm64_ios hot_mode_dev_cycle_ios__benchmark to be flaky by @fluttergithubbot in 158242
* Added cusor control properties to CupertinoSearchTextField and tests by @p-salmon in 158240
* Fix RawScrollbar examples and desktop test by @bleroux in 158237
* Delete firebase_android_embedding_v2_smoke_test by @jmagman in 158223
* excluding website-cms from critical pr triage by @chunhtai in 158220
* On-device Widget Inspector button exits widget selection by @elliette in 158219
* remove `bringup` status for recently re-subsharded targets by @andrewkolos in 158217
* Make flutter_tools use newest package:{native_assets_builder,native_assets_cli,native_toolchain_c} by @mkustermann in 158214
* [SwiftPM] Move the logic for SwiftPM enablement to the platform project by @loic-sharma in 158213
* Update error message for Cocoapods support for synchronized groups/folders by @LouiseHsu in 158206
* Remove observatory related TODO that is already fixed. by @matanlurey in 158205
* Restore skipped iOS test by looping over `FakeAsync` elapse. by @matanlurey in 158204
* Remove unused `enableObservatory` flag. by @matanlurey in 158202
* use root directory as the default for rootOverride in Cache.test constructor by @andrewkolos in 158201
* Increase subsharding for `Linux tool_integration_tests` by @andrewkolos in 158196
* Reland2: Revert "Revert "Add a warning/additional handlers for parsing`synthetic-package`."" by @polina-c in 158184
* Roll Packages from 796afa35071d to 721943194945 (11 revisions) by @engine-flutter-autoroll in 158179
* Cleanup MenuAnchor and Improve DropdownMenu tests readability by @bleroux in 158175
* Make native asset integration test more robust, thereby allowing smooth auto-update of packages via `flutter update-packages` by @mkustermann in 158170
* Add test for `raw_scrollbar.2.dart` by @ValentinVignal in 158161
* Fix update order of SliverAppBar by @hgraceb in 158159
* increase subsharding for `Windows build_tests` from 8 to 9 by @andrewkolos in 158146
* Forward fix `CupertinoDynamicColor` by adding `toARGB32()`. by @matanlurey in 158145
* Further remove web-only considerations that are no longer necessary by @matanlurey in 158143
* Extract and restore a test that a blank native assets project still builds by @matanlurey in 158141
* [SwiftPM] Update .flutter-plugin-dependencies format by @loic-sharma in 158138
* Add optional parameter to FlutterTesterDevices. by @polina-c in 158133
* [CP-beta]Prevent `flutter build ios-framework --xcframework` from copying `Flutter.xcframework.dSYM` into the `App.framework` folder. by @flutteractionsbot in 158131
* Reland1:  "Revert "Add and plumb `useImplicitPubspecResolution` across `flutter_tools`."" by @polina-c in 158126
* [CP-stable]Prevent `flutter build ios-framework --xcframework` from copying `Flutter.xcframework.dSYM` into the `App.framework` folder. by @flutteractionsbot in 158125
* Add validator execution times to `flutter doctor --verbose` by @bkonyi in 158124
* Disable failing native assets test by @victorsanni in 158119
* Update Material 3 `CircularProgressIndicator` for new visual style by @TahaTesser in 158104
* Add test for `raw_scrollbar.shape.0.dart` by @ValentinVignal in 158094
* Remove null from flex documentation by @ValentinVignal in 158086
* Revert "Add a warning/additional handlers for parsing`synthetic-package`." by @polina-c in 158078
* Revert "Add and plumb `useImplicitPubspecResolution` across `flutter_tools`." by @polina-c in 158076
* Add test for `raw_scrollbar.1.dart` by @ValentinVignal in 158069
* Add test for `interactive_viewer.constrained.0.dart` by @ValentinVignal in 158044
* Remove references to the HTML renderer in public docs. by @matanlurey in 158035
* Delete unused references to dev.flutter.plugins.e2e. by @matanlurey in 158031
* Add benchmarks for single-threaded Skwasm. by @eyebrowsoffire in 158027
* [Android] Removes dev dependency plugins from release builds by @camsim99 in 158026
* fix failing lints in `aar_init_script.gradle`  by @AbdeMohlbi in 158025
* fix lint usage of `task` inside `resolve_dependecies.gradle` file by @AbdeMohlbi in 158022
* Add `SafeArea` DartPad sample by @nate-thegrate in 158019
* Deflake api 35 emulator tests by updating emulator definitions version to latest available from chrome infra by @reidbaker in 158017
* Move explicit package dependencies to a feature flag by @matanlurey in 158016
* Improve consistency of code snippets in basic.dart by @loic-sharma in 158015
* Make SwiftPM integration tests even MORE idiomatic by @loic-sharma in 158014
* Remove unnecessary `kCliAnimationsFeatureName` that is available as `.configSetting`. by @matanlurey in 158013
* Add `dev_dependency` attribute to plugins in `.flutter-plugins-dependencies` by @camsim99 in 158009
* Roll Packages from 7cc1caa0cc36 to 796afa35071d (15 revisions) by @engine-flutter-autoroll in 158003
* Adjusts the Hindi TimeOfDayFormat to display in a LTR orientation in localizations. by @Mairramer in 157998
* Add test for `raw_scrollbar.0.dart` by @ValentinVignal in 157989
* Add test for `interactive_viewer.transformation_controller.0.dart` by @ValentinVignal in 157986
* Fix: Update PopupMenu position when layout changes by @YeungKC in 157983
* Make the SwiftPM integration tests more idiomatic by @loic-sharma in 157971
* [CP-beta]Add handler for jlink error when using Java 21 by @flutteractionsbot in 157946
* Renames `injectBuildTimePluginFilesForWebPlatform` and removes unused named parameter. by @matanlurey in 157944
* Add a warning/additional handlers for parsing`synthetic-package`. by @matanlurey in 157934
* Refactor DropdownMenu tests by @bleroux in 157913
* Add test for `notification.0.dart` by @ValentinVignal in 157909
* [flutter_driver] use mostly public screenshot API. by @jonahwilliams in 157888
* Set stable color for semantics debugger by @chunhtai in 157884
* [CP-beta]Support host android apps with `kts` gradle files for add to app by @flutteractionsbot in 157881
* Add and plumb `useImplicitPubspecResolution` across `flutter_tools`. by @matanlurey in 157879
* Upgrade templates to AGP 8.7/Gradle 8.10.2 by @gmackall in 157872
* Make leak tracking bots blocking. by @polina-c in 157866
* Roll Packages from 028027e6b1f1 to 7cc1caa0cc36 (5 revisions) by @engine-flutter-autoroll in 157864
* Mention partial PRs in the contributing docs by @stuartmorgan in 157863
* fix(ScrollAction): unsafe non-null assertion by @kszczek in 157855
* Add test for `media_query_data.system_gesture_insets.0.dart` by @ValentinVignal in 157854
* Marks Linux_pixel_7pro service_extensions_test to be flaky by @fluttergithubbot in 157853
* improve `ContainerRenderObjectMixin` error message when `parentData` is not set up properly by @PurplePolyhedron in 157846
* Update CHANGELOG.md to correct ios vs macos issue by @reidbaker in 157822
* iOS Selection Handle Improvements by @Renzo-Olivares in 157815
* Roll Packages from e0c4f55cd355 to 028027e6b1f1 (8 revisions) by @engine-flutter-autoroll in 157813
* Reverts "Avoid labeling 'context' PRs as 'text-input' (#157650)" by @auto-submit[bot] in 157812
* [impeller] re-enable impeller shard. by @jonahwilliams in 157806
* Avoid labeling all PRs as 'text-input' by @jmagman in 157805
* Add test for `interactive_viewer.0.dart` by @ValentinVignal in 157773
* Add test for `focus_scope.0.dart` by @ValentinVignal in 157772
* Add test for `page_storage.0.dart` by @ValentinVignal in 157770
* Update `TextEditingController.text` documentation to recommend against using it in production code by @LongCatIsLooong in 157769
* Add test for `scroll_metrics_notification.0.dart` by @ValentinVignal in 157768
* Pin Mac tool_integration_test shards to arm64 by @zanderso in 157760
* Fix `NestedScrollView` inner position logic by @nate-thegrate in 157756
* [web] On the web platform, use an <img> tag to show an image if it can't be accessed with CORS by @harryterkelsen in 157755
* Factor out "shaker" class by @nate-thegrate in 157748
* Fix `TabBar` tab icons not respecting custom `IconTheme` by @TahaTesser in 157724
* Updated document to clarify Clip Behaviour by @Neutrino2711 in 157719
* Add test for `nested_scroll_view_state.0.dart` by @ValentinVignal in 157714
* Add test for `restoration_mixin.0.dart` by @ValentinVignal in 157709
* Add test for `restorable_route_future.0.dart` by @ValentinVignal in 157708
* Fix showSnackBar can't access useMaterial3 from the theme by @bleroux in 157707
* Add test for `navigator.restorable_push_replacement.0.dart` by @ValentinVignal in 157704
* Add test for `focus_node.unfocus.0.dart` by @ValentinVignal in 157673
* Add test for `navigator_state.restorable_push_replacement.0.dart` by @ValentinVignal in 157668
* Add tests for `navigator_state.restorable_push.0.dart` by @ValentinVignal in 157667
* fix fade_transition issue by @yiiim in 157663
* Remove extraneous `throw`. by @matanlurey in 157658
* Fix and remove a few `no-shuffle` tags in `flutter_tools`. by @matanlurey in 157656
* Avoid labeling 'context' PRs as 'text-input' by @jmagman in 157650
* Kill interactive script job `xcdevice observe` processes on tool/daemon shutdown by @jmagman in 157646
* Relands "Wide gamut framework gradient test (#153976)" by @gaaclarke in 157643
* Adds a new helpful tool exit message for SocketExceptions thrown during mdns discovery by @LouiseHsu in 157638
* Add hidden `--no-implicit-pubspec-resolution` flag for one stable release. by @matanlurey in 157635
* Update .ci.yaml have android sdk be 35v1 by @reidbaker in 157621
* Fix `ResizeImage` documentation by @nate-thegrate in 157619
* Reland "Upgrade tests to AGP 8.7/Gradle 8.10.2/Kotlin 1.8.10" by @gmackall in 157617
* Reverts "Wide gamut framework gradient test (#153976)" by @auto-submit[bot] in 157615
* Fix menu anchor state handling by @YeungKC in 157612
* Roll Packages from a556f0f52825 to e0c4f55cd355 (2 revisions) by @engine-flutter-autoroll in 157605
* Add 3.24.4 changelog to master by @reidbaker in 157600
* Add 3.24.4 changelog by @reidbaker in 157596
* Add test for `navigator_state.restorable_push_and_remove_until.0.dart` by @ValentinVignal in 157595
* Add tests  for `focusable_action_detector.0.dart` by @ValentinVignal in 157575
* CupertinoSheetRoute by @MitchellGoodwin in 157568
* Tighten up `throwToolExit`, explain when to use it. by @matanlurey in 157561
* Fix use of deprecated `buildDir` in Android templates/tests/examples by @gmackall in 157560
* Reverts "Upgrade tests to AGP 8.7/Gradle 8.10.2/Kotlin 1.8.10 (#157032)" by @auto-submit[bot] in 157559
* Mark mac impeller as bringup. by @jonahwilliams in 157551
* Reverts "Reverts "Added a warning if `flutter.groovy` uses a `.flutter-plugins` file. (#157388)" (#157541)" by @auto-submit[bot] in 157549
* Use discenrable characters (replace `' 🙙 🙛 '` in error logs) by @matanlurey in 157548
* Reverts "Added a warning if `flutter.groovy` uses a `.flutter-plugins` file. (#157388)" by @auto-submit[bot] in 157541
* Roll Packages from 5e03bb1da411 to a556f0f52825 (7 revisions) by @engine-flutter-autoroll in 157539
* Remove unsafe_html lint rule by @srawlins in 157531
* Allow opting out of `.flutter-plugins`, opt-out in `refreshPluginsList`. by @matanlurey in 157527
* Remove unused `PubDependenciesProjectValidator`. by @matanlurey in 157516
* Add test for `build_owner.0.dart` by @ValentinVignal in 157499
* Add tests for `navigator.restorable_push.0.dart` by @ValentinVignal in 157492
* Add test for `navigator.restorable_push_and_remove_until.0.dart` by @ValentinVignal in 157487
* Add partial test for flutter build ios-framework on non-module by @loic-sharma in 157482
* docs: Rework "Making changes to the `flutter` tool" to include `flutter-dev` by @andrewkolos in 157480
* Bump actions/checkout from 4.2.1 to 4.2.2 by @dependabot[bot] in 157473
* Readability change to `flutter.groovy`, align on null assignment, reduce unused scope for some methods, apply static where possible by @AbdeMohlbi in 157471
* Turn `brieflyShowPassword` back on on iOS by @LongCatIsLooong in 157466
* `Plugin.isDevDependency` if exclusively in `dev_dependencies` by @matanlurey in 157462
* Update `Tab.height` parameter doc for tab height lower than default by @TahaTesser in 157443
* Fix Scaffold extend body by @yiiim in 157441
* Fixes typos & spelling error in changelog.md file by @thejitenpatel in 157438
* Marks Mac_benchmark animated_complex_opacity_perf_macos__e2e_summary to be flaky by @fluttergithubbot in 157424
* Marks Windows build_android_host_app_with_module_source to be unflaky by @fluttergithubbot in 157420
* Marks Windows build_android_host_app_with_module_aar to be unflaky by @fluttergithubbot in 157419
* Marks Windows build_tests_7_8 to be unflaky by @fluttergithubbot in 157418
* Marks Windows build_tests_6_8 to be unflaky by @fluttergithubbot in 157417
* Marks Windows build_tests_5_8 to be unflaky by @fluttergithubbot in 157416
* Marks Windows build_tests_4_8 to be unflaky by @fluttergithubbot in 157415
* Marks Windows build_tests_3_8 to be unflaky by @fluttergithubbot in 157414
* Marks Mac build_android_host_app_with_module_source to be unflaky by @fluttergithubbot in 157412
* Marks Mac build_android_host_app_with_module_aar to be unflaky by @fluttergithubbot in 157411
* Marks Linux build_android_host_app_with_module_source to be unflaky by @fluttergithubbot in 157410
* Marks Linux build_android_host_app_with_module_aar to be unflaky by @fluttergithubbot in 157409
* Add test for `star_border.0.dart` by @ValentinVignal in 157401
* Reland "Fix TextField selects all content after the application is resumed" by @bleroux in 157399
* Create flutter specific leak troubleshooting guidance. by @polina-c in 157396
* Prevent `flutter build ios-framework --xcframework` from copying `Flutter.xcframework.dSYM` into the `App.framework` folder. by @LouiseHsu in 157394
* Make hash script for Frob by @jtmcdole in 157390
* Added a warning if `flutter.groovy` uses a `.flutter-plugins` file. by @matanlurey in 157388
* Remove the only reference to `settings.gradle.legacy_versions`. by @matanlurey in 157380
* Reverts "Fix TextField selects all content after the application is resumed (#156968)" by @auto-submit[bot] in 157378
* Upgrade leak tracker. by @polina-c in 157369
* Roll Packages from b6f7e47c7586 to 5e03bb1da411 (3 revisions) by @engine-flutter-autoroll in 157349
* Fix MenuController.isOpen throws when unattached by @bleroux in 157331
* Add test for `pointer_signal_resolver.0.dart` by @ValentinVignal in 157330
* Add test for `platform_menu_bar.0.dart` by @ValentinVignal in 157328
* Test alternate correct macOS framework xcprivacy manifest location by @jmagman in 157318
* Add `@protected` to public `State` method overrides by @nate-thegrate in 157313
* Allow requesting a reduced widget tree with `getRootWidgetTree` service extension by @elliette in 157309
* [CP-beta] Fix flavor-conditional asset bundling for path dependencies  by @andrewkolos in 157306
* [devicelab] remove flaky designation from flutter_driver_android_test by @jonahwilliams in 157300
* Remove duplicated widget of the week video embed by @loic-sharma in 157299
* Fix some leaky tests. by @polina-c in 157294
* Revert "[devicelab] handle missed lifecycle messages. (#156596)" by @jason-simmons in 157293
* Match framework and engine android emulator versions by @reidbaker in 157291
* Update ecosystem contribution docs by @stuartmorgan in 157288
* Update flutter.groovy to catch unknown task exception when finding api task by @AbdeMohlbi in 157282
* doctor: make JDK validation message more descriptive by @Sameri11 in 157280
* Support backdrop key in flutter framework. by @jonahwilliams in 157278
* Roll Packages from 2a1c477a788c to b6f7e47c7586 (5 revisions) by @engine-flutter-autoroll in 157271
* [flutter_releases] Flutter beta 3.27.0-0.1.pre Framework Cherrypicks by @reidbaker in 157268
* Add test for `selectable_region.0.dart` by @ValentinVignal in 157258
* Resolve pupup menu test TODO by @parlough in 157251
* Migrate away from deprecated whereNotNull by @parlough in 157250
* Fix a few typos in framework code and doc comments by @parlough in 157248
* Dispose temporarily created CurvedAnimation [prod-leak-fix] by @polina-c in 157233
* Add example to Directionality docs by @loic-sharma in 157230
* Add example to SafeArea docs by @loic-sharma in 157228
* Add example to ClipOval docs by @loic-sharma in 157227
* Add test for `navigation_rail.extended_animation.0_test.dart` by @ValentinVignal in 157222
* fix `Consider using 'named' to avoid unnecessary configuration` inside flutter.groovy by @AbdeMohlbi in 157221
* Remove unused import from kt plugin template by @koji-1009 in 157220
* Made Cupertino dialog more like a native dialog in dark mode by @thejitenpatel in 157218
* Add dart command line tool for calculating engine hash by @jtmcdole in 157212
* Make android dependency version test suite run on changes to templates by @gmackall in 157196
* Use Gradle KTS in new Android app projects by default (2nd try) by @bartekpacia in 157195
* Reverts "Use Gradle KTS in new Android app projects by default (#154061)" by @auto-submit[bot] in 157194
* all selectable widgets set the hasSelectedState flag by @yjbanov in 157191
* `WidgetStateInputBorder` by @nate-thegrate in 157190
* [web] Allow control of hitTestBehavior of Platform Views by @mdebbar in 157189
* Delete unused string in `gradle_errors.dart` by @gmackall in 157187
* Add support for `flutter build web --debug`. by @eyebrowsoffire in 157186
* Polish the texture example by @loic-sharma in 157176
* Roll Packages from 5582669ac6d0 to 2a1c477a788c (4 revisions) by @engine-flutter-autoroll in 157171
* Delete line referencing v1 string by @gmackall in 157170
* Allow customizing entry mode icons in TimePicker by @syedaniq in 157151
* Preland support for monorepo engine hashing by @jtmcdole in 157138
* Beta test alternate correct macOS framework xcprivacy manifest location by @jmagman in 157136
* Update CupertinoNavigationBar to support large layout by @Piinks in 157133
* Add handler for jlink error when using Java 21 by @gmackall in 157132
* Move analyzer_benchmark to the devicelab by @zanderso in 157127
* Roll Packages from a35f02d79d0e to 5582669ac6d0 (6 revisions) by @engine-flutter-autoroll in 157119
* Add test for `flexible_space_bar.0.dart` by @ValentinVignal in 157107
* [CP-beta]Update Android plugin templates for newer AGP by @flutteractionsbot in 157100
* Add test for `selection_container.0_test.dart` by @ValentinVignal in 157079
* Mark `Linux_android_emu_34 flutter_driver_android_test` bringup: true by @QuncCccccc in 157069
* Return a valid result for a view with zero width/height in TestViewConfiguration._getMatrix by @jason-simmons in 157068
* Manual roll Flutter Engine from f6fd2cbe4773 to f12e0d385f4d (8 revisions) by @engine-flutter-autoroll in 157066
* Temporarily skip CustomPainter SemanticsFlag test to allow new flag to roll in by @yjbanov in 157061
* Upgrade tests to AGP 8.7/Gradle 8.10.2/Kotlin 1.8.10 by @gmackall in 157032
* [CP-beta]Add a tool warning when `pod install` does not work after adding a new test/watch/extension/other target with Xcode 16  by @flutteractionsbot in 157022
* Temporarily skip SemanticsFlag test to allow new flag to roll in by @yjbanov in 157017
* Roll Packages from bf751e6dff18 to a35f02d79d0e (2 revisions) by @engine-flutter-autoroll in 156983
* builder gets executed with AnimationStyle.noAnimation by @Lurchfresser in 156982
* Fix TextField selects all content after the application is resumed by @bleroux in 156968
* Marks Linux_pixel_7pro flavors_test to be flaky by @fluttergithubbot in 156956
* feat: Include web 1.x.x in plugin template by @Gustl22 in 156947
* Marks Mac flavors_test_macos to be flaky by @fluttergithubbot in 156944
* Remove LogicalKeySet usage in one Shortcuts example by @bleroux in 156941
* Add test for `selection_container_disabled.0.dart` by @ValentinVignal in 156934
* Removing unnecessary parenthesis by @FMorschel in 156928
* Update Snackbar actionOverflowThreshold Documentation by @RamonFarizel in 156926
* Roll pub packages by @flutter-pub-roller-bot in 156925
* Pin google_mobile_ads to 5.1.0 by @loic-sharma in 156911
* [devicelab] try waiting for first frame. by @jonahwilliams in 156907
* Roll Packages from 1e670f27a620 to bf751e6dff18 (1 revision) by @engine-flutter-autoroll in 156824
* Add tests for `material_state_outlined_border.0.dart` by @ValentinVignal in 156814
* fix DropdownMenu keyboard navigation is broken when expandedInsets is set by @bleroux in 156803
* make `ChromiumDevice.stopApp` a no-op if it has already been called by @andrewkolos in 156778
* fix test sharding  by @andrewkolos in 156768
* increase sharding of `Windows build_tests` by @andrewkolos in 156763
* Add a tool warning when `pod install` does not work after adding a new test/watch/extension/other target with Xcode 16  by @LouiseHsu in 156758
* Fix JS compilation to use the command 'compile js' instead of using snapshot names to invoke dart2js by @a-siva in 156735
* Roll Packages from 67401e169e5c to 1e670f27a620 (7 revisions) by @engine-flutter-autoroll in 156734
* Add test for `material_state_property.0.dart` by @ValentinVignal in 156719
* Update iOS/macOS plugin test information by @stuartmorgan in 156716
* Update dropdown menu semantics to fix its a11y issues by @hannah-hyj in 156709
