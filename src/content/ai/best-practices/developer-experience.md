---
title: Developer experience
description: >
  Learn how to use spec-driven development and Gemini to plan, code, and 
  iterate on high-quality Flutter applications.
prev:
  title: Mode of interaction
  path: /ai/best-practices/mode-of-interaction
---


Generative AI is not just useful for implementing features in your app; it's
also useful for generating the code to implement those features.

Unfortunately, it's just as easy as prompting an AI coding agent to "build a
Flutter app that solves crossword puzzles." I'm sure that prompt would yield
something, but I doubt very much that it would give us the powerful AI-assisted,
user-validated combination the Crossword Companion provides.

With better prompting, however, the sample app was implemented with Gemini 2.5
Pro for the bulk of the functionality and Gemini 3 Pro Preview to add the final
touches. The process to get the best results from both models was the same:

- Plan  
- Code  
- Validate  
- Iterate

### Plan

The goal of the planning process is to kick off the coding process with enough
detail to let the agent know what you have in mind. The Crossword Companion
planning process was started with the following prompt:

```plaintext
I'd like to create a file called requirements.md in the plans folder at the root of the project. here's a description of the project:

The application will be an open-source sample hosted on GitHub in the flutter/demos directory. It aims to demonstrate the use of Flutter, Firebase AI Logic, and Gemini to produce an agentic workflow that can solve a small crossword puzzle (one with a size under 10x10)....lots more description of the app along with a sample puzzle screenshot...
Ask any questions you may have before you get started.
```

This prompt, with a little bit of Q&A, manual edits by a human, and some updates
during the coding process, yielded [the requirements file][requirements].

Before jumping into architectural design, the Gemini CLI was asked to initialize
the GEMINI.md rules file and then to update it with a list of architectural
principles:

```plaintext
DRY (Don't Repeat Yourself) – eliminate duplicated logic by extracting shared utilities and modules.

Separation of Concerns – each module should handle one distinct responsibility.

Single Responsibility Principle (SRP) – every class/module/function/file should have exactly one reason to change.

Clear Abstractions & Contracts – expose intent through small, stable interfaces and hide implementation details.

Low Coupling, High Cohesion – keep modules self-contained, minimize cross-dependencies.

Scalability & Statelessness – design components to scale horizontally and prefer stateless services when possible.

Observability & Testability – build in logging, metrics, tracing, and ensure components can be unit/integration tested.

KISS (Keep It Simple, Sir) - keep solutions as simple as possible.

YAGNI (You're Not Gonna Need It) – avoid speculative complexity or over-engineering.
```

The GEMINI.md file is loaded into every new prompt you create with Gemini; it
provides the set of rules you want it to remember for any activity. Gemini was
running inside of an empty Flutter app project, so the `/init` command
documented how to build, test and run it, which was useful during coding.

If you're building something more than a sample, I also recommend adding
something for test-driven development:

```markdown
- **TDD (Test-Driven Development)** - write the tests first; the implementation
  code isn't done until the tests pass.
```

This helps to build guardrails to ensure the coding agent is writing solid code
over time.

With the requirements and rules in place, prompting for the design.md file was
next:

```plaintext
great. i'd like to work on the design with you to be created in a design.md file to be stored in the plans folder. please use the @GEMINI.md and @requirements.md files as input. ask any questions you may have before you get started.
```

After inspecting and editing the generated app design, Gemini was prompted to
break it down into [tasks][tasks-spec]:

```plaintext
please read the files in the @specs folder and create a corresponding tasks.md file in the same folder that lays out a set of tasks and subtasks representing the functionality of this app. lay out the top-level tasks as minimal new functionality that the user can see in the running app, step-by-step as each top-level task is completed. each top-level task should include sub-tasks for creating and running tests and updating the @README.md with a description of the current functionality of the app. ask any questions you may have before you get started.
```

All of this happens before any code is written. You don't have to split things
into separate files, but by carefully considering the requirements, the design
and the task breakdown, you're helping the agent to provide results that meet
your expectations. This is called "Spec-Driven Development" and it's currently
the best way we know of to upgrade your process from "vibe coding" to
"AI-assisted software development."

Also, the sentence that says "ask any questions you may have before you get
started" is a great way for the agent to clarify anything that it doesn't
understand instead of just making up the answers as it goes. It's also useful to
help you to decide on details you might not otherwise have considered.

### Code

With the requirements, rules, design and tasks in place, kicking off the coding
part is easy:

```plaintext
Read the @tasks.md file and implement the first milestone.
```

You can watch the coding agent at work, jumping in to correct it as it works, or
just let it go. Either way, when it's done, it's time to check its work.

### Validate

At this point, you have some code and (in the world outside of samples) some
tests. To validate, ask yourself some questions:

- Does the analyzer show it to be free of errors? Of warnings?  
- Does the app run?  
- Does it have the features you asked for? Do they work?  
- Do the tests pass?  
- Does the code pass your review?

The answers to these questions are the input for the next phase.

### Iterate

Gather the issues that need to be addressed and hand the ones that need fixing
back to the coding agent, iterating between it coding and your validation until
you get to a good place from a functional point of view.

Now take another pass through validation from an architectural principles point
of view, spinning up a new agent to check the code. By clearing out the agent's
context, you remove the biases the original agent gathered choosing what code to
write in the first place. To ground it on just the code changes the agent has
just made, use a prompt like this:

```plaintext
Use git diff to find the new code and check it against the architectural principles listed here: @GEMINI.md. Make recommendations for important improvements.
```

Doing this a few times keeps the code in good shape for AI agents and humans
alike.


[requirements]: {{site.github}}/flutter/demos/blob/main/crossword_companion/specs/requirements.md
[tasks-spec]: {{site.github}}/flutter/demos/blob/main/crossword_companion/specs/tasks.md
