---
title: Widgets Catalog
toc: false
---

Create beautiful apps faster with Flutter's collection of visual, structural,
platform, and interactive widgets.

In addition to browsing widgets by category,
you can also see all the widgets in the [Flutter widget index](/development/ui/widgets/widgetindex).

{% for section in site.data.catalog.index %}
- ### [{{section.name}}](/development/ui/widgets/{{section.id}})
  {:.catalog-category-title}

  {{section.description}}
{:.card}
{% endfor %}
