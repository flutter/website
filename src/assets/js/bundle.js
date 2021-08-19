---
layout: blank
includes:
  - vendor/code-prettify/prettify.js
  - vendor/code-prettify/lang-css.js
  - vendor/code-prettify/lang-dart.js
  - vendor/code-prettify/lang-yaml.js
  - archive.js
  - tabs.js
  - main.js
---
{%- for path in page.includes %}
// ------------------------------------
// {{ path }}
// ------------------------------------
{% include_relative {{ path }} %}
{% endfor -%}