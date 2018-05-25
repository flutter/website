---
layout: page
title: 测试 Flutter 应用
permalink: /testing/
---

* TOC
{:toc}

## 介绍

应用的功能特性越多手动测试的难度就越大。一套好的自动化测试将帮助您确保您的应用程序在发布之前正确执行，同时保留您的特性和 bug 修复速度。 

自动化测试有很多种，总结如下：

- _单元测试_测试单个函数，方法或类。单元测试下的外部依赖通常使用例如  [`package:mockito`](https://github.com/fibulwinter/dart-mockito/blob/master/README.md)。
  单元测试一般不读/写到磁盘，渲染到屏幕上，并且不从运行测试的进程之外接收用户操作。单元测试的目标是在各种条件下验证逻辑单元的正确性。
- _widget 测试_(在其他的 UI 框架里也叫  _组件测试_) 测试单个控件。 测试控件涉及多个类，需要一个测试环境，该环境提供适当的控件生命周期上下文。例如，它应该能够接收和响应用户操作和事件，执行布局，并实例化子控件。 因此，控件测试比单元测试更全面。但是，就像单元测试一样，控件测试的环境被一个比成熟的 UI 系统更简单的实现所替代。控件测试的目标是为了确保控件的 UI 外观和交互符合预期。
- [_集成测试_](https://en.wikipedia.org/wiki/Integration_testing)测试一个完整的应用或应用的一个部分。一般情况下，_集成测试_ 运行在真机或模拟器上，比如 iOS 模拟器或 Android 模拟器。测试中的应用程序通常是从测试驱动程序代码中分离出来的，以避免产生偏差。集成测试的目标是验证整个应用程序的功能是否正确，所有的控件都是按照预期的方式集成在一起的。您也可以使用集成测试来验证应用程序的性能。

这里有一个表总结了在选择不同类型的测试之间的权衡:

{: .flutter-table}

|                      | Unit   | Widget | Integration |
|----------------------|--------|--------|-------------|
| **Confidence**       | Low    | Higher | Highest     |
| **Maintenance cost** | Low    | Higher | Highest     |
| **Dependencies**     | Few    | More   | Lots        |
| **Execution speed**  | Quick  | Slower | Slowest     |
|                      |        |        |             |

**提示**: 根据经验，一个经过良好测试的应用程序有大量的单元测试和控件测试。通过 [code coverage](https://en.wikipedia.org/wiki/Code_coverage) 追踪，大量的集成测试涵盖了所有重要的使用场景。


## 单元测试

有些 Flutter 库，比如 `dart:ui`,在使用默认 Dart SDK 的独立 Dart VM 中不可用。`flutter test` 命令可以让您在本地的 Dart 虚拟机中运行您的测试，而不需要提供这些库的无头版本 Flutter 引擎。使用这个命令可以运行任何测试，无论是否依赖 Flutter 库。

使用 `package:test` 编写一个 Flutter 单元测试。`package:test`使用文档在 [这里](https://github.com/dart-lang/test/blob/master/README.md).

例:

添加文件到 `test/unit_test.dart`:

{% prettify dart %}
import 'package:test/test.dart';

void main() {
  test('my first unit test', () {
    /**highlight*/var answer = 42;/*-highlight*/
    expect(answer, 42);
  });
}
{% endprettify %}

另外，您必须将以下代码块添加到 `pubspec.yaml`:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
```

（即使您的测试没有显示导入`flutter_test`也需要加上，因为测试框架本身在后台使用了它。)

要运行调试， 从工程目录（不是 `test` 子目录）运行 `flutter test test/unit_test.dart` 。

要运行所有测试，从工程目录运行  `flutter test`。


## Widget 测试

您可以通过与单元测试类似的方式实现控件测试。 在测试中执行与控件的交互，使用 Flutter 提供的工具[`WidgetTester`](https://docs.flutter.io/flutter/flutter_test/WidgetTester-class.html)
例如，您可以发动轻击和滑动手势。您也可以使用
[`WidgetTester`](https://docs.flutter.io/flutter/flutter_test/WidgetTester-class.html)
来获取控件树中的子控件，读取文本，以及校验控件的属性值是否正确。

例:

添加文件到 `test/widget_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('my first widget test', (WidgetTester tester) async {
    // You can use keys to locate the widget you need to test
    var sliderKey = new UniqueKey();
    var value = 0.0;

    // Tells the tester to build a UI based on the widget tree passed to it
    await tester.pumpWidget(
      new StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return new MaterialApp(
            home: new Material(
              child: new Center(
                child: new Slider(
                  key: sliderKey,
                  value: value,
                  onChanged: (double newValue) {
                    setState(() {
                      value = newValue;
                    });
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
    expect(value, equals(0.0));

    // Taps on the widget found by key
    await tester.tap(find.byKey(sliderKey));

    // Verifies that the widget updated the value correctly
    expect(value, equals(0.5));
  });
}
```

运行 `flutter test test/widget_test.dart`.

查看 [`package:flutter_test` API 获取所有控件测试可用的工具。

您可以使用[`debugDumpApp()`](https://docs.flutter.io/flutter/widgets/debugDumpApp.html) 函数来可视化测试 UI 状态或仅仅使用 `flutter run test/widget_test.dart` 将测试程序运行在模拟器或真机等目标运行环境中来辅助调试。在控件测试 `flutter run` 会话中，您可以交互地轻触部分屏幕来打印建议的 [`Finder`](https://docs.flutter.io/flutter/flutter_test/CommonFinders-class.html).


## 集成测试

集成测试也用`package:test`来编写。一个完整的测试是一对 — 一个测试脚本和一个接收测试命令的 Flutter 应用程序。与单元测试和控件测试不同，集成测试不能与被测应用运行在相同进程。反而，被测应用是运行在_真是设备_或_模拟器_（例如 Android 模拟器或 iOS 模拟器）。测试脚本运行在您的电脑上。它和应用连接并发出不同的命令来执行不同的用户行为。这就是所谓的  “driving”  应用程序。Flutter 提供了工具和 API ，统称为 _Flutter Driver_，来实现这一点。

> 如果您熟悉  Selenium/WebDriver (web), Espresso (Android)  和  UI Automation (iOS), 那么  Flutter Driver 就是 Flutter 中这些集成测试工具的等价物。另外， Flutter Driver 提供了记录测试执行的性能跟踪 API (又名 _时间轴_)。

Flutter Driver 是:

* 一个命令行工具 `flutter drive`
* 一个包 `package:flutter_driver` ([API](https://docs.flutter.io/flutter/flutter_driver/FlutterDriver-class.html))

两者在一起可以让您:

* 为集成测试创建指令化应用程序
* 编写一个测试
* 运行测试

### 添加 flutter_driver 依赖

要使用 `flutter_driver`, 您必须添加下面代码块到 `pubspec.yaml`:

```yaml
dev_dependencies:
  flutter_driver:
    sdk: flutter
```

### 创建指令化 Flutter 应用

一个指令化应用是一个 Flutter  应用启用了 Flutter Driver _拓展_。要启用拓展请调用`enableFlutterDriverExtension()`.

例:

我们假设您有一个入口在`my_app/lib/main.dart`的应用程序。要创建它的指令化版本，在`my_app/test_driver/`下创建一个 Dart 文件。基于您在测试的功能来命名；接下来定位到 my_app/test_driver/ 中的`user_list_scrolling.dart` :

```dart
// This line imports the extension
import 'package:flutter_driver/driver_extension.dart';

void main() {
  // This line enables the extension
  enableFlutterDriverExtension();

  // Call the `main()` of your app or call `runApp` with whatever widget
  // you are interested in testing.
}
```

### 编写集成测试

一个集成测试是一个简单的`package:test`，它使用 Flutter Driver API 告诉应用执行什么操作然后验证程序是否执行了操作。 

例：:

为了增加趣味性我们也让测试记录下性能时间轴，在`my_app/test_driver/`中创建测试文件 `user_list_scrolling_test.dart`:

```dart
import 'dart:async';

// Imports the Flutter Driver API
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('scrolling performance test', () {
    FlutterDriver driver;

    setUpAll(() async {
      // Connects to the app
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        // Closes the connection
        driver.close();
      }
    });

    test('measure', () async {
      // Record the performance timeline of things that happen inside the closure
      Timeline timeline = await driver.traceAction(() async {
        // Find the scrollable user list
        SerializableFinder userList = find.byValueKey('user-list');

        // Scroll down 5 times
        for (int i = 0; i < 5; i++) {
          // Scroll 300 pixels down, for 300 millis
          await driver.scroll(
              userList, 0.0, -300.0, new Duration(milliseconds: 300));

          // Emulate a user's finger taking its time to go back to the original
          // position before the next scroll
          await new Future<Null>.delayed(new Duration(milliseconds: 500));
        }

        // Scroll up 5 times
        for (int i = 0; i < 5; i++) {
          await driver.scroll(
              userList, 0.0, 300.0, new Duration(milliseconds: 300));
          await new Future<Null>.delayed(new Duration(milliseconds: 500));
        }
      });

      // The `timeline` object contains all the performance data recorded during
      // the scrolling session. It can be digested into a handful of useful
      // aggregate numbers, such as "average frame build time".
      TimelineSummary summary = new TimelineSummary.summarize(timeline);
      summary.writeSummaryToFile('stocks_scroll_perf', pretty: true);
      summary.writeTimelineToFile('stocks_scroll_perf', pretty: true);
    });
  });
}
```

### 运行集成测试

要在 Android 设备上运行测试，通过 USB 连接设备到您的电脑并打开 USB 调试。然后运行下面的命令：

```
flutter drive --target=my_app/test_driver/user_list_scrolling.dart
```

此命令会:

* 构建 `--target` 应用并安装到设备上
* 启动应用
* 运行 `my_app/test_driver/` 目录下的 `user_list_scrolling_test.dart` 测试

您可能想知道该命令是如何找到正确的测试文件的。`flutter drive` 命令使用一种约定来查找与 `--target` 应用程序在同一目录中具有相同文件名但是具有 `_test` 后缀的测试文件。
