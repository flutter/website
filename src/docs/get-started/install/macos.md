---
title: 맥OS에서 설치
short-title: 맥OS
next:
  title: 에디터 설정
  path: /docs/get-started/editor
---

{% assign os = 'macos' -%}

## 시스템 요구 사항

Flutter를 설치하고 실행하기 위해서는 개발 환경이 다음과 같은 최소 요구 사항을 충족해야 합니다:

- **운영 체제**: macOS (64-bit)
- **저장 공간**: 700 MB (IDE나 개발 도구 용량은 별도).
- **도구**: Flutter는 맥OS 환경에서 아래 커멘트 라인 도구가 필요합니다. 
  - `bash`
  - `curl`
  - `git` 2.x
  - `mkdir`
  - `rm`
  - `unzip`
  - `which`

{% include_relative _get-sdk.md %}

{% include_relative _path-mac-linux.md %}

## 플랫폼 설정

MacOS에서는 iOS 및 Android용 Flutter 앱을 모두 개발할 수 있습니다. 
첫번째 Flutter 앱을 만들고 실행하기 위해 두 플랫폼 중 하나 이상 설치를 완료하세요. 

{% include_relative _ios-setup.md %}

{% include_relative _android-setup.md %}

## 다음 단계

[다음 단계: 에디터 설정](/docs/get-started/editor)
