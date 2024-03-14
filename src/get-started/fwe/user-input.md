---
title: Handling user input
description: Learn how to handle user input in Flutter.
prev:
  title: State Management
  path: /get-started/fwe/state-management
next:
  title: Networking and data
  path: /get-started/fwe/networking
---

Now that you know how to manage state in your Flutter app, how can you let users interact with your app and change its state? 

## Introduction to user input

As a multi-platform UI framework, there are many different ways for users to interact with a Flutter app. The resources in this section will introduce you to some of the common widgets used for enabling user interaction. 

Some user input types, like [scrolling], have already been covered in previous sections. 

For an introduction to how you can change app state in response to user interactions, check out the following tutorial which teaches you how to build a "favorite" button:

<i class="material-symbols" aria-hidden="true">flutter_dash</i> Tutorial: [Add interactivity to your Flutter app][]

## Material 3 demo 

Now that you've gotten a feel for how user interaction works, check out the [Material 3 Demo][] which samples some of the various user input widgets available in the Material 3 component library. 

Note: This page focuses on Material 3 widgets because it is the library that many developers start with when learning Flutter. However, Flutter also supports other component libraries such as [Cupertino][] for iOS-styled widgets.

## Get user input

This section covers widgets that will help you build the most common user input methods into your Flutter app. 

### Click or tap (Buttons)
Let a user prompt action in a UI by clicking or tapping. 

The following are Material 3 button types. Functionally they are similar, but styled differently:

* [ElevatedButton][]: A button with some depth. Use elevated buttons to add dimension to otherwise mostly flat layouts.
* [FilledButton][]: A filled button that should be used for important, final actions that complete a flow, like Save, Join now, or Confirm.
* [TextButton][]: Clickable text, without a border. 
* [OutlinedButton][]: A button with text and a visible border.

[IconButton][]: A button with an icon. 

[FloatingActionButton][]: A circular icon button that hovers over content to promote a primary action.

* Video: [Floating Action Button (Widget of the Week)][]

### Text

[TextField][]: Let users enter text, either with hardware keyboard or with an onscreen keyboard.

This series of cookbook articles will walk you through every stop on how to build a text field, from beginning to end:

1. Article: [Create and style a text field][]
1. Article: [Retrieve the value of a text field][]
1. Article: [Handle changes to a text field][]
1. Article: [Focus and text fields][]

[RichText][]: Display text that uses multiple different styles.

* Video: [Rich Text (Widget of the Week)][]
* Demo: [Rich Text Editor][]
* Sample code: [Rich Text Editor code][]

[SelectableText][]: Display a string of user-selectable text with a single style.

* Video: [SelectableText (Widget of the Week)][]

[Form][]: An optional container for grouping together multiple form field widgets. 

* Article: [Build a form with validation][]
* Demo: [Form App][]
* Sample code: [Form App Code][]

### Select a value from a group of options

[SegmentedButton][]: Allow users to select from limited set of options.

[DropdownMenu][]: Let users select a choice from a menu and put the selected item into the text input field.

* Video: [DropdownMenu (Widget of the Week)][]

[Slider][]: Select from a range of values.

* Video: [Slider, RangeSlider, CupertinoSlider (Widget of the Week)][]

### Toggle values

[Checkbox][]: Select one or more items from a list, or turn an item on or off.

[CheckboxListTile][]: A checkbox with a label.

* Video: [CheckboxListTile (Widget of the Week)][]

[Switch][]: Toggle the on/off state of a single setting.

[SwitchListTile][]: A switch with a label. 

* Video [SwitchListTile (Widget of the Week)][]

[Radio][]: Select between a number of mutually exclusive values. When one radio button in a group is selected, the other radio buttons in the group cease to be selected.

[Chip][]: Chips are compact elements that represent an attribute, text, entity, or action.

### Select a date or time

[showDatePicker][]: Shows a dialog containing a [Material Design date picker][].

[showTimePicker][]: Shows a dialog containing a [Material Design time picker][].

### Swipe and slide

[Dismissible][]: Clear list items by swiping left or right.

* Video: [Dismissible (Widget of the Week)][]
* Article: [Implement swipe to dismiss][]

[pkg:flutter_slidable][]: A Flutter implementation of slidable list item with directional slide actions that can be dismissed.

* Video [flutter_slidable (Package of the Week)][]

## Build your own interactive widget with GestureDetector 

If none of the above widgets fit the functionality what you're looking for, you can add interactivity to your own widget using GestureDetector. 

* Video: [GestureDetector (Widget of the Week)][]
* Documentation: [Taps, drags, and other gestures][]
* Article: [Handle taps][]

Don't forget about accessibility! If you're building your own custom widget, you can annotate its meaning with the Semantics widget. It lets you provide descriptions, metadata, and more to screen readers and other semantic analysis-based tools. 

* Video: [Semantics (Flutter Widget of the Week)][]

Bonus: For a deeper understanding on how Flutter's GestureArena turns raw user interaction data into human recognizable concepts like taps, drags, and pinches:

* Video: [GestureArena (Decoding Flutter)][]

## Testing
Finished building user interactions into your app? Don't forget to write tests to make sure that everything works as expected! 

* Article: [Tap, drag, and enter text][]
* Article: [Handle scrolling][]

