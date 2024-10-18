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


<figure class="code-and-image {{class}}">
  <div class="{{code-class}}"> 
    {{code}}
  </div>
  <div>
    <img src='/assets/images/docs/{{image}}' class='{{img-class}}' alt='{{alt}}' style='{{width}} {{height}}'>
     {% if caption -%}
     <figcaption class="figure-caption {{figcaption-class}}">
       {{caption}}
     </figcaption>
    {% endif -%}
  </div>
</figure>


