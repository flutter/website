---
title: "Flutter Q2 2026 survey — trust, transparency, and an evolving community"
description: >-
  The Flutter Q2 2026 user survey results are in!
  Discover developer satisfaction, trust levels, AI coding tool adoption,
  and updates on Cupertino widgets.
publishDate: 2026-08-06
author: twerske
image: images/q2-survey-header.webp
category: announcement
layout: blog
---

<DashImage figure src="images/q2-survey-header.webp" />

The Flutter team has been running user surveys twice a year
since Flutter's 1.0 release in 2018.
The Q2 2026 survey ran from June 8 to June 22,
collecting over 3,500 complete responses through Flutter's IDE plugins
(VS Code, IntelliJ, Android Studio), X, and our website.
We asked about:
- Overall satisfaction and trust, by focus area and developer segment
- Which editors and AI coding agents you use in your daily workflow
- Your perception of Flutter and Google

Overall, 93% of the 3,500+ respondents reported positive satisfaction
(top-2 box: very + somewhat), holding steady compared to Q4 2025.
Where things get really interesting is underneath that headline number:
58% of you are now very satisfied
(up a statistically significant 6 points from 52% in Q4 2025),
while "somewhat satisfied" dropped from 40% to 35%.
Trust in Flutter to consistently meet your development needs moved
in the same direction, rising from 77% to 83%.
We’re proud of the progress our team and community have made together
to drive these improvements.

