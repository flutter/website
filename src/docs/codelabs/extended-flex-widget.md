---
title: "Basic Flutter layout concepts"
description: "A codelab that teaches basic Flutter layout concepts through DartPad2 code examples."
toc: true
--- 
{{site.alert.important}}
  This codelab covers basic Flutter layout concepts using a browser-based code editor called DartPad. Currently, DartPad is in the experimental stage and has experienced issues on Safari. If you encounter any difficulties while using DartPad, please create a [DartPad issue](https://github.com/dart-lang/dart-pad/issues/new) and label the issue "platform-web."
{{site.alert.end}} 
## Introduction

Flutter is different from other frameworks in that its UI is built from code, not an XML file (or similar). 
Widgets are the basic building blocks of Flutter's UI. As you progress through this codelab, 
you'll learn that almost everything in Flutter is a widget. A widget is an immutable object that describes a specific part of a UI. You'll also learn that Flutter's widgets are composable; meaning, 
you can combine existing widgets to make more sophisticated widgets. For example, widgets can be built around and inside of other widgets, and widgets can have interconnected and ordered relationships with one another. 
At the end of this codelab, you'll apply what you've learned to build an interface that uses Flutter's basic layout concepts. 
## Row and Column classes
`Row` and `Column` are classes that contain and lay out widgets. These widgets are called "children," 
and `Row` and `Column` are referred to as "parents." `Row` lays out its widgets *horizontally*, and 
`Column` lays out its widgets *vertically*. 

#### Example: Create a Row
{:.no_toc}
{{site.alert.secondary}}
{:.no_toc}  
  The following code example displays three blue squares horizontally. 

  Click the **Run** button.
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/26c8fb02c58c4120917b073ec6253953
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=26c8fb02c58c4120917b073ec6253953&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe> 

#### Example: Create a Column
{:.no_toc}
{{site.alert.secondary}}
{:.no_toc}
  The following code example displays three blue squares vertically. 

  The difference between this example and the previous one is that `MyWidget` in the code below returns a `Column`.

  Click the **Run** button. 
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/db96dc75c3283227bc849ba31d213783
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=db96dc75c3283227bc849ba31d213783&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>

## Alignment

So far, the blue boxes have been displayed close together (either to the left or at the top) of the UI Output. You can change their spacing using the following alignment properties.

### mainAxisSize property

`Row` and `Column` occupy different main axes. `Row`\'s main axis is horizontal, and `Column`\'s main axis is vertical. 
`mainAxisSize` is a property that determines how much space `Row` and `Column` can occupy on their main axes.
`mainAxisSize` has two possible values: 

`MainAxisSize.max`
: Increases the amount of space `Row` and `Column` can occupy on their main axes. 
`Row` and `Column` might have extra space.

`MainAxisSize.min`
: Decreases the amount of space `Row` and `Column` can occupy on their main axes.
`Row` and `Column` only have enough space for their children. 

{{site.alert.tip}}
  `MainAxisSize.max` is a default value. Default values aren't required in the code, 
  as shown in the previous code examples. 
{{site.alert.end}}
#### Example: Modify axis size
{:.no_toc}
{{site.alert.secondary}}
{:.no_toc}

  The following example explicitly sets the `mainAxisSize` property to `MainAxisSize.max`.

  **1.** Click the **Run** button. 

  **2.** Change the `mainAxisSize` property to `MainAxisSize.min`.

  **3.** Click the **Run** button. 
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/def3c5c3c68459b5bb4bdfed58f5d024
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=d852e4f07d6c87600fe8e0f186c7a31b&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>

### mainAxisAlignment property

When `mainAxisSize` is set to `MainAxisSize.max`, `Row` and `Column` might have extra space on their main axes. 
`mainAxisAlignment` is a property that determines how `Row` and `Column` can position their children in that extra space. `mainAxisAlignment` has six possible values: 

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

#### Example: mainAxisAlignment property
{:.no_toc}
{{site.alert.secondary}}

  The following example explicitly sets the `mainAxisAlignment` property to `MainAxisAlignment.start`.

  **1.** Click the **Run** button.

  **2.** Change the `mainAxisAlignment` property to `MainAxisAlignment.end`.

  **3.** Click the **Run** button. 
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/cb8abed13f90a6a0c7a0ada6f15a09c9
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=cb8abed13f90a6a0c7a0ada6f15a09c9&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>
{{site.alert.tip}}
  Before moving to the next section, try changing `MainAxisAlignment.start` to one of the other values. 
{{site.alert.end}}

### crossAxisAlignment property

Similar to the `mainAxisAlignment` property, 
`crossAxisAlignment` is a property that determines how `Row` and `Column` can position their children in extra space.
The difference is that the `crossAxisAlignment` property determines how `Row` and `Column` can position their children in vertical space. Most of the `crossAxisAlignment` property's values only work with `Row`, 
and the `crossAxisAlignment` property has five possible values:

`CrossAxisAlignment.start`
: Positions children near the top of the cross axis. (`Row` only)

`CrossAxisAlignment.end`
: Positions children near the bottom of the cross axis. (`Row` only)

`CrossAxisAlignment.center`
: Positions children at the middle of the cross axis. (`Row` only)

`CrossAxisAlignment.stretch`
: Stretches children across the cross axis. (Top to bottom for `Row`, left to right for `Column`)

`CrossAxisAlignment.baseline`
: Aligns children by their character baselines. (`Text` class only)

{{site.alert.tip}}
  `CrossAxisAlignment.baseline` works with `Text` classes and requires the `textBaseline` property set to `TextBaseline.alphabetic`. See the [Text class](#text-class) section for an example of this value. 
{{site.alert.end}}

#### Example: crossAxisAlignment property 
{:.no_toc}
{{site.alert.secondary}}
  The following example explicitly sets the `crossAxisAlignnment` property to `CrossAxisAlignment.center`. 
  Also, notice how `Row` contains a `BiggerBlueBox` widget and the `mainAxisAlignment` property set to `MainAxisAlignment.spaceAround`. This widget and property help illustrate how the code displays the children in vertical space. 

  **1.** Click the **Run** button.

  **2.** Change `CrossAxisAlignment.center` to `CrossAxisAlignment.start`.

  **3.** Click the **Run** button. 
{{site.alert.end}}
{% comment %}
  Gist: https://gist.github.com/70a6eb88f13019eec349a57bc4fd5fe0
{% endcomment %}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=70a6eb88f13019eec349a57bc4fd5fe0&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>
{{site.alert.tip}}
  Before moving to the next section, try changing `CrossAxisAlignment.center` to one of the other values. 
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

#### Example: flex property
{:.no_toc}
{{site.alert.secondary}}
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

#### Example: fit property
{:.no_toc}  
{{site.alert.secondary}}
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

## Expanded widget

Similar to the `Flexible` class, `Expanded` is a class that can wrap around a widget and take the widget as its child. 
However, the `Expanded` class forces its widget to fill extra space.  

#### Example: Expanded widget
{:.no_toc}
{{site.alert.secondary}}
  The `Expanded` class wraps around a widget in the exact same way that the `Flexible` class does. Except,
   the `Expanded` class doesn't require `flex` and `fit` properties.

  **1.** Click the **Run** button. 

  **2.** Wrap the second BlueBox widget in an `Expanded` class. 
  
  **3.** Click the **Run** button.  
{{site.alert.end}}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=77021d2ed15f9ece850de15e73c47526&amp;&fw=true&amp;split=60" width="100%" height="400px"></iframe>

## SizedBox widget

Similar to the `Flexible` and `Expanded` classes, `SizedBox` is a class that can wrap around a widget, 
take the widget as its child, and then resize the widget. However, the `SizedBox` class also can create space between widgets. Instead of using `flex` and `fit` properties, the `SizedBox` class uses `width` and `height` properties.

{{site.alert.tip}}
  When the `SizedBox` class creates space between widgets, it doesn't take a child widget. 
  It also only uses `width` properties when it's inside of `Row` and `height` properties when it's inside of `Column`.
{{site.alert.end}}
#### Example: SizedBox with a child
{:.no_toc}
{{site.alert.secondary}}
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

#### Example: SizedBox without a child
{:.no_toc}
{{site.alert.secondary}}
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

## Spacer widget

Similar to the `SizedBox` class, `Spacer` is a class that creates space between widgets. However, 
the `Spacer` class can't take child widgets and doesn't create space at exact dimensions. Instead, 
the `Spacer` class creates space using the `flex` property.

#### Example: Spacer widget
{:.no_toc}
{{site.alert.secondary}}
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

## Text widget

`Text` is a class that displays a string of text. 
The `Text` class can display text at different font sizes and in different fonts and colors. 

#### Example: Text widget
{:.no_toc}
{{site.alert.secondary}}
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

## Icon widget

`Icon` is a class that displays symbols. Flutter is preloaded with icon packages for Android and iOS applications.

#### Example: Icon widget
{:.no_toc}
{{site.alert.secondary}}
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

## Image widget 

`Image` is a class that links to and displays an image. Unlike the widgets previously covered in this codelab, 
the `Image` class references its data, which is stored remotely.

#### Example: Image widget
{:.no_toc}
{{site.alert.secondary}}
  `Row` contains an `Image` class. Notice how the `Image` class references its image. 
  The `Image` class initiates its link with `.Network` followed by parentheses. Then, inside the parentheses, 
  the `Image` class links to its image.

  In this code example, the code displays an image that's stored remotely on [GitHub](https://github.com/flutter/website/tree/master/examples/layout/sizing/images).

  Click the **Run** button.  
{{site.alert.end}}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=b6f3084800bd139cdb522b8858bb58b7&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>

## Putting it all together 
{:.no_toc}

In this section of the codelab, you'll apply techniques that you've learned and build a UI that displays a business card.

### Part 1
{:.no_toc}

This part contains two examples. In the first part, you build a `Column` that displays a name and business title. In the second part, you wrap the `Column` that you create in a `Row` that displays the name, business title, and business icon. 

#### Example: Name and business title 
{:.no_toc}
{{site.alert.secondary}}

  To complete this example, you need to build a `Column` that contains the following classes.  

  * Two `Text` classes.

  One `Text` class that contains the name "Flutter McFlutter" and a `style` property set to `Theme.of(context).textTheme.headline`.

  Another `Text` class that contains the title "Experienced Developer."

  * A `mainAxisSize` property set to `MainAxisSize.min`
  * A `crossAxisAlignment` property set to `CrossAxisAlignment.start`.  
{{site.alert.end}}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=30ccbe0fcf31cc10eafba3aea8ff0697&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>

#### Example: Business icon
{:.no_toc}
{{site.alert.secondary}}
  To complete this example, you need to wrap the `Column` you created in a `Row` that contains the following classes.

  * An `Icon` class set to `Icons.account_circle` and that contains a `size` property set to 50.
  * A `Padding` widget that wraps around the `Icon` class. The `Padding` widget also contains a `padding` constraint set to `const EdgeInsets.all(8.0)`.

{{site.alert.end}}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=95dcc1451aea8412669c41eb8a1a5f23&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>

### Part 2
{:.no_toc}

#### Example: Contact information 1
{{site.alert.secondary}}
  
  To complete this example, you need to wrap the `Row` you created in a `Column` that contains the following classes.

  **1.** A `mainAxisSize` property set to `MainAxisSize.min`. 

  **3.** A `crossAxisAlignment` property set to `CrossAxisAlignment.stretch`.

  **4.** A `SizedBox` class with a height property equal to 8.

  **5.** An empty `Row` class.

  **6.** Another `SizedBox` class with a height property equal to 16.

  **7.** Another empty `Row` class. 
{{site.alert.end}}

<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=c3ac34ed8952724a0ecb0af1445c2af8&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>

#### Example: Contact information 2

{{site.alert.secondary}}

**1.** In the first `Row` class' list of children, add a `Text` class that contains the address `'123 Main Street'`.

**2.** In the second `Row` class' list of children, add a `Text` class that contain the phone number `'123-456-7890'`.

**3.** Set the first `Row` class' `mainAxisAlignment` to `mainAxisAlignment.SpaceBetween`.

{{site.alert.end}}
<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=c5be61116652927c5d92262fce1b5360&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>

### Part 3
{:.no_toc}
{{site.alert.secondary}}
{{site.alert.end}}

<iframe src="https://dartpad.dev/experimental/embed-new-flutter.html?id=dae36611fc9af04c4b9d0fbc3429275e&amp;fw=true&amp;split=60" width="100%" height="400px"></iframe>

## Conclusion
{:.no_toc} 
