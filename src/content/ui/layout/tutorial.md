---
title: Build a Flutter layout
short-title: Layout tutorial
description: Learn how to build a layout in Flutter.
diff2html: true
---

{% assign examples = site.repo.this | append: "/tree/" | append: site.branch | append: "/examples" -%}

<style>dl, dd { margin-bottom: 0; }</style>

:::secondary What you'll learn
* How to lay out widgets next to each other.
* How to add space between widgets.
* How adding and nesting widgets results in a Flutter layout.
:::

This tutorial explains how to design and build layouts in Flutter.

If you use the example code provided, you can build the following app.

{% render docs/app-figure.md, img-class:"site-mobile-screenshot border", image:"ui/layout/layout-demo-app.png", caption:"The finished app.", width:"50%" %}

<figcaption class="figure-caption">

Photo by [Dino Reichmuth][ch-photo] on [Unsplash][].
Text by [Switzerland Tourism][].

</figcaption>

To get a better overview of the layout mechanism, start with
[Flutter's approach to layout][].

[Switzerland Tourism]: https://www.myswitzerland.com/en-us/destinations/lake-oeschinen
[Flutter's approach to layout]: /ui/layout

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
<li>

Ask these questions to break the layout down to its basic elements.

* Can you identify the rows and columns?
* Does the layout include a grid?
* Are there overlapping elements?
* Does the UI need tabs?
* What do you need to align, pad, or border?

</li>

<li>

Identify the larger elements. In this example, you arrange the image, title,
buttons, and description into a column.

{% render docs/app-figure.md, img-class:"site-mobile-screenshot border", image:"ui/layout/layout-sketch-intro.svg", caption:"Major elements in the layout: image, row, row, and text block", width:"50%" %}

</li>
<li>

Diagram each row.

<ol type="a">

<li>

Row 1, the **Title** section, has three children:
a column of text, a star icon, and a number.
Its first child, the column, contains two lines of text.
That first column might need more space.

{% render docs/app-figure.md, image:"ui/layout/layout-sketch-title-block.svg", caption:"Title section with text blocks and an icon" -%}

</li>

<li>

Row 2, the **Button** section, has three children: each child contains
a column which then contains an icon and text.

{% render docs/app-figure.md, image:"ui/layout/layout-sketch-button-block.svg", caption:"The Button section with three labeled buttons", width:"50%" %}

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
If only the text changes in a `Text` widget, Flutter redraws only that text.
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

   <?code-excerpt "lib/main.dart (all)"?>
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

[Set up your Flutter environment]: /get-started/install
[new-flutter-app]: /get-started/test-drive

## Add the Title section

In this section, create a `TitleSection` widget that resembles
the following layout.

<?code-excerpt path-base="layout/lakes"?>

{% render docs/app-figure.md, image:"ui/layout/layout-sketch-title-block-unlabeled.svg", caption:"The Title section as sketch and prototype UI" %}

### Add the `TitleSection` Widget

Add the following code after the `MyApp` class.

<?code-excerpt "step2/lib/main.dart (title-section)"?>
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
Within the [`SingleChildScrollView`][] widget, replace the `Text` widget with a
`Column` widget.

```diff2html
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
  in the order listed.
  The first element listed in the `children` list displays at
  the top of the list. Elements in the `children` list display
  in array order on the screen from top to bottom.

[`SingleChildScrollView`]: {{site.api}}/flutter/widgets/SingleChildScrollView-class.html

### Update the app to display the title section

Add the `TitleSection` widget as the first element in the `children` list.
This places it at the top of the screen.
Pass the provided name and location to the `TitleSection` constructor.

```diff2html
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

:::tip
* When pasting code into your app, indentation can become skewed.
  To fix this in your Flutter editor, use [automatic reformatting support][].
* To accelerate your development, try Flutter's [hot reload][] feature.
* If you have problems, compare your code to [`lib/main.dart`][].
:::

[automatic reformatting support]: /tools/formatting
[hot reload]: /tools/hot-reload
[`lib/main.dart`]: {{examples}}/layout/lakes/step2/lib/main.dart

## Add the Button section

In this section, add the buttons that will add functionality to your app.

<?code-excerpt path-base="layout/lakes/step3"?>

The **Button** section contains three columns that use the same layout:
an icon over a row of text.

{% render docs/app-figure.md, image:"ui/layout/layout-sketch-button-block-unlabeled.svg", caption:"The Button section as sketch and prototype UI" %}

Plan to distribute these columns in one row so each takes the same
amount of space. Paint all text and icons with the primary color.

### Add the `ButtonSection` widget

Add the following code after the `TitleSection` widget to contain the code
to build the row of buttons.

<?code-excerpt "lib/main.dart (button-start)"?>
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

### Create a widget to make buttons

As the code for each column could use the same syntax,
create a widget named `ButtonWithText`.
The widget's constructor accepts a color, icon data, and a label for the button.
Using these values, the widget builds a `Column` with an `Icon` and a stylized
`Text` widget as its children.
To help separate these children, a `Padding` widget the `Text` widget
is wrapped with a `Padding` widget.

Add the following code after the `ButtonSection` class.

<?code-excerpt "lib/main.dart (button-with-text)"?>
```dart
class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});
// ···
}

class ButtonWithText extends StatelessWidget {
  const ButtonWithText({
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

1. Add three instances of the `ButtonWithText` widget, once for each button.
1. Pass the color, `Icon`, and text for that specific button.
1. Align the columns along the main axis with the
   `MainAxisAlignment.spaceEvenly` value.
   The main axis for a `Row` widget is horizontal and the main axis for a
   `Column` widget is vertical.
   This value, then, tells Flutter to arrange the free space in equal amounts
   before, between, and after each column along the `Row`.

<?code-excerpt "lib/main.dart (button-section)"?>
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
          ButtonWithText(
            color: color,
            icon: Icons.call,
            label: 'CALL',
          ),
          ButtonWithText(
            color: color,
            icon: Icons.near_me,
            label: 'ROUTE',
          ),
          ButtonWithText(
            color: color,
            icon: Icons.share,
            label: 'SHARE',
          ),
        ],
      ),
    );
  }
}

class ButtonWithText extends StatelessWidget {
  const ButtonWithText({
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

Add the button section to the `children` list.

<?code-excerpt path-base="layout/lakes"?>

```diff2html
--- step2/lib/main.dart (add-widget)
+++ step3/lib/main.dart (add-widget)
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

{% render docs/app-figure.md, image:"ui/layout/layout-sketch-add-text-block.svg", caption:"The text block as sketch and prototype UI" %}

<?code-excerpt path-base="layout/lakes"?>

### Add the `TextSection` widget

Add the following code as a separate widget after the `ButtonSection` widget.

<?code-excerpt "step4/lib/main.dart (text-section)"?>
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

By setting [`softWrap`][] to `true`, text lines fill the column width before
wrapping at a word boundary.

[`softWrap`]: {{site.api}}/flutter/widgets/Text/softWrap.html

### Update the app to display the text section

Add a new `TextSection` widget as a child after the `ButtonSection`.
When adding the `TextSection` widget, set its `description` property to
the text of the location description.

```diff2html
--- step3/lib/main.dart (add-widget)
+++ step4/lib/main.dart (add-widget)
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

To configure your app to reference images, modify its `pubspec.yaml` file.

1. Create an `images` directory at the top of the project.

1. Download the [`lake.jpg`][] image and add it to the new `images` directory.

   :::note
   You can't use `wget` to save this binary file.
   You can download the [image][ch-photo] from [Unsplash][]
   under the Unsplash License. The small size comes in at 94.4 kB.
   :::

1. To include images, add an `assets` tag to the `pubspec.yaml` file
   at the root directory of your app.
   When you add `assets`, it serves as the set of pointers to the images
   available to your code.

   ```diff2html
   --- step4/pubspec.yaml
   +++ step5/pubspec.yaml
   @@ -19,3 +19,5 @@

    flutter:
      uses-material-design: true
   +  assets:
   +    - images/lake.jpg
   ```

:::tip
Text in the `pubspec.yaml` respects whitespace and text case.
Write the changes to the file as given in the previous example.

This change might require you to restart the running program to
display the image.
:::

[`lake.jpg`]: https://raw.githubusercontent.com/flutter/website/main/examples/layout/lakes/step5/images/lake.jpg

### Create the `ImageSection` widget

Define the following `ImageSection` widget after the other declarations.

<?code-excerpt "step5/lib/main.dart (image-section)"?>
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

The `BoxFit.cover` value tells Flutter to display the image with
two constraints. First, display the image as small as possible.
Second, cover all the space that the layout allotted, called the render box.

### Update the app to display the image section

Add an `ImageSection` widget as the first child in the `children` list.
Set the `image` property to the path of the image you added in
[Configure your app to use supplied images](#configure-your-app-to-use-supplied-images).

```diff2html
--- step4/lib/main.dart (add-widget)
+++ step5/lib/main.dart (add-widget)
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

{% render docs/app-figure.md, img-class:"site-mobile-screenshot border", image:"ui/layout/layout-demo-app.png", caption:"The finished app", width:"50%" %}

## Resources

You can access the resources used in this tutorial from these locations:

**Dart code:** [`main.dart`][]<br>
**Image:** [ch-photo][]<br>
**Pubspec:** [`pubspec.yaml`][]<br>

[`main.dart`]: {{examples}}/layout/lakes/step6/lib/main.dart
[ch-photo]: https://unsplash.com/photos/red-and-gray-tents-in-grass-covered-mountain-5Rhl-kSRydQ
[`pubspec.yaml`]: {{examples}}/layout/lakes/step6/pubspec.yaml

## Next Steps

To add interactivity to this layout, follow the
[interactivity tutorial][Adding Interactivity to Your Flutter App].

[Adding Interactivity to Your Flutter App]: /ui/interactivity
[Unsplash]: https://unsplash.com
