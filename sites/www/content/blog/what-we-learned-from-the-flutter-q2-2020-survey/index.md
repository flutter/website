---
title: "What we learned from the Flutter Q2 2020 survey"
description: "With a focus on code samples, app performance, and writing packages"
publishDate: 2020-07-22
author: jayoung-lee
image: images/1BJJb_evaKM8qgJV5VCn95Q.webp
category: announcement
layout: blog
---

For about ten days every quarter, the Flutter team hosts a survey to hear about your experience with Flutter. Each survey combines recurring questions that help our team monitor longitudinal trends of various measures, with new questions that collect timely feedback. It helps us stay focused on important areas.

In this same tradition, we announced our ninth quarterly survey in May 2020 and were delighted that we received almost 8,000 responses over ten days, despite all the challenges of the current world situation. We are grateful for your participation. First, we are happy to share that 94% of you (that responded) are positively satisfied with Flutter; and 57% are *very* satisfied with Flutter, which is an all-time high! It’s humbling to see the love for the framework that we are building together.

We learned about many topics in this quarter’s survey. Read on for some highlights!

<DashImage figure src="images/1BJJb_evaKM8qgJV5VCn95Q.webp" alt="*57% of respondents are very satisfied with Flutter. In total, 94% are positively satisfied.*" caption="*57% of respondents are very satisfied with Flutter. In total, 94% are positively satisfied.*" />


## Flutter adoption

This quarter we were particularly interested in better understanding how professional developers choose Flutter, and so we asked some questions to find out more. Our hypothesis was that there’s an overlap between personal and professional use, and we wanted to test this and understand it better.

<DashImage figure src="images/0hllcpu-J2qiBOC-D.webp" alt="*Overall, 46% of the respondents decided or convinced management to adopt Flutter after using Flutter for personal projects*" caption="*Overall, 46% of the respondents decided or convinced management to adopt Flutter after using Flutter for personal projects*" />


We learned that 46% of respondents decided (or convinced management) to adopt Flutter after using Flutter for personal projects. It means that Flutter’s adoption is mostly driven by positive experiences at home that translated into work explorations. This is fairly consistent across different environments, as the chart below demonstrates. Even for those working for an agency or an enterprise, about a half the respondents said that they either decided or convinced management to adopt Flutter.

We believe that this reflects the appeal of Flutter among actual users of the technology. In other words, you!

<DashImage figure src="images/0FjDr-VCUHT1A_0E3.webp" alt="*The proportion of respondents who decided or convinced management remained high in all categories of company/organization*" caption="*The proportion of respondents who decided or convinced management remained high in all categories of company/organization*" />


