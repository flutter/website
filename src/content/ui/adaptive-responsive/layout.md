---
title: Layout for adaptive apps
description: >
  Learn how to create a responsive app >
  that responds to changes in the screen size.
short-title: Layout
---

<?code-excerpt path-base="ui/adaptive_app_demos"?>

<b>TODO(sfshaza): I'm coalescing this page from two previous pages. I'm not done with the text. It likely also needs code or other updates.</b>

Flutter allows you to create apps that self-adapt
to the device's screen size and orientation.

## General advice

When creating a layout that automatically adapts
to the size and shape of the user's device,
there are several things you might keep in mind.
This page covers how to take an app build for a
phone and make it beautiful on a wide range of devices.

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
want your UI to change its layout,
as described in the next section.

### Screen-based breakpoints

The simplest form of procedural layouts uses
screen-based breakpoints. There are no
hard and fast rules for the sizes to use
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

<b>TODO(sfshaza): PENDING: Should the following example be updated to use Display instead of MediaQuery?</b>

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
the user isn't on a handset (mobile device):

<b>TODO(sfshaza): PENDING: Should the following example be updated to use Display instead of MediaQuery?</b>

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
The calling function decides how to handle the UI.
You can also adjust your display based on the
device's height, the aspect ratio, or some other property.

### MediaQuery

You can determine the current screen size by using the
[`MediaQuery.of()`][] method in your widget's build function.
Keep in mind that this approach returns the current size
and orientation of the app's entire screen and
not just a single widget.

<b>TODO(sfshaza): PENDING: Do we need an example here?</b>

In this scenario, the `build` function
automatically runs when the user is _done_
resizing the screen. However, this isn't
particularly interactive. What you
likely want to see is the UI changing in
real time as the user resizes the window.

[`MediaQuery`]: {{site.api}}/flutter/widgets/MediaQuery-class.html
[`MediaQuery.of()`]: {{site.api}}/flutter/widgets/MediaQuery/of.html

### LayoutBuilder

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

`LayoutBuilder` also provides an interactive approach:
From a `LayoutBuilder`'s [`builder`][] property,
extract the [`BoxConstraints`][] object and
examine the constraint's properties to decide
what to display.

For example of modifying orientation:

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

When the constraints change (for example,
the user rotates the phone or puts your app
app into a tile UI on Android), Flutter calls
the `LayoutBuilder`'s `build` function.

You can also adjust your display based on the
device's height, the aspect ratio,
or some other property.
When the constraints change (for example,
the user rotates the phone, resizes the window,
or puts your app into a tile UI on Android),
the `LayoutBuilder` re-runs its build method,
updating the layout in real time.

---

Learn more in the following 5-minute video:

<iframe width="560" height="315" src="{{site.yt.embed}}/HD5gYnspYzk?si=KvEOAYbOn7lAfKmP" title="Learn the difference between adaptive and responsive apps" {{site.yt-set}}></iframe>

[Adaptive vs responsive][]

[Adaptive vs responsive]: {{site.youtube-site}}/watch?v=HD5gYnspYzk

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

[`BoxConstraints`]: {{site.api}}/flutter/rendering/BoxConstraints-class.html
[Build Responsive UIs in Flutter]: {{site.medium}}/flutter-community/build-responsive-uis-in-flutter-fd450bd59158
[`builder`]: {{site.api}}/flutter/widgets/LayoutBuilder/builder.html
[Developing for Multiple Screen Sizes and Orientations in Flutter]: {{site.medium}}/flutter-community/developing-for-multiple-screen-sizes-and-orientations-in-flutter-fragments-in-flutter-a4c51b849434

[How to make flutter app responsive according to different screen size?]: {{site.so}}/questions/49704497/how-to-make-flutter-app-responsive-according-to-different-screen-size
[`LayoutBuilder`]: {{site.api}}/flutter/widgets/LayoutBuilder-class.html
[Making Cross-platform Flutter Landing Page Responsive]: {{site.medium}}/flutter-community/making-cross-platform-flutter-landing-page-responsive-7fffe0655970

---

## Creating an adaptive Flutter app

You might also check out the following episodes
of The Boring Show:

<iframe style="max-width: 100%" width="560" height="315" src="{{site.yt.embed}}/n6Awpg1MO6M" title="Learn about adaptative layouts on the Boring Show" {{site.yt-set}}></iframe>

[Adaptive layouts][]

<iframe style="max-width: 100%" width="560" height="315" src="{{site.yt.embed}}/eikOZzfc0l4" title="Continue to learn about adaptative layouts on the Boring Show" {{site.yt-set}}></iframe>

[Adaptive layouts, part 2][]

For a great example of an adaptive app,
check out Flutter Folio, a scrapbooking app created
in collaboration with gskinner and the Flutter team:

<iframe style="max-width: 100%" width="560" height="315" src="{{site.yt.embed}}/yytBENOnF0w" title="Watch a demonstration of the Flutter Folio app" {{site.yt-set}}></iframe>

The [Folio source code][] is also available on GitHub.
Learn more on the [gskinner blog][].

[Adaptive layouts]: {{site.yt.watch}}?v=n6Awpg1MO6M&t=694s
[Adaptive layouts, part 2]: {{site.yt.watch}}?v=eikOZzfc0l4&t=11s
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
[Platform-specific behaviors and adaptations]: /platform-integration/platform-adaptations

### Contextual layout

If you need more than density changes and can't find a
widget that does what you need, you can take a more
procedural approach to adjust parameters, calculate sizes,
swap widgets, or completely restructure your UI to suit
a particular form factor.

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

![Adaptive scaffold 2](/assets/images/docs/ui/adaptive-responsive/adaptive_scaffold2.gif){:width="100%"}

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

