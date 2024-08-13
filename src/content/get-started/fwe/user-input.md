---
title: Handling user input
description: Learn how to handle user input in Flutter.
prev:
  title: State management
  path: /get-started/fwe/state-management
next:
  title: Networking and data
  path: /get-started/fwe/networking
---

Now that you know how to manage state in your
Flutter app, how can you let users interact
with your app and change its state? 

## Introduction to handling user input

As a multi-platform UI framework,
there are many different ways for users
to interact with a Flutter app.
The resources in this section introduce
you to some of the common widgets used
for enabling user interaction within your app. 

Some user input mechanisms, like [scrolling][],
have already been covered in [Layouts][]. 

Flutter ships with two design systems as part of the SDK, [Material][] and [Cupertino][]. For educational purposes, this page focuses on  Material widgets, prebuilt components that are stylized according to the Material design langauge specifications. 

> <i class="material-symbols" aria-hidden="true">menu_book</i> **Reference**: 
> The [widget catalog][] has an inventory of commonly used widgets in the [Material][] and [Cupertino][] libraries.

The Flutter community also creates and supports additional designs systems on [pub.dev][], the package repository for Dart and Flutter. If the existing design system components don't quite fit what you need, Flutter lets you build your own custom designed widget library.

[pub.dev]: https://pub.dev
[Layouts]: /get-started/fwe/layout
[Material]: /ui/widgets/material
[Cupertino]: /ui/widgets/cupertino
[widget catalog]: /ui/widgets#design-systems

In this section, we'll cover a few of the widgets that cover some common usecases for handling user input your Flutter app. 

> <i class="material-symbols" aria-hidden="true">bookmark</i> **Tutorial**: 
> Curious how you can change your app
> state in response to user interactions?
> Complete the following tutorial that
> teaches you how to build a "favorite" button: [Add interactivity to your Flutter app][]

### Buttons

Buttons let a user prompt action in the UI by clicking or tapping. The Material 3 library provides button a variety of button types are functionally similar, but styled differently for various usecases. 

There are generally 3 parts to constructing a button: style, callback, and its child. 

A button's style controls its appearance: color, border, etc. 

<!--- TODO: WidgetStateProperty and styling in the the design section of FWE Of course, a button's appearance can be dependent on its state. You can style a button based on its state using WidgetStateProperty. -->

Its callback determines what happens when the button is clicked. If a `null` callback is provided, the button is disabled and nothing happens when the button is pressed. 

The button's child is what's displayed within the content area of the button, this is usually some text or icon that describes the button's purpose. 

<img src='/assets/images/docs/fwe/user-input/material-buttons.png' alt="A collection of Material 3 Buttons.">

#### `ElevatedButton`
A button with some depth. Use elevated buttons to add dimension to otherwise mostly flat layouts.

```dart
Widget build(BuildContext context) {
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ElevatedButton(
          style: style,
          onPressed: null,
          child: const Text('Disabled'),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          style: style,
          onPressed: () {},
          child: const Text('Enabled'),
        ),
      ],
    ),
  );
}
```
#### `FilledButton`
A filled button that should be used for important,
  final actions that complete a flow,
  like **Save**, **Join now**, or **Confirm**. 

#### `OutlinedButton`
A button with text and a visible border.
  These buttons contain actions that are important,
  but aren't the primary action in an app.

#### `TextButton`
Clickable text, without a border.
  Since text buttons don't have visible borders
  and they must therefore rely on their position
  relative to other content for context.

#### `IconButton`
A button with an icon.

#### `FloatingActionButton`
An icon button that hovers over
  content to promote a primary action.

> <i class="material-symbols" aria-hidden="true">slideshow</i> **Video**: 
> [FloatingActionButton (Widget of the Week)][]


<br>

> <i class="material-symbols" aria-hidden="true">menu_book</i> **API Docs**:  
> [`ElevatedButton`][] | [`FilledButton`][] | [`OutlinedButton`][] | [`TextButton`][] | [`IconButton`][] | [`FloatingActionButton`][]

[`ElevatedButton`]: {{site.api}}/flutter/material/ElevatedButton-class.html
[`FilledButton`]: {{site.api}}/flutter/material/FilledButton-class.html
[`FloatingActionButton`]: {{site.api}}/flutter/material/FloatingActionButton-class.html
[FloatingActionButton (Widget of the Week)]: https://youtu.be/2uaoEDOgk_I?si=MQZcSp24oRaS_kiY
[`IconButton`]: {{site.api}}/flutter/material/IconButton-class.html
[`OutlinedButton`]: {{site.api}}/flutter/material/OutlinedButton-class.html
[`TextButton`]: {{site.api}}/flutter/material/TextButton-class.html

### Handling Text Input

Flutter apps also accept text as input.  

