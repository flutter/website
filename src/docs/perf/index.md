---
title: Performance
description: Evaluating the performance of your app from several angles.
---

<iframe width="560" height="315" src="https://www.youtube.com/embed/PKGguGUwSYE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
[Flutter performance basics](https://www.youtube.com/watch?v=PKGguGUwSYE)

What is performance? Why is performance important? How to improve performance?

We aim at answering those 3 questions (mainly the 3rd one), and all questions
related to them. This would hopefully serve as the single entry-point, or the
root node of a tree of resources that address any needs about performance.

The answers to the first 2 questions are mostly philosophical, and less
immediately helpful to many developers who visit this page with speicifc
performance issues to solve. Hence we'll leave them to
[appendix](/docs/perf/appendix).

To improve the performance, we first need metrics: some measurable numbers to
verify the problems and improvements. In [metrics](/docs/perf/metrics) page,
we'll show what metrics are currently used, and what tools and APIs are
available to get them.

We then collect a list of [Frequently Asked Questions](/docs/perf/faq), so you
can find if the questions or problems have been encountered before, and what
existing solutions there are. (Alternatively, you may check the Flutter Github
issue database with the [performance][performance] label.)

Finally, we divide performance issues into 4 categories. They correspond to the
4 labels we used in Flutter Github issue data base: "[perf: speed][speed]",
"[perf: memory][memory]", "[perf: app size][size]", "[perf: energy][energy]".

We'll organize the rest content using those 4 categories as below. (Note that
these docs are in process of being expanded.)

<!--
Let's put "speed" (rendering) first as it's the most popular performance issue
category.
-->
## Speed

Are your animations janky (not smooth)? Learn how to
evaluate and fix rendering issues.

[Improving rendering performance](/docs/perf/rendering)

{% comment %}
Do your apps take a long time to open? We'll also cover the startup speed issue
in some future pages.
{% endcomment %}

## App size

How to measure your app's size. The smaller the size,
the quicker it is to download.

[Measuring your app's size][]

{% comment %}

## Memory

[Using memory wisely](/docs/perf/memory)

## Energy

How to ensure a longer battery life when running
your app.

[Preserving your battery](/docs/perf/power)

{% endcomment %}

[Measuring your app's size]: /docs/perf/app-size

[speed]: https://github.com/flutter/flutter/issues?q=is%3Aopen+label%3A%22perf%3A+speed%22+sort%3Aupdated-asc+

[energy]: https://github.com/flutter/flutter/issues?q=is%3Aopen+label%3A%22perf%3A+energy%22+sort%3Aupdated-asc+

[memory]: https://github.com/flutter/flutter/issues?q=is%3Aopen+label%3A%22perf%3A+memory%22+sort%3Aupdated-asc+

[size]: https://github.com/flutter/flutter/issues?q=is%3Aopen+label%3A%22perf%3A+app+size%22+sort%3Aupdated-asc+

[performance]: https://github.com/flutter/flutter/issues?q=+label%3A%22severe%3A+performance%22
