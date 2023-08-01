{% if entries -%}
### Topics

{% for topic in entries -%}
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
