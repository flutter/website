---
title: Install help
description: This page describes some common installation issues new Flutter users have run into and offers suggestions to resolve them.
---

This page describes some common installation issues new Flutter users have run into and offers suggestions to resolve them. Included at the bottom of the page is a list of [community support channels][] you can reach out to if you don’t find answers from this page.

If you’d like to add a topic to this page, please file an issue or a pull request against this page. 

## Get the Flutter SDK


### Unable to find the `flutter` command


#### What does this issue look like? 

When you try to run the `flutter` command, the console fails to find it. On Windows, the error usually looks like this:


#### Explanation and suggestions

You might have missed steps to add Flutter to the PATH environment variable. On Windows, you can follow the process demonstrated in [this video](https://youtu.be/0SRvmcsRu2w?t=137). 

<!-- TODO: Embed YouTube video  -->

If you’ve already [set up VS Code](https://docs.flutter.dev/get-started/editor) for Flutter development, you can use the Flutter extension’s “Locate SDK” prompt to identify the location of your `flutter` folder.

See also: [Configuring PATH and Environment Variables - Dart Code](https://dartcode.org/docs/configuring-path-and-environment-variables/)


### Flutter in special folders


#### What does this issue look like? 

When you try to run your Flutter project, you get an error message like this: 


#### Explanation and Suggestions

On Windows, this usually happens when Flutter is installed in a directory like `C:\Program Files\` that requires elevated privileges. Try relocating flutter to a different folder such as `C:\src\flutter`.


## Android setup


## Having multiple versions of Java installed


#### What does this issue look like? 

The command `flutter doctor --android-licenses` fails. When you run `flutter doctor –verbose` you see an error message like this:


#### Explanation and suggestions

The error occurs when an older version of Java Development Kit (JDK) is installed on your computer. 

If you don’t need multiple versions of Java, uninstall existing JDKs from your computer. Flutter will automatically use the JDK included in Android Studio. 

If you do need another version of Java, try the workaround described in [this Github issue](https://github.com/flutter/flutter/issues/106416#issuecomment-1522198064) until a long-term solution is implemented. 


#### See also

*   [flutter doctor --android-licenses not working due to java.lang.UnsupportedClassVersionError - Stack Overflow](https://stackoverflow.com/questions/75328050/)


### `cmdline-tools` component is missing


#### What does this issue look like? 

`flutter doctor` complains about “Android toolchain” and specifically missing the cmdline-tools component. 


#### Explanation and suggestions

The easiest way you get cmdline-tools is through the SDK Manager in Android Studio. To open the SDK Manager from Android Studio, click **Tools > SDK Manager** from the menu bar. 



*   Select the latest Android SDK (or a specific version your app requires), Android SDK Command-line Tools, and Android SDK Build-Tools. 
*   Click the **Apply** button to have the selected artifacts installed.



<p id="gdcalert2" ><span style="color: red; font-weight: bold">>>>>  GDC alert: inline image link here (to images/image1.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert3">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>> </span></p>

<!-- FIXME -->
![alt_text](images/image1.png "image_tooltip")


If you're not using Android Studio, you can download tools using the [sdkmanager](https://developer.android.com/studio/command-line/sdkmanager) command-line tool.


## Other problems


### Exit code 69


#### What does this issue look like? 

After running a `flutter` command, you get an error with “exit code: 69” as shown in the example below:


#### Explanation and suggestions

The issue is related to networking. Here are a few things you can try to troubleshoot this:



*   Check your internet connection. Make sure that you are connected to the internet and that your connection is stable.
*   Restart your devices, including your computer and networking equipment.
*   Use a VPN. A VPN can help to bypass any restrictions that may be preventing you from connecting to the network.
*   If you have tried all of these steps and you are still getting the error, print out verbose logs with the `flutter doctor -v` command and ask for help in one of the 
[community support channels][].


## Community support

The Flutter community is helpful and welcoming. If none of the above solves your installation issue, you may consider asking for support from the following channels:

*   [/r/flutterhelp](https://www.reddit.com/r/flutterhelp/) on Reddit
*   [/r/flutterdev](https://discord.gg/rflutterdev) on Discord. There’s an `install-and-setup` channel on this server. 
*   [StackOverflow](https://stackoverflow.com/search?q=%5Bflutter%5D+install)

To be respectful to everyone’s time, try to search the archive for a similar issue first before you post a new one. 


[community support channels]: #community-support