---
title: Layout for adaptive apps
description: >
  Learn how to create a responsive app >
  that responds to changes in the screen size.
short-title: Layout
---

xxx This page is in the process of being coalesced; it's currently fairly repetitive as it comes from two sources

{% include docs/yt_shims.liquid %}

Flutter allows you to create apps that self-adapt
to the device's screen size and orientation.

## Two approaches

There are at least two ways you can create a
UI that responds to a change in screen size.
Each approach has its pros and cons.

* `MediaQuery.of`
  * Returns screen size used by entire app.
  * Updates layout when user completes a size
    or orientation change.
* `LayoutBuilder` 
  * Returns screen size used by a particular widget.
  * Updates layout in real time as the user
    changes size or orientation.

For either approach, you need to determine
the sizes (called _breakpoints_) where you
want your UI to change its layout.
The following examples use a pixel width of
1201 or more to indicate an ultra wide display,
601 to 1200 pixels for a wide display,
301 to 600 pixels for a narrow display,
and a width of 300 pixels or less for an
ultra narrow display.

The calling function decides how to handle the UI.
For example, using the screen size examples above,
if the screen is 1201 pixels or more,
return a [`Scaffold`][] object with a row
that has a list on the left (a side nav).
If the screen is less than 300 pixels wide,
return a [`Scaffold`][] object with a drawer
containing that list (assumes bottom navigation).

You can also adjust your display based on the
device's height, the aspect ratio,
or some other property.

### MediaQuery

You can determine the current screen size by using the
[`MediaQuery.of()`][] method in your widget's build function.
Keep in mind that this method returns the current size
and orientation of the app's entire screen and
not just a single widget.

The following example code uses `MediaQuery.of`
to calculate the breakpoints:

```dart
final screenWidth = MediaQuery.of(context).size.width;

if (screenWidth > 1200) {
  return UltraWideLayout();
} else if (screenwidth > 600) {
  return WideLayout();
} else if (screenwidth > 300) {
  return NarrowLayout();
} else {
  return UltraNarrowLayout();
}
```

With this approach the `build` function
automatically runs when the user is _done_
resizing the screen. However, this isn't a
particularly reactive approach. What you
likely want to see is the UI changing in
real time as the user resizes the window.

[`MediaQuery`]: {{site.api}}/flutter/widgets/MediaQuery-class.html
[`MediaQuery.of()`]: {{site.api}}/flutter/widgets/MediaQuery/of.html

### LayoutBuilder

To accomplish a more reactive approach,
use the `LayoutBuilder` class.
From a `LayoutBuilder`'s [`builder`][] property,
extract the [`BoxConstraints`][] object.
Examine the constraint's properties to decide
what to display.

When the constraints change (for example,
the user rotates the phone or puts your app
app into a tile UI on Android), Flutter calls
the `LayoutBuilder`'s `build` function.

The following code, similar to the code for
`MediaQuery`, shows how the layout
builder might calculate the breakspoints for
the device's size:

```dart
LayoutBuilder()
  ...
  child: LayoutBuilder(
    builder: (context, constraints) {
      if (constraints.maxWidth > 1200) {
        return UltraWideLayout();
      } else if (constraints.maxWidth > 600) {
        return WideLayout();
      } else {
        return NarrowLayout();
    }
    ...
```

You can also adjust your display based on the
device's height, the aspect ratio,
or some other property.
When the constraints change (for example,
the user rotates the phone, resizes the window,
or puts your app into a tile UI on Android),
the `LayoutBuilder` re-runs its build method,
updating the layout in real time.

The `LayoutBuilder`'s `build` method then
decides how to handle this change.
For example, if the layout is `UltraWideLayout`
or `WideLayout`, return a sidenav—such as
a [`Scaffold`][] object with a row that has
a list on the left. If the layout is
`NarrowWide`, return a navigation drawer—or
a drawer containing that list.

[PENDING: Needs example code]

## Respond to large screen devices

You can optimize your app to improve its
look and feel on large screens. 
Flutter defines [large screens][] as tablets,
foldables, and ChromeOS devices running Android.
Demand for large screens continues to increase. 
As of December 2023, more than
[270 million active large screen][] and 
foldable devices run on Android.

---

Learn more in the following 5-minute video:

