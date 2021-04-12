## iOS setup

### Install Xcode

To develop Flutter apps for iOS, you need a Mac with Xcode installed.

 1. Install the latest stable version of Xcode
    (using [web download][] or the [Mac App Store][]).
 1. Configure the Xcode command-line tools to use the
    newly-installed version of Xcode by
    running the following from the command line:

    ```terminal
    $ sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
    $ sudo xcodebuild -runFirstLaunch
    ```

    This is the correct path for most cases,
    when you want to use the latest version of Xcode.
    If you need to use a different version,
    specify that path instead.

 1. Make sure the Xcode license agreement is signed by
    either opening Xcode once and confirming or running
    `sudo xcodebuild -license` from the command line.

Versions older than the latest stable version may still work,
but are not recommended for Flutter development.
Using old versions of Xcode to target bitcode is not
supported, and is likely not to work.

With Xcode, you’ll be able to run Flutter apps on
an iOS device or on the simulator.

### Set up the iOS simulator

To prepare to run and test your Flutter app on the iOS simulator,
follow these steps:

 1. On your Mac, find the Simulator via Spotlight or
    by using the following command:

    ```terminal
    $ open -a Simulator
    ```

 2. Make sure your simulator is using a 64-bit device
    (iPhone 5s or later) by checking the settings in
    the simulator's **Hardware > Device** menu.
 3. Depending on your development machine's screen size,
    simulated high-screen-density iOS devices
    might overflow your screen. Grab the corner of the
    simulator and drag it to change the scale. You can also
    use the **Window > Physical Size** or **Window > Pixel Accurate**
    options if your computer's resolution is high enough.
    * If you are using a version of Xcode older
    than 9.1, you should instead set the device scale
    in the **Window > Scale** menu.

### Create and run a simple Flutter app

To create your first Flutter app and test your setup,
follow these steps:

 1. Create a new Flutter app by running the following from the
    command line:

    ```terminal
    $ flutter create my_app
    ```

 2. A `my_app` directory is created, containing Flutter's starter app.
    Enter this directory:

    ```terminal
    $ cd my_app
    ```

 3. To launch the app in the Simulator,
    ensure that the Simulator is running and enter:

    ```terminal
    $ flutter run
    ```

### Deploy to iOS devices

To deploy your Flutter app to a physical iOS device
you'll need to set up physical device deployment in Xcode
and an Apple Developer account. If your app is using Flutter plugins,
you will also need the third-party CocoaPods dependency manager.

<ol markdown="1">
<li markdown="1">

You can skip this step if your apps do not depend on
[Flutter plugins][] with native iOS code.
[Install and set up CocoaPods][] by running the following commands:

```terminal
$ sudo gem install cocoapods
```
{{site.alert.note}}
  The default version of Ruby requires `sudo` to install the CocoaPods gem.
  If you are using a Ruby Version manager, you may need to run without `sudo`.
{{site.alert.end}}

</li>

<li markdown="1">

Follow the Xcode signing flow to provision your project:

   {: type="a"}
   1. Open the default Xcode workspace in your project by
      running `open ios/Runner.xcworkspace` in a terminal
      window from your Flutter project directory.
   1. Select the device you intend to deploy to in the device
      drop-down menu next to the run button.
   1. Select the `Runner` project in the left navigation panel.
   1. In the `Runner` target settings page,
      make sure your Development Team is selected
      under **Signing & Capabilities > Team**.

      When you select a team,
      Xcode creates and downloads a Development Certificate,
      registers your device with your account,
      and creates and downloads a provisioning profile (if needed).

      * To start your first iOS development project,
        you might need to sign into
        Xcode with your Apple ID. ![Xcode account add][]{:.mw-100}
        Development and testing is supported for any Apple ID.
        Enrolling in the Apple Developer Program is required to
        distribute your app to the App Store.
        For details about membership types,
        see [Choosing a Membership][].

      <a name="trust"></a>
      * The first time you use an attached physical device for iOS
        development, you need to trust both your Mac and the
        Development Certificate on that device.
        Select `Trust` in the dialog prompt when
        first connecting the iOS device to your Mac.

        ![Trust Mac][]{:.mw-100}

        Then, go to the Settings app on the iOS device,
        select **General > Device Management**
        and trust your Certificate.
        For first time users, you may need to select
        **General > Profiles > Device Management** instead.

      * If automatic signing fails in Xcode, verify that the project's
        **General > Identity > Bundle Identifier** value is unique.
        ![Check the app's Bundle ID][]{:.mw-100}

</li>

<li markdown="1">

Start your app by running `flutter run`
or clicking the Run button in Xcode.

</li>
</ol>

[Check the app's Bundle ID]: /images/setup/xcode-unique-bundle-id.png
[Choosing a Membership]: https://developer.apple.com/support/compare-memberships
[Mac App Store]: https://itunes.apple.com/us/app/xcode/id497799835
[Flutter plugins]: /docs/development/packages-and-plugins/developing-packages#types
[Install and set up CocoaPods]: https://guides.cocoapods.org/using/getting-started.html#installation
[Trust Mac]: /images/setup/trust-computer.png
[web download]: https://developer.apple.com/xcode/
[Xcode account add]: /images/setup/xcode-account.png
