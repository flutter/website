---
title: 설치
next:
  title: 에디터 설정
  path: /docs/get-started/editor
---

Flutter를 설치할 운영 체제를 선택해주세요:

<div class="card-deck mb-8">
{% for os in site.os-list %}
  {% assign os-korean = '' %}
  {% if os == 'Windows' %}
    {% assign os-korean = '윈도우' %} 
  {% endif %}
  {% if os == 'macOS' %}
    {% assign os-korean = '맥OS' %} 
  {% endif %}
  {% if os == 'Linux' %}
    {% assign os-korean = '리눅스' %} 
  {% endif %}
  <a class="card" href="/docs/get-started/install/{{os | downcase}}">
    <div class="card-body">
      <header class="card-title text-center m-0">
        {{os-korean}}
        <i class="fab fa-{{os | downcase}}"></i>
      </header>
    </div>
  </a>
{% endfor %}
</div>

{{site.alert.important}}
  중국에 있다면, 먼저 [중국에서 플러터 사용하기](/community/china)를 읽어보세요.
{{site.alert.end}}

