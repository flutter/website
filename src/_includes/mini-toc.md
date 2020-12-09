{% if entries -%}
Topics:

{% for topic in entries -%}
{% if topic.permalink == nil -%}
  - {{topic.title}}
{% elsif topic.permalink contains '://' -%}
  - [{{topic.title}}<i class="fas fa-external-link-alt"></i>]({{topic.permalink}})
{% else -%}
  - [{{topic.title}}]({{topic.permalink}})
{% endif -%}
{% endfor %}
{% endif -%}
