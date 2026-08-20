---
title: "Architects, testers, and coders: Building multi-agent development teams"
description: >-
  How multi-agent development teams running in Antigravity can port Python
  libraries to idiomatic Dart packages using test-driven development.
publishDate: 2026-08-20
author: redbrogdon
image: images/header.webp
category: deep-dive
layout: blog
---

<DashImage figure src="images/header.webp" alt="Illustration representing an AI multi-agent software development team with architects, testers, and coders" />

When I first began experimenting with AI coding assistants,
I used a single agent for everything: architecting code, writing unit tests,
and debugging stack traces. While this approach worked well for small tasks,
it quickly degraded on complex software engineering problems.
As my conversation history grew,
the agent's context window became saturated with logs and search results,
leading to hallucinations, missing connections, sloppy code, and bugs.

A couple weeks ago, I stumbled onto [a blog post about multi-agent,
TDD coding
workflows](https://thagomizer.com/blog/2026/06/24/ping-pong-pairing-with-antigravity.html).
I’d heard of the approach before, but had never tried it.
Since Antigravity's Agent Hub includes tools for multi-agent setups,
I decided to put the technique to the test.

To test it on a real challenge,
I set out to port the popular `python-statemachine` library to a statically
typed, reflection-free Dart package.
While pub.dev already has solid state machine options,
`python-statemachine` made a fantastic benchmark.
It relies heavily on dynamic Python features (like metaclasses and runtime
callbacks) that had to be completely re-architected for Dart's strong static
typing and Flutter's requirement that `dart:mirrors` not be used.

<DashImage figure src="images/workflow.webp" alt="Diagram showing the roles and workflow of the multi-agent development team" caption="It's less complicated than it looks, I swear!" />

One of the first things I learned is that the foundation of an effective agent
team is a set of well-defined roles that come with specific constraints on what
the agent is allowed to do. To implement those,
I created an overarching workflow skill (`tdd-dart-workflow`) to establish the
shared TDD rules and permissions,
along with four role-specific skills defining each agent:

- **Architect (`tdd-dart-architect`)**: Analyzes source code,
produces the upfront `architecture_blueprint.md` (Phase 0),
and writes targeted module specifications under `specs/` (Phase 1).
The Architect cannot write to `lib/`, `test/`, or `example/`.
- **Tester (`tdd-dart-tester`)**:
Writes comprehensive failing unit tests under `test/` based on the Architect's
specification (Phase 2a). The Tester cannot view or write to `lib/` or `specs/`.
- **Coder (`tdd-dart-coder`)**:
Creates compilation skeletons and implements library code under `lib/src/` to
make failing tests pass (Phases 2b & 3).
The Coder cannot edit `test/` or `specs/`.
- **Coordinator (`tdd-dart-coordinator`)**: The coordinator parent agent.
The Coordinator manages Git branch commits,
executes `dart analyze && dart test` verifications,
and delegates tasks to the subagents.

By enforcing strict role separation,
no single agent could alter both the test assertions and the underlying code.
The Coordinator acts as a gatekeeper,
receiving only a brief completion report when a subagent finishes its task.
This creates a "cognitive firewall." Beyond being a fun phrase to drop in job
interviews,
it means each subagent's trial-and-error token history is discarded once their
task completes. As a result,
the parent Coordinator's context window stays clean, focused,
and free from token saturation.

To be clear, there are potential problems that I'm hand-waving here,
like "What happens if a subagent gets stuck in a loop?" and "Should there be a
time cutoff after which a subagent is killed and recreated or a human is
notified?" This is my first foray into multi-agent teams, though,
and I'll save those for a follow-up blog post!

To prevent race conditions and unverified code commits,
filesystem write access is restricted in `tdd-dart-workflow` at the tool level
based on the agent's assigned role:

| Agent role | Allowed read path | Allowed write path | Forbidden actions |
|---|---|---|---|
| **Coordinator** | Anywhere | Anywhere | Direct code modifications (delegates to Coder/Tester) |
| **Architect** | Anywhere | `specs/`, `skills/` | Cannot write to `lib/`, `test/`, or `example/` |
| **Tester** | Anywhere | `test/`, `example/` | Cannot write to `lib/` or `specs/` |
| **Coder** | Anywhere | `lib/`, `example/` | Cannot write to `test/` or `specs/` |

In my version,
these restrictions are included in the instructions for the agents,
so it's technically possible for them to be violated.
As multi-agent systems evolve, though,
I expect we'll start to see ways to implement restrictions in more secure ways.

## An example challenge

Operating a multi-agent team in a compiled language like Dart introduced an
interesting challenge:
the tension between static compilation and the need to write tests for code that
doesn't yet exist. In dynamic languages like Python,
TDD starts with a failing test (Red) that throws a runtime error.
In static languages, however,
writing unit tests for methods that do not yet exist causes a compile-time
failure. The compiler aborts,
preventing the test runner from executing and proving that the test itself is
valid.

My agent team solved this within the **Red Phase** loop. First,
the Tester writes tests targeting the Architect's specification. Next,
the Coder creates a compilation skeleton under `lib/src/` with class and method
stubs that return dummy values or throw `UnimplementedError`.
Once the skeleton satisfies the compiler,
the Coordinator runs `dart analyze && dart test` to verify that the tests fail
for the right reasons (unimplemented logic rather than syntax or import errors).
Comment boundaries ensure that temporary skeleton stubs are isolated from
permanent test utilities,
allowing the Coordinator to clean them up automatically once the Coder completes
the Green phase:

```dart
// TEST UTILITIES - KEEP PERMANENTLY
class MockListener extends Mock implements StateMachineListener {}

// SKELETON STUBS FOR COMPILATION - DELETE ONCE SKELETON IS IMPLEMENTED
class StateMachine<T extends StateModel> {
  dynamic get currentState => throw UnimplementedError();
  dynamic get currentStateValue => throw UnimplementedError();
  void send(String eventId) => throw UnimplementedError();
}
```

## What didn't go well: Friction points and mid-flight skill updates

Using agents definitely made the process of porting the library faster,
but it comes with its own challenges. The moments when the workflow broke down,
though, provided the most valuable engineering lessons.
Mid-way through the porting process,
I had to pause and update my skill files (`SKILL.md`) to resolve three issues:

- **Accidental Deletion of Test Utilities**:
Once the Coder implemented the real library classes in `lib/src/`,
the Coordinator had to clean up the temporary compilation stubs left in the test
files. It kept getting the stubs and the real thing confused,
so required explicit comment headers for the real implementation to make things
explicit.
- **Spread Operator (`...`) Type Mismatches**:
Python and Dart handle types differently,
and things that are iterable by default in Python aren't necessarily so in Dart.
I had to add some explicit instructions on things that needed to implement
`Iterable` as a result.
- **"Foreign-Accented" Dynamic Typing**: Here again,
the different type systems caused problems.
The original Python library used `hasattr` checks in a few places.
I had to refine `tdd-dart-architect/SKILL.md` to force the Architect to use
idiomatic Dart and explicit callback delegates instead of dynamic property
lookups.

These skill refinements directly shaped the final design.
The resulting Dart package (`state_machine`) retains the full feature set of
`python-statemachine`,
with the Coder agent implementing fluent builders to support Dart's native
spread operator (`...`).
Below is a comparison between the original Python class definition and the final
Dart state machine produced by the agent team:

The old way:

```python
# python-statemachine syntax (declarative via metaclasses)
from statemachine import StateMachine, State

class TrafficLightMachine(StateMachine):
    green = State("Green", initial=True)
    yellow = State("Yellow")
    red = State("Red")

    cycle = green.to(yellow) | yellow.to(red) | red.to(green)

    def on_enter_green(self):
        print("Entered Green state")
```

The new way:

```dart
// state_machine Dart syntax (declarative constructor DSL)
import 'package:state_machine/state_machine.dart';

class TrafficLightMachine extends StateMachine<TrafficLightModel> {
  final green = State('green', initial: true);
  final yellow = State('yellow');
  final red = State('red');

  late final Event cycle;

  TrafficLightMachine(TrafficLightModel model) : super(model: model) {
    cycle = event('cycle');

    initialize(
      states: [green, yellow, red],
      transitions: [
        ...green.to(yellow).on(cycle).transitions,
        ...yellow.to(red).on(cycle).transitions,
        ...red.to(green).on(cycle).transitions,
      ],
    );

    green.onEnter((EventData data) {
      print('Entered Green state');
    });
  }
}
```

The point of all this was more to produce a set of reusable skills for myself
rather than to create and publish a new Dart package.
I'm not in a position to watch for reported issues and maintain this over time,
I can't vouch for all of the code that was created (though it worked when I've
tested it),
and there are already several well-maintained packages in the ecosystem.
Hopefully, though,
this has given you a look at what multi-agent systems running in Antigravity can
do for Dart and Flutter developers.

If you'd like to explore multi-agent workflows in your own projects, go for it!

- Download [Antigravity](https://antigravity.google/).
- Visit the [AGY getting started
documentation](https://antigravity.google/docs/getting-started) to learn how to
define your own agents and custom developer skills.
- Check out the [actual skill
files](https://github.com/flutter/demos/tree/main/multiagent_skills) I created
while working on this project, modify them to suit your needs,
and let us know how it goes!
