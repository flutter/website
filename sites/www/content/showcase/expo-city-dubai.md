---
title: Expo City Dubai
bodyTags: interior showcase showcase-story
description: Expo City Dubai is a mixed-use smart-city district where people can live, work, build businesses, and visit. Merixstudio partnered with Expo City Dubai to build a cross-platform Flutter app that helps people navigate the fast-growing destination.
logo: images/case_studies/expo-city-dubai/logo.png
headline: Expo City Dubai
summary: From visitor guide to smart-city super app, Expo City Dubai in Flutter
appName: Expo City Dubai
companyName: Expo City Dubai
card: images/case_studies/expo-city-dubai/case_study_card.png
videoEmbedUrl: "https://www.youtube.com/embed/Busrmb6Kh5c"
options_location: Asia
options_platform: Mobile
options_social: Travel & Lifestyle
successMetrics: []
date: 2026-03-24
feature_color: "#F0B800"
feature_theme: light
featured: false
featured_card_id:
publishDate: "2026-03-24"
tags:
- mobile
- Android
- ios
---

**Introduction**

[Expo City Dubai](https://www.expocitydubai.com/) (ECD) is a mixed-use smart-city district where people can live, work, build businesses, and visit—with residences, offices and coworking, retail and dining, plus tourism, museums/cultural venues, exhibitions, and major events in one place. It continues to grow on the foundations created for Expo 2020 Dubai.

The core challenge was to create a mobile “companion” that works for very different audiences—tourists and day visitors, but also tenants, founders, and employees—coming from multiple cultural backgrounds and using different languages (including right-to-left scripts). The product was built for an **international, diverse set of users**, with a simple entry path and **no mandatory login** for general use. 

Because Expo City Dubai covers a large area, the quality of the navigation and information architecture has real-world consequences. Unclear labels, missing context, or too many steps to reach directions can lead to wrong turns and longer routes on site. The UX therefore had to be designed for speed and clarity: find a place, understand where it is, and get there with minimal effort.

<Image src="images/case_studies/expo-city-dubai/case_study_body_1.png" format="fullwidth" alt="Home screen of the Expo City Dubai app" />

**Why Flutter?**

Expo City needed one team to ship consistently on iOS and Android, while keeping quality high and maintenance predictable. A single codebase in Flutter made that feasible—without sacrificing the degree of UI customization required for a highly branded, map-heavy experience. 

**The rationale came down to a few decision-level factors:**

* Cross-platform leverage: one product roadmap, one implementation stream, two platforms.   
* Performance for interactive UI: the app’s heart is the map and the interactions around it; Flutter’s rendering model and control over UI details fit that requirement well.   
* Developer experience and iteration speed: a fast feedback loop matters when backlog priorities change with events, seasons, and the city’s growth.   
* When native was needed: in a few edge cases, the team used Flutter’s **add-to-app** model—adding native iOS/Android extensions where required, while keeping the cross-platform core.

<br/>

**Building with Flutter**

[Merixstudio](https://www.merixstudio.com/development/flutter), Expo City tech partner, designed the product around a clear reality: for many people on site, “content” is secondary. The first question is: Where am I, where should I go next, and how do I get there?

Flutter enabled a single, consistent **map-first experience** across iOS and Android—critical when the map is the primary UI and the product must stay visually and behaviorally consistent for a diverse, international user base. It also gave the team strong control over UI interactions around Mapbox (map-driven browsing, navigation entry points, saved places) while keeping delivery and maintenance centralized in one codebase.

For maps, the team used the **official Mapbox Maps Flutter SDK**. Because it doesn’t include turn-by-turn navigation, they extended it via **platform channels**, bridging to the native Mapbox Navigation SDKs on iOS and Android. This kept the core experience and product logic in Dart, adding only thin native layers where necessary.

From there, the app expanded into supporting flows that turn “a map” into “a visit”—the same “what’s inside” promise described publicly on the app listing:

* Interactive map with point-to-point navigation, with bookmarking so users can pin places before arriving.  
* A directory of attractions, events, dining options, and businesses—a content layer that stays useful even when you’re not yet on site.  
* Visitor guide, including practical parking and accessibility information.  
* Event awareness, including “today’s events” improvements shipped in early 2026.

<br/>

**Architecture and integrations**

On the data side, a headless CMS (Contentful) supported consistent content updates, while integrations with Microsoft Dynamics helped fit the app into a broader digital ecosystem. 

To keep performance predictable during traffic spikes (for example during major exhibitions and events), the backend and infrastructure were set up for autoscaling on Amazon Web Services. 

Flutter also supported the project’s architecture and integrations by making it easier to keep “content services” wiring consistent across both platforms. The app consumed CMS-driven content and business data through API layers, with Flutter acting as the shared presentation and orchestration layer. Thanks to that, the Integration logic incl.data fetching, caching, error handling, and feature rollout rules didn’t have to be duplicated for iOS and Android. This reduced platform drift and made it simpler to evolve. 

The architecture relies on flutter_bloc for state management, get_it with injectable for dependency injection, Dio for networking, and go_router for routing. Storage is split between flutter_secure_storage for credentials and shared_preferences for lightweight state. Firebase powers analytics, crashlytics, remote config, and push notifications, while Tealium handles tag management. On the UI side, the team used cached_network_image, flutter_svg, video_player, and a Widgetbook-driven component library. 

The codebase is organized into internal packages—separating API, data, common utilities, widgets, and theming—keeping the dependency graph clean and enabling parallel development across the team. Where platform-specific SDKs were required—most notably Mapbox Navigation—the team used Flutter’s platform channels to bridge to native code, keeping the app fully within Flutter.

**Inclusivity by design: language and accessibility**

This is where mobile decisions become product decisions. The app was built to be culturally intuitive across multiple audiences and scalable across languages, including right-to-left layouts. It was also developed with accessibility in mind (aiming toward WCAG alignment and highlighting facilities available to people with disabilities). 

**Quality and trust (what's often invisible)**

Trust is often "felt" rather than explicitly articulated. Here, it was tested. The codebase went through a security audit by the Expo City Dubai's security team, and the project also underwent a sustainability assessment by Ecovadis at the Expo City Dubai's request.

<Image src="images/case_studies/expo-city-dubai/case_study_body_2.png" format="fullwidth" alt="Event calendar in the Expo City Dubai app" />

**Key results & business impact**

Below are the achieved outcomes: 

* Scalability validated at high traffic: load tests verified stability for up to 400,000 simultaneous users during spikes like major events.   
* Integration foundation: delivered several key integrations, including Contentful & Microsoft Dynamics as part of the initial solution, enabling the app to plug into the wider city ecosystem.   
* Client satisfaction: achieved a 10/10 NPS from users (with internal team satisfaction 4.5/5).   
* Design recognition: earned second prize in the mobile category at the WaysConf Awards.   
* Industry distinction: the app was listed among nominees in the “Travel & Transport” category of Mobile Trends Awards (awards announced in March 2025). 

And because the app’s growth is intertwined with the city’s growth, external recognition of Expo City matters too: in October 2025, Expo City Dubai was awarded the global “rising star” free zone of 2025 by fDi Intelligence. 

<Image src="images/case_studies/expo-city-dubai/case_study_body_3.png" format="fullwidth" alt="A screenshot of the Expo City Dubai app showing the interactive map" />

**Conclusion**

The key takeaway is that **Flutter works as an enterprise-grade foundation**—not just for cross-platform delivery, but for long-term product evolution. For Expo City Dubai, the app was designed as a **superapp platform**, bringing together multiple services and audiences in a fast-growing smart city. That architecture keeps the product flexible as the city expands—supporting everything from business and workplace needs to navigation, lifestyle, culture, and tourism. In other words, the app isn’t just describing the city; it’s becoming part of how the city runs.
