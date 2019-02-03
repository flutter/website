## 안드로이드 설정

{{site.alert.note}}
  Flutter는 안드로이드 플랫폼에 종속정인 부분이 있기 때문에 안드로이드 스튜디오를 전부 설치해야 합니다.  
  그러나 다양한 에디터에서 Flutter 앱을 작성할 수 있습니다. 관련 내용은 향후에 설명합니다.
{{site.alert.end}}

### 안드로이드 스튜디오 설치

 1. [안드로이드 스튜디오](https://developer.android.com/studio) 다운드로 및 설치.
 1. 안드로이드 스튜디오를 시작하고 '안드로이드 스튜디오 설치 마법사'를 실행합니다. 
    설치 마법사는 Flutter로 안드로이드를 개발할 때 필요한 최신 안드로이드 SDK, 안드로이드 SDK 플랫폼 도구, 안드로이드 SDK 빌드 도구를 설치합니다.  

### 안드로이드 기기 설정

안드로이드 기기에서 Flutter 앱을 실행하고 테스트하기 위해서, 안드로이드 4.1 (API 16) 이상에서 동작하는 안드로이드 기기가 필요합니다.

 1. 기기에서 **개발자 옵션**과 **USB 디버깅**을 활성화 해야합니다. 
    자세한 사항은 [안드로이드 문서](https://developer.android.com/studio/debug/dev-options)에서 확인하실 수 있습니다.
 1. 윈도우인 경우: [구글 USB 드라이버](https://developer.android.com/studio/run/win-usb)를 설치하세요.
 1. USB케이블을 이용하여 기기를 컴퓨터에 연결하세요. 
    장치에 관한 메시지가 나타나면, 컴퓨터가 장치에 접근할 수 있도록 권한을 부여하세요.
 1. Flutter에 안드로이기 기기가 연결됐는지 확인하기 위해 터미널에서 `flutter devices` 명령을 실행하세요

기본적으로, Flutter는 `adb` 도구에 연결된 버전의 안드로이드 SDK를 사용합니다.
다른 곳에 설치된 안드로이드 SDK를 사용하고 싶다면, `ANDROID_HOME` 환경 변수를 해당 디렉토리로 변경해야 합니다.

### 안드로이드 에뮬레이터 설정

안드로이드 에뮬레이터에서 Flutter 앱을 실행하고 테스트하기 위해, 아래 단계를 수행하세요:

 1. 기기에서 [VM 가속화](https://developer.android.com/studio/run/emulator-acceleration)를 활성화하세요.
 1. **Android Studio > Tools > Android > AVD Manager**를 실행하고
    **Create Virtual Device**를 선택하세요. 
    (**Android** 하위 메뉴는 안드로이드 프로젝트 내부에 있을 때만 나타납니다.)
 1. 기기 해상도를 선택하고 **Next**를 누르세요.
 1. 가상화하려는 안드로이드 버전에 맞게 1개 이상의 시스템 이미지를 선택하고 **Next**를 누르세요.
    _x86_ 또는 _x86\_64_ 를 권장합니다.
 1. 에뮬레이터 성능에서, [하드웨어 가속화](https://developer.android.com/studio/run/emulator-acceleration)를 위해
    **Hardware - GLES 2.0**를 선택하세요.
 1. AVD 구성이 올바른지 확인하고 **Finish**를 선택하세요.

    위 단계에 대한 자세한 내용은 [AVD 관리](https://developer.android.com/studio/run/managing-avds)를 참고하세요.
 1. 안드로이드 가상 기기 관리자에 있는 툴바에서 **Run**을 클릭하세요.
    에뮬레이터가 시작되고 선택한 OS 버전과 기기의 기본 캔버스가 표시됩니다.
