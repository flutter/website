---
layout: default
toc: false
sitemap: false
---

{% assign url = page.url | regex_replace: '/index$|/index.html$|/$' -%}
{% assign path_parts = url | split: '/' -%}
{% assign topics = sidenav -%}
{% assign path = '' -%}

{% comment %}
  - path_parts[0] == '' because page.url always starts with '/'
{% endcomment -%}

{% for path_part in path_parts -%}
  {% if forloop.first == true -%}
    {% assign path = '' -%}
  {% else -%}
    {% assign path = path | append: '/' | append: path_part -%}
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
