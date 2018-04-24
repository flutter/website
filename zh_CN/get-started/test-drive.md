---
layout: page
title: "入门：Flutter 初体验"
permalink: /get-started/test-drive/
---

在这篇文档中你将了解如何在 Flutter 开发中进行调试和修改：从我们提供的项目模板创建一个 Flutter 应用程序，运行然后学习如何使用热重载来修改程序。

Flutter 是一个扩展性极强的工具集，因此你可以选择你钟爱的开发工具或者平台来写代码，编译以及运行 Flutter 应用程序。

<div id="tab-set-install">

<ul class="tabs__top-bar">
    <li class="tab-link current" data-tab="tab-install-androidstudio">Android Studio</li>
    <li class="tab-link" data-tab="tab-install-vscode">VS Code</li>
    <li class="tab-link" data-tab="tab-install-terminal">控制台 + 文本编辑器</li>
</ul>

<div id="tab-install-androidstudio" class="tabs__content current" markdown="1">

*Android Studio:* 一个完整的，高度集成的 Flutter 开发编辑器。

## 创建应用程序 {#create-app}

   1. 依次选择 **File>New Flutter Project**
   1. 选择 **Flutter application** 作为项目类型，然后点击下一步
   1. 输入项目名称（例如：`myapp`），然后点击下一步
   1. 点击 **Finish**
   1. 等待 Android Studio 安装好 SDK 和创建好这个项目。

