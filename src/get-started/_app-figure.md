{% comment %}
TODO: Fernando, should we set all `figure-caption` to have centered text,
      or locally use class="text-center"? I'd favor the former.
      I've (chalin) temporarily used .text-center below.
{% endcomment -%}

{% assign alt = include.alt | default: include.caption -%}
{% assign caption = include.caption | default: include.platform -%}
{% assign path = 'get-started' -%}

{% if include.platform -%}
  {% assign alt = alt | append: ' on ' | append: include.platform -%}
  {% assign platform_in_lowercase = include.platform | downcase -%}
  {% assign path = path | append: '/' | append: platform_in_lowercase -%}
{% endif -%}

<figure class="site-figure {{include.class}}">
  <div>
      {% asset '{{path}}/{{include.image}}' alt='{{alt}}' %}
      {% if caption -%}
      <figcaption class="figure-caption text-center">{{caption}}</figcaption>
      {% endif -%}
  </div>
</figure>
