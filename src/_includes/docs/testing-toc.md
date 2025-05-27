{% comment %}
  Generates a list of testing recipes for the given type. The type 
  corresponds to the name of the directory under cookbook/testing/*.

  Usage: {% include docs/testing_toc.md type='unit' %}
{% endcomment -%}
{% assign dir = 'cookbook/testing/' | append: include.type -%}
{% assign recipes = collections.all | childPagesOf: dir | sort: 'title' %}

{% for recipe in recipes -%}
{% comment -%}
  Omit the index page for the given type
{% endcomment -%}
{% assign frag = recipe.url | split: '/' | last %}
{% if frag != include.type -%}
- [{{ recipe.data.title }}]({{ recipe.url }})
{% endif -%}
{% endfor %}