以上的命令创建了一个名叫 `myapp` 的 Flutter 项目，并且放在 'myapp' 文件夹中。这是一个很简单的，基于 [Material 组件](https://material.io/guidelines/) 的项目。

在这个项目的文件夹中，和项目业务相关的代码都在 `lib/main.dart` 中。

## 运行这个程序

   1. 找到 Android Studio 的主工具栏：<br>
      ![IntelliJ 的主工具栏](/images/intellij/main-toolbar.png)
   1. 在 **target selector** 中，选择一个已连接的 Android 设备来运行这个程序。如果列表中没有可用的设备，   那么依次选择 **Tools>Android>AVD Manager** 创建一个可用的模拟器。了解更多，请查看 [管理
      AVDs](https://developer.android.com/studio/run/managing-avds.html)。
   1. 点击工具栏中的 **Run icon**，或者在菜单栏中一次选择 **Run > Run**。
   1. 如果一切正常，那么你现在就可以在你的手机或者模拟器上看到程序的起始界面了：<br>
      ![Android 设备/模拟器上的起始界面](/images/flutter-starter-app-android.png)

## 尝试一下热重载

Flutter 提供了一种非常高效的开发方式，叫做 _热重载_ ，这个功能可以在应用程序运行的状态下替换部分代码，并且运行中的程序不会丢失任何状态。简单的对你的源代码做一些修改，告诉你的 IDE 或者命令行工具，你需要进行热重载，然后你就可以在模拟器或者手机中看到你的修改了。

  1. 把字符串<br>`'You have pushed the button this many times:'`修改为<br>`'You have clicked      the button this many times:'`
  1. 不需要点击 'Stop' 按钮；让应用程序继续运行。
  1. 只需要将代码 **全部保存** (`cmd-s` / `ctrl-s`)，或者点击 **热重载** 按钮（那个像闪电⚡️一样的图标按钮）你就可以看到你的修改已经被执行了。

你几乎可以立刻就在应用程序里看到你对字符串的修改。

</div>

<div id="tab-install-vscode" class="tabs__content" markdown="1">

*VS Code:* 包含了运行和调试 Flutter 应用程序的轻量级编辑器。

## 创建应用程序

  1. 启动 VS Code
  1. 依次执行 **View>Command Palette...**
  1. 输入 'flutter'，选择 **'Flutter: New Project'** 命令
  1. 输入项目名称（例如：`myapp`），回车
  1. 找到一个用于保存项目的目录，然后点击蓝色的确认按钮
  1. 项目会自动进行创建，创建完毕之后，`main.dart` 文件会被自动打开

以上的命令创建了一个名叫 `myapp` 的 Flutter 项目，并且放在 'myapp' 文件夹中。这是一个很简单的，基于 [Material 组件](https://material.io/guidelines/) 的项目。

在这个项目的文件夹中，和项目业务相关的代码都在 `lib/main.dart` 中。

## 运行这个程序

  1. 确保在 VS Code 的右下角能看到目标设备的名称
  1. 使用键盘上的 F5 按钮，或者依次执行 **Debug>Start Debugging**
  1. 等待应用程序启动
  1. 如果一切正常，构建完应用程序之后，你就可以在你的手机或者模拟器上看到应用程序的起始界面了：<br>
     ![Android 设备/模拟器上的起始界面](/images/flutter-starter-app-android.png)

## 尝试一下热重载

Flutter 提供了一种非常高效的开发方式，叫做 _热重载_ ，这个功能可以在应用程序运行的状态下替换部分代码，并且运行中的程序不会丢失任何状态。简单的对你的源代码做一些修改，告诉你的 IDE 或者命令行工具，你需要进行热重载，然后你就可以在模拟器或者手机中看到你的修改了。

  1. 在你最钟爱的 Dart 开发编辑器中打开 `lib/main.dart` 文件
  1. 把字符串<br>`'You have pushed the button this many times:'`
     修改为<br>`'You have clicked the button this many times:'`
  1. 不需要点击 'Stop' 按钮；让应用程序继续运行。
  1. 只需要将代码 **全部保存** (`cmd-s` / `ctrl-s`)，或者点击 **热重载** 按钮（那个绿色的带箭头的转圈图标按钮）你就可以看到你的修改已经被执行了。

你几乎可以立刻就在应用程序里看到你对字符串的修改。

</div>

<div id="tab-install-terminal" class="tabs__content" markdown="1">

*控制台 + 文本编辑器* 你自己选择的代码编辑器加上 Flutter 提供的命令行工具来运行和构建 Flutter 应用程序。

## 创建应用程序

   1. 使用 `flutter create` 命令来创建一个新的应用程序：
   {% commandline %}
   flutter create myapp
   cd myapp
   {% endcommandline %}

以上的命令创建了一个名叫 `myapp` 的 Flutter 项目，并且放在 'myapp' 文件夹中。这是一个很简单的，基于 [Material 组件](https://material.io/guidelines/) 的项目。

在这个项目的文件夹中，和项目业务相关的代码都在 `lib/main.dart` 中。

## 运行这个程序

   * 确保 Android 设备当前处于运行状态。如果没有发现在运行的设备，查看 [安装](/get-started/install/)   页面。
   {% commandline %}
   flutter devices
   {% endcommandline %}
   * 使用 `flutter run` 命令来运行程序：
   {% commandline %}
   flutter run
   {% endcommandline %}
   * 如果一切正常，构建完应用程序之后，你就可以在你的手机或者模拟器上看到应用程序的起始界面了：<br>
     ![Android 设备/模拟器上的起始界面](/images/flutter-starter-app-android.png)

## 尝试一下热重载

Flutter 提供了一种非常高效的开发方式，叫做 _热重载_ ，这个功能可以在应用程序运行的状态下替换部分代码，并且运行中的程序不会丢失任何状态。简单的对你的源代码做一些修改，告诉你的 IDE 或者命令行工具，你需要进行热重载，然后你就可以在模拟器或者手机中看到你的修改了。

  1. 在编辑器中打开 `lib/main.dart` 文件
  1. 把字符串<br>`'You have pushed the button this many times:'`
     修改为<br>`'You have clicked the button this many times:'`
  1. 不需要点击 'Stop' 按钮；让应用程序继续运行。
  1. 只需要将代码 **全部保存** (`cmd-s` / `ctrl-s`)，或者点击 **热重载** 按钮（那个绿色的带箭头的转圈图标按钮）你就可以看到你的修改已经被执行了。

你几乎可以立刻就在应用程序里看到你对字符串的修改。

</div>

</div>

## 下一步

让我们通过创建一个小应用来学习一些 Flutter 中的核心概念。

[下一步：编写第一个 Flutter 应用](/get-started/codelab/)
