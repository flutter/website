---
layout: page
title: A Tour of the Flutter Widget Framework
permalink: /widgets-intro/
---

* TOC Placeholder
{:toc}

## 简介
Flutter widgets 启发于 
[React](http://facebook.github.io/react/)，使用流行的响应式框架构建。你可以使用 widgets 去组装出你想要的 UI。用组件来构建整个页面以及显示当前的信息状态。当某 widget 的 state 发生变化时，该 widget 会重新构建加载，Flutter 会比较当前 state 与前面的 state，确保以最小的更改来达到当前所需要的 state。

<aside id="note" class="alert alert-info" markdown="1">
**注意：** 如果你想更深入的了解 Flutter 并想查看某些代码, 请移步
[Building Layouts in Flutter](/tutorials/layout/) 和
[Adding Interactivity to Your Flutter App](/tutorials/interactive/).
</aside>

Hello World
-----------
再小的 Flutter 应用程序也需要调用 
[`runApp`](https://docs.flutter.io/flutter/widgets/runApp.html) 函数：

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    new Center(
      child: new Text(
        'Hello, world!',
        textDirection: TextDirection.ltr,
      ),
    ),
  );
}
```

[`runApp`](https://docs.flutter.io/flutter/widgets/runApp.html) 函数是 
[`Widget`](https://docs.flutter.io/flutter/widgets/Widget-class.html) 的入口函数。在这个小例子中，有两个 widget，及 
[`Center`](https://docs.flutter.io/flutter/widgets/Center-class.html) widget 和其子组件 
[`Text`](https://docs.flutter.io/flutter/widgets/Text-class.html) widget。框架强制使 root widget 覆盖全屏，这就意味着 “Hello,word” 呈现在屏幕中央，此时可以设置字符串的布局。接下来我们将会为你演示，使用 MaterialApp widget。

在编写应用程序时，当创建新的 widgets，通常是 
[`StatelessWidget`](https://docs.flutter.io/flutter/widgets/StatelessWidget-class.html)
或
[`StatefulWidget`](https://docs.flutter.io/flutter/widgets/StatefulWidget-class.html) 的子类，具体要继承那一个，取决于你是否要管理此 widget 所有 state。
[`build`](https://docs.flutter.io/flutter/widgets/StatelessWidget/build.html)
函数是 widgets 主要入口函数 
，可以在此函数里创建其他的 lower-level widgets。框架将会依次构建这些 widgets，直到最底层的 
[`RenderObject`](https://docs.flutter.io/flutter/rendering/RenderObject-class.html) 之下，然后计算机进行计算相关的图形并渲染出。

Basic widgets
-------------

_主要相关文章：[Widgets Overview - Layout Models](https://flutter.io/widgets/layout)_

Flutter 自带有一套强大的 Basic widgets，其中以下是经常用的：

 * [`Text`](https://docs.flutter.io/flutter/widgets/Text-class.html)：
   [`Text`](https://docs.flutter.io/flutter/widgets/Text-class.html) widget
   可以在你的应用中创建一个可自定义风格的文本框。

 * [`Row`](https://docs.flutter.io/flutter/widgets/Row-class.html),
   [`Column`](https://docs.flutter.io/flutter/widgets/Column-class.html)：
   这两个 widgets 使你无论是在水平([`Row`](https://docs.flutter.io/flutter/widgets/Row-class.html)) 还是在垂直位置
   ([`Column`](https://docs.flutter.io/flutter/widgets/Column-class.html))
   都可以创建出灵活的布局，它是基于 flexbox layout model 来设计的。
  
 * [`Stack`](https://docs.flutter.io/flutter/widgets/Stack-class.html)：你可以使用 
   [`Stack`](https://docs.flutter.io/flutter/widgets/Stack-class.html) widget 来绘制需要重叠的 widget、元素，而不是安照线性方向（垂直或者水平）来布局 widget、元素。你可以在
   [`Stack`](https://docs.flutter.io/flutter/widgets/Stack-class.html) 上使用 
   [`Positioned`](https://docs.flutter.io/flutter/widgets/Positioned-class.html)
定位相对设置其子元素上下左右的参数。Stacks 基于网页 positioning layout model。

 * [`Container`](https://docs.flutter.io/flutter/widgets/Container-class.html)：
   [`Container`](https://docs.flutter.io/flutter/widgets/Container-class.html) 
   可以创建出简单的矩形元素视图。也可当做 
   [`BoxDecoration`](https://docs.flutter.io/flutter/painting/BoxDecoration-class.html) 自定义风格的容器，例如：背景，边框，阴影。
   [`Container`](https://docs.flutter.io/flutter/widgets/Container-class.html) 可以设置 margin、padding 甚至设置任意大小尺寸。 另外 
   [`Container`](https://docs.flutter.io/flutter/widgets/Container-class.html) 可以利用矩阵在三维空间中编辑。
   
以下是一些简单的 widgets，它们结合了以上和其他 widgets：

```dart
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  MyAppBar({this.title});

  // Fields in a Widget subclass are always marked "final".

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 56.0, // in logical pixels
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: new BoxDecoration(color: Colors.blue[500]),
      // Row is a horizontal, linear layout.
      child: new Row(
        // <Widget> is the type of items in the list.
        children: <Widget>[
          new IconButton(
            icon: new Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed: null, // null disables the button
          ),
          // Expanded expands its child to fill the available space.
          new Expanded(
            child: title,
          ),
          new IconButton(
            icon: new Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
    );
  }
}

