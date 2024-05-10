{% assign alt = alt | default: caption -%}
{% assign cap = caption | default: '' -%}
{% if width -%}
{% assign w = 'width: ' | append: width | append: ';' -%}
{% else -%}
{% assign w = '' -%}
{% endif -%}
{% if height -%}
{% assign h = 'height: ' | append: height | append: ';' -%}
{% else -%}
{% assign h = '' -%}
{% endif -%}

<figure class="site-figure {{class}}">
  <div class="site-figure-container">
    <img src='/assets/images/docs/{{image}}' class='{{img-class}}' alt='{{alt}}' style='{{w}} {{h}}'>
    {% if cap -%}
      <figcaption class="figure-caption">{{cap}}</figcaption>
    {% endif -%}
  </div>
</figure>
