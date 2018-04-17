## 获取 Flutter SDK

为了获取 Flutter ， 使用 `git` 去克隆仓库然后添加 `flutter` 工具到你的环境变量。
运行 `flutter doctor` 来显示剩下你需要安装的的依赖。

### 克隆仓库
如果这是你第一次在电脑上安装 Flutter ，就要克隆这个远程仓库：


{% commandline %}
git clone -b beta https://github.com/flutter/flutter.git
{% endcommandline %}

要更新现有版本的 Flutter ，参阅 [升级 Flutter](/upgrading/)

### 更新你的环境变量

为了可以在任意的终端会话使用 `flutter` 命令，你需要添加它到你的 PATH 环境变量：

* 打开 “控制面板  > 系统和安全 > 系统 > 高级系统设置 > 环境变量”。
* 在用户变量下，检测是否存在 “Path” 的环境变量：
    * 如果这个 Path 变量已经存在了，就添加`;`到原来的 Path 值的末尾，并且加上 `flutter\bin` 的全路径。
    * 如果这个 Path 变量不存在，就要在用户变量下创建新的 `Path` 的变量名，并且它的变量值设置为 `flutter\bin` 的全路径。

重启 Windows 以完全应用此更改。

### 运行 flutter doctor
打开一个新的命令提示符或者 PowerShell 窗口，接着运行以下的命令，看是否需要安装任何依赖项来完成安装：


{% commandline %}
flutter doctor
{% endcommandline %}

要在命令提示符或者 PowerShell 窗口运行此命令。目前， Flutter 还不支持像 Git Bash 这样子的第三方 shell。
{: .alert-warning}

该命令会检测你的环境和在终端窗口生成报告。 Dart SDK 和 Flutter 捆绑在一起，没必要
单独去安装 Dart 。仔细检查命令窗口的输出是否需要安装其他软件或者执行其他任务（用粗体显示）

举个例子：
<pre>
[-] Android toolchain - develop for Android devices
    • Android SDK at D:\Android\sdk
    <strong>✗ Android SDK is missing command line tools; download from https://goo.gl/XxQghQ</strong>
    • Try re-installing or updating your Android SDK,
      visit https://flutter.io/setup/#android-setup for detailed instructions.
</pre>

第一次运行 flutter 命令
（比如 `flutter doctor` ），它会下载自己的依赖库并且自行编译。后续运行 flutter 命令就会很快了。


接下来的部分描述怎么去执行这些任务并完成这些设置过程。如果你选择了使用 IDE ，你会在 `flutter doctor` 的输出看到， IntelliJ IDEA ， Android Studio 和 VS Code 有可用插件。参阅[编译器设置](/get-started/editor/)获取安装 Flutter 和 Dart 插件的步骤。

当你已经安装好缺失的依赖库，运行 `flutter doctor` 命令会再次验证你是否正确设置所有内容。


`flutter` 使用 Google Analytics 匿名报告功能使用情况统计信息和基本崩溃报告。
这些数据用于帮助改进 Flutter 。这些分析不会在 flutter 第一次运行就发送或则任何涉及到 flutter 配置的运行时发出。要禁用报告，请在终端输入 `flutter config --no-analytics` ，要显示当前设置可以输入 `flutter config` 。详情请参阅Google的隐私政策： [www.google.com/intl/en/policies/privacy](https://www.google.com/intl/en/policies/privacy/)。
{: .alert-warning}
