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

Flutter ships with two design systems as part of the SDK, [Material][] and [Cupertino][]. For educational purposes, this page focuses on Material widgets, prebuilt components that are stylized according to the Material design langauge specifications. 

The Flutter community also creates and supports additional designs systems on [pub.dev][], the package repository for Dart and Flutter. If the existing design system components don't quite fit what you need, Flutter lets you build your own custom designed widget library.

[pub.dev]: https://pub.dev
[Layouts]: /get-started/fwe/layout
[Material]: /ui/widgets/material
[Cupertino]: /ui/widgets/cupertino
[widget catalog]: /ui/widgets#design-systems

In this section, we'll cover a few of the Material widgets that cover common usecases for handling user input your Flutter app. 

> <i class="material-symbols" aria-hidden="true">menu_book</i> **Reference**: 
> The [widget catalog][] has an inventory of commonly used widgets in the [Material][] and [Cupertino][] libraries.

### Buttons
<img src='/assets/images/docs/fwe/user-input/material-buttons.png' alt="A collection of Material 3 Buttons.">

Buttons let a user prompt action in the UI by clicking or tapping. The Material library provides a variety of button types that are functionally similar, but styled differently for various usecases,  including:
- `ElevatedButton`: A button with some depth. Use elevated buttons to add dimension to otherwise mostly flat layouts.
- `FilledButton`: A filled button that should be used for important, final actions that complete a flow, like **Save**, **Join now**, or **Confirm**. 
- `Tonal Button`
- `OutlinedButton`: A button with text and a visible border.
  These buttons contain actions that are important,
  but aren't the primary action in an app.
- `TextButton`: Clickable text, without a border.
  Since text buttons don't have visible borders
  and they must therefore rely on their position
  relative to other content for context.
- `IconButton`: A button with an icon.
- and `FloatingActionButton`: An icon button that hovers over
  content to promote a primary action.

> <i class="material-symbols" aria-hidden="true">slideshow</i> **Video**: 
> [FloatingActionButton (Widget of the Week)][]

There are usually 3 main parts to constructing a button: style, callback, and its child, as seen in the `ElevatedButton` sample code below: 

<!--- TODO: WidgetStateProperty and styling in the the design section of FWE Of course, a button's appearance can be dependent on its state. You can style a button based on its state using WidgetStateProperty. -->

- Its callback function, `onPressed` determines what happens when the button is clicked, this function is where you update your app state. If a `null` callback is provided, the button is disabled and nothing happens when a user presses the button. 

- The button's `child`, which is what's displayed within the button's content area, that's usually text or an icon that indicates the button's purpose. 

- Finally, a button's `style` controls its appearance: color, border, etc.

```dart
Widget build(BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
    ),
    onPressed: () {
      setState({
        count += 1;
      })
    },
    child: const Text('Enabled'),
  );
}
```
<br>

> <i class="material-symbols" aria-hidden="true">star</i> **Checkpoint**: 
> Complete this tutorial that
> teaches you how to build a "favorite" button: [Add interactivity to your Flutter app][]

<br>

<i class="material-symbols" aria-hidden="true">menu_book</i> **API Docs**: [`ElevatedButton`][] • [`FilledButton`][] • [`OutlinedButton`][] • [`TextButton`][] • [`IconButton`][] • [`FloatingActionButton`][]

[`ElevatedButton`]: {{site.api}}/flutter/material/ElevatedButton-class.html
[`FilledButton`]: {{site.api}}/flutter/material/FilledButton-class.html
[`FloatingActionButton`]: {{site.api}}/flutter/material/FloatingActionButton-class.html
[FloatingActionButton (Widget of the Week)]: https://youtu.be/2uaoEDOgk_I?si=MQZcSp24oRaS_kiY
[`IconButton`]: {{site.api}}/flutter/material/IconButton-class.html
[`OutlinedButton`]: {{site.api}}/flutter/material/OutlinedButton-class.html
[`TextButton`]: {{site.api}}/flutter/material/TextButton-class.html

### Text

#### `SelectableText`

Flutter's `Text` widget displays text on the screen, but app users aren't able to highlight it, copy, etc. `SelectableText` will display a string of _user-selectable_ text with a single style.
<!-- GIF of SelectableText -->

> <i class="material-symbols" aria-hidden="true">slideshow</i> **Video**: 
> [SelectableText (Widget of the Week)][]

#### `RichText`
Like `Text`, `RichText` lets you display strings of text in your app, but with the ability to display parts of text with different text styles.

<!-- IMAGE of RichText -->

> <i class="material-symbols" aria-hidden="true">slideshow</i> **Video**: 
> [Rich Text (Widget of the Week)][]

