import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  //debugPaintSizeEnabled = true;
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

// The images are saved with names pic1.jpg, pic2.jpg...pic28.jpg.
// The List.generate constructor allows an easy way to create
// a list when objects have a predictable naming pattern.
List<Container> _buildGridTileList(int count) {
  List<Container> containers;

  containers = new List<Container>.generate(
      count,
      (container) =>
          new Container(child: new Image.asset('images/pic${count--}.jpg')));
  return containers;
}

Widget buildGrid() {
  return new GridView.extent(
      maxCrossAxisExtent: 200.0,
      padding: const EdgeInsets.all(4.0),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      children: _buildGridTileList(29));
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(config.title),
      ),
      body: new Center(
        child: buildGrid(),
      ),
    );
  }
}

// GridView.count({Key key,
//   Axis scrollDirection: Axis.vertical,
//   bool reverse: false,
//   ScrollController controller,
//   bool primary: false,
//   ScrollPhysics physics,
//   bool shrinkWrap: false,
//   EdgeInsets padding,
//   @required int crossAxisCount,
//   double mainAxisSpacing: 0.0,
//   double crossAxisSpacing: 0.0,
//   double childAspectRatio: 1.0,
//   List<Widget> children: const [] })

// GridView.extent({Key key,
//   Axis scrollDirection: Axis.vertical,
//   bool reverse: false,
//   ScrollController controller,
//   bool primary: false,
//   ScrollPhysics physics,
//   bool shrinkWrap: false,
//   EdgeInsets padding,
//   @required double maxCrossAxisExtent,
//   double mainAxisSpacing: 0.0,
//   double crossAxisSpacing: 0.0,
//   double childAspectRatio: 1.0,
//   List<Widget> children: const [] })

/**
    Widget buildGrid(Orientation orientation) {
    return new GridView.count(
    crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
    padding: const EdgeInsets.all(4.0),
    mainAxisSpacing: 4.0,
    crossAxisSpacing: 4.0,
    children: _buildGridTileList(29));
    }
 */
