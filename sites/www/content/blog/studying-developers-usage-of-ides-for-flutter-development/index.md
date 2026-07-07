---
title: "Studying developer’s usage of IDEs for Flutter development"
description: "Findings from the Q2 2022 user survey. Written by JaYoung Lee and Ander Dobo."
publishDate: 2022-09-12
author: jayoung-lee
image: images/1lHHYRiiookkYcA-Uhq9pgg.png
category: announcements
layout: blog
---

## Studying developer’s IDE usage for Flutter development

The Flutter team at Google currently builds and maintains support for Android Studio (which is based on IntelliJ-IDEA), and Visual Studio Code (VS Code). We integrate features into plugins for these IDEs for Flutter app development, such as code completion, syntax highlighting, widget editing assists, run & debug support, and more. Flutter developers have used both IDEs since the earliest days of Flutter with Android Studio, traditionally being more popular than VS Code. VS Code has steadily gained popularity faster than, and recently surpassed, the popularity of Android Studio for Flutter development as shown in the figure below.

To better understand Flutter developers’ thoughts behind IDE choice, the Flutter UX team fielded a survey specifically for this topic in May 2022.

*In the rest of the article, “Android Studio” represents both Android Studio and IntelliJ-IDEA together.*

<DashImage figure src="images/1lHHYRiiookkYcA-Uhq9pgg.png" alt="*Figure 1. The number of Flutter developers from each IDE, from August 2021 to July 2022, shows that VS Code became more popular in the recent few months.*" caption="*Figure 1. The number of Flutter developers from each IDE, from August 2021 to July 2022, shows that VS Code became more popular in the recent few months.*" />


## What we already knew about the IDEs

In addition to the fact that Flutter developers were split between Android Studio and VS Code 50:50 at the beginning of 2022, we knew a bit more about the developers’ choice based on the previous surveys.

### Flutter developers tend to use the IDE familiar to them

In 2019 Q3, we asked Flutter developers why they prefer the IDE they use the most. The most common choice was that the IDE was “more familiar to me”.

<DashImage figure src="images/0fSlfAxkzo4DXfFvW.png" alt="*Figure 2. 80% of Android Studio users and 61% of VS Code users said that they chose the IDE because of familiarity, according to the Q3 2019 survey.*" caption="*Figure 2. 80% of Android Studio users and 61% of VS Code users said that they chose the IDE because of familiarity, according to the Q3 2019 survey.*" />


### VS Code users value the speed they experience with the IDE

Another notable thing from the figure above (Figure 2) is that 68% of VS Code users chose the IDE because it’s faster than other IDEs, while only 12% of Android Studio users thought so. In an open-ended question, VS Code users said that they like the IDE because it is lightweight but has a variety of extensions.

### VS Code users are more satisfied with Flutter’s IDE support

We also asked about satisfaction with Flutter’s IDE support, and VS Code users tended to be more satisfied. (We record the IDE developers are using when they open the survey from an IDE. We notify developers about this recording when they click the survey link.)

<DashImage figure src="images/0cmGZIWZvGJlGLslQ.png" alt="*Figure 3. While 93.3% of VS Code users are satisfied with Flutter’s IDE support, only 85.9% of Android Studio users are satisfied.*" caption="*Figure 3. While 93.3% of VS Code users are satisfied with Flutter’s IDE support, only 85.9% of Android Studio users are satisfied.*" />


Android Studio is, of course, designed as a fully-integrated IDE for Android development, so it has a much richer feature set for that purpose. Developers have mentioned that it’s easy to handle native Android code and use convenient features like refactoring in Android Studio. In the next section, we dig deeper into the preference and why developers are less happy with using Flutter in Android Studio despite these advantages.

## What we learned from the Q2 2022 survey

The results above made us wonder why Flutter developers are happier with the VS Code support than with the Android Studio support. We wanted to understand the things that Flutter developers really like about VS Code.

To understand that, we asked a set of questions to developers who switched their main IDE from one to the other in either direction. We believe these developers are well placed to tell us about the unique values in each IDE from their perspective.

First of all, there were more Flutter developers who switched from Android Studio to VS Code.

<DashImage figure src="images/0YwvNR6rKmm9AZd8-.png" alt="*Figure 4. More Flutter developers switched their main IDE from Android Studio (blue) to VS Code (teal) than vice versa.*" caption="*Figure 4. More Flutter developers switched their main IDE from Android Studio (blue) to VS Code (teal) than vice versa.*" />


As shown in the following graph, those who switched to VS Code liked its performance (82%) and usability (63%). On the other hand, those who switched to Android Studio liked its features (51%) and integration with Flutter tools (39%) and native platforms (27%).

<DashImage figure src="images/0lsCeAx1gT5qxWONz.png" alt="*Figure 5. Reasons for switching to a new IDE.*" caption="*Figure 5. Reasons for switching to a new IDE.*" />


Still, about 23% of Flutter developers use *both* VS Code and Android Studio. When we asked them why they use more than one IDE, the most prominent theme that emerged was that VS Code users need to use Android Studio and Xcode for native-specific functionalities, such as emulator set-up, build configuration, release requirements (such as key generation and signing), and when developing hybrid Flutter+native apps.

<DashImage figure src="images/0_waE6swxNd-8j2r-.png" alt="Figure 6. 22.5% of Flutter developers use both VS Code and Android Studio together" caption="Figure 6. 22.5% of Flutter developers use both VS Code and Android Studio together" />


Another insight we gained from the survey is that Flutter developers from different countries or regions prefer different IDEs. While most Flutter developers prefer VS Code over Android Studio, developers from China prefer Android Studio (56%) over VSCode (23%). We found this interesting — Flutter is adopted globally, yet used under different development environments. Please leave a comment on this article, if you have any stories from your country or region to share around this tendency.

<DashImage figure src="images/0ejP8ZefmPBh8PF1o.png" alt="Figure 7. IDE by countries or regions. Countries or regions with at least 100 survey respondents are included in the chart." caption="Figure 7. IDE by countries or regions. Countries or regions with at least 100 survey respondents are included in the chart." />


## In conclusion

Our goal is to deliver a useful and complete development experience that minimizes the friction to get started with Flutter and maximizes developers’ productivity. We will take account of these and future study findings to inform our roadmap for future Flutter IDE support and documentation. As a first step, we’re making minor updates to our website’s getting started documentation to reflect the IDE preferences and patterns of usage described above.

The insights we gain from this and other surveys are invaluable to us and ensure that we invest in the right areas to continue improving the Flutter developer experience. Thank you to everyone who participated! If you’re interested in participating in future user studies, you can sign up at [https://flutter.dev/research-signup](https://flutter.dev/research-signup). We’ll be back next quarter to share the Q3 survey results. See you in the next article!