<iframe width="560" height="315" src="{{yt-embed}}/HD5gYnspYzk?si=dsA37QUjHBb2Zh_-" title="Learn the difference between adaptive and responsive Flutter apps" {{yt-set}}></iframe>
[Adaptive vs responsive][]

[Adaptive vs responsive]: {{site.youtube-site}}/HD5gYnspYzk?si=5ItDD7UjXvGCRM0K

### Other resources

For more information, here are a few resources,
including contributions from the Flutter community:

* [Developing for Multiple Screen Sizes and Orientations in
  Flutter][] by Deven Joshi
* [Build Responsive UIs in Flutter][] by Raouf Rahiche
* [Making Cross-platform Flutter Landing Page Responsive][]
  by Priyanka Tyagi
* [How to make flutter app responsive according to different screen
  size?][], a question on StackOverflow

[`AspectRatio`]: {{site.api}}/flutter/widgets/AspectRatio-class.html
[`BoxConstraints`]: {{site.api}}/flutter/rendering/BoxConstraints-class.html
[Build Responsive UIs in Flutter]: {{site.medium}}/flutter-community/build-responsive-uis-in-flutter-fd450bd59158
[`builder`]: {{site.api}}/flutter/widgets/LayoutBuilder/builder.html
[`CustomMultiChildLayout`]: {{site.api}}/flutter/widgets/CustomMultiChildLayout-class.html
[`CustomSingleChildLayout`]: {{site.api}}/flutter/widgets/CustomSingleChildLayout-class.html
[Developing for Multiple Screen Sizes and Orientations in Flutter]: {{site.medium}}/flutter-community/developing-for-multiple-screen-sizes-and-orientations-in-flutter-fragments-in-flutter-a4c51b849434
[`FittedBox`]: {{site.api}}/flutter/widgets/FittedBox-class.html

[`FractionallySizedBox`]: {{site.api}}/flutter/widgets/FractionallySizedBox-class.html
[How to make flutter app responsive according to different screen size?]: {{site.so}}/questions/49704497/how-to-make-flutter-app-responsive-according-to-different-screen-size
[`LayoutBuilder`]: {{site.api}}/flutter/widgets/LayoutBuilder-class.html
[Making Cross-platform Flutter Landing Page Responsive]: {{site.medium}}/flutter-community/making-cross-platform-flutter-landing-page-responsive-7fffe0655970
[`maxWidth`]: {{site.api}}/flutter/rendering/BoxConstraints/maxWidth.html
[`OrientationBuilder`]: {{site.api}}/flutter/widgets/OrientationBuilder-class.html
[`Scaffold`]: {{site.api}}/flutter/material/Scaffold-class.html

## Creating an adaptive Flutter app

Learn more about creating an adaptive Flutter app with
[Building adaptive apps][], written by the gskinner team.

You might also check out the following episodes
of The Boring Show:

<iframe style="max-width: 100%" width="560" height="315" src="{{yt-embed}}/n6Awpg1MO6M" title="Learn about adaptative layouts on the Boring Show" {{yt-set}}></iframe>
[Adaptive layouts][]

<iframe style="max-width: 100%" width="560" height="315" src="{{yt-embed}}/eikOZzfc0l4" title="Continue to learn about adaptative layouts on the Boring Show" {{yt-set}}></iframe>
[Adaptive layouts, part 2][]

For an excellent example of an adaptive app,
check out Flutter Folio, a scrapbooking app created
in collaboration with gskinner and the Flutter team:

<iframe style="max-width: 100%" width="560" height="315" src="{{yt-embed}}/yytBENOnF0w" title="Watch a demonstration of the Flutter Folio app" {{yt-set}}></iframe>

The [Folio source code][] is also available on GitHub.
Learn more on the [gskinner blog][].

[Adaptive layouts]: {{yt-watch}}?v=n6Awpg1MO6M&t=694s
[Adaptive layouts, part 2]: {{yt-watch}}?v=eikOZzfc0l4&t=11s
[Building adaptive apps]: {{site.url}}/ui/layout/responsive/building-adaptive-apps
[Folio source code]: {{site.github}}/gskinnerTeam/flutter-folio
[gskinner blog]: https://blog.gskinner.com/

### Other resources

You can learn more about creating platform-adaptive apps
in the following resources:

* [Platform-specific behaviors and adaptations][],
  a page on this site.
