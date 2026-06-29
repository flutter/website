---
title: "Zoho Tables"
description: "Learn how the Zoho Tables team built their multi-platform spreadsheet-database hybrid using Flutter, achieving feature parity in 14% less time with a 60% smaller team."
headline: "Zoho Tables"
summary: "Building a spreadsheet-database hybrid with Flutter"
appName: "Zoho Tables"
companyName: "Zoho"
logo: "images/third_party/case_studies/zoho-tables/zoho.png"
card: "images/third_party/case_studies/zoho-tables/zoho.png"
videoEmbedUrl: "https://www.youtube.com/embed/YWAuwAR28KY"
locations:
  - India
platforms:
  - Mobile
industries:
  - Productivity
successMetrics:
  - perc: 60
    desc: "smaller team size"
  - perc: 50
    desc: "reduction in developer costs"
  - perc: 42
    desc: "higher refresh rates"
tags:
  - mobile
  - android
  - ios
publishDate: "2026-05-01"
---

[Zoho](http://www.zoho.com) serves over 130 million users across 180 countries across a catalog of 55 applications. The duplication of efforts across Android, iPhone, and iPad platforms presented a massive drain on engineering resources. To address this challenge, the team adopted Flutter to build [Zoho Tables](https://www.zoho.com/tables/) with a fraction of their engineering resources.

<Image src="images/third_party/case_studies/zoho-tables/tablet_and_ipad.png" format="fullwidth" alt="iPhone and iPad" />

**Why Flutter?**

Before committing to a technology, the Zoho Tables team built rigorous proofs of concept, ran widget tests, and benchmarked refresh rates for different cross-platform technologies. Flutter consistently outperformed the competition, demonstrating a 42% higher refresh rate. This high performance was essential for the application's "infinite canvas," which hosts massive spreadsheets, galleries, and calendars.

<Image src="images/third_party/case_studies/zoho-tables/android.png" format="fullwidth" alt="Android" />

Additionally, Flutter's comprehensive documentation enabled their existing Java and Swift developers to transition to Dart almost immediately, making it possible to build functional user interface components in no time. Flutter also enabled the team to respect platform-specific design conventions using Material and Cupertino libraries while maintaining a single codebase.

**Their solution: Building with Flutter**

The team built the Zoho Tables mobile application by rendering content on a custom canvas using Flutter's custom paint and scroll physics. This custom implementation achieved smooth scrolling for users interacting with anywhere from 100 to 100,000 rows of data.

<Image src="images/third_party/case_studies/zoho-tables/iphone.png" format="fullwidth" alt="iPhone" />

To integrate native hardware features, the team combined Flutter's platform channels with native APIs. This approach brought support for Apple Pencil and Samsung S Pen, allowing users to sketch, take notes, and even create a new database by drawing a form. For state management, the team used a combination of [BLoC](https://pub.dev/packages/bloc), `ValueNotifier`, and `ValueListenableBuilder` to organize a codebase of over one million lines of code. The team is also experimenting with using Flutter's GenUI SDK to let users build rich dashboards with AI and integrate Zoho Tables with AI agents with Gemini.

**Key results and business impact**

By adopting Flutter, the Zoho Tables team achieved significant development velocity and cost reductions:

* Reached feature parity with their web application in 14% less time.  
* Shipped on mobile with a team that was 60% smaller than the web application team.  
* Reduced overall developer costs by 50%.  
* Decreased build times by 70% using hot reload and fast compilation.  
* Achieved a 42% higher refresh rate compared to other cross-platform options.

<br />
<br />