---
title: Flutter - Beautiful native apps in record time
layout: page
homepage: true
hide_title: true
---

<div class="homepage__illustration">
    <h1 class="homepage__illustration--text">
        <span>Flutter Beta 2 now available!</span>
        &nbsp;
        <a href="https://medium.com/flutter-io/https-medium-com-flutter-io-announcing-flutters-beta-2-c85ba1557d5e">Learn More</a>.
    </h1>
    <img src="images/homepage/header-illustration.png" 
         class="homepage__illustration--image"
         alt="Illustration with a mobile phone, a pencil, and an abstract drawing of widgets.">
</div>

<section class="homepage__key_points card">
    <h1 class="homepage__title">
        Build beautiful native apps in&nbsp;record&nbsp;time
    </h1>

    <div class="homepage__tagline">
    Flutter is Google’s mobile UI framework
    for crafting high-quality native interfaces
    on iOS and Android in record time. Flutter works with existing code,
    is used by developers and organizations around the world,
    and is free and open source.
    </div>

    <div class="homepage__button_row">
    <a href="/get-started/install/" class="get-started-button">Get Started</a>
    </div>

    <div class="key-points">

        <div class="homepage__key_point">
            <div class="homepage__key_point_title">Fast Development</div>

            <p>
            Hot Reload in milliseconds to paint your app to life. 
            Use a rich set of fully-customizable widgets to build native interfaces in minutes. 
            </p>
        </div>

        <div class="homepage__key_point">
            <div class="homepage__key_point_title">Expressive and Flexible UI</div>

            <p>
            Quickly ship features with a focus on native end-user experiences. 
            Layered architecture allows full customization, 
            which results in incredibly fast rendering and expressive and flexible designs.
            </p>
        </div>

        <div class="homepage__key_point">
            <div class="homepage__key_point_title">Native Performance</div>

            <p>
            Flutter’s widgets incorporate all critical platform differences such as scrolling, navigation, icons and fonts to provide full native performance on both iOS and Android.
            </p>
        </div>

    </div>
</section>

<section class="homepage__hot_reload card">
    <h1>Fast development</h1>

    <p>
        Flutter's <em>hot reload</em> helps you quickly
        and easily experiment, build UIs, add features, and fix
        bugs faster. Experience sub-second reload times,
        without losing state, on
        emulators, simulators, and hardware for iOS
        and Android.
    </p>

    <div class="hot-reload-gif-container">
        <img src="/images/intellij/hot-reload.gif" class="hot-reload-gif" alt="Make a change in your code, and your app is changed instantly.">
    </div>
</section>

<section class="homepage__beautiful_uis card ">
    <h1>Expressive, beautiful UIs</h1>

    <p>
    Delight your users with Flutter's built-in
    beautiful Material Design and
    Cupertino (iOS-flavor) widgets, rich motion APIs,
    smooth natural scrolling, and platform awareness.
    </p>

    <div class="screenshot-list">
        <img class="screenshot" src="/images/homepage/screenshot-1.png" width="270" height="480" alt="Brand-first shopping design">
        <img class="screenshot" src="/images/homepage/screenshot-2.png" width="270" height="480" alt="Fitness app design">
        <img class="screenshot" src="/images/homepage/screenshot-3.png" width="270" height="480" alt="Contact app design">
        <img class="screenshot" src="/images/homepage/ios-friendlychat.png" width="270" height="480" alt="iOS chat app design">
    </div>

    <p>
    Browse the <a href="/widgets/">widget catalog</a>.
    </p>
</section>

<section class="homepage__reactive_framework card">
    <h1>Modern, reactive framework</h1>

    <p>
    Easily compose your UI with Flutter's
    modern reactive framework and
    rich set of platform, layout, and foundation widgets.
    Solve your tough UI challenges with
    powerful and flexible APIs for 2D, animation, gestures,
    effects, and more.
    </p>

{% prettify dart %}
class CounterState extends State<Counter> {
  int counter = 0;

  void increment() {
    // Tells the Flutter framework that state has changed,
    // so the framework can run build() and update the display.
    setState(() {
      counter++;
    });
  }

