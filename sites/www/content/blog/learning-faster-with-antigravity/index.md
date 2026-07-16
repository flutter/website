---
title: "Learning faster with Antigravity"
description: "Creating Flutter frontends for ADK"
publishDate: 2026-07-01
author: redbrogdon
image: images/1XhysKMaIjv--tjhGDEas6A.webp
category: tutorial
layout: blog
---

<DashImage figure src="images/1XhysKMaIjv--tjhGDEas6A.webp" alt="Dash enjoying Antigravity" caption="Dash enjoying Antigravity" />


## Learning faster with Antigravity

### Creating Flutter frontends for ADK

How can I build a Flutter frontend for an agent when that agent is built with an SDK and a language I’ve never used before?

This was the challenge I faced when approaching a Python-based agent written with Agent Development Kit (ADK). With limited experience in Python and no prior exposure to the ADK framework, building a client that integrates with the backend server presented a significant learning curve. Plus, even if I could get a coding agent to crank out something that worked, finishing the project without understanding the code was also a form of failure.

After a few false starts, though, I found an answer. Using a structured, iterative workflow with my AI coding partner, Antigravity, I created a reusable developer skill that codified what I learned with each go-round. I started from scratch, generated notes about the code, created multiple apps that connected to the [`deep_search`](https://github.com/google/adk-samples) agent (a multi-agent research coordinator from the official ADK samples repository), and incrementally built up the skill and my own understanding. At times, I was using multiple agents at the same time, an “author” agent to create the skill with me, and a “coder” agent to use that guidance to build frontends.

What I ended up with was an agent skill called [`flutter_frontend_for_adk`](https://github.com/flutter/demos/tree/main/flutter-frontend-for-adk). It includes five reference docs that guide Antigravity through a sequence of phases, each one ending in a deliverable. The first phases generated the following notes files, so that I could structure how the “coder” agent thought about the task as it analyzed the agent and prepared to generate the app:

* `AGENT_INTERFACE_NOTES.md` — Notes taken during an analysis of the agent’s source code. What is it meant to accomplish and how is it constructed? What are the interfaces and APIs this agent exposes and how do they work?

* `FRONTEND_USAGE_NOTES.md` — The first spec. What should the frontend do and how should users interact with it?

* `FRONTEND_ARCHITECTURE_NOTES.md` — An architecture plan. What services, classes, state, and models should be created?

* `FRONTEND_DESIGN_NOTES.md` — A design document for the frontend. What will it look like? What are the colors, fonts, and other details?

After that, Antigravity could generate the application’s code, run, and test it. While the skill (and I) remain a work in progress, I’ve now got a decent handle on ADK, as well as a useful way to build frontends for existing agents.

This is how it happened.

<DashImage figure src="images/19kmUzKkC8c8EBCvMQKftBg.webp" alt="Screenshot of a generated frontend for the deep_search agent" caption="Screenshot of a generated frontend for the deep_search agent" />


## Start with the work of others

I’m not the only one writing skills around here, so the first step was to install some skills from the Google Cloud and Flutter teams:

```bash
npx skills add google/agents-cli --skill google-agents-cli-adk-code
npx skills add flutter/skills
```


Those got me some basic smarts about ADK, its CLI tool, and Flutter. I also had the Dart MCP server installed, thanks to the Dart extension for Antigravity.

## Establish the loop

Rather than begin with a request for the agent to blast out an app, I established a kind of “learning loop” with it. First, I asked the coder agent to execute the workflow from my skill, and then I worked with the author agent to manually evaluate the coder’s output, identify gaps in the skill’s instructions, and update the guidelines to improve future runs. After each iteration I deleted the generated notes and app, started over, and discovered the next thing I needed to learn.

<DashImage figure src="images/1GMT5ZFE5c7DhhwEqm7_iOw.webp" alt="Behold my loop!" caption="Behold my loop!" />


The loop consists of five distinct steps driven by conversations with Antigravity:

**1) Execute the current skill**: In a fresh conversation, the coder agent runs the workflow defined by the current version of the skill file.

My prompt: `This codebase includes an agent built with ADK, but no frontend or client. I’d like you to read the instructions in flutter-frontend-for-adk/SKILL.md and follow the workflow. Do not examine git history, do not reference the context of other conversations we’ve had, and do not change git branches.`

**2) Evaluate output and specifications**: In a second conversation, the author agent and I inspect the generated deliverables, such as architectural notes, design specifications, and the resulting code structure. I was better at noticing structural issues, while Antigravity helped catch all the little stuff.

