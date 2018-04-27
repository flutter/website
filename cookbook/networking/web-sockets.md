---
layout: page
title: "Working with WebSockets"
permalink: /cookbook/networking/web-sockets/
---

In addition to normal HTTP requests, we can connect to servers using WebSockets.
WebSockets allow for two-way communication with a server without polling.

In this example, we'll connect to a [test server provided by 
websocket.org](http://www.websocket.org/echo.html). The server will simply send
back the same message we send to it!

## Directions

  1. Connect to a WebSocket server 
  2. Listen for messages from the server 
  3. Send Data to the Server
  4. Close the WebSocket connection
  
## 1. Connect to a WebSocket server

The [web_socket_channel](https://pub.dartlang.org/packages/web_socket_channel) 
package provides the tools we'll need to connect to a WebSocket server.

The package provides a `WebSocketChannel` that allows us to both listen for 
messages from the server as well as push messages to the server. 

In Flutter, we can create a `WebSocketChannel` that connects to a server in one 
line:

<!-- skip -->
```dart
final channel = new IOWebSocketChannel.connect('ws://echo.websocket.org');
```

## 2. Listen for messages from the server

Now that we've established a connection, we can listen to messages from our 
server.

After we send a message to the test server, it will send the same message back. 

How do we listen for messages and display them? In this example, we'll use 
a [`StreamBuilder`](https://docs.flutter.io/flutter/widgets/StreamBuilder-class.html) 
Widget to listen for new messages and a [`Text`](https://docs.flutter.io/flutter/widgets/Text-class.html) 
Widget to display them.

<!-- skip -->
```dart
new StreamBuilder(
  stream: widget.channel.stream,
  builder: (context, snapshot) {
    return new Text(snapshot.hasData ? '${snapshot.data}' : '');
  },
);
```

### How does this work?

The `WebSocketChannel` provides a [`Stream`](https://docs.flutter.io/flutter/dart-async/Stream-class.html)
of messages from the server. 

The `Stream` class is a fundamental part of the `dart:async` package. It
provides a way to listen to async events from a data source. Unlike `Future`, 
which returns a single async response, the `Stream` class can deliver many
events over time. 

The [`StreamBuilder`](https://docs.flutter.io/flutter/widgets/StreamBuilder-class.html)
Widget will connect to a `Stream` and ask Flutter to rebuild every time it 
receives an event using the given `builder` function! 

## 3. Send Data to the Server

In order to send data to the server, we'll `add` messages to the `sink` provided
by the `WebSocketChannel`.

<!-- skip -->
```dart
channel.sink.add('Hello!');
```

### How does this work

The `WebSocketChannel` provides a [`StreamSink`](https://docs.flutter.io/flutter/dart-async/StreamSink-class.html)
to push messages to the server. 

The `StreamSink` class provides a general way to add sync or async events to a 
data source.

## 4. Close the WebSocket connection

After we're done using the WebSocket, we'll want to close the connection! To do 
so, we can close the `sink`.

<!-- skip -->
```dart
channel.sink.close();
```

## Complete Example

```dart
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'WebSocket Demo';
    return new MaterialApp(
      title: title,
      home: new MyHomePage(
        title: title,
        channel: new IOWebSocketChannel.connect('ws://echo.websocket.org'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final WebSocketChannel channel;

  MyHomePage({Key key, @required this.title, @required this.channel})
      : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Form(
              child: new TextFormField(
                controller: _controller,
                decoration: new InputDecoration(labelText: 'Send a message'),
              ),
            ),
            new StreamBuilder(
              stream: widget.channel.stream,
              builder: (context, snapshot) {
                return new Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: new Text(snapshot.hasData ? '${snapshot.data}' : ''),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: new Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      widget.channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}
```

![Web Sockets Demo](/images/cookbook/web-sockets.gif)
