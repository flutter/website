---
title: Communicate with WebSockets
description: How to connect to a web socket.
---

<?code-excerpt path-base="cookbook/networking/web_sockets/"?>

In addition to normal HTTP requests,
you can connect to servers using `WebSockets`.
`WebSockets` allow for two-way communication with a server
without polling.

In this example, connect to a
[test WebSocket server sponsored by Lob.com][].
The server sends back the same message you send to it.
This recipe uses the following steps:

  1. Connect to a WebSocket server.
  2. Listen for messages from the server.
  3. Send data to the server.
  4. Close the WebSocket connection.

## 1. Connect to a WebSocket server

The [`web_socket_channel`][] package provides the
tools you need to connect to a WebSocket server.

The package provides a `WebSocketChannel`
that allows you to both listen for messages
from the server and push messages to the server.

In Flutter, use the following line to
create a `WebSocketChannel` that connects to a server:

<?code-excerpt "lib/main.dart (connect)" replace="/_channel/channel/g"?>
```dart
final channel = WebSocketChannel.connect(
  Uri.parse('wss://echo.websocket.events'),
);
```

## 2. Listen for messages from the server

Now that you've established a connection,
listen to messages from the server.

After sending a message to the test server,
it sends the same message back.

In this example, use a [`StreamBuilder`][]
widget to listen for new messages, and a
[`Text`][] widget to display them.

<?code-excerpt "lib/main.dart (StreamBuilder)" replace="/_channel/channel/g"?>
```dart
StreamBuilder(
  stream: channel.stream,
  builder: (context, snapshot) {
    return Text(snapshot.hasData ? '${snapshot.data}' : '');
  },
),
```

### How this works

The `WebSocketChannel` provides a
[`Stream`][] of messages from the server.

The `Stream` class is a fundamental part of the `dart:async` package.
It provides a way to listen to async events from a data source.
Unlike `Future`, which returns a single async response,
the `Stream` class can deliver many events over time.

The [`StreamBuilder`][] widget connects to a `Stream`
and asks Flutter to rebuild every time it
receives an event using the given `builder()` function.

## 3. Send data to the server

To send data to the server,
`add()` messages to the `sink` provided
by the `WebSocketChannel`.

<?code-excerpt "lib/main.dart (add)" replace="/_channel/channel/g;/_controller.text/'Hello!'/g"?>
```dart
channel.sink.add('Hello!');
```

### How this works

The `WebSocketChannel` provides a
[`StreamSink`][] to push messages to the server.

The `StreamSink` class provides a general way to add sync or async
events to a data source.

## 4. Close the WebSocket connection

After you're done using the WebSocket, close the connection:

<?code-excerpt "lib/main.dart (close)" replace="/_channel/channel/g"?>
```dart
channel.sink.close();
```

## Complete example

<?code-excerpt "lib/main.dart"?>
```dart
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'WebSocket Demo';
    return const MaterialApp(title: title, home: MyHomePage(title: title));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  final _channel = WebSocketChannel.connect(
    Uri.parse('wss://echo.websocket.events'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            const SizedBox(height: 24),
            StreamBuilder(
              stream: _channel.stream,
              builder: (context, snapshot) {
                return Text(snapshot.hasData ? '${snapshot.data}' : '');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }
}
```
![Web sockets demo](/assets/images/docs/cookbook/web-sockets.gif){:.site-mobile-screenshot}


[`Stream`]: {{site.api}}/flutter/dart-async/Stream-class.html
[`StreamBuilder`]: {{site.api}}/flutter/widgets/StreamBuilder-class.html
[`StreamSink`]: {{site.api}}/flutter/dart-async/StreamSink-class.html
[test WebSocket server sponsored by Lob.com]: https://www.lob.com/blog/websocket-org-is-down-here-is-an-alternative
[`Text`]: {{site.api}}/flutter/widgets/Text-class.html
[`web_socket_channel`]: {{site.pub-pkg}}/web_socket_channel
