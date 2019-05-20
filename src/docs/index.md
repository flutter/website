---
title: Flutter Documentation
short-title: Docs
description: The landing page for Flutter documentation.
---

{% for card in site.data.docs_cards -%}
  {% capture index0Modulo3 %}{{ forloop.index0 | modulo:3 }}{% endcapture %}
  {% capture indexModulo3 %}{{ forloop.index | modulo:3 }}{% endcapture %}
  {% if index0Modulo3 == '0' %}
  <div class="card-deck mb-4">
  {% endif %}
    <a class="card" href="{{card.url}}">
      <div class="card-body">
        <header class="card-title">{{card.name}}</header>
        <p class="card-text">{{card.description}}</p>
      </div>
    </a>
  {% if indexModulo3 == '0' %}
  </div>
  {% endif %}
{% endfor -%}

## 사이트 새소식

**2019년 5월 7일, Google I/O가 열렸습니다**

[Flutter 1.5](https://developers.googleblog.com/2019/05/Flutter-io19.html)가 출시되었습니다!

이번 업데이트에 대한 더 자세한 정보는, [릴리즈 노트](https://github.com/flutter/flutter/wiki/Release-Notes-Flutter-1.5.4)
나 [릴리즈 다운로드](/docs/development/tools/sdk/archive)를 살펴보세요.

[What's new archive](/docs/whats-new-archive)

## Flutter를 처음 접하셨나요?

[첫번째 Flutter 앱 작성하기](/docs/get-started/codelab)를 포함한
[시작하기](/docs/get-started/install)를 끝내고 나서
다음 단계로 아래 것들을 진행해보세요.

### 문서

다른 플랫폼에서 오셨나요? 다음 리소스를 참고해보세요.
[Android](/docs/get-started/flutter-for/android-devs),
[iOS](/docs/get-started/flutter-for/ios-devs),
[Web](/docs/get-started/flutter-for/web-devs),
[React Native](/docs/get-started/flutter-for/react-native-devs),
[Xamarin.Forms](/docs/get-started/flutter-for/xamarin-forms-devs)

[Flutter에서 레이아웃 구현하기](/docs/development/ui/layout)
: 모든 것이 위젯인 Flutter에서 레이아웃을 어떻게 작성하는 지 알아봅니다.

[Flutter 앱에 인터렉션 추가하기](/docs/development/ui/interactive)
: 상태를 가진 위젯을 추가하는 방법에 대해 알아봅니다.

[Flutter 위젯 프레임워크 알아보기](/docs/development/ui/widgets-intro)
: Flutter의 리액트 스타일 프레임워크에 대해 알아봅니다.

[FAQ](/docs/resources/faq)
: 자주 물어보는 질문에 대한 답변을 알아봅시다.

### 비디오

[Flutter Youtube channel]({{site.social.youtube}})에서 도움이 될만한 비디오를 제공하고 있습니다!
특히, Flutter in Focus 시리즈를 살펴보시고 [videos](/docs/resources/videos) 페이지에서 다른 시리즈에 대해서도 알아보세요.

<iframe style="max-width: 100%" width="560" height="315" src="https://www.youtube.com/embed/wgTBLj7rMPM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
Flutter in Focus: 10분 내에 알아보는 Flutter 특징들.<br>
[Flutter in Focus playlist](https://www.youtube.com/playlist?list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2)

Flutter에서는 "모든 것이 위젯입니다"! 상태가 없는(stateless) 위젯과 상태가 있는(Stateful) 위젯, 
두가지 종류의 위젯에 대해 더 자세히 이해하고 싶다면 [Flutter in Focus](https://www.youtube.com/playlist?list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2) 시리즈의 일부인
아래 비디오들을 참고해보세요.

<iframe style="max-width: 100%" width="560" height="315" src="https://www.youtube.com/embed/wE7khGHVkYY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe> <iframe width="560" height="315" src="https://www.youtube.com/embed/AqCMFXEmf3w" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## 더 깊게 알아보고 싶으신가요?

엔지니어가 코드를 작성하고 실수를 만들고 수정하는 과정을 지켜보는 것으로 무언가를 얻고싶다면,
[Boring Flutter Show](https://www.youtube.com/watch?v=vqPG1tU6-c0&list=PLjxrf2q8roU28W3pXbISJbVA5REsA41Sx&index=3&t=9s)
비디오 시리즈를 살펴보세요.

<iframe style="max-width: 100%" width="560" height="315" src="https://www.youtube.com/embed/vqPG1tU6-c0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
[Boring Flutter Show playlist](https://www.youtube.com/watch?v=vqPG1tU6-c0&list=PLjxrf2q8roU28W3pXbISJbVA5REsA41Sx&index=3&t=9s)

아래 문서들도 살펴보시면 유용합니다.

* [패키지 사용하기](/docs/development/packages-and-plugins/using-packages)
* [어셋과 이미지 추가하기](/docs/development/ui/assets-and-images)
* [네비게이션과 라우팅](/docs/development/ui/navigation)
* [상태 관리](/docs/development/data-and-backend/state-mgmt/intro)
* [애니메이션](/docs/development/ui/animations)

