{% assign groups = include.pages
      | where_exp: "recipe", "recipe.url contains include.path_base"
      | where_exp: "recipe", "recipe.url != include.path_base"
      | group_by_exp: "recipe", "recipe.url | replace_first: include.path_base, '' | regex_replace: '^/?([-\w]+).*', '\1'"
      | sort: 'name' -%}

{% for group in groups -%}
{{include.heading_syntax}} {{ group.name | capitalize }}

{% if group.name == 'testing' -%}

{% assign path_base = include.path_base | append: group.name -%}
{% assign heading_syntax = include.heading_syntax | append: '#' -%}

{% include_relative _group.md pages=group.items path_base=path_base heading_syntax=heading_syntax -%}

{% else -%}

{% assign recipes = group.items | sort: 'title' -%}
{% for recipe in recipes -%}
- [{{ recipe.title }}]({{ recipe.url }})
{% endfor %}

{% endif -%}
{% endfor %}
