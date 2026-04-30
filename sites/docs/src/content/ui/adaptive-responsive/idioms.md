---
title: Platform idioms
description: >-
  Learn how to create a responsive app
  that responds to changes in the screen size.
shortTitle: Idioms
---

<?code-excerpt path-base="ui/adaptive_app_demos"?>

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

## Consider expected behavior on each platform

The first step is to spend some time considering what
the expected appearance, presentation,
or behavior is on this platform.
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

### Find a platform advocate

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

:::secondary Important
Advocates don't need to be developers or
even full-time team members. They can be designers,
stakeholders, or external testers that are provided
with regular builds.
:::

### Stay unique

Conforming to expected behaviors doesn't mean that your app
needs to use default components or styling.
Many of the most popular multiplatform apps have very distinct
and opinionated UIs including custom buttons, context menus,
and title bars.

The more you can consolidate styling and behavior across platforms,
the easier development and testing will be.
The trick is to balance creating a unique experience with a
strong identity, while respecting the norms of each platform.

## Common idioms and norms to consider

Take a quick look at a few specific norms and idioms
you might want to consider, and how you could approach
them in Flutter.

### Scrollbar appearance and behavior

Desktop and mobile users expect scrollbars,
but they expect them to behave differently on different platforms.
Mobile users expect smaller scrollbars that only appear
while scrolling, whereas desktop users generally expect
omnipresent, larger scrollbars that they can click or drag.

Flutter comes with a built-in `Scrollbar` widget that already
has support for adaptive colors and sizes according to the
current platform. The one tweak you might want to make is to
toggle `alwaysShown` when on a desktop platform:

<?code-excerpt "lib/pages/adaptive_grid_page.dart (scrollbar-always-shown)"?>
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

### Multi-select

Dealing with multi-select within a list is another area
with subtle differences across platforms:

<?code-excerpt "lib/widgets/extra_widget_excerpts.dart (multi-select-shift)"?>
```dart
static bool get isSpanSelectModifierDown =>
    isKeyDown({LogicalKeyboardKey.shiftLeft, LogicalKeyboardKey.shiftRight});
```

To perform a platform-aware check for control or command,
you can write something like this:

<?code-excerpt "lib/widgets/extra_widget_excerpts.dart (multi-select-modifier-down)"?>
```dart
static bool get isMultiSelectModifierDown {
  bool isDown = false;
  if (Platform.isMacOS) {
    isDown = isKeyDown({
      LogicalKeyboardKey.metaLeft,
      LogicalKeyboardKey.metaRight,
    });
  } else {
    isDown = isKeyDown({
      LogicalKeyboardKey.controlLeft,
      LogicalKeyboardKey.controlRight,
    });
  }
  return isDown;
}
```

A final consideration for keyboard users is the **Select All** action.
If you have a large list of items of selectable items,
many of your keyboard users will expect that they can use
`Control+A` to select all the items.

#### Touch devices

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

### Selectable text

A common expectation on the web (and to a lesser extent desktop)
is that most visible text can be selected with the mouse cursor.
When text is not selectable,
users on the web tend to have an adverse reaction.

Luckily, this is easy to support with the [`SelectableText`][] widget:

<?code-excerpt "lib/widgets/extra_widget_excerpts.dart (selectable-text)"?>
```dart
return const SelectableText('Select me!');
```

To support rich text, then use `TextSpan`:

<?code-excerpt "lib/widgets/extra_widget_excerpts.dart (rich-text-span)"?>
```dart
return const SelectableText.rich(
  TextSpan(
    children: [
      TextSpan(text: 'Hello'),
      TextSpan(
        text: 'Bold',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ],
  ),
);
```

[`SelectableText`]: {{site.api}}/flutter/material/SelectableText-class.html

### Title bars

On modern desktop applications, it's common to customize
the title bar of your app window, adding a logo for
stronger branding or contextual controls to help save
vertical space in your main UI.

![Samples of title bars](/assets/images/docs/ui/adaptive-responsive/titlebar.png){:width="100%"}

This isn't supported directly in Flutter, but you can use the
[`bits_dojo`][] package to disable the native title bars,
and replace them with your own.

This package lets you add whatever widgets you want to the
`TitleBar` because it uses pure Flutter widgets under the hood.
This makes it easy to adapt the title bar as you navigate
to different sections of the app.

[`bits_dojo`]: {{site.github}}/bitsdojo/bitsdojo_window

### Context menus and tooltips

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

<?code-excerpt "lib/widgets/extra_widget_excerpts.dart (tooltip)"?>
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

### Horizontal button order

On Windows, when presenting a row of buttons,
the confirmation button is placed at the start of
the row (left side). On all other platforms,
it's the opposite. The confirmation button is
placed at the end of the row (right side).

This can be easily handled in Flutter using the
`TextDirection` property on `Row`:

<?code-excerpt "lib/widgets/ok_cancel_dialog.dart (row-text-direction)"?>
```dart
TextDirection btnDirection = DeviceType.isWindows
    ? TextDirection.rtl
    : TextDirection.ltr;
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

![Sample of embedded image](/assets/images/docs/ui/adaptive-responsive/embed_image1.png){:width="75%"}

![Sample of embedded image](/assets/images/docs/ui/adaptive-responsive/embed_image2.png){:width="90%"}

### Menu bar

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

### Drag and drop

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

In Flutter, you can implement drag and drop in many ways.
Discussing specific implementations is outside
the scope of this article, but some high level options
include the following:

* Use the [`Draggable`][] and [`DragTarget`][] APIs
  directly for a custom look and feel.

* Hook into `onPan` gesture events,
  and move an object yourself within a parent `Stack`.

* Use one of the [pre-made list packages][] on pub.dev.

[`Draggable`]: {{site.api}}/flutter/widgets/Draggable-class.html
[`DragTarget`]: {{site.api}}/flutter/widgets/DragTarget-class.html
[pre-made list packages]: {{site.pub}}/packages?q=reorderable+list