#### `TextField`
Let users enter text with a hardware or onscreen keyboard. 

Decoration
Controller

> <i class="material-symbols" aria-hidden="true">bookmark</i> **Tutorial**: 
> This 4-part cookbook series walks
> you through how to create a text field,
> retrieve its value, and update your app state:
> 1. [Create and style a text field][]
> 1. [Retrieve the value of a text field][]
> 1. [Handle changes to a text field][]
> 1. [Focus and text fields][].


```dart
@override
Widget build(BuildContext context) {
  return const SizedBox(
    width: 250,
    child: TextField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Password',
      ),
    ),
  );
}
```

#### `RichText`
`RichText` lets you take text input and dispay them with inline styles.

> <i class="material-symbols" aria-hidden="true">slideshow</i> **Video**: 
> [Rich Text (Widget of the Week)][]

> <i class="material-symbols" aria-hidden="true">flutter</i> **Demo**: 
> [Rich Text Editor][]

> <i class="material-symbols" aria-hidden="true">code</i> **Code**: 
> [Rich Text Editor code][]

#### `SelectableText`
Display a string of user-selectable text with a single style.
> <i class="material-symbols" aria-hidden="true">slideshow</i> **Video**: 
> [SelectableText (Widget of the Week)][]

#### `Form`

An optional container for grouping together
  multiple form field widgets. 

> <i class="material-symbols" aria-hidden="true">bookmark</i> **Tutorial**: 
> [Build a form with validation][]

> <i class="material-symbols" aria-hidden="true">flutter</i> **Demo**: 
> [Form app][]

> <i class="material-symbols" aria-hidden="true">code</i> **Code**: 
> [Form app code][]

<br>

> <i class="material-symbols" aria-hidden="true">menu_book</i> **API Docs**:  
> [`TextField`][] | [`RichText`][] | [`SelectableText`][] | [`Form`][]

[Build a form with validation]: /cookbook/forms/validation
[Create and style a text field]: /cookbook/forms/text-input
[Focus and text fields]: /cookbook/forms/focus
[`Form`]: {{site.api}}/flutter/widgets/Form-class.html
[Form app]: https://flutter.github.io/samples/web/form_app/
[Form app code]: https://github.com/flutter/samples/tree/main/form_app
[Handle changes to a text field]: /cookbook/forms/text-field-changes
[Retrieve the value of a text field]: /cookbook/forms/retrieve-input
[`RichText`]: {{site.api}}/flutter/widgets/RichText-class.html
[Rich Text (Widget of the Week)]: https://www.youtube.com/watch?v=rykDVh-QFfw
[Rich Text Editor]: https://flutter.github.io/samples/rich_text_editor.html
[Rich Text Editor code]: https://github.com/flutter/samples/tree/main/simplistic_editor
[`SelectableText`]: {{site.api}}/flutter/material/SelectableText-class.html
[SelectableText (Widget of the Week)]: https://www.youtube.com/watch?v=ZSU3ZXOs6hc
[`TextField`]: {{site.api}}/flutter/material/TextField-class.html

### Selecting a value from a group of options

#### `SegmentedButton`
Allow users to select from limited set of options.

Example Code:
<iframe class="snippet-dartpad" src="https://dartpad.dev/embed-flutter.html?split=60&amp;run=true&amp;sample_id=material.SegmentedButton.1&amp;channel=stable">
    </iframe>

#### `DropdownMenu`
Let users select a choice from a menu and place the
  selected item into the text input field.

> <i class="material-symbols" aria-hidden="true">slideshow</i> **Video**: 
> [DropdownMenu (Widget of the Week)][]

Example Code:
<iframe class="snippet-dartpad" src="https://dartpad.dev/embed-flutter.html?split=60&amp;run=true&amp;sample_id=material.DropdownMenu.1&amp;channel=stable">
    </iframe>

#### `Slider`
Select from a range of values.
> <i class="material-symbols" aria-hidden="true">slideshow</i> **Video**: 
> [Slider, RangeSlider, CupertinoSlider (Widget of the Week)][]

Example Code:
<iframe class="snippet-dartpad" src="https://dartpad.dev/embed-flutter.html?split=60&amp;run=true&amp;sample_id=material.Slider.1&amp;channel=stable" data-gtm-yt-inspected-9257802_51="true" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true">
    </iframe>

[`DropdownMenu`]: {{site.api}}/flutter/material/DropdownMenu-class.html
[DropdownMenu (Widget of the Week)]: https://youtu.be/giV9AbM2gd8?si=E23hjg72cjMTe_mz
[`SegmentedButton`]: {{site.api}}/flutter/material/SegmentedButton-class.html
[`Slider`]: {{site.api}}/flutter/material/Slider-class.html
[Slider, RangeSlider, CupertinoSlider (Widget of the Week)]: https://www.youtube.com/watch?v=ufb4gIPDmEss

