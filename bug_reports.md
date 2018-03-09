---
layout: page
title: 创建有效的 bug 反馈报告

permalink: /bug-reports/
---

* TOC Placeholder
{:toc}

## 简介

本文档中的说明详细介绍了当崩溃和其他异常现象发生时，创建一份最为有效的反馈报告的通用步骤。虽然每一个步骤都不是必须的，但会极大地提高问题确定和定位的速度，所以我们希望您能够尽可能多地提供反馈信息。

## 在 Github 上创建 Issue
* 您可以在如下位置创建一个新的 issue ： [https://github.com/flutter/flutter/issues/new](https://github.com/flutter/flutter/issues/new)

## 提供 Flutter 的诊断信息
* 在您项目的根目录下打开终端运行命令 `flutter doctor` ，并将打印结果粘贴到 Github 的 Issue 中：

```
[✓] Flutter (on Mac OS, channel master)
    • Flutter at /Users/me/projects/flutter
    • Framework revision 8cbeb2e (4 hours ago), engine revision 5c28578

[✓] Android toolchain - develop for Android devices (Android SDK 23.0.2)
    • Android SDK at /usr/local/Cellar/android-sdk/24.4.1_1
    • Platform android-23, build-tools 23.0.2
    • Java(TM) SE Runtime Environment (build 1.8.0_73-b02)

[✓] iOS toolchain - develop for iOS devices (Xcode 7.3)
    • XCode at /Applications/Xcode.app/Contents/Developer
    • Xcode 7.3, Build version 7D175

[✓] IntelliJ IDEA Ultimate Edition (version 2016.2.5)
    • Dart plugin installed
    • Flutter plugin installed
```

## 以详细模式运行命令
如果您的问题与 `flutter` 工具本身相关，请参考如下步骤。

* 所有的 Flutter 命令都可以接收 `--verbose` 参数。在 issue 中加入该命令的数据将可能有助于确定问题。
* 将命令的输出附于 Github 的 issue 中。
![flutter verbose](/images/verbose_flag.png)

## 提供最近的日志信息
* 通过执行 `flutter logs` 命令可以获取当前连接设备的日志信息
* 如果是可重现的崩溃, 请先清空日志 (⌘ + k on Mac), 然后重现崩溃后将最新生成的 log 日志输出到文件中附到 bug 反馈中。
* 如果您发现了由框架抛出的异常，请包含异常第一次出现位置虚线间的所有输出信息。
![flutter logs](/images/logs.png)

## 提供设备的崩溃日志
* 当崩溃发生于 iOS 模拟器时，崩溃日志将生成在： `~/Library/Logs/DiagnosticReports/`。
* 当崩溃发生于 iOS 真机上时, 崩溃日志将生成在： `~/Library/Logs/CrashReporter/MobileDevice`。
* 找到与崩溃相关的日志 (通常是最新的那一个日志) 并将其附到 Github issue 中。
![crash report](/images/crash_reports.png)
