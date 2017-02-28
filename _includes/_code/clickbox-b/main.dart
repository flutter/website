import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

void main() {
  runApp(new MyApp());
}

// ParentWidget manages the state for ClickboxB.

//------------------------ ParentWidget --------------------------------

class ParentWidget extends StatefulWidget {
  @override
  ParentWidgetState createState() => new ParentWidgetState();
}

class ParentWidgetState extends State<ParentWidget> {
  bool active = false;

  void handleClickboxChanged(bool newValue) {
    setState(() {
      active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        child:
            new ClickboxB(active: active, onChanged: handleClickboxChanged));
  }
}

//------------------------- ClickboxB ----------------------------------

class ClickboxB extends StatelessWidget {
  ClickboxB({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(active ? 'Active' : 'Inactive',
              style: new TextStyle(fontSize: 32.0, color: Colors.white)),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
          backgroundColor: active ? Colors.lightGreen[700] : Colors.grey[600],
        )
      ),
    );
  }
}

//------------------------- MyApp --------------------------------------

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