<br>

> <i class="material-symbols" aria-hidden="true">menu_book</i> **API Docs**:  
> [`SegmentedButton`][] | [`DropdownMenu`][] | [`Slider`][]

### Toggling between values

#### `Checkbox`
Select one or more items from a list,
  or toggle an item.

Example Code:
<iframe class="snippet-dartpad" src="https://dartpad.dev/embed-flutter.html?split=60&amp;run=true&amp;sample_id=material.Checkbox.1&amp;channel=stable">
    </iframe>



#### `Switch`
Toggle the on/off state of a single setting.

Example Code:
<iframe class="snippet-dartpad" src="https://dartpad.dev/embed-flutter.html?split=60&amp;run=true&amp;sample_id=material.Switch.1&amp;channel=stable">
    </iframe>

#### `CheckboxListTile` & `SwitchListTile`
A checkbox or switch widget, with a label. 

> <i class="material-symbols" aria-hidden="true">slideshow</i> **Video**: 
> [CheckboxListTile (Widget of the Week)][]

> <i class="material-symbols" aria-hidden="true">slideshow</i> **Video**: 
> [SwitchListTile (Widget of the Week)][]

Example Code:
<iframe class="snippet-dartpad" src="https://dartpad.dev/embed-flutter.html?split=60&amp;run=true&amp;sample_id=material.CheckboxListTile.2&amp;channel=stable" data-gtm-yt-inspected-9257802_51="true" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true">
    </iframe>

<iframe class="snippet-dartpad" src="https://dartpad.dev/embed-flutter.html?split=60&amp;run=true&amp;sample_id=material.SwitchListTile.2&amp;channel=stable" data-gtm-yt-inspected-9257802_51="true" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true">
    </iframe>

#### `Radio`
Select between a number of mutually exclusive values.
  When one radio button in a group is selected,
  the other radio buttons in the group cease to be selected.

Example Code:
<iframe class="snippet-dartpad" src="https://dartpad.dev/embed-flutter.html?split=60&amp;run=true&amp;sample_id=material.Radio.1&amp;channel=stable">
    </iframe>

#### `Chip`
Chips are compact elements that represent an attribute,
  text, entity, or action.

<br>

> <i class="material-symbols" aria-hidden="true">menu_book</i> **API Docs**:  
> [`Checkbox`][] | [`CheckboxListTile`][] | [`Switch`][] | [`SwitchListTile`][] | [`Radio`][] | [`Chip`][]


### Selecting a date, time, or both!

#### `DatePickerDialog`
A Material design date picker dialog, display it using `showDatePicker`.

Example Code:
<iframe class="snippet-dartpad" src="https://dartpad.dev/embed-flutter.html?split=60&amp;run=true&amp;sample_id=material.showDatePicker.1&amp;channel=stable">
    </iframe>

#### `TimePickerDialog`
A Material Design time picker dialog, display it using `showTimePicker`.

Example Code: 
<iframe class="snippet-dartpad" src="https://dartpad.dev/embed-flutter.html?split=60&amp;run=true&amp;sample_id=material.showTimePicker.4&amp;channel=stable">
    </iframe>

<br>

> <i class="material-symbols" aria-hidden="true">menu_book</i> **API Docs**:  
> [`showDatePicker`][] | [`showTimePicker`][]

### Swipe & slide

[`Dismissible`][]
Clear list items by swiping left or right.

> <i class="material-symbols" aria-hidden="true">slideshow</i> **Video**: 
> [Dismissible (Widget of the Week)][]

> <i class="material-symbols" aria-hidden="true">bookmark</i> **Tutorial**: 
> Learn how to [Implement swipe to dismiss][] using the dismissable widget.

Example Code:
<iframe class="snippet-dartpad" src="https://dartpad.dev/embed-flutter.html?split=60&amp;run=true&amp;sample_id=widgets.Dismissible.1&amp;channel=stable" data-gtm-yt-inspected-9257802_51="true" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true">
    </iframe>

[pkg:`flutter_slidable`][]
A list item with directional slide actions that can be dismissed.

> <i class="material-symbols" aria-hidden="true">slideshow</i> **Video**: 
> [flutter_slidable (Package of the Week)][]

<br>

> <i class="material-symbols" aria-hidden="true">menu_book</i> **API Docs**:  
> [`Dismissible`][] | [pkg:`flutter_slidable`][]

## Want a full sample of Material 3's User Input Components?

> <i class="material-symbols" aria-hidden="true">flutter</i> **Demo**: 
> Check out the [Material 3 Demo][],
> to see examples of additional user input widgets
> available in the Material 3 component library. 

## Adding interactivity with GestureDetector 

