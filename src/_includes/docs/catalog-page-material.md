{% assign category = catalog.index | find: "name", categoryName %}

{% if category.subcategories -%}
{% for sub in category.subcategories -%}
{% assign components = catalog.widgets | filterByProperty: "subcategories", sub.name, true %}
{% if components.size != 0 -%}
  
## {{sub.name}}

<div class="card-grid material-cards">
  {% for comp in components -%}
  <a class="card outlined-card" href="{{comp.link}}">
    <div class="card-image-holder-material-3" style="--bg-color: {{sub.color}}">
      <img alt="Rendered example of the {{comp.name}} Material widget." src="{{comp.image.src}}">
      <div class="card-image-material-3-hover">
        <img alt="Decorated background for material widget visualizations." src="{{comp.hoverBackground.src}}" aria-hidden="true">
      </div>
    </div>
    <div class="card-header">
      <header class="card-title">{{comp.name}}</header>
    </div>
    <div class="card-content">
      <p>{{ comp.description | truncatewords: 25 }}</p>
    </div>
  </a>
  {% endfor -%}
</div>

{% endif -%}
{% endfor -%}
{% endif -%}
