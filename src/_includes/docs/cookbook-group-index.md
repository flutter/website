{% assign path_base = page.url %}
{% assign recipes = collections.all
      | children_pages: path_base
      | sort: 'title' %}

{% for recipe in recipes -%}
- [{{ recipe.title }}]({{ recipe.url }})
{% endfor -%}
