---
title: "Codelab: basic Flutter layout concepts"
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
In this codelab, you interact with and build Flutter layouts in a code editor called DartPad2. As you progress through this codelab, you learn that widgets build everything in flutter. A widget is an immutable object that describes a specific part of a UI. You also learn that, while widgets are simple in their functions, widgets can be complex in their structures. Widgets can be built around and inside of other widgets, and widgets can have interconnected and ordered relationships with one another. At the end of this codelab, you apply what you learn and build a simple interface using basic Fluter layout concepts. 
## Row class and Column class
`Row` and `Column` are classes that contain widgets. When `Row` and `Column` contain widgets, the widgets become "children," and `Row` and `Column` become "parents." Moreover, when `Row` and `Column` contain widgets, `Row` and `Column` lay them out. `Row` lays out its widgets horizontally. `Column` lays out its widgets vertically. 
#### Code example: Row
{:.no_toc}
{{site.alert.secondary}}
{:.no_toc}
  *Check out Dart.*

  In the code, `Row` contains three children, all `BlueBox` widgets. 

  In this code example, the code displays three blue squares horizontally.

  ***Run the code.***
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/26c8fb02c58c4120917b073ec6253953
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=26c8fb02c58c4120917b073ec6253953&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe> 

#### Code example: Column
{:.no_toc}
{{site.alert.secondary}}
{:.no_toc}
  *Check out Dart.*

  In the code, `Column` contains three child widgets, all `BlueBox` widgets. 

  In this code example, the code displays three blue squares vertically.

  ***Run the code.***
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/db96dc75c3283227bc849ba31d213783
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=db96dc75c3283227bc849ba31d213783&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>

## mainAxisSize property
`Row` and `Column` occupy different main axes. `Row`\'s main axis is horizontal. `Column`\'s main axis is vertical. `mainAxisSize` is a property that determines how much space `Row` and `Column` can occupy on their main axes. `mainAxisSize` has two `MainAxisSize` enums: 

* `MainAxisSize.max`
<br/>
Increases the amount of space `Row` and `Column` can occupy on their main axes. 
* `MainAxisSize.min` 
<br/>
Decreases the amount of space `Row` and `Column` can occupy on their main axes.  

{{site.alert.tip}}
  `MainAxisSize.max` is a default enum. When  building Flutter layouts, `Row` and `Column` automatically occupy all of the space on their main axes.  
{{site.alert.end}}

#### Code example: MainAxisSize.max
{:.no_toc}
{{site.alert.secondary}}
{:.no_toc}
  *Check out Dart.*

  `Row` contains three `BlueBox` widgets. Notice how `mainAxisSize` is set to `MainAxisSize.max`. 

  When `mainAxisSize` is set to `MainAxisSize.max`, `Row` and `Column` occupy all of the space on their main axes. As a result, `Row` and `Column` may have extra space on their main axes.

  In this code example, the code displays three blue squares, but notice how the grey, rectangular box has extra space. 

  ***Run the code.***
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/def3c5c3c68459b5bb4bdfed58f5d024
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=def3c5c3c68459b5bb4bdfed58f5d024&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>

#### Code example: MainAxisSize.min
{:.no_toc}
{{site.alert.secondary}}
{:.no_toc}
  *Check out Dart.*

  `Row` contains three `BlueBox` widgets. Notice how `mainAxisSize` is set to `MainAxisSize.min`. 

  When `mainAxisSize` is set to `MainAxisSize.min`, `Row` and `Column` only occupy enough space on their main axes for their children. As a result, `Row` and `Column` don't have any extra space on their main axes.

  In this code example, the code displays three blue squares, but notice how the grey, rectangular box doesn't have extra space. 

  ***Run the code.***
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/def3c5c3c68459b5bb4bdfed58f5d024
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=d852e4f07d6c87600fe8e0f186c7a31b&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>

## mainAxisAlignment property
When `mainAxisSize` is set to `MainAxisSize.max`, `Row` and `Column` may have extra space on their main axes. `mainAxisAlignment` is a property that determines how `Row` and `Column` can position their children horizontally in extra space. `mainAxisAlignment` has six `MainAxisAlignment` enums: 