My prompt: `While I review the notes and code, take a look at the generated artifacts and tell me how well you think they match the instructions and our goals.`

**3) Identify gaps and failure modes**: We identify areas where the coder agent lacked specific guidance, made incorrect assumptions, or encountered integration issues.

My prompt: `I noticed two issues in the last run: first, the root gitignore is ignoring the new frontend/lib/ folder due to a global ‘lib/’ ignore rule. Second, the coder agent is executing all six phases continuously without stopping. We need a way to pause and verify the deliverables after each stage.`

**4) Update central skill and references**: We update the instructions in SKILL.md or the sub-guides in the references/ directory to address the gaps.

My prompt: `Let’s update Phase 6 in SKILL.md to explicitly handle the gitignore issue by adding ‘!frontend/lib’ if ‘lib/’ is ignored globally. Also, add a mandatory ‘Review’ step at the end of Phases 1 to 4 instructing the agent to pause and wait for my approval before proceeding.`

**5) Clear local files and rerun**: I delete temporary specification files, reset the git working tree, and head back to the top of the loop.

While working with a pair of agents definitely sped things up, it didn’t make the process instantaneous. I can only absorb so much information at a time! Within each iteration, though, I read through notes and source files, reviewed the conversation with Antigravity, and (once I was generating real code) ran the app to see how it performed.

At the start, I was mostly reading and learning. By the end, though, I knew enough about what was going on to zero in on things that were failing consistently, start doing my own research, and tweak code to fix issues. After I was done modifying the notes and codebase, I’d ask Antigravity how it could update the skill to make future code generation look more like what I’d put together. As a result, the skill wasn’t just instructions for the coder agent, but a record of what I was learning.

## Loop the loop

It took thirteen iterations to get me to something that I’m not embarrassed to share. Here are the first six, which were mostly about discovery and note-taking:

1. **Bootstrapping and workspace mapping** — I realized that a single, monolithic `SKILL.md` file was too hard for the agent to navigate. I refactored the skill to be modular, creating a dedicated references/ folder and writing the first specialized guide: `references/agent_discovery.md`. That got Antigravity through analyzing the agent’s source and creating `AGENT_INTERFACE_NOTES.md` to record what it learned.

1. **Defining behavior and user experience** — Next up was the usage spec for the frontend: What would it do? How would a user interact with it? I added a new phase to the skill, instructed it to read references/frontend_usage.md and interview me for platform preferences and feature requirements. This got me `FRONTEND_USAGE_NOTES.md`, which defined the app’s purpose and feature set before we ever touched the code.

1. **Setting the structural blueprint** — Architecture. We added `references/frontend_architecture.md` to the skill, which focused on architectural details that the frontend would need, and I got the agent to produce `FRONTEND_ARCHITECTURE_NOTES.md`.

1. **Designing the visual aesthetics** — We created `references/frontend_design.md` to instruct the agent on how to define visual aesthetics and added scaffolding instructions to `SKILL.md`. This guide directed the agent to interview me for theme, breakpoint, and animation preferences, and Antigravity started producing `FRONTEND_DESIGN_NOTES.md`.

1. **Generating and running an app** — At this point, I was able to tell Antigravity to start generating the actual flutter code based on all the specifications we had gathered. The app failed pretty spectacularly, and I realized some kind of general “best practices” file was needed to get it over problems that were likely to reappear. We added `references/frontend_best_practices.md` to the skill files to guide the actual coding, and started fixing things one at a time.

From here on out, I continued iterating with Antigravity as I tackled one issue at a time, updating the code, updating the skill to match, and then wiping out the generated frontend to try again. In the process, the loop got tighter and the changes smaller. I did seven more iterations:

1. **The app can’t make network calls!** — Fixed the entitlements and info for macOS and iOS.

1. **All this markdown isn’t getting formatted!** — Took advantage of `flutter_markdown` to properly display text from the agent, which often contains markdown.

