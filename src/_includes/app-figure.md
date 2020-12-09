{% assign alt = include.alt | default: include.caption -%}
{% assign caption = include.caption | default: include.platform -%}
{% if include.path-prefix -%}
  {% assign path = include.path-prefix | append: '/' -%}
{% else -%}
  {% assign path = '' -%}
{% endif -%}

{% if include.platform -%}
  {% assign alt = alt | append: ' on ' | append: include.platform -%}
  {% assign platform_in_lowercase = include.platform | downcase -%}
  {% assign path = path | append: platform_in_lowercase | append: '/' -%}
{% endif -%}

<figure class="site-figure {{include.class}}">
  <div class="site-figure-container">
    {% asset '{{path}}{{include.image}}' class='{{include.img-class}}' alt='{{alt}}' %}
    {% if caption -%}
      <figcaption class="figure-caption">{{caption}}</figcaption>
    {% endif -%}
  </div>
</figure>
