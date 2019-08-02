---
title: "Codelab: Basic Flutter layout concepts"
description: "A codelab that teaches basic Flutter layout concepts through DartPad2 code examples."
toc: true
--- 
{{site.alert.important}}
  This codelab covers basic Flutter layout concepts using a code editor called DartPad2. An understanding of [Dart](https://www.dart.dev) or some exposure to object-oriented programming is recommended. 
{{site.alert.end}}
{{site.alert.important}}
  Currently, DartPad2 is in the experimental stage and being tested with Google Chrome. A PC (Microsoft, Mac, or Linux) with Google Chrome installed is required for this codelab. If you encounter any difficulties while using DartPad2, please create a [DartPad issue](https://github.com/dart-lang/dart-pad/issues/new) and label the issue "platform-web."
{{site.alert.end}} 
{{site.alert.note}}
  Flutter supports devices that maintain right-to-left language settings. 
{{site.alert.end}}
## Introduction

In this codelab, you'll interact with and build Flutter layouts in a code editor called DartPad2. 
As you progress through this codelab, you learn that widgets build everything in Flutter. 
A widget is an immutable object that describes a specific part of a UI. You also learn that, 
while widgets are simple in their functions, widgets can be complex in their structures. 
Widgets can be built around and inside of other widgets, 
and widgets can have interconnected and ordered relationships with one another. At the end of this codelab, 
you'll apply what you learn and build a simple interface using basic Flutter layout concepts. 
## Row and Column classes
`Row` and `Column` are classes that contain and lay out widgets. These widgets are called "children," 
and `Row` and `Column` are referred to as "parents." `Row` lays out its widgets *horizontally*. 
`Column` lays out its widgets *vertically*. 

#### Code example: Row
{:.no_toc}
{{site.alert.secondary}}
{:.no_toc}
  Check out Dart.
  
  The following code example displays three blue squares horizontally. 

  Click the **Run** button.
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/26c8fb02c58c4120917b073ec6253953
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=26c8fb02c58c4120917b073ec6253953&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe> 

#### Code example: Column
{:.no_toc}
{{site.alert.secondary}}
{:.no_toc}
  Check out Dart.

  The following code example displays three blue squares vertically. 

  Click the **Run** button. 
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/db96dc75c3283227bc849ba31d213783
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=db96dc75c3283227bc849ba31d213783&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>

## mainAxisSize property

`Row` and `Column` occupy different main axes. `Row`\'s main axis is horizontal. `Column`\'s main axis is vertical. 
`mainAxisSize` is a property that determines how much space `Row` and `Column` can occupy on their main axes.
`mainAxisSize` has two `MainAxisSize` enums: 

`MainAxisSize.max`
: Increases the amount of space `Row` and `Column` can occupy on their main axes. 
`Row` and `Column` may have extra space.

`MainAxisSize.min`
: Decreases the amount of space `Row` and `Column` can occupy on their main axes.
`Row` and `Column` only have enough space for their children. 

{{site.alert.tip}}
  `MainAxisSize.max` is a default enum. Default enums don't require that you enter them in your code. 
  Take a look at the previous code examples. Both code examples contain the `mainAxisSize` property, 
  although you can't see it. The following code example demonstrates where and how the `mainAxisSize` property is entered.  
{{site.alert.end}}
#### Code example: MainAxisSize.max and MainAxisSize.min
{:.no_toc}
{{site.alert.secondary}}
{:.no_toc}
  Try Dart

  Notice how `Row` contains the `mainAxisSize` property set to `MainAxisSize.max`.

  **1.** Click the **Run** button. 

  **2.** Change the `mainAxisSize` property to `MainAxisSize.min`.

  **3.** Click the **Run** button. 
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/def3c5c3c68459b5bb4bdfed58f5d024
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=d852e4f07d6c87600fe8e0f186c7a31b&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>

## mainAxisAlignment property

When `mainAxisSize` is set to `MainAxisSize.max`, `Row` and `Column` may have extra space on their main axes. 
`mainAxisAlignment` is a property that determines how `Row` and `Column` can position their children *horizontally* in that extra space. `mainAxisAlignment` has six `MainAxisAlignment` enums: 

`MainAxisAlignment.start`
: Positions children near the beginning of the main axis. (Left for `Row`, top for `Column`)

`MainAxisAlignment.end`
: Positions children near the end of the main axis. (Right for `Row`, bottom for `Column`)

`MainAxisAlignment.center`
: Positions children at the middle of the main axis.

`MainAxisAlignment.spaceBetween`
: Divides the extra space evenly between children.

`MainAxisAlignment.spaceEvenly`
: Divides the extra space evenly between children and creates an even amount of space before the first child and after the last child.

`MainAxisAlignment.spaceAround`
: Similar to `MainAxisAlignment.spaceEvenly` but reduces half of the space before the first child and after the last child. 

#### Code example: mainAxisAlignment property
{:.no_toc}
{{site.alert.secondary}}
  Try Dart.

  Notice how `mainAxisAlignment` is set to `MainAxisAlignment.start`.

  **1.** Click the **Run** button.

  **2.** Change the `mainAxisAlignment` property to `MainAxisAlignment.end`.

  **3.** Click the **Run** button. 
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/cb8abed13f90a6a0c7a0ada6f15a09c9
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=cb8abed13f90a6a0c7a0ada6f15a09c9&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>
{{site.alert.tip}}
  Before moving to the next section, try changing `MainAxisAlignment.start` to one of the other enums. 
{{site.alert.end}}

## crossAxisAlignment property

Similar to the `mainAxisAlignment` property, 
`crossAxisAlignment` is a property that determines how `Row` and `Column` can position their children in extra space. 
However, 
the `crossAxisAlignment` property determines how `Row` and `Column` can position their children *vertically* in that extra space. 
Note that most of the `crossAxisAlignment` property's enums only function inside of `Row`. 
The `crossAxisAlignment` property has five `CrossAxisAlignment` enums:

`CrossAxisAlignment.start`
: Positions children near the top of the cross axis. (`Row`)

`CrossAxisAlignment.end`
: Positions children near the bottom of the cross axis. (`Row`)

`CrossAxisAlignment.center`
: Positions children at the middle of the cross axis. (`Row`)

`CrossAxisAlignment.stretch`
: Stretches children across the cross axis. (Top to bottom for `Row`, left to right for `Column`)

`CrossAxisAlignment.baseline`
: Aligns children by their character baselines. (`Text` class)

{{site.alert.tip}}
  `CrossAxisAlignment.baseline` functions with `Text` classes and requires the `textBaseline` property set to `TextBaseline.alphabetic`. In the [Text class](#text-class) section, 
  you encounter a scenario where you may use this enum. 
{{site.alert.end}}

#### Code example: crossAxisAlignment property 
{:.no_toc}
{{site.alert.secondary}}
  Try Dart. 

  In this code example, the `crossAxisAlignnment` property is set to `CrossAxisAlignment.center`. Also, 
  notice how `Row` contains a `BiggerBlueBox` widget and the `mainAxisAlignment` property set to `MainAxisAlignment.spaceAround`. This widget and property help illustrate how the code displays the children vertically. 

  **1.** Click the **Run** button.

  **2.** Change `CrossAxisAlignment.center` to `CrossAxisAlignment.start`.

  **3.** Click the **Run** button. 
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/70a6eb88f13019eec349a57bc4fd5fe0
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=70a6eb88f13019eec349a57bc4fd5fe0&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>
{{site.alert.tip}}
  Before moving to the next section, try changing `CrossAxisAlignment.center` to one of the other enums. 
{{site.alert.end}}

## Flexible class

`mainAxisAlignment` and `crossAxisAlignment` are properties that determine how `Row` and `Column` can position widgets
in extra space. When `Row` and `Column` lay out widgets, they lay out widgets of a fixed size first. Widgets
of a fixed size are considered "inflexible" because they can't resize themselves after `Row` and `Column` lay them out. 

`Flexible` is a class that wraps around a widget, takes the widget as its child, and then resizes the widget.
When the `Flexible` class wraps around a widget, the widget is considered "flexible" because the widget can resize 
itself. `Row` and `Column` lay out flexible widgets after they lay out inflexible widgets. Flexible widgets can resize themselves according to their `flex` and `fit` properties:

`flex`
: Compares itself against other `flex` properties before determining what fraction of the total extra space each flexible widget receives.

`fit` 
: Determines whether a flexible widget fills all of its extra space.

#### Code example: flex property
{:.no_toc}
{{site.alert.secondary}}
  Checkout Dart. 

  Notice how two `Flexible` classes wrap around two `BlueBox` widgets. Also, notice that the `Flexible` classes contain `flex` properties equal to 1. 

  When `flex` properties compare themselves against one another, they add up their `flex` values, and the sum of the `flex` values 
  determines what fraction of the total extra space each flexible widget receives. 
  
  In this code example, the sum of both `flex` values (2) determines that each flexible widget receives half 
  of the extra space. 

  Click the **Run** button. 
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/datafoya/82e4dd24028034ae03ba0ddc71bf59e5
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=82e4dd24028034ae03ba0ddc71bf59e5&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>
{{site.alert.tip}}
  Before moving to the next code example, try changing the `flex` values. 
{{site.alert.end}}

#### Code example: fit property
{:.no_toc}  
{{site.alert.secondary}}
  Try Dart.

  Notice how the `Flexible` classes contain `fit` properties set to `FlexFit.loose`. The `fit` property 
   has two `fit` values that help determine whether a flexible widget can occupy all of its extra space:

  `FlexFit.loose`
  : Enables a flexible widget to occupy as much of or as little of its extra space.

  `FlexFit.tight`
  : Forces a flexible widget to fill of its extra space. 

  In this code example, the `fit` properties restrict the flexible widgets from filling all of their extra space. 

  **1.** Click the **Run** button. 

  **2.** Change the `fit` properties to `FlexFit.tight`.

  **3.** Click the **Run** button.   
{{site.alert.end}}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=ba0f40356d1023066d960f6de2be1a4b&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>

## Expanded class

Similar to the `Flexible` class, `Expanded` is a class that can wrap around a widget and take the widget as its child. 
However, the `Expanded` class forces its widget to fill extra space.  

#### Code example: Expanded class
{:.no_toc}
{{site.alert.secondary}}
  Try Dart.

  The `Expanded` class wraps around a widget in the exact same way that the `Flexible` class does. Except,
   the `Expanded` class doesn't require `flex` and `fit` properties.

  **1.** Click the **Run** button. 

  **2.** Wrap the second BlueBox widget in an `Expanded` class. 
  
  **3.** Click the **Run** button.  
{{site.alert.end}}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=77021d2ed15f9ece850de15e73c47526&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>

## SizedBox class

Similar to the `Flexible` and `Expanded` classes, `SizedBox` is a class that can wrap around a widget, 
take the widget as its child, and then resize the widget. However, the `SizedBox` class also can create space between widgets. Instead of using `flex` and `fit` properties, the `SizedBox` class uses `width` and `height` properties.

{{site.alert.tip}}
  When the `SizedBox` class creates space between widgets, it doesn't take a child widget. 
  It also only uses `width` properties when it's inside of `Row` and `height` properties when it's inside of `Column`.
{{site.alert.end}}
#### Code example: SizedBox with a child
{:.no_toc}
{{site.alert.secondary}}
  Try Dart.

  Notice how `Row` contains two `BlueBox` widgets and one `SizedBox` class that class wraps around a `BlueBox` widget. 
  Also, notice how the `SizedBox` class contains a `width` property equal to 100. 

  **1.** Click the **Run** button.

  **2.** Add a height property equal to 100 inside the `SizedBox` class. 

  **3.** Click the **Run** button.  
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/datafoya/6582851e85b57180ff5321f814fabb81
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=6582851e85b57180ff5321f814fabb81&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>

#### Code example: SizedBox without a child
{:.no_toc}
{{site.alert.secondary}}
  Try Dart.

  Notice how `Row` contains three `BlueBox` widgets and one `SizedBox` class that separates the first and second `BlueBox` widgets. 
  Also, notice how the `SizedBox` class contains a `width` property equal to 50. 

  **1.** Click the **Run** button.

  **2.** Add another `SizedBox` class between the second and third `BlueBox` widgets. 

  **3.** Inside the `SizedBox` class, add a `width` property equal to 25.

  **4.** Click the **Run** button.  
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/datafoya/19ead147ab5c7668d7d32e1cfed90097
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=19ead147ab5c7668d7d32e1cfed90097&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>

## Spacer class

Similar to the `SizedBox` class, `Spacer` is a class that creates space between widgets. However, 
the `Spacer` class can't take child widgets and doesn't create space at exact dimensions. Instead, 
the `Spacer` class creates space using the `flex` property.

#### Code example: Spacer class
{:.no_toc}
{{site.alert.secondary}}
  Try Dart.  

  Notice how `Row` contains three `BlueBox` widgets and one `Spacer` class that separates the first and second `BlueBox` widgets. Also, notice how the `Spacer` class separates the first and second `BlueBox` widgets. 

  **1.** Click the **Run** button.

  **2.** Add another `Spacer` class between the second and third `BlueBox` widgets. 

  **3.** Inside the `Spacer` class, add another `flex` property equal to 1.

  **4.** Click the **Run** button.  
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/datafoya/bfc367aefde35e02ea5283efdbf58e60
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=bfc367aefde35e02ea5283efdbf58e60&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>

## Text class

`Text` is a class that displays a string of text. 
The `Text` class can display text at different font sizes and in different fonts and colors. 

#### Code example: Text class
{:.no_toc}
{{site.alert.secondary}}
  Try Dart.

  Notice how `Row` contains three `Text` classes, which display "Hey!" in the same font but at different font sizes and in different colors. 
  Also, notice that `Row` contains the `crossAxisAlignment` property and the `textBaseline` property. 

  Earlier in this codelab, you learn that `CrossAxisAlignment.baseline` aligns `Text` classes by their character baselines when your code
  contains the `textBaseline` property set to `TextBaseline.alphabetic`.  

  **1.** Click the **Run** button. 

  **2.** Change the `crossAxisAlignment` property to `CrossAxisAlignment.baseline`.

  **3.** Click the **Run** button. 
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/datafoya/0ff109090b99ef1873d9fad501b2bc86
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=0ff109090b99ef1873d9fad501b2bc86&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>

## Icon class

`Icon` is a class that displays symbols. Flutter is preloaded with icon packages for Android and iOS applications.

#### Code example: Icon class
{:.no_toc}
{{site.alert.secondary}}
  
  Try Dart.

  Notice how `Row` contains two `Icon` classes that display widget icons at the same size. Also, 
  notice how the `Icon` classes contain different color properties.

  **1.** Click the **Run** button. 

  **2.** Add another widget icon below the red widget icon.

  **3.** Enter a `size` property equal to 50. 

  **4.** Enter a `color` property set to `Colors.amber`.   

  **3.** Click the **Run** button. 
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/datafoya/01688fca8c13f85d93078054af2e858b
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=01688fca8c13f85d93078054af2e858b&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>

## Image class 

`Image` is a class that links to and displays an image. Unlike the widgets previously covered in this codelab, 
the `Image` class references its data, which is stored remotely.

#### Code example: Image class
{:.no_toc}
{{site.alert.secondary}}
  Check out Dart. 

  `Row` contains an `Image` class. Notice how the `Image` class references its image. 
  The `Image` class initiates its link with `.Network` followed by parentheses. Then, inside the parentheses, 
  the `Image` class links to its image.

  In this code example, the code displays an image that's stored remotely on [GitHub](https://github.com/flutter/website/tree/master/examples/layout/sizing/images).

  Click the **Run** button.  
{{site.alert.end}}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=b6f3084800bd139cdb522b8858bb58b7&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>
## Test yourself 
### Part 1
### Part 2
### Part 3
## Conclusion 
