---
title: 리눅스 설치
short-title: 리눅스
# js: [{defer: true, url: /assets/archive.js}]
next:
  title: 에디터 설정
  path: /docs/get-started/editor
---

{% assign os = 'linux' -%}

## 시스템 요구 사항

Flutter를 설치하고 실행하기 위해서는 개발 환경이 다음과 같은 최소 요구 사항을 충족해야 합니다:

- **운영 체제**: 리눅스 (64-bit)
- **저장 공간**: 600 MB (IDE나 개발 도구 용량은 별도).
- **도구**: Flutter는 리눅스 환경에서 아래 커멘트 라인 도구가 필요합니다. 
  - `bash`
  - `curl`
  - `git` 2.x
  - `mkdir`
  - `rm`
  - `unzip`
  - `which`
  - `xz-utils`
- **공유 라이브러리**: 리눅스 환경에서는 아래 라이브러리가 사용 가능한 상태여야만 Flutter의 `test` 명령을 실행할 수 있습니다.  
  - `libGLU.so.1` - mesa 패키지에 의해 제공됨 (예, Ubuntu/Debian에서는 `libglu1-mesa`)

{% include_relative _get-sdk.md %}

{% include_relative _path-mac-linux.md %}

{% include_relative _android-setup.md %}

## 다음 단계

[다음 단계: 에디터 설정](/docs/get-started/editor)
