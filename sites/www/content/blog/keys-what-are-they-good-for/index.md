---
title: "Keys! What are they good for?"
description: "The key parameter can be found on basically every widget constructor, but their use is less common. Keys preserve state when widgets move…"
publishDate: 2019-03-29
author: efortuna
image: images/1sHDIVXBu9RpJYN9Zdn8iBw.gif
category: tutorial
layout: blog
---

The key parameter can be found on basically every widget constructor, but their use is less common. Keys preserve state when widgets move around in your widget tree. In practice, this means they can be useful to preserve the user’s scroll location or keep state when modifying a collection.

The following article is adapted from the following video:

<YoutubeEmbed id="kn0EOS-ZiIc" title="When to Use Keys - Flutter Widgets 101 Ep. 4" fullwidth="true"/>

If you prefer to listen/watch rather than read, that video should cover all of the same content.

## The Inside Scoop on Keys

Most of the time… you don’t need keys! Generally, there’s no harm adding them, but it’s also unnecessary and just takes up unnecessary space, just like the new keyword, or declaring types on both the right side and left side of a new variable (I’m looking at you, `Map<Foo, Bar> aMap = Map<Foo, Bar>()`). But, if you find yourself adding, removing, or reordering a collection of widgets of the same type that *hold some state*, using keys is likely in your future!
> # If you find yourself adding, removing, or reordering a collection of widgets of the same type that *hold some state*, using keys is likely in your future.

To illustrate why you need keys when modifying a collection of widgets, I wrote an extremely simple app with two randomly colored widgets that swap places when you tap a button:

<DashImage figure src="images/1edgczyvaQRgGRy8yhht0QQ.gif" />

In the stateless version of the app, I have two stateless Tiles, each with a randomly generated color, in a `Row` and a `StatefulWidget` called `PositionedTiles` to store the position of these tiles. When I tap the `FloatingActionButton` down at the bottom it properly swaps their position in the list:

```dart
void main() => runApp(new MaterialApp(home: PositionedTiles()));

class PositionedTiles extends StatefulWidget {
 @override
 State<StatefulWidget> createState() => PositionedTilesState();
}

class PositionedTilesState extends State<PositionedTiles> {
 List<Widget> tiles = [
   StatelessColorfulTile(),
   StatelessColorfulTile(),
 ];

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     body: Row(children: tiles),
     floatingActionButton: FloatingActionButton(
         child: Icon(Icons.sentiment_very_satisfied), onPressed: swapTiles),
   );
 }

 swapTiles() {
   setState(() {
     tiles.insert(1, tiles.removeAt(0));
   });
 }
}

class StatelessColorfulTile extends StatelessWidget {
 Color myColor = UniqueColorGenerator.getColor();
 @override
 Widget build(BuildContext context) {
   return Container(
       color: myColor, child: Padding(padding: EdgeInsets.all(70.0)));
 }
}
```

But if we make those `ColorfulTiles` *stateful* instead of stateless and store the color in the state, when I press the button it looks like nothing is happening.

<DashImage figure src="images/1T7TBQx9DhaQ16gbX68XxVw.gif" />

```dart
List<Widget> tiles = [
   StatefulColorfulTile(),
   StatefulColorfulTile(),
];

...
class StatefulColorfulTile extends StatefulWidget {
 @override
 ColorfulTileState createState() => ColorfulTileState();
}

class ColorfulTileState extends State<ColorfulTile> {
 Color myColor;

 @override
 void initState() {
   super.initState();
   myColor = UniqueColorGenerator.getColor();
 }

 @override
 Widget build(BuildContext context) {
   return Container(
       color: myColor,
       child: Padding(
         padding: EdgeInsets.all(70.0),
       ));
 }
}

```

Just a reminder, the code shown above is *buggy*, in that it does not show the colors swapping when the user presses the “swap” button. The fix for this is to add a key parameter to the stateful widgets, and then the widgets swap places like we want:

<DashImage figure src="images/13XbdhaQ9_lPfILdViiipeQ.gif" />

```dart
List<Widget> tiles = [
  StatefulColorfulTile(key: UniqueKey()), // Keys added here
  StatefulColorfulTile(key: UniqueKey()),
];

// ...
class StatefulColorfulTile extends StatefulWidget {
  StatefulColorfulTile({Key key}) : super(key: key);  // NEW CONSTRUCTOR

  @override
  ColorfulTileState createState() => ColorfulTileState();
}

class ColorfulTileState extends State<ColorfulTile> {
  Color myColor;

  @override
  void initState() {
    super.initState();
    myColor = UniqueColorGenerator.getColor();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: myColor,
      child: Padding(
        padding: EdgeInsets.all(70.0),
      ),
    );
  }
}
```

But, this is only necessary if you have *stateful* widgets in the subtree that you are modifying. If the entire widget subtree in your collection is *stateless*, keys *aren’t* needed.

That’s it! That’s technically all you need to know to use keys in Flutter. But if you’d like to understand the underlying why of it all….

## The Nitty Gritty of Why Keys are Sometimes Needed

You’re still here, eh? Well, then gather near, to learn the true nature of Widget and Element trees to become a Flutter Sorcerer! Mwahahaha! Ha ha! Ha HA! Ahem, excuse me.

As you may know, under the covers, for every widget, Flutter builds a corresponding `Element`. Just like constructing a Widget tree, Flutter also builds an `Element` tree. The `ElementTree` is extremely simple, only holding information about the *type* of each widget and a reference to children elements. You can think of the `ElementTree` like a skeleton of your Flutter app. It shows the structure of your app, but all the additional information can be looked up via reference to the original widget.

The `Row` widget in the example above essentially holds a set of ordered slots for each of its children. When we swap the order of the Tile widgets in the `Row`, Flutter walks the `ElementTree` to see if the skeletal structure is the same.

<DashImage figure src="images/1sHDIVXBu9RpJYN9Zdn8iBw.gif" />

It starts with the `RowElement`, and then moves to its children. The `ElementTree` checks that the new widget is the same *type* and *key* as the old one, and if so, it updates its reference to the new widget. In the stateless version, the widgets don’t have keys, so Flutter just checks the type. (If this seems like a lot of information at once, watch the animated diagram above.)

The underlying `Element` tree structure for *stateful* widgets looks a little different. There are widgets and elements like before, but also there are a pair of state objects with them, and the color information is being stored there, not in the widgets themselves.

<DashImage figure src="images/1noTkKudlGuaAkiGaubEcNA.gif" />

In the stateful `Tile` case without keys, when I swap the order of the two widgets, Flutter walks the `ElementTree`, checks the type of the `RowWidget`, and updates the reference. Then `TileElement` checks that the corresponding widget is the same *type* (`TileWidget`) and it is, so it updates the reference. The same thing happens for the second child. Because Flutter uses the `ElementTree` and its corresponding *state* to determine what to actually display on your device, from our perspective, it looks like your widgets didn’t properly swap!

<DashImage figure src="images/17n-u4yexzRZDEtNvbrsG1g.gif" />

In the fixed version with the stateful `Tiles`, I added key properties to the widgets. Now if we swap the widgets The `Row` widgets match like before, but the key of the Tile Element doesn’t match the key of the corresponding Tile Widget. This causes Flutter to deactivate those elements and remove the references to the Tile Elements in the Element Tree, starting with the first one that doesn’t match.

<DashImage figure src="images/1AcBxC8IF_irZpFARt-Nqyw.gif" />

Then Flutter looks through to non-matched children of the `Row` for an element with the correct corresponding key. It finds a match, and updates its reference to the corresponding widget. Flutter then does the same thing for the second child. Now Flutter will display what we expect, with the widgets swapping places and updating their color when I press the button.

So in summary, keys are useful if you’re modifying the *order* or *number* of stateful widgets in a collection. For the sake of illustration, I stored the color as state in this example. Often though, state is much more subtle. Playing animations, displaying data that the user has entered, and scroll location all involve state.