1. **Why doesn’t the code look right** ?— Added lints, formatting rules, and other post-generation checks.

1. **Sealed classes!** — Different message types should share a base type so the app can use exhaustive switch statements.

1. **Why aren’t the chats scrolling?** — Added a `ScrollController` to automatically advance lists of messages when new ones arrive.

1. **Why did the app crash when I ran it on the web?** — Removed `dart:io` and relied on `package:http` for networking.

1. **Partial events in my list!** — ADK sends a stream of events, sometimes in pieces. The frontend needed to assemble and present them coherently rather than give the user a list of all the partials (with broken markdown formatting).

1. **Why is the tool window blank?** — As generated, the apps weren’t dealing with tool naming conventions correctly, and the event handling wasn’t correctly identifying when tools were being invoked.

## An example “thing that went wrong”

To give you an idea of the work done in each of the iterations, let’s walk through one of the changes: how the frontend handles partial events.

The ADK server streams events representing small chunks of content or partial tool execution stages. If the client application renders every incoming network event as an individual message bubble in the chat list, though, the interface becomes fragmented. A single response from the agent would appear as dozens of isolated, broken text blocks.

**The old way (a naive list):**

```dart
// Rendering every raw event chunk in a list view
ListView.builder(
  itemCount: rawEvents.length,
  itemBuilder: (context, index) {
    // Each partial text chunk is rendered in a separate bubble
    return ChatBubble(text: rawEvents[index].contentText);
  },
)
```


This code leads to UI that looks like this:

<DashImage figure src="images/1MuEwLr96JNe25xfg6kc4Rw.webp" alt="Look at all those broken list items and half-bolded segments!" caption="Look at all those broken list items and half-bolded segments!" />


The fix for this isn’t particularly hard, once you know the right thing to do. I didn’t, of course, so I started asking Antigravity questions like “How does ADK use SSE to stream events?” and “What does the over-the-wire data structure for an event look like, and how do I know if it’s a partial event?” If “vibe learning” were a thing, I was doing it.

It turns out that you just need to check a flag, so I tweaked the code in the frontend’s `AgentProvider` class, asked Antigravity to review it in case I’d forgotten anything obvious, and ran the app to verify. It took one more request to Antigravity to update the best practices so that every new frontend would use this approach.

**The new way (aggregation in AgentProvider):**

```dart
await for (final event in stream) {
  if (event.partial && event.contentText != null) {
    // Accumulate streaming text
    _activeStreamingAuthor = event.author;
    _activeStreamingResponse =
        (_activeStreamingResponse ?? ‘’) + event.contentText!;
  } else {
    // Finished chunk: Clear accumulator and add to permanent events list
    _activeStreamingResponse = null;
   
    final updatedEvents = List<Event>.from(_activeSession!.events)
        ..add(event);

    // Merge state delta
    Map<String, dynamic> mergedState = _extractSessionStateMap(
      _activeSession!,
    );
    if (event.actions.stateDelta.isNotEmpty) {
      mergedState.addAll(event.actions.stateDelta);
    }

    // Build a new copy of the Session with updated events & state
    _activeSession = Session.fromJson({
      'id': _activeSession!.id,
      'app_name': _activeSession!.appName,
      'user_id': _activeSession!.userId,
      'events': updatedEvents.map((ev) => _serializeEvent(ev)).toList(),
      'state': mergedState,
    });

    _processCompletedEvent(event);
  }
  
  notifyListeners();
}
```


## Try it yourself

I’m very much a “learn by doing” person, and trying something entirely outside my comfort zone (like both a new language and a new SDK) was pretty intimidating. Having this loop, though, gave me a structure to work off of, which was really helpful, and now I have a [neat new agent skill](https://github.com/flutter/demos/tree/main/flutter-frontend-for-adk).

If you haven’t already, download Antigravity yourself and give it a try — it only took me a few hours, and I definitely picked up some new tricks.

To get started:

1. Download [Antigravity](https://antigravity.google) to integrate the agentic coding assistant into your development environment.

1. Visit the [AGY getting started](https://antigravity.google/docs/getting-started) documentation to learn how to define your own custom developer skills and reference guidelines.

1. Draft a simple skill for a framework you want to explore, and keep looping until you get something you like!