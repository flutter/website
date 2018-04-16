---
layout: page
title: "Working with long lists"
permalink: /cookbook/lists/long-lists/
---

The standard [`ListView`](https://docs.flutter.io/flutter/widgets/ListView-class.html) 
constructor works well for small lists. In order to work with lists that contain
a large number of items, it's best to use the [`Listview.builder`](https://docs.flutter.io/flutter/widgets/ListView/ListView.builder.html) 
constructor.

Whereas the default `ListView` constructor requires us to create all items at
once, the `ListView.builder` constructor will create items as they are scrolled
onto the screen.

## 1. Create a data source

First, we'll need a data source to work with. For example, your data source 
might be a list of messages, search results, or products in a store. Most of 
the time, this data will come from the internet or a database. For this example, 
we'll manually create a List of Messages to work with.

### Define a Message class

We'll need to create a class that holds the data of each message.

```dart
class Message {
  final String sender;
  final String subject;
  final String body;

  Message({this.sender, this.subject, this.body});
}
```

### Create a list of Messages

Now that we've got a Message class to work with, we'll create a list of sample
data to work with. 

```dart
final messages = [
  new Message(
    sender: 'Flutter Weekly',
    subject: 'Flutter Weekly #5',
    body: 'Check out this week\'s latest Flutter news'
  ),
  new Message(
    sender: 'Drew',
    subject: 'Scuba Photos',
    body: 'Check out the pictures from our last trip'
  ),
  new Message(
    sender: 'Lindsey',
    subject: 'Catch up on Thursday?',
    body: 'Long time no see, let\'s grab coffee!'
  ),
];
```

## 2. Convert our Items into a List

In order to display out list of messages, we'll need to render each Message as 
a Widget for our users to interact with!

This is where the `ListView.builder` will come into play. In our case, we'll 
display a list of messages that imitate the Gmail app.

```dart
new ListView.builder(
  // Pass the number of messages in your list to the builder
  itemCount: messages.length,
  // Provide a function that will build each Widget as it's scrolled on screen
  itemBuilder: (context, index) {
    final message = messages[index];

    return new ListTile(
      leading: new CircleAvatar(
        child: new Text(message.sender[0]),
      ),
      title: new Text(message.sender),
      subtitle: new Text('${message.subject}\n${message.body}'),
      isThreeLine: true,
    );
  }
);
```

## Complete Example

```dart
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class Message {
  final String sender;
  final String subject;
  final String body;

  Message({this.sender, this.subject, this.body});
}

final messages = [
  new Message(
    sender: 'Flutter Weekly',
    subject: 'Flutter Weekly #5',
    body: 'Check out this week\'s latest Flutter news'
  ),
  new Message(
    sender: 'Drew',
    subject: 'Scuba Photos',
    body: 'Check out the pictures from our last trip'
  ),
  new Message(
    sender: 'Lindsey',
    subject: 'Catch up on Thursday?',
    body: 'Long time no see, let\'s grab coffee!'
  ),
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Basic List';

    return new MaterialApp(
      title: title,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(title),
        ),
        body: new ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];

            return new ListTile(
              leading: new CircleAvatar(
                child: new Text(message.sender[0]),
              ),
              title: new Text(message.sender),
              subtitle: new Text('${message.subject}\n${message.body}'),
              isThreeLine: true,
            );
          }
        ),
      ),
    );
  }
}
```