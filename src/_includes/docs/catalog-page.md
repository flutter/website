{% assign category = catalog.index | find: "name", categoryName %}

{{category.description}}

{% assign components = catalog.widgets | filterByProperty: "categories", categoryName, true %}
{% if components.size != 0 -%}
<div class="card-grid">
{% for comp in components -%}
  <a class="card outlined-card" href="{{comp.link}}">
    <div class="card-image-holder">
      {% if comp.vector -%}
        {{comp.vector}}
      {% elsif comp.image -%}
        <img alt="Image/visualization of the {{comp.name}} widget." src="{{comp.image.src}}">
      {% else -%}
        <img alt="Flutter logo for widget missing visualization image." src="/assets/images/docs/catalog-widget-placeholder.png" aria-hidden="true">
      {% endif -%}
    </div>
    <div class="card-header">
      <header class="card-title">{{comp.name | camelCaseBreaker}}</header>
    </div>
    <div class="card-content">
      <p>{{ comp.description | truncatewords: 25 }}</p>
    </div>
  </a>
{% endfor -%}
</div>
{% endif -%}

{% if category.subcategories and category.subcategories.size != 0 -%}
{% for sub in category.subcategories -%}
  {% assign components = catalog.widgets | filterByProperty: "subcategories", sub.name, true %}
  {% if components.size != 0 -%}
  
  ## {{sub.name}}

  <div class="card-grid">
    {% for comp in components -%}
      <a class="card outlined-card" href="{{comp.link}}">
        <div class="card-image-holder">
          {% if comp.vector -%}
            {{comp.vector}}
          {% elsif comp.image -%}
            <img alt="Rendered image or visualization of the {{comp.name}} widget." src="{{comp.image.src}}">
          {% else -%}
            <img alt="Placeholder Flutter logo in place of missing widget image or visualization." src="/assets/images/docs/catalog-widget-placeholder.png" aria-hidden="true">
          {% endif -%}
        </div>
        <div class="card-header">
          <header class="card-title">{{comp.name | camelCaseBreaker}}</header>
        </div>
        <div class="card-content">
          <p>{{ comp.description | truncatewords: 25 }}</p>
        </div>
      </a>
    {% endfor -%}
  </div>
  {% endif -%}
{% endfor -%}
{% endif %}

Find more widgets in the [widget catalog](/ui/widgets).
