import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

void main() {
  runApp(new MyApp());
}

// State is managed by ClickboxModel, a subclass of ChangeNotifier.
// The StatefulWidgets register as listeners.
  // TBD: Adam is going to add ListeningWidget to the framework,
  //      so it won't be needed here.
// If something changes, ClickboxModel notifies its listeners.

//---------------------------- ParentWidget ----------------------------

class ParentWidget extends StatefulWidget {
  @override
  ParentWidgetState createState() => new ParentWidgetState();
}

class ParentWidgetState extends State<ParentWidget> {
  ClickboxModel model = new ClickboxModel();

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        new ClickboxD(model: model),
        new ClickboxD(model: model),
      ]
    );
  }
}

//-------------------------- ListeningWidget ---------------------------

abstract class ListeningWidget extends StatefulWidget {
  ListeningWidget({ Key key, this.listenable }) : super(key: key);

  Listenable listenable;

  Widget build(BuildContext context);

  _ListeningWidgetState createState() => new _ListeningWidgetState();
}

class _ListeningWidgetState extends State<ListeningWidget> {
  void initState() {
    super.initState();
    config.listenable.addListener(_handleChanged);
  }

  void didUpdateConfig(ListeningWidget oldConfig) {
    if (config.listenable != oldConfig.listenable) {
      oldConfig.listenable.removeListener(_handleChanged);
      config.listenable.addListener(_handleChanged);
    }
  }

  void dispose() {
    config.listenable.removeListener(_handleChanged);
    super.dispose();
  }

  void _handleChanged() {
    setState(() { });
  }

  Widget build(BuildContext context) => config.build(context);
}

//--------------------------- ClickboxModel ----------------------------

class ClickboxModel extends ChangeNotifier {
  bool get active => _active;
  bool _active = false;
  set active(bool newValue) {
    assert(newValue != null);
    if (_active == newValue)
      return;
    _active = newValue;
    notifyListeners();
  }
}

//----------------------------- ClickboxD ------------------------------

class ClickboxD extends ListeningWidget {
  ClickboxD({Key key, @required ClickboxModel model})
      : model = model, super(key: key, listenable: model);

  final ClickboxModel model;

  void _handleTap() {
    model.active = !model.active;
  }

  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
          child: new Center(
            child: new Text(model.active ? 'Active' : 'Inactive',
                style: new TextStyle(fontSize: 32.0, color: Colors.white)),
          ),
          width: 200.0,
          height: 200.0,
          decoration: new BoxDecoration(
            backgroundColor: model.active ? Colors.lightGreen[700] : Colors.grey[600],
          )
      ),
    );
  }
}

//------------------------------- MyApp --------------------------------

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Flutter Demo'),
        ),
        body: new Center(
          child: new ParentWidget(),
        ),
      ),
    );
  }
}
