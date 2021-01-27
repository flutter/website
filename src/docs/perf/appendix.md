---
title: Some more thoughts on performance
description: What is performance, and why is performance importnat.
---

# What is performance?

Performance is a set of quantifiable properties of a performer.

In our context, it’s not the execution of an action itself (as the performance
in performing arts). It’s “how well something/someone performs”. Hence it has an
adjective word “performant”.

While the “how well” part can in general be described in natural languages, in
our limited scope, we only focus on something that’s quantifiable as a real
number, which includes integers, and 0/1 binaries as special cases.
Natural-language descriptions are still very important. For example, a news
article that heavily criticizes Flutter’s performance by just using words
without any numbers could still be devastating. The limited scope is chosen only
because of our limited resources.

For example, the 500-word quarterly performance summary is not in our scope. But
if the quarterly performance is summarized in one word which has only 5 options,
say “need-improvement, meet-expectations, exceed-expectations,
strongly-exceed-expectations, superb”, then it’s within our scope as we can map
those 5 options to 1, 2, 3, 4, 5.

Take that to an extreme, all the correctness unit tests are within our scope as
we can describe the code change's test performance as either 0 fail or 1 pass.
If a performance is only described as either bad (e.g., janky) or good (e.g.,
smooth), it’s within that binary scope too.

The required quantity to describe the performance is often referred to as the
metric.

To navigate through countless performance issues and metrics, we can categorize
based on performers.

For example, most content here is about the Flutter app performance where the
performer is a Flutter app. Infra performance is also important to Flutter where
the performers are build bots and CI task runners: they heavily affect how fast
Flutter can land some code changes to improve the app performance. Flutter team
performance has the engineers inside the Flutter team as performers. Flutter
community performance has the open-source community as the performer, and the
performance metric could be the median time to close a community Github pull
request.

Here we intentionally broadens the scope to include performance issues other
than just app performance issues because they can share many tools regardless of
who the performers are. For example, Flutter app performance and infra
performance may share the same dashboard and similar alert mechanisms.

Broadening the scope also allows us to include performers that are traditionally
easy to ignore. Documents performance is such an example. The performer could be
an API doc of the SDK, and a metric could be: what's the percentage of readers
who find it useful?

Besides zooming out, categorizing performers also allows us to zoom in. For
example, within the Flutter app performance issues, sometimes the performers can
be further subdivided. There are Flutter framework performance issues which are
usually blamed on a single framework commit version. There could also be Flutter
engine performance issues or Skia performance issues that can be further
pin-pointed down to a single engine or Skia commit.

# Why is performance important?

Answering this question is not only crucial for validating the work in
performance, but also for guiding the performance work to be more useful. An
answer for “why is performance important” is often also an answer for “how to
make performance useful”.

Simply speaking, performance is important and useful because in our scope it has
to have quantifiable properties or metrics. That implies:
1. Performance report is easy to consume.
2. Performance has little ambiguity.
3. Performance is comparable and convertible.
4. Performance is more fair.

Note they don't mean that non-performance or non-measurable issues or
descriptions are not important. They're to high-light the scenarios where
performance can be more useful.

## 1. Performance report is easy to consume

Performance metrics are numbers. Reading a number is much easier than reading a
passage. For example, it probably takes an engineer 1 second to consume the
performance rating as a number from 1 to 5. It probably takes the same person at
least 1 minute to read the full 500-word feedback summary.

If there are many numbers, it’s easy to summarize or visualize them for quick
consumption. For example, one can quickly consume millions of numbers by looking
at its histogram, average, quantiles, and so on. If a metric has a history of
thousands of data points, one can easily plot a timeline to read its trend.

On the other hand, having N number of 500-word texts almost guarantees an N-time
cost to consume those texts. It would be a daunting task to analyze thousands of
historical descriptions, each of which has 500 words.

## 2. Performance has little ambiguity

Another advantage of having performance as a set of numbers is its unambiguity.
When we measure an animation to have a performance of 20ms per frame, or 50fps,
there’s little room for different interpretations on the numbers themselves. On
the other hand, to describe the same animation in words, someone may call it
smooth, while someone else may complain that it’s laggy. Similarly, the same
word or phrase could be interpreted differently by different people. One might
interpret an “Ok frame rate” to be 60fps, while someone else may interpret it to
be 30fps.

Numbers could still be noisy. For example, the measured “time per frame” might
be a true “computation time of this frame”, plus a noisy “random time that
CPU/GPU spends on some unrelated work”. Hence the metric will fluctuate.
Nevertheless, there’s no ambiguity of what the number means. And there are also
rigorous theory and tested tools to handle such noise. For example, one could
take multiple measurements to estimate the distribution of a random variable.
One could take the average of many measurements to cancel the noise by [the law
of large numbers][1].

## 3. Performance is comparable and convertible

Performance numbers have not only unambiguous meanings, but also unambiguous
comparisons. For example, there’s no doubt that 5 is greater than 4. On the
other hand, it may be subjective to figure out whether “excellent” is better or
worse than “superb”. Similarly, could you figure out whether “epic” is better
than “legendary”? Actually, the word “strongly-exceeds-expectation” could be
better than “superb” in someone’s interpretation. It only becomes unambiguous
and comparable after a definition that maps “strongly-exceeds-expectation” to 4,
and “superb” to 5.

Numbers are also easily convertible using formulas and functions. For example,
60 fps can be converted to 16.67ms per frame. A frame render time x (ms)  can be
converted to a binary indicator `isSmooth = [x <= 16] = (x <= 16 ? 1 :0)`. Such
conversion can be compounded/chained so we can get a large variety of quantities
using a single measurement without any added noise or ambiguity. The converted
quantity can then be used for further comparisons and consumption. Such
conversions are almost impossible if we’re dealing with natural languages.

## 4. Performance is more fair

If issues rely on verbose words to be discovered, then an unfair advantages are
given to people who are (1) more verbose, or more willing to chat or write; (2)
closer to the development team, who has a larger bandwidth and lower cost for
chatting or face-to-face meetings.

By having the same metrics to detect problems no matter how far or how silent
the users are, we’re given a more fair treatment to all issues. That in turn
allows us to focus on the right issues that have wider impacts.

## How to make performance useful

Now let's summarize the 3 points above from a slightly different perspctive:
1. Make performance metrics easy to consume. Do not overwhelm the readers with a
   ton of numbers (or words). If there are many numbers, try to summarize them
   into a smaller set of numbers (e.g., summarize many numbers into a single
   average number). Only notify readers when the numbers change significantly
   (e.g., auto alerts on spikes/regressions).

2. Make performance metrics as unambiguous as possible. Define the unit that the
   number is using. Precisely describe how the number is measured. Make the
   number easily reproducible. When there’s a lot of noise, try to show the full
   distribution, or cancel out the noise as much as possible by aggregating many
   noisy measurements.

3. Make it easy to compare performance. For example, provide a timeline to
   compare the current version with the old version. Provide ways and tools to
   convert one metric to another. For example, if we can convert both memory
   increase and fps drop into the number of users dropped or revenue loss in
   dollars, we can then compare them and make an informed trade-off.

4. Make performance metrics monitor as wide a population as possible, so no one
   is left behind.

[1]: https://en.wikipedia.org/wiki/Law_of_large_numbers
