{% assign alt = alt | default: caption -%}
{% assign caption = caption | default: '' -%}
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

<figure class="{{class}}">
  <div class="site-figure-container">
    <img src='/assets/images/docs/{{image}}' class='{{img-class}}' alt='{{alt}}' style='{{width}} {{height}}'>
    {% if caption -%}
      <figcaption class="figure-caption">{{caption}}</figcaption>
    {% endif -%}
  </div>
</figure>
