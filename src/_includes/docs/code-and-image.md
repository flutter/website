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
  <div class="row {{figure-class}}">
      <div class="col-md-7 {{code-class}}" style="padding-right:12px"> 
        {{code}}
      </div>
      <div class="col-md-5" style="padding-left:0">
        <img src='/assets/images/docs/{{image}}' class='{{img-class}}' alt='{{alt}}' style='{{width}} {{height}}'>
         {% if caption -%}
           <figcaption class="figure-caption {{figcaption-class}}" style="margin-top: 6px">
            {{caption}}
           </figcaption>
        {% endif -%}
      </div>
  </div>
</figure>