If you are in a similar situation where you want to convince others to adopt Flutter, you might consider referring to [Nubank’s tech blog](https://medium.com/building-nubank/https-medium-com-freire-why-nubank-chose-flutter-61b80b568772) and [video](https://www.youtube.com/watch?v=vnj2i6RNo3g&vl=en) about how they assessed Flutter and other technologies and decided to adopt Flutter. Nubank is the largest digital bank outside Asia with over 20 million customers, and their independent technical evaluation of Flutter makes interesting reading.

## Code samples

In the previous survey, users told us that sample code is the most useful learning resource, even more than videos, articles, or demos. In this quarter’s survey, we wanted to better understand what types of sample code we should invest in.

In the survey, users were asked to recall their most recent experience of searching for sample code. Then they were asked about the details about the experience, such as where they found the most useful sample code. Stack Overflow was the most common place where people found useful sample code (26%), followed by GitHub (17%).

<DashImage figure src="images/0zDQJ8f84eOugD5zY.webp" alt="*Stack Overflow was the common place where people found useful sample code from (26%), followed by GitHub (17%).*" caption="*Stack Overflow was the common place where people found useful sample code from (26%), followed by GitHub (17%).*" />


At the end of this section of the survey, we asked which type of code would have been more useful, if only one type of code sample is available: more but smaller samples or fewer but larger samples.

The overall results showed that the majority of the users (68%) want more samples, even if they are small. This result directly guides us to add multiple short examples first to the documentation when there are no code samples available in our documentation, such as API docs, cookbooks, tutorials, etc.

<DashImage figure src="images/0VdwCqbeqU3wlTMl-.webp" alt="*Respondents said that more but smaller samples would be more useful. In the actual survey question, the phrase “{resource that participant selected}” was filled with suggested resources (such as Stack Overflow) where the respondent recently found sample code.*" caption="*Respondents said that more but smaller samples would be more useful. In the actual survey question, the phrase “{resource that participant selected}” was filled with suggested resources (such as Stack Overflow) where the respondent recently found sample code.*" />


Is there any difference in the preferences towards the location of code samples, such as Stack Overflow or API docs? When we did a breakdown of the responses by the resource, the preference was still towards “more, but smaller code samples” in all the categories.

<DashImage figure src="images/0Wqiz9yZUhX2wXPl_.webp" alt="*The proportion of the respondents who selected “more, but smaller code samples” remained high in all types of resources.*" caption="*The proportion of the respondents who selected “more, but smaller code samples” remained high in all types of resources.*" />


Interestingly, as seen in the graph above, for the resources that users found useful in getting some inspiration or seeing an app known to be a good quality, such as GitHub or YouTube, the proportion of users preferring “fewer, but larger app samples” increased. This result may be helpful for the Flutter community instructors who are planning learning materials.

## Flutter app performance

Flutter compiles to machine code on mobile and desktop devices, allowing for performance comparable with system frameworks. Still, the Flutter team is invested in improving various performance metrics, including rendering speed, power usage, memory usage, and application size. As a result, the proportion of users positively satisfied with Flutter’s mobile performance increased from 85% in Q3 2019 to 92% this quarter.

<DashImage figure src="images/0RVxVaxzNCEY3XbrU.webp" alt="*92% of the users are positively satisfied with Flutter’s mobile performance. This does not include 9.2% who selected “I don’t have enough experience with it to answer this question” or 2.3% who selected “What is release mode or profile mode?”*" caption="*92% of the users are positively satisfied with Flutter’s mobile performance. This does not include 9.2% who selected “I don’t have enough experience with it to answer this question” or 2.3% who selected “What is release mode or profile mode?”*" />


In this quarter, we wanted to better understand how Flutter’s app performance is perceived by users, compared to those building Android and iOS apps with native platform frameworks. The questions were asked to those who said they have hands-on experience with Android and iOS development.

While Flutter developers are generally happy with our performance and resource usage, app size is the area of greatest opportunity for improvement, with 11–13% of developers with prior Android or iOS experience rating it “unacceptable”. We have made improvements here, but this tells us we’re not yet done. We hope we can further optimize app size by tweaking our compilers and splitting AOT artifacts.

<DashImage figure src="images/0uWwV77z9EcebWuzx.webp" alt="*Relative acceptability of Flutter apps performance, compared to Android native.*" caption="*Relative acceptability of Flutter apps performance, compared to Android native.*" />


<DashImage figure src="images/03P8YpKBYQ5APySDe.webp" alt="*Relative acceptability of Flutter apps performance, compared to iOS native.*" caption="*Relative acceptability of Flutter apps performance, compared to iOS native.*" />


We also learned that satisfaction with Flutter’s app memory usage is slightly lower than that of speed and power usage. To respond to this, we are improving memory performance (specifically image memory use), and at the same time, we are heavily investing into better tools, tests, and docs for all areas. The team is improving the DevTools’ UI as well as the documentation about the debugging process for testing memory, app size, and energy issues.

## Writing packages

Flutter developers can use packages on pub.dev to quickly build their apps, without having to write everything from scratch. While there are [over 10,000 Flutter-compatible packages](https://pub.dev/flutter/packages) available on pub.dev, only a small number of them are directly maintained by the Google Flutter team. Thus, Flutter’s ecosystem is, by design, heavily dependent on community contributions.

We are dedicated to building a great development environment that supports package authors’ creation and curation of high-quality packages. Just this week, we launched a complete [redesign of the pub.dev site](https://medium.com/dartlang/pub-dev-redesign-747406dcb486) based on previous feedback.

Now our user-experience researchers want to understand what motivates package authors to publish and maintain packages. We talked to numerous package authors earlier this year, and based on those findings, we added quantitative questions to this survey to explore the area further.

The main finding from the survey was that most package authors publish packages with altruistic motives, but maintain the packages because of their own needs. For instance, 82% of authors published their packages because they wanted other users to benefit, but the same reason motivated only 58% of the authors to maintain them. On the other hand, 66% of authors published packages for their own use, and the same reason made 70% of the authors maintain them.

<DashImage figure src="images/05dBLaUz--b_5W2P3.webp" alt="*82% of the authors published their packages because they wanted other users to benefit*" caption="*82% of the authors published their packages because they wanted other users to benefit*" />


<DashImage figure src="images/0P1coe65N82z6o0Ys.webp" alt="*“Benefiting others” motivated only 58% of the authors to maintain their packages*" caption="*“Benefiting others” motivated only 58% of the authors to maintain their packages*" />


It made us realize that there are additional ways we could support this. Some package authors might benefit from knowing how much impact you could have on the community by publishing certain packages. For instance, you might want to know how many Flutter users would benefit from a notification plugin. (Currently, you can see what potential packages are waiting for authors from the [flutter/flutter](https://github.com/flutter/flutter) repository, with the “[would be a good package](https://github.com/flutter/flutter/issues?q=is%3Aopen+label%3A%22would+be+a+good+package%22+sort%3Areactions-%2B1-desc)” label.) Also, you might want to know which packages are explicitly looking for contributions, so that you can easily find the packages in need. Thanks to your input, we will consider work in this area for future pub.dev releases.

We also discovered that we could support the learning aspect better, because many users pointed out that learning opportunities motivate them to maintain packages. Learning how to write documentation, learning what to improve from peer developers, or learning how to manage an open source project may all fall under this category. With these findings in mind, we will continue to create an environment where you can improve yourself as you contribute to the community.

## Wrapping up

We hope that this series of posts continues to demonstrate how much we value your input. We spend hours analyzing and digesting your responses every quarter. Several of us from across user research, engineering, and product management read through every free-form comment, and while we can’t answer every one directly, your needs and comments influence our decision-making every day.

We are going to continue this tradition of basing our decisions on what you tell us in these surveys. So please continue to participate and share your thoughts. Special thanks go to the 7,883 users who participated in the Q2 survey and helped us create the insights shared here.

Flutter’s UX research team is also running a wide variety of user experience studies to make your experience with Flutter more pleasant. For instance, last quarter, we contacted and interviewed package authors to hear about their experience of publishing and maintaining packages. If you are interested in participating in such studies, please [sign up](https://docs.google.com/forms/d/e/1FAIpQLSe0i4De809KXVCdljGKrjMj3lxhuzbuFKCtY5PEQPCYtGxFMg/viewform) to be considered for a future study.