Transparency is a core value for Flutter,
so we want to use this post to hold our work accountable to what you told us.
We reviewed our recent releases and
[2026 roadmap](https://github.com/flutter/flutter/blob/master/docs/roadmap/Roadmap.md)
directly against your feedback to see how our plans align with your
real-world experience.

## Satisfaction is up, especially for new Flutter devs 🚀

We track satisfaction across 16 parts of the Flutter experience every survey,
because a single overall satisfaction score hides important variance
underneath it.
This time, every developer subgroup we measure
(by experience level, company size, team size, and platform)
reached 90% or higher, marking a first in our survey history.

The focus areas that developers rated highest were the Dart language
(92% top-2 box), Android app development (91%), and the core framework (90%).
These scores have remained consistently strong across multiple surveys,
reflecting a solid foundation under real-world usage.

Novice developers have historically been our least-satisfied segment,
as starting with any new framework brings initial friction.
This time, however, novice satisfaction reached 90% top-2 box
(a 5-point increase from Q4 2025), and we don't think that's a coincidence.
Back in February, we launched the new
[Dart and Flutter Getting Started
experience](https://docs.flutter.dev/learn/pathway),
a guided learning pathway combining tutorials, videos, and quizzes
specifically for developers new to the ecosystem.

That said, when we isolate satisfaction from this same group for just the
core framework,
the experience gap remains wide: 82% for novices versus 93% for experts.
That 11-point spread is larger than almost any other split in the survey,
signaling that the core framework still presents a steep learning curve
that onboarding tutorials alone cannot solve.
While onboarding has improved,
helping new developers master core framework concepts
remains an isolated challenge we are actively working to address.

Interestingly, one likely driver is that novice developers report lower adoption
of AI tools in their development workflow.
Up to now, we have intentionally kept initial learning pathways manual
to encourage foundational understanding,
but given this trend,
we are exploring ways to surface AI-assisted Flutter guidance
to novices earlier to improve their early experience.

## AI coding tools have moved from experiment to default ✨

We added code editor
and agent usage to the survey for the first time this cycle,
and the results confirmed the AI-buzz we’ve all seen first-hand.
Traditional IDEs remain heavily used, with VS Code leading at 66%
and Android Studio at 40%.
But right behind them are AI coding agents: Claude Code at 32%
and Antigravity at 23%,
both now ahead of GitHub Copilot (19%), Cursor (18%), and Codex (17%).
(A note on methodology: respondents can use one or multiple editors,
so these numbers add up way beyond 100%.)

<DashImage figure src="images/editor-agent-usage.webp" alt="Bar chart of editor and agent usage among Flutter developers, ranked highest to lowest" caption="VS Code (66%) and Android Studio (40%) still lead, but Claude Code (32%) and Antigravity (23%) are now ahead of every other AI coding tool." />

Satisfaction with most editors clustered high: VS Code at 88% top-2 box,
Claude Code at 86%, and Codex at 85%.
One outlier: Zed sits at just 38% top-2 box satisfaction,
well below every other tool in the list, even though usage is still small (5%).
We don't have enough qualitative detail yet,
but we’ll continue to explore how tooling choice affects people’s
satisfaction with Flutter overall.

This isn't a new trend to us.
Vibe coding with Flutter has been on our radar for a while.
We shipped the [Dart MCP server](https://docs.flutter.dev/ai/mcp-server)
in mid-2025,
and Google I/O included the launch of
[official Agent Skills for Flutter and Dart](https://github.com/flutter/skills)
along with [agentic hot
reload](https://docs.flutter.dev/ai/antigravity#agentic-hot-reload)
(task-oriented instructions that work across any agent).
We’ve continued shipping, with a
[Flutter Antigravity plugin](https://docs.flutter.dev/ai/antigravity),
and are in the process of collaborating with other major agentic tools
to ensure Flutter plugins are available out of the box.

We want Flutter to be a first-party,
well-supported target for every major agentic coding tool,
and we're partnering both inside Google and with outside teams to make
that true.
Our current investment spans core models, eval systems,
and a combination of skills and MCP tools to ensure a high-quality
Flutter agentic developer experience and code generation.

## Where the experience still falls short

Not every subsystem is trending well.
Cupertino widgets, web, Windows,
and Linux are our lowest-rated areas in this survey.

<DashImage figure src="images/subsystem-satisfaction.webp" alt="Bar chart of satisfaction by subsystem" caption="Dart language (92%), core framework (90%), and Android app (91%) lead; Cupertino widgets (61%) is the lowest-rated area, down 6 points from Q4 2025." />

Satisfaction across Web (72%), Linux (73%), and Windows (74%)
all improved compared to Q4 2025.
Major roadmap initiatives are still ahead to build on this momentum,
including making WebAssembly the default web target
and expanding multi-window desktop support with Canonical.
These foundational changes take time,
which is why the satisfaction gap hasn't fully closed yet,
even as the overall trend moves in the right direction.

When we asked what's actually driving dissatisfaction more broadly,
four themes came through clearly.
Here's where we stand on each one today, without sugar-coating:

- **Platform and ecosystem maturity (44%)**:
This was the largest theme,
centered on upgrade pain rather than getting started.
Developers described losing hours to version-matrix guesswork
when upgrading older projects,
especially on Android when juggling Flutter, Dart, Gradle, Kotlin,
and JVM versions together.

Android tooling and dependency pain has come up in previous surveys.
We know that keeping up with Android's changing build requirements
is a major frustration,
so we’ve focused heavily on making your upgrades smoother and more predictable.
In **Flutter 3.29**, we removed legacy script-based Gradle plugin applications
to reduce breakage when new AGP versions ship.
**Flutter 3.32** rewrote the Gradle plugin from Groovy to Kotlin
for a more stable build process,
and **Flutter 3.38** published an official version matrix across Java, Kotlin,
AGP, and Gradle.
Most recently, **Flutter 3.41** added AGP 9 support,
and **Flutter 3.44** included
[migrations to use built-in Kotlin](https://docs.flutter.dev/release/breaking-changes/migrate-to-built-in-kotlin).

To eliminate the usual version-matching guesswork,
we now include a compatibility matrix in our
["What's New in Flutter" blog](https://flutter.dev/blog?category=release)
that maps out supported combinations of Java, Kotlin, Gradle,
and the Android Gradle Plugin.
We have also built smart fallbacks directly into our build tools so that
when major platform changes arrive
(like Android Gradle Plugin 9's transition to built-in Kotlin),
your existing projects and legacy plugins will continue to compile safely.
Our goal is to handle these complex transitions behind the scenes,
providing clear, actionable feedback when conflicts do arise so you can
get back to writing code.

Meanwhile, on iOS and macOS, **Flutter 3.44** made Swift Package Manager
the default dependency manager to replace CocoaPods,
with 92 of the top 100 iOS plugins already migrated.

- **Tooling and IDE experience (33%)**:
  Centered on wanting deeper Android Studio integration:
more AI tooling, more native support, better visualization.
Our current AI investments are focused on building AI tooling
that can be used with any agent, regardless of your IDE.
This includes the Dart MCP server and Agent Skills work,
which predate this survey's fielding.
That said, Android Studio didn’t have MCP support when we first launched
Dart MCP,
but we're working on making sure our tooling works there next.

- **Bugs and stability (24%)**:
Pointed at debug tooling specifically, such as breakpoints
that stick around after being removed
and a performance timeline view several developers found confusing.
We want to be straightforward here: we don't have a shipped fix,
but if you have details or reproductions we can use to debug further,
please file an issue on GitHub.

- **UI/UX aesthetics (14%)**:
Was the smallest theme by volume,
but it's the one most directly tied to Cupertino's score drop,
so it deserves its own section, right below.

## Cupertino widgets: a new chapter

Cupertino widgets dropped 6 points to 61% top-2 box,
marking the steepest decline anywhere in the survey
and becoming our lowest-rated area.
Several developers described feeling like Flutter's promise of
native-feeling apps
hadn't kept pace specifically for iOS-style design,
expressing concern that native design systems got deprioritized
once they became difficult to maintain inside the core framework.
While we are watching this feedback closely, this doesn’t come as a surprise.
We intentionally paused work on Cupertino widgets to execute on decoupling
to get to that better world where we can ship faster.

In the August release, we're shipping the first step of that decoupling,
publishing [material_ui](https://pub.dev/packages/material_ui) and
[cupertino_ui](https://pub.dev/packages/cupertino_ui) packages on pub.dev.
Once that's live,
native design fidelity stops being gated behind core framework release
cycles
and can iterate on its own schedule, with contributions landing
and shipping faster.
This foundational work is already unblocking us to start tackling platform
fidelity work
we couldn't move fast enough on before,
like adopting Material 3 Expressive and Apple's Liquid Glass design language.
That's the tangible upside of decoupling:
Material and Cupertino get to evolve on their own schedule instead of
waiting on Flutter’s core,
opening the door for us to partner directly
with the community on these design systems.

## Trust in Flutter, as our community model keeps evolving

We added a new section to this survey to establish something we haven't
had before:
a real baseline on developer trust in Flutter,
so we can track how it moves as our community model keeps changing.
Flutter is consistently one of the most active repositories on GitHub,
and how we operate in the open matters.
For example, Canonical now leads the Flutter desktop roadmap,
and we have proposed a formal contributor ladder aimed at growing the
maintainer base well beyond Google.
We wanted a real read on where trust sits today,
before more of those shifts land, not after.

98% of you correctly identified Google as Flutter's creator,
so awareness was never really the question.
What matters more for a baseline is
that when we asked you to rate trust in Flutter
and trust in Google separately, Flutter came out 20+ points ahead every time:
83% top-2 box trust in Flutter versus 62% in Google,
consistent across company sizes.
This is a strong signal supporting our continued investment in growing our
maintainer group beyond Google.

<DashImage figure src="images/trust-flutter-vs-google.webp" alt="Grouped bar chart comparing trust in Flutter versus trust in Google to consistently meet development needs, split by company size" caption="Flutter (83% top-2 box) outpaces Google (62%) by 20+ points across every company-size segment." />

When we asked what actually builds that trust,
framework performance and stability topped the list at 26%,
ahead of community size and activity (20%) and documentation quality (19%).
And when evaluating a brand-new feature, more of you said you'd trust it
because it's "battle-tested" by the community (41%)
than because it was built by Google engineers (26%).
That's good news for where we're headed:
the credibility we've built is earned independently through the framework
and its community.
That is exactly the kind of trust we want to protect
and grow as we open up the maintainer base further.

## Where responsiveness still lags

Agreement that Flutter is proactive about technical issues
and responsive to developer feedback sits at 71%,
a full 10+ points below every other statement we asked about reliability
and safety.
Our 2026 plans describe a structural response to that gap:
expanding the Consultancy Program, the Google Developer Expert network,
the Customer Advisory Board,
and the Partners Advisory Board as formal feedback channels.
Formal advisory channels help us build the right roadmap as Flutter scales.
At the same time, we remain committed to prioritizing GitHub and Discord
so every community member feels heard,
while expanding social listening
and ensuring contributors at all levels can share ideas and feedback.

There's a structural version of this same problem on the contributor side,
and we're addressing it head-on.
For years, the only path to a trusted role on Flutter
(such as code review rights and merge access)
has been informal admission to the `flutter-hackers` group,
decided case-by-case by whoever happened to notice your work.
Over 70% of currently open PRs in the Flutter project come from
contributors outside of Google.
We are excited to deliver a clearer, more open path for these contributors
to become official members of the Flutter project.

Shortly after this survey closed,
we published a proposal publicly for community feedback:
a formal, four-tier [Contributor Ladder](https://docs.google.com/document/d/1ITkAaE96R1kWgttDFVQYYKvdyHlcOz_Rs1QyiS8JMEY/edit?tab=t.0)
(Contributor → Reviewer → Committer → Maintainer)
with public, data-driven promotion in a new `flutter/contributors` repository,
replacing the old informal sponsorship model entirely.
It also introduces a formal path to project leadership,
not just code contributions.
This is a major step forward for expanding who gets to lead this project!
Because it went public after the survey closed,
we wouldn't expect it to show up in these numbers yet,
but it's a direct answer to the transparency gap this section is about,
and we'll be watching whether it moves the needle next time.

## Thank you 💙

Over 3,500 of you took the time to answer honestly across two weeks in June
(through IDE plugins, X, and our website),
and that's what makes this whole exercise worth running twice a year.
Every piece of feedback in this post came from someone who could have just
closed the survey tab instead.
We know that, and we don't take it for granted.

## What's next?

This survey told us Flutter is in a genuinely strong place.
Satisfaction and trust both moved up,
we're making it easier for new Flutter developers to join our community,
and the AI-assisted workflows so many of you have adopted align directly
with what we're building.

It also confirmed key areas where we need to keep pushing forward:
publishing the `material_ui` and `cupertino_ui` packages,
continuing to improve support for Web and Desktop, and much more.

Let's keep building the future of Flutter together,
with you and not just for you.
Tell us what resonated on social media, and see you in the next survey!
