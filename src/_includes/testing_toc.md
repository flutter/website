{% comment %}
  Generates a list of testing recipes for the given type. The type corresponds
  to the name of the directory under cookbook/testing/*.

  Usage: {% include testing_toc.md type='unit' %}
{% endcomment -%}

{% assign dir = 'cookbook/testing/' | append: include.type %}

{% assign recipes = site.pages | where_exp:"item", "item.dir contains dir" | sort: 'title' %}

{% for recipe in recipes -%}
{% comment %}
  Exclude index pages (all other pages will end in `.html`).
{% endcomment -%}
{% if recipe.url contains '.html' -%}
- [{{ recipe.title }}]({{ recipe.url }})
{% endif -%}
{% endfor %}