* [Designing truly adaptive user interfaces][],
  presented at the Flutter Vikings 2020 conference
  by Aloïs Deniel,

[Designing truly adaptive user interfaces]: https://www.aloisdeniel.com/blog/designing-truly-adaptative-user-interfaces
[Platform-specific behaviors and adaptations]: {{site.url}}/platform-integration/platform-adaptations

### Contextual layout

If you need more than density changes and can't find a
widget that does what you need, you can take a more
procedural approach to adjust parameters, calculate sizes,
swap widgets, or completely restructure your UI to suit
a particular form factor.

#### Screen-based breakpoints

The simplest form of procedural layouts uses
screen-based breakpoints. In Flutter,
this can be done with the `MediaQuery` API.
There are no hard and fast rules for the sizes to use
here, but these are general values:

<?code-excerpt "lib/global/device_size.dart (FormFactor)"?>
```dart
class FormFactor {
  static double desktop = 900;
  static double tablet = 600;
  static double handset = 300;
}
```

Using breakpoints, you can set up a simple system
to determine the device type:

<?code-excerpt "lib/global/device_size.dart (getFormFactor)"?>
```dart
ScreenType getFormFactor(BuildContext context) {
  // Use .shortestSide to detect device type regardless of orientation
  double deviceWidth = MediaQuery.of(context).size.shortestSide;
  if (deviceWidth > FormFactor.desktop) return ScreenType.desktop;
  if (deviceWidth > FormFactor.tablet) return ScreenType.tablet;
  if (deviceWidth > FormFactor.handset) return ScreenType.handset;
  return ScreenType.watch;
}
```

As an alternative, you could abstract it more
and define it in terms of small to large:

<?code-excerpt "lib/global/device_size.dart (ScreenSize)"?>
```dart
enum ScreenSize { small, normal, large, extraLarge }

ScreenSize getSize(BuildContext context) {
  double deviceWidth = MediaQuery.of(context).size.shortestSide;
  if (deviceWidth > 900) return ScreenSize.extraLarge;
  if (deviceWidth > 600) return ScreenSize.large;
  if (deviceWidth > 300) return ScreenSize.normal;
  return ScreenSize.small;
}
```

Screen-based breakpoints are best used for making
top-level decisions in your app. Changing things like
visual density, paddings, or font-sizes are best when
defined on a global basis.

You can also use screen-based breakpoints to reflow your
top-level widget trees. For example, you could switch
from a vertical to a horizontal layout when
the user isn't on a handset:

<?code-excerpt "lib/global/device_size.dart (MediaQuery)"?>
```dart
bool isHandset = MediaQuery.of(context).size.width < 600;
return Flex(
  direction: isHandset ? Axis.vertical : Axis.horizontal,
  children: const [Text('Foo'), Text('Bar'), Text('Baz')],
);
```

In another widget,
you might swap some of the children completely:

<?code-excerpt "lib/global/device_size.dart (WidgetSwap)"?>
```dart
Widget foo = Row(
  children: [
    ...isHandset ? _getHandsetChildren() : _getNormalChildren(),
  ],
);
```

#### Use LayoutBuilder for extra flexibility

Even though checking total screen size is great for
full-screen pages or making global layout decisions,
it's often not ideal for nested subviews.
Often, subviews have their own internal breakpoints
and care only about the space that they have available to render.

The simplest way to handle this in Flutter is using the
[`LayoutBuilder`][] class. `LayoutBuilder` allows a
widget to respond to incoming local size constraints,
which can make the widget more versatile than if it
depended on a global value.

The previous example could be rewritten using `LayoutBuilder`:

<?code-excerpt "lib/widgets/extra_widget_excerpts.dart (LayoutBuilder)"?>
```dart
Widget foo = LayoutBuilder(builder: (context, constraints) {
  bool useVerticalLayout = constraints.maxWidth < 400;
  return Flex(
    direction: useVerticalLayout ? Axis.vertical : Axis.horizontal,
    children: const [
      Text('Hello'),
      Text('World'),
    ],
  );
});
```

This widget can now be composed within a side panel,
dialog, or even a full-screen view,
and adapt its layout to whatever space is provided.

#### Device segmentation

There are times when you want to make layout decisions
based on the actual platform you're running on,
regardless of size. For example, when building a
custom title bar, you might need to check the operating
system type and tweak the layout of your title bar,
so it doesn't get covered by the native window buttons.

