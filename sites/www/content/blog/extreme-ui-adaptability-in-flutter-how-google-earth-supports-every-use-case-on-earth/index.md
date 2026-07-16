---
title: "Extreme UI Adaptability in Flutter — How Google Earth supports every use case on earth"
description: "When Google Earth set out to rewrite their mobile and web clients in Flutter, they knew they wanted to allow each and every one of their…"
publishDate: 2024-02-07
author: craiglabenz
image: images/1RXf-GaJ4uz5_ZKU8QgIVkw.webp
category: story
layout: blog
---

## Extreme UI Adaptability in Flutter — How Google Earth supports every use case on earth

When Google Earth set out to rewrite their mobile and web clients in Flutter, they knew they wanted to allow each and every one of their users to explore the planet however they liked, on whatever devices they owned. This had long been true to an extent; after all, Google Earth had existing web, desktop, Android, and iOS clients. But this rewrite, which would cover all of those targets other than desktop, would need to support the superset of existing use cases; plus a few new adaptability ideas the Earth team was excited to explore.

The search for Google Earth’s tech stack of the future was heavily informed by all-too-familiar sources of friction that had slowed development on their existing clients. Namely, Google Earth had long been forced to choose between developer velocity on new features and maintaining feature parity across their three unique codebases (web, Android, and iOS). Luckily, the center of the UI — the entirety of the pale blue dot in the middle of the screen — is powered by a C++ engine that already delivered a unified experience for *some* of Google Earth’s features. However, the rest of the UI chrome and menus were implemented separately across each codebase. This meant that any cross-platform choice would not only need to overhaul the UI development process, but also integrate with a large legacy engine in Android, iOS, and the web.

The deciding factors to use Flutter were twofold. First, integrating with the existing Google Earth engine proved to be a straightforward task using method channels. Second, Google Earth not only wanted to streamline their codebases, but also to reimagine their UI entirely. Any major UI overhaul is already something of a rewrite, and Google Earth opted to write one new Flutter app instead of performing surgery on three existing apps. This complicated the task, but the team committed to a clean break and obsessive focus on adaptability. In the end, the Google Earth team came to power their UI across three platforms with Flutter.

## Defining adaptability

And so, the Google Earth team set out on an adventure to push the limits of UI adaptability. Prior art abounds on creating UIs tailored to different user journeys — dating back to the dawn of smartphones and the entire internet’s collective realization that most websites needed a rethink for small screens. Browser APIs and CSS patterns emerged to build websites with an awareness of their screen’s resolution; and those ideas have been prominent ever since. Even in Flutter’s earliest days, developers knew phone screens would vary and made their apps’ UIs depend on the screen’s resolution. And if that resolution changed — either because the user rotated their phone or resized their browser window, the app’s UI would *respond*. In Flutter, as in the web for years before it, ***responsive UIs*** improved user experiences.

