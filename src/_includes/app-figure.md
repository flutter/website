{% assign alt = include.alt | default: include.caption -%}
{% assign caption = include.caption | default: include.platform -%}
{% assign path = include.path-prefix | default: 'get-started' -%}

{% if include.platform -%}
  {% assign alt = alt | append: ' on ' | append: include.platform -%}
  {% assign platform_in_lowercase = include.platform | downcase -%}
  {% assign path = path | append: '/' | append: platform_in_lowercase -%}
{% endif -%}

<figure class="site-figure {{include.class}}">
  <div class="site-figure-container">
    {% asset '{{path}}/{{include.image}}' class='{{include.img-class}}' alt='{{alt}}' %}
    {% if caption -%}
    <figcaption class="figure-caption">{{caption}}</figcaption>
    {% endif -%}
  </div>
</figure>
