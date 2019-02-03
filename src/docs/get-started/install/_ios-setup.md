## iOS 설정

### Xcode 설치

iOS용 Flutter 앱을 개발하기 위해서는 Xcode 9.0 이상 버전이 설치된 맥이 필요합니다.

 1. Xcode 9.0 이상을 설치하세요([웹에서 다운로드](https://developer.apple.com/xcode/) 혹은
    [맥 앱스토어](https://itunes.apple.com/us/app/xcode/id497799835)에서).
 1. 아래 명령을 실행하여 새롭게 설치된 버전을 사용하도록 Xcode 커멘드라인 도구를 설정하세요

    ```terminal
    $ sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
    ```

    최신 버전 Xcode를 사용하고자 할 때, 보통은 이 경로가 올바른 경로입니다.
    다른 버전을 사용하기를 원한다면, 다른 경로를 지정해주세요.
 1. Xcode를 한 번 열어 확인을 선택하거나 커멘트라인에서 `sudo xcodebuild -license`를 입력하여 
    Xcode 라이센스 계약이 서명되었는지 확인하세요.  

Xcode를 사용하여 iOS 기기 또는 시뮬레이터에서 Flutter 앱을 실행할 수 있습니다.

### iOS 시뮬레이터 설정

iOS 시뮬레이터에서 Flutter 앱을 실행하고 테스트하기 위해서, 아래 단계를 수행하세요: 

 1. 맥에서 Spotlight를 통해 혹은 아래 명령을 입력하여 시뮬레이터를 찾으세요.

    ```terminal
    $ open -a Simulator
    ```

 2. 시뮬레이터의 **Hardware > Device**메뉴의 설정에서 시뮬레이터가 64비트 기기(iPhone 5s 이상)를 활용하고 있는지 확인하세요.
 3. 기기 화면 크기에 따라서, 시뮬레이터에서 높은 해상도의 iOS 기기가 화면을 초과할 수 있습니다.
    시뮬레이터의 **Window > Scale** 메뉴에서 기기의 스케일을 설정하세요. 

### 간단한 Flutter 앱 만들고 실행하기

첫번째 Flutter 앱을 만들고 설정이 잘 되는지 확인하기 위해, 아래 단계를 수행하세요:

 1. 커멘드라인에서 아래 명령을 실행하여 새로운 Flutter 앱을 만듭니다:
 
    ```terminal
    $ flutter create my_app
    ```

 2. Flutter's starter 앱이 들어있는 `my_app` 디렉토리가 생성됩니다. 해당 디렉토리로 이동하세요:
 
    ```terminal
    $ cd my_app
    ```
 
 3. 시뮬레이터에서 앱을 실행하기 위해, 시뮬레이터가 실행중인지 확인한 후 다음을 입력하세요:

    ```terminal
    $ flutter run
    ```

### iOS 기기에 배포

Flutter 앱을 실제 iOS 기기에 배포하려면 몇 가지 추가적인 도구와 Apple 계정이 필요합니다.
또한 실제 기기 배포 설정을 해야합니다.

 1. [homebrew](https://brew.sh)를 설치하세요.
 1. homebrew가 최신인지 확인하세요:

    ```terminal
    $ brew update
    ```

 1. 다음 명령을 입력하여 Flutter앱을 iOS 기기에 배포하기 위한 도구를 설치하세요:

    ```terminal
    $ brew install --HEAD usbmuxd
    $ brew link usbmuxd
    $ brew install --HEAD libimobiledevice
    $ brew install ideviceinstaller ios-deploy cocoapods
    $ pod setup
    ```

    {{site.alert.note}}
      위 명령 중 처음 두 명령은 libusbmuxd의 다음 릴리즈까지 일시적으로 문제를 해결하기 위해 필요합니다.
      [libusbmuxd 이슈 #46][]과 [Flutter 이슈 #22595][] 참고.

      [libusbmuxd 이슈 #46]: https://github.com/libimobiledevice/libusbmuxd/issues/46#issuecomment-445502733
      [Flutter 이슈 #22595]: https://github.com/flutter/flutter/issues/22595
    {{site.alert.end}}

    명령이 실패하는 경우에는 `brew doctor`를 실행하고 지시에 따라 문제를 해결하세요.

 1. Xcode 서명 흐름에 따라 프로젝트를 프로비저닝하세요:

     {: type="a"}
     1. Open the default Xcode workspace in your project by running `open
        ios/Runner.xcworkspace` in a terminal window from your Flutter project
        directory.
     1. In Xcode, select the `Runner` project in the left navigation panel.
     1. In the `Runner` target settings page, make sure your Development Team is
        selected under **General > Signing > Team**. When you select a team,
        Xcode creates and downloads a Development Certificate, registers your
        device with your account, and creates and downloads a provisioning
        profile (if needed).

        * To start your first iOS development project, you may need to sign into
          Xcode with your Apple ID. ![Xcode account add][]{:.mw-100}
          Development and testing is supported for any Apple ID. Enrolling in the
          Apple Developer Program is required to distribute your app to the App
          Store. For details about membership types, see
          [Choosing a Membership][].

        * The first time you use an attached physical device for iOS
          development, you will need to trust both your Mac and the Development
          Certificate on that device. Select `Trust` in the dialog prompt when
          first connecting the iOS device to your Mac.

          ![Trust Mac][]{:.mw-100}

          Then, go to the Settings app on the iOS device, select **General >
          Device Management** and trust your Certificate.

        * If automatic signing fails in Xcode, verify that the project's
          **General > Identity > Bundle Identifier** value is unique.
          ![Check the app's Bundle ID][]{:.mw-100}

 1. Start your app by running `flutter run`.

[Check the app's Bundle ID]: /images/setup/xcode-unique-bundle-id.png
[Choosing a Membership]: https://developer.apple.com/support/compare-memberships
[Trust Mac]: /images/setup/trust-computer.png
[Xcode account add]: /images/setup/xcode-account.png
