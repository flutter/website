---
title: 윈도우에서 설치
short-title: 윈도우
# js: [{defer: true, url: /assets/archive.js}]
next:
  title: 에디터 설정
  path: /docs/get-started/editor
---

{% assign os = 'windows' -%}

## 시스템 요구 사항

Flutter를 설치하고 실행하기 위해서는 개발 환경이 다음과 같은 최소 요구 사항을 충족해야 합니다:

- **운영 체제**: 윈도우7 SP1 이상 (64-bit)
- **저장 공간**: 400 MB (IDE나 개발 도구 용량은 별도).
- **도구**: Flutter는 윈도우 환경에서 아래 도구가 필요합니다.
  - [윈도우 파워셸 5.0][] 또는 그 이상 버전 (윈도우10에 내장되어 있음)
  - [Git for Windows][] 2.x, with the **Use Git from the Windows Command Prompt** option.

     윈도우용 Git이 이미 설치되어 있다면, git 명령을 명령 프롬프트나 파워셸에서 실행되는지 확인하세요.

{% include_relative _get-sdk-win.md %}

{% include_relative _android-setup.md %}

## 다음 단계

[다음 단계: 에디터 설정](/docs/get-started/editor)

[Git for Windows]: https://git-scm.com/download/win
[윈도우 파워셸 5.0]: https://docs.microsoft.com/en-us/powershell/scripting/setup/installing-windows-powershell