To determine which combination of platforms you're on,
you can use the [`Platform`][] API along with the `kIsWeb` value:

<?code-excerpt "lib/global/device_type.dart (Platforms)"?>
```dart
bool get isMobileDevice => !kIsWeb && (Platform.isIOS || Platform.isAndroid);
bool get isDesktopDevice =>
    !kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux);
bool get isMobileDeviceOrWeb => kIsWeb || isMobileDevice;
bool get isDesktopDeviceOrWeb => kIsWeb || isDesktopDevice;
```

The `Platform` API can't be accessed from web builds without
throwing an exception, because the `dart.io` package isn't
supported on the web target. As a result, the above code checks
for web first, and because of short-circuiting,
Dart never calls `Platform` on web targets.

Use `Platform`/`kIsWeb` when the logic absolutely <i>must</i>
run for a given platform. For example,
talking to a plugin that only works on iOS,
or displaying a widget that only conforms to
Play Store policy and not the App Store's.

[`Platform`]: {{site.api}}/flutter/package-platform_platform/Platform-class.html

### Single source of truth for styling

You'll probably find it easier to maintain your views
if you create a single source of truth for styling values
like padding, spacing, corner shape, font sizes, and so on.
This can be done easily with some helper classes:

<?code-excerpt "lib/global/device_type.dart (Styling)"?>
```dart
class Insets {
  static const double xsmall = 3;
  static const double small = 4;
  static const double medium = 5;
  static const double large = 10;
  static const double extraLarge = 20;
  // etc
}

class Fonts {
  static const String raleway = 'Raleway';
  // etc
}

class TextStyles {
  static const TextStyle raleway = TextStyle(
    fontFamily: Fonts.raleway,
  );
  static TextStyle buttonText1 =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 14);
  static TextStyle buttonText2 =
      const TextStyle(fontWeight: FontWeight.normal, fontSize: 11);
  static TextStyle h1 =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 22);
  static TextStyle h2 =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
  static TextStyle body1 = raleway.copyWith(color: const Color(0xFF42A5F5));
  // etc
}
```

These constants can then be used in place of hard-coded numeric values:

<?code-excerpt "lib/global/device_type.dart (UseConstants)"?>
```dart
return Padding(
  padding: const EdgeInsets.all(Insets.small),
  child: Text('Hello!', style: TextStyles.body1),
);
```

Use `Theme.of(context).platform` for theming and
design choices, like what kind of switches to show
and general Cupertino/Material adaptions.

With all views referencing the same shared-design system rules,
they tend to look better and more consistent.
Making a change or adjusting a value for a specific platform
can be done in a single place, instead of using an error-prone
search and replace. Using shared rules has the added benefit
of helping enforce consistency on the design side.

Some common design system categories that can be represented
this way are:

* Animation timings
* Sizes and breakpoints
* Insets and paddings
* Corner radius
* Shadows
* Strokes
* Font families, sizes, and styles

Like most rules, there are exceptions:
one-off values that are used nowhere else in the app.
There is little point in cluttering up the styling rules
with these values, but it's worth considering if they
should be derived from an existing value (for example,
`padding + 1.0`). You should also watch for reuse or duplication
of the same semantic values. Those values should likely be
added to the global styling ruleset.

### Design to the strengths of each form factor

Beyond screen size, you should also spend time
considering the unique strengths and weaknesses
of different form factors. It isn't always ideal
for your multiplatform app to offer identical
functionality everywhere. Consider whether it makes
sense to focus on specific capabilities,
or even remove certain features, on some device categories.

For example, mobile devices are portable and have cameras,
but they aren't well suited for detailed creative work.
With this in mind, you might focus more on capturing content
and tagging it with location data for a mobile UI,
but focus on organizing or manipulating that content
for a tablet or desktop UI.

Another example is leveraging the web's extremely low barrier
for sharing. If you're deploying a web app,
decide which deep links to support,
and design your navigation routes with those in mind.

The key takeaway here is to think about what each
platform does best and see if there are unique capabilities
you can leverage.

### Use desktop build targets for rapid testing

One of the most effective ways to test adaptive
interfaces is to take advantage of the desktop build targets.

When running on a desktop, you can easily resize the window
while the app is running to preview various screen sizes.
This, combined with hot reload, can greatly accelerate the
development of a responsive UI.

