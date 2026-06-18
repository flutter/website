---
title: "Zoho Tables"
description: "Learn how the Zoho Tables team built their cross-platform spreadsheet-database hybrid using Flutter, achieving feature parity in 14% less time with a team 60% smaller than the web team."
headline: "Zoho Tables"
summary: "Bringing a spreadsheet-database hybrid to mobile with Flutter"
appName: "Zoho Tables"
companyName: "Zoho"
logo: "images/third_party/case_studies/zoho-tables/zoho_tables_logo.png"
card: "images/third_party/case_studies/zoho-tables/zoho_tables_card.png"
videoEmbedUrl: "https://www.youtube.com/embed/YWAuwAR28KY"
locations:
  - India
platforms:
  - Mobile
industries:
  - Productivity
successMetrics:
  - perc: 60
    desc: "smaller mobile team size compared to the web team"
  - perc: 50
    desc: "reduction in developer costs"
  - perc: 42
    desc: "higher refresh rates than competing frameworks during testing"
tags:
  - mobile
  - android
  - ios
publishDate: "2026-05-01"
---

Zoho is a global software development company
serving more than 130 million users
across 180 countries.
With over 55 applications in their catalog,
the constant duplication of efforts
across Android, iOS, and iPadOS platforms
presented a massive drain on engineering resources,
requiring multiple work streams to deliver a single experience.
To address this challenge for their modern spreadsheet-database hybrid,
Zoho Tables,
the team sought a framework that would allow them
to deliver a successful business product
with a slim, focused team.

**Why Flutter?**

Before committing to a technology,
the Zoho Tables team built rigorous proofs of concept,
ran widget tests,
and benchmarked refresh rates for different cross-platform technologies.
Flutter consistently outperformed the competition,
demonstrating a 42% higher refresh rate.
This high performance was essential for the application's "infinite canvas,"
which hosts massive spreadsheets, galleries, and calendars.

Additionally, Flutter's comprehensive documentation
allowed their existing Java and Swift developers
to transition to Dart almost immediately,
enabling them to build functional user interface components in no time.
Flutter also enabled the team
to respect platform-specific design conventions using
Material and Cupertino libraries
while maintaining a single codebase.

**Their solution: Building with Flutter**

The team built the Zoho Tables mobile application
by rendering content on a custom canvas using
Flutter's custom paint and scroll physics.
This custom implementation achieved smooth scrolling
for users interacting with anywhere from 100 to 100,000 rows of data.

To integrate native hardware features,
the team combined Flutter's platform channels with native APIs.
This approach brought support for Apple Pencil and Samsung S Pen,
allowing users to sketch, take notes,
and even create a new database by drawing a form.
For state management, the team used a combination of
BLoC, `ValueNotifier`, and `ValueListenableBuilder`
to organize a codebase of over one million lines of code.
The team is also adopting Flutter's GenUI SDK
to let users build rich dashboards with AI
and integrate Zoho Tables as AI agents with Gemini.

**Key results and business impact**

By adopting Flutter,
the Zoho Tables team achieved significant development velocity
and cost reductions:

*   Reached feature parity with their web application in 14% less time.
*   Shipped on mobile with a team
    that was 60% smaller than the web application team.
*   Reduced overall developer costs by 50%.
*   Decreased build times by 70% using hot reload and fast compilation.
*   Achieved a 42% higher refresh rate
    compared to other cross-platform options.
