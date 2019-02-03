## Flutter SDK 다운로드

 1. 다음 설치 번들을 다운로드하여 Flutter SDK의 최신 {{site.sdk.channel}} 릴리즈를 받으세요:  

    [(loading...)](#){:.download-latest-link-{{os}}.btn.btn-primary}

    다른 릴리즈 채널이나 이전 빌드를 받으려면 
    [SDK 아카이브](/docs/development/tools/sdk/archive) 페이지를 확인하세요.
 1. zip 파일의 압축을 풀고 `flutter`를 원하는 설치 위치에 놓으세요.
    (예시. `C:\src\flutter`) (`C:\Program Files\`와 같은 권한이 필요한 위치에 설치하지 마세요.)
 1. `flutter` 디렉토리에서 `flutter_console.bat`파일을 찾은 후 더블클릭하세요.

이제 Flutter 콘솔에서 Flutter 명령을 실행할 수 있습니다.

기존 Flutter의 버전을 업데이트하고 싶다면, 
[Flutter 업그레이드](/docs/development/tools/sdk/upgrading)를 확인하세요.

### Path 추가

일반 윈도우 콘솔에서 Flutter 명령을 실행하고 싶다면, 아래 단계를 수행해여 `Path` 환경 변수에 Flutter를 추가하세요.

* From the Start search bar, type 'env' and select **Edit environment
  variables for your account**
* Under **User variables** check if there is an entry called **Path**:
  * If the entry does exist, append the full path to `flutter\bin` using `;` as
    a separator from existing values.
  * If the entry does not exist, create a new user variable named `Path` with
    the full path to `flutter\bin` as its value.

이러한 변경 내용을 적용하려면 기존 콘솔 창을 닫았다가 다시 열어야 합니다.

### `Flutter doctor` 실행

콘솔에서 Flutter 디렉토리(상단에서 확인)로 이동한 후 설정을 완료하는 데 필요한 플랫폼 디펜던시가 있는지 확인하기 위해 아래 명령을 실행하세요:

```console
C:\src\flutter>flutter doctor
```

이 명령은 당신의 환경을 체크하고 Flutter 설치 상태에 대한 보고서를 보여줍니다.
출력된 내용을 꼼꼼히 보고 설치해야할 다른 소프트웨어가 있는지 또는 수행해야 할 추가 작업이 있는지(**굵은** 글씨로 표시됨) 확인하세요.

예시:

<pre>
[-] Android toolchain - develop for Android devices
    • Android SDK at D:\Android\sdk
    <strong>✗ Android SDK is missing command line tools; download from https://goo.gl/XxQghQ</strong>
    • Try re-installing or updating your Android SDK,
      visit https://flutter.io/setup/#android-setup for detailed instructions.
</pre>

다음 섹션에서는 이러한 작업을 수행하고 설치 과정을 완수하는 방법을 설명합니다.
누락된 디펜던시를 설치한 후에, `flutter doctor` 명령을 다시 실행하여 모든 설정이 올바른지 확인할 수 있습니다.

{% include_relative _analytics.md %}
