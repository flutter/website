---
layout: default
toc: false
sitemap: false
---

{% assign url = page.url | regexReplace: '/index$|/index.html$|/$' -%}
{% assign pathParts = url | split: '/' -%}
{% assign topics = sidenav -%}
{% assign path = '' -%}

{% comment %}
  - pathParts[0] == '' because page.url always starts with '/'
{% endcomment -%}

{% for pathPart in pathParts -%}
  {% if forloop.first == true -%}
    {% assign path = '' -%}
  {% else -%}
    {% assign path = path | append: '/' | append: pathPart -%}
  {% endif -%}
  {% if forloop.index0 > 0 and path != '/ui' -%}
    {% assign topics = topics | where: "permalink", path -%}
    {% assign topics = topics[0].children | where: "title" -%}
  {% endif -%}
{% endfor -%}

{% if topics -%}
### Topics

{% for topic in topics -%}

{% if topic.permalink == nil -%}
{% if topic contains 'header' %}
#### {{topic.header}}

{% else -%}
  - {{topic.title}}
{% endif -%}
{% else -%}
  - [{{topic.title}}]({{topic.permalink}})
{% endif -%}
{% endfor %}
{% endif -%}

{{content}}
