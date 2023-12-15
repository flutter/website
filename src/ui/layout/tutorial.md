---
title: Create a layout
short-title: Tutorial
description: Learn how to build a layout in Flutter.
diff2html: true
---

{% assign api = '{{site.api}}/flutter' -%}
{% capture examples -%} {{site.repo.this}}/tree/{{site.branch}}/examples {%- endcapture -%}
{% assign rawExFile = '<https://raw.githubusercontent.com/flutter/website/main/examples>' -%}
{% capture demo -%} {{site.repo.flutter}}/tree/{{site.branch}}/examples/flutter_gallery/lib/demo {%- endcapture -%}

<style>dl, dd { margin-bottom: 0; }</style>

{{site.alert.secondary}}

## What you'll learn

* How to lay out widgets next to each other.
* How to add space between widgets.
* How adding and nesting widgets results in a Flutter layout.
{{site.alert.end}}

This tutorial explains how to design and build layouts in Flutter.

If you use the example code provided, you can build the following app.

{% include docs/app-figure.md
   img-class="site-mobile-screenshot border"
   image="ui/layout/layout-demo-app.png"
   caption="The finished app"
   width="50%" %}

**Credits:** Photo by [Dino Reichmuth][ch-photo] on [Unsplash][].
Text by [Switzerland Tourism][].