  Widget build(BuildContext context) {
    // This method is rerun every time setState is called.
    // The Flutter framework has been optimized to make rerunning
    // build methods fast, so that you can just rebuild anything that
    // needs updating rather than having to individually change
    // instances of widgets.
    return new Row(
      children: <Widget>[
        new RaisedButton(
          onPressed: increment,
          child: new Text('Increment'),
        ),
        new Text('Count: $counter'),
      ],
    );
  }
}
{% endprettify %}

    <p>
    Browse the <a href="/widgets/">widget catalog</a>
    and learn more about the
    <a href="/widgets-intro/">reactive framework</a>.
    </p>

</section>

<section class="homepage__interop card">
    <h1>Access native features and SDKs</h1>

    <p>
    Make your app come to life
    with platform APIs, 3rd party SDKs,
    and native code.
    Flutter lets you reuse your existing Java, Swift, and ObjC code,
    and access native features and SDKs on iOS and Android.
    </p>

    <p>
    Accessing platform features is easy. Here is a snippet from our <a href="https://github.com/flutter/flutter/tree/master/examples/platform_channel">interop example</a>:
    </p>

{% prettify dart %}
Future<Null> getBatteryLevel() async {
  var batteryLevel = 'unknown';
  try {
    int result = await methodChannel.invokeMethod('getBatteryLevel');
    batteryLevel = 'Battery level: $result%';
  } on PlatformException {
    batteryLevel = 'Failed to get battery level.';
  }
  setState(() {
    _batteryLevel = batteryLevel;
  });
}
{% endprettify %}

    <p>
    Learn how to use <a href="/using-packages/">packages</a>, or 
    write <a href="/platform-channels/">platform channels</a>,
    to access native code, APIs, and SDKs.
    </p>

</section>

<section class="homepage__features card">
    <h1>Unified app development</h1>

    <p>
    Flutter has the tools and libraries to help you easily
    bring your ideas to life on iOS and Android.
    If you don't have any mobile development experience, Flutter
    is an easy and fast way to build beautiful mobile apps.
    If you are an experienced iOS or Android developer,
    you can use Flutter for your views and leverage much of your
    existing Java/ObjC/Swift investment.
    </p>

    <div class="feature-lists">

        <div class="feature-list-group">
            <h3>Build</h3>

            <h4>Beautiful app UIs</h4>

                <ul>
                    <li>Rich 2D GPU-accelerated APIs</li>
                    <li>Reactive framework</li>
                    <li>Animation/motion APIs</li>
                    <li>Material Components and Cupertino widgets</li>
                </ul>

            <h4>Fluid coding experience</h4>

            <ul>
                <li>Sub-second, stateful hot reload</li>
                <li>IntelliJ: refactor, code completion, etc</li>
                <li>Dart language and core libs</li>
                <li>Package manager</li>
            </ul>

            <h4>Full-features apps</h4>

            <ul>
                <li>Interop with mobile OS APIs &amp; SDKs</li>
                <li>Maven/Java</li>
                <li>Cocoapods/ObjC/Swift</li>
            </ul>
        </div>

        <div class="feature-list-group">
            <h3>Optimize</h3>

            <h4>Test</h4>

            <ul>
                <li>Unit testing</li>
                <li>Integration testing</li>
                <li>On-device testing</li>
            </ul>

            <h4>Debug</h4>

            <ul>
                <li>IDE debugger</li>
                <li>Web-based debugger</li>
                <li>async/await aware</li>
                <li>Expression evaluator</li>
            </ul>

            <h4>Profile</h4>

            <ul>
                <li>Timeline</li>
                <li>CPU and memory</li>
                <li>In-app perf charts</li>
            </ul>
        </div>

        <div class="feature-list-group">
            <h3>Deploy</h3>

            <h4>Compile</h4>

            <ul>
                <li>Native ARM code</li>
                <li>Dead code elimination</li>
            </ul>

            <h4>Distribution</h4>

            <ul>
                <li>App Store</li>
                <li>Play Store</li>
            </ul>
        </div>

    </div>

    <p>
    Learn more about what makes Flutter special in the
    <a href="/technical-overview/">technical overview</a>.
    </p>
</section>

<section class="homepage__try_flutter card">

    <div class="homepage__try_today">Try Flutter today. Getting started is easy.</div>

    <div class="homepage__button_row">
    <a href="/get-started/install/" class="get-started-button">Get Started</a>
    </div>

</section>

