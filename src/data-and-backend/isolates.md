---
title: Concurrency and Isolates
description: Multithreading in Flutter using Dart isolates.
---

<?code-excerpt path-base="isolates/"?>

All Dart code runs in [isolates](https://dart.dev/language/concurrency), which
are similar to threads, but differ in that isolates have their own isolated
memory. They do not share state in any way, and can only communicate via
messaging. By default, Flutter apps do all of their work on a single isolate. In
most cases, this model allows for simpler programming and is fast enough that
the application's UI doesn’t become unresponsive.

In rare cases, though, applications need to perform exceptionally large
computations that can cause “UI jank”. To solve this problem, you can create new
isolates and move large computations off the main isolate.

Each isolate has its own chunk of memory, and its own event loop. The event loop
processes events in the order that they’re added to an event queue. These events
can be anything from handling a user tapping the UI, to executing a function, to
painting a frame on the screen. For smooth rendering, Flutter adds a “paint
frame” event to the event queue 60 times per second. If these events aren’t
processed on time, the UI will become unresponsive and the user will experience
animation jank.

Whenever a process cannot be completed in a frame gap, or the time between two
frames, it's a good idea to offload the work to another isolate to ensure that
the main isolate can produce 60 frames per second. When you spawn an isolate in
Dart, it can process the work concurrently with the main isolate, without
blocking it.

<iframe width="560" height="315" src="{{site.youtube-site}}/embed/vl_AaCgudcY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

You can read more about how isolates and the event loop work in Dart on the
[concurrency page](https://dart.dev/language/concurrency) of the Dart
documentation.

# The compute method

The easiest way to move a process to an isolate in Flutter is with the
[compute](https://api.flutter.dev/flutter/foundation/compute.html)
API. The compute method spawns an isolate, passes a function to the isolate to
start some computation, returns a value from the computation, and then shuts the
isolate down when the computation is complete. This all happens concurrently
with the main isolate, and doesn’t block it.

<img src='/assets/images/docs/development/data-and-backend/concurrency
/compute-in-isolate.png' width="100%" alt="An image that diagrams the process of
creating an isolate with the compute method. This accompanies the full
explanation in the text.">

{{site.alert.note}} Dart doesn’t support isolates on web platforms. On Flutter
web, compute calls the callback on the main isolate. On native
platforms `await compute(fun, message)` is equivalent
to `await Isolate.run(() => fun(message))`. See
also [Isolate.run](https://api.flutter.dev/flutter/dart-isolate/Isolate/run.html).
{{site.alert.end}}

The compute method requires 2 arguments:
A callback function, which will be called on the new isolate. This callback must be callable with exactly one argument.
Data that will be passed to the callback when it is run.
When compute resolves, it returns the return value of the callback. 

For example, consider this method that loads a massive JSON blob from a file, 
and converts that JSON into custom Dart objects. If the `jsonDecode` process 
wasn’t off loaded to a new isolate, this method would cause the UI to become 
unresponsive for several seconds on many devices.

```dart
// The JSON file is ~20MB, and produces a list of 211,640 photo objects.
Future<List<Photo>> getPhotos() async {
  String jsonString = await rootBundle.loadString('assets/photos.json');

  final List<dynamic> photoData = await compute<String, dynamic>(jsonDecode, jsonString);

  final photos = photoData.map((dynamic element) {
    final data = element as Map<String, dynamic>;
    return Photo.fromJson(data);
  }).toList();

  return photos;
}
```
For a complete walkthrough of using compute to parse JSON in the background, 
see [this cookbook](https://docs.flutter.dev/cookbook/networking/background-parsing).

# Using Isolates and Ports to create background workers



