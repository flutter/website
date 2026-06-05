---
title: Atlas Associates
description: Japan-based startup Atlas Associates used Flutter and Firebase to build Arc, an AI-powered messaging app with ephemeral conversations.
headline: Atlas Associates
summary: How Atlas Associates built a next-gen AI messenger with Flutter and Firebase
appName: Arc
companyName: Atlas Associates
logo: images/third_party/case_studies/atlas/logo.png
card: images/third_party/case_studies/atlas/case_study_card.png
poster: images/third_party/case_studies/atlas/case_study_poster.png
locations:
  - Asia
platforms:
  - Mobile
industries:
  - Social
publishDate: 2025-11-25
---

**Goal**

[**Arc**](https://www.atlasassociates.io/arc) is an AI-powered messaging app by the Japan-based tech startup [Atlas Associates](https://www.atlasassociates.io/), who began with a vision to redefine communication in the digital age. The team wanted to create a space for truly private, ephemeral, and intimate conversations, so Arc is designed so that every message, even group chats, disappear over time.

This vision requires an architecture that can compete on a global level, based on four pillars: stability, speed, lightweight design, and high security. Their goal wasn't just to build another messaging app; it was to create an entirely new conversational experience, complete with robust AI characters and uncompromising security.

<Image src="images/third_party/case_studies/atlas/case_study_body_1.png" format="fullwidth" alt="Screenshots of chat experience for Arc" />

**Why Flutter?**

Atlas Associates chose Flutter for two reasons.

First, Flutter’s unique ability to deliver high-fidelity experiences across multiple platforms from a single codebase is a strategic advantage for a compact team, enabling remarkable development velocity.

Second, the team believed that the lag in app responsiveness often attributed to cross-platform frameworks wasn’t necessarily a limitation of the framework chosen, but often solvable with the right architecture and implementation approach. They were confident they could achieve the high-performance, fluid user experience their vision demanded with Flutter, alongside other solutions from the broader Google ecosystem.

**Their solution**

Atlas Associates’ small team was able to ship Arc, a high-performance app, to both Android and iOS following a rigorous optimization process to achieve their performance goals. They used [Flutter DevTools](https://docs.flutter.dev/tools/devtools) to dive deep into frame rendering times, CPU usage, and memory allocation to eliminate sources of jank at the millisecond level. Their focus on minimizing widget rebuilds through meticulous state management resulted in a highly fluid user experience.

To power the app, the team chose a hybrid backend of specialized services. For the core experience, they relied on [Firebase](https://firebase.google.com/). [Firestore](https://firebase.google.com/products/firestore) served as the primary database, providing real-time synchronization and robust offline capabilities for ephemeral messages. They used [Firebase Authentication](https://firebase.google.com/products/auth) for a secure identity layer and [App Check](https://firebase.google.com/products/app-check) to ensure all backend requests came from a legitimate instance of their app, creating a critical defense against abuse.

They also used a combination of additional Google Cloud products, including [Cloud Run](https://cloud.google.com/run) for complex, stateful, or computationally intensive microservices, and [Vertex AI](https://cloud.google.com/vertex-ai) for a variety of AI tasks, including calling the Gemini API, RAG and Vertex AI Search.

“ By combining the rapid development capabilities of Flutter and Firebase with the scalable power of Cloud Run and the intelligence of Vertex AI, we have built a platform designed for global competition. ” - Takayuki Miyano, Founder, Atlas Associates

**Results**

Using Flutter with the power of Firebase and Google Cloud, Atlas Associations achieved incredible development velocity—shipping 144 updates in 34 months with a compact team. This sets the team up to move quickly and continue to define the next generation of communication experiences.
