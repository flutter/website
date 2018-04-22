---
layout: page
title: 使用平台通道编写平台特定代码
permalink: /platform-channels/
---

本教程介绍了怎样编写平台特定代码。一些平台特定的功能在已存在的扩展包可以直接使用；请参阅 [using packages](/using-packages/).

* TOC
{:toc}

Flutter 使用了一个灵活的系统允许你调用平台特定的接口，无论在 Android 上使用 Java 或 Kotlin, 在 iOS 上使用 ObjectiveC 或 Swift 代码都可以.

Flutter 对于平台特定接口的支持不依赖代码生成，而是基于灵活的消息传递的方式：

* 应用程序的 Flutter 部分通过平台通道向其*主机*、应用程序的iOS或Android部分发送消息.

* *宿主*监听平台通道，并接受消息。然后调用任意数量的平台特定接口 -- 使用原生编程语言 -- 并将响应发送回*客户端*，即应用的 Flutter 部分。

## 结构概述：平台通道 {#architecture}

使用平台通道在客户端（UI）和宿主（平台）之间传递消息，如图所示：

![Platform channels architecture](/images/PlatformChannels.png)

为了让用户界面保持响应，消息和响应被异步传递。

在客户端这端，`MethodChannel` ([API][MethodChannel]) 可以发送与方法调用相对应的消息。在平台端，`MethodChannel` 在 Android ([API][MethodChannelAndroid]) 和 iOS
([API][MethodChanneliOS]) 上能够接收方法调用并返回结果。这些类允许你通过很少的'样板'代码开发平台插件。