class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece of paper on which the UI appears.
    return new Material(
      // Column is a vertical, linear layout.
      child: new Column(
        children: <Widget>[
          new MyAppBar(
            title: new Text(
              'Example title',
              style: Theme.of(context).primaryTextTheme.title,
            ),
          ),
          new Expanded(
            child: new Center(
              child: new Text('Hello, world!'),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(new MaterialApp(
    title: 'My app', // used by the OS task switcher
    home: new MyScaffold(),
  ));
}
```
请检查 `flutter` 文件下 `pubspec.yaml` 文件中 `uses-material-design: true`，以允许使用默认 [Material icons](https://design.google.com/icons/)

```yaml
name: my_app
flutter:
  uses-material-design: true
```

许多 widgets 在 
[`MaterialApp`](https://docs.flutter.io/flutter/material/MaterialApp-class.html) 中呈现，是为了继承它的主题相关参数以统一设计风格。所以我们使用 
[`MaterialApp`](https://docs.flutter.io/flutter/material/MaterialApp-class.html)。

`MyAppBar` widget 里创建了一个 
[`Container`](https://docs.flutter.io/flutter/widgets/Container-class.html) 对象，并设置参数高为56px，离屏幕左右填充8px，在 container 中，`MyAppBar` 使用 
[`Row`](https://docs.flutter.io/flutter/widgets/Row-class.html) 布局其子级界面。在中间，使用 
[`Expanded`](https://docs.flutter.io/flutter/widgets/Expanded-class.html) 创建 `title` widget，因为它可以自动填充其他子 widget 未使用的剩余空间。当然可以使用多个 
[`Expanded`](https://docs.flutter.io/flutter/widgets/Expanded-class.html) 对象，并且可以使用 
[`flex`](https://docs.flutter.io/flutter/widgets/Expanded-class.html#flex) 参数来设置可用空间的比例。
 
`MyScaffold` widget 布局其子 widgets 使其垂直排列。在顶部，初始化了一个 `MyAppBar`，其标题是 
[`Text`](https://docs.flutter.io/flutter/widgets/Text-class.html) widget。通常我们可以在一个 widget 中，去引用其他的 widget 并作为参数，这样会提高组件的复用性。最后使用 
[`Expanded`](https://docs.flutter.io/flutter/widgets/Expanded-class.html) 的 `MyScaffold` widget 将剩下的空间全部填充。

使用 Material Components
---------------------

_主要相关文章：[Widgets Overview - Material Components](https://flutter.io/widgets/material)_

Flutter 提供了许多 widgets，并可帮助你构建遵循 Material Design 的应用程序。一个 Material 应用程序往往开始于 
[`MaterialApp`](https://docs.flutter.io/flutter/material/MaterialApp-class.html)
widget，其中包括一些其他有用的 widgets。比如 
[`Navigator`](https://docs.flutter.io/flutter/widgets/Navigator-class.html)，他管理一些以字符串为标识的 widgets，也可以称为"路由"，它可以帮你管理应用程序界面，使之不同的界面直接跳转平稳可控。当然你也可以不使用 
[`MaterialApp`](https://docs.flutter.io/flutter/material/MaterialApp-class.html)，不过其依然是一个不错的选择。

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: 'Flutter Tutorial',
    home: new TutorialHome(),
  ));
}

class TutorialHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: new Text('Example title'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
      // body is the majority of the screen.
      body: new Center(
        child: new Text('Hello, world!'),
      ),
      floatingActionButton: new FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        child: new Icon(Icons.add),
        onPressed: null,
      ),
    );
  }
}
```

现在，我们已经把原来的 `MyAppBar` 和 `MyScaffold` 分别替换为 
[`AppBar`](https://docs.flutter.io/flutter/material/AppBar-class.html) 和 
[`Scaffold`](https://docs.flutter.io/flutter/material/Scaffold-class.html)，它们都来自 `material.dart`，此时我们的应用程序使用了更多的 Material 元素。例如，应用栏的阴影，标题文本的样式都自动继承于 
[`MaterialApp`](https://docs.flutter.io/flutter/material/MaterialApp-class.html) 里的相关参数。我们额外也添加了一个浮动的按钮，以便你进行参考。

注意，这里我们再次将其他 widgets 作为其他 widgets 的参数。
[`Scaffold`](https://docs.flutter.io/flutter/material/Scaffold-class.html) widget 里有许多参数都是 widgets，并且这些都通过 `Scaffold` 进行排版显示。同样，
[`AppBar`](https://docs.flutter.io/flutter/material/AppBar-class.html)
widget 里面 
[`leading`](https://docs.flutter.io/flutter/material/AppBar-class.html#leading)
、
[`actions`](https://docs.flutter.io/flutter/material/AppBar-class.html#actions)
和
[`title`](https://docs.flutter.io/flutter/material/AppBar-class.html#title) 参数都是 widgets。整个框架大量的使用此设计模式，所以当你去设计自己的 widgets 时可以参考下。

手势的处理
-----------------

_主要相关文章：[Gestures in Flutter](https://flutter.io/gestures/)_

通常应用程序会和用户做一些手势交互。所以，程序首先就要去检测用户的各种手势输入。接下来，让我们通过创建一个简单的按钮来了解它的工作原理：

```dart
class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        print('MyButton was tapped!');
      },
      child: new Container(
        height: 36.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(5.0),
          color: Colors.lightGreen[500],
        ),
        child: new Center(
          child: new Text('Engage'),
        ),
      ),
    );
  }
}
```

[`GestureDetector`](https://docs.flutter.io/flutter/widgets/GestureDetector-class.html) 只是用来检测用户手势动作，没有显示效果，所以你看不到任何界面在程序中。当用户点击 
[`Container`](https://docs.flutter.io/flutter/widgets/Container-class.html)，
[`GestureDetector`](https://docs.flutter.io/flutter/widgets/GestureDetector-class.html) 会调用它的 
[`onTap`](https://docs.flutter.io/flutter/widgets/GestureDetector-class.html#onTap) 回调，此时，会执行相关代码，打印消息到控制台。你可以使用 
[`GestureDetector`](https://docs.flutter.io/flutter/widgets/GestureDetector-class.html) 来检测各种输入手势，包括点击，拖动和缩放。

许多 widgets 使用 
[`GestureDetector`](https://docs.flutter.io/flutter/widgets/GestureDetector-class.html) 为其提供手势回调，当然你也可以不去实现其回调。例如，
[`IconButton`](https://docs.flutter.io/flutter/material/IconButton-class.html),
[`RaisedButton`](https://docs.flutter.io/flutter/material/RaisedButton-class.html),
和 
[`FloatingActionButton`](https://docs.flutter.io/flutter/material/FloatingActionButton-class.html) 有 
[`onPressed`](https://docs.flutter.io/flutter/material/RaisedButton-class.html#onPressed) 回调方法，你可以不用去实现 
[`GestureDetector`](https://docs.flutter.io/flutter/widgets/GestureDetector-class.html) 里的回调方法。

更改 widgets 显示状态
-------------------------------------

_主要相关文章： [`StatefulWidget`](https://docs.flutter.io/flutter/widgets/StatefulWidget-class.html), [`State.setState`](https://docs.flutter.io/flutter/widgets/State/setState.html)_

到目前为止，我们只使用 stateless widgets。stateless widgets 从它们的父 widgets 接收参数，它们存储在 [`final`](https://www.dartlang.org/docs/dart-up-and-running/ch02.html#final-and-const) 变量中。当一个 widget 要求
[`构建`](https://docs.flutter.io/flutter/widgets/StatelessWidget/build.html)时，它使用这些已存储的值为被创建的 widget 派生新的参数。

我们来创建一个比较复杂的例子 - 例如，对用户的交互做出有意义的响应 - 应用程序通常会自带一些 state。Flutter 使用 StatefulWidgets 来捕获某个状态更改。StatefulWidgets 是个特殊的Widgets，它知道如何生成 State objects，然后用它来保持 state。考虑这个基本的例子，我们使用前面提到 
[`RaisedButton`](https://docs.flutter.io/flutter/material/RaisedButton-class.html)：

```dart
class Counter extends StatefulWidget {
  // This class is the configuration for the state. It holds the
  // values (in this nothing) provided by the parent and used by the build
  // method of the State. Fields in a Widget subclass are always marked "final".

  @override
  _CounterState createState() => new _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      // This call to setState tells the Flutter framework that
      // something has changed in this State, which causes it to rerun
      // the build method below so that the display can reflect the
      // updated values. If we changed _counter without calling
      // setState(), then the build method would not be called again,
      // and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance
    // as done by the _increment method above.
    // The Flutter framework has been optimized to make rerunning
    // build methods fast, so that you can just rebuild anything that
    // needs updating rather than having to individually change
    // instances of widgets.
    return new Row(
      children: <Widget>[
        new RaisedButton(
          onPressed: _increment,
          child: new Text('Increment'),
        ),
        new Text('Count: $_counter'),
      ],
    );
  }
}
```


你可能想知道为什么我们把 StatefulWidget 和 State 分离为单独的对象。在 Flutter 中，这两种类型的对象具有着不同的生命周期。Widgets 只是用于在界面显示当前信息的临时对象。State objects 用来保存一些状态信息，会一直存在与 
[`build()`](https://docs.flutter.io/flutter/widgets/State/build.html) 来回调用。

上面的例子，用户对界面进行交互并直接在 build method 中呈现结果。在更复杂的应用程序中，每个不同层级 widgets 都会个自负责响应不同的状态及作用；例如，一个 widget 收集特定的信息（如日期或位置）最终会呈现在复杂的用户界面上，当另一个 widget 改变这些信息时，前面的 widget 会更新其状态。

在 Flutter 中，widget 的更改变化是通过回调方式一层一层“向上”传递，而当前状态则“向下”传递到stateless widgets。重定向这共同父级。通过下面稍微复杂的例子，我们看看具体是如何工作的：


```dart
class CounterDisplay extends StatelessWidget {
  CounterDisplay({this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return new Text('Count: $count');
  }
}

class CounterIncrementor extends StatelessWidget {
  CounterIncrementor({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      onPressed: onPressed,
      child: new Text('Increment'),
    );
  }
}

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => new _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      ++_counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Row(children: <Widget>[
      new CounterIncrementor(onPressed: _increment),
      new CounterDisplay(count: _counter),
    ]);
  }
}
```
请注意看下，我们是如何创建了两个 stateless widgets，使 _计数显示_ （CounterDisplay）与 _计数更改_ (CounterIncrementor) 解耦。尽管功能与前面的例子一样，但是我们把一些复杂逻辑抽取出来，并进行一层封装，这样我们就能保持父级可扩展性，以及代码的整洁。

综合实例
------------------------

让我们实践一个更完整的例子，将上面介绍的概念汇集在一起​​。我们假设在开发购物应用程序，该应用程序显示待售的各种产品，并要维护购物车。让我们来开始吧， `ShoppingListItem`：


```dart
class Product {
  const Product({this.name});
  final String name;
}

typedef void CartChangedCallback(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({Product product, this.inCart, this.onCartChanged})
      : product = product,
        super(key: new ObjectKey(product));

  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different parts of the tree
    // can have different themes.  The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return new TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      onTap: () {
        onCartChanged(product, !inCart);
      },
      leading: new CircleAvatar(
        backgroundColor: _getColor(context),
        child: new Text(product.name[0]),
      ),
      title: new Text(product.name, style: _getTextStyle(context)),
    );
  }
}
```

ShoppingListItem widget 遵循 stateless
widgets 的常见模式。它将在构造函​​数中接收到的值存储在 
[`final`](https://www.dartlang.org/docs/dart-up-and-running/ch02.html#final-and-const) 成员变量中，然后在 
[`build`](https://docs.flutter.io/flutter/widgets/StatelessWidget/build.html) 函数中使用它 。例如，`inCart` 布尔值作用两个主题之间切换：一个使用当前主题的主色，另一个使用灰色。

当用户点击列表选项时，widget 不会直接修改 `inCart` 的值。相反，widget 会调用父级 `onCartChanged` 函数。此方式可让你在层次结构更高的 widget 中存储状态，从而使状态持续更长的时间。在极端情况下，存储在窗口 widget 上的状态将在 
[`runApp`](https://docs.flutter.io/flutter/widgets/runApp.html) 的整个生命周期中持续存在。

当父级收到 `onCartChanged` 回调时，父级将更新其内部状态，这将触发父级重构并使用新的 `inCart` 值创建一个新的 `ShoppingListItem` 实例。尽管父级重构并创建了新的 `ShoppingListItem` 实例，不过此操作是很高效的，因为该框架会将新构建的 widget 与先前构建的 widget 进行比较，并在 
[`RenderObject`](https://docs.flutter.io/flutter/rendering/RenderObject-class.html) 之下仅渲染不同的地方。

我们来看看在父 widget 存储可变状态的例子：

<!--
class Product {
  const Product({this.name});
  final String name;
}

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({Product product, bool inCart, Function onCartChanged});
  @override
  Widget build(BuildContext context) => null;
}
-->
```dart
class ShoppingList extends StatefulWidget {
  ShoppingList({Key key, this.products}) : super(key: key);

  final List<Product> products;

  // The framework calls createState the first time a widget appears at a given
  // location in the tree. If the parent rebuilds and uses the same type of
  // widget (with the same key), the framework will re-use the State object
  // instead of creating a new State object.

  @override
  _ShoppingListState createState() => new _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  Set<Product> _shoppingCart = new Set<Product>();

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      // When user changes what is in the cart, we need to change _shoppingCart
      // inside a setState call to trigger a rebuild. The framework then calls
      // build, below, which updates the visual appearance of the app.

      if (inCart)
        _shoppingCart.add(product);
      else
        _shoppingCart.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Shopping List'),
      ),
      body: new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: widget.products.map((Product product) {
          return new ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}

void main() {
  runApp(new MaterialApp(
    title: 'Shopping App',
    home: new ShoppingList(
      products: <Product>[
        new Product(name: 'Eggs'),
        new Product(name: 'Flour'),
        new Product(name: 'Chocolate chips'),
      ],
    ),
  ));
}
```

`ShoppingList` 类扩展于 
[`StatefulWidget`](https://docs.flutter.io/flutter/widgets/StatefulWidget-class.html)，使之可以存储一些可变的状态。当 `ShoppingList` 首次创建时，框架会调用 
[`createState`](https://docs.flutter.io/flutter/widgets/StatefulWidget-class.html#createState) 函数创建一个新的实例 `_ShoppingListState` 来关联此时的位置（请注意，我们通常命名 
[`State`](https://docs.flutter.io/flutter/widgets/State-class.html)的子类为带有下划线的，来表示它们是私有的。）当此 widget 的父级被重构时，父级将会创建一个新的 `ShoppingList` 实例，框架会重新关联使用 `_ShoppingListState` 尽管之前已经调用了 
[`createState`](https://docs.flutter.io/flutter/widgets/StatefulWidget-class.html#createState)，但是此时还会再次调用。

可以通过 `_ShoppingListState` 使用 `ShoppingList` 
[`widget`](https://docs.flutter.io/flutter/widgets/State-class.html#widget) 的属性来获取它的属性。如果父级重建并创建新的 `ShoppingList`，那么 `_ShoppingListState` 也将用新的 widget 的属性重建。如果希望 
[`widget`](https://docs.flutter.io/flutter/widgets/State-class.html#widget) 属性更改时收到通知，则可以复写 
[`didUpdateWidget`](https://docs.flutter.io/flutter/widgets/State-class.html#didUpdateWidget) 函数。以便 `oldWidget` 将之前的 
[`widget`](https://docs.flutter.io/flutter/widgets/State-class.html#widget) 与现在的进行比较。

当 `onCartChanged` 回调被调用时， `_ShoppingListState` 在 `_shoppingCart` 里进行添加删除产品，从而改变了状态。调用 
[`setState`](https://docs.flutter.io/flutter/widgets/State-class.html#setState) 方法会通知框架改变器状态。当调用 
[`setState`](https://docs.flutter.io/flutter/widgets/State-class.html#setState) 方法时会标记修改的 widget 并计划在下次应用程序需要更新用户界面时重新构建它。如果你修改 widget 状态时忘记调用
[`setState`] (https://docs.flutter.io/flutter/widgets/State-class.html#setState) 方法，框架就不知道此 widget 是被修改过的，并不会调用此 widget 的 
[`build`](https://docs.flutter.io/flutter/widgets/StatelessWidget/build.html) 函数，最终会导致不会更新此状态，界面也不会发生什么变化。

通过以上这种方式管理状态，你不需要编写用于创建和更新子部件的单独代码。相反，你只需实现可以处理这两种情况的 build 函数。

widget 的生命周期
-------------------------------------

_主要文章：[`State`](https://docs.flutter.io/flutter/widgets/State-class.html)_

在 StatefulWidget 调用 
[`createState`](https://docs.flutter.io/flutter/widgets/StatefulWidget-class.html#createState) 后，框架会插入新的 state object 在节点树中，然后在调用
[`initState`](https://docs.flutter.io/flutter/widgets/State-class.html#initState) 在此对象上。子类 
[`State`](https://docs.flutter.io/flutter/widgets/State-class.html) 
可以复写 
[`initState`](https://docs.flutter.io/flutter/widgets/State-class.html#initState) 并且只会调用一次。例如，你可以复写 
[`initState`](https://docs.flutter.io/flutter/widgets/State-class.html#initState) 以配置动画或订阅平台服务。
[`initState`](https://docs.flutter.io/flutter/widgets/State-class.html#initState) 实现之前，需要先调用 
[`super.initState`](https://docs.flutter.io/flutter/widgets/State-class.html#initState)。

当一个 state object 不再需要时，框架调用 state object 的 
[`dispose`](https://docs.flutter.io/flutter/widgets/State-class.html#dispose) 函数时，你可以复写该 
[`dispose`](https://docs.flutter.io/flutter/widgets/State-class.html#dispose) 函数来执行清理工作。例如，你可以复写 
[`dispose`](https://docs.flutter.io/flutter/widgets/State-class.html#dispose) 来取消定时器或取消平台订阅服务。当然调用 
[`dispose`](https://docs.flutter.io/flutter/widgets/State-class.html#dispose) 之前，要先调用
[`super.dispose`](https://docs.flutter.io/flutter/widgets/State-class.html#dispose)。

Keys
----
_主要相关文章：[`Key`](https://docs.flutter.io/flutter/foundation/Key-class.html)_

你可以使用 keys 来找到 widgets 并控制它，框架将会通过 keys 来匹配已经构建好的相应 widgets。默认情况下，框架会根据 
[`runtimeType`](https://docs.flutter.io/flutter/widgets/Widget-class.html#runtimeType) 以及显示顺序来匹配当前构建和以前构建中的 widgets。通过 keys，框架需要两个 widgets 有相同的 
[`key`](https://docs.flutter.io/flutter/widgets/Widget-class.html#key) 以及 
[`runtimeType`](https://docs.flutter.io/flutter/widgets/Widget-class.html#runtimeType)。

当有构建许多相同类型的 widgets 时，keys 属性是还是非常有用的。例如，`ShoppingList` widget 构建可以填充其可见区域的 `ShoppingListItem` 实例:

* 如果没有 keys，当前构建中的第一个 item 将始终与前一个构建中的第一个 item 同步，即使在逻辑上，列表中的第一个 item 已经滚动出了屏幕。

* 通过列表中的每个 item 的 "semantic" keys，以使整个列表效果正常，因为框架将通过 keys 同步 item 并因此具有相似（或相同）的显示效果。此外，使用语义来同步列表中的子项意味着 Stateful widget 中的 State 将和具有相同语义的 Stateful Widget 进行匹配而不是跟列表中相同位置的 Stateful Widget 进行匹配。

全局 Keys
-----------

_主要相关文章：[`GlobalKey`](https://docs.flutter.io/flutter/widgets/GlobalKey-class.html)_

你可以使用全局 keys 标识唯一子窗口 widgets。全局 keys 在整个界面 widgets 层次结构中必须是唯一的，这与局部 keys 不同，后者只需要在同级中有唯一性。由于它们是全局唯一的，因此可以使用全局 keys 来检索与界面 widgets 关联的状态。

