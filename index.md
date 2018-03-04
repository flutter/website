---
title: Flutter - Beautiful native apps in record time
layout: page
homepage: true
hide_title: true
---

<div class="homepage__illustration">
    <h1 class="homepage__illustration--text">
        <span>Flutter Beta 版已发布!</span>
        &nbsp;
        <a href="https://medium.com/flutter-io/announcing-flutter-beta-1-build-beautiful-native-apps-dc142aea74c0">了解更多</a>.
    </h1>
    <img src="images/homepage/header-illustration.png" 
         class="homepage__illustration--image"
         alt="Illustration with a mobile phone, a pencil, and an abstract drawing of widgets.">
</div>

<section class="homepage__key_points card">
    <h1 class="homepage__title">
        以极短的时间构建优雅的原生级应用
    </h1>

    <div class="homepage__tagline">
    Flutter 是谷歌的移动端 UI 框架，可在极短的时间内构建 Android 和 iOS 上高质量的原生级应用。 Flutter 可与现有代码一起工作, 它被世界各地的开发者和组织使用, 并且 Flutter 是免费和开源的.
    </div>

    <div class="homepage__button_row">
    <a href="/get-started/install/" class="get-started-button">开始</a>
    </div>

    <div class="key-points">

        <div class="homepage__key_point">
            <div class="homepage__key_point_title">快速开发</div>

            <p>
            程序的热重载可以在瞬间完成，让应用在生命周期内得到重绘。丰富且完全可定制的部件可以让你在几分钟内构建原生级界面。
            </p>
        </div>

        <div class="homepage__key_point">
            <div class="homepage__key_point_title">极具表现力和灵活性的 UI</div>

            <p>
            Flutter 能够快速发布专注于终端用户体验的功能。其分层架构允许完全自定义，从而实现快速渲染和极具表现力与灵活性的设计。
            </p>
        </div>

        <div class="homepage__key_point">
            <div class="homepage__key_point_title">本地化表现</div>

            <p>
            Flutter 的部件包含所有重要的平台差异，如滚动，导航，图标和字体，以在 iOS 和 Android 上提供完整的 UI 本地化表现。
            </p>
        </div>

    </div>
</section>

<section class="homepage__hot_reload card">
    <h1>快速开发</h1>

    <p>
        Flutter 的热重载 可帮助您快速轻松地试验，构建 UI，添加功能和快速地修复错误。在 iOS 和 Android 的模拟器与硬件上体验亚秒级重载的同时不会丢失状态。
    </p>

    <div class="hot-reload-gif-container">
        <img src="/images/intellij/hot-reload.gif" class="hot-reload-gif" alt="Make a change in your code, and your app is changed instantly.">
    </div>
</section>

<section class="homepage__beautiful_uis card ">
    <h1>极具表现力和美观 UI</h1>

    <p>
    使用 Flutter 内置的 Material Design 和 Cupertino（iOS 风格）的部件、丰富的手势 API、自然平滑的滑动和不同的平台表现来提升用户体验。
    </p>

    <div class="screenshot-list">
        <img class="screenshot" src="/images/homepage/screenshot-1.png" width="270" height="480" alt="Brand-first shopping design">
        <img class="screenshot" src="/images/homepage/screenshot-2.png" width="270" height="480" alt="Fitness app design">
        <img class="screenshot" src="/images/homepage/screenshot-3.png" width="270" height="480" alt="Contact app design">
        <img class="screenshot" src="/images/homepage/ios-friendlychat.png" width="270" height="480" alt="iOS chat app design">
    </div>

    <p>
    浏览 <a href="/widgets/">部件目录</a>.
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