*注意*：必要时，方法调用也可以反方向调用，平台作为客户端通过 Dart 实现方法。具体的例子在这里 [`quick_actions`](https://pub.dartlang.org/packages/quick_actions) 插件.

[MethodChannel]: https://docs.flutter.io/flutter/services/MethodChannel-class.html
[MethodChannelAndroid]: https://docs.flutter.io/javadoc/io/flutter/plugin/common/MethodChannel.html
[MethodChanneliOS]: https://docs.flutter.io/objcdoc/Classes/FlutterMethodChannel.html

### 平台通道支持的数据类型和编解码器 {#codec}

标准平台通道使用一个标准的消息编解码器。简单的JSON类值（如布尔值）的高效二进制序列化，数字、字符串、字节缓冲区以及这些列表和映射。(查看细节
[`StandardMessageCodec`](https://docs.flutter.io/flutter/services/StandardMessageCodec-class.html))。这些值的序列化和反序列化在消息发送和接收值时自动发生。

下表展示了如何在平台上接收的 Dart 值，反之亦然：

| Dart        | Android             | iOS                        
|-------------|---------------------|----
| null        | null                | nil (NSNull when nested)
| bool        | java.lang.Boolean   | NSNumber numberWithBool:
| int         | java.lang.Integer   | NSNumber numberWithInt:
| int, if 32 bits not enough | java.lang.Long       | NSNumber numberWithLong:
| int, if 64 bits not enough | java.math.BigInteger | FlutterStandardBigInteger
| double      | java.lang.Double    | NSNumber numberWithDouble:
| String      | java.lang.String    | NSString
| Uint8List   | byte[]   | FlutterStandardTypedData typedDataWithBytes:
| Int32List   | int[]    | FlutterStandardTypedData typedDataWithInt32:
| Int64List   | long[]   | FlutterStandardTypedData typedDataWithInt64:
| Float64List | double[] | FlutterStandardTypedData typedDataWithFloat64:
| List        | java.util.ArrayList | NSArray
| Map         | java.util.HashMap   | NSDictionary

<br>
## 示例: 使用平台通道调用平台特定的 iOS 和 Android 代码 {#example}

以下说明了怎么调用平台特定的接口来取得并显示当前的电池电量。通过单独的一个的平台消息，使用 Android `BatteryManager` 接口，和 iOS `device.batteryLevel` 接口。

示例在主应用中添加了平台特定代码。如果你想在多个应用程序中重用平台代码，创建工程的步骤略有不同 (请参阅 [开发扩展包](/developing-packages/#plugin))，但是平台通道代码使用同样的方法。

*注意*：这个示例完整可运行的代码在这儿[`/examples/platform_channel/`](https://github.com/flutter/flutter/tree/master/examples/platform_channel)，该版本使用 Java  开发 Android，Objective-C 开发的 iOS。iOS 的 Swift 版本请参阅[`/examples/platform_channel_swift/`](https://github.com/flutter/flutter/tree/master/examples/platform_channel_swift).

### 步骤 1: 创建新工程 {#example-project}

开始创建新工程：

* 在终端运行: `flutter create batterylevel`

默认模板支持使用 Java 编写 Android，Objective-C 编写 iOS。想使用Kotlin 或者 Swift，使用 `-i` 与/或 `-a` 标记；

* 终端运行： `flutter create -i swift -a kotlin batterylevel`

### 步骤 2: 创建 Flutter 平台客户端 {#example-client}

应用的 `State` 类持有当前应用的状态。我们需要扩展它来持有当前的电池状态。

首先，我们构造通道。我们使用 `MethodChannel` 编写单独的平台方法并返回电池变量。

通道的客户端和宿主端通过在构造器中传入通道名来连接。所有的通道名在一个应用中必须唯一；我们推荐使用唯一的'域名前缀'给通道名加前缀，如 `samples.flutter.io/battery`。

<!-- skip -->
```dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
...
class _MyHomePageState extends State<MyHomePage> {
  static const platform = const MethodChannel('samples.flutter.io/battery');

  // Get battery level.
}
```

接下来，我们调用方法通道上的方法，指定具体方法。通过字符串标识符 `getBatteryLevel` 调用。调用也许会失败 -- 例如如果平台不支持平台接口（比如运行在模拟器上），所以我们用语句块来包装`invokeMethod` 调用。我们拿到返回结果在 `setState` 里面用 `_batteryLevel` 更新用户界面状态。

<!-- skip -->
```dart
  // Get battery level.
  String _batteryLevel = 'Unknown battery level.';

  Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
```

最后，我们把模板中的 `build` 方法替换为一个小的用户界面用字符串显示电池状态，还有一个按钮来刷新这个值。

<!-- skip -->
```dart
@override
Widget build(BuildContext context) {
  return new Material(
    child: new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new RaisedButton(
            child: new Text('Get Battery Level'),
            onPressed: _getBatteryLevel,
          ),
          new Text(_batteryLevel),
        ],
      ),
    ),
  );
}
```


### 步骤 3a: 用 Java 添加 Android 平台特定实现 {#example-java}

*注意*: 以下步骤使用 Java。如果你更喜欢 Kotlin，跳到步骤3b。

在 Android Studio 中打开 Android 宿主端：

1. 打开 Android Studio。

1. 选择菜单项 '文件 > 打开...'。

1. 导航到 Flutter 应用程序的目录，选择它里面的 `android` 文件夹。点击确定。

1. 在工程视图下打开位于 `java` 文件夹的 `MainActivity.java` 文件。

下一步，创建 `MethodChannel` 并在 `onCreate` 方法中设置 `MethodCallHandler`。确保使用了和 Flutter 客户端同样的通道名。

```java
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "samples.flutter.io/battery";

    @Override
    public void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);

        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                new MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, Result result) {
                        // TODO
                    }
                });
    }
}
```

下一步，我们添加真正的 Android Java 代码，使用 Android 电池接口取到电池电量。这些代码和你编写原生的 Android 应用一样。

首先，在文件顶部添加必要的应用：

```
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;
```

在 activity 类中 `onCreate` 的方法下面紧接着添加一个新的方法：

```java
private int getBatteryLevel() {
  int batteryLevel = -1;
  if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
    BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
    batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
  } else {
    Intent intent = new ContextWrapper(getApplicationContext()).
        registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
    batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
        intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
  }

  return batteryLevel;
}
```

最后，我们完成之前添加的 `onMethodCall` 方法。我们需要一个单一的平台方法，`getBatteryLevel`，我们在 `call` 参数中检测它。这个平台方法的实现调用了我们在之前步骤中写的 Android 代码，并在成功和错误的情况下都返回 `response` 参数。如果调用了一个未知的方法，我们会发出报告。替换：

```java
public void onMethodCall(MethodCall call, Result result) {
    // TODO
}
```

为：

```java
@Override
public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getBatteryLevel")) {
        int batteryLevel = getBatteryLevel();

        if (batteryLevel != -1) {
            result.success(batteryLevel);
        } else {
            result.error("UNAVAILABLE", "Battery level not available.", null);
        }
    } else {
        result.notImplemented();
    }
}               
```

你现在应该能够在 Android 系统上运行应用程序了。如果使用了 Android 模拟器，你可以在点击工具栏中的 `...` 按钮，在扩展控制栏设置电池电量。

### 步骤 3b: 用 Kotlin 添加 Android 特定平台实现 {#example-kotlin}

*注意*：以下步骤和步骤 3a 类似，除了用 Kotlin 代替 Java。

本步骤假设你在[步骤 1.](#example-project)中使用 `-a kotlin` 选项创建工程。

在 Android Studio 中打开 Android 宿主端：

1. 打开 Android Studio。

1. 选择菜单项 '文件 > 打开...'。

1. 导航到 Flutter 应用程序的目录，选择它里面的 `android` 文件夹。点击确定。

1. 在工程视图下打开位于 `kotlin` 文件夹下的 `MainActivity.kt` 文件。(注意：如果你正在使用 Android Studio 2.3 编辑，'kotlin' 文件夹将会显示名为 ’java'。）

下一步，创建 `MethodChannel` 并在 `onCreate` 方法中调用 `setMethodCallHandler `。确保使用了和 Flutter 客户端同样的通道名。

```kotlin
import android.os.Bundle
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity() : FlutterActivity() {
  private val CHANNEL = "samples.flutter.io/battery"

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
      // TODO
    }
  }
}
```

下一步，我们添加真正的 Android Kotlin 代码，使用 Android 电池接口取到电池电量。这些代码和你编写原生的 Android 应用一样。

首先，在文件顶部添加必要的引用：

```
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
```

在 `MainActivity` 类中 `onCreate` 的方法下面紧接着添加一个新的方法：

```kotlin
  private fun getBatteryLevel(): Int {
    val batteryLevel: Int
    if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
      val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
      batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    } else {
      val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
      batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
    }

    return batteryLevel
  }
```

最后，我们完成之前添加的 `onMethodCall` 方法。我们需要一个单一的平台方法，`getBatteryLevel`，我们在 `call` 参数中检测它。这个平台方法的实现调用了我们在之前步骤中写的 Android 代码，并在成功和错误的情况下都返回 `response` 参数。如果调用了一个未知的方法，我们会发出报告。替换：

```kotlin
    MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
      // TODO
    }
```

为:

```kotlin
    MethodChannel(flutterView, CHANNEL).setMethodCallHandler { call, result ->
      if (call.method == "getBatteryLevel") {
        val batteryLevel = getBatteryLevel()

        if (batteryLevel != -1) {
          result.success(batteryLevel)
        } else {
          result.error("UNAVAILABLE", "Battery level not available.", null)
        }
      } else {
        result.notImplemented()
      }
    }
```

你现在应该能够在 Android 系统上运行应用程序了。如果使用了 Android 模拟器，你可以在点击工具栏中的 `...` 按钮，在扩展控制栏设置电池电量。

### 步骤 4a: 用 Objective-C 添加 iOS 平台特定实现 {#example-objc}

*注意*：以下步骤使用 Objective-C。如果你更喜欢 Swift，跳到步骤4b。

在 Xcode 中打开 Flutter 应用的 iOS 宿主端：

1. 打开 Xcode

1. 选择菜单项 '文件 > 打开...'

1. 导航到 Flutter 应用程序的目录，选择它里面的 `ios` 文件夹。点击确定。

1. 确保 Xcode 工程编译没有错误。

1. 打开位于 Runner > Runner 工程目录下的文件 `AppDelegate.m`。

下一步，创建 'FlutterMethodChannel' 并在 `application
didFinishLaunchingWithOptions:` 方法中添加一个处理器。确保使用了和 Flutter 客户端同样的通道名。

```objectivec
#import <Flutter/Flutter.h>

@implementation AppDelegate
- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
  FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;

  FlutterMethodChannel* batteryChannel = [FlutterMethodChannel
                                          methodChannelWithName:@"samples.flutter.io/battery"
                                          binaryMessenger:controller];

  [batteryChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
    // TODO
  }];

  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
```

下一步，我们添加真正的 iOS ObjectiveC 代码，使用 iOS 电池接口取到电池电量。这些代码和你编写原生的 iOS 应用一样。

在 `AppDelegate` 类中，`@end` 之前接着添加一个新方法：

```objectivec
- (int)getBatteryLevel {
  UIDevice* device = UIDevice.currentDevice;
  device.batteryMonitoringEnabled = YES;
  if (device.batteryState == UIDeviceBatteryStateUnknown) {
    return -1;
  } else {
    return (int)(device.batteryLevel * 100);
  }
}
```

最后，我们完成之前添加的 `setMethodCallHandler` 方法。我们需要一个单一的平台方法，`getBatteryLevel`，我们在 `call` 参数中检测它。这个平台方法的实现调用了我们在之前步骤中写的 iOS 代码，并在成功和错误的情况下都返回 `response` 参数。如果调用了一个未知的方法，我们会发出报告。

```objectivec
[batteryChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
  if ([@"getBatteryLevel" isEqualToString:call.method]) {
    int batteryLevel = [self getBatteryLevel];

    if (batteryLevel == -1) {
      result([FlutterError errorWithCode:@"UNAVAILABLE"
                                 message:@"Battery info unavailable"
                                 details:nil]);
    } else {
      result(@(batteryLevel));
    }
  } else {
    result(FlutterMethodNotImplemented);
  }
}];
```

你现在应该能够在 iOS 系统上运行应用程序了。如果使用了 iOS 模拟器，注意它不支持电池相关接口，应用会显示 '无法获取电池信息'。

### 步骤 4b: 用 Swift 添加 iOS 平台特定实现 {#example-swift}

*注意*：以下步骤和步骤 3a 类似，除了用 Swift 代替 Objective-C。

本步骤假设你在[步骤 1.](#example-project)中使用 `-i swift` 选项创建工程。

在 Xcode 中打开 Flutter 应用的 iOS 宿主端：

1. 打开 Xcode

1. 选择菜单项 '文件 > 打开...'

1. 导航到 Flutter 应用程序的目录，选择它里面的 `ios` 文件夹。点击确定。

下一步，在使用 Objective-C 设置的标准模板中添加 Swift 支持：

1. 在工程中展开 Runner > Runner。

1. 在工程中打开位于 Runner > Runner 下的`AppDelegate.swift`。

下一步，重写 `application` 函数并创建一个 `FlutterMethodChannel` 绑定到通道 `samples.flutter.io/battery`：

```swift
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    GeneratedPluginRegistrant.register(with: self);

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController;
    let batteryChannel = FlutterMethodChannel.init(name: "samples.flutter.io/battery",
                                                   binaryMessenger: controller);
    batteryChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: FlutterResult) -> Void in
      // Handle battery messages.
    });

    return super.application(application, didFinishLaunchingWithOptions: launchOptions);
  }
}
```

下一步, 我们添加真正的 iOS Swift 代码，使用 iOS 电池接口取到电池电量。这些代码和你编写原生的 iOS 应用一样。

在 `AppDelegate.swift` 底部添加下面的新方法：

```swift
private func receiveBatteryLevel(result: FlutterResult) {
  let device = UIDevice.current;
  device.isBatteryMonitoringEnabled = true;
  if (device.batteryState == UIDeviceBatteryState.unknown) {
    result(FlutterError.init(code: "UNAVAILABLE",
                             message: "Battery info unavailable",
                             details: nil));
  } else {
    result(Int(device.batteryLevel * 100));
  }
}
```

最后，我们完成之前添加的 `setMethodCallHandler` 方法。我们需要一个单一的平台方法，`getBatteryLevel`，我们在 `call` 参数中检测它。这个平台方法的实现调用了我们在之前步骤中写的 iOS 代码，并在成功和错误的情况下都返回 `response` 参数。如果调用了一个未知的方法，我们会发出报告。

```swift
batteryChannel.setMethodCallHandler({
  (call: FlutterMethodCall, result: FlutterResult) -> Void in
  if ("getBatteryLevel" == call.method) {
    receiveBatteryLevel(result: result);
  } else {
    result(FlutterMethodNotImplemented);
  }
});
```

你现在应该能够在 iOS 系统上运行应用程序了。如果使用了 iOS 模拟器，注意它不支持电池相关接口，应用会显示 '无法获取电池信息'。

## 从 UI 代码中拆分平台特定的代码 {#separate}

如果你希望在多个 Flutter 应用中使用平台特定代码，在主应用之外的目录，把代码拆分到平台插件中非常有用。更多细节请参考 [开发扩展包](/developing-packages/)。

## 发布平台特定代码为扩展包 {#publish}

如果你希望在 Flutter 的生态系统中和其他开发者分享自己的平台特定代码，更多细节请参考 [发布扩展包](/developing-packages/#publish)。

## 自定义通道和编解码器

除了上面提到的 `MethodChannel`，你也可以使用更简单的 [`BasicMessageChannel`][BasicMessageChannel]，它使用自定义消息编解码器支持最基本的，异步消息传递。甚至，你可以使用特定的 [`BinaryCodec`][BinaryCodec], [`StringCodec`][StringCodec], 和
[`JSONMessageCodec`][JSONMessageCodec] 类，或创建你自己的编解码器.

[BasicMessageChannel]: https://docs.flutter.io/flutter/services/BasicMessageChannel-class.html
[BinaryCodec]: https://docs.flutter.io/flutter/services/BinaryCodec-class.html
[StringCodec]: https://docs.flutter.io/flutter/services/StringCodec-class.html
[JSONMessageCodec]: https://docs.flutter.io/flutter/services/JSONMessageCodec-class.html
