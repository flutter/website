## iOS setup

### Install Xcode

To develop Flutter apps for iOS, you need a Mac with Xcode 7.2 or newer:

1. Install Xcode 7.2 or newer (via [web download](https://developer.apple.com/xcode/)
or the [Mac App Store](https://itunes.apple.com/us/app/xcode/id497799835)).
1. Configure the Xcode command-line tools to use the newly-installed version of 
Xcode by running:
```
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```
at the command line.

   This is the correct path for most cases, when you want to use the latest 
   version of Xcode. If you need to use a different version, specify that path 
   instead.
1. Make sure the Xcode license agreement is signed by either opening Xcode once
and confirming or running:
```
sudo xcodebuild -license
```
at the command line.

With Xcode, you’ll be able to run Flutter apps on an iOS device or on the 
Simulator.

### Set up the iOS simulator

To prepare to run and test your Flutter app on the iOS Simulator, follow these 
steps:

1. On your Mac, find the Simulator via Spotlight or by using the following 
command:

    ```
    $ open -a Simulator
    ```

2. Make sure the Simulator is using a 64-bit device (iPhone 5s or later) by 
checking the settings in the **Hardware > Device** menu.
3. Depending on your development machine's screen size, simulated 
high-screen-density iOS devices may overflow your screen. Set the device scale
under the **Window > Scale** menu.
4. Start your app by running `flutter run`.


### Deploy to iOS devices

To deploy your Flutter app to a physical iOS device, you’ll need some additional
tools, an account, and a profile:

1. Install [homebrew](http://brew.sh/).
1. Open the terminal and run these commands to install the tools for deploying 
Flutter apps to iOS devices.

   ```
   $ brew update
   $ brew install --HEAD libimobiledevice
   $ brew install ideviceinstaller ios-deploy
   $ brew install cocoapods
   ```
   If any of these commands fails with an error, run `brew doctor` and follow 
   the instructions for resolving the issue.
   
1. Follow the steps defined by Apple to configure Xcode with your Apple Developer
account and enable deploying with provisioning profiles. To learn how to set up
your profile, see [Apple's official documentation](https://developer.apple.com/library/ios/documentation/IDEs/Conceptual/AppDistributionGuide/MaintainingProfiles/MaintainingProfiles.html).
1. Select your Development Team for the Flutter project.
   1. Open the default Xcode workspace in your project under `ios/Runner.xcworkspace`. 
   1. Select the `Runner` project in the left navigation panel.
   1. In the Target Settings page, make sure your Development Team is selected
under **General > Signing > Team**.
1. Start your app by running `flutter run`.
