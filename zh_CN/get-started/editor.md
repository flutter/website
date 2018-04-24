---
layout: page
title: "入门：配置编辑器"
permalink: /get-started/editor/
---

你可以使用任意一款文本编辑器结合我们提供的命令行工具来构建 Flutter 应用程序。当然，我们更推荐的是使用我们开发的文本编辑器插件之一，来优化开发的使用体验。安装好编辑器插件之后，你会获得代码自动补全，关键词高亮，组件编辑助手，运行&调试的支持等一系列实用的功能。

请跟随下面的步骤来为你的编辑器添加这些插件，我们支持 Android Studio, IntelliJ 以及 VS Code。如果你使用的是另外的编辑器，也没有问题，跳过这一步，直接进入 [下一步：创建并运行你的第一个应用程序](/get-started/test-drive/)。

<div id="tab-set-install">

<ul class="tabs__top-bar">
    <li class="tab-link current" data-tab="tab-install-androidstudio">Android Studio</li>
    <li class="tab-link" data-tab="tab-install-vscode">VS Code</li>
</ul>

<div id="tab-install-androidstudio" class="tabs__content current" markdown="1">

## Android Studio 配置

*Android Studio:* 一个完整的，高度集成的 Flutter 开发编辑器。

### 安装 Android Studio

   * [Android Studio](https://developer.android.com/studio/index.html), 3.0 或者更高的版本。

当然，你也可以选择使用 IntelliJ：

   * [IntelliJ IDEA 社区版](https://www.jetbrains.com/idea/download/), 2017.1 或者更高的版本。
   * [IntelliJ IDEA 高级版](https://www.jetbrains.com/idea/download/), 2017.1 或者更高的版本。

### 安装 Flutter 和 Dart 插件

Flutter 的开发支持需要安装 2 个插件：

   * `Flutter` 插件可以提高 Flutter 在开发过程中的开发效率（运行，调试，热重载等等）。
   * `Dart` 插件提提升了代码层面的开发效率（在你敲代码的同时进行代码校验，代码自动补全等等）。

安装步骤：

   1. 启动 Android Studio。
   1. 打开插件设置（在 macOS 上路径为 **Preferences>Plugins**，在 Windows 和 Linux 上路径为 **File>Settings>Plugins**）。
   1. 选择 **Browse repositories…**，找到或者在搜索栏输入 Flutter，然后点击 `install`。
   1. 当弹出对话框提示要安装 Dart 插件的时候，点击 `Yes` 接受。
   1. 如果弹出 `Restart` 需要重启编辑器的时候，点击 `Yes` 接受。

</div>

<div id="tab-install-vscode" class="tabs__content" markdown="1">

## Visual Studio Code (VS Code) 配置

*VS Code:* 包含了运行和调试 Flutter 应用程序的轻量级编辑器。

### 安装 VS Code

  * [VS Code](https://code.visualstudio.com/), 1.20.1 或更高版本。

### 安装 Dart Code 插件

  1. 启动 VS Code
  1. 依次执行 **View>Command Palette...**
  1. 在扩展插件安装面板的输入框输入 `dart code` 关键词，在显示的列表中选择 'Dart Code' 插件，然后点击 **Install**
  1. 点击 'OK' 重新加载 VS Code

## 使用 Flutter Doctor 来验证你的配置

  1. 依次执行 **View>Command Palette...**
  1. 输入 'doctor', 然后选择 **'Flutter: Run Flutter Doctor'** 命令
  1. 在日志打印窗口的 'OUTPUT' 标签中查看打印出的日志信息，看看有没有报错

</div>

</div>

## 下一步

让我们首先来用 Flutter 小试牛刀，体验一下 Flutter 开发的特点：创建第一个项目，运行并且体验一下 '热重载'。

[下一步: Flutter 初体验](/get-started/test-drive/)
