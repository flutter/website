---
title: Books about Flutter
description: Extra, extra! Here's a collection of books about Flutter.
toc: false
---

Here's a collection of books about Flutter, in alphabetical order.
If you find another one that we should add,
[file an issue][] and (optionally)
submit a PR ([sample][]) to add it yourself.

[file an issue]: {{site.repo.this}}/issues/new
[sample]: {{site.repo.this}}/pull/6019

{% for book in site.data.books -%}
* [{{book.title}}]({{book.link}})
{% endfor -%}

<p>
  The following sections have more information about each book.
</p>

{% for book in site.data.books %}
<div class="book-img-with-details row">
<a href="{{book.link}}" title="{{book.title}}" class="col-sm-3 no-automatic-external">
  <img src="/assets/images/docs/cover/{{book.cover}}" alt="{{book.title}}">
</a>
<div class="details col-sm-9" markdown="1">
### [{{book.title}}]({{book.link}})
{:.title}

by {{book.authors | array_to_sentence_string}}
{:.authors.h4}

{{book.desc}}
</div>
</div>
{% endfor %}