![Adaptive scaffold 2](/assets/images/docs/development/ui/layout/adaptive_scaffold2.gif){:width="100%"}

### Solve touch first

Building a great touch UI can often be more difficult
than a traditional desktop UI due, in part,
to the lack of input accelerators like right-click,
scroll wheel, or keyboard shortcuts.

One way to approach this challenge is to focus initially
on a great touch-oriented UI. You can still do most of
your testing using the desktop target for its iteration speed.
But, remember to switch frequently to a mobile device to
verify that everything feels right.

After you have the touch interface polished, you can tweak
the visual density for mouse users, and then layer on all
the additional inputs. Approach these other inputs as
accelerator—alternatives that make a task faster.
The important thing to consider is what a user expects
when using a particular input device,
and work to reflect that in your app.

## Idioms and norms

The final area to consider for adaptive apps is platform standards.
Each platform has its own idioms and norms;
these nominal or de facto standards inform user expectations
of how an application should behave. Thanks, in part to the web,
users are accustomed to more customized experiences,
but reflecting these platform standards can still provide
significant benefits:

* **Reduce cognitive load**
: By matching the user's existing mental model,
  accomplishing tasks becomes intuitive,
  which requires less thinking,
  boosts productivity, and reduces frustrations.

* **Build trust**
: Users can become wary or suspicious
  when applications don't adhere to their expectations.
  Conversely, a UI that feels familiar can build user trust
  and can help improve the perception of quality.
  This often has the added benefit of better app store
  ratings—something we can all appreciate!

### Consider expected behavior on each platform

The first step is to spend some time considering what
the expected appearance, presentation, or behavior is on this platform.
Try to forget any limitations of your current implementation,
and just envision the ideal user experience.
Work backwards from there.

Another way to think about this is to ask,
"How would a user of this platform expect to achieve this goal?"
Then, try to envision how that would work in your app
without any compromises.

This can be difficult if you aren't a regular user of the platform.
You might be unaware of the specific idioms and can easily miss
them completely. For example, a lifetime Android user is
likely unaware of platform conventions on iOS,
and the same holds true for macOS, Linux, and Windows.
These differences might be subtle to you,
but be painfully obvious to an experienced user.

#### Find a platform advocate

If possible, assign someone as an advocate for each platform.
Ideally, your advocate uses the platform as their primary device,
and can offer the perspective of a highly opinionated user.
To reduce the number of people, combine roles.
Have one advocate for Windows and Android,
one for Linux and the web, and one for Mac and iOS.

The goal is to have constant, informed feedback so the app
feels great on each platform. Advocates should be encouraged
to be quite picky, calling out anything they feel differs from
typical applications on their device. A simple example is how
the default button in a dialog is typically on the left on Mac
and Linux, but is on the right on Windows.
Details like that are easy to miss if you aren't using a platform
on a regular basis.

{{site.alert.secondary}}
  **Important**: Advocates don't need to be developers or
  even full-time team members. They can be designers,
  stakeholders, or external testers that are provided
  with regular builds.
{{site.alert.end}}

#### Stay unique

Conforming to expected behaviors doesn't mean that your app
needs to use default components or styling.
Many of the most popular multiplatform apps have very distinct
and opinionated UIs including custom buttons, context menus,
and title bars.

The more you can consolidate styling and behavior across platforms,
the easier development and testing will be.
The trick is to balance creating a unique experience with a
strong identity, while respecting the norms of each platform.

### Common idioms and norms to consider

Take a quick look at a few specific norms and idioms
you might want to consider, and how you could approach
them in Flutter.

#### Scrollbar appearance and behavior

Desktop and mobile users expect scrollbars,
but they expect them to behave differently on different platforms.
Mobile users expect smaller scrollbars that only appear
while scrolling, whereas desktop users generally expect
omnipresent, larger scrollbars that they can click or drag.

Flutter comes with a built-in `Scrollbar` widget that already
has support for adaptive colors and sizes according to the
current platform. The one tweak you might want to make is to
toggle `alwaysShown` when on a desktop platform:

<?code-excerpt "lib/pages/adaptive_grid_page.dart (ScrollbarAlwaysShown)"?>
```dart
return Scrollbar(
  thumbVisibility: DeviceType.isDesktop,
  controller: _scrollController,
  child: GridView.count(
    controller: _scrollController,
    padding: const EdgeInsets.all(Insets.extraLarge),
    childAspectRatio: 1,
    crossAxisCount: colCount,
    children: listChildren,
  ),
);
```

