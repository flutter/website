---
title: "Codelab: Basic Flutter layout"
description: "A codelab that uses DartPad2 to teach Flutter layout concepts."
---

{{site.alert.note}}
  This codelab is being used to test out some new features of
  DartPad! You may encounter bugs,
  malapropisms, annoyances, and other general weirdness.
  If that happens, please take a moment to
  [file a bug on GitHub](https://github.com/dart-lang/dart-pad/issues/new).
  Feature requests and suggestions are also greatly appreciated.
{{site.alert.end}}

{{site.alert.note}}
  This codelab is currently being developed and tested
  with Chrome. There may be (in the short term) features that
  work in some browsers and not others. If you encounter
  any, please feel free to file bugs using the link above.
{{site.alert.end}}

`Row` and `Column` are two very important widgets in the Flutter universe.
Want to put a `Text` widget with a label next to another `Text`
widget with the corresponding value?  Use a `Row`.
Want to present multiple pairs of labels and values?
That's a `Column` of `Row`s. Forms with several fields,
icons next to menu choices, buttons next to
search bars, these are all places where `Row`s and `Column`s are used,

This codelab walks you through how `Row`s and `Column`s work.
Because they're so similar, once you're done learning about 
`Row`s, the codelab mostly shows you how all the same concepts apply
to `Column`s. There are inline editors
along the way so you can play around and test your knowledge.

### Start with a Row and some children

The whole point of a `Row` or `Column` is to contain
other widgets, known as children. In a `Row`, children
are arranged horizontally from first to last in accordance
with text direction. If your device is set to
English or another left-to-right language, it starts from the left.
If you're using Arabic or another right-to-left language, it starts
on the right and moves left.

#### Code example

Below is a widget called `MyWidget` that builds a single `Row`.
Try adding three `BlueBox` widgets to its list of children.

<iframe src="https://dartpad.dartlang.org/experimental/embed-new.html?id=76e993732820ef908ea8424744b9996d&fw=true" width="100%" height="400px"></iframe>

### Main axis size

The main axis of a `Row` is the horizontal one (for
`Column`s, it's the vertical axis). Each `Row` has a
property called `mainAxisSize` that determines how much space
it should take along that axis. By default,
`mainAxisSize` is set to `MainAxisSize.max`, which
causes a `Row` to take up all the available horizontal
space. You can use `MainAxisSize.min` to direct a `Row`
widget to take up as little space as possible.

#### Code example

Here's the example you just finished. Try setting the `Row`'s
`mainAxisSize` property to `MainAxisSize.min` and see what happens.

<iframe src="https://dartpad.dartlang.org/experimental/embed-new.html?id=9ac4ade5961150a27d3e547b667c8037&fw=true" width="100%" height="400px"></iframe>

### Main axis alignment

If you've set the `mainAxisSize` of a `Row` to the minimum,
there won't be any extra room beyond what the children use.
If you've set it to `max`, though, the `Row` may have some
additional space lying around.  You can use the `mainAxisAlignment`
property to control how the `Row` aligns its children within that space.

There are six different values available in the `MainAxisAlignment` enum:

* `MainAxisAligment.start`<br>
   Place all children as close to the start of the `Row` as possible
   (for left-to-right rows, this is the left side).

* `MainAxisAligment.end`<br>
  Place all children as close to the end of the `Row` as possible.

* `MainAxisAligment.center`<br>
  Group the children together in the center of the `Row`.

* `MainAxisAligment.spaceBetween`<br>
  Any extra space is divided evenly and used to make gaps between the children.

* `MainAxisAligment.spaceEvenly`<br>
  Just like `spaceBetween`, except the spots before the first child
  and after the last one also count as gaps.

* `MainAxisAligment.spaceAround`<br>
  Just like `spaceEvenly`, only the first and last gaps get 50% of the
  amount used between children.

#### Code example

The row below has its `mainAxisAlignment` set to start. Try changing it to the
other values and re-running the code to see how things move around.

<iframe src="https://dartpad.dartlang.org/experimental/embed-new.html?id=0c97de625a9aa5c3194f9eecbd73ec1a&fw=true" width="100%" height="400px"></iframe>
### Cross axis alignment

The cross axis for `Row` widgets is the vertical axis,
and you can use the `crossAxisAlignment` property to
control how children are positioned vertically.
The default value is `CrossAxisAlignment.center`,
but there are five options in total:

* `CrossAxisAlignment.start`<br>
  Children are aligned at the start of the `Row`'s vertical space
  (by default, the top is considered to be the start,
  though you can change that via the `verticalDirection` propert).

* `CrossAxisAlignment.end`<br>
  Children are aligned at the end of the `Row`'s
  vertical space (by default, that means the bottom).

* `CrossAxisAlignment.center`<br>
  Children are centered with respect to the vertical axis.

* `CrossAxisAlignment.stretch`<br>
  Children are forced to have the same height as the
  `Row` itself, filling all the vertical space.

* `CrossAxisAlignment.baseline`<br>
  Children are aligned by their baselines (more on this one below).

#### Code example

This `Row` has two small children and one big one. Its
`crossAxisAlignment` property is set to center, the default.
Try changing it to the other values and re-running the code to
see how things move around.

A word of warning: `CrossAxisAlignment.baseline` requires
that another property be set as well, so you
will see an error if you try that one.
Don't worry, though&mdash;it's covered in the next section.

<iframe src="https://dartpad.dartlang.org/experimental/embed-new.html?id=610aa31bbd09c90b5cede790bb6c3854&fw=true" width="100%" height="400px"></iframe>

### Baseline alignment

Sometimes it's handy to align widgets containing text not by their
overall bounds, but by the baselines used by their characters.
That's what `CrossAxisAlignment.baseline` is for. You
can use it in combination with a `Row`'s `textBaseline`
property (which indicates which baseline to use) to align a
`Row`'s children along their baselines.

Note that if you set a `Row`'s `crossAxisAlignment` property
to baseline without setting `textBaseline` at the same
time, your widgets will fail to build.

#### Code example

This row contains three `Text` widgets with different font
sizes. Try changing the `crossAxisAlignment`
property to `baseline`, and experiment with different
values for `textBaseline` as well (there's an enum called
`TextBaseline` that contains the valid baseline values).

<iframe src="https://dartpad.dartlang.org/experimental/embed-new.html?id=8c4a0571b161755c8d9235df947d268e&fw=true" width="100%" height="400px"></iframe>

### Flexible children

So far, all the widgets used as children in examples have
had a fixed size. It's possible, though, for a
`Row` to have children that flex,
and adapt to the available space. In order to
understand how this works,
it's best to take a look at how `Row`s size themselves and
their children:

1. First, the `Row` asks all of its children with fixed
   sizes how big they'd like to be.
1. Next, it calculates the remaining space in its main
   axis (horizontal).
1. Then it divides up that remaining space among its
   flexible children according to their flex factors.
   The flexible children can use some or all of the space
   they're offered.
1. At that point, the `Row knows how big all of its
   children are, and can align them using the same axis
   size and alignment properties you've seen so far.

Most widgets are considered to be of a fixed size.
You can change that by wrapping them in a `Flexible`
widget. `Flexibles` have two important properties:
a `flex` factor that determines how much of the remaining
space they get in comparison to other `Flexibles`,
and a `fit` property that determines whether their child
is forced to take up all the extra space it's offered.

#### Code example

Try wrapping the middle box in this row with a `Flexible`
widget that has a `flex` factor of 1 and its `fit`
property set to `FlexFit.loose`. Afterward,
try changing the fit to tight and see what happens.

This combination (a `flex` factor of 1 and a tight `fit`)
is so popular, there's a whole widget just to make
using them easier: `Expanded`.

<iframe src="https://dartpad.dartlang.org/experimental/embed-new.html?id=c7ba00c50151ab2e5c0c2194686fef93&fw=true" width="100%" height="400px"></iframe>

### Flex factors

If more than one child of a `Row` or `Column` has a
flexible size, the available space is allotted to them according to their
`flex` factors. Each child gets space in proportion to their flex
factor divided by the total of all the flex factors of all children:

<!-- skip -->
```dart
remainingSpace * (flex / totalOfAllFlexValues)
```

For example, if there are two children with flex factors of 1,
each gets half of the available space. If there
are two children with flex factors of 1 and another child
with a flex factor of 2, the first two
children each get a quarter of the available space,
and the other child gets half.

#### Code example

In this example, all three of the `Row`'s children are `Flexible`.
Try changing their `flex` values and
re-running the code to see how the widgets' sizes adjust.

<iframe src="https://dartpad.dartlang.org/experimental/embed-new.html?id=4ab5409b566272c8f2cd28feddb0a995&fw=true" width="100%" height="400px"></iframe>

### What happens if you run out of space?

As you just saw, when a `Row` asks one of its `Flexible`
children how big it wants to be, it gives the child
a max width based on its `flex` factor. However,
fixed-size children get no such restriction. This is so
they can determine their own intrinsic size.

One side effect is that there's nothing stopping a fixed-size
child from declaring itself to be bigger than the `Row` can support.
When that happens, a flex overflow results. You can
fix it by changing the child widget so that it chooses a smaller size,
or by using a scrolling widget.

#### Code example

The `Row` below contains a single widget that's way too wide to fit. Run the
code as-is to see what happens, then try modifying the width of the
`Container` to make it fit.

<iframe src="https://dartpad.dartlang.org/experimental/embed-new.html?id=5a59d93119dc5b6eb1725235fde137cf&fw=true" width="100%" height="400px"></iframe>

### Try using SizedBox to make space

If you need a specific amount of space between two children of a
`Row`, an easy way to do it is by sticking a `SizedBox` of the
appropriate width in between.

#### Code example

Trying making some space between these two list items by placing a
`SizedBox` with a `width` of 100 between them.

<iframe src="https://dartpad.dartlang.org/experimental/embed-new.html?id=0c3e1ce8177a2f0cc8e2275d5260b348&fw=true" width="100%" height="400px"></iframe>

### Spacers expand to make space

`Spacers` are another convenient way to make space between
items in a `Row`.  They're flexible, and expand to fill any
leftover space.

#### Code example

Try adding a `Spacer` in between the first and second children of the
`Row` below.

<iframe src="https://dartpad.dartlang.org/experimental/embed-new.html?id=dd68c1eb491e7a22a2ceb4127d78e504&fw=true" width="100%" height="400px"></iframe>

### Wait, wasn't I going to learn about Columns, too?

Surprise, you already have! `Row`s and `Column`s do the
same job, just in different dimensions. The main
axis of a `Row` is horizontal, and the main axis of a
`Column` is vertical, but they both size and position their
children in the same way. They even share a base class,
`Flex`, so everything you've learned about `Row`s
applies to `Column`s as well!

#### Code example

Here's a `Column` with some children of various sizes and its most important
properties set. Try fiddling around with them and you'll see that the
`Column` works like a vertical `Row.

<iframe src="https://dartpad.dartlang.org/experimental/embed-new.html?id=6cafe7beab954e72fed2fd2393a29f6c&fw=true" width="100%" height="400px"></iframe>

### Putting it all together

Now that you're versed in `Row`s, `Column`s, and the
important properties of both, you're ready to practice
putting them together to build interfaces. The next few
examples guide you through the construction
of a business card display.

#### Code example

Every business card needs a name and a title, so start with that.

* Add a `Column` widget
* Add two text widgets to the `Column`'s list of children:
  * The first should be a name (a short one is easier to
    fit into the small window) and use the `headline` style:

<!-- skip -->
```dart
style: Theme.of(context).textTheme.headline<br>
```

  * The second text widget should say 'Experienced App Developer`
    and use the default style (leave the `style` property out entirely).

* Set the `Column`'s `crossAxisAlignment` to start, so
  that the text widgets are start-aligned rather than centered.

* Set the `Column`'s `mainAxisSize` to `MainAxisSize.min`,
  so the card won't expand to the full height of the window.

<iframe src="https://dartpad.dartlang.org/experimental/embed-new.html?id=5e7e9352bca878f446d4347f324e2f63&fw=true&split=60" width="100%" height="800px"></iframe>

Business cards often have an icon or logo in the top-left corner,
so the next step is to add one to yours. Start by wrapping the
`Column` you just created with a `Row` widget:

<!-- skip -->
```dart
Row(
  children: [
    Column( … ), // <- This should be the Column you made in the previous step
  ],
);
```

Now you can add the `Icon`:

* Above your `Column` in the `Row`'s list of children,
  add a `Padding` widget.
  * Set its `padding` to `const EdgeInsets.all(8)`.
  * For the child of the `Padding` widget, use an `Icon`.
    * You can use any icon resource you want, though `Icons.account_circle`
      works nicely.
    * Set the `Icon`'s `size`.

<iframe src="https://dartpad.dartlang.org/experimental/embed-new.html?id=684e599476eef2ec4b4508e6b2186c03&fw=true&split=60" width="100%" height="800px"></iframe>

Your first `Row` is now complete! There are two more to go, though,
and you need a `Column` to put them in.
Wrap your `Row` with a `Column` widget so that it looks like this:

<!-- skip -->
```dart
 Column(
   children: [
     Row( … ), // <- This should be the Row with your Icon and Text widgets.
   ],
 );
```

Then, finish up your new `Column` with these steps:

* Set the `Column`'s mainAxisSize to min
  * Otherwise it'll expand to fill the screen!

* Set the `Column`'s `crossAxisAlignment` to stretch
  * This makes all of its children full-width

* Add more widgets below your `Row` in the `Column`'s
  list of children:
  * A `SizedBox` with a height of 8
    * An empty `Row` (no children or other properties)
    * A `SizedBox` with a height of 16
    * Another empty `Row`

<iframe src="https://dartpad.dartlang.org/experimental/embed-new.html?id=19ead6db4f42ce112fc0a7d2e0922466&fw=true&split=60" width="100%" height="800px"></iframe>

There are just a few steps to go now. Next up is the second row.
Add the following to its list of children:

* A `Text` widget with a street address like '123 Main Street'
* A `Text` widget with a phone number like '800-123-1234'

If you run the code at this point, you'll see that the two `Text`
widgets are placed right up against each other rather than at
opposite ends of the `Row`, which isn't right.
You can fix this by setting the `Row`'s `mainAxisAlignment`
property to `spaceBetween`, which puts any extra space between
the two `Text` widgets.

<iframe src="https://dartpad.dartlang.org/experimental/embed-new.html?id=e6e07bbe96255b762163cf3e40906944&fw=true&split=60" width="100%" height="800px"></iframe>

The last step is to get those icons in place at the bottom of the card:

* Add four `Icon` widgets to the last `Row`'s list of
  children. You can use whichever icon resources you
  like, but these would be a good way to show that your
  imaginary developer focuses on accessibility,
  fast development, and multi-platform apps:
  * `Icons.accessibility`
  * `Icons.timer`
  * `Icons.phone_android`
  * `Icons.phone_iphone`

* Set the `Row`'s `mainAxisAlignment` property to
  `MainAxisAlignment.spaceAround`

<iframe src="https://dartpad.dartlang.org/experimental/embed-new.html?id=2234a5ccada200eb1e018b12fa95d57d&fw=true&split=60" width="100%" height="800px"></iframe>
