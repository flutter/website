---
title: Flutter Concurrency for Swift developers
description: Leverage your Swift concurrency knowledge while learning Flutter and Dart
---

<?code-excerpt path-base="resources"?>

Both Dart and Swift support concurrent programming. 
This document is meant to help you 
understand how concurrency works in Dart, 
and how it compares to Swift, 
so that you can create high-performing iOS apps. 

When developing an application for the Apple ecosystem, 
you may have tasks that take a long time to complete- 
such as fetching or processing large amounts of data. 
Historically, iOS developers leveraged Grand Central Dispatch 
(GCD) to facilitate the scheduling of tasks 
using a shared thread pool. 
With GCD, developers add tasks to dispatch queues, 
and GCD decides which thread to execute them on.

However, because GCD will spin up threads to 
handle remaining work items, 
you can easily end up with a large number of threads 
and the system can become over committed 
with more threads than CPU cores. 
With Swift, the structured concurrency model changed 
to reduce the number 
of threads and context switches. 
So now, there is just one thread per core. 

Dart has a single-threaded execution model, 
with support for Isolates 
(a way to run Dart codes on another thread), an event loop, 
and asynchronous programming. 
Unless you spawn an Isolate, your Dart code runs in the 
main UI thread and is driven by an event loop. 
Flutter’s event loop is 
equivalent to the iOS main loop—that is, 
the Looper that is attached to the main thread.

Dart’s single-threaded model doesn’t mean 
you are required to run everything 
as a blocking operation that causes the UI to freeze. 
Instead, use the asynchronous 
facilities that the Dart language provides, 
such as async/await, to perform asynchronous work.

### Asynchronous Programming
Asynchronous operations allow other operations 
to execute before it completes. 
Both Dart and Swift support asynchronous functions 
using the `async` and `await` keywords. 
In both cases, `async` marks that a function 
will do asynchronous work, 
and await tells the system to await a result 
from the asynchronous function that was called- 
meaning that the function can be suspended at this point. 
For more details on asynchronous programming, 
see (Concurrency in Dart)[{{site.url}}/guides/language/concurrency].

### Leveraging the Main Thread or Isolate
For Apple operating systems, the primary– or main– 
thread is where the application begins running. 
Drawing the user interface always happens on the main thread, 
as noted above. 
One difference between Swift and Dart is that 
Swift may use different threads for different tasks, 
and it doesn’t guarantee which one will be used. 
So, when dispatching UI updates in Swift, 
you may need to ensure that work is being run on the main thread. 

Say you want to write a function that fetches the 
weather asynchronously and 
displays the results to the user. 
To perform manual dispatching to the main thread using GCD, 
you may do something like the following. First, define the `Weather` `enum`:

```swift
// 1 second delay is used in mocked api-call. 
extension UInt64 {
  static let oneSecond = UInt64(1_000_000_000)
} 

enum Weather: String {
    case rainy, sunny
}
```

Next, define the view model and mark it as `ObservableObject` 
so that it can publish its result property of type `Weather?`. 
With GCD, a `DispatchQueue` is created to 
send the work to the pool of threads:

```swift
class ContentViewModel: ObservableObject {
    @Published private(set) var result: Weather?

    private let queue = DispatchQueue(label: "weather_io_queue")
    func load() {
        // Mimic 1 sec delay.
        queue.asyncAfter(deadline: .now() + 1) { [weak self] in
            DispatchQueue.main.async {
                self?.result = .sunny
            }
        }
    }
}
```

Finally, the results are shown to the user:

```swift
struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    var body: some View {
        Text(viewModel.result?.rawValue ?? "Loading")
            .onAppear {
                viewModel.load()
        }
    }
}
```

More recently, Swift introduced actors to provide 
synchronization for a shared, mutable state. 
To ensure that work is being run on the main thread, 
it introduced the main actor. 
With these updates, you can use a view model class 
that is marked as `@MainActor`, 
and a `load()` function that internally calls an 
asynchronous function using `Task`.  

```swift
@MainActor class ContentViewModel: ObservableObject {
  @Published private(set) var result: Weather?
  
  func load() async {
    try? await Task.sleep(nanoseconds: .oneSecond)
    self.result = .sunny
  }
}
```

Next, the view model is defined as a state object using `@StateObject`, 
and the `load()` function can be called by the view model:

