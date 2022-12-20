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

You also might use flavors for feature development. 
If you’ve built a new feature and want to try it out, 
you could set up a flavor to test it out. 
Your production code remains unaffected 
until you're ready to deploy your new feature.

Flavors let you define compile-time configurations 
and set parameters that are read at runtime to customize
your app's behavior.

This document guides you through setting up Flutter flavors for iOS and Android. 

## Environment set up
Prerequisites:
* Xcode installed
* An existing project 

To set up flavors in iOS, you’ll define build configurations in Xcode. 

## Creating flavors in iOS

<ol markdown="1">
<li markdown="1">

Open your project in Xcode.

</li>
<li markdown=1>

Select **Runner** > **New Scheme** from the menu to add a new `Scheme`.  
* A scheme describes how Xcode runs different actions. 
  For the purposes of this guide, the example _flavor_ and _scheme_ are 
  named `free`. 
  The build configurations in the `free` scheme 
  have the `-free` suffix. 

</li>
<li markdown="1">

Duplicate the build configurations to differentiate between the 
default configurations that are already available and the new configurations 
for the `free` scheme. 
* Under the **Info** tab at the end of the 
**Configurations** dropdown list, click the plus button and duplicate 
each configuration name (Debug, Release, and Profile). 
Duplicate the listed production configurations, once for each environment. 

![Step 3 Xcode image](/assets/images/docs/flavors/step3-ios-build-config.png){:width="100%"}
{{site.alert.note}}
  Your configurations should be based on your **Debug.xconfig** or **Release.xcconfig**
  file, not the **Pods-Runner.xcconfigs**. You can check this by expanding the configuration names. 
{{site.alert.end}}

</li>
<li markdown="1">

To match the development flavor, add `-free` 
at the end of each new configuration name. 

</li>
<li markdown="1">

Change the `free` scheme to match the development 
build configurations already created.
* In the **Runner** project, click **Manage Schemes…** and a pop up window opens. 
* Double click the development scheme. In the next step 
(as shown in the screenshot), you’ll modify each scheme 
to match its dev build configuration:

![Step 5 Xcode image](/assets/images/docs/flavors/step5-ios-scheme.png){:width="100%"}

</li>
</ol>

## Using flavors in iOS

Now that you’ve set up your development flavor, 
you can, for example, add different product bundle identifiers per flavor. 
A _bundle identifier_ uniquely identifies your application. 
In this example, we set the **Debug-free-example** value to equal 
`com.flavor-test.dev`. 

<ol markdown="1">
<li markdown="1">

Change the app bundle identifier to differentiate between schemes. 
In **Product Bundle Identifier**, append `.free` to each -free scheme value.

![Step 1 using flavors image.](/assets/images/docs/flavors/step1-using-flavors.png){:width="100%"}  

</li>
<li markdown=1>

In the **Build Settings**, set the **Product Name** value to match each flavor. 

![Step 2 using flavors image.](/assets/images/docs/flavors/step2-using-flavors.png){:width="100%"}  

</li>
<li markdown=1>

Add the display name to **info.plist**. Create a new key in **info.plist** called **Bundle Display Name** 
with the value `$(PRODUCT_NAME)`. 

![Step 3 using flavors image.](/assets/images/docs/flavors/step3-using-flavors.png){:width="100%"}    

</li>
</ol>

Now you have set up your development flavor by making a `free` scheme 
in Xcode and setting the build configurations for that scheme. 

For more information, skip to the [“Launching your app flavors”][] 
section at the end of this document.

### Plugin configurations

If your app has a Flutter plugin, you will need to update the `ios/Podfile`. 

1. In `ios/Podfile` change the default of **Debug**, **Profile**, and **Release** 
to match the Xcode build configurations for the `free` scheme.

```ruby
project 'Runner', {
  'Debug-free' => :debug,
  'Debug-production' => :debug,
  'Profile-free' => :release,
  'Profile-production' => :release,
  'Release-free' => :release,
  'Release-production' => :release,
}
```

## Using flavors in Android

Setting up flavors in Android can be done in your project's 
**build.gradle** file.

1. In your IDE, inside your Flutter project, 
navigate to **android** > **app** > **build.gradle**.   

![Step 1 using flavors in Android image.](/assets/images/docs/flavors/android-step1.png){:width="100%"}    

Add a flavor object with the specified environments along with values for 
**dimension**, **resValue**, and **applicationId**. 
The name of the application for each build is located in **resValue** 
(as shown in the screenshot below from VSCode).
## Setting up launch configurations

Next, you'll add a **launch.json** file allows you to run the command 
`flutter run --flavor [environment name]`.    
In VSCode, set up the launch configurations as follows:    
1. In the root directory of your project, add a folder called **.vscode**.    
2. Inside the **.vscode** folder, create a file named **launch.json**.    
3. In the **launch.json** file, add a configuration object for each flavor. 
Each configuration has a **name**, **request**, **type**, **program**, 
and **args** key.

You can now run the terminal command 
`flutter run --flavor [environment name]` or you can set up a run 
configuration in your IDE.

```ruby
productFlavors {
    development {
        dimension "default"
        resValue "string", "app_name", "dev free flavor example"
        applicationId ".dev"
    }
    production {
        dimension "default"
        resValue "string", "app_name", "prod free flavor example"
        applicationId ""
    }
}
``` 

## Launching your app flavors

1. Once the flavors are set up, modify the Dart code in 
**lib** > **main.dart** to consume the flavors. 
2. Test the setup using `flutter run --flavor [environment name]` 
at the command line, or by setting up a run configuration in your IDE. 

For examples of build flavors for [iOS (Xcode)][] and [Android][], 
check out the integration test samples in the [Flutter repo][]. 

## More information
For more information on creating and using flavors, checkout
the following resources:
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
