{% assign path_base = path_base | default: page.url | regex_replace: 'index$|index.html$' %}
{% assign groups = include.pages
      | where_exp: "recipe", "recipe.url contains path_base"
      | where_exp: "recipe", "recipe.url != path_base"
      | group_by_exp: "recipe", "recipe.url | replace_first: path_base, '' | regex_replace: '^/?([-\w]+).*', '\1'"
      | sort: 'name' -%}

{% for group in groups %}

  {% if group.name == '/' %}
    {% continue %}
  {% endif %}

  <{{include.header_tag}}>{{group.name | capitalize}}</{{include.header_tag}}>

  {% if group.name == 'testing' %}
    {% assign path_base = path_base | append: group.name %}
    {% include docs/cookbook-toc.md pages=group.items path_base=path_base header_tag="h3" %}
  {% else %}
    {% for recipe in group.items | sort: 'title' %}
      {% assign title_lower = recipe.title | downcase %}
      {% if title_lower != group.name %}
        - [{{recipe.title }}]({{ recipe.url }})
      {% endif %}
    {% endfor %}
  {% endif %}
{% endfor %}
