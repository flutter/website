---
title: Books about Flutter
description: Extra, extra! Here's a collection of books about Flutter.
toc: false
---

Here's a collection of books about Flutter,
in alphabetical order.
If you find another one that we should add,
[file an issue][] and (feel free to)
submit a PR ([sample][]) to add it yourself.

Also, check the Flutter version that the book
was written under. Anything published before
Flutter 3.10/Dart 3 (May 2023),
won't reflect the latest version of Dart and
might not include null safety;
anything published before Flutter 3.16 (November 2023)
won't reflect that Material 3 is now
Flutter's default theme.
See the [what's new][]
page to view Flutter's latest release.

[file an issue]: {{site.repo.this}}/issues/new
[sample]: {{site.repo.this}}/pull/6019
[what's new]: /release/whats-new

{% for book in books -%}
* [{{book.title}}]({{book.link}})
{% endfor -%}

## Book details

The following sections have more information about each book.

{% for book in books %}
<div class="book-img-with-details">
<a href="{{book.link}}" title="{{book.title}}">
  <img src="/assets/images/docs/cover/{{book.cover}}" alt="{{book.title}}">
</a>
<div class="details">

<h3 class="title" id="{{book.title}} | slugify">
<a href="{{book.link}}">{{book.title}}</a>
</h3>

by {{book.authors | arrayToSentenceString}}
{:.authors}

{{book.desc}}
</div>
</div>
{% endfor -%}

