---
title: "Vibe once, run anywhere with Antigravity and Flutter"
description: >-
  How Flutter and Antigravity helped build and launch an asteroid landing game.
publishDate: 2026-06-29
author:
  - craiglabenz
  - rodydavis
image: images/1Mg2Bj5FBg1I19r1Jw4q9Kg.webp
category: story
layout: blog
---

<DashImage figure src="images/1Mg2Bj5FBg1I19r1Jw4q9Kg.webp" />

Coding agents and the way we use them has already dramatically evolved since their arrival just a handful of months ago. Initially, the focus was heavily on observation — reviewing every single output line by line. But as models rapidly increased in capability, the industry shifted toward true agentic engineering. Today, developers, PMs, and designers are wearing multiple hats, focusing on lofty conceptual goals and letting agents tackle the individual components.

To explore this new frontier, our team wanted to build an experience that showcased this exact workflow. We wanted to build a game, generate its assets, write the marketing page, and deploy the whole thing, all using Google’s premiere AI-native platform: Antigravity.

Antigravity brings the best of Google into one place, using a tight feedback loop of planning, acting, and verifying. It creates artifacts, writes code, runs tests, and even clicks buttons in your UI to ensure it actually completed the task correctly.

The result of our agentic adventure is DashLander — a moonlander-style game set on procedurally generated asteroids. Here is the story of how we built it.

### Why Flutter in the AI era?

A lot of people might be thinking: *If agents can write native code, why not just have them write Android, iOS, and web apps entirely separately?*

That is a valid question; and is what originally inspired the concept of Flutter as a **“Vibe once, run anywhere”** UI toolkit.

Having a single source of truth is just as important for AI as it is for humans. By having an agent write a single, cross-platform app, teams can eliminate the subtle bugs that inevitably creep in between different languages or platform-specific paradigms. Furthermore, Dart’s strong typing gives LLMs excellent feedback. Languages with looser typing systems require dramatically more analysis by the LLM to know whether a given piece of code is correct across all scenarios. Flutter and Dart, on the other hand, use their analysis server to send strong signal about mismatches in function signatures or class shapes to your agent. Paired with stateful hot reload, agents are just as accelerated by Flutter as human developers.

And, while agentic development has dramatically reduced the cost of producing new software, it’s still far from being free. With agentic development, time is money both figuratively *and* literally, as more time spent querying equals more tokens; which equals more AI spend. With Flutter, agents fresh off a successful coding task don’t have to start over to support another platform, **saving you money**.

### Failing fast to build better

We knew we wanted to build a game where you pilot a moonlander, complete with dynamic elements, custom shaders, and particle effects. (We didn’t have the heart to put Dash herself into the cold vacuum of space so, instead, you’re piloting a ship.) Integrating these concepts was, of course, vastly accelerated by using AI, but that doesn’t preclude slowing down and thoughtfully writing high quality code later on. If anything, a fast exploratory phase with AI helps you reach that stage more quickly, as many of your failed experiments can come and go within the life cycle of a few prompts rather than taking hours or days of programming just to learn whether or not a specific idea is actually much fun. And if there’s one thing in this life that doesn’t matter, it’s the code quality of an experimental feature that never sees the light of day.

Crucially, we also knew what we *weren’t* building: a high-performance, real-time multiplayer game. Real-time multiplayer features introduce latency constraints and exponentially scale infrastructure complexity. Instead, we realized we could deliver 90% of that engaging competitive experience by replaying the ghosts of past high scores in a Challenge Mode. This allows us to rely on static storage and simple backends and to cleverly reuse perfectly written “AI opponent logic” for free, just by replaying what the best users have already done. And that’s the best code of all: the code you neither write nor maintain.

### Generating a universe of assets

To make an asteroid lander fun, we needed great assets, and we leaned heavily on the agentic ecosystem to get them:

* **Audio:** We used Google’s Lyria to generate background music. (Though, putting on his old audio engineer hat, Rody did record custom thruster noises in his backyard with a microphone, a hose, and a spray can. What a fun afternoon!)

* **Visuals:** We generated UI designs in Stitch and Google Canvas. Gemini wrote our particle effects directly in code and we used Nano Banana to generate the app icons.

* **Physics:** Because this game takes place in a vacuum, we wanted accurate Reaction Control Systems (RCS). We unleashed Gemini Deep Research to find the exact zero-atmosphere physics formulas we needed, which it compiled into a Google Doc. Then we included that research in our context and Gemini translated the equations directly into Dart. Are they *actually* the right physics equations? Hilariously, we don’t know, because we’re not physicists! But the controls certainly *feel* correct when you’re playing the game.

### Iterating on the prototype

We started our build inside AI Studio’s sandbox to generate rapid, throwaway code before committing to an architecture. These rich prototypes can act as context compression for the model later, locking in micro-decisions early. Some of our prototypes had more fun gameplay, some looked significantly more appealing, and others captured our zero-G physics most cleanly. For our final game, we merged the best ideas from each prototype.

