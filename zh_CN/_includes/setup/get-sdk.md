## 获取 Flutter SDK

获取 Flutter ，你可使用 `git`去克隆 Flutter 的仓库然后添加 `flutter` 工具到你的路径，运行 `flutter doctor `显示你可能要安装的依赖。

### 克隆仓库

如果你是第一次在你机器上安装 Flutter ，克隆 `beta` 分支的仓库然后添加 `flutter` 工具到你的路径：

{% commandline %}
git clone -b beta https://github.com/flutter/flutter.git
export PATH=`pwd`/flutter/bin:$PATH
{% endcommandline %}

上面的命令会在当前的终端窗口暂时设置 PATH 变量，要永久添加 Flutter 到你的路径，请参阅 [更新你的路径](#update-your-path)。

要更新一个现有版本的 Flutter ，请参阅[更新 Flutter](/upgrading/) 。


### 运行 flutter doctor

运行以下命令可以看到你是否需要安装任何依赖来完成安装：

{% commandline %}
flutter doctor
{% endcommandline %}

这个命令会检查你的环境并显示一份报告在终端窗口，Dart SDK 已和 Flutter 捆绑在一起，所以你不需要额外安装 Dart 。仔细检查输出信息是否需要安装其他软件或者执行其他任务（以**粗体**字显示）。

举个例子：
<pre>
[-] Android toolchain - develop for Android devices
    • Android SDK at /Users/obiwan/Library/Android/sdk
    <strong>✗ Android SDK is missing command line tools; download from https://goo.gl/XxQghQ</strong>
    • Try re-installing or updating your Android SDK,
      visit https://flutter.io/setup/#android-setup for detailed instructions.
</pre>

这是你第一次去运行 flutter 命令（比如 `flutter doctor`），它会下载依赖库，并且自行编译。后续运行这条命令就会更加快了。

接下来的章节就是描述怎么执行这些任务和完成设置过程。你会看到 `flutter doctor` 输出了假如你是用了 IDE ，就会显示 IntelliJ IDEA ， Android Studio ， 和 VS Code 这些编译器的可用插件。请参阅[编译器设置](/get-started/editor/)根据步骤去安装 Flutter 和 Dart 插件。

当你安装好了所有缺失的依赖库，运行 `flutter doctor` 命令去验证你的设置是否正确。

这个`flutter` 工具使用了 Google Analytics 匿名分析 报告功能，使用情况信息和基本崩溃报告。这些数据用于帮助改进 Flutter 工具。并且这个分析报告是不会在第一次运行或者任何涉及到 `flutter config` 的设置运行时发送，因此你可以在任何分析之前退出分析。要禁用分析的话，输入`flutter config --no-analytics` ，要显示当前配置的话输入 `flutter config` 。详情请参阅 Google 的隐私政策：[www.google.com/intl/en/policies/privacy](https://www.google.com/intl/en/policies/privacy/)。
{: .alert-warning}