What then, you might wonder, is the difference between a *responsive* UI and an *adaptive* UI? Put simply, a *responsive* UI adjusts to changes in the amount and aspect ratio of available pixels; while an *adaptive* UI adjusts to *everything else.* Responsive UIs can grow and shrink individual UI elements based on screen real estate details, but adaptive UIs answer more fundamental questions like where to render the app’s navigation, whether list views should route to separate detail views or show them side-by-side with the list itself, and how the user’s connected peripherals should influence things like tap targets and hover states (more on this concept later).
> For more on this, watch [episode 15 of Decoding Flutter](https://youtu.be/HD5gYnspYzk?si=8AvuBRGXNRNET9dR) on Adaptive vs Responsive UIs and see these guides from [Flutter](https://docs.flutter.dev/ui/layout/responsive/building-adaptive-apps) and [Android’s](https://developer.android.com/develop/ui/views/layout/responsive-adaptive-design-with-views) documentation.

As anyone who’s written responsive CSS for a website will tell you, even simple UIs promise tricky edge cases. And to be clear, this is no fault of CSS; the problem space’s many states are so fine-grained as to almost feel analog. What then, should a UI developer expect when considering several additional variables, such as the device form factor and connected peripherals? Naturally, they should expect a fair increase in complexity.

This all came to a head when the behavior of an early prototype caught the Google Earth team off-guard. While playing with that early build, a Google Earth engineer shrunk their desktop web browser down to an extremely narrow width. Suddenly, typical desktop affordances like side navigation bars and tighter touch targets were replaced by mobile affordances, like a bottom navigation bar and larger, finger-friendly buttons. Their surprise was brief — after all, *that was exactly what they’d told their app to do*. The Google Earth team was now faced with a profound question — *Is this what a user would want?*

Such was the terra incognita the Google Earth team was about to chart.

## Why adaptability?

To some, the following content raises a meta-question: *Why bother with any of this in the first place? Is the ROI sufficient when surely a responsive UI will satisfy most users?*

These are good questions, but they should not contribute toward hesitation with Flutter. Using a cross-platform UI framework like Flutter does not *introduce* adaptive UI concerns; it *unlocks adaptive UI solutions*. Beyond that, here are two considerations that suggest adaptive UIs really are that important:

* Screen resolutions don’t imply what they once did. Desktop browsers can have low DPI settings that a naive breakpoint check will confuse with mobile environments; high-DPI phones in landscape orientation can be mistaken with old tablet (or even desktop!) breakpoints; and foldable devices can alternate between showing your app full-screen and splitting screen real estate between multiple apps, leading to jarring differences if this careens a user back and forth across certain breakpoints.

* Apps with distinct creation vs consumption modes (think any text composition app with Read and Edit experiences) can suffer heavily on mobile — and especially on tablets. Shipping a mobile-first, and thus likely consumption-first experience to smartphones and tablets greatly limits your power users with a tablet, Bluetooth keyboard, and mouse.

## Delivering on adaptability

The Google Earth team walked a long road of experimentation, user research, and iteration to arrive at the app they ultimately shipped. But in the end, their problem space boiled down to three high-level questions:

1. How should the app determine its initial UI strategy?

1. How and when should the app change its UI strategy?

1. How would the Google Earth team cleanly implement this logic?

## Determining an initial UI strategy

One of the Earth team’s early assumptions was that “there is no difference between a Chromebook with a touchscreen and a tablet with a connected Bluetooth keyboard”, and that their UI should not distinguish between the two. Although this idea stood to initial reason, it did not survive testing; and over time the Earth team increasingly realized the gaps in this approach. A user launching the app with a high-resolution tablet in landscape mode could find themselves within a desktop UI range of pixel resolution (following older, responsive UI rules). If that same user then rotated their tablet into portrait mode and in doing so shifted into a pixel resolution range assigned to tablets, Google Earth would be faced with a hard choice. The dynamic option would be to dramatically restructure everything by shifting from the desktop UI to the mobile UI; whereas the static option would be to do nothing except squish and compress the desktop UI until it fit in within its new constraints. Neither of these options were satisfying, and it all meant that there *was* a difference between a Chromebook with a touchscreen and a tablet with a keyboard.

In the end, the Earth team settled on a simple rule: serve the mobile experience to smartphones and tablets, and the desktop experience to desktops. If this seems anti-climactic, well, it sort of is; but only because it punts some of the juicy parts to the next question — *When should the UI’s initial strategy **change?***

## Updating the UI strategy within a user session

The Earth team’s first strategy for UI changes was little more than established responsive UI rules: show your mobile UI on any resolutions below a minimum threshold, your tablet UI (if you have one) the next few hundred possible widths, and lastly, your desktop UI on anything else. And, critically, when a UI crosses one of those thresholds for any reason, you re-render the app accordingly. Of course, this ruleset’s awkwardness launched Google Earth onto its odyssey of extreme adaptability; so it should be no surprise that the team abandoned this approach.

A second possibility came from Stadia, a fellow Google team with a successful Flutter mobile app. (Obviously, Stadia did not survive as a product; but that was not for lack of functionality in its mobile app!) Stadia’s approach was to make adaptive UI decisions based on which inputs were last touched. Drag your computer’s cursor or press a key, and Stadia would snap into its desktop UI mode. Conversely, if you tilted a joystick on a connected console controller, Stadia would snap into its console UI mode. However, while that made sense for Stadia, it proved less appropriate for Google Earth. A simple case ruled out this last-inputs-touched strategy: a tablet user pinching to zoom their map, then returning to a Bluetooth keyboard to finish typing content. No user would want two dramatic UI transitions during that simple interaction, so the user’s most recent inputs could not wholesale change Google Earth’s UI from mobile to desktop or back.

In the end, the Google Earth team settled on a second very simple rule: remain consistent within a session and never leave the initial UI flavor without the user’s explicit permission. As explored earlier, Google Earth would show its mobile-first UI on smartphones and tablets and its desktop-first UI on desktops; and it would never outsmart itself and change that unless the user requested a change in the settings panel.

## Mixed-UI states

UI consistency within sessions served Google Earth well, but it is not the whole story. UI affordances in desktop experiences like cursor hover effects lack any equivalent on mobile and must be reimagined. A user treating their touchscreen laptop like a tablet could be blocked entirely by an app’s failure to replace critical hover effects with alternatives suitable for mobile. This realization suggested a two-tier problem and solution. Google Earth’s UI would not only need to smoothly switch back and forth between its mobile and desktop experiences when a user requested, but individual controls would need to have both a touch-friendly form *and* a mouse-friendly form, regardless of the overarching strategy.

Finally, Google Earth knew what they were building. All of their research and iteration left only implementation questions, which amounted to:

1. How to manage transitions between two fundamentally different UIs, and

1. How to build individual controls to support atypical peripherals

## Managing multiple UIs

At its simplest, building any Flutter app to seamlessly switch between two different experiences is as simple as putting the following line somewhere in a widget’s build method:

```dart
child: mode == Mode.desktop ? DesktopUI() : MobileUI()
```


However, this strategy (which is what Google Earth uses) implies some extra work elsewhere to fully realize. The issue — initially obscure — surfaces when *any* application state is stored within a Stateful widget, as toggling that `mode` variable completely replaces the widget tree, destroying all State objects and any information they hold. There are two layers to this problem.

To imagine the first layer, consider a screen that has multiple panels on desktop, but reorganizes each of those panels into a tab bar experience on mobile. A mobile user will have an active tab, but that concept has no equivalent on desktop. Storing the active tab index within a StatefulWidget (an idiomatic decision in Flutter!) would always reset a mobile user’s position to the default tab after toggling back and forth through the desktop UI. The solution to this involves moving any primitive application state — strings, integers, and the like — out of StatefulWidgets and into your state management classes. This way, no shenanigans in your widget tree can reset critical values.

The problem’s second layer comes from application state less easily pulled out of the widget tree, like TextEditingControllers or ScrollControllers. The situation looks like this: you have a ListTile with a TextField, but any time the user touches their mouse or touchscreen, you rebuild that ListTile to accommodate the user’s latest peripherals. Without intervention, this would cause Flutter to destroy the entire part of the Widget and Element trees containing the old TextField, taking with them any controllers holding the user’s work. You might be tempted to treat these as primitives (TextEditingControllers as strings and ScrollControllers as doubles) and repeat the above solution; but controllers are too rich to easily serialize in this way (cursor position and text selection, anyone?).

To solve this problem, Google Earth uses GlobalKeys to have the framework “reparent” highly-scoped widgets after a fresh layout. The following AdaptableTextInput widget is tightly scoped to its TextField and TextEditingController. Supplying the same GlobalKey to that AdaptableTextInput widget across UI-changing rebuilds will keep the TextEditingController alive, saving your users’ work.

```dart
class AdaptableTextInput extends StatefulWidget {

  // Supply a consistent GlobalKey here!
  const AdaptableTextInput({super.key, required this.mode});

  final Mode mode;

  @override
  State<AdaptableTextInput> createState() => _AdaptableTextInputState();
}

class _AdaptableTextInputState extends State<AdaptableTextInput> {

  final _controller = TextEditingController();
  final String helpText = 'I clarify this text input!';

  @override
  Widget build(BuildContext context) {
    if (widget.mode == Mode.desktop) {
      return Tooltip(
        showOnHover: helpText,
        child: TextField(controller: _controller),
      );
    } else if (widget.mode == Mode.mobile) {
      return Column(
        children: <Widget>[
          TextField(controller: _controller),
          Text(helpText);
        ],
      );
    } 
  }
}
```


## Navigation

Navigation stacks and the app’s Back button also require special attention. Continuing with the above example of a desktop UI that shows multiple panels at once, now imagine a complementary mobile UI that presents those panels in a stack-like UI with forward and backward navigation. The implications of allowing desktops to use the mobile UI, and phones to use the desktop UI, was one of the big adaptability ideas Google Earth wanted to pursue.

<DashImage figure src="images/1nHhbCY1mlIwlvQI60jaJHA.webp" alt="A grid of UIs, showing a desktop UI on both desktop and mobile devices, and a mobile UI on both desktop and mobile devices" caption="A grid of UIs, showing a desktop UI on both desktop and mobile devices, and a mobile UI on both desktop and mobile devices" />


If a desktop-UI user is on the red panel when they switch to the mobile UI, the Back button won’t automatically be wired up, because the navigation stack will be reset. This means your desktop UI needs to account for extra information technically only needed by the mobile UI, because at any moment the mobile UI could be asked to take over.

<DashImage figure src="images/1RXf-GaJ4uz5_ZKU8QgIVkw.webp" alt="A desktop device rendering the same UI in two different modes — one typical of desktop, and one typical of mobile" caption="A desktop device rendering the same UI in two different modes — one typical of desktop, and one typical of mobile" />


Luckily, GoRouter’s declarative routing API can help. Create two separate routing declarations and switch to the appropriate route when your user toggles UI modes. In this situation, if the desktop UI has tracked the user’s last activity to the red panel when a request to activate the mobile UI comes in, calling `mobileRouter.go(‘home/blue/red’)` will create a navigation stack with a synthetic history, allowing the user to press the Back button to escape the red screen.

```dart
final desktopRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => FourPanels(),
    ),
  ],
);

final mobileRouter = GoRouter(
  routes: [
    // One route for each panel, configured to wire up
    // the Back button if a user arrives on one of the nested panels
    GoRoute(
      path: '/home/blue',
      builder: (context, state) => BluePanel(),
      routes: [
        GoRoute(
          path: 'red',
          builder: (context, state) => RedPanel(),
          routes: [
            GoRoute(
              path: 'green',
              builder: (context, state) => GreenPanel(),
              routes: [
                GoRoute(
                  path: 'yellow',
                  builder: (context, state) => YellowPanel(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
```


Highly adaptive UIs like Google Earth’s require an implementation that treats all possible scenarios as always in play, even though only one given UI is ever being rendered. This means that the app must always be able to *completely* reconstruct its state from resources you completely control — whether that is because you have GlobalKeys to retain State objects holding important information, or because you’ve stored all relevant details in your state management classes.

## Adapting to user inputs

All of this left only one more tricky adaptability problem: ensuring controls across their UI were amenable to the user’s last-used peripherals and not just the reigning UI strategy. After all, if a tablet user started clicking a Bluetooth mouse; Google Earth wasn’t going to wholesale switch to their desktop UI, but they *did* want to slightly tweak elements to leverage a keyboard and mouse’s strengths.

Merely using Flutter meant Google Earth was off to a good start here. Imagine the alternative: an app that is split across three codebases (JavaScript for desktop via web, and Swift and Kotlin for mobile), when the Swift and Kotlin teams realize that it would be awfully nice if, *in some scenarios*, they could borrow elements from the JavaScript app’s UI. Maybe what they need can be re-implemented simply enough; or maybe not. Either way; in a Flutter app, the existing tool you want to borrow is always in the same codebase.

But code sharing is not code organization, and the question of how to implement this coherently remained. Here, the Google Earth team turned to an old Flutter staple: the builder pattern.

```dart
/// High level categories of user inputs.
enum InputType { gamepad, keyboardAndMouse, touch }

/// Builds a widget tree that depends on the user's current [InputType].
class InputTypeBuilder extends StatelessWidget {
  /// Called when the [InputType] data updates.
  final Function(BuildContext, InputTypeModel, Widget?) builder;

  /// Constructs a wrapping widget that will invoke the [builder] whenever
  /// [InputType] changes.
  ///
  /// See [InputTypeModel] for details on how to change [InputType].
  const InputTypeBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<InputTypeModel>(
      builder: (context, inputTypeModel, _) {
        return builder(
          context,
          inputTypeModel.inputType,
        );
      },
    );
  }
}
```


A widget like `InputTypeBuilder` listens to a top-level mechanism, the `InputTypeModel`, which itself subscribes to the Flutter Engine for updates on the last-used input. `InputTypeModel.inputType` is a property of the `InputType` enum. And with that, child widgets can make localized decisions about how to render themselves in light of how the user is currently interacting with the app. For example, if you had been using a mouse, but then tapped your finger on the touch screen, affordances that were once only revealed by the cursor’s hover effect would now appear all over the app. And similarly, if you switched back to using the mouse, this `InputTypeBuilder` would allow them to reverse the change.

```dart
@override
Widget build(BuildContext context) {
  return InputTypeBuilder(
    builder: (context, inputTypeModel, child) {
      final bool isHoveredOrTouchInput = isHovered || inputTypeModel.inputType == InputType.touch;
      return Row(
        children: <Widget>[
          isHoveredOrTouchInput ? DragIndicator() : Container(),
          RestOfRow(),
        ],
      );
    },
  );
}
```


The following gif shows Google Earth’s desktop UI (running in Chrome), nimbly adjusting to the user alternating between touchscreen and mouse actions.

<DashImage figure src="images/17hP0qPviv5Hrh7U82WWhQg.gif" alt="Google Earth’s UI swapping between typical desktop and mobile affordances as the end-user interacts with different peripherals" caption="Google Earth’s UI swapping between typical desktop and mobile affordances as the end-user interacts with different peripherals" />


## Conclusion

The biggest unexpected wins rebuilding Google Earth with Flutter came to users of the tweener environments — tablets and the web. Caught awkwardly between phones and laptops; tablets can physically support both types of experiences but rarely enjoy the software flexibility to match. Similarly, web experiences can be loaded on any device; and on desktop, browsers can be arbitrarily resized. Depending on the app, all of this can imply radically different UIs. For most development teams with separate codebases for each build target, fully supporting users caught in these limbo states is a non-starter. (Imagine convincing your boss to spend the time rebuilding your entire desktop UI on mobile, just in case a tablet user wants it!)

But, as the Google Earth team found, while building a fully adaptive UI in one codebase did imply extra complexity, it was dwarfed by the user experience improvements gained by meeting each and every user exactly where they were.

You can try Google Earth’s new Flutter implementation today by downloading the app on Android or iOS, or visiting [https://earth.google.com](https://earth.google.com).
