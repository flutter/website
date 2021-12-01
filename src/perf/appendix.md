---
title: More thoughts about performance
description: What is performance, and why is performance important
---

## What is performance?

Performance is a set of quantifiable properties of a performer.

In this context, performance isn't the execution of an action itself;
it’s how well something or someone performs. Therefore, we use the adjective
 _performant_.

While the _how well_ part can, in general, be described in natural languages,
in our limited scope, the focus is on something that is quantifiable as a real
number. Real numbers include integers and 0/1 binaries as special cases.
Natural language descriptions are still very important. For example, a news
article that heavily criticizes Flutter’s performance by just using words
without any numbers (a quantifiable value) could still be meaningful, and it
could have great impacts. The limited scope is chosen only because of our
limited resources.

The required quantity to describe performance is often referred to as a
metric.

To navigate through countless performance issues and metrics, you can categorize
based on performers.

For example, most of the content on this website is about the Flutter app
performance, where the performer is a Flutter app. Infra performance is also
important to Flutter, where the performers are build bots and CI task runners:
they heavily affect how fast Flutter can incorporate code changes, to improve
the app's performance.

Here, the scope was intentionally broadened to include performance issues other
than just app performance issues because they can share many tools regardless of
who the performers are. For example, Flutter app performance and infra
performance might share the same dashboard and similar alert mechanisms.

Broadening the scope also allows performers to be included that traditionally
are easy to ignore. Document performance is such an example. The performer
could be an API doc of the SDK, and a metric could be: the percentage of readers
who find the API doc useful.

## Why is performance important?

Answering this question is not only crucial for validating the work in
performance, but also for guiding the performance work in order to be more
useful. The answer to “why is performance important?” often is also the answer
to “how is performance useful?”

Simply speaking, performance is important and useful because, in the scope,
performance must have quantifiable properties or metrics. This implies:
1. A performance report is easy to consume.
2. Performance has little ambiguity.
3. Performance is comparable and convertible.
4. Performance is fair.

Not that non-performance, or non-measurable issues or descriptions are not
important. They're meant to highlight the scenarios where performance can be
more useful.

### 1. A performance report is easy to consume

Performance metrics are numbers. Reading a number is much easier than reading a
passage. For example, it probably takes an engineer 1 second to consume the
performance rating as a number from 1 to 5. It probably takes the same engineer
at least 1 minute to read the full, 500-word feedback summary.

If there are many numbers, it’s easy to summarize or visualize them for quick
consumption. For example, you can quickly consume millions of numbers by
looking at its histogram, average, quantiles, and so on. If a metric has a
history of thousands of data points, then you can easily plot a timeline to
read its trend.

On the other hand, having _n_ number of 500-word texts almost guarantees an
_n_-time cost to consume those texts. It would be a daunting task to analyze
thousands of historical descriptions, each having 500 words.

### 2. Performance has little ambiguity

Another advantage of having performance as a set of numbers is its unambiguity.
When you want an animation to have a performance of 20 ms per frame or
50 fps, there’s little room for different interpretations about the numbers. On
the other hand, to describe the same animation in words, someone might call it
good, while someone else might complain that it’s bad. Similarly, the same
word or phrase could be interpreted differently by different people. You might
interpret an OK frame rate to be 60 fps, while someone else might interpret it
to be 30 fps.

Numbers can still be noisy. For example, the measured time per frame might
be a true computation time of this frame, plus a random amount of time (noise)
that CPU/GPU spends on some unrelated work. Hence, the metric will fluctuate.
Nevertheless, there’s no ambiguity of what the number means. And, there are
also rigorous theory and testing tools to handle such noise. For example, you
could take multiple measurements to estimate the distribution of a random
variable, or you could take the average of many measurements to eliminate the
noise by [the law of large numbers][1].

### 3. Performance is comparable and convertible

Performance numbers not only have unambiguous meanings, but they also have
unambiguous comparisons. For example, there’s no doubt that 5 is greater than 4.
On the other hand, it might be subjective to figure out whether excellent is
better or worse than superb. Similarly, could you figure out whether epic is
better than legendary? Actually, the phrase _strongly exceeds expectations_
could be better than _superb_ in someone’s interpretation. It only becomes
unambiguous and comparable after a definition that maps strongly exceeds
expectations to 4 and superb to 5.

Numbers are also easily convertible using formulas and functions. For example,
60 fps can be converted to 16.67 ms per frame. A frame's rendering
time _x_ (ms) can be converted to a binary indicator
`isSmooth = [x <= 16] = (x <= 16 ? 1 :0)`. Such conversion can be compounded or
chained, so you can get a large variety of quantities using a single
measurement without any added noise or ambiguity. The converted quantity can
then be used for further comparisons and consumption. Such conversions are
almost impossible if you're dealing with natural languages.

### 4. Performance is fair

If issues rely on verbose words to be discovered, then an unfair advantage is
given to people who are more verbose (more willing to chat or write) or those
who are closer to the development team, who have a larger bandwidth and lower
cost for chatting or face-to-face meetings.

By having the same metrics to detect problems no matter how far away or how
silent the users are, we can treat all issues fairly. That, in turn,
allows us to focus on the right issues that have greater impact.

### How to make performance useful

The following summarizes the 4 points discussed here, from a slightly different
perspective:
1. Make performance metrics easy to consume. Do not overwhelm the readers with a
   lot of numbers (or words). If there are many numbers, then try to summarize
   them into a smaller set of numbers (for example, summarize many numbers into
   a single average number). Only notify readers when the numbers change
   significantly (for example, automatic alerts on spikes or regressions).

2. Make performance metrics as unambiguous as possible. Define the unit that the
   number is using. Precisely describe how the number is measured. Make the
   number easily reproducible. When there’s a lot of noise, try to show the full
   distribution, or eliminate the noise as much as possible by aggregating many
   noisy measurements.

3. Make it easy to compare performance. For example, provide a timeline to
   compare the current version with the old version. Provide ways and tools to
   convert one metric to another. For example, if we can convert both memory
   increase and fps drops into the number of users dropped or revenue lost in
   dollars, then we can compare them and make an informed trade-off.

4. Make performance metrics monitor a population that is as wide as possible,
   so no one is left behind.

[1]: https://en.wikipedia.org/wiki/Law_of_large_numbers
