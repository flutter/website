## Android 设置

### 安装 Android Studio

为 Android 开发 Flutter 应用，你可以使用 Mac ，Windows 或者是 Linux（64 位）机器。

Flutter 要求安装和配置 Android Studio：

1. 下载并安装 [Android Studio](https://developer.android.com/studio/index.html)。

1. 启动 Android Studio，并执行 Android Studio 安装向导。这将会安装 Flutter 为 Android 开发所需的最新的 Android SDK ，Android SDK 平台工具和 Android SDK 构建工具。

### 设置你的 Android 设备

为了在 Android 设备上运行和测试你的 Flutter 应用，你需要一台运行 Android 4.1（ API 级别 16 ）或者更高版本的 Android 设备。

1. 在你的设备上启动**开发者选项** 和 **USB 调试**，详情说明可在 [Android 文档](https://developer.android.com/studio/debug/dev-options.html)中找到。
3. 使用 USB 线将设备插入电脑。如果在设备上出现提示，请授权你的电脑访问你的设备。
4. 在终端运行 `flutter devices` 命令来验证 Flutter 识别到你连接的 Android 设备。
5. 运行 `flutter run` 来启动的你的应用。


通常情况下， Flutter 使用了 `adb` 工具所基于的 Android SDK 版本，如果你要安装使用不同的 Android SDK 版本，就必须设置 `ANDROID_HOME` 环境变量设置为安装目录。

### 设置 Android 模拟器

准备在 Android 模拟器上运行和测试你的 Flutter 应用，需要按照以下几个步骤来操作：


1. 在你的电脑上启动 [VM 加速](https://developer.android.com/studio/run/emulator-acceleration.html)。
1. 启动  **Android Studio > Tools > Android > AVD Manager**  和选择 **Create Virtual Device** 。
1. 选择一个设备的定义和选择 **Next** 。
1. 为你的模拟器 Android 版本选择一个或者多个系统镜像，和选择 **Next** 。推荐使用 _x86_  or  _x86\_64_ 镜像。
1. 为了提高模拟器性能，选择 **Hardware - GLES 2.0** 来启动[硬件加速](https://developer.android.com/studio/run/emulator-acceleration.html)。
1. 验证 AVD 的配置是否正确，然后选择 **Finish** 。


   有关上述步骤的详细信息,请查阅[管理 AVDs ](https://developer.android.com/studio/run/managing-avds.html)。

1. 在 Android 虚拟设备管理器中，在工具栏点击 **Run** 。模拟器启动和显示所选操作系统版本和设备的默认界面。
1. 通过 `flutter run` 来启动你的应用，连接设备的名称是 `Android SDK built for <platform>` ，这里的  _platform_ 是指设备 soc 芯片系列，比如 x86 。