## Next: Networking

This page was an introduction to handling user input. Now that you know how to accept input from app's users, you can make your app even more interesting by adding external data. In the next section, you will learn now to fetch data for your app over a network. 

[scrolling]: /get-started/fwe/layout#scrollable-widgets

[Add interactivity to your Flutter app]: /ui/interactivity
[Cupertino]: {{site.api}}flutter/cupertino/cupertino-library.html
[Material 3 Demo]: https://flutter.github.io/samples/web/material_3_demo/

[ElevatedButton]: https://api.flutter.dev/flutter/material/ElevatedButton-class.html
[FilledButton]: https://api.flutter.dev/flutter/material/FilledButton-class.html
[TextButton]: https://api.flutter.dev/flutter/material/TextButton-class.html
[OutlinedButton]: https://api.flutter.dev/flutter/material/OutlinedButton-class.html
[IconButton]: https://api.flutter.dev/flutter/material/IconButton-class.html
[FloatingActionButton]: https://api.flutter.dev/flutter/material/FloatingActionButton-class.html
[FloatingActionButton (Widget of the Week)]: https://youtu.be/2uaoEDOgk_I?si=MQZcSp24oRaS_kiY

[TextField]: {{site.api}}flutter/material/TextField-class.html
[Create and style a text field]: https://docs.flutter.dev/cookbook/forms/text-input
[Retrieve the value of a text field]: https://docs.flutter.dev/cookbook/forms/retrieve-input
[Handle changes to a text field]: https://docs.flutter.dev/cookbook/forms/text-field-changes
[Focus and text fields]: https://docs.flutter.dev/cookbook/forms/focus
[RichText]: https://api.flutter.dev/flutter/widgets/RichText-class.html
[Rich Text (Widget of the Week)]: https://www.youtube.com/watch?v=rykDVh-QFfw
[Rich Text Editor]: https://flutter.github.io/samples/rich_text_editor.html
[Rich Text Editor code]: https://github.com/flutter/samples/tree/main/simplistic_editor
[Form]: https://api.flutter.dev/flutter/widgets/Form-class.html
[Build a form with validation]: https://docs.flutter.dev/cookbook/forms/validation
[Form App]: https://flutter.github.io/samples/web/form_app/
[Form App Code]: https://github.com/flutter/samples/tree/main/form_app
[SelectableText]: https://api.flutter.dev/flutter/material/SelectableText-class.html
[SelectableText (Widget of the Week)]: https://www.youtube.com/watch?v=ZSU3ZXOs6hc

[SegmentedButton]: {{site.api}}flutter/material/SegmentedButton-class.html
[DropdownMenu]: {{site.api}}flutter/material/DropdownMenu-class.html
[DropdownMenu (Widget of the Week)]: https://youtu.be/giV9AbM2gd8?si=E23hjg72cjMTe_mz
[Slider]: {{site.api}}flutter/material/Slider-class.html
[Slider, RangeSlider, CupertinoSlider (Widget of the Week)](https://www.youtube.com/watch?v=ufb4gIPDmEs)


[Checkbox]: {{site.api}}flutter/material/Checkbox-class.html
[CheckboxListTile]: {{site.api}}flutter/material/CheckboxListTile-class.html
[CheckboxListTile (Widget of the Week)]: https://www.youtube.com/watch?v=RkSqPAn9szs
[Switch]: {{site.api}}flutter/material/Switch-class.html
[SwitchListTile]: {{site.api}}flutter/material/SwitchListTile-class.html
[SwitchListTile (Widget of the Week)]: https://www.youtube.com/watch?v=0igIjvtEWNU
[Radio]: {{site.api}}flutter/material/Radio-class.html
[Chips]: {{site.api}}flutter/material/Chip-class.html

[Material Design date picker]: https://m3.material.io/components/date-pickers/overview
[Material Design time picker]: https://m3.material.io/components/time-pickers/overview
[showDatePicker]: {{site.api}}flutter/material/showDatePicker.html
[showTimePicker]: {{site.api}}flutter/material/showTimePicker.html

[Dismissible]: {{site.api}}flutter/widgets/Dismissible-class.html
[Dismissible (Widget of the Week)]: https://youtu.be/iEMgjrfuc58?si=f0S7IdaA9PIWIYvl
[Implement swipe to dismiss]: /cookbook/gestures/dismissible
[pkg:flutter_slidable]: https://pub.dev/packages/flutter_slidable
[flutter_slidable (Package of the Week)]: https://www.youtube.com/watch?v=QFcFEpFmNJ8

[GestureDetector (Widget of the Week)]: https://www.youtube.com/watch?v=WhVXkCFPmK4
[Taps, drags, and other gestures]: /ui/interactivity/gestures#gestures
[Handle taps]: /cookbook/gestures/handling-taps
[Semantics (Flutter Widget of the Week)]: https://youtu.be/NvtMt_DtFrQ?si=o79BqAg9NAl8EE8_
[GestureArena (Decoding Flutter)]: https://www.youtube.com/watch?v=Q85LBtBdi0U

[Tap, drag, and enter text]: https://docs.flutter.dev/cookbook/testing/widget/tap-drag
[Handle scrolling]: https://docs.flutter.dev/cookbook/testing/widget/scrolling