{% for section in catalog.index %}
  {% if section.name == categoryName %}
    {% assign category = section %}
    {% break %}
  {% endif %}
{% endfor %}

{% if category.subcategories -%}
{% for sub in category.subcategories -%}
{% assign components = catalog.widgets | widget_filter: "subcategories", sub.name %}
{% if components.size != 0 -%}

## {{sub.name}}

<div class="card-grid">
  {% for comp in components -%}
  <div class="card">
    <a href="{{comp.link}}">
      <div class="card-image-holder-material-3" style="--bg-color: {{sub.color}}">
        <img alt="Rendered example of the {{comp.name}} Material widget." src="{{comp.image.src}}">
        <div class="card-image-material-3-hover">
          <img alt="Decorated background for material widget visualizations." src="{{comp.hoverBackground.src}}" aria-hidden="true">
        </div>
      </div>
    </a>
    <div class="card-body">
      <a href="{{comp.link}}"><header class="card-title card-title-material-3">{{comp.name}}</header></a>
      <p class="card-text">{{ comp.description | truncatewords: 25 }}</p>
    </div>
  </div>
  {% endfor -%}
</div>

{% endif -%}
{% endfor -%}
{% endif -%}