Once we loaded the project into Antigravity, we equipped our agent with the MCP servers for Firebase, Flutter, the Flame game engine, and the Gemini API. We kicked off a fresh prompt and Antigravity split the tasks across specialized sub-agents for the backend, UI, and game logic. Within five minutes, we had a game, written in Flutter and Flame, that would have normally taken days to write. But realistically, it wasn’t anywhere near done. There were only three hard-coded levels, the camera didn’t follow the lander, and the math implied our ship was roughly the size of the Empire State Building.

<YoutubeEmbed id="3mKKi8ZW0Yg" title="Dashlander v1" fullwidth="true"/>

It took about another 100 prompts to get the game to its final state. A huge percentage of those prompts were just about code organization and adding tests. Everyone has their own relationship with reading AI-generated code, but Rody and I highly value what I’ve been calling “cognitive ownership” and want to still understand the deep inner workings of our app. We read a lot of what Gemini wrote, pushing back on the LLM to refactor for clarity and reusability.

I also had to face a harsh reality: I am not great at trigonometry, and *boy* is there a lot of it in DashLander. When the agents told me they perfectly implemented a new system like landing calculations and scoring, I’d often play the game and immediately see discrepancies. Unfortunately, no matter how much I read Gemini’s dense trigonometry in my codebase, I couldn’t pinpoint where the disconnect was hiding. To escape this Catch-22, I asked Gemini to build a top-secret debug mode behind a keyboard shortcut. It rendered overlays showing the exact terrain data, relative tilts of the surface, and collision hitboxes, allowing me to prove to myself exactly where the agent’s calculations were wrong. Armed with definitive evidence, I was able to help work with Gemini to fix problems in the files of dense math.

<YoutubeEmbed id="cVcM8jZ_Ioo" title="Dashlander debug mode" fullwidth="true"/>

### The tricky business of time travel

When we added Challenge Mode, Antigravity did a brilliant job wiring up the data models and connecting them to Cloud Firestore. But during testing, I noticed a sneaky bug. I would race against the ghost of a previous high score and, visually, everything looked great as the ghost ship drifted along nicely. But as the replay went on, it turned out that the ghost ship was imperceptibly desyncing from its past self. At the end of the run, despite the original player having landed perfectly, the ghost ship would sometimes violently crash into the asteroid.

To solve this, I had to make like it was 2023 and turn on my own brain. *Scary*, I know.

I realized that the core problem was a fundamental aspect of modern computer architecture. You see, on a modern, multi-process CPU, you can tell a program to run a piece of code at an exact millisecond in the future, but the CPU can never guarantee perfect accuracy due to the nature of process scheduling. And, unfortunately for me, a single millisecond delay in activating a thruster during a replay fundamentally alters a ship’s simulated flight path. I realized that, instead of just logging thruster timestamps, I had to store a complete representation of the lander’s physical state at the exact moment of each thruster event to correct inaccuracies during a replay. Gemini then integrated the logic to continuously compare the replay’s live simulation against these physical checkpoints, auto-correcting any micro-drifts. The result was a flawless, crash-free replay.

### From game to launch

You’ve probably felt the pressure to wear more hats in your day job, regardless of the size of your team. For example, maybe you’re great at writing games but don’t want to market them. Or, you’re a rockstar UX engineer but prefer not to handle graphic design. The good news is, you don’t have to do everything alone.

We used Stitch to generate our marketing landing page from a single prompt, passing in screenshots of our running game as context. (Admittedly, if producing an optimized landing page had been our actual goal, we would have iterated on that a bit more.) Using a one-click export into Antigravity, we then downloaded the HTML and got to work. Because we were building in Dart, we wanted to keep our stack unified. We used [Jaspr](https://pub.dev/packages/jaspr), a web framework that maps HTML directly to Dart components, to seamlessly integrate the generated HTML. Gemini handled this conversion perfectly, allowing us to share code between our game and our marketing site while preserving industry-standard SEO indexing.

Finally, we used the Antigravity CLI to build our Flutter web app, copy the build directory over to Jaspr, run the build script, and deploy directly to Firebase Hosting — all in one unbroken terminal workflow.

While DashLander is currently web-first to easily validate mechanics, because it’s built with Flutter, we are always just one command away from deploying to iOS, Android, macOS, Windows, Linux, or even the infotainment panel in a Toyota RAV4. As of this writing, the game is currently available at [dashlander.com](https://dashlander.com); though if you find this article far enough into the future that that link has gone dry, you’re welcome to download the [code straight from GitHub](https://github.com/craiglabenz/dashlander).

### Realizing YOUR vision

To get started building your dream app or game, head to [antigravity.google](https://antigravity.google) for Google’s Agent Manager and IDE; and to [flutter.dev](https://flutter.dev) to get started with the Flutter SDK.

Good luck, and we can’t wait to see what you build!