## Where do I put ‘em?

Short answer: if you need to add keys to your app, you should add them at the ***top*** of the widget subtree with the state you need to preserve.

A common mistake I’ve seen is people thinking they only need to put a key on the first stateful widget, but *there be dragons.* Don’t believe me? To show what sort of trouble we can get into, I wrapped my colorfulTile widgets with padding widgets, but I left the keys on the tiles.

```dart
void main() => runApp(new MaterialApp(home: PositionedTiles()));

class PositionedTiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

class PositionedTilesState extends State<PositionedTiles> {
  // Stateful tiles now wrapped in padding (a stateless widget) to increase height
  // of widget tree and show why keys are needed at the Padding level.
  List<Widget> tiles = [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: StatefulColorfulTile(key: UniqueKey()),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: StatefulColorfulTile(key: UniqueKey()),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: tiles),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.sentiment_very_satisfied),
        onPressed: swapTiles,
      ),
    );
  }

  swapTiles() {
    setState(() {
      tiles.insert(1, tiles.removeAt(0));
    });
  }
}

class StatefulColorfulTile extends StatefulWidget {
  StatefulColorfulTile({Key key}) : super(key: key);

  @override
  ColorfulTileState createState() => ColorfulTileState();
}

class ColorfulTileState extends State<ColorfulTile> {
  Color myColor;

  @override
  void initState() {
    super.initState();
    myColor = UniqueColorGenerator.getColor();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: myColor,
      child: Padding(
        padding: EdgeInsets.all(70.0),
      ),
    );
  }
}
```

Now when I click the button the Tiles change to completely different random colors!

<DashImage figure src="images/1uC-SRZpRkOZCEr_rGisF9g.gif" />

Here’s what the WidgetTree and ElementTree look like with the padding widgets added:

<DashImage figure src="images/10NNY0KOBQGCWvdrWvorOQA.jpeg" />

When we swap the positions of the children, Flutter’s element-to-widget-matching algorithm looks at one level in the tree at a time. The diagram greys out the children’s children in the diagram so we can focus on one level at a time. At that first level of children with the Padding elements, everything matches up correctly.

<DashImage figure src="images/1vD86ZINBC-1Ctx9kudEGaw.gif" />

At the second level, Flutter notices that the key of the Tile Element doesn’t match the key of the widget, so it deactivates that Tile Element, dropping those connections. The keys we’re using in this example are `LocalKeys`. That means that when matching up widget to elements, Flutter only looks for key matches within a particular level in the tree.

Since it can’t find a tile element at that level with that key value, it creates a new one, and initializes a new state, in this case, making the widget orange!

<DashImage figure src="images/1JI1Ex87QRMTCJwBWmbNI5A.gif" />

If we add keys at the level of the padding widgets:

```dart
void main() => runApp(new MaterialApp(home: PositionedTiles()));

class PositionedTiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

class PositionedTilesState extends State<PositionedTiles> {
  List<Widget> tiles = [
    Padding(
      // Place the keys at the *top* of the tree of the items in the collection.
      key: UniqueKey(),
      padding: const EdgeInsets.all(8.0),
      child: StatefulColorfulTile(),
    ),
    Padding(
      key: UniqueKey(),
      padding: const EdgeInsets.all(8.0),
      child: StatefulColorfulTile(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: tiles),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.sentiment_very_satisfied),
        onPressed: swapTiles,
      ),
    );
  }

  swapTiles() {
    setState(() {
      tiles.insert(1, tiles.removeAt(0));
    });
  }
}

class StatefulColorfulTile extends StatefulWidget {
  StatefulColorfulTile({Key key}) : super(key: key);

  @override
  ColorfulTileState createState() => ColorfulTileState();
}

class ColorfulTileState extends State<ColorfulTile> {
  Color myColor;

  @override
  void initState() {
    super.initState();
    myColor = UniqueColorGenerator.getColor();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: myColor,
      child: Padding(
        padding: EdgeInsets.all(70.0),
      ),
    );
  }
}
```

