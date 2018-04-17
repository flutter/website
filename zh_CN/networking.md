---
layout: page
title: 使用 Flutter 发起网络请求
permalink: /networking/
---

本文介绍了如何使用 Flutter 发起网络请求，了解 sockets ，请查阅 [dart:io][dartio]。

* TOC Placeholder
{:toc}

## 发起 HTTP 请求

HTTP 核心接口的支持位于 [`dart:io`][dartio]，所以为了创建一个 HTTP [Client][client]
我们需要引入以下代码：

<!-- skip -->
```dart
import 'dart:io';

var httpClient = new HttpClient();
```

客户端支持常见的 HTTP 操作，例如 [`GET`][get]，
[`POST`][post]，[`PUT`][put]，[`DELETE`][delete]。

## 异步处理

注意到 HTTP 相关接口在返回值中使用 [Dart
Futures](https://www.dartlang.org/tutorials/language/futures)。我们推荐在调用接口的时候使用 `async`/`await` 语法。

网络请求一般遵循以下几个步骤：

1. 创建 client。
2. 构造 Uri。
3. 唤起操作，使用 await 等待请求。（可选）配置请求头和请求体。
4. 关闭请求，使用 await 等待响应。
5. 解码响应对象。

这些步骤使用基于 Future 的接口，以上几步的接口调用示例代码：

<!-- skip -->
```dart
get() async {
  var httpClient = new HttpClient();
  var uri = new Uri.http(
      'example.com', '/path1/path2', {'param1': '42', 'param2': 'foo'});
  var request = await httpClient.getUrl(uri);
  var response = await request.close();
  var responseBody = await response.transform(UTF8.decoder).join();
}
```

完整的示例代码参见下面的 'Example'。

## JSON 的编码与解码

简单的 JSON 编解码可以使用
[`dart:convert`](https://docs.flutter.io/flutter/dart-convert/dart-convert-library.html)
库。更多 JSON 相关文档，请参阅 [JSON and serialization](/json/).

解码一个简单的 JSON 字符串并将响应对象解析为一个字典：

<!-- skip -->
```dart
Map data = JSON.decode(responseBody);
// Assume the response body is something like: ['foo', { 'bar': 499 }]
int barValue = data[1]['bar']; // barValue is set to 499
```

编码简单的 JSON 对象，将简单的值（如字符串，布尔值，或者 数值类型），字典，数组，或者包含简单值的字典组成的数组传入 `encode` 方法：

<!-- skip -->
```dart
String encodedString = JSON.encode([1, 2, { 'a': null }]);
```

## 示例: 通过 GET 请求解析 JSON

以下示例代码展示在 Flutter 应用中如何从 HTTPS 的 GET 请求中解码 JSON。

使用 [httpbin.com](https://httpbin.com) 的测试 API 服务
并返回你的本地 IP 地址。 注意使用安全的网络（HTTPS）。

1. 创建一个 flutter 应用 `flutter create`。

1. 将 `lib/main.dart` 的内容替换为：

```dart
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _ipAddress = 'Unknown';

  _getIPAddress() async {
    var url = 'https://httpbin.org/ip';
    var httpClient = new HttpClient();

    String result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var json = await response.transform(UTF8.decoder).join();
        var data = JSON.decode(json);
        result = data['origin'];
      } else {
        result =
            'Error getting IP address:\nHttp status ${response.statusCode}';
      }
    } catch (exception) {
      result = 'Failed getting IP address';
    }

    // If the widget was removed from the tree while the message was in flight,
    // we want to discard the reply rather than calling setState to update our
    // non-existent appearance.
    if (!mounted) return;

    setState(() {
      _ipAddress = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    var spacer = new SizedBox(height: 32.0);

    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('Your current IP address is:'),
            new Text('$_ipAddress.'),
            spacer,
            new RaisedButton(
              onPressed: _getIPAddress,
              child: new Text('Get IP address'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## API 文档

更多文档，请参阅：

  * [library `dart:io`][dartio]
  * [library `dart:convert`][convert]

[dartio]:     https://docs.flutter.io/flutter/dart-io/dart-io-library.html
[convert]:    https://docs.flutter.io/flutter/dart-convert/dart-convert-library.html
[client]:     https://docs.flutter.io/flutter/dart-io/HttpClient-class.html
[get]:        https://docs.flutter.io/flutter/dart-io/HttpClient/getUrl.html
[post]:       https://docs.flutter.io/flutter/dart-io/HttpClient/postUrl.html
[put]:        https://docs.flutter.io/flutter/dart-io/HttpClient/putUrl.html
[delete]:     https://docs.flutter.io/flutter/dart-io/HttpClient/deleteUrl.html
