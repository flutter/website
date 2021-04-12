---
title: Performance
description: Evaluating the performance of your app from several angles
---

<iframe width="560" height="315" src="https://www.youtube.com/embed/PKGguGUwSYE" 
frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; 
picture-in-picture" allowfullscreen></iframe>
[Flutter performance basics](https://www.youtube.com/watch?v=PKGguGUwSYE)

What is performance? Why is performance important? How do I improve performance?

Our goal is to answer those three questions (mainly the third one), and 
anything related to them. This document should serve as the single entry 
point or the root node of a tree of resources that addresses any questions 
that you have about performance.

The answers to the first two questions are mostly philosophical, and not as 
helpful to many developers who visit this page with specific
performance issues that need to be solved. Therefore, the answers to those 
questions are in the [appendix](/docs/perf/appendix).

To improve performance, you first need metrics: some measurable numbers to
verify the problems and improvements. In the [metrics](/docs/perf/metrics) 
page, you'll see which metrics are currently used, and which tools and APIs 
are available to get the metrics.

There is a list of [Frequently asked questions](/docs/perf/faq), 
so you can find out if the questions you have or the problems you're having 
were already answered or encountered, and whether there are existing solutions. 
(Alternatively, you can check the Flutter GitHub issue database using the
 [performance][performance] label.)

Finally, the performance issues are divided into four categories. They 
correspond to the four labels that are used in the Flutter GitHub issue 
database: "[perf: speed][speed]", "[perf: memory][memory]", 
"[perf: app size][size]", "[perf: energy][energy]".

The rest of the content is organized using those four categories. (Note that
these docs are in the process of being expanded.)

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


## Memory

[Using memory wisely](/docs/perf/memory)


## App size

How to measure your app's size. The smaller the size, the quicker it is to 
download.

[Measuring your app's size][]

{% comment %}


## Energy

How to ensure a longer battery life when running your app.

[Preserving your battery](/docs/perf/power)

{% endcomment %}

[Measuring your app's size]: /docs/perf/app-size

[speed]: https://github.com/flutter/flutter/issues?q=is%3Aopen+label%3A%22perf%3A+speed%22+sort%3Aupdated-asc+

[energy]: https://github.com/flutter/flutter/issues?q=is%3Aopen+label%3A%22perf%3A+energy%22+sort%3Aupdated-asc+

[memory]: https://github.com/flutter/flutter/issues?q=is%3Aopen+label%3A%22perf%3A+memory%22+sort%3Aupdated-asc+

[size]: https://github.com/flutter/flutter/issues?q=is%3Aopen+label%3A%22perf%3A+app+size%22+sort%3Aupdated-asc+

[performance]: https://github.com/flutter/flutter/issues?q=+label%3A%22severe%3A+performance%22
