---
title: "Basic Flutter layout concepts"
description: "A codelab that teaches basic Flutter layout concepts through DartPad2 code examples."
toc: true
--- 
{{site.alert.important}}
  This codelab covers basic Flutter layout concepts using a code editor called DartPad. 
  DartPad is in an experimental stage and hasn't been fully tested on all browsers. If you encounter any difficulties while using DartPad on a specific browser, 
  please create a [DartPad issue](https://github.com/dart-lang/dart-pad/issues/new) and specify which browser you're using in the issue title.
{{site.alert.end}}

Welcome to the Flutter layout codelab, 
where you learn to lay out a Flutter UI without downloading or installing Flutter and Dart!

Flutter is different from other frameworks because its UI is built in code, 
not (for example) in an XML file or similar. 
Widgets are the basic building blocks of a Flutter UI. 
As you progress through this codelab, 
you'll learn that almost everything in Flutter is a widget. 
A widget is an immutable object that describes a specific part of a UI. 
You'll also learn that Flutter widgets are composable, meaning, 
that you can combine existing widgets to make more sophisticated widgets.  
At the end of this codelab, 
you'll apply what you've learned into building a Flutter UI that displays a business card.

**Estimated time to complete this codelab: 45-60 minutes.**

## Row and Column classes
`Row` and `Column` are classes that contain and lay out widgets. 
Widgets inside of a `Row` or `Column` are called *children*, 
and `Row` and `Column` are referred to as *parents*. 
`Row` lays out its widgets horizontally, 
and `Column` lays out its widgets vertically. 

#### Example: Creating a Column
{:.no_toc}
{{site.alert.secondary}}
{:.no_toc}  
  The following example displays the differences between a `Row` and `Column`. 

  **1.** Click the **Run** button.

  **2.** In the code, change the `Row` to a `Column`, and run again.
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/4e11c4a7ec824685f963f25d7c30ba0b
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=4e11c4a7ec824685f963f25d7c30ba0b&amp;theme=dark&amp;split=60" width="100%" height="400px"></iframe> 

## Axis size and alignment

So far, the blue boxes widgets have been squished together 
(either to the left or at the top of the UI Output).
You can change how the blue boxes widgets are spaced using the size and alignment properties.

### mainAxisSize property

`Row` and `Column` occupy different main axes. 
`Row`'s main axis is horizontal, 
and `Column`'s main axis is vertical. 
The `mainAxisSize` property determines how much space `Row` and `Column` can occupy on their main axes.
`mainAxisSize` has two possible values: 

`MainAxisSize.max`
: Increases the amount of space `Row` and `Column` can occupy on their main axes.
If the combined width of `Row` and `Column`'s child widgets is 
less than the total space on `Row` and `Column`'s main axes, 
the children are laid out with extra space.

`MainAxisSize.min`
: Decreases the amount of space `Row` and `Column` can occupy on their main axes.
`Row` and `Column`'s children are laid out without extra space. 

{{site.alert.tip}}
  `MainAxisSize.max` is the default value for the `mainAxisSize` property. 
  If you don't specify another value, 
  the default value is used, 
  as shown in the previous example. 
{{site.alert.end}}
#### Example: Modify axis size
{:.no_toc}
{{site.alert.secondary}}
{:.no_toc}

  The following example explicitly sets `mainAxisSize` to its default value, `MainAxisSize.max`.

  **1.** Click the **Run** button. 

  **2.** Change the `mainAxisSize` property to `MainAxisSize.min`, and run again. 
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/d852e4f07d6c87600fe8e0f186c7a31b
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=d852e4f07d6c87600fe8e0f186c7a31b&amp;theme=dark&amp;split=60" width="100%" height="400px"></iframe>

### mainAxisAlignment property

When `mainAxisSize` is set to `MainAxisSize.max`, 
`Row` and `Column` might lay out their children with extra space. 
The `mainAxisAlignment` property determines how `Row` and `Column` 
can position their children in that extra space. 
 `mainAxisAlignment` has six possible values: 

`MainAxisAlignment.start`
: Positions children near the beginning of the main axis. 
(Left for `Row`, top for `Column`)

`MainAxisAlignment.end`
: Positions children near the end of the main axis. 
(Right for `Row`, bottom for `Column`)

`MainAxisAlignment.center`
: Positions children at the middle of the main axis.

`MainAxisAlignment.spaceBetween`
: Divides the extra space evenly between children.

`MainAxisAlignment.spaceEvenly`
: Divides the extra space evenly between children and before and after the children.

`MainAxisAlignment.spaceAround`
: Similar to `MainAxisAlignment.spaceEvenly`,
but reduces half of the space before the first child and after the last child 
to half of the width between the children. 

#### Example: Modify main axis alignment
{:.no_toc}
{{site.alert.secondary}}

  The following example explicitly sets the `mainAxisAlignment` property to its default value, 
  `MainAxisAlignment.start`.

  **1.** Click the **Run** button.

  **2.** Change `MainAxisAlignment.start` to `MainAxisAlignment.end`, and run again.
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/cb8abed13f90a6a0c7a0ada6f15a09c9
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=cb8abed13f90a6a0c7a0ada6f15a09c9&amp;theme=dark&amp;split=60" width="100%" height="400px"></iframe>
{{site.alert.tip}}
  Before moving to the next section, change `MainAxisAlignment.end` to one of the other values.
{{site.alert.end}}

### crossAxisAlignment property

The `crossAxisAlignment` property determines 
how `Row` and `Column` can position their children on their cross axes. 
A `Row`'s cross axis is vertical, and a `Column`'s cross axis is horizontal. 
Most of the `crossAxisAlignment` property's values only work with `Row`. 
`crossAxisAlignment` has five possible values:

`CrossAxisAlignment.start`
: Positions children near the top of the cross axis. (`Row` only)

`CrossAxisAlignment.end`
: Positions children near the bottom of the cross axis. (`Row` only)

`CrossAxisAlignment.center`
: Positions children at the middle of the cross axis. (`Row` only)

`CrossAxisAlignment.stretch`
: Stretches children across the cross axis. 
(Top-to-bottom for `Row`, left-to-right for `Column`)

`CrossAxisAlignment.baseline`
: Aligns children by their character baselines. (`Text` class only, and requires that the `textBaseline` property is set to `TextBaseline.alphabetic`. See the [Text class](#text-class) section for an example.)

#### Example: Modify cross axis alignment
{:.no_toc}
{{site.alert.secondary}}
  The following example explicitly sets the `crossAxisAlignment` property to its default value,
  `CrossAxisAlignment.center`. 

  To demonstrate cross axis alignment, `Row` now contains a `BiggerBlueBox` widget
  that is taller than the other widgets, and `mainAxisAlignment` is set to
 `MainAxisAlignment.spaceAround`. 

  **1.** Click the **Run** button.

  **2.** Change `CrossAxisAlignment.center` to `CrossAxisAlignment.start`, and run again. 
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/70a6eb88f13019eec349a57bc4fd5fe0
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=70a6eb88f13019eec349a57bc4fd5fe0&amp;theme=dark&amp;split=60" width="100%" height="400px"></iframe>
{{site.alert.tip}}
  Before moving to the next section, change `CrossAxisAlignment.start` to one of the other values. 
{{site.alert.end}}

## Flexible widget

As you've seen, the `mainAxisAlignment` and `crossAxisAlignment` properties determine 
how `Row` and `Column` position widgets along both axes. 
`Row` and `Column` first lay out widgets of a fixed size.
Fixed size widgets are considered *inflexible* because they can't resize
themselves after they've been laid out.

The `Flexible` widget wraps a widget, so the widget becomes resizable. 
When the `Flexible` widget wraps a widget, the widget becomes the `Flexible` widget's child 
and is considered *flexible*. 
After inflexible widgets are laid out,
flexible widgets are resized according to their `flex` and `fit` properties.:

`flex`
: Compares itself against other `flex` properties before determining 
what fraction of the total extra space each `Flexible` widget receives.

`fit` 
: Determines whether a `Flexible` widget fills all of its extra space.

#### Example: Testing flex values
{:.no_toc}
{{site.alert.secondary}}
  In the following example, two `Flexible` widgets wrap two `BlueBox` widgets. 
  The `Flexible` widgets contain `flex` properties with values set to 1 (the default value).

  When `flex` properties are compared, 
  the ratio between the values determines 
  what fraction of the total extra space each `Flexible` widget receives.

  In this example, the sum of the `flex` values (2),
  determines that each `Flexible` widget increases
  by half of the free space. 
  The fixed-width widget remains the same size.

  **1.** Click the **Run** button. 
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/82e4dd24028034ae03ba0ddc71bf59e5
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=82e4dd24028034ae03ba0ddc71bf59e5&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>
{{site.alert.tip}}
  Before moving to the next code example, change the `flex` properties to other values, 
  such as 2 and 1.
{{site.alert.end}}

#### Example: Testing fit properties
{:.no_toc}  
{{site.alert.secondary}}
  The following example displays the `fit` property,
  which can have one of two values:

  `FlexFit.loose`
  : The widget's preferred size is used. (Default)

  `FlexFit.tight`
  : Forces the widget to fill all of its extra space. 

  In this example, modify the `fit` properties to
  make the `Flexible` widgets fill the free space.

  **1.** Click the **Run** button. 

  **2.** Change the `fit` values to `FlexFit.tight`, 
  and run again.   
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/ba0f40356d1023066d960f6de2be1a4b
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=ba0f40356d1023066d960f6de2be1a4b&amp;theme=dark&amp;split=60" width="100%" height="400px"></iframe>

## Expanded widget

Similar to the `Flexible` widget, the `Expanded` widget can wrap a widget and force the widget to fill extra space. 

{{site.alert.tip}}
  **What's the difference between Flexible and Expanded?**
    Use `Flexible` to resize widgets in a `Row` or `Column`,
    so you can adjust child widgets' spacing while keeping the
    relation with their parent widget.
    `Expanded` changes the constraints of the child widgets
    to fill any empty space.
{{site.alert.end}} 

#### Example: Filling extra space
{:.no_toc}
{{site.alert.secondary}}
  The following example demonstrates how the `Expanded` widget forces its child widget to fill extra space.

  **1.** Click the **Run** button. 

  **2.** Wrap the second `BlueBox` widget in an `Expanded` widget. 

  For example: 

  ```dart
  Expanded(child: BlueBox(),),
  ```
  **3.** Select the **Format** button, and run again. 

{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/77021d2ed15f9ece850de15e73c47526
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=77021d2ed15f9ece850de15e73c47526&amp;theme=dark&amp;split=60" width="100%" height="400px"></iframe>

## SizedBox widget

The `SizedBox` widget can be used in one of two ways.
When `SizedBox` wraps a widget, 
it resizes the widget using the `height` and `width` properties.
When it doesn't wrap a widget, 
it uses the `height` and `width` properties to create empty space.
#### Example: Resizing a widget 
{:.no_toc}
{{site.alert.secondary}}
  The following example wraps the middle `BlueBox` widget inside of a
  `SizedBox` widget and sets the `BlueBox`'s width to 100 logical pixels.

  **1.** Click the **Run** button.

  **2.** Add a `height` property equal to 100 logical pixels inside the `SizedBox` widget, and run again.   
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/6582851e85b57180ff5321f814fabb81
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=6582851e85b57180ff5321f814fabb81&amp;theme=dark&amp;split=60" width="100%" height="400px"></iframe>

#### Example: Creating space 
{:.no_toc}
{{site.alert.secondary}}
  The following example contains three `BlueBox` widgets and one `SizedBox` widget that separates the first and second `BlueBox` widgets. The `SizedBox` widget contains a `width` property equal to 50 logical pixels. 

  **1.** Click the **Run** button.

  **2.** Create more space by adding another `SizedBox` widget (25 logical pixels wide) 
  between the second and third `BlueBox` widgets, and run again.
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/datafoya/19ead147ab5c7668d7d32e1cfed90097
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=19ead147ab5c7668d7d32e1cfed90097&amp;theme=dark&amp;split=60" width="100%" height="400px"></iframe>

## Spacer widget

Similar to the `SizedBox` widget, the `Spacer` widget also can create space between widgets.

{{site.alert.tip}}
  **What's the difference between SizedBox and Spacer?**
    Use `Spacer` when you want to create space using a `flex` property.
    Use `SizedBox` when you want to create space 
    using a specific number of logical pixels.
{{site.alert.end}} 

#### Example: Creating more space
{:.no_toc}
{{site.alert.secondary}}
  The following example separates the first two `BlueBox` widgets using
  a `Spacer` widget with a `flex` value of 1.

  **1.** Click the **Run** button.

  **2.** Add another `Spacer` widget (also with a `flex` value of 1)
   between the second and third `BlueBox` widgets.  
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/datafoya/bfc367aefde35e02ea5283efdbf58e60
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=bfc367aefde35e02ea5283efdbf58e60&amp;theme=dark&amp;split=60" width="100%" height="400px"></iframe>

## Text widget

The `Text` widget displays text and can be configured
for different fonts, sizes, and colors. 

#### Example: Aligning text
{:.no_toc}
{{site.alert.secondary}}
  The following example displays "Hey!" three times in one row,
  but at different font sizes and in different colors.
  `Row` specifies the `crossAxisAlignment` and `textBaseline` properties.

  As mentioned previously, to align `Text` widgets along their character baselines,
  set the `textBaseline` property to `TextBaseline.alphabetic`.  

  **1.** Click the **Run** button. 

  **2.** Change `CrossAxisAlignment.center` to `CrossAxisAlignment.baseline`, and run again.
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/datafoya/0ff109090b99ef1873d9fad501b2bc86
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=0ff109090b99ef1873d9fad501b2bc86&amp;theme=dark&amp;split=60" width="100%" height="400px"></iframe>

## Icon widget

The `Icon` widget displays a graphical symbol, 
which represents an aspect of the UI. 
Flutter is preloaded with icon packages for 
[Material](https://api.flutter.dev/flutter/material/MaterialApp-class.html) and 
[Cupertino](https://api.flutter.dev/flutter/cupertino/CupertinoApp-class.html) applications.

#### Example: Create an Icon widget
{:.no_toc}
{{site.alert.secondary}}
  The following example displays the widget icon from the
  [Material Icon library](https://api.flutter.dev/flutter/material/Icons-class.html) in red and blue.

  **1.** Click the **Run** button. 

  **2.** Add another `Icon` widget from the 
  [Material Icon library](https://api.flutter.dev/flutter/material/Icons-class.html)
  with a size of 50. 

  **3.** Give the icon a color of `Color.amber` from the 
  [Material Color palette](https://api.flutter.dev/flutter/material/Colors-class.html), 
  and run again.  
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/datafoya/01688fca8c13f85d93078054af2e858b
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=01688fca8c13f85d93078054af2e858b&amp;theme=dark&amp;split=60" width="100%" height="400px"></iframe>

## Image widget 

The `Image` widget displays an image. You either can reference images using a URL,
or you can include images inside your app package. Since DartPad can't package an image,
the following example uses an image from the network.

#### Example: Image widget
{:.no_toc}
{{site.alert.secondary}}
  The following example displays an image using `Image`. 
  The `Image.network` method takes a string parameter that contains the image's URL.

  This example displays an image that's stored remotely on [GitHub](https://github.com/flutter/website/tree/master/examples/layout/sizing/images).

  **1.** Click the **Run** button.  
{{site.alert.end}}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=b6f3084800bd139cdb522b8858bb58b7&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>

## Putting it all together 

You've almost reached the end of this codelab.
Why not test your knowledge by applying the techniques
you've learned to build a UI that displays a business card!

You'll break down the layout into parts, which is how you'd
create a UI in the real world. This exercise can be broken
into three parts. In part 1,
you'll implement a `Column` containing a name, title, and icon. 
In part 2, you'll wrap the `Column` in a `Row`, tweak the layout to look nice, 
and add contact information. In part 3,
you'll add another `Row` containing an address.  

### Part 1
{:.no_toc}

This part contains two examples. 
In the first example, you'll build a `Column`,
which contains a name and title. 
In the second example, you'll wrap your `Column` in a `Row`, 
which contains an icon.
By the end of Part 1, 
your code displays a name, business title, and business icon. 

#### Example: Create the name and title
{:.no_toc}
{{site.alert.secondary}}

  Build a `Column` that contains the following widgets: 

<ul markdown="1">
  <li markdown="1">
  One Text widget that contains the name "Flutter McFlutter" and
  the `style` property set to `Theme.of(context).textTheme.headline`.  
  </li>
  <li markdown="1">
  A second `Text` widget that contains the business title "Experienced Developer."

  For your Column, set the:
  </li>
 
  <li markdown="1">`mainAxisSize` property to `MainAxisSize.min`
  </li>
  <li markdown="1">`crossAxisAlignment` property to `CrossAxisAlignment.start`.
  </li>
</ul>
    
{{site.alert.end}}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=30ccbe0fcf31cc10eafba3aea8ff0697&amp;theme=dark&amp;split=60" width="100%" height="400px"></iframe>

#### Exercise: Wrap the Column in a Row
{:.no_toc}
{{site.alert.secondary}}
  

  Wrap your `Column` in a `Row` that contains the following widgets:

<ul markdown="1">
  <li markdown="1">
  An `Icon` widget set to `Icons.account_circle` with a size of 50 pixels.
  </li>
  <li markdown="1">
  A `Padding` widget that creates a space of 8 pixels around the `Icon` widget. 

  To do this, you can specify `const EdgeInsets.all(8.0)` for the padding property.

  For example: 
  </li>
</ul>

  ```dart
  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.account_circle, size: 50)),
  ```
{{site.alert.end}}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=95dcc1451aea8412669c41eb8a1a5f23&amp;theme=dark&amp;split=60" width="100%" height="400px"></iframe>

### Part 2
{:.no_toc}

This part also contains two examples, both focusing on contact information. 
In the first example, you'll wrap the `Row` you built in a `Column`, 
so you can create space for the contact information. 
In the second example, you'll enter the contact information. 
At the end of Part 2, your code will contain a `Column` within a `Row` within a `Column`.

#### Exercise: Tweak the layout
{:.no_toc}
{{site.alert.secondary}}
  
  Wrap your `Row` inside a `Column` that contains the following widgets:

<ul markdown="1">
  <li markdown="1"> 
  A `mainAxisSize` property set to `MainAxisSize.min`. 
  </li>
  <li markdown="1">
  A `crossAxisAlignment` property set to `CrossAxisAlignment.stretch`.
  </li>
  <li markdown="1">
  A `SizedBox` widget with a height of 8.
  </li>
  <li markdown="1">
  An empty `Row` class where you'll add your contact information. 
  </li>
  <li markdown="1">
  A second `SizedBox` widget with a height of 16.
  </li>
  <li markdown="1">
  A second empty `Row` class where you'll add different icons (covered in [Part 3](#part-3)). 
  </li>
</ul>

  Your `SizedBox` widgets and empty `Row` classes should be formatted like this: 

  ```dart

     ],
    ),
    SizedBox(),
    Row(), // First empty Row class.
    SizedBox(),
    Row(), // Second empty Row class.
   ],
  );

  ```
{{site.alert.end}}

<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=c3ac34ed8952724a0ecb0af1445c2af8&amp;theme=dark&amp;split=60" width="100%" height="400px"></iframe>

#### Example: Enter contact information 
{:.no_toc}
{{site.alert.secondary}}
  Enter the following widgets inside the first empty `Row` class: 

<ul markdown="1">
  <li markdown="1">  
  A `Text` widget that contains the address "123 Main Street." 
  </li>
  <li markdown="1">
  A second `Text` widget that contains the phone number "123-456-7890."
  </li>
  <li markdown="1"> 
  A `mainAxisAlignment` property set to `mainAxisAlignment.SpaceBetween`.
  </li>
</ul>
{{site.alert.end}}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=c5be61116652927c5d92262fce1b5360&amp;theme=dark&amp;split=60" width="100%" height="400px"></iframe>

### Part 3
{:.no_toc}
This part contains one example where you finish your business card display. You'll add four `Icon` widgets to the second empty `Row` class that you built in Part 2. 

{{site.alert.secondary}}
  Enter the following `Icon` widgets in the second empty `Row` class.
  * `Icons.accessibility` 
  * `Icons.timer`
  * `Icons.phone_android`
  * `Icons.phone_iphone`
{{site.alert.end}}

<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=dae36611fc9af04c4b9d0fbc3429275e&amp;theme=dark&amp;split=60" width="100%" height="400px"></iframe>