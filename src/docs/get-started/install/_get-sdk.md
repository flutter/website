{% if os == 'linux' -%}
  {% assign unzip = 'tar xf' -%}
  {% assign file_ext = '.tar.xz' -%}
{% else -%}
  {% assign unzip = 'unzip' -%}
  {% assign file_ext = '.zip' -%}
{% endif -%}

## Flutter SDK 다운로드 {#get-sdk}

 1. 다음 설치 번들을 다운로드하여 Flutter SDK의 최신 {{site.sdk.channel}} 릴리즈를 받으세요:

    [(loading...)](#){:.download-latest-link-{{os}}.btn.btn-primary}

    다른 릴리즈 채널이나 이전 빌드를 받으려면 
        [SDK 아카이브](/docs/development/tools/sdk/archive) 페이지를 확인하세요.
 1. 다음 예시처럼 원하는 위치에 압축을 푸세요:

    {% comment %}
      Our JS also updates the filename in this template, but it doesn't include the terminal formatting:

      {% prettify shell %}
      $ cd ~/development
      $ {{unzip}} ~/Downloads/[[download-latest-link-filename]]flutter_{{os}}_vX.X.X-{{site.sdk.channel}}{{file_ext}}[[/end]]
      {% endprettify %}
    {% endcomment -%}

    ```terminal
    $ cd ~/development
    $ {{unzip}} ~/Downloads/flutter_{{os}}_vX.X.X-{{site.sdk.channel}}{{file_ext}}
    ```

 1. `flutter` 도구를 path에 추가하세요:

    ```terminal
    $ export PATH="$PATH:`pwd`/flutter/bin"
    ```

    이 명령은 _현재_ 터미널 창에 대해서만 `PATH` 변수를 설정합니다.
    Flutter를 path에 영구적으로 추가하고 싶다면, 
    [Path 추가](#update-your-path)를 참고하세요. 

이제 Flutter 명령을 실행할 수 있습니다!

{{site.alert.note}}
  기존 Flutter의 버전을 업데이트하고 싶다면, 
  [Flutter 업그레이드](/docs/development/tools/sdk/upgrading)를 확인하세요.
{{site.alert.end}}

### Flutter doctor 실행

설정을 완료하는 데 필요한 플랫폼 디펜던시가 있는지 확인하기 위해 아래 명령을 실행하세요.
(자세한 출력을 원한다면, `-v` 플래그를 추가하세요)

```terminal
$ flutter doctor
```

이 명령은 당신의 환경을 체크하고 보고서를 터미널 창에 보여줍니다.
다트 SDK는 플러터와 함께 번들로 제공되기 때문에 별도로 설치할 필요가 없습니다.
출력된 내용을 꼼꼼히 보고 설치해야할 다른 소프트웨어가 있는지 또는 수행해야 할 추가 작업이 있는지(**굵은** 글씨로 표시됨) 확인하세요.

예시:

<pre>
[-] Android toolchain - develop for Android devices
    • Android SDK at /Users/obiwan/Library/Android/sdk
    <strong>✗ Android SDK is missing command line tools; download from https://goo.gl/XxQghQ</strong>
    • Try re-installing or updating your Android SDK,
      visit https://flutter.io/setup/#android-setup for detailed instructions.
</pre>

다음 섹션에서는 이러한 작업을 수행하고 설치 과정을 완수하는 방법을 설명합니다.
누락된 디펜던시를 설치한 후에, `flutter doctor` 명령을 다시 실행하여 모든 설정이 올바른지 확인할 수 있습니다.

{% include_relative _analytics.md %}
