---
title: Creating flavors for Flutter
short-title: Flavors
description: How to create build flavors specific to different release types or development environments.
---
## What are flavors
Have you ever wondered how to set up different environments in your Flutter app?
Flavors (known as _build configurations_ in iOS), allow you (the developer) to 
create separate environments for your app using the same code base. 
For example, you might have one flavor for your full-fledged production app, 
another as a limited "free" app, another for testing experimental features, and so on. 

Let's say you want to make both free and paid versions of your Flutter app. 
You can use flavors to set up both app versions 
without writing two separate apps. 
The free version of the app has basic functionality and ads (for example). 
In contrast, the paid version has basic app functionality, extra features, 
different styles for paid users, and no ads. 

Another example where you might use flavors is for feature development. 
If you’ve built a new feature and want to try it out, 
you could set up a flavor to test out the feature. 
Your production code remains unaffected 
until you are ready to deploy your new feature.

Flavors function by letting you define compile time configurations 
and set parameters that are read at runtime depending on your app needs.

This document guides you through setting up Flutter flavors for iOS and Android. 

## Environment set up
Prerequisites:
* Xcode installed
* An existing project 

To set up flavors in iOS, you’ll define build configurations in Xcode. 

## Creating flavors in iOS
1. Open your project in Xcode.

2. Select **Runner** > **New Scheme** from the menu to add a new Scheme.  
* A scheme describes how Xcode runs different actions. 
  For the purposes of this guide, the example _flavor_ and _scheme_ are 
  named `development`. 
  The build configurations in the development scheme 
  have the `-development` suffix. 

3. Duplicate the build configurations to differentiate between the 
default configurations that are already available and the new configurations 
for the `development` scheme. 
* Under the **Info** tab at the end of the 
**Configurations** dropdown list, click the plus button and duplicate 
each configuration name (Debug, Release, and Profile). 
Duplicate the listed production configurations, once for each environment. 

![Step 3 Xcode image](/assets/images/docs/flavors/step3-ios-build-config.png){:width="100%"}
{{site.alert.note}}
  Your configurations should be based on your **Debug.xconfig** or **Release.xcconfig**
  file, not the **Pods-Runner.xcconfigs**. You can check this by expanding the configuration names. 
{{site.alert.end}}

&nbsp;4. To match the development flavor, add `-development` 
at the end of each new configuration name. 

&nbsp;5. Change the `development` scheme to match the development 
build configurations already created.
* In the **Runner** project, click **Manage Schemes…** and a pop up window opens. 
* Double click the development scheme. In the next step 
(as shown in the screenshot), you’ll modify each scheme 
to match its dev build configuration:

![Step 5 Xcode image](/assets/images/docs/flavors/step5-ios-scheme.png){:width="100%"}

## Using flavors in iOS

Now that you’ve set up your development flavor, 
you can, for example, add different product bundle identifiers per flavor. 
A _bundle identifier_ uniquely identifies your application. 
In this example, we set the **Debug-development** value to equal 
`com.flavor-test.dev`. 

&nbsp;1. Change the app bundle identifier to differentiate between schemes. 
In **Product Bundle Identifier**, append `.dev` to each -development scheme value.

![Step 1 using flavors image.](/assets/images/docs/flavors/step1-using-flavors.png){:width="100%"}  

&nbsp;2. In the **Build Settings**, set the **Product Name** value to match each flavor. 

![Step 2 using flavors image.](/assets/images/docs/flavors/step2-using-flavors.png){:width="100%"}  

&nbsp;3. Add the display name to **info.plist**. Create a new key in **info.plist** called **Bundle Display Name** 
with the value `$(PRODUCT_NAME)`. 

![Step 3 using flavors image.](/assets/images/docs/flavors/step3-using-flavors.png){:width="100%"}    

Now you have set up your development flavor by making a `development` scheme 
in Xcode and setting the build configurations for that scheme. 

For more information, skip to the [“Launching your app flavors”][] 
section at the end of this document.

### Plugin configurations

If your app has a Flutter plugin, you will need to update the `ios/Podfile`. 

* in `iOS/Podfile` change the default of **Debug**, **Profile**, and **Release** 
to match the Xcode build configurations for the `development` scheme.

![Podfile configuration image.](/assets/images/docs/flavors/podfile-config.png){:width="80%"}

## Using flavors in Android

Setting up flavors in Android can be done in your projects 
**build.gradle** file.

1. In your IDE, inside your Flutter project, 
navigate to **android** > **app** > **build.gradle**.   

![Step 1 using flavors in Android image.](/assets/images/docs/flavors/android-step1.png){:width="100%"}    

Add a flavor object with the specified environments along with values for 
**dimension**, **resValue**, and **applicationId**. 
The name of the application for each build is located in **resValue** 
(as shown in the screenshot below from VSCode).
## Setting up launch configurations

In VSCode, set up the launch configurations as follows:  
Adding a **launch.json** file allows you to run the terminal command 
`flutter run --flavor [environment name]`. 
1. In the root directory of your project, add a folder called **.vscode**.    
2. Inside the **.vscode** folder, create a file named **launch.json**.    
3. In the **launch.json** file, add a configuration object for each flavor. 
Each configuration has a **name**, **request**, **type**, **program**, 
and **args** key.

You can now run the terminal command 
`flutter run --flavor [environment name]` or you can set up a run 
configuration in your IDE.

![Image for VSCode launch configuration step.](/assets/images/docs/flavors/vscode-config.png){:width="100%"}  

## Launching your app flavors

1. Once the flavors are set up, modify the Dart code in 
**lib** > **main.dart** to consume the flavors. 
2. Test the setup using `flutter run --flavor [environment name]` 
at the command line, or by setting up a run configuration in your IDE. 

For examples of build flavors for [iOS (Xcode)][] and [Android][], 
check out the integration test samples in the [Flutter repo][]. 

## More information

* [Build flavors in Flutter (Android and iOS) with different Firebase projects per flavor Flutter Ready to Go][]
* [Flavoring Flutter Applications (Android & iOS)][]
* [Flutter Flavors Setup with multiple Firebase Environments using FlutterFire and Very Good CLI][]

### Packages
There are packages available that support creating flavors for your app. 


* [`flutter_flavor`][]
* [`flutter_flavorizr`][]

[“Launching your app flavors”]: {{site.url}}/deployment/flavors/#launching-your-app-flavors
[Flutter repo]: {{site.repo.flutter}}/blob/master/dev/integration_tests/flavors/lib/main.dart
[iOS (Xcode)]: {{site.repo.flutter}}/tree/master/dev/integration_tests/flavors/ios
[Android]: {{site.repo.flutter}}/tree/master/dev/integration_tests/flavors/android
[Build flavors in Flutter (Android and iOS) with different Firebase projects per flavor Flutter Ready to Go]: {{site.medium}}/@animeshjain/build-flavors-in-flutter-android-and-ios-with-different-firebase-projects-per-flavor-27c5c5dac10b
[Flavoring Flutter Applications (Android & iOS)]: {{site.medium}}/flutter-community/flavoring-flutter-applications-android-ios-ea39d3155346
[Flutter Flavors Setup with multiple Firebase Environments using FlutterFire and Very Good CLI]: https://codewithandrea.com/articles/flutter-flavors-for-firebase-apps/
[`flutter_flavor`]: {{site.pub}}/packages/flutter_flavor
[`flutter_flavorizr`]: {{site.pub}}/packages/flutter_flavorizr
