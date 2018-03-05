---
title: Flutter - 极速构建漂亮的本地应用
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
    <h1>现代化响应式框架</h1>

    <p>
    使用Flutter的现代化响应式框架和丰富的平台、布局和基础组件来构建你的用户界面。使用功能强大且灵活的API（针对 2D，动画，手势，动效等）解决复杂的用户界面设计。
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
    浏览 <a href="/widgets/">组件目录</a>
    来学习
    <a href="/widgets-intro/">响应式框架。</a>.
    </p>

</section>

<section class="homepage__interop card">
    <h1>使用平台原生功能及 SDK</h1>

    <p>
    通过平台 API，第三方 SDK 和原生代码让你的应用具有强大的扩展性。 Flutter 允许重复使用现有的 Java，Swift 和 ObjC代码，并访问 iOS 和 Android 上的原生功能和 SDK。
    </p>

    <p>
    访问平台的原生功能非常简单。 如以下是来自 <a href="https://github.com/flutter/flutter/tree/master/examples/platform_channel">平台交互 demo</a> 的代码片段：
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
    学习如何使用 <a href="/using-packages/">扩展库</a>, 或者编写
     <a href="/platform-channels/">平台通道</a>,
    来访问原生代码、API 和 SDK。
    </p>

</section>

<section class="homepage__features card">
    <h1>统一应用开发</h1>

    <p>
    Flutter 的工具和库可以帮助你轻松地将自己的想法带到 iOS 和 Android 设备上。如果你没有任何移动开发经验，用 Flutter 来构建漂亮的移动应用是你不错的选择。如果你是一位经验丰富的 iOS 或 Android 开发人员，则可以使用 Flutter 作为你应用的用户界面开发工具，并充分利用现有的大部分Java、ObjC 或 Swift 代码。
    </p>

    <div class="feature-lists">

        <div class="feature-list-group">
            <h3>应用构建</h3>

            <h4>漂亮的用户界面</h4>

                <ul>
                    <li>丰富的2D 硬件加速API</li>
                    <li>响应式框架</li>
                    <li>动画和运动 API</li>
                    <li>Material 风格和 Cupertino 风格的部件</li>
                </ul>

            <h4>流畅的编程体验</h4>

            <ul>
                <li>亚秒级、保留状态的热重载</li>
                <li>IntelliJ 的 refactor、代码补齐等功能</li>
                <li>Dart 语言及其核心库</li>
                <li>依赖库管理</li>
            </ul>

            <h4>构建功能齐全的应用</h4>

            <ul>
                <li>调用平台的 API 和 SDK</li>
                <li>Maven/Java</li>
                <li>Cocoapods/ObjC/Swift</li>
            </ul>
        </div>

        <div class="feature-list-group">
            <h3>应用优化</h3>

            <h4>测试</h4>

            <ul>
                <li>单元测试</li>
                <li>集成测试</li>
                <li>设备端实时测试</li>
            </ul>

            <h4>调试</h4>

            <ul>
                <li>IDE 调试器</li>
                <li>基于 Web 的调试器</li>
                <li>async/await 的可感知</li>
                <li>实时表达式值显示</li>
            </ul>

            <h4>分析</h4>

            <ul>
                <li>时间线</li>
                <li>CPU 和 内存</li>
                <li>应用内视图</li>
            </ul>
        </div>

        <div class="feature-list-group">
            <h3>部署</h3>

            <h4>编译</h4>

            <ul>
                <li>本地 ARM 机器码</li>
                <li>消除冗余代码</li>
            </ul>

            <h4>分发</h4>

            <ul>
                <li>App Store</li>
                <li>Play Store</li>
            </ul>
        </div>

    </div>

    <p>
    通过学习 <a href="/technical-overview/">技术概览</a> 来了解 Flutter 为什么如此特殊。
    </p>
</section>

<section class="homepage__try_flutter card">

    <div class="homepage__try_today">现在就来体验 Flutter，轻松入门。</div>

    <div class="homepage__button_row">
    <a href="/get-started/install/" class="get-started-button">开始</a>
    </div>

</section>

