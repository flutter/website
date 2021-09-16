{% assign path_base = page.url %}
{% assign recipes = site.pages
      | where_exp: "recipe", "recipe.url contains path_base"
      | where_exp: "recipe", "recipe.url != path_base"
      | sort: 'title' %}

{% for recipe in recipes %}
- [{{ recipe.title }}]({{ recipe.url }})
{% endfor %}
