---
title: Linux install
short-title: Linux
# js: [{defer: true, url: /assets/archive.js}]
next:
  title: 에디터 설정
  path: /docs/get-started/editor
---

{% assign os = 'linux' -%}

## 시스템 요구 사항

Flutter를 설치하고 실행하기 위해서는 개발 환경이 다음과 같은 최소 요구 사항을 충족해야 합니다:

- **운영 체제**: Linux (64-bit)
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
- **Shared libraries**: Flutter `test` command depends on this library being available in your environment.
  - `libGLU.so.1` - provided by mesa packages e.g. `libglu1-mesa` on Ubuntu/Debian

{% include_relative _get-sdk.md %}

{% include_relative _path-mac-linux.md %}

{% include_relative _android-setup.md %}

## Next step

[Next step: Configure Editor](/docs/get-started/editor)
