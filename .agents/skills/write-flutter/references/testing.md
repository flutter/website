# Flutter testing

What to test at which level,
and how to write widget tests that check behavior users can observe.

## Flutter test suite structure

- Use **unit tests** for view models, repositories, and other plain Dart code.
  When logic stays out of widgets,
  most tests belong here.
  See [State and architecture](state-and-architecture.md).
- Use `testWidgets` to write **widget tests**
  for observable behavior worth protecting:
  what renders for a given state
  and what events user actions produce.
- Use **integration tests** for a small set of critical end-to-end flows.

Follow the project's test layout.
When it has no convention,
mirror the `lib/` structure under `test/` and end filenames in `_test.dart`.
Write descriptions as behavior sentences,
as in `testWidgets('shows an error banner when submission fails', ...)`,
grouped by widget or scenario with `group`.

## Widget test mechanics

Wrap the widget under test in the ancestors it needs.
A `MaterialApp` supplies themes, localization, and navigation.
If the widget needs only text direction,
a `Directionality` ancestor can be sufficient.
Write one pump helper per suite instead of repeating boilerplate code:

```dart
Future<void> pumpCard(WidgetTester tester, {required Profile profile}) {
  return tester.pumpWidget(
    MaterialApp(
      home: Scaffold(body: ProfileCard(profile: profile)),
    ),
  );
}

testWidgets('shows the display name', (tester) async {
  await pumpCard(tester, profile: Profile(name: 'Ada'));
  expect(find.text('Ada'), findsOneWidget);
});
```

## Test time and pumping

- `pump()` advances one frame.
  `pump(duration)` advances test time.
  Fake time avoids wall-clock delays and makes tests deterministic.
- `pumpAndSettle()` pumps until no frames are scheduled.
  After navigation, it can be convenient.
  If an animation repeats indefinitely,
  such as a spinner or repeating controller,
  `pumpAndSettle()` eventually times out.
  In those cases, pump explicit durations.
- Awaiting a real `Future.delayed` doesn't advance the fake test clock.
  Advance the clock with `pump`.

## Finders and interaction

- **PREFER** finding by what users perceive
  with `find.text(...)`, `find.bySemanticsLabel(...)`,
  or `find.byIcon(...)`, then use `find.byType(...)`.
  When several similar widgets need disambiguation,
  use `find.byKey(...)`.
  Tests coupled to internal structure can fail
  after behavior-preserving refactors.
- Interact through the tester, such as with
  `tester.tap(...)`, `tester.enterText(...)`, and `tester.drag(...)`.
  Pump after an interaction when the assertion depends on
  a scheduled frame, animation, or microtask.
  An interaction alone doesn't process a rebuild.
- Assert _behavior_ such as
  rendered text, callback values, and navigation destinations,
  not private state fields or widget internals.

## Dependency fakes

Constructor injection lets you pass a fake repository or view model directly.

- **PREFER** handwritten fakes that implement the interface
  for straightforward dependencies.
  A fake can return predefined data and record calls.
  When interaction verification becomes complex,
  use the mocking package that the project already uses.
- **DON'T** let widget tests use real network, storage, or platform channels:
  external dependencies make tests nondeterministic.

## Accessibility checks

The `flutter_test` package includes guideline matchers
that identify accessibility defects:

```dart
testWidgets('meets accessibility guidelines', (tester) async {
  final handle = tester.ensureSemantics();
  try {
    await pumpCard(tester, profile: Profile(name: 'Ada'));

    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await expectLater(tester, meetsGuideline(textContrastGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
  } finally {
    handle.dispose();
  }
});
```

Use `androidTapTargetGuideline` for Android targets
and `iOSTapTargetGuideline` for iOS targets.
For a cross-platform widget,
exercise each platform-specific guideline that the product supports.

## Golden tests

- **CONSIDER** golden tests with `matchesGoldenFile` for
  widgets whose appearance requires verification:
  charts, custom painters, and design-system components.
  Update intentionally with `flutter test --update-goldens`,
  and review the image diff with the same care as a code diff.
- Font and shader rendering differ across platforms.
  Run goldens on one pinned continuous integration platform.
  Avoid whole-page goldens,
  because ordinary copy changes require large updates.