Flutter notices the problem and updates the connections correctly, just like it did in our previous example. Order is restored in the universe.

<DashImage figure src="images/1FkCvw_LCfQ2x02wj7cmrpA.gif" />

## What kind of Key should I use?

The fine purveyors of Flutter APIs have given us a variety of Key classes to choose from. The type of key you should use depends on what the distinguishing characteristic is for the items needing keys. Take a look at the information that you’re storing in those widgets. Here I’ll talk about four different types of keys: **`ValueKey`**, **`ObjectKey`**, **`UniqueKey`**, and **`GlobalKey`**.

Consider the following To-do list app¹, where you can reorder the items in your TODO list based on priority and then remove them when you’re done.

<DashImage figure src="images/1wHJZnNPhMkePFEw1ihrbEA.gif" />

In this scenario, you might expect the text of a To-do item to be constant and unique. If that is the case, it is probably a good candidate for a **`ValueKey`**, where the text is the “value”.

```dart
return TodoItem(
  key: ValueKey(todo.task),
  todo: todo,
  onDismissed: (direction) => _removeTodo(context, todo),
);
```

In a different scenario, perhaps you had an address book app that listed information about each user. In this case each child widget stores a more complex combination of data. Any of the individual fields, like a first name or birthday might be the same as another entry, but the combination is unique. In this scenario, an **`ObjectKey`** is probably most appropriate.

<DashImage figure src="images/1vZV_QjG1GEg7nJILMbhEkA.webp" />

If you have multiple widgets in your collection with the same value or if you want to really ensure each widget is distinct from *all* others, you can use the **`UniqueKey`**. I used a `UniqueKey` in the example color-switching app because we didn’t have any other constant data that we’re storing in our tiles, and we don’t know what the color will be when we construct the widget. Be careful with `UniqueKey` though! If you construct a new `UniqueKey` inside a `build` method, the widget using that key will get a different, *unique* key every time you the build method re-executes. This will eliminate any benefits of using keys!

Similarly, one thing you definitely *don’t* want to use is a random number for your key. Every time a widget gets built, a new random number will be generated and you’ll lose consistency between frames. Then you might as well not have used keys in the first place!

**`PageStorageKey`**s are specialized keys that store a user’s scroll location so that the app can preserve it for later.

<DashImage figure src="images/1KgQeq1LDIPVuE2dwNzZbRQ.gif" />

**`GlobalKeys`** have two uses: they allow widgets to change parents anywhere in your app without losing state, or they can be used to access information about another widget in a completely different part of the widget tree. An example of the first scenario might if you wanted to show the same widget on two different screens, but holding all the same state, you’d want to use a `GlobalKey`. In the second scenario, maybe you want to validate a password, but don’t want to share that state information with other widgets in the tree. `GlobalKeys` can also be useful for testing, by using a key to access a particular widget and query information about its state.

<DashImage figure src="images/1JIPjn-gM6OIG_TfPJvtuVA.gif" />

Often (but not always!), `GlobalKeys` are a little like global variables. There is usually a better way to look up that state, using `InheritedWidgets`, or something like Redux or the BLoC pattern.

## Quick Recap

In summary, use Keys when you want to preserve state across widget trees. This most commonly occurs when you’re modifying a collection of widgets of the same type, like in a list. Put the key at the *top* of the widget tree you want preserved, and choose the key type you use based on the data you are storing in the widget.

Congratulations, you are now well on your way to becoming a Flutter Sorcerer! Oh, did I say sorcerer? I meant *sourcerer*, as in someone who writes app source code…which is almost just as good. …Almost. ⚡

[1] Code for the To-do app inspired by [https://github.com/brianegan/flutter_architecture_samples/tree/master/example/vanilla](https://github.com/brianegan/flutter_architecture_samples/tree/master/example/vanilla)