If you can't find a widget that fits the functionality
that you're looking for, you can build your own widget and add interactivity
using `GestureDetector`. 

> <i class="material-symbols" aria-hidden="true">slideshow</i> **Video**: 
> [GestureDetector (Widget of the Week)][]

> <i class="material-symbols" aria-hidden="true">menu_book</i> **Reference**: 
> [Taps, drags, and other gestures][]

> <i class="material-symbols" aria-hidden="true">bookmark</i> **Tutorial**: 
> [Handle taps][]

> <i class="material-symbols" aria-hidden="true">slideshow</i> **Bonus Video**: 
> Curious how Flutter's
`GestureArena` turns raw user interaction data into
human recognizable concepts like taps, drags, and pinches?
Check out the this video: [GestureArena (Decoding Flutter)][]

### Don't forget about accessibility!

If you're building custom widgets, annotate its meaning with the `Semantics` widget.
It provides descriptions, metadata,and more to screen readers and other semantic
analysis-based tools. 

> <i class="material-symbols" aria-hidden="true">slideshow</i> **Video**: 
> [Semantics (Flutter Widget of the Week)][]


<br>

> <i class="material-symbols" aria-hidden="true">menu_book</i> **API Docs**:  
> [`GestureDetector`][] | [`Semantics`][]

## Testing

Once you have finished building user interactions
into your app, don't forget to write tests to
ensure that everything works as expected!

> <i class="material-symbols" aria-hidden="true">bookmark</i> **Tutorial**: 
> [Tap, drag, and enter text][]

> <i class="material-symbols" aria-hidden="true">bookmark</i> **Tutorial**: 
> [Handle scrolling][]

[GestureArena (Decoding Flutter)]: https://www.youtube.com/watch?v=Q85LBtBdi0U
[GestureDetector (Widget of the Week)]: https://www.youtube.com/watch?v=WhVXkCFPmK4
[Handle taps]: /cookbook/gestures/handling-taps
[Semantics (Flutter Widget of the Week)]: https://youtu.be/NvtMt_DtFrQ?si=o79BqAg9NAl8EE8_
[Tap, drag, and enter text]: /cookbook/testing/widget/tap-drag
[Taps, drags, and other gestures]: /ui/interactivity/gestures#gestures

## Next: Networking

This page was an introduction to handling user input.
Now that you know how to accept input from app's users,
you can make your app even more interesting by adding
external data. In the next section,
you'll learn now to fetch data for your app over a network,
how to convert data to and from JSON, authentication,
and other networking features. 

[scrolling]: /get-started/fwe/layout#scrolling-widgets

[Add interactivity to your Flutter app]: /ui/interactivity
[Material 3 Demo]: https://flutter.github.io/samples/web/material_3_demo/



[`Checkbox`]: {{site.api}}/flutter/material/Checkbox-class.html
[`CheckboxListTile`]: {{site.api}}/flutter/material/CheckboxListTile-class.html
[CheckboxListTile (Widget of the Week)]: https://www.youtube.com/watch?v=RkSqPAn9szs
[`Switch`]: {{site.api}}/flutter/material/Switch-class.html
[`SwitchListTile`]: {{site.api}}/flutter/material/SwitchListTile-class.html
[SwitchListTile (Widget of the Week)]: https://www.youtube.com/watch?v=0igIjvtEWNU
[`Radio`]: {{site.api}}/flutter/material/Radio-class.html
[`Chip`]: {{site.api}}/flutter/material/Chip-class.html

[Material Design date picker]: https://m3.material.io/components/date-pickers/overview
[Material Design time picker]: https://m3.material.io/components/time-pickers/overview
[`showDatePicker`]: {{site.api}}/flutter/material/showDatePicker.html
[`showTimePicker`]: {{site.api}}/flutter/material/showTimePicker.html

[`Dismissible`]: {{site.api}}/flutter/widgets/Dismissible-class.html
[Dismissible (Widget of the Week)]: https://youtu.be/iEMgjrfuc58?si=f0S7IdaA9PIWIYvl
[Implement swipe to dismiss]: /cookbook/gestures/dismissible
[pkg:`flutter_slidable`]: https://pub.dev/packages/flutter_slidable
[flutter_slidable (Package of the Week)]: https://www.youtube.com/watch?v=QFcFEpFmNJ8


[`GestureDetector`]: {{site.api}}/flutter/widgets/GestureDetector-class.html
[`Semantics`]: {{site.api}}/flutter/widgets/Semantics-class.html

[Handle scrolling]: /cookbook/testing/widget/scrolling

## Feedback

As this section of the website is evolving, 
we [welcome your feedback][]!

[welcome your feedback]: https://google.qualtrics.com/jfe/form/SV_6A9KxXR7XmMrNsy?page="user-input"
