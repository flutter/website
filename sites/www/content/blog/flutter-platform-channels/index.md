---
title: "Flutter Platform Channels"
description: >-
  "Nice UI. But how does Flutter deal with platform-specific APIs?"
publishDate: 2018-08-28
author: mravn
image: images/1ykNghfAKtx0xsZWedfgslg.webp
category: tutorial
layout: blog
---

[Flutter](https://flutter.io) invites you to write your mobile app in the Dart programming language and build for both Android and iOS. But Dart does not compile to Android’s Dalvik bytecode, nor are you blessed with Dart/Objective-C bindings on iOS. This means that your Dart code is written without direct access to the platform-specific APIs of iOS Cocoa Touch and the Android SDK.

This isn’t much of a problem as long as you are just writing Dart to paint pixels on the screen. The Flutter framework and its underlying graphics engine are very capable of that on their own. Nor is it a problem if everything you do besides painting pixels is file or network I/O and associated business logic. The Dart language, runtime, and libraries have you covered there.

But non-trivial apps require deeper integration with the host platform:

* notifications, app lifecycle, deep links, …

* sensors, camera, battery, geolocation, sound, connectivity, …

* sharing information with other apps, launching other apps, …

* persisted preferences, special folders, device information, …

The list is long and broad and seems to grow with every platform release.

Access to all of these platform APIs could be baked into the Flutter framework itself. But that would make Flutter a lot bigger and give it many more reasons to change. In practice, that would likely lead to Flutter lagging behind the latest platform release. Or landing app authors with unsatisfactory “least common denominator” wrappings of platform APIs. Or puzzling newcomers with unwieldy abstractions to paper over platform differences. Or version fragmentation. Or bugs.

Come to think of it, probably all of the above.

The Flutter team chose a different approach. It doesn’t do all that much, but it is simple, versatile, and completely in your hands.

First of all, **Flutter is hosted** by an ambient Android or iOS app. The Flutter parts of the app are wrapped in standard platform-specific components such as `View` on Android and `UIViewController` on iOS. So while Flutter invites you to write your app in Dart, you can do as much or as little in Java/Kotlin or Objective-C/Swift as you please in the host app, working directly on top of platform-specific APIs.

Second, [**platform channels**](https://flutter.io/platform-channels/) provide a simple mechanism for communicating between your Dart code and the platform-specific code of your host app. This means you can expose a platform service in your host app code and have it invoked from the Dart side. Or vice versa.

And third, [**plugins**](https://flutter.io/developing-packages/) make it possible to create a Dart API backed by an Android implementation written in Java or Kotlin and an iOS implementation written in Objective-C or Swift — and package that up as a Flutter/Android/iOS triple glued together using platform channels. This means you can reuse, share, and distribute *your take* on how Flutter should use a particular platform API.

This article is an in-depth introduction to platform channels. Starting from Flutter’s messaging foundations, I’ll introduce the message/method/event channel concepts, and discuss some API design considerations. There’ll be no API listings, but short code samples for copy-paste reuse instead. A brief list of usage guidelines is provided, based on my experience contributing to the [flutter/plugins](https://github.com/flutter/plugins) GitHub repository as a member of the Flutter team. The article concludes with a list of additional resources, including links to the DartDoc/JavaDoc/ObjcDoc reference APIs.

## Platform channels API

For most use cases you would probably employ *method channels* for platform communication. But since many of their properties are derived from the simpler *message channels* and from the underlying *binary messaging* foundations, I’ll start there.

### Foundations: asynchronous, binary messaging

<DashImage figure src="images/1BIknuDE2gMHmbYg7S8_F0Q.webp" />

At the most basic level, Flutter talks to platform code using asynchronous message passing with binary messages — meaning the message payload is a byte buffer. To distinguish between messages used for different purposes, each message is sent on a logical “channel” which is just a name string. The examples below use the channel name `foo`.

```dart
// Send a binary message from Dart to the platform.

final WriteBuffer buffer = WriteBuffer()
  ..putFloat64(3.1415)
  ..putInt32(12345678);
final ByteData message = buffer.done();
await BinaryMessages.send('foo', message);
print('Message sent, reply ignored');
```

On Android such a message can be received, as a `java.nio.ByteBuffer`, using the following Kotlin code:

```kotlin
// Receive binary messages from Dart on Android.
// This code can be added to a FlutterActivity subclass, typically
// in onCreate.

flutterView.setMessageHandler("foo") { message, reply ->
  message.order(ByteOrder.nativeOrder())
  val x = message.double
  val n = message.int
  Log.i("MSG", "Received: $x and $n")
  reply.reply(null)
}
```

The `ByteBuffer` API supports reading off primitive values while automatically advancing the current read position. The story on iOS is similar; suggestions for improving my weak Swift fu are very welcome:

```swift
// Receive binary messages from Dart on iOS.
// This code can be added to a FlutterAppDelegate subclass,
// typically in application:didFinishLaunchingWithOptions:.

let flutterView =
  window?.rootViewController as! FlutterViewController;
flutterView.setMessageHandlerOnChannel("foo") {
  (message: Data!, reply: FlutterBinaryReply) -> Void in
  let x : Float64 = message.subdata(in: 0..<8)
    .withUnsafeBytes { $0.pointee }
  let n : Int32 = message.subdata(in: 8..<12)
    .withUnsafeBytes { $0.pointee }
  os_log("Received %f and %d", x, n)
  reply(nil)
}
```

Communication is bidirectional, so you can send messages in the opposite direction too, from Java/Kotlin or Objective-C/Swift to Dart. Reversing the direction of the above setup looks as follows:

Send a binary message from Android:

```kotlin
val message = ByteBuffer.allocateDirect(12)
message.putDouble(3.1415)
message.putInt(123456789)
flutterView.send("foo", message) { _ ->
  Log.i("MSG", "Message sent, reply ignored")
}
```

Send a binary message from iOS:

```swift
var message = Data(capacity: 12)
var x: Float64 = 3.1415
var n: Int32 = 12345678
message.append(UnsafeBufferPointer(start: &x, count: 1))
message.append(UnsafeBufferPointer(start: &n, count: 1))
flutterView.send(onChannel: "foo", message: message) {(_) -> Void in
  os_log("Message sent, reply ignored")
}
```

Receive binary messages from the platform in Dart:

```dart
BinaryMessages.setMessageHandler('foo', (ByteData message) async {
  final ReadBuffer readBuffer = ReadBuffer(message);
  final double x = readBuffer.getFloat64();
  final int n = readBuffer.getInt32();
  print('Received $x and $n');
  return null;
});
```

**The fine print.** *Mandatory replies.* Each message send involves an asynchronous reply from the receiver. In the examples above, there is no interesting value to communicate back, but the null reply is necessary for the Dart future to complete and for the two platform callbacks to execute.

*Threads.* Messages and replies are received, and must be sent, on the platform’s main UI thread. In Dart there is only one thread per Dart isolate, i.e. per Flutter view, so there is no confusion about which thread to use here.

*Exceptions.* Any uncaught exception thrown in a Dart or Android message handler is caught by the framework, logged, and a null reply is sent back to the sender. Uncaught exceptions thrown in reply handlers are logged.

*Handler lifetime.* Registered message handlers are retained and kept alive along with the Flutter view (meaning the Dart isolate, the Android `FlutterView` instance, and the iOS `FlutterViewController`). You can cut a handler’s life short by deregistering it: just set a null (or different) handler using the same channel name.

*Handler uniqueness.* Handlers are held in a hash map keyed by channel name, so there can be at most one handler per channel. A message sent on a channel for which no message handler is registered at the receiving end is responded to automatically, using a null reply.

*Synchronous communication.* Platform communication is available in asynchronous mode only. This avoids making blocking calls across threads and the system-level problems that might entail (poor performance, risk of deadlocks). At the time of this writing, it is not entirely clear if synchronous communication is really needed in Flutter and, if so, in what form.

Working at the level of binary messages, you need to worry about delicate details like endianness and how to represent higher-level messages such as strings or maps using bytes. You also need to specify the right channel name whenever you want to send a message or register a handler. Making this easier leads us to platform channels:

*A platform channel is an object that brings together a channel name and a codec for serializing/deserializing messages to binary form and back*.

### Message channels: name + codec

<DashImage figure src="images/1Sd6s3EDGkU8TBS9xLc4Zvw.webp" />

Suppose you want to send and receive string messages instead of byte buffers. This can be done using a message channel, a simple kind of platform channel, constructed with a string codec. The code below shows how to use message channels in both directions across Dart, Android, and iOS.

On the Dart side:

```dart
const channel = BasicMessageChannel<String>('foo', StringCodec());

// Send message to platform and receive reply.
final String reply = await channel.send('Hello, world');
print(reply);

// Receive messages from platform and send replies.
channel.setMessageHandler((String message) async {
  print('Received: $message');
  return 'Hi from Dart';
});
```

On the Android side:

```kotlin
val channel = BasicMessageChannel<String>(
  flutterView, "foo", StringCodec.INSTANCE)

// Send message to Dart and receive reply.
channel.send("Hello, world") { reply ->
  Log.i("MSG", reply)
}

// Receive messages from Dart and send replies.
channel.setMessageHandler { message, reply ->
  Log.i("MSG", "Received: $message")
  reply.reply("Hi from Android")
}
```

On the iOS side:

```swift
let channel = FlutterBasicMessageChannel(
    name: "foo",
    binaryMessenger: controller,
    codec: FlutterStringCodec.sharedInstance())

// Send message to Dart and receive reply.
channel.sendMessage("Hello, world") {(reply: Any?) -> Void in
  os_log("%@", type: .info, reply as! String)
}

// Receive messages from Dart and send replies.
channel.setMessageHandler {
  (message: Any?, reply: FlutterReply) -> Void in
  os_log("Received: %@", type: .info, message as! String)
  reply("Hi from iOS")
}
```

The channel name is specified only on channel construction. After that, calls to send a message or set a message handler can be done without repeating the channel name. More importantly, we leave it to the string codec class to deal with how to interpret bytes buffers as strings and vice versa.

These are noble advantages to be sure, but you’d probably agree that `BasicMessageChannel` doesn’t do all that much. Which is on purpose. The Dart code above is equivalent to the following use of the binary messaging foundations:

```dart
const codec = StringCodec();

// Send message to platform and receive reply.
final String reply = codec.decodeMessage(
  await BinaryMessages.send(
    'foo',
    codec.encodeMessage('Hello, world'),
  ),
);
print(reply);

// Receive messages from platform and send replies.
BinaryMessages.setMessageHandler('foo', (ByteData message) async {
  print('Received: ${codec.decodeMessage(message)}');
  return codec.encodeMessage('Hi from Dart');
});
```

This remark applies to the [Android](https://docs.flutter.io/javadoc/io/flutter/plugin/common/BasicMessageChannel.html) and [iOS](https://docs.flutter.io/objcdoc/Classes/FlutterBasicMessageChannel.html) implementations of message channels as well. *There is no magic involved*:

* Message channels delegate to the binary messaging layer for all communication.

* Message channels do not keep track of registered handlers themselves.

* Message channels are light-weight and stateless.

* Two message channel instances created with the same channel name and codec are equivalent (and interfere with each other’s communication).

For various historical reasons, the Flutter framework defines four different message codecs:

* [`StringCodec`](https://docs.flutter.io/flutter/services/StringCodec-class.html) Encodes strings using UTF-8. As we’ve just seen, message channels with this codec have type `BasicMessageChannel<String>` in Dart.

* [`BinaryCodec`](https://docs.flutter.io/flutter/services/BinaryCodec-class.html) Implementing the identity mapping on byte buffers, this codec allows you to enjoy the convenience of channel objects in cases where you don’t need encoding/decoding. Dart message channels with this codec have type `BasicMessageChannel<ByteData>`.

* [`JSONMessageCodec`](https://docs.flutter.io/flutter/services/JSONMessageCodec-class.html) Deals in “JSON-like” values (strings, numbers, Booleans, null, lists of such values, and string-keyed maps of such values). Lists and maps are heterogeneous and can be nested. During encoding, the values are turned into JSON strings and then to bytes using UTF-8. Dart message channels have type `BasicMessageChannel<dynamic>` with this codec.

* [`StandardMessageCodec`](https://docs.flutter.io/flutter/services/StandardMessageCodec-class.html) Deals in slightly more generalized values than the JSON codec, supporting also homogeneous data buffers (`UInt8List`, `Int32List`, `Int64List`, `Float64List`) and maps with non-string keys. The handling of numbers differs from JSON with Dart ints arriving as 32 or 64 bit signed integers on the platform, depending on magnitude — never as floating-point numbers. Values are encoded into a custom, reasonably compact, and extensible binary format. The standard codec is designed to be the default choice for channel communication in Flutter. As for JSON, Dart message channels constructed with the standard codec have type `BasicMessageChannel<dynamic>`.

As you may have guessed, message channels work with any message codec implementation that satisfies a simple contract. This allows you to plug in your own codec, if you need to. You’ll have to implement compatible encoding and decoding in Dart, Java/Kotlin, and Objective-C/Swift.

**The fine print.** *Codec evolution*. Each message codec is available in Dart, as part of the Flutter framework, as well as on both platforms, as part of the libraries exposed by Flutter to your Java/Kotlin or Objective-C/Swift code. Flutter uses the codecs only for intra-app communication, not as a persistence format. This means that the binary form of messages may change from one release of Flutter to the next, without warning. Of course, the Dart, Android, and iOS codec implementations are evolved together, to ensure that what is encoded by the sender can be successfully decoded by the receiver, in both directions.

*Null messages.* Any message codec must support and preserve null messages since that is the default reply to a message sent on a channel for which no message handler has been registered on the receiving side.

*Static typing of messages in Dart.* A message channel configured with the standard message codec gives type `dynamic` to messages and replies. You’d often make your type expectations explicit by assigning to a typed variable:

```dart
final String reply1 = await channel.send(msg1);
final int reply2 = await channel.send(msg2);
```

But there’s a caveat when dealing with replies involving generic type parameters:

```dart
final List<String> reply3 = await channel.send(msg3);      // Fails.
final List<dynamic> reply3 = await channel.send(msg3);     // Works.
```

The first line fails at runtime, unless the reply is null. The standard message codec is written for heterogeneous lists and maps. On the Dart side, these have runtime types `List<dynamic>` and `Map<dynamic, dynamic>`, and Dart 2 prevents such values from being assigned to variables with more specific type arguments. This situation is similar to Dart JSON deserialization which produces `List<dynamic>` and `Map<String, dynamic>` — as does the JSON message codec.

Futures can get you into similar trouble:

```dart
Future<String> greet() => channel.send('hello, world');    // Fails.
Future<String> greet() async {                             // Works.
  final String reply = await channel.send('hello, world');
  return reply;
}
```

The first method fails at runtime, even if the reply received is a string. The channel implementation creates a `Future<dynamic>` regardless of the type of the reply, and such an object cannot be assigned to a `Future<String>`.

*Why the “basic“ in BasicMessageChannel?* Message channels seem to be used only in rather restricted situations where you are communicating some form of homogeneous event stream in an implied context. Like keyboard events, perhaps. For most applications of platform channels, you’re going to need to communicate not only values, but also what you want to happen with each value, or how you’d like it to be interpreted by the receiver. One way to do that is to have the message represent a method call with the value as argument. So you’ll want a standard way of separating the method name from the argument in the message. And you’ll also want a standard way to distinguish between success and error replies. This is what *method* channels do for you. Now, `BasicMessageChannel` was originally named `MessageChannel`, but was renamed to avoid confusing `MessageChannel` with `MethodChannel` in code. Being more generally applicable, method channels kept the shorter name.

### Method channels: standardized envelopes

<DashImage figure src="images/1ykNghfAKtx0xsZWedfgslg.webp" />

Method channels are platform channels designed for invoking named pieces of code across Dart and Java/Kotlin or Objective-C/Swift. Method channels make use of standardized message “envelopes” to convey method name and arguments from sender to receiver, and to distinguish between successful and erroneous results in the associated reply. The envelopes and supported payload are defined by separate method codec classes, similarly to how message channels use message codecs.

*This is all that method channels do: combine a channel name with a codec.*

In particular, no assumptions are being made about what code is executed on receipt of a message on a method channel. Even though the message represents a method call, you don’t have to invoke a method. You might just switch on the method name and execute a few lines of code for each case.

**Side note.** This lack of implied or automated binding to methods and their parameters might disappoint you. That’s fine, disappointment can be productive. I suppose you can build such a solution from scratch using annotation processing and code generation, or maybe you can reuse parts of an existing RPC framework. Flutter is open source, [feel free to contribute](https://github.com/flutter/flutter/blob/master/CONTRIBUTING.md)! Method channels are available as a target for your code generation, if they fit the bill. In the mean time, they are useful on their own in “handcraft mode”.

Method channels were the Flutter team’s answer to the challenge of defining a workable communication API for use by the, at the time, non-existing plugin ecosystem. We wanted something that plugin authors could start using right away, without a lot of boilerplate or complicated build setup. I think the method channel concept makes a decent answer, but I’d be surprised if it remains the *only* answer.

Here’s how you would use a method channel in the simple case of invoking a bit of platform code from Dart. The code is associated with the name `bar` which is not a method name in this case, but could have been. All it does is construct a greeting string and return it to the caller, so we can code this with the reasonable assumption that the platform invocation won’t fail (we’ll look at error handling further below).

On the Dart side:

```dart
// A basic example of invoking platform methods.
const channel = MethodChannel('foo');
final String greeting = await channel.invokeMethod('bar', 'world');
print(greeting);
```

On the Android side:

```kotlin
val channel = MethodChannel(flutterView, "foo")
channel.setMethodCallHandler { call, result ->
  when (call.method) {
    "bar" -> result.success("Hello, ${call.arguments}")
    else -> result.notImplemented()
  }
}
```

On the iOS side:

```swift
let channel = FlutterMethodChannel(
  name: "foo", binaryMessenger: flutterView)
channel.setMethodCallHandler {
  (call: FlutterMethodCall, result: FlutterResult) -> Void in
  switch (call.method) {
  case "bar": result("Hello, \(call.arguments as! String)")
  default: result(FlutterMethodNotImplemented)
  }
}
```

By adding cases to the switch constructs, we can easily extend the above to handle multiple methods. The default clause handles the situation where an unknown method is called (most likely due to a programming error).

The Dart code above is equivalent to the following:

```dart
const codec = StandardMethodCodec();

final ByteData reply = await BinaryMessages.send(
  'foo',
  codec.encodeMethodCall(MethodCall('bar', 'world')),
);
if (reply == null) {
  throw MissingPluginException();
} else {
  print(codec.decodeEnvelope(reply));
}
```

The [Android](https://docs.flutter.io/javadoc/io/flutter/plugin/common/MethodChannel.html) and [iOS](https://docs.flutter.io/objcdoc/Classes/FlutterMethodChannel.html) implementations of method channels are similarly thin wrappers around calls to the binary messaging foundations. A null reply is used to represent a “not implemented” result. This conveniently makes the behavior at the receiving end indifferent to whether the invocation fell through to the default clause in the switch, or no method call handler had been registered with the channel at all.

The argument value in the example is the single string `world`. But the default method codec, aptly named the “standard method codec”, uses the standard *message* codec under the hood to encode payload values. This means that the “generalized JSON-like” values described earlier are all supported as method arguments and (successful) results. In particular, heterogeneous lists support multiple arguments, while heterogeneous maps support named arguments. The default arguments value is null. A few examples:

```dart
await channel.invokeMethod('bar');
await channel.invokeMethod('bar', <dynamic>['world', 42, pi]);
await channel.invokeMethod('bar', <String, dynamic>{
  name: 'world',
  answer: 42,
  math: pi,
}));
```

The Flutter SDK includes two method codecs:

* [`StandardMethodCodec`](https://docs.flutter.io/flutter/services/StandardMethodCodec-class.html) which by default delegates the encoding of payload values to `StandardMessageCodec`. Because the latter is extensible, so is the former.

* [`JSONMethodCodec`](https://docs.flutter.io/flutter/services/JSONMethodCodec-class.html) which delegates the encoding of payload values to `JSONMessageCodec`.

You can configure method channels with any method codec, including custom ones. To fully understand what is involved in implementing a codec, let’s look at how errors are handled at the method channel API level by extending the example above with a fallible `baz` method.

On the Dart side:

```dart
const channel = MethodChannel('foo');

// Invoke a platform method.
const name = 'bar'; // or 'baz', or 'unknown'
const value = 'world';
try {
  print(await channel.invokeMethod(name, value));
} on PlatformException catch(e) {
  print('$name failed: ${e.message}');
} on MissingPluginException {
  print('$name not implemented');
}

// Receive method invocations from platform and return results.
channel.setMethodCallHandler((MethodCall call) async {
  switch (call.method) {
    case 'bar':
      return 'Hello, ${call.arguments}';
    case 'baz':
      throw PlatformException(code: '400', message: 'This is bad');
    default:
      throw MissingPluginException();
  }
});
```

On the Android side:

```kotlin
val channel = MethodChannel(flutterView, "foo")

// Invoke a Dart method.
val name = "bar" // or "baz", or "unknown"
val value = "world"
channel.invokeMethod(name, value, object: MethodChannel.Result {
  override fun success(result: Any?) {
    Log.i("MSG", "$result")
  }
  override fun error(code: String?, msg: String?, details: Any?) {
    Log.e("MSG", "$name failed: $msg")
  }
  override fun notImplemented() {
    Log.e("MSG", "$name not implemented")
  }
})

// Receive method invocations from Dart and return results.
channel.setMethodCallHandler { call, result ->
  when (call.method) {
    "bar" -> result.success("Hello, ${call.arguments}")
    "baz" -> result.error("400", "This is bad", null)
    else -> result.notImplemented()
  }
}
```

On the iOS side:

```swift
let channel = FlutterMethodChannel(
  name: "foo", binaryMessenger: flutterView)

// Invoke a Dart method.
let name = "bar" // or "baz", or "unknown"
let value = "world"
channel.invokeMethod(name, arguments: value) {
  (result: Any?) -> Void in
  if let error = result as? FlutterError {
    os_log("%@ failed: %@", type: .error, name, error.message!)
  } else if FlutterMethodNotImplemented.isEqual(result) {
    os_log("%@ not implemented", type: .error, name)
  } else {
    os_log("%@", type: .info, result as! NSObject)
  }
}

// Receive method invocations from Dart and return results.
channel.setMethodCallHandler {
  (call: FlutterMethodCall, result: FlutterResult) -> Void in
  switch (call.method) {
  case "bar": result("Hello, \(call.arguments as! String)")
  case "baz": result(FlutterError(
    code: "400", message: "This is bad", details: nil))
  default: result(FlutterMethodNotImplemented)
}
```

Errors are triples (code, message, details) where the code and message are strings. The message is intended for human consumption, the code for, well, code. The error details is some custom value, often null, which is constrained only by the kinds of value that the codec supports.

**The fine print.** *Exceptions.* Any uncaught exception thrown in a Dart or Android method call handler is caught by the channel implementation, logged, and an error result is returned to the caller. Uncaught exceptions thrown in result handlers are logged.

*Envelope encoding.* How a method codec encodes its envelopes is an implementation detail just like how message codecs convert messages to bytes. As an example, a method codec might use lists: method calls can be encoded as a two-element lists [method name, arguments]; success results as one-element lists [result]; error results as three-element lists [code, message, details]. Such a method codec can then be implemented simply by delegation to an underlying *message* codec that supports at least lists, strings, and null. The method call arguments, success results, and error details would be arbitrary values supported by that message codec.

*API differences.* The code examples above highlight that method channels deliver results very differently across Dart, Android, and iOS:

* On the Dart side, invocation is handled by a method returning a future. The future completes with the result of the call in success cases, with a `PlatformException` in error cases, and with a `MissingPluginException` in the not implemented case.

* On Android, invocation is handled by a method taking a callback argument. The callback interface defines three methods of which one is called, depending on the outcome. Client code implements the callback interface to define what should happen on success, on error, and on not implemented.

* On iOS, invocation is similarly handled by a method taking a callback argument. But here, the callback is a single-argument function which is given either a `FlutterError` instance, the `FlutterMethodNotImplemented` constant, or, in case of success, the result of the invocation. Client code provides a block with conditional logic to handle the different cases, as needed.

These differences, mirrored also in the way message call handlers are written, arose as concessions to the styles of the programming languages (Dart, Java, and Objective-C) used for the Flutter SDK method channel implementations. Redoing the implementations in Kotlin and Swift might remove some of the differences, but care must be taken to avoid making it harder to use method channels from Java and Objective-C.

### Event channels: streaming

<DashImage figure src="images/1jd9Thys5_k-jbkKM7P69Ng.webp" />

An event channel is a specialized platform channel intended for the use case of exposing platform events to Flutter as a Dart stream. The Flutter SDK currently has no support for the symmetrical case of exposing Dart streams to platform code, though that could be built, if the need arises.

Here’s how you would consume a platform event stream on the Dart side:

```dart
// Consuming events on the Dart side.

const channel = EventChannel('foo');

channel.receiveBroadcastStream().listen((dynamic event) {
  print('Received event: $event');
}, onError: (dynamic error) {
  print('Received error: ${error.message}');
});
```

The code below shows how to produce events on the platform side, using sensor events on Android as an example. The main concern is to ensure that we are listening to events from the platform source (the sensor manager in this case) and sending them through the event channel precisely when 1) there is at least one stream listener on the Dart side and 2) the ambient `Activity` is running. Packaging up the necessary logic in a single class increases the chance of doing this correctly:

```kotlin
// Producing sensor events on Android.

// SensorEventListener/EventChannel adapter.
class SensorListener(private val sensorManager: SensorManager) :
  EventChannel.StreamHandler, SensorEventListener {
  private var eventSink: EventChannel.EventSink? = null

  // EventChannel.StreamHandler methods
  override fun onListen(
    arguments: Any?, eventSink: EventChannel.EventSink?) {
    this.eventSink = eventSink
    registerIfActive()
  }
  override fun onCancel(arguments: Any?) {
    unregisterIfActive()
    eventSink = null
  }

  // SensorEventListener methods.
  override fun onSensorChanged(event: SensorEvent) {
    eventSink?.success(event.values)
  }
  override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {
    if (accuracy == SensorManager.SENSOR_STATUS_ACCURACY_LOW)
      eventSink?.error("SENSOR", "Low accuracy detected", null)
  }

  // Lifecycle methods.
  fun registerIfActive() {
    if (eventSink == null) return
    sensorManager.registerListener(
      this,
      sensorManager.getDefaultSensor(Sensor.TYPE_GYROSCOPE),
      SensorManager.SENSOR_DELAY_NORMAL)
  }
  fun unregisterIfActive() {
    if (eventSink == null) return
    sensorManager.unregisterListener(this)
  }
}

// Use of the above class in an Activity.
class MainActivity: FlutterActivity() {
  var sensorListener: SensorListener? = null

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)
    sensorListener = SensorListener(
      getSystemService(Context.SENSOR_SERVICE) as SensorManager)
    val channel = EventChannel(flutterView, "foo")
    channel.setStreamHandler(sensorListener)
  }

  override fun onPause() {
    sensorListener?.unregisterIfActive()
    super.onPause()
  }

  override fun onResume() {
    sensorListener?.registerIfActive()
    super.onResume()
  }
}
```

If you use the `android.arch.lifecycle` package in your app, you could make `SensorListener` more self-contained by making it a `LifecycleObserver`.

**The fine print.** *Life of a stream handler.* The platform side stream handler has two methods, `onListen` and `onCancel`, which are invoked whenever the number of listeners to the Dart stream goes from zero to one and back, respectively. This can happen multiple times. The stream handler implementation is supposed to start pouring events into the event sink when the former is called, and stop when the latter is called. In addition, it should pause when the ambient app component is not running. The code above provides a typical example. Under the covers, a stream handler is of course just a binary message handler, registered with the Flutter view using the event channel’s name.

*Codec.* An event channel is configured with a method codec, allowing us to distinguish between success and error events in the same way that method channels are able to distinguish between success and error results.

*Stream handler arguments and errors.* The `onListen` and `onCancel` stream handler methods are invoked via method channel invocations. So we have control method calls from Dart to the platform and event messages in the reverse direction, all on the same logical channel. This setup allows arguments to be relayed to both control methods and any errors to be reported back. On the Dart side, the arguments, if any, are given in the call to `receiveBroadcastStream`. This means they are specified only once, regardless of the number of invocations of `onListen` and `onCancel` happening during the lifetime of the stream. Any errors reported back are logged.

*End of stream.* An event sink has an `endOfStream` method that can be invoked to signal that no additional success or error events will be sent. The null binary message is used for this purpose. On receipt on the Dart side, the stream is closed.

*Life of a stream*. The Dart stream is backed by a stream controller fed from the incoming platform channel messages. A binary message handler is registered using the event channel’s name to receive incoming messages only while the stream has listeners.

## Usage guidelines

### Prefix channel names by domain for uniqueness

Channel names are just strings, but they have to be unique across all channel objects used for different purposes in your app. You can accomplish that using any suitable naming scheme. However, the recommended approach *for channels used in plugins* is to employ a domain name and plugin name prefix such as `some.body.example.com/sensors/foo` for the `foo` channel used by the `sensors` plugin developed by `some.body` at `example.com`. Doing so allows plugin consumers to combine any number of plugins in their apps without risk of channel name collisions.

### Consider treating platform channels as intra-module communication

Code for invoking remote procedure calls in distributed systems look superficially similar to code using method channels: you invoke a method given by a string and serialize your arguments and results. Since distributed system components are often developed and deployed independently, robust request and reply checking is critical, and usually done in check-and-log style on both sides of the network.

Platform channels on the other hand glue together three pieces of code that are developed and deployed together, in a single component.

Java/Kotlin ↔ Dart ↔ Objective-C/Swift

In fact, it very often makes sense to package up a triad like this in a *single code module*, such as a Flutter plugin. This means that the need for arguments and results checking across method channel invocations should be comparable to the need for such checks across normal method calls within the same module.

Inside modules, our main concern is to guard against programming errors that are beyond the compiler’s static checks and go undetected at runtime until they blow things up non-locally in time or space. A reasonable coding style is to make assumptions explicit using types or assertions, allowing us to fail fast and cleanly, e.g. with an exception. Details vary by programming language of course. Examples:

* If a value received over a platform channel is expected to have a certain type, immediately assign it to a variable of that type.

* If a value received over a platform channel is expected to be non-null, either set things up to have it dereferenced immediately, or assert that it is non-null before storing it for later. Depending on your programming language, you may be able to assign it to a variable of a non-nullable type instead.

The following Dart code expects to receive a non-null list of integers:

```dart
for (final int n in await channel.invokeMethod('getFib', 100)) {
  print(n * n);
}
```

The following Android code expects non-null `name` and `age` arguments for asynchronous processing, delivered in a string-keyed map:

```kotlin
channel.setMethodCallHandler { call, result ->
  when (call.method) {
    "bar" -> {
      val name : String = call.argument("name")
      val age : Int = call.argument("age")
      process(name, age, result)
    }
    else -> result.notImplemented()
  }
}
:
fun process(name: String, age: Int, result: Result) { ... }
```

The Android code exploits the generically typed `<T> T argument(String key)` method of `MethodCall` which looks up the key in the arguments, assumed to be a map, and casts the value found to the target (call site) type. A suitable exception is thrown, if this fails for any reason. Being thrown from a method call handler, it would be logged, and an error result sent to the Dart side.

### Don’t mock platform channels

(Pun intended.) When writing unit tests for Dart code that uses platform channels, a knee jerk reaction may be to mock the channel object, as you would a network connection.

You can certainly do that, but channel objects don’t actually need to be mocked to play nicely with unit tests. Instead, you can register mock message or method handlers to play the role of the platform during a particular test. Here is a unit test of a function `hello` that is supposed to invoke the `bar` method on channel `foo`:

```dart
test('gets greeting from platform', () async {
  const channel = MethodChannel('foo');
  channel.setMockMethodCallHandler((MethodCall call) async {
    if (call.method == 'bar')
      return 'Hello, ${call.arguments}';
    throw MissingPluginException();
  });
  expect(await hello('world'), 'Platform says: Hello, world');
});
```

To test code that sets up message or method handlers, you can synthesize incoming messages using `BinaryMessages.handlePlatformMessage`. At present, this method is not mirrored on platform channels, though that could easily be done as indicated in the code below. The code defines a unit test of a class `Hello` that is supposed to collect incoming arguments of calls to method `bar` on channel `foo`, while returning greetings:

```dart
test('collects incoming arguments', () async {
  const channel = MethodChannel('foo');
  final hello = Hello();
  final String result = await handleMockCall(
    channel,
    MethodCall('bar', 'world'),
  );
  expect(result, contains('Hello, world'));
  expect(hello.collectedArguments, contains('world'));
});

// Could be made an instance method on class MethodChannel.
Future<dynamic> handleMockCall(
  MethodChannel channel,
  MethodCall call,
) async {
  dynamic result;
  await BinaryMessages.handlePlatformMessage(
    channel.name,
    channel.codec.encodeMethodCall(call),
    (ByteData reply) {
      if (reply == null)
        throw MissingPluginException();
      result = channel.codec.decodeEnvelope(reply);
    },
  );
  return result;
}
```

Both examples above declare the channel object in the unit test. This works fine — unless you worry about the duplicated channel name and codec — because all channel objects with the same name and codec are equivalent. You can avoid the duplication by declaring the channel as a **`const`** somewhere visible to both your production code and the test.

What you don’t need is to provide a way to inject a mock channel into your production code.

### Consider automated testing for your platform interaction

Platform channels are simple enough, but getting everything working from your Flutter UI via a custom Dart API backed by a separate Java/Kotlin and Objective-C/Swift implementation does takes some care. And keeping the setup working as changes are made to your app will, in practice, require automated testing to guard against regressions. This cannot be accomplished with unit testing alone because you need a real app running for platform channels to actually talk to the platform.

Flutter comes with the `flutter_driver` integration test framework that allows you to test Flutter applications running on real devices and emulators. But `flutter_driver` is not currently integrated with other frameworks to enable testing across Flutter and platform components. I am confident this is one area where Flutter will improve in the future.

In some situations, you can use `flutter_driver` as is to test your platform channel usage. This requires that your Flutter user interface can be used to trigger any platform interaction and that it is then updated with sufficient detail to allow your test to ascertain the outcome of the interaction.

If you are not in that situation, or if you are packaging up your platform channel usage as a Flutter plugin for which you want a module test, you can instead write a simple Flutter app for testing purposes. That app should have the characteristics above and can then be exercised using `flutter_driver`. You’ll find an example in [the Flutter GitHub repo](https://github.com/flutter/flutter/tree/master/dev/integration_tests/platform_interaction).

### Keep platform side ready for incoming synchronous calls

Platform channels are asynchronous only. But there are quite a few platform APIs out there that make synchronous calls into your host app components, asking for information or help or offering a window of opportunity. One example is `Activity.onSaveInstanceState` on Android. Being synchronous means everything must be done before the incoming call returns. Now, you might like to include information from the Dart side in such processing, but it is too late to start sending out asynchronous messages once the synchronous call is already active on the main UI thread.

The approach used by Flutter, most notably for semantics/accessibility information, is to proactively send updated (or updates to) information to the platform side whenever the information changes on the Dart side. Then, when the synchronous call arrives, the information from the Dart side is already present and available to platform side code.

## Resources

[Flutter API documentation](https://docs.flutter.io/):

* DartDoc for the [services library](https://docs.flutter.io/flutter/services/services-library.html) which contains the Dart platform channel types.

* JavaDoc for the [io.flutter.plugins.common package](https://docs.flutter.io/javadoc/io/flutter/plugin/common/package-summary.html) which contains the Android platform channel types.

* ObjcDoc for the [iOS Flutter library](https://docs.flutter.io/objcdoc/Classes.html).

Guides:

* The [flutter.io website](https://flutter.io) documents [how to use method channels](https://flutter.io/platform-channels/) and the Dart/Android/iOS value conversions involved in using the standard method codec.

* The *Boring Flutter Development Show*, Episode 6: [Packages and plugins](https://youtu.be/ht2bDlJd2c4) is a YouTube video showing a Flutter plugin being implemented, live, using platform channels.

Code examples:

* The [flutter/flutter GitHub repo](https://github.com/flutter/flutter) contains [a basic example](https://github.com/flutter/flutter/tree/master/examples/platform_channel) of using method and event channels to access device battery information, wrapped up in a complete Flutter app.

* The [flutter/plugins GitHub repo](https://github.com/flutter/plugins) contains several examples of using platform channels to implement Flutter plugins. The code is located in the [packages](https://github.com/flutter/plugins/tree/master/packages) sub-folder, organized by plugin. Each plugin includes a complete example app.
