{% assign path_base = path_base | default: page.url | regex_replace: 'index$|index.html$' -%}
{% assign groups = include.pages
      | where_exp: "recipe", "recipe.url contains path_base"
      | where_exp: "recipe", "recipe.url != path_base"
      | group_by_exp: "recipe", "recipe.url | replace_first: path_base, '' | regex_replace: '^/?([-\w]+).*', '\1'"
      | sort: 'name' -%}

{% for group in groups -%}

{% if group.name == '/' -%}{% continue %}{% endif -%}
{{include.heading_syntax}} {{ group.name | capitalize }}

{% if group.name == 'testing' -%}

{% assign path_base = path_base | append: group.name -%}
{% assign heading_syntax = include.heading_syntax | append: '#' -%}

{% include cookbook_toc.md pages=group.items path_base=path_base heading_syntax=heading_syntax -%}

{% else -%}

{% assign recipes = group.items | sort: 'title' -%}
{% for recipe in recipes -%}
{% comment %}
  Exclude index pages (all other pages will end in `.html`).
{% endcomment -%}
{% if recipe.url contains '.html' -%}
- [{{ recipe.title }}]({{ recipe.url }})
{% endif -%}
{% endfor %}

{% endif -%}
{% endfor %}
