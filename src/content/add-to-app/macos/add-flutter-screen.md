---
title: Add a Flutter screen to an macOS app
shortTitle: Add a Flutter screen
description: Learn how to add a single Flutter screen to your existing macOS app.
---

This guide describes how to add a single Flutter screen to an existing macOS app.

## Start a FlutterEngine and FlutterViewController

To launch a Flutter screen from an existing macOS app, you start a
[`FlutterEngine`][] and a [`FlutterViewController`][].

:::note
The `FlutterEngine` serves as a host to the Dart VM and your Flutter runtime,
and the `FlutterViewController` attaches to a `FlutterEngine` to pass
input events into Flutter and to display frames rendered by the
`FlutterEngine`.
:::

The `FlutterEngine` might have the same lifespan as your
`FlutterViewController` or outlive your `FlutterViewController`.

:::tip
It's generally recommended to pre-warm a long-lived
`FlutterEngine` for your application because:

* The first frame appears faster when showing the `FlutterViewController`.
* Your Flutter and Dart state will outlive one `FlutterViewController`.
* Your application and your plugins can interact with Flutter and your Dart
  logic before showing the UI.
:::

See [Loading sequence and performance][]
for more analysis on the latency and memory
trade-offs of pre-warming an engine.

### Create a FlutterEngine

Where you create a `FlutterEngine` depends on your host app.

<Tabs key="macos-framework">
<Tab name="SwiftUI">

In this example, we create a `FlutterEngine` object inside a SwiftUI [`Observable`][]
object called `FlutterDependencies`.
Pre-warm the engine by calling `run()`, and then inject this object
into a `ContentView` using the `environment()` view modifier.

 ```swift title="MyApp.swift"
import SwiftUI
import FlutterMacOS
// The following library connects plugins with macOS platform code to this app.
import FlutterPluginRegistrant

@Observable
class FlutterDependencies {
  let flutterEngine = FlutterEngine(name: "my flutter engine", project: nil)
  init() {
    // Runs the default Dart entrypoint with a default Flutter route.
    flutterEngine.run(withEntrypoint: nil)
    // Connects plugins with macOS platform code to this app.
    RegisterGeneratedPlugins(registry: self.flutterEngine)
  }
}

@main
struct MyApp: App {
    // flutterDependencies will be injected through the view environment.
    @State var flutterDependencies = FlutterDependencies()
    var body: some Scene {
      WindowGroup {
        ContentView()
          .environment(flutterDependencies)
      }
    }
}
```

</Tab>
<Tab name="AppKit-Swift">

As an example, we demonstrate creating a
`FlutterEngine`, exposed as a property, on app startup in
the app delegate.

```swift title="AppDelegate.swift"
import Cocoa
import FlutterMacOS
// The following library connects plugins with macOS platform code to this app.
import FlutterPluginRegistrant

@main
class AppDelegate: FlutterAppDelegate {
  lazy var flutterEngine = FlutterEngine(name: "my flutter engine", project: nil)

  override func applicationDidFinishLaunching(_ aNotification: Notification) {
    flutterEngine.run(withEntrypoint: nil)
    RegisterGeneratedPlugins(registry: self.flutterEngine)
  }
}
```

</Tab>
</Tabs>

### Show a FlutterViewController with your FlutterEngine

<Tabs key="macos-framework">
<Tab name="SwiftUI">

The following example shows a generic `ContentView` with a
[`NavigationLink`][] hooked to a flutter screen.
First, create a `FlutterViewControllerRepresentable` to represent the
`FlutterViewController`. The `FlutterViewController` constructor takes
the pre-warmed `FlutterEngine` as an argument, which is injected through
the view environment.

```swift title="ContentView.swift"
import SwiftUI
import FlutterMacOS

struct FlutterViewControllerRepresentable: NSViewControllerRepresentable {
  // Flutter dependencies are passed in through the view environment.
  @Environment(FlutterDependencies.self) var flutterDependencies

  func makeNSViewController(context: Context) -> FlutterViewController {
    return FlutterViewController(
      engine: flutterDependencies.flutterEngine,
      nibName: nil,
      bundle: nil
    )
  }

  func updateNSViewController(_ nsViewController: FlutterViewController, context: Context) {}
}

struct ContentView: View {
  var body: some View {
    NavigationStack {
      NavigationLink("My Flutter Feature") {
        FlutterViewControllerRepresentable()
      }
    }
  }
}
```

Now, you have a Flutter screen embedded in your macOS app.

:::note
In this example, your Dart `main()` entrypoint function runs
when the `FlutterDependencies` observable is initialized.
:::

</Tab>
<Tab name="AppKit-Swift">

The following example shows a generic `ViewController` with a
`NSButton` hooked to present a [`FlutterViewController`][].
The `FlutterViewController` uses the `FlutterEngine` instance
created in the `AppDelegate`.