This subtle attention to detail can make your app feel more
comfortable on a given platform.

#### Multi-select

Dealing with multi-select within a list is another area
with subtle differences across platforms:

<?code-excerpt "lib/widgets/extra_widget_excerpts.dart (MultiSelectShift)"?>
```dart
static bool get isSpanSelectModifierDown =>
    isKeyDown({LogicalKeyboardKey.shiftLeft, LogicalKeyboardKey.shiftRight});
```

To perform a platform-aware check for control or command,
you can write something like this:

<?code-excerpt "lib/widgets/extra_widget_excerpts.dart (MultiSelectModifierDown)"?>
```dart
static bool get isMultiSelectModifierDown {
  bool isDown = false;
  if (Platform.isMacOS) {
    isDown = isKeyDown(
      {LogicalKeyboardKey.metaLeft, LogicalKeyboardKey.metaRight},
    );
  } else {
    isDown = isKeyDown(
      {LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.controlRight},
    );
  }
  return isDown;
}
```

A final consideration for keyboard users is the **Select All** action.
If you have a large list of items of selectable items,
many of your keyboard users will expect that they can use
`Control+A` to select all the items.

##### Touch devices

On touch devices, multi-selection is typically simplified,
with the expected behavior being similar to having the
`isMultiSelectModifier` down on the desktop.
You can select or deselect items using a single tap,
and will usually have a button to **Select All** or
**Clear** the current selection.

How you handle multi-selection on different devices depends
on your specific use cases, but the important thing is to
make sure that you're offering each platform the best
interaction model possible.

#### Selectable text

A common expectation on the web (and to a lesser extent desktop)
is that most visible text can be selected with the mouse cursor.
When text is not selectable,
users on the web tend to have an adverse reaction.

Luckily, this is easy to support with the [`SelectableText`][] widget:

<?code-excerpt "lib/widgets/extra_widget_excerpts.dart (SelectableText)"?>
```dart
return const SelectableText('Select me!');
```

To support rich text, then use `TextSpan`:

<?code-excerpt "lib/widgets/extra_widget_excerpts.dart (RichTextSpan)"?>
```dart
return const SelectableText.rich(
  TextSpan(
    children: [
      TextSpan(text: 'Hello'),
      TextSpan(text: 'Bold', style: TextStyle(fontWeight: FontWeight.bold)),
    ],
  ),
);
```

[`SelectableText`]: {{site.api}}/flutter/material/SelectableText-class.html

#### Title bars

On modern desktop applications, it's common to customize
the title bar of your app window, adding a logo for
stronger branding or contextual controls to help save
vertical space in your main UI.

![Samples of title bars](/assets/images/docs/development/ui/layout/titlebar.png){:width="100%"}

This isn't supported directly in Flutter, but you can use the
[`bits_dojo`][] package to disable the native title bars,
and replace them with your own.

This package lets you add whatever widgets you want to the
`TitleBar` because it uses pure Flutter widgets under the hood.
This makes it easy to adapt the title bar as you navigate
to different sections of the app.

[`bits_dojo`]: {{site.github}}/bitsdojo/bitsdojo_window

#### Context menus and tooltips

On desktop, there are several interactions that
manifest as a widget shown in an overlay,
but with differences in how they're triggered, dismissed,
and positioned:

* **Context menu**
: Typically triggered by a right-click,
  a context menu is positioned close to the mouse,
  and is dismissed by clicking anywhere,
  selecting an option from the menu, or clicking outside it.

* **Tooltip**
: Typically triggered by hovering for
  200-400ms over an interactive element,
  a tooltip is usually anchored to a widget
  (as opposed to the mouse position) and is dismissed
  when the mouse cursor leaves that widget.

* **Popup panel (also known as flyout)**
: Similar to a tooltip,
  a popup panel is usually anchored to a widget.
  The main difference is that panels are most often
  shown on a tap event, and they usually don't hide
  themselves when the cursor leaves.
  Instead, panels are typically dismissed by clicking
  outside the panel or by pressing a **Close** or **Submit** button.

To show basic tooltips in Flutter,
use the built-in [`Tooltip`][] widget:

