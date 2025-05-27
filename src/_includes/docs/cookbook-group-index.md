{% assign pathBase = page.url %}
{% assign recipes = collections.all | childPagesOf: pathBase | sort: 'title' %}

{% for recipe in recipes -%}
- [{{ recipe.data.title }}]({{ recipe.url }})
{% endfor -%}