* `MainAxisAlignment.start`<br>
  Positions children near the beginning of the main axis. (Left for `Row`, top for `Column`)
* `MainAxisAlignment.end`<br>
  Positions children near the end of the main axis. (Right for `Row`, bottom for `Column`)
* `MainAxisAlignment.center`<br>
  Positions children at the middle of the main axis.
* `MainAxisAlignment.spaceBetween`<br>
  Divides the extra space evenly between children.
* `MainAxisAlignment.spaceEvenly`<br>
  Divides the extra space evenly between children and creates an even amount of space before the first child and after the last child.
* `MainAxisAlignment.spaceAround`<br>
  Similar to `MainAxisAlignment.spaceEvenly` but reduces half of the space before the first child and after the last child. 

#### Code example: mainAxisAlignment property
{:.no_toc}
{{site.alert.secondary}}
  *Check out Dart.* 

  `Row` contains three `BlueBox` widgets. Notice how `mainAxisAlignment` is set to `MainAxisAlignment.start`.

  In this code example, the code displays three blue squares on the left side of the grey, rectangular box. 

  ***Run the code.***
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/cb8abed13f90a6a0c7a0ada6f15a09c9
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=cb8abed13f90a6a0c7a0ada6f15a09c9&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>
{{site.alert.tip}}
  Before moving to the next section, try resetting `mainAxisAlignment` to one of the other `MainAxisAlignment` enums. 
{{site.alert.end}}

## crossAxisAlignment property
Similar to the `mainAxisAlignment` property, `crossAxisAlignment` is a property that determines how `Row` and `Column` can position their children in extra space. However, the `crossAxisAlignment` property determines how `Row` and `Column` can position their children vertically in extra space. As a result, most of the `crossAxisAlignment` property's enums only function inside of `Row`. The `crossAxisAlignment` property has five `CrossAxisAlignment` enums:

* `CrossAxisAlignment.start`<br>
  Positions children near the top of the cross axis. (`Row`)
* `CrossAxisAlignment.end`<br>
  Positions children near the bottom of the cross axis. (`Row`)
* `CrossAxisAlignment.center`<br>
  Positions children at the middle of the cross axis. (`Row`)
* `CrossAxisAlignment.stretch`<br>
  Stretches children across the cross axis. (Top to bottom for `Row`, left to right for `Column`)
