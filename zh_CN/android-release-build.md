---
layout: page
title: 发布 Android 应用的准备工作

permalink: /android-release/
---

一般当您的软件处于开发阶段，您既可以在命令行中运行 `flutter run` 来测试应用，也可以使用 IntelliJ 工具栏中的 Run 和 Debug 按钮。默认情况下 Flutter 会构建出您应用的 *debug* 版本。

而当您已经准备好要为 Android 平台构建一个 *release* 版应用， 例如
[发布到 Google Play Store][play]， 请参考本页中的如下步骤。

* TOC Placeholder
{:toc}

## 检查应用的 Manifest 清单

请检查路径 `<app dir>/android/app/src/main/` 下保存的默认 [App Manifest][manifest] 清单文件 `AndroidManifest.xml` ，确保其中的值正确无误，尤其是：

* `application`: 编辑 [`application`][applicationtag] 标签以修改应用最终显示的名称。

* `uses-permission`: 如果您的应用并不需要网络访问权限，请移除 `android.permission.INTERNET`
[permission][permissiontag] 标签。标准项目模板中包含此标签是因为开发阶段需要利用网络权限来确保应用和 Flutter 工具链间的通讯以完成运行调试等功能。

## 检查构建配置

请检查路径 `<app dir>/android/app/` 下保存的默认 [Gradle build file][gradlebuild] 文件 `build.gradle` ，确保其中的值正确无误，尤其是：

* `defaultConfig`: 

  * `applicationId`: 指定唯一的应用 ID [appid]

  * `versionCode` & `versionName`: 指定应用的版本号和用于显示的版本号字符串。 与版本信息相关的详细内容请查阅文档 [versions documenation][versions] 。

  * `minSdkVersion` & `targetSdkVersion`: 指定可运行应用的最低版本的 Android 平台，以及运行应用的目标 API 级别。 具体内容请查阅文档 [versions documetation][versions] 中《指定 API 级别要求》部分。

## 添加桌面图标

当创建一个全新的 Flutter 应用时，应用将使用一个默认图标，如果您想要自定义桌面图标：

1. 请参考 [Android Launcher Icons][launchericons] 推荐指南来设计图标。

1. 在 `<app dir>/android/app/src/main/res/` 文件夹中放置您以 [配置限定符][configurationqualifiers] 命名过的图标文件。
默认的 `mipmap-` 文件夹演示了正确的命名约定。

1. 在 `AndroidManifest.xml` 清单文件中， 更新 [`application`][applicationtag] 标签中
`android:icon` 属性的值以指定使用上一步中配置的图标文件 (例如.
`<application android:icon="@mipmap/ic_launcher" ...`).

1. 使用 `flutter run` 运行您的应用并检查桌面上的图标，以确保图标文件已经替换成功。

## 给应用签名

### 创建 keystore 证书
如果您已经创建过证书则可以跳过这一步。若要创建新的证书，请在命令行中执行如下命令：
`keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key`

*注意*: 请注意保护好这个证书文件，确保隐私安全，尤其是不要将其上传到公开的版本控制中。

*注意*: `keytool` 命令可能并不存在于您的系统环境路径中。 它是 Java JDK 的一部分，当您安装 Android Studio 时会被一起安装。 您可以通过运行 `flutter doctor` 命令，查看 'Java binary at:' 后输出的路径来确定命令所在的路径，然后将全路径中最后的 `java` 替换成 `keytool` 来执行该命令。

### 在应用中引用 keystore 证书

创建一个包含了 keystore 证书引用的配置文件并命名为 `<app dir>/android/key.properties` :

```
storePassword=<上一步中输入的 store 密码>
keyPassword=<上一步中输入的 key 密码>
keyAlias=key
storeFile=<keystore 文件的位置， 例如： /Users/<user name>/key.jks>
```

*注意*: 请注意保护好这个配置文件，确保隐私安全，尤其是不要将其上传到公开的版本控制中。

### 在 gradle 中配置签名选项

编辑您应用的 `<app dir>/android/app/build.gradle`
文件以配置签名选项

1. 替换:
```
   android {
```
   为您包含证书引用的配置文件:
```
   def keystorePropertiesFile = rootProject.file("key.properties")
   def keystoreProperties = new Properties()
   keystoreProperties.load(new FileInputStream(keystorePropertiesFile))

   android {
```

1. 替换:
```
   buildTypes {
       release {
           // TODO: Add your own signing config for the release build.
           // Signing with the debug keys for now, so `flutter run --release` works.
           signingConfig signingConfigs.debug
       }
   }
```
   为如下内容:
```
   signingConfigs {
       release {
           keyAlias keystoreProperties['keyAlias']
           keyPassword keystoreProperties['keyPassword']
           storeFile file(keystoreProperties['storeFile'])
           storePassword keystoreProperties['storePassword']
       }
   }
   buildTypes {
       release {
           signingConfig signingConfigs.release
       }
   }
```

这样一来，当您的应用构建 Release 版本时就会自动签名。

## 构建 release 版应用

这一部分介绍了应该如何构建 release 版本的 APK。如果您已经完成了上面的所有步骤， Release 版的 APK 将会被自动签名。

在命令行使用:

1. `cd <app dir>` (用您应用工程的根目录替换 `<app dir>` )。
1. 运行 `flutter build apk` (`flutter build` 命令默认使用 `--release`)。

您应用的 release 版本的 APK 会生成在 `<app dir>/build/app/outputs/apk/app-release.apk`。

## 将 release 版本的 APK 安装到设备上

参考如下步骤，将上面步骤构建出的 APK 安装到已连接的 Android 设备。

使用命令行命令:

1. 使用 USB 将 Android 设备连接到您的计算机。
1. `cd <app dir>` (进入您应用工程的根目录)。
1. 运行 `flutter install` 。

## 将 APK 发布到 Google Play Store

将 release 版应用发布到 Google Play Store 的详细步骤请参阅： [Google Play publishing documentation][play]。

[manifest]: http://developer.android.com/guide/topics/manifest/manifest-intro.html
[manifesttag]: https://developer.android.com/guide/topics/manifest/manifest-element.html
[appid]: https://developer.android.com/studio/build/application-id.html
[permissiontag]: https://developer.android.com/guide/topics/manifest/uses-permission-element.html
[applicationtag]: https://developer.android.com/guide/topics/manifest/application-element.html
[versions]: https://developer.android.com/studio/publish/versioning.html
[launchericons]: https://developer.android.com/guide/practices/ui_guidelines/icon_design_launcher.html
[configurationqualifiers]: https://developer.android.com/guide/practices/screens_support.html#qualifiers
[play]: https://developer.android.com/distribute/googleplay/start.html
