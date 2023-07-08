{% if entries -%}
Topics:

{% for topic in entries -%}
{% if topic.permalink == nil -%}
  - {{topic.title}}
{% else -%}
  - [{{topic.title}}]({{topic.permalink}})
{% endif -%}
{% endfor %}
{% endif -%}
