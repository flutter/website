---
title: Flutter 문서
short-title: 문서
description: The landing page for Flutter documentation.
---

<div class="card-deck">
{% for card in site.data.docs_cards -%}
  <a class="card" href="{{card.url}}">
    <div class="card-body">
      <header class="card-title">{{card.name}}</header>
      <p class="card-text">{{card.description}}</p>
    </div>
  </a>
{% endfor -%}
</div>

## flutter.io의 새로운 기능

**2018년 11월 5일**

새로워진 Flutter 웹사이트에 오신 것을 환영합니다!

지난 몇 달 동안 웹사이트를 재설계했고 어떻게 정보를 정리되는지 보았습니다.
여러분이 문서를 더 쉽게 찾을 수 있기를 바랍니다.
웹 사이트 변경 사항은 다음과 같습니다: 

* [첫](/) 페이지 수정
* [쇼케이스](/showcase) 페이지 수정
* [커뮤니티](/community) 페이지 수정
* 왼쪽 메뉴에서 내비게이션 수정
* 대부부의 페이지 오른쪽에 있는 목차

새로운 콘텐츠는 다음과 같습니다:

* Flutter 내부 심층 탐구,
  [Inside Flutter](/docs/resources/inside-flutter)
* [기술 영상 자료](/docs/resources/videos)
* [상태 관리](/docs/development/data-and-backend/state-mgmt)
* [백그라운드 작업](/docs/development/packages-and-plugins/background-processes)
* [Flutter 빌드 모드](/docs/testing/build-modes)
{% comment %}
* How to connect [a native debugger _and_
  a Dart debugger to your app](/docs/testing/oem-debuggers)
  (not yet complete)
{% endcomment %}

개편된 사이트에 대해 질문이나 의견이 있으시면, 
[이슈를 등록해주세요]({{site.repo.this}}/issues).

한글 사이트에 대한 [이슈도 등록해주세요](https://github.com/bro-jo/website/pulls).

## 플러터가 처음인가요?

[시작하기](/docs/get-started/install)와
 [첫번째 앱을 작성해보세요](/docs/get-started/codelab)를 완료했다면, 
다음 단계가 준비되어 있습니다.

[안드로이드 개발자를 위한 Flutter](/docs/get-started/flutter-for/android-devs)
: 안드로이드 개발 경험이 있다면 이 팁을 봐보세요.

[iOS 개발자를 위한 Flutter](/docs/get-started/flutter-for/ios-devs)
: iOS 개발 경험이 있다면 이 팁을 봐보세요.

[웹 개발자를 위한 Flutter](/docs/get-started/flutter-for/web-devs)
: 웹 경험이 있다면 HTML과 Flutter의 유사한 점을 살펴보세요.

[리액트 네이티브 개발자를 위한 Flutter](/docs/get-started/flutter-for/react-native-devs)
: 리액트 네이티브 개발 경험이 있다면 이 팁을 봐보세요.

[자마린 폼즈 개발자를 위한 Flutter](/docs/get-started/flutter-for/xamarin-forms-devs)
: 자마린 폼즈 개발 경험이 있다면 이 팁을 봐보세요.

[Flutter에서 레이아웃](/docs/development/ui/layout)
: 레이아웃을 만드는 방법을 배워보세요. Flutter에서는 모든 게 위젯입니다.

[Flutter 앱에 상호작용 추가하기](/docs/development/ui/interactive)
: 상태를 저장할 수 있는 위젯을 만드는 방법을 배워보세요.

[Flutter 위젯 프레임워크 둘러보기](/docs/development/ui/widgets-intro)
: 리액트 스타일 프레임워크 Flutter에 대해 더 알아봅시다.

[자주 묻는 질문](/docs/resources/faq)
: 자주 묻는 질문에 대한 답변을 살펴보세요.


## 한 단계 더 나아가고 싶나요?

기본적인 내용을 숙달했으면 이제 다음 페이지를 봐보세요.

[Cookbook](/docs/cookbook)
: 일반적인 Flutter 사용 사례를 다루는 레시피 모음. (개선 중)

[깃허브에 있는 예제 앱](https://github.com/flutter/samples/blob/master/INDEX.md)
: Flutter를 잘 활용한 샘플 앱 모음. (개선 중)

[Flutter에서 리소스와 이미지 파일 추가하기](/docs/development/ui/assets-and-images)
: Flutter 앱에 리소스를 추가하는 방법.

[Flutter에서 애니메이션](/docs/development/ui/animations)
: 기본 애니메이션과, hero 애니메이션, staggered 애니메이션 등 Flutter가 지원하는 애니메이션 생성 방법.

[내비게이션 및 라우팅](/docs/development/ui/navigation)
: 새로운 스크린을 만들고 새로운 스크린으로 이동하는 방법 (플러터에서는 _route_ 라고 부릅니다).

[국제화](/docs/development/accessibility-and-localization/internationalization)
: 글로벌화하세요! 플러터앱을 국제화하는 방법.

[Effective Dart](https://www.dartlang.org/guides/language/effective-dart)
: 더 나은 다트 코드를 작성법 가이드.

## 전문적인 주제

관심있는 주제를 더 깊게 살펴보세요.

[위젯 검사 도구](/docs/development/tools/inspector)
: 위젯 트리를 탐색하거나, DEBUG 배너를 없애거나, 성능 오버레이 표시해주는 등 다양한 기능을 가능하게 해주는 강력한 도구인 위젯 검사 도구를 사용하는 방법.

[사용자 지정 글꼴](/docs/cookbook/design/fonts)
: 새로운 폰트를 앱에 추가하는 방법.

[문자 입력](/docs/cookbook/forms/text-input)
: 문자를 입력받는 기본적인 방법.

[Flutter 앱 디버깅](/docs/testing/debugging)
: 앱 디버깅을 위한 도구와 팁

완성된 목록은 아닙니다.
왼쪽 탐색 메뉴를 사용해주세요. 다른 주제를 찾고 싶으시면 검색창을 이용해주세요. 
