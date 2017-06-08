## iOS setup

### Install Xcode

To develop Flutter apps for iOS, you need a Mac with Xcode 7.2 or newer:

1. Install Xcode 7.2 or newer (via [web download](https://developer.apple.com/xcode/) or
the [Mac App Store](https://itunes.apple.com/us/app/xcode/id497799835)).
1. Configure the Xcode command-line tools to use the newly-installed version of Xcode by
running `sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer` from
the command line.

   This is the correct path for most cases, when you want to use the latest version of Xcode.
   If you need to use a different version, specify that path instead.
1. Make sure the Xcode license agreement is signed by either opening Xcode once and confirming or
running `sudo xcodebuild -license` from the command line.

With Xcode, you’ll be able to run Flutter apps on an iOS device or on the simulator.

### Set up the iOS simulator

To prepare to run and test your Flutter app on the iOS simulator, follow these steps:

1. On your Mac, find the Simulator via Spotlight or by using the following command:

    ```
    $ open -a Simulator
    ```

2. Make sure your simulator is using a 64-bit device (iPhone 5s or later) by checking the settings
in the simulator's **Hardware > Device** menu.
3. Depending on your development machine's screen size, simulated high-screen-density iOS devices
may overflow your screen. Set the device scale under the **Window > Scale** menu in the simulator.
4. Start your app by running `flutter run`.


### Deploy to iOS devices

To deploy your Flutter app to a physical iOS device, you’ll need some additional tools, an Apple account, and follow a few steps for physical device deployment from Apple:

1. Install [homebrew](http://brew.sh/).
1. Open the terminal and run these commands to install the tools for deploying Flutter apps to
iOS devices.

   ```
   $ brew update
   $ brew install --HEAD libimobiledevice
   $ brew install ideviceinstaller ios-deploy
   $ brew install cocoapods
   ```
   If any of these commands fails with an error, run `brew doctor` and follow the instructions
   for resolving the issue.

1. Follow Xcode's automatic signing flow to provision your project.
    1. Open the default Xcode workspace in your project with `open ios/Runner.xcworkspace` inside your Flutter project directory.
    1. Select the `Runner` project in the left navigation panel.
    1. In the `Runner` target settings page, make sure your Development Team is selected under **General > Signing > Team**. This will create and download a Development Certificate, register your device with your account, create and download a provisioning profile if needed.
        * If you have never done iOS development on iOS, you may need to sign in with your Apple ID in Xcode first.
        ![Xcode account add](/images/setup/xcode-account.png)  
        Development and testing is possible on a vanilla Apple ID but enrolling in the Apple Developer Program will be required to distribute your app to the App Store. See more about their Apple's [membership comparison](https://developer.apple.com/support/compare-memberships).
        * If you never used the current physical device for iOS development, you may need to trust the Development Certificate on the device in the Settings app via **General > Device Management** and trust your Certificate.
        * Xcode's automatic signing may fail if the project's Bundle Identifier isn't unique under **General > Identity > Bundle Identifier**.
        ![Check the app's Bundle ID](/images/setup/xcode-unique-bundle-id.png)
1. Start your app by running `flutter run`.