> <i class="material-symbols" aria-hidden="true">flutter</i> **Demo**: 
> [Rich Text Editor][]

> <i class="material-symbols" aria-hidden="true">code</i> **Code**: 
> [Rich Text Editor code][]


#### `TextField`
A `TextField` lets users enter text in text box using a hardware or onscreen keyboard. 

`TextField`s have many different properties and configurations, so here are a few of the highlights:
- `InputDecoration` determines the text field's appearance, such as color, border, etc.
- `controller`: A `TextEditingController` controls the text being edited. Why would you need a controller? By default your app's users will be able to type into the text field, but if you want to programmatically control the `TextField` and do something like clearing its value, you'll need a `TextEditingController`.
- `onChanged`: The callback function that is triggered when the user changes the  text field's value, such as inserting or removing text.
- `onSubmitted`:  This callback is triggered when the user indicates that they are done editing the text in the field, for example tapping the "enter" key. 

There are many other confiugrable properties on a `TextField` such as `obscureText` which turns the inputted letters displays each character as a circle and `readOnly` which determines whether the text can be changed.

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

> <i class="material-symbols" aria-hidden="true">star</i> **Checkpoint**: 
> Complete this 4-part cookbook series that walks
> you through how to create a text field,
> retrieve its value, and update your app state:
> 1. [Create and style a text field][]
> 1. [Retrieve the value of a text field][]
> 1. [Handle changes to a text field][]
> 1. [Focus and text fields][].

#### `Form`

`Form` is an optional container for grouping together multiple form field widgets, such as `TextField`. 

Each individual form field should be wrapped in a `FormField` widget with the `Form` widget as a common ancestor. There are convenience widgets that pre-wrap form field widgets in `FormField` for you. For example, the `Form` widget version of `TextField` is `TextFormField`. 

Using a `Form` gives the benefit of having access to a `FormState` which lets you save, reset, and validate each `FormField` that is a descendant of this `Form`. A `GlobalKey` can also be provided to identify a specific form, as seen in this example code:

```dart
class _FormExampleState extends State<FormExample> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter your email',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState!.validate()) {
                  // Process data.
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
```

> <i class="material-symbols" aria-hidden="true">star</i> **Checkpoint**:
> Complete this tutorial which teaches you how to [build a form with validation][].

> <i class="material-symbols" aria-hidden="true">flutter</i> **Demo**: 
> [Form app][]

> <i class="material-symbols" aria-hidden="true">code</i> **Code**: 
> [Form app code][]



<br>

<i class="material-symbols" aria-hidden="true">menu_book</i> **API Docs**: [`TextField`][] • [`RichText`][] • [`SelectableText`][] • [`Form`][]

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
> [`SegmentedButton`][] • [`DropdownMenu`][] • [`Slider`][]

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
> [`Checkbox`][] • [`CheckboxListTile`][] • [`Switch`][] • [`SwitchListTile`][] • [`Radio`][] • [`Chip`][]


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
> [`showDatePicker`][] • [`showTimePicker`][]

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

[pkg: `flutter_slidable`][]
A list item with directional slide actions that can be dismissed.

> <i class="material-symbols" aria-hidden="true">slideshow</i> **Video**: 
> [flutter_slidable (Package of the Week)][]

<br>

> <i class="material-symbols" aria-hidden="true">flutter</i> **Demo**: 
> Check out Flutter's [Material 3 Demo][] for an assortment of user input widgets available in the Material library. 

<br>

<i class="material-symbols" aria-hidden="true">menu_book</i> **API Docs**: [`Dismissible`][] • [pkg: `flutter_slidable`][]

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
> [`GestureDetector`][] • [`Semantics`][]

## Testing

Once you have finished building user interactions
into your app, don't forget to write tests to
ensure that everything works as expected!

These tutorials will walk you through writing tests that simulate user interactions in your app:

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
Now that you know how to get input from app's users,
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
[pkg: `flutter_slidable`]: https://pub.dev/packages/flutter_slidable
[flutter_slidable (Package of the Week)]: https://www.youtube.com/watch?v=QFcFEpFmNJ8


[`GestureDetector`]: {{site.api}}/flutter/widgets/GestureDetector-class.html
[`Semantics`]: {{site.api}}/flutter/widgets/Semantics-class.html

[Handle scrolling]: /cookbook/testing/widget/scrolling

## Feedback

As this section of the website is evolving, 
we [welcome your feedback][]!

[welcome your feedback]: https://google.qualtrics.com/jfe/form/SV_6A9KxXR7XmMrNsy?page="user-input"
