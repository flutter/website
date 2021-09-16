{% assign path_base = page.url %}
{% assign dirs = include.pages
        | where_exp: "item", "item.url contains path_base"
        | where_exp: "item", "item.url != path_base"
        | group_by_exp: "item", "item.url | remove: path_base | split: '/' | first"
        | sort: "name" %}

{% for dir in dirs %}

  {% assign dir_name = dir.name | capitalize %}
  <h2>{{ dir_name }}</h2>

  {% assign items = dir.items | where_exp: "item", "item.title != dir_name" | sort: "title" %}
  {% for item in items %}
  - [{{ item.title }}]({{ item.url }})
  {% endfor %}


{% endfor %}
