---
title: Create a layout
short-title: Tutorial
description: Learn how to build a layout in Flutter.
diff2html: true
---

{% assign api = '{{site.api}}/flutter' -%}
{% capture examples -%} {{site.repo.this}}/tree/{{site.branch}}/examples {%- endcapture -%}
{% assign rawExFile = 'https://raw.githubusercontent.com/flutter/website/main/examples' -%}
{% capture demo -%} {{site.repo.flutter}}/tree/{{site.branch}}/examples/flutter_gallery/lib/demo {%- endcapture -%}

<style>dl, dd { margin-bottom: 0; }</style>

{{site.alert.secondary}}
## What you'll learn

* How Flutter's layout mechanism works.
* How to lay out widgets in vertical columns and horizontal rows.
* How to build a Flutter layout.
{{site.alert.end}}

This guide explains how to build layouts in Flutter.

The example code builds the layout for the following app:

{% include docs/app-figure.md
   img-class="site-mobile-screenshot border"
   image="ui/layout/layout-demo-app.png"
   caption="The finished app"
   width="50%" %}

**Credits:** Photo by [Dino Reichmuth][ch-photo] on [Unsplash][].
Text by [Switzerland Tourism][].

If you want a high-level understanding of the layout mechanism,
start with [Flutter's approach to layout][].

## Create the app base code

<?code-excerpt path-base="layout/base"?>

1. [Set up your Flutter environment][].

1. [Create a new Flutter app][new-flutter-app].

1. Replace the contents of `lib/main.dart` with the following code.
   This app uses a parameter for the app title and the title shown
   on the app's `appBar`. This decision was made to simplify the code.

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

## Diagram the layout

Use whichever method you prefer, like an interface design tool or a pencil
and a sheet of paper. Figure out where you want to place elements on your
screen before writing code. It's the programming equivalent of the adage:
"Measure twice, cut once."

<ol>
<li markdown="1">

Ask these questions to break the layout down to its basic elements.

* Can you identify the rows and columns?
* Does the layout include a grid?
* Are there overlapping elements?
* Does the UI need tabs?
* What areas require alignment, padding, or borders?

</li>

<li markdown="1">

Identify the larger elements. In this example,
four elements are arranged into a column: an image, two rows,
and a block of text.  

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

Row 2, the **Button** section, has three children:
each child has a column that contains an icon and text.

{% include docs/app-figure.md
    image="ui/layout/layout-sketch-button-block.svg"
    caption="The Button section with three labeled buttons" %}

  </li>

</ol>

</li>
</ol>

After diagramming the layout, consider how you would implement it.

Would you write all of the code in one class?
Or, would you create one class for each part of the layout?

The best practice in Flutter would be to create one class, or Widget,
to contain each part of the layout you designed.
When Flutter needs to re-render part of a user interface,
it updates the smallest part that contains the change.
This is why Flutter makes "everything a widget".
This means that Flutter changes the least amount of the user interface possible
in response to user or other input.

For this guide, you write each element you have identified as its own widget.

## Add the Title section widget

<?code-excerpt path-base="layout/lakes"?>

In this section, you will create a `TitleSection` widget that resembles
the following layout.

{% include docs/app-figure.md
   image="ui/layout/layout-sketch-title-block-unlabeled.svg"
   caption="The Title section as sketch and prototype UI" %}

1. Add the following code after the `MyApp` class.

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
    1. Putting a `Column` inside an `Expanded` widget stretches
      the column to use all remaining free space in the row.
      Setting the `crossAxisAlignment` property to
      `CrossAxisAlignment.start` positions the column at
      the start of the row.
    2. Putting the first row of text inside a `Padding` widget
      enables you to add padding. The second child in the
      `Padding`, also text, displays as grey.
    3. The last two items in the title row are a star icon,
      painted red, and the text `41`. The entire row is inside
      a `Padding` widget and padded along each edge by 32 pixels.

1. In the `body` property, replace the `Center` widget with a
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

   * A `SingleChildScrollView` widget can scroll to display
     elements that don't fit on the current screen.
   * A `Column` widget displays any elements within its `children` property
     in a stack.
     The first element listed in the `children` array displays at
     the top of the stack. Elements in the `children` array display
     in array order on the screen from top to bottom.

1. Add the `TitleSection` widget as the first element in the `children` array.
   This places it at the top of the screen. As the `TitleSection` widget
   constructor takes parameters, pass the provided name and location
   to that widget.

    <?code-excerpt "{../base,step2}/lib/main.dart" from="children:" to="],"?>
    ```diff
    --- ../base/lib/main.dart
    +++ step2/lib/main.dart
    @@ -23 +19,5 @@
    +            children: [
    +              TitleSection(
    +                  name: 'Oeschinen Lake Campground',
    +                  location: 'Kandersteg, Switzerland'),
    +            ],
    ```

{{site.alert.tip}}
  * When pasting code into your app, indentation can
    become skewed. You can fix this in your Flutter editor
    using the [automatic reformatting support][].
  * For a faster development experience,
    try Flutter's [hot reload][] feature.
  * If you have problems, compare your code to [`lib/main.dart`][].
{{site.alert.end}}

## Add the Button section widget

<?code-excerpt path-base="layout/lakes/step3"?>

The **Button** section contains 3 columns that use the same layout:
an icon over a row of text.

{% include docs/app-figure.md
   image="ui/layout/layout-sketch-button-block-unlabeled.svg"
   caption="The Button section as sketch and prototype UI" %}

Distribute these columns in this row to take the same amount of space.
Paint all text and icons with the primary color.

Create a `ButtonSection` widget to contain the code to build the buttons.

<?code-excerpt "lib/main.dart (ButtonStart)" title?>
```dart
class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
// ···
  }
// ···
}
```

### Create a helper to make the buttons

As the code for each column should use the same syntax,
create a private helper method named `buildButtonColumn()`.
Each call to this method passes a color, an `Icon` widget and a `Text` widget.
Given these parameters, the helper returns a `Column` that contains
two children: the `Icon` and the `Text`.
A `Padding` widget separates these children.
The helper also paints these children in the given color.

Add the following code into the `ButtonSection` widget.

<?code-excerpt "lib/main.dart (_buildButtonColumn)" title?>
```dart
class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});
// ···
  Column _buildButtonColumn(Color color, IconData icon, String label) {
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

### Create the button section as a `Row`

To build a row containing these columns, call the helper method three times,
once for each button.
To this method, pass the color, `Icon`, and text for that specific button.
To align the columns along the main axis,
use the `MainAxisAlignment.spaceEvenly` method.
This method arranges the free space evenly before, between,
and after each column.

1. Add the following code into the `ButtonSection` widget before
   the `_buildButtonColumn` widget.

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
              _buildButtonColumn(color, Icons.call, 'CALL'),
              _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
              _buildButtonColumn(color, Icons.share, 'SHARE'),
            ],
          ),
        );
      }

      Column _buildButtonColumn(Color color, IconData icon, String label) {
        return Column(
    // ···
        );
      }
    }
    ```

1. Add the button section to the `children` array.

    <?code-excerpt path-base="layout/lakes"?>
    <?code-excerpt "step{2,3}/lib/main.dart (addWidget)" title?>
    ```diff
    --- step2/lib/main.dart (addWidget)
    +++ step3/lib/main.dart (addWidget)
    @@ -4,6 +4,7 @@
           TitleSection(
               name: 'Oeschinen Lake Campground',
               location: 'Kandersteg, Switzerland'),
    +      ButtonSection(),
         ],
       ),
     ),
    ```

## Add the Text section widget

Add the text description to this app.

{% include docs/app-figure.md
   image="ui/layout/layout-sketch-add-text-block.svg"
   caption="The text block as sketch and prototype UI" %}

<?code-excerpt path-base="layout/lakes"?>

1. Add the following code as a separate widget after the `ButtonSection` widget.
   By setting `softwrap` to `true`, text lines fill the column width before
   wrapping at a word boundary.

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

1. Insert the `TextSection` call into the `body` property.
   This call needs `description` variable set to the text of the
   location description.

    <?code-excerpt "step{3,4}/lib/main.dart (addWidget)" title?>
    ```diff
    --- step3/lib/main.dart (addWidget)
    +++ step4/lib/main.dart (addWidget)
    @@ -5,6 +5,15 @@
               name: 'Oeschinen Lake Campground',
               location: 'Kandersteg, Switzerland'),
           ButtonSection(),
    +      TextSection(
    +        description:
    +            'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
    +            'Alps. Situated 1,578 meters above sea level, it is one of the '
    +            'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
    +            'half-hour walk through pastures and pine forest, leads you to the '
    +            'lake, which warms to 20 degrees Celsius in the summer. Activities '
    +            'enjoyed here include rowing, and riding the summer toboggan run.',
    +      ),
         ],
       ),
     ),
    ```

## Add the Image section widget

At this point, the layout has three of the four column elements.
Now, you should add the image file to this app.

### Configure your app to use images

1. Create an `images` directory at the top of the project.

1. Add [`lake.jpg`][].

   {{site.alert.info}}
     You can't use `wget` to save this binary file.
     You can download the [image][ch-photo] from [Unsplash][]
     under the Unsplash License. The small size comes in at 94.4 kB.
   {{site.alert.end}}

1. Update the `pubspec.yaml` file to include an `assets` tag.
   This makes the image available to your code.

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
  * Text in `pubspec.yaml` is case sensitive,
    so write `assets:` and the image URL
    as shown in the previous example.
  * The pubspec file is also sensitive to white space,
    so use proper indentation.
  * You might need to restart the running program
    (either on the simulator or a connected device)
    for the `pubspec` changes to take effect.
{{site.alert.end}}

This allows you to reference the image from your code.

### Add the image to the app

1. Add the following `ImageSection` widget to the end of your app code.

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

   `BoxFit.cover` tells the framework that the image should
   be as small as possible but cover its entire render box.

1. Insert the `ImageSection` call as the first child in the `children` array.
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
               location: 'Kandersteg, Switzerland'),
    ```

**Dart code:** [`main.dart`][]<br>
**Image:** [images][]<br>
**Pubspec:** [`pubspec.yaml`][]<br>

That's it! When you hot reload the app,
you should see the same app layout as
the screenshot at the top of this page.

To add interactivity to this layout, follow the tutorial on
[Adding Interactivity to Your Flutter App][].


[Adding Interactivity to Your Flutter App]: {{site.url}}/ui/interactivity
[automatic reformatting support]: {{site.url}}/tools/formatting
[ch-photo]: https://unsplash.com/photos/red-and-gray-tents-in-grass-covered-mountain-5Rhl-kSRydQ
[Unsplash]: https://unsplash.com/
[Switzerland Tourism]: https://www.myswitzerland.com/en-us/destinations/lake-oeschinen/
[Flutter's approach to layout]: {{site.url}}/ui/layout
[new-flutter-app]: {{site.url}}/get-started/test-drive
[images]: {{examples}}/layout/lakes/step6/images
[`lake.jpg`]: {{rawExFile}}/layout/lakes/step5/images/lake.jpg
[`lib/main.dart`]: {{examples}}/layout/lakes/step2/lib/main.dart
[hot reload]: {{site.url}}/tools/hot-reload
[`main.dart`]: {{examples}}/layout/lakes/step6/lib/main.dart
[`pubspec.yaml`]: {{examples}}/layout/lakes/step6/pubspec.yaml
[Set up your Flutter environment]: {{site.url}}/get-started/install