To get a better overview of the layout mechanism, start with
[Flutter's approach to layout][].

## Diagram the layout

In this section, consider what type of user experience you want for
your app users.

Consider how to position the components of your user interface.
A layout consists of the total end result of these positionings.
Consider planning your layout to speed up your coding.
Using visual cues to know where something goes on screen can be a great help.

Use whichever method you prefer, like an interface design tool or a pencil
and a sheet of paper. Figure out where you want to place elements on your
screen before writing code. It's the programming version of the adage:
"Measure twice, cut once."

<ol>
<li markdown="1">

Ask these questions to break the layout down to its basic elements.

* Can you identify the rows and columns?
* Does the layout include a grid?
* Are there overlapping elements?
* Does the UI need tabs?
* What do you need to align, pad, or border?

</li>

<li markdown="1">

Identify the larger elements. In this example, you arrange the image, title,
buttons, and description into a column.

{% include docs/app-figure.md
    img-class="site-mobile-screenshot border"
    image="ui/layout/layout-sketch-intro.svg"
    caption="Major elements in the layout: image, row, row, and text block"
    width="50%" %}

</li>
<li markdown="1">

Diagram each row.

<ol type="a">

<li markdown="1">

Row 1, the **Title** section, has three children:
a column of text, a star icon, and a number.
Its first child, the column, contains two lines of text.
That first column might need more space.

{% include docs/app-figure.md
   image="ui/layout/layout-sketch-title-block.svg"
   caption="Title section with text blocks and an icon"
   -%}

</li>

<li markdown="1">

Row 2, the **Button** section, has three children: each child contains
a column which then contains an icon and text.

{% include docs/app-figure.md
    image="ui/layout/layout-sketch-button-block.svg"
    caption="The Button section with three labeled buttons" %}

  </li>

</ol>

</li>
</ol>

After diagramming the layout, consider how you would code it.

Would you write all the code in one class?
Or, would you create one class for each part of the layout?

To follow Flutter best practices, create one class, or Widget,
to contain each part of your layout.
When Flutter needs to re-render part of a UI,
it updates the smallest part that changes.
This is why Flutter makes "everything a widget".
If the only the text changes in a `Text` widget, Flutter redraws only that text.
Flutter changes the least amount of the UI possible in response to user input.

For this tutorial, write each element you have identified as its own widget.

## Create the app base code

In this section, shell out the basic Flutter app code to start your app.

<?code-excerpt path-base="layout/base"?>

1. [Set up your Flutter environment][].

1. [Create a new Flutter app][new-flutter-app].

1. Replace the contents of `lib/main.dart` with the following code.
   This app uses a parameter for the app title and the title shown
   on the app's `appBar`. This decision simplifies the code.

   <?code-excerpt "lib/main.dart (all)" title?>
   ```dart
   import 'package:flutter/material.dart';

   void main() => runApp(const MyApp());

   class MyApp extends StatelessWidget {
     const MyApp({super.key});

     @override
     Widget build(BuildContext context) {
       const String appTitle = 'Flutter layout demo';
       return MaterialApp(
         title: appTitle,
         home: Scaffold(
           appBar: AppBar(
             title: const Text(appTitle),
           ),
           body: const Center(
             child: Text('Hello World'),
           ),
         ),
       );
     }
   }
   ```

## Add the Title section

In this section, create a `TitleSection` widget that resembles
the following layout.

<?code-excerpt path-base="layout/lakes"?>

{% include docs/app-figure.md
   image="ui/layout/layout-sketch-title-block-unlabeled.svg"
   caption="The Title section as sketch and prototype UI" %}

### Add the `TitleSection` Widget

Add the following code after the `MyApp` class.

<?code-excerpt "step2/lib/main.dart (titleSection)" title?>
```dart
class TitleSection extends StatelessWidget {
  const TitleSection({
    super.key,
    required this.name,
    required this.location,
  });

  final String name;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  location,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          const Text('41'),
        ],
      ),
    );
  }
}
```

{:.numbered-code-notes}

1. To use all remaining free space in the row, use the `Expanded` widget to
   stretch the `Column` widget.
   To place the column at the start of the row,
   set the `crossAxisAlignment` property to `CrossAxisAlignment.start`.
2. To add space between the rows of text, put those rows in a `Padding` widget.
3. The title row ends with a red star icon and the text `41`.
    The entire row falls inside a `Padding` widget and pads each edge
    by 32 pixels.

### Change the app body to a scrolling view

In the `body` property, replace the `Center` widget with a
`SingleChildScrollView` widget.
Within the `SingleChildScrollView` widget, replace the `Text` widget with a
`Column` widget.

<?code-excerpt "{../base,step2}/lib/main.dart" from="body:" to="children: ["?>
```diff
--- ../base/lib/main.dart
+++ step2/lib/main.dart
@@ -21,2 +17,3 @@
-        body: const Center(
-          child: Text('Hello World'),
+        body: const SingleChildScrollView(
+          child: Column(
+            children: [
```

These code updates change the app in the following ways.

* A `SingleChildScrollView` widget can scroll.
  This allows elements that don't fit on the current screen to display.
* A `Column` widget displays any elements within its `children` property
  in a stack.
  The first element listed in the `children` array displays at
  the top of the stack. Elements in the `children` array display
  in array order on the screen from top to bottom.

### Update the app to display the title section

Add the `TitleSection` widget as the first element in the `children` array.
This places it at the top of the screen.
Pass the provided name and location to the `TitleSection` constructor.

<?code-excerpt "{../base,step2}/lib/main.dart" from="children:" to="],"?>
```diff
--- ../base/lib/main.dart
+++ step2/lib/main.dart
@@ -23 +19,6 @@
+            children: [
+              TitleSection(
+                name: 'Oeschinen Lake Campground',
+                location: 'Kandersteg, Switzerland',
+              ),
+            ],
```

{{site.alert.tip}}

* When pasting code into your app, indentation can become skewed.
      To fix this in your Flutter editor, use [automatic reformatting support][].
* To accelerate your development, try Flutter's [hot reload][] feature.
* If you have problems, compare your code to [`lib/main.dart`][].

{{site.alert.end}}

## Add the Button section

In this section, add the Buttons that will add functionality to your app.

<?code-excerpt path-base="layout/lakes/step3"?>

The **Button** section contains three columns that use the same layout:
an icon over a row of text.

{% include docs/app-figure.md
   image="ui/layout/layout-sketch-button-block-unlabeled.svg"
   caption="The Button section as sketch and prototype UI" %}

Plan to distribute these columns in one row so each takes the same
amount of space. Paint all text and icons with the primary color.

### Add the `ButtonSection` widget

Add the following code after the `TitleSection` widget to contain the code
to build the row of buttons.

<?code-excerpt "lib/main.dart (ButtonStart)" title?>
```dart
class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
// ···
  }
}
```

### Create a helper method to make buttons

As the code for each column could use the same syntax,
create a helper method named `ButtonSection()`.
Each call to this method passes a color, an `Icon` widget and a `Text` widget.
Given these parameters, the helper returns a `Column` widget.
Each contains two children: the `Icon` and the `Text`.
A `Padding` widget separates these children.
The helper also paints these children in the given color.

Add the following code after the `ButtonSection` widget.

<?code-excerpt "lib/main.dart (BuildButtonColumn)" title?>
```dart
class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});
// ···
}

class BuildButtonColumn extends StatelessWidget {
  const BuildButtonColumn({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
  });

  final Color color;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
```

### Position the buttons with a `Row` widget

Add the following code into the `ButtonSection` widget.

1. Call the helper method three times, once for each button.
1. Pass the color, `Icon`, and text for that specific button.
1. Align the columns along the main axis with the
   `MainAxisAlignment.spaceEvenly` method.
   This arranges the free space in equal amounts before, between,
   and after each column.

<?code-excerpt "lib/main.dart (ButtonSection)" title?>
```dart
class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BuildButtonColumn(
            color: color,
            icon: Icons.call,
            label: 'CALL',
          ),
          BuildButtonColumn(
            color: color,
            icon: Icons.near_me,
            label: 'ROUTE',
          ),
          BuildButtonColumn(
            color: color,
            icon: Icons.share,
            label: 'SHARE',
          ),
        ],
      ),
    );
  }
}

class BuildButtonColumn extends StatelessWidget {
  const BuildButtonColumn({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
  });

  final Color color;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
// ···
    );
  }
}
```

### Update the app to display the button section

Add the button section to the `children` array.

    <?code-excerpt path-base="layout/lakes"?>
    
    <?code-excerpt "step{2,3}/lib/main.dart (addWidget)" title?>
    ```diff
    --- step2/lib/main.dart (addWidget)
    +++ step3/lib/main.dart (addWidget)
    @@ -5,6 +5,7 @@
             name: 'Oeschinen Lake Campground',
             location: 'Kandersteg, Switzerland',
           ),
    +      ButtonSection(),
         ],
       ),
     ),
    ```

## Add the Text section

In this section, add the text description to this app.

{% include docs/app-figure.md
   image="ui/layout/layout-sketch-add-text-block.svg"
   caption="The text block as sketch and prototype UI" %}

<?code-excerpt path-base="layout/lakes"?>

### Add the `TextSection` widget

Add the following code as a separate widget after the `ButtonSection` widget.

<?code-excerpt "step4/lib/main.dart (TextSection)" title?>
```dart
class TextSection extends StatelessWidget {
  const TextSection({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Text(
        description,
        softWrap: true,
      ),
    );
  }
}
```

By setting `softwrap` to `true`, text lines fill the column width before
wrapping at a word boundary.

### Update the app to display the text section

Insert the `TextSection` call into the `body` property.
This call needs `description` variable set to the text of the
location description.

<?code-excerpt "step{3,4}/lib/main.dart (addWidget)" title?>
```diff
--- step3/lib/main.dart (addWidget)
+++ step4/lib/main.dart (addWidget)
@@ -6,6 +6,16 @@
         location: 'Kandersteg, Switzerland',
       ),
       ButtonSection(),
+      TextSection(
+        description:
+            'Lake Oeschinen lies at the foot of the Blüemlisalp in the '
+            'Bernese Alps. Situated 1,578 meters above sea level, it '
+            'is one of the larger Alpine Lakes. A gondola ride from '
+            'Kandersteg, followed by a half-hour walk through pastures '
+            'and pine forest, leads you to the lake, which warms to 20 '
+            'degrees Celsius in the summer. Activities enjoyed here '
+            'include rowing, and riding the summer toboggan run.',
+      ),
     ],
   ),
 ),
```

## Add the Image section

In this section, add the image file to complete your layout.

### Configure your app to use supplied images

In this section, configure your app to reference images in your Flutter project.

1. Create an `images` directory at the top of the project.

1. Add [`lake.jpg`][].

   {{site.alert.info}}
     You can't use `wget` to save this binary file.
     You can download the [image][ch-photo] from [Unsplash][]
     under the Unsplash License. The small size comes in at 94.4 kB.
   {{site.alert.end}}

1. Update the `pubspec.yaml` file at the root directory of your app
   to include an `assets` tag.
   This change makes the image available to your code.

   <?code-excerpt "{step4,step5}/pubspec.yaml"?>
   ```diff
   --- step4/pubspec.yaml
   +++ step5/pubspec.yaml
   @@ -19,3 +19,5 @@

    flutter:
      uses-material-design: true
   +  assets:
   +    - images/lake.jpg
   ```

{{site.alert.tip}}

Text in the `pubspec.yaml` respects whitespace and text case.
Write the changes to the app as given in the previous example.

This change might require you to restart the running program to
display the image.

{{site.alert.end}}

### Create the `ImageSection` widget

Add the following `ImageSection` widget to the end of your app code.

<?code-excerpt "step5/lib/main.dart (ImageSection)" title?>
```dart
class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      width: 600,
      height: 240,
      fit: BoxFit.cover,
    );
  }
}
```

The `BoxFit.cover` method tells Flutter to display the image with
two constraints. First, display the image as small as possible.
Second, cover all the space that the layout allotted, called the render box.

### Update the app to display the image section

Insert the `ImageSection` call as the first child in the `children` array.
This call needs `image` variable set to the path of the image file.

<?code-excerpt "step{4,5}/lib/main.dart (addWidget)" title?>
```diff
--- step4/lib/main.dart (addWidget)
+++ step5/lib/main.dart (addWidget)
@@ -1,6 +1,9 @@
 body: const SingleChildScrollView(
   child: Column(
     children: [
+      ImageSection(
+        image: 'images/lake.jpg',
+      ),
       TitleSection(
         name: 'Oeschinen Lake Campground',
         location: 'Kandersteg, Switzerland',
```

## Congratulations

That's it! When you hot reload the app, your app should look like this.

{% include docs/app-figure.md
   img-class="site-mobile-screenshot border"
   image="ui/layout/layout-demo-app.png"
   caption="The finished app"
   width="50%" %}

## Resources

You can access the resources used in this tutorial from these locations:

**Dart code:** [`main.dart`][]<br>
**Image:** [ch-photo][]<br>
**Pubspec:** [`pubspec.yaml`][]<br>

## Next Steps

To add interactivity to this layout, follow the
[interactivity tutorial][Adding Interactivity to Your Flutter App].

[Adding Interactivity to Your Flutter App]: {{site.url}}/ui/interactivity
[automatic reformatting support]: {{site.url}}/tools/formatting
[ch-photo]: https://unsplash.com/photos/red-and-gray-tents-in-grass-covered-mountain-5Rhl-kSRydQ
[Unsplash]: https://unsplash.com/
[Switzerland Tourism]: https://www.myswitzerland.com/en-us/destinations/lake-oeschinen/
[Flutter's approach to layout]: {{site.url}}/ui/layout
[new-flutter-app]: {{site.url}}/get-started/test-drive
[`lake.jpg`]: {{rawExFile}}/layout/lakes/step5/images/lake.jpg
[`lib/main.dart`]: {{examples}}/layout/lakes/step2/lib/main.dart
[hot reload]: {{site.url}}/tools/hot-reload
[`main.dart`]: {{examples}}/layout/lakes/step6/lib/main.dart
[`pubspec.yaml`]: {{examples}}/layout/lakes/step6/pubspec.yaml
[Set up your Flutter environment]: {{site.url}}/get-started/install