* `CrossAxisAlignment.baseline`<br>
  Aligns children according to their character baselines. (`Text` class)
{{site.alert.note}}
  `CrossAxisAlignment.baseline` aligns `Text` classes along their character baselines, but requires the `textBaseline` property set to `TextBaseline.alphabetic`. In the following code example, if you reset `crossAxisAlignment` to `CrossAxisAlignment.baseline`, the code displays an error message. `CrossAxisAlignment.baseline` is covered in the [Text class](#text-class) section. 
{{site.alert.end}}

#### Code example: crossAxisAlignment property 
{:.no_toc}
{{site.alert.secondary}}
  *Check out Dart.* 

  `Row` contains two `BlueBox` widgets and one `BiggerBlueBox` widget. Notice how `crossAxisAlignment` is set to `CrossAxisAlignment.center`.

  In this code example, the code displays two squares and one rectangle at the middle of the grey, rectangular box. 

***Run the code.***
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/70a6eb88f13019eec349a57bc4fd5fe0
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=70a6eb88f13019eec349a57bc4fd5fe0&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>
{{site.alert.tip}}
  Before moving to the next section, try resetting `crossAxisAlignment` to one of the other `CrossAxisAlignment` enums. 
{{site.alert.end}}
## Flexible class

`mainAxisAlignment` and `crossAxisAlignment` are properties that determine how `Row` and `Column` can position widgets in extra space. When `Row` and `Column` lay out widgets, they lay out widgets of a fixed size first. Widgets of a fixed size are considered "inflexible" because they can't resize themselves after `Row` and `Column` lay them out. 

`Flexible` is a class that wraps around a widget, takes the widget as its child, and then resizes the widget. When the `Flexible` class wraps around a widget, the widget is considered "flexible" because the widget can resize itself. `Row` and `Column` lay out flexible widgets after they lay out inflexible widgets. Flexible widgets can resize themselves according to their `flex` and `fit` properties:

* `flex`
<br>
  Compares itself against other `flex` properties before determining what fraction of the total extra space each flexible widget receives.

* `fit` 
<br>
  Determines whether a flexible widget fills all of its extra space.

#### Code example: flex property
{:.no_toc}
{{site.alert.secondary}}
  *Check out Dart.* 

  `Row` contains one `BlueBox` widget and two `Flexible` classes. Notice how the `Flexible` classes wrap around two `BlueBox` widgets. Also, notice that the `Flexible` classes contain `flex` properties with `flex` values set to 1. 

  When `flex` properties compare themselves against one another, they add up their `flex` values, and the sum of the `flex` values determines what fraction of the total extra space each flexible widget receives. 
  
  In this code example, the sum of both `flex` values (2) determines that each flexible widget receives half of the extra space. 

  ***Run the code.***
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/datafoya/82e4dd24028034ae03ba0ddc71bf59e5
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=82e4dd24028034ae03ba0ddc71bf59e5&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>

#### Code example: fit property
{:.no_toc}  
{{site.alert.secondary}}
  *Check out Dart.*
  
  `Row` contains two `Flexible` classes that both wrap around `BlueBox` widgets. Notice that the `Flexible` classes contain `flex` properties with `flex` values set to 1. Also, notice that the `Flexible` classes contain `fit` properties with `fit` values set to `FlexFit.loose`. The `fit` property has two `fit` values that help determine whether a flexible widget can occupy all of its extra space:

  * `FlexFit.loose`
  <br>
  Enables a flexible widget to occupy as much of or as little of its extra space.
  * `FlexFit.tight`
  <br>
  Forces a flexible widget to fill of its extra space. 

  In this code example, the `fit` properties restrict the flexible widgets from filling all of their extra space. Try resetting the `fit` properties to `FlexFit.tight`.

  ***Run the code.***  
{{site.alert.end}}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=ba0f40356d1023066d960f6de2be1a4b&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>

## Expanded class

Similar to the `Flexible` class, `Expanded` is a class that can wrap around a widget, take the widget as its child, and then resize the widget. However, the `Expanded` class doesn't utilize `flex` and `fit` properties to resize its child. Insetad, the `Expanded` class forces its child to fill extra space. 

#### Code example: Expanded class
{:.no_toc}
{{site.alert.secondary}}
  *Check out Dart.* 

  `Row` contains two `BlueBox` widgets and one `Expanded` class. Notice how the `Expanded` class wraps around another `BlueBox` widget. 

  In this code example, the code displays three blue squares, and the middle square fills all of the extra space inside the grey, rectangular box.  

  ***Run the code.*** 
{{site.alert.end}}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=77021d2ed15f9ece850de15e73c47526&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>

## SizedBox class

Similar to the `Flexible` and `Expanded` classes, `SizedBox` is a class that can wrap around a widget, take the widget as its child, and then resize the widget. However, the `SizedBox` class also can create space between widgets. Instead of utilizing `flex` and `fit` properties, the `SizedBox` class utilizes `width` and `height` properties.

#### Code example: SizedBox with a child
{:.no_toc}
{{site.alert.secondary}}
*Check out Dart.* 

`Row` contains two `BlueBox` widgets and one `SizedBox` class. Notice how the `SizedBox` class wraps around another `BlueBox` widget and contains a `width` property equal to 100. 

In this code example, try adding a height property equal to 100 inside the `SizedBox` class. 

***Run the code.*** 
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/datafoya/6582851e85b57180ff5321f814fabb81
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=6582851e85b57180ff5321f814fabb81&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>

#### Code example: SizedBox without a child
{:.no_toc}
{{site.alert.secondary}}
*Check out Dart.* 

`Row` contains three `BlueBox` widgets and one `SizedBox` class. Notice how the `SizedBox` class separates the first and second `BlueBox` widgets. Also, notice how the `SizedBox` class doesn't wrap around a widget and only contains a `width` property. 

When the `SizedBox` class creates space between widgets, the `SizedBox` class doesn't take a child widget. Also, when `Row` contains a `SizedBox` class, the `SizedBox` class only utilizes a `width` property. Likewise, when `Column` contains a `SizedBox` class, the `SizedBox` class only utilizes a `height` property.

In this code example, try adding another `SizedBox` class between the second and third `BlueBox` widgets. Then add a `width` property equal to 25 inside the `SizedBox` class.

***Run the code.*** 
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/datafoya/19ead147ab5c7668d7d32e1cfed90097
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=19ead147ab5c7668d7d32e1cfed90097&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>

## Spacer class

Similar to the `SizedBox` class, `Spacer` is a class that creates space between widgets. However, the `Spacer` class can't take child widgets and doesn't create space at exact dimensions. Instead, the `Spacer` class creates space utilizing `flex` properties.

#### Code example: Spacer class
{:.no_toc}
{{site.alert.secondary}}
*Check out Dart.* 

`Row` contains three `BlueBox` widgets and one `Spacer` class with a `flex` property equal to 1. Notice how the `Spacer` class separates the first and second `BlueBox` widgets. 

In this code example, try adding another `Spacer` class between the second and third `BlueBox` widgets. Then add another `flex` property equal to 1 inside the `Spacer` class. 

***Run the code.*** 
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/datafoya/bfc367aefde35e02ea5283efdbf58e60
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=bfc367aefde35e02ea5283efdbf58e60&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>

## Text class

`Text` is a class that displays a string of text. The `Text` class can display text at different font sizes and in various fonts and colors. 

#### Code example: Text class
{:.no_toc}
{{site.alert.secondary}}
*Check out Dart.*

  `Row` contains three `Text` classes, which all display "Hey!" in the same font, but at different font sizes and in different colors. Notice how `Row` also contains the `crossAxisAlignment` property and the `textBaseline` property. 

  Earlier in this codelab, you learn about the `crossAxisAlignment` property and its `CrossAxisAlignment` enum `CrossAxisAlignment.baseline`. When `Row` and `Column` contain `Text` classes, the `crossAxisAlignment` property set to `CrossAxisAlignment.baseline` can align the `Text` classes along their character baselines. However, the `crossAxisAlignment` property requires the `textBaseline` property set to `TextBaseline.alphabetic`. 

  In this code example, try resetting the `crossAxisAlignment` property to `CrossAxisAlignment.baseline`.  

***Run the code***
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/datafoya/0ff109090b99ef1873d9fad501b2bc86
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=0ff109090b99ef1873d9fad501b2bc86&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>

## Icon class

`Icon` is a class that displays glyphs. Flutter is preloaded with multiple icon packages for Android and iOS applications. 

#### Code example: Icon class
{:.no_toc}
{{site.alert.secondary}}
  *Check out Dart.* 

  `Row` contains three `Icon` classes, which all display widget icons in the same size. Notice how the first and second `Icon` classes contain `color` properties.

  In this code example, try adding a `color` property set to `Colors.amber` inside the third `Icon` class.   

  ***Run the code***
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/datafoya/01688fca8c13f85d93078054af2e858b
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=01688fca8c13f85d93078054af2e858b&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>

## Image class 

`Image` is a class that links to and displays an image. Unlike the widgets previously covered in this codelab, the `Image` class references its data, which is stored remotely.

#### Code example: Image class
{:.no_toc}
{{site.alert.secondary}}
  *Check out Dart* 

  `Row` contains an `Image` class. Notice how the `Image` class references its image. The `Image` class initiates that it's linking to an image with `.Network` followed by parentheses. Then, inside the parentheses, the `Image` class links to its image.

  In this code example, the code displays an image that's stored remotely on [GitHub](https://github.com/flutter/website/tree/master/examples/layout/sizing/images).

  ***Run the code.*** 
{{site.alert.end}}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=b6f3084800bd139cdb522b8858bb58b7&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>
## Test yourself 
### Part 1
### Part 2
### Part 3
## Conclusion 