<?code-excerpt "lib/widgets/extra_widget_excerpts.dart (Tooltip)"?>
```dart
return const Tooltip(
  message: 'I am a Tooltip',
  child: Text('Hover over the text to show a tooltip.'),
);
```

Flutter also provides built-in context menus when editing
or selecting text.

To show more advanced tooltips, popup panels,
or create custom context menus,
you either use one of the available packages,
or build it yourself using a `Stack` or `Overlay`.

Some available packages include:

* [`context_menus`][]
* [`anchored_popups`][]
* [`flutter_portal`][]
* [`super_tooltip`][]
* [`custom_pop_up_menu`][]

While these controls can be valuable for touch users as accelerators,
they are essential for mouse users. These users expect
to right-click things, edit content in place,
and hover for more information. Failing to meet those expectations
can lead to disappointed users, or at least,
a feeling that something isn't quite right.

[`anchored_popups`]: {{site.pub}}/packages/anchored_popups
[`context_menus`]: {{site.pub}}/packages/context_menus
[`custom_pop_up_menu`]: {{site.pub}}/packages/custom_pop_up_menu
[`flutter_portal`]: {{site.pub}}/packages/flutter_portal
[`super_tooltip`]: {{site.pub}}/packages/super_tooltip
[`Tooltip`]: {{site.api}}/flutter/material/Tooltip-class.html

#### Horizontal button order

On Windows, when presenting a row of buttons,
the confirmation button is placed at the start of
the row (left side). On all other platforms,
it's the opposite. The confirmation button is
placed at the end of the row (right side).

This can be easily handled in Flutter using the
`TextDirection` property on `Row`:

<?code-excerpt "lib/widgets/ok_cancel_dialog.dart (RowTextDirection)"?>
```dart
TextDirection btnDirection =
    DeviceType.isWindows ? TextDirection.rtl : TextDirection.ltr;
return Row(
  children: [
    const Spacer(),
    Row(
      textDirection: btnDirection,
      children: [
        DialogButton(
          label: 'Cancel',
          onPressed: () => Navigator.pop(context, false),
        ),
        DialogButton(
          label: 'Ok',
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
    ),
  ],
);
```

![Sample of embedded image](/assets/images/docs/development/ui/layout/embed_image1.png){:width="75%"}

![Sample of embedded image](/assets/images/docs/development/ui/layout/embed_image2.png){:width="90%"}

#### Menu bar

Another common pattern on desktop apps is the menu bar.
On Windows and Linux, this menu lives as part of the Chrome title bar,
whereas on macOS, it's located along the top of the primary screen.

Currently, you can specify custom menu bar entries using
a prototype plugin, but it's expected that this functionality will
eventually be integrated into the main SDK.

It's worth mentioning that on Windows and Linux,
you can't combine a custom title bar with a menu bar.
When you create a custom title bar,
you're replacing the native one completely,
which means you also lose the integrated native menu bar.

If you need both a custom title bar and a menu bar,
you can achieve that by implementing it in Flutter,
similar to a custom context menu.

#### Drag and drop

One of the core interactions for both touch-based and
pointer-based inputs is drag and drop. Although this
interaction is expected for both types of input,
there are important differences to think about when
it comes to scrolling lists of draggable items.

Generally speaking, touch users expect to see drag handles
to differentiate draggable areas from scrollable ones,
or alternatively, to initiate a drag by using a long
press gesture. This is because scrolling and dragging
are both sharing a single finger for input.

Mouse users have more input options. They can use a wheel
or scrollbar to scroll, which generally eliminates the need
for dedicated drag handles. If you look at the macOS
Finder or Windows Explorer, you'll see that they work
this way: you just select an item and start dragging.

In Flutter, you can implement drag and drop in many
ways. Discussing specific implementations is outside
the scope of this article, but some high level options
are:

* Use the [`Draggable`][] and [`DragTarget`][] APIs
  directly for a custom look and feel.

* Hook into `onPan` gesture events,
  and move an object yourself within a parent `Stack`.

* Use one of the [pre-made list packages][] on pub.dev.  

[`Draggable`]: {{site.api}}/flutter/widgets/Draggable-class.html
[`DragTarget`]: {{site.api}}/flutter/widgets/DragTarget-class.html
[pre-made list packages]: {{site.pub}}/packages?q=reorderable+list
