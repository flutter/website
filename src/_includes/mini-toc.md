{% if entries -%}
### Topics

{% for topic in entries -%}
{% if topic.permalink == nil -%}
{% if topic contains 'header' %}
#### {{topic.header}}

{% else -%}
  - {{topic.title}}
{% endif -%}
{% elsif topic.permalink contains '://' -%}
  - [{{topic.title}}<i class="fas fa-external-link-alt"></i>]({{topic.permalink}})
{% else -%}
  - [{{topic.title}}]({{topic.permalink}})
{% endif -%}
{% endfor %}
{% endif -%}