```swift title="ViewController.swift"
import Cocoa
import FlutterMacOS

class ViewController: NSViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    // Make a button to call the showFlutter function when pressed.
    let button =  NSButton(title: "Show Flutter!", target: self, action: #selector(showFlutter))
    button.frame = CGRect(x: 202, y: 187, width: 160.0, height: 40.0)
    self.view.addSubview(button)
  }

  @objc func showFlutter() {
    let flutterEngine = (NSApplication.shared.delegate as! AppDelegate).flutterEngine
    let flutterViewController =
        FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
    self.addChild(flutterViewController)
    flutterViewController.view.frame = self.view.bounds
    presentAsModalWindow(flutterViewController)
  }
}
```

Now, you have a Flutter screen embedded in your macOS app.

:::note
Using the previous example, the default `main()`
entrypoint function of your default Dart library
would run when calling `run` on the
`FlutterEngine` created in the `AppDelegate`.
:::

</Tab>
</Tabs>

### _Alternatively_ - Create a FlutterViewController with an implicit FlutterEngine

As an alternative to the previous example, you can let the
`FlutterViewController` implicitly create its own `FlutterEngine` without
pre-warming one ahead of time.

This is not usually recommended because creating a
`FlutterEngine` on-demand could introduce a noticeable
latency between when the `FlutterViewController` is
presented and when it renders its first frame. This could, however, be
useful if the Flutter screen is rarely shown, when there are no good
heuristics to determine when the Dart VM should be started, and when Flutter
doesn't need to persist state between view controllers.

To let the `FlutterViewController` present without an existing
`FlutterEngine`, omit the `FlutterEngine` construction, and create the
`FlutterViewController` without an engine reference.

<Tabs key="macos-framework">
<Tab name="SwiftUI">

```swift title="ContentView.swift"
// Existing code omitted.
func makeNSViewController(context: Context) -> FlutterViewController {
  return FlutterViewController()
}
```

</Tab>
<Tab name="AppKit-Swift">

```swift title="ViewController.swift"
// Existing code omitted.
func showFlutter() {
  let flutterViewController = FlutterViewController()
  self.addChild(flutterViewController)
  flutterViewController.view.frame = self.view.bounds
  presentAsModalWindow(flutterViewController)
}
```

</Tab>
</Tabs>

See [Loading sequence and performance][]
for more explorations on latency and memory usage.

## Using the FlutterAppDelegate

Letting your application's `UIApplicationDelegate` subclass
`FlutterAppDelegate` is recommended but not required.

The `FlutterAppDelegate` performs functions such as:

* Forwarding application callbacks such as [`openURLs`][]
  to plugins such as [google_sign_in][].

### Creating a FlutterAppDelegate subclass
Creating a subclass of the `FlutterAppDelegate` in UIKit apps was shown
in the [Start a FlutterEngine and FlutterViewController section][].
In a SwiftUI app, you can create a subclass of the
`FlutterAppDelegate` and annotate it with the [`Observable()`][] macro as follows:

```swift title="MyApp.swift"
import SwiftUI
import FlutterMacOS

@Observable
class AppDelegate: FlutterAppDelegate {
  let flutterEngine = FlutterEngine(name: "my flutter engine", project: nil)

  override func applicationDidFinishLaunching(_ aNotification: Notification) {
    // Runs the default Dart entrypoint with a default Flutter route.
    flutterEngine.run(withEntrypoint: nil)
    // Used to connect plugins (only if you have plugins with macOS platform code).
    RegisterGeneratedPlugins(registry: self.flutterEngine)
  }
}

@main
struct MyApp: App {
  // Use this property wrapper to tell SwiftUI
  // it should use the AppDelegate class for the application delegate
  @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
```

Then, in your view, the `AppDelegate` is accessible through the view environment.

```swift title="ContentView.swift"
import SwiftUI
import FlutterMacOS

struct FlutterViewControllerRepresentable: NSViewControllerRepresentable {
  // Access the AppDelegate through the view environment.
  @Environment(AppDelegate.self) var appDelegate

  func makeNSViewController(context: Context) -> FlutterViewController {
    return FlutterViewController(
      engine: appDelegate.flutterEngine,
      nibName: nil,
      bundle: nil
    )
  }

  func updateNSViewController(_ nsViewController: FlutterViewController, context: Context) {}
}

struct ContentView: View {
  var body: some View {
    NavigationStack {
      NavigationLink("My Flutter Feature") {
        FlutterViewControllerRepresentable()
      }
    }
  }
}
```

[`FlutterEngine`]: {{site.api}}/macos-embedder/interface_flutter_engine.html
[`FlutterViewController`]: {{site.api}}/macos-embedder/interface_flutter_view_controller.html
[Loading sequence and performance]: /add-to-app/performance
[google_sign_in]: {{site.pub}}/packages/google_sign_in
[`openURLs`]: {{site.apple-dev}}/documentation/appkit/nsapplicationdelegate/application(_:open:)
[Start a FlutterEngine and FlutterViewController section]:/add-to-app/macos/add-flutter-screen/#start-a-flutterengine-and-flutterviewcontroller
[`Observable`]: {{site.apple-dev}}/documentation/observation/observable
[`NavigationLink`]: {{site.apple-dev}}/documentation/swiftui/navigationlink
[`Observable()`]: {{site.apple-dev}}/documentation/observation/observable()
