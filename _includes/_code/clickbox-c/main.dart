import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

void main() {
  runApp(new MyApp());
}

// ClickboxC exports the "active" state to ParentWidget, but
// handles its color state internally.

//---------------------------- ParentWidget ----------------------------

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
        child: new ClickboxC(active: active, onChanged: handleClickboxChanged));
  }
}

//----------------------------- ClickboxC ------------------------------

class ClickboxC extends StatefulWidget {
  ClickboxC({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  _ClickboxCState createState() => new _ClickboxCState();
}

class _ClickboxCState extends State<ClickboxC> {
  bool highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      highlight = false;
    });
  }

  void _handleTap() {
    config.onChanged(!config.active);
  }

  Widget build(BuildContext context) {

    // This example adds a green border on tap down.
    // On tap up, the square changes to the opposite state.
    return new GestureDetector(
      onTapDown: _handleTapDown,  // Handle the tap events in the order that
      onTapUp: _handleTapUp,      // they occur: down, up, tap, cancel
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: new Container(
          child: new Center(
            child: new Text(config.active ? 'Active' : 'Inactive',
                style: new TextStyle(fontSize: 32.0, color: Colors.white)),
          ),
          width: 200.0,
          height: 200.0,
          decoration: new BoxDecoration(
            backgroundColor:
                config.active ? Colors.lightGreen[700] : Colors.grey[600],
            border: highlight
                ? new Border.all(
              color: Colors.teal[700],
                    width: 10.0,
                  )
                : null,
          )),
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
