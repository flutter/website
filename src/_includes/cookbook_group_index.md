{% assign path_base = page.url | regex_replace: '/index$|/index.html$|/$' -%}
{% assign recipes = site.pages
      | where_exp: "recipe", "recipe.url contains path_base"
      | where_exp: "recipe", "recipe.url != path_base"
      | sort: 'title' -%}

{% for recipe in recipes -%}
{% if recipe.url contains '.html' -%}
- [{{ recipe.title }}]({{ recipe.url }})
{% endif -%}
{% endfor %}