```swift
struct ContentView: View {
  @StateObject var viewModel = ContentViewModel()
  var body: some View {
    Text(viewModel.result?.rawValue ?? "Loading...")
      .task {
        await viewModel.load()
      }
  }
}
```
With Dart, you don’t need to worry about 
main actor because work will run on the main isolate by default.  
To recreate the same example as above, 
the first step is to create the `Weather` `enum` in dart. 

<?code-excerpt "lib/async_weather.dart (Weather)"?>
```dart
enum Weather {
  rainy,
  windy,
  sunny,
}
```

Then a simple view model, similar to what was created in SwiftUI, 
is created to fetch the weather. 
In Dart, `ObservableObject` is simply represented 
by either a `Future` or `Stream` object- 
that represents values to be provided in the future.  
So in this example you can return a `Future<Weather>` 
from a function within the view model:

<?code-excerpt "lib/async_weather.dart (HomePageViewModel)"?>
```dart
@immutable
class HomePageViewModel {
  const HomePageViewModel();
  Future<Weather> load() async {
    await Future.delayed(const Duration(seconds: 1));
    return Weather.sunny;
  }
}
```

If you look at `load()` you can see 
similarities to the Swift code. 
The function is marked as `async` because internally, 
it is using the `await` keyword.

Additionally, inside a function marked as `async`, 
you can use the return statement 
to synchronously return a value 
that is placed inside the resulting Future. 
In other words, you don't have to create a 
`Future` instance manually 
inside functions that are marked as `async`. 

The last step is to display the resulting Weather to the user. 
In Flutter, [`FutureBuilder`]({{site.flutter-api}}/flutter/widgets/FutureBuilder-class.html) and 
[`StreamBuilder`]({{site.flutter-api}}/flutter/widgets/StreamBuilder-class.html)  
widgets can be used to display the results of a Future in the UI. 
In this example, a `FutureBuilder` is used:

<?code-excerpt "lib/async_weather.dart (HomePageWidget)"?>
```dart
class HomePage extends StatelessWidget {
  final HomePageViewModel viewModel = const HomePageViewModel();
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // Feed a FutureBuilder to your widget tree.
      child: FutureBuilder<Weather>(
        // Specify the Future that you want to track.
        future: viewModel.load(),
        builder: (context, snapshot) {
          // A snapshot is of type `AsyncSnapshot` and contains the
          // state of the Future. By looking if the snapshot contains
          // an error or if the data is null, you can decide what to
          // show to the user.
          if (snapshot.hasData) {
            return Center(
              child: Text(
                snapshot.data.toString(),
              ),
            );
          } else {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
        },
      ),
    );
  }
}
```

You can see the complete (example on Github)[https://github.com/flutter/website/tree/main/examples/resources/lib/async_weather.dart].

### Leveraging Background Threads or Isolates
Flutter apps can run on a variety of multi-core hardware, 
including devices running macOS and iOS. 
To improve the performance of these applications, 
it’s sometimes necessary to run tasks 
on the different cores concurrently- 
especially to avoid blocking UI rendering 
on the main thread with long running operations. 

In Swift, you can leverage GCD to run tasks on global queues
 with different quality of service class 
 (qos) properties- which indicate the tasks’ priority. 

```swift
func parse(string: String, completion: @escaping ([String:Any]) -> Void) {
  // Mimic 1 sec delay.
  DispatchQueue(label: "data_processing_queue", qos: .userInitiated)
    .asyncAfter(deadline: .now() + 1) {
      let result: [String:Any] = ["foo": 123]
      completion(result)
    }
  }
}
```

In Dart, you can offload computation to a worker isolate, 
often called a background worker. 
A common case is spawning a simple worker isolate and 
returning the results in a message when the worker exits. 
As of Dart 2.19, `Isolate.run()` can be used to 
spawn an isolate and run some computation:

```dart
void main() async {
  // Read some data.
  final jsonData = await Isolate.run(() => jsonDecode(jsonString) as Map<String, dynamic>);`

  // Use that data.
  print('Number of JSON keys: ${jsonData.length}');
}
```

In Flutter, you are also able to use the compute function 
to spin up an isolate to run a callback function:

```dart
final jsonData = await compute(getNumberOfKeys, jsonString);

In this case, the call back function is a top-level function as shown below:
Map<String, dynamic> getNumberOfKeys(String jsonString) {
 return jsonDecode(jsonString);
}
```
