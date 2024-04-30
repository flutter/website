{% assign alt = alt | default: caption -%}
{% assign caption = caption | default: platform -%}
{% if width -%}
{% assign width = 'width: ' | append: width | append: ';' -%}
{% else -%}
{% assign width = '' -%}
{% endif -%}
{% if height -%}
{% assign height = 'height: ' | append: height | append: ';' -%}
{% else -%}
{% assign height = '' -%}
{% endif -%}

{% comment %}
NOTE possibly sneaky introspection, feeling like this should be removed
NOTE(rearch) We second that, never a good idea.
{% endcomment %}
{% if path-prefix -%}
  {% assign path = path-prefix | append: '/' -%}
{% else -%}
  {% assign path = '' -%}
{% endif -%}

{% if platform -%}
  {% assign alt = alt | append: ' on ' | append: platform -%}
  {% assign platform_in_lowercase = platform | downcase -%}
  {% assign path = path | append: platform_in_lowercase | append: '/'  -%}
{% endif -%}

<figure class="site-figure {{class}}">
  <div class="site-figure-container">
    <img src='/assets/images/docs/{{path}}{{image}}' class='{{img-class}}' alt='{{alt}}' style='{{width}} {{height}}'>
    {% if caption -%}
      <figcaption class="figure-caption">{{caption}}</figcaption>
    {% endif -%}
  </div>
</figure>
