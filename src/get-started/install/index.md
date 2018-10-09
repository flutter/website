---
title: Install
next:
  title: Set up an editor
  path: /get-started/editor
toc: false
---

Select the operating system on which you are installing Flutter:

{% for os in site.os-list -%}
- [{{os}}](/get-started/install/{{os | downcase}})
{% endfor %}

{{site.alert.important}}
  If you're in China, first read [Using Flutter in China][].

  [Using Flutter in China]: {{site.repo.flutter}}/wiki/Using-Flutter-in-China
{{site.alert.end}}

