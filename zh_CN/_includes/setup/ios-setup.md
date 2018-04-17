## iOS 设置

### 安装 Xcode

为 iOS 开发 Flutter 应用，你需要一台安装了 Xcode 7.2 或者更新版本的 Mac 。

1. 安装 Xcode 7.2  或者更新版本（通过[网页下载](https://developer.apple.com/xcode/)或者 [App Store](https://itunes.apple.com/us/app/xcode/id497799835) 安装）。
1. 通过在在命令行运行`sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer` 来配置 Xcode 命令行工具来使用安装好的最新版本 Xcode 。

	大多数情况下，这是安装最新版 Xcode 的正确的路径。如果你想使用不同的版本，请改为指定的路径。
1. 确保 Xcode 许可协议是通过打开一次 Xcode 或者从命令行中运行 `sudo xcodebuild -license` 来签署的。



使用 Xcode ，你就可以在你的 iOS 设备或者在模拟器上运行 Flutter 应用。

### 设置 iOS 模拟器

准备在 iOS 模拟器上运行并测试你的 Flutter 应用，根据以下步骤：

1. 在你的 Mac 上，可以通过 Spotlight 或者使用以下命令找到模拟器：

{% commandline %}
open -a Simulator
{% endcommandline %}

2. 通过检查模拟器的 **Hardware > Device** 设置，确保你的模拟器运行 64 位的设备（iPhone 5s 或者更高版本）。
3. 根据你开发设备的屏幕尺寸，模拟高屏幕密度的 iOS 设备可能会溢出你的屏幕，在模拟器的 **Window > Scale** 菜单设置设备的比例。
4. 运行`flutter run` 来启动你的应用。


### 部署到 iOS 设备

部署你的 Flutter 应用程序到物理的 iOS 设备，你需要一些额外的工具和一个 Apple 账号。你还需要在 Xcode 中设置物理设备的部署。

1. 安装 [homebrew](http://brew.sh/)。
1. 打开终端运行这些命令来安装部署 Flutter 应用程序到 iOS 设备的工具。

{% commandline %}
brew update
brew install --HEAD libimobiledevice
brew install ideviceinstaller ios-deploy cocoapods
pod setup
{% endcommandline %}

如果这些命令中的任何一个命令失败出现错误，运行 `brew doctor` 并根据说明解决问题。

1. 遵循 Xcode 的签名流程来配置你的项目：
    1. 打开默认的 Xcode 工作空间，找到你的 Flutter 项目目录并打开终端运行 `open ios/Runner.xcworkspace`  。
    1. 在 Xcode 左边的导航面板，选择 `Runner`  项目。
    1. 在 `Runner` 目标设置界面，确保在 **General > Signing > Team** 选择了你的开发团队，当你选择了开发团队，Xcode 创建和下载一个开发证书，向你的设备注册你的账户，并创建和下载配置文件（如果你需要的话）。
        * 要开始你的第一个 iOS 开发项目，你可能需要在 Xcode 上注册你的 Apple ID。<br>
        ![Xcode account add](/images/setup/xcode-account.png)<br>
        任意的 Apple ID 都支持开发和测试。需要注册 Apple 开发者计划才能分发你的应用到 App Store 。请参阅 [Apple 会员类型之间的差异](https://developer.apple.com/support/compare-memberships)。
        * 你第一次用物理设备开发 iOS 时，你需要同时信任该设备上的 Mac 和开发证书。  当你的 iOS 设备第一次连接到你的 Mac 时，在对话框提示中选择 `Trust`。<br>
        ![Trust Mac](/images/setup/trust-computer.png)<br>
        然后，打开 iOS 设备上的设置，选择**常规 > 设备管理** 然后信任你的证书。
        * 如果 Xcode 的自动签名失败，验证项目的**General > Identity > Bundle Identifier**  是否唯一。<br>
        ![Check the app's Bundle ID](/images/setup/xcode-unique-bundle-id.png)
1. 运行`flutter run` 启动你的应用程序。
