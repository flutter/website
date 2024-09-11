{% for section in catalog.index %}
  {% if section.name == categoryName %}
    {% assign category = section %}
    {% break %}
  {% endif %}
{% endfor %}

{{category.description}}

{% assign components = catalog.widgets | widget_filter: "categories", categoryName %}
{% if components.size != 0 -%}
<div class="card-grid">
{% for comp in components -%}
  <div class="card">
    <a href="{{comp.link}}">
      <div class="card-image-holder">
        {% if comp.vector -%}
          {{comp.vector}}
        {% elsif comp.image -%}
          <img alt="Image/visualization of the {{comp.name}} widget." src="{{comp.image.src}}">
        {% else -%}
          <img alt="Flutter logo for widget missing visualization image." src="/assets/images/docs/catalog-widget-placeholder.png" aria-hidden="true">
        {% endif -%}
      </div>
    </a>
    <div class="card-body">
      <a href="{{comp.link}}"><header class="card-title">{{comp.name}}</header></a>
      <p class="card-text">{{ comp.description | truncatewords: 25 }}</p>
    </div>
  </div>
{% endfor -%}
</div>
{% endif -%}

{% if category.subcategories and category.subcategories.size != 0 -%}
{% for sub in category.subcategories -%}
  {% assign components = catalog.widgets | widget_filter: "subcategories", sub.name %}
  {% if components.size != 0 -%}
  
  ## {{sub.name}}

  <div class="card-grid">
    {% for comp in components -%}
      <div class="card">
        <a href="{{comp.link}}">
          <div class="card-image-holder">
            {% if comp.vector -%}
              {{comp.vector}}
            {% elsif comp.image -%}
              <img alt="Rendered image or visualization of the {{comp.name}} widget." src="{{comp.image.src}}">
            {% else -%}
              <img alt="Flutter logo for widget missing visualization image." src="/assets/images/docs/catalog-widget-placeholder.png" aria-hidden="true">
            {% endif -%}
          </div>
        </a>
        <div class="card-body">
          <a href="{{comp.link}}"><header class="card-title">{{comp.name}}</header></a>
          <p class="card-text">{{ comp.description | truncatewords: 25 }}</p>
        </div>
      </div>
    {% endfor -%}
  </div>
  {% endif -%}
{% endfor -%}
{% endif %}

Find more widgets in the [widget catalog](/ui/widgets).
