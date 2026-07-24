---
title: "Jaime’s build context: Prompt engineering as infrastructure"
description: >-
  Learn how reproducible systems, versioned prompts, and shared skills
  support reliable agentic development.
publishDate: 2026-01-23
author: jwren
image: images/1HNqQFQ2hdhAgjew1pIMqXA.webp
category: engineering
layout: blog
---

<DashImage figure src="images/1HNqQFQ2hdhAgjew1pIMqXA.webp" />

## Summary

In the era of agentic AI, the bottleneck for scaling projects has shifted from code volume to code integrity. To move at the speed AI allows without introducing systemic friction, we must stop treating AI as a magic wand and start treating it as a high-performance engine that requires a perfectly calibrated track.

* Close the gap: Engineering teams are splitting — traditionalists on one end and high-velocity agentic power users on the other. For production apps, your infrastructure must connect both, creating a shared space where traditional rigor and agentic speed don’t just coexist, but actively harden each other.

* Lean into reproducible systems: An agent is only as good as its feedback loop. If your tests aren’t reproducible and your CI lacks a high-signal feedback loop, your agents are flying blind.

* Prompts as infrastructure: Stop treating your best AI instructions as ephemeral chat one-offs that disappear when a session ends. Instead, move these automated workflow instructions into a version-controlled file, transforming your individual tribal knowledge into executable documentation that ensures every team member can trigger the same high-integrity results reliably across the project.

* Shift to Skill-based architecture: Success means graduating your proven workflows into shared Skills. By moving from individual prompts to project-wide Skills, you provide your entire team with a standard, high-integrity playbook that agents can execute automatically.

Recently, I’ve been reflecting on what it truly means to scale an open-source project for a new wave of contributors. We are moving into an era where agentic AI can generate code so rapidly that sheer volume is no longer the bottleneck; instead, the real challenge is ensuring this influx doesn’t compromise our codebases, or our shared values as teammates. Many teams are splitting into a dumbbell shape: traditional manual coding on one end and high-velocity agentic power-users on the other.

For large apps, our infrastructure must serve as the handle that connects these two ends of the spectrum, creating a shared space where traditional rigor and agentic speed don’t just coexist, but actively harden each other. To scale effectively, we must lean into the basics by anchoring our workflows in the fundamentals of reproducible software development. To move at the speed these tools allow without drowning in technical debt or unreadable codebases, our environments must provide a definitive, high-signal feedback loop.

In this agentic context, source code health is measured strictly by passing tests, deterministic coverage metrics, and clean analysis. If these fundamentals are missing, it’s like asking a high-performance engine to drive at breakneck speed through the dark. It is perfectly reasonable — and often responsible — to feel the need to push back against these new tools if the environment isn’t ready for them.

The goal here isn’t to force a tool onto a project for the sake of speed; it’s to build the digital sensors that allow us to adopt that new velocity safely. More importantly, this transition is about bringing our teammates along for the ride. Infrastructure shouldn’t be a barrier that separates the “AI power users” from the rest of the team; it should be the common ground where we all feel confident. Being a good teammate in the agentic era means ensuring that though our repositories might move faster, our culture remains supportive. We build these systems so that everyone can move with confidence, ensuring that “agentic speed” is a win for the whole team, not just a new risk for an existing functioning software product.

However, these digital sensors are only as reliable as the environment in which they live. This is why we must anchor our trust in our CI systems. In a truly reproducible workflow, the CI is the only version of reality that matters; it is the final arbiter for an agent that lacks human intuition. If a change doesn’t pass the automated gates, it effectively doesn’t exist. By treating the CI as a high-signal feedback loop, we remove the human bottleneck of manual verification and replace it with a reproducible gate. This absolute source of truth allows us to scale more responsibly — enabling agents to fail fast, iterate, and ultimately succeed without compromising the integrity of the project or the peace of mind of the team.

## The ask

A one-off prompting success is just a fluke. True scale comes from creating a flywheel: every time you or a teammate returns to the repository, the agent should be more capable than it was the last time because knowledge debt has been paid forward into a shared repository of prompts. You are building a shared institutional memory that isn’t trapped in a single developer’s head.

To make this repeatable for any developer on your team, you need a library of prompt instructions that acts as executable documentation. While many teams rush to create global “config” and “rules” files, I find these often lead to inconsistent results — an agent might “forget” a rule or misapply it to the wrong context. As scientifically minded engineers, we should prefer to remove variables. By controlling the exact prompting for a specific task, you ensure the agent has exactly what it needs for that particular task within your repository. Doing so in an intentional manner in a project is what helps both individuals and teams build genuine confidence in these new tools.

## Enter Agent Skills

In late 2025, Anthropic introduced *Agent Skills* — an open standard designed to provide AI agents with specialized, modular expertise. Rather than just generic tools, Skills package instructions and resources together to ensure complex tasks are performed consistently. This is moving fast; as of early 2026, many tools are already adding support for this standard to enable cross-platform portability.

* Flexibility: You can use Skills with many agents, including Antigravity, Cursor, Claude Code Gemini CLI and VS Code, because they are an [open standard](https://agentskills.io/home).

* Shared knowledge: Skills can be easily shared with collaborators, or saved into a user folder for use across projects.

* Repeatable workflows: Skills ensure that agents consistently perform complex, multi-step tasks by instructing them with clear procedural steps.

* Additional resources: Skills can include scripts, templates, or other data alongside instructions.

* Just-in-time access: When Skills are first loaded, only the metadata is loaded into the agent’s context. This means that the specific instructions are only added to the context when needed, which saves tokens.

* Maintain code quality: The construction of these can be used as a set of tools to help contributors have the right context to put together higher quality PRs, tests, and documentation following your best practices.

## Documentation for current major tools that support Skills

See documentation for your tool to see where to add these files.

* Antigravity — [https://antigravity.google/docs/skills](https://antigravity.google/docs/skills)

* Cursor — [https://cursor.com/docs/context/skills](https://cursor.com/docs/context/skills)

* Claude Code- [https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview)

* Gemini CLI — [https://geminicli.com/docs/cli/skills/](https://geminicli.com/docs/cli/skills/)

* VS Code — [https://code.visualstudio.com/docs/copilot/customization/agent-skills](https://code.visualstudio.com/docs/copilot/customization/agent-skills)

## The anatomy of an effective Skill

To ensure your Skills library remains a “Runbook for Robots” rather than just a list of suggestions, every prompt in this collection follows a strict set of best practices:

* Known good state: Before an agent touches a line of code, it must verify that the existing tests pass and the analyzer is clean. If the foundation is cracked, the agent fixes the foundation before building on top of it.

* Actionable verification: Anchor instructions in commands like `flutter test --coverage` or `dart fix --apply` to provide the agent with the deterministic feedback it needs to self-correct.

* Finite scoping: To ensure that the agent maintains high context and focus, prompts are designed with clear boundaries — targeting specific functions, files, or coverage gaps. This ensures that the agent remains focused on a single goal, preventing scope creep and ensuring the output is easy to review.

* The report & review loop: The agent’s job ends with a structured summary, not a commit. By requiring the agent to explain its changes and provide a suggested commit message without actually pushing code, we keep the human engineer in the role of the final decision maker.

## Example Skill: Prepare current work for PR

```markdown
---
name: pr-prep
description: Prepare current work for PR
---

## Prepare current work for PR: Verify Tests Passing and Cleanup

**Objective:** Verify the current test suite status with `flutter test`, clean up any temporary modifications, and harden test coverage for active files.

**Instructions:**
1.  **Baseline:**
    *   Run `dart fix --apply` to apply automated fixes.
    *   Run `flutter analyze` to ensure no analysis issues.
    *   Run `flutter test` to establish the current passing state.
    *   Run `flutter test integration_test/app_test.dart` to verify integration integrity.
2.  **Fix Failures:** If there are any test failures or analysis errors, investigate and resolve them. Prioritize fixing code over deleting tests.
3.  **Cleanup:** Review any currently modified files (run `git status` or check the diff). Remove any:
    *   `print` / `debugPrint` statements.
    *   Unused imports.
    *   Commented-out code blocks.
    *   Temporary "hack" fixes that should be replaced with proper solutions.
4.  **Verify & Expand:**
    *   For the files you touched or cleaned up, check if there are obvious edge cases missing from their unit tests. Add tests to cover these cases.
    *   Run `flutter analyze` again to ensure clean code.
    *   Run `flutter test` again to ensure cleanup didn't break anything.
    *   Repeat this step as necessary.
5.  **Report & Review:**
    *   Summarize the cleanup status (e.g., "Tests passing, removed 3 debug prints").
    *   **Action:** Ask the user to review the changes closely to ensure no intended code was accidentally removed.
    *   **Do not commit or push.**
    *   Provide a suggested Git commit message (e.g., "Prepare for PR: Fix tests and remove debug code").
```

## Example Skill: Single file test coverage

```markdown
---
name: single-file-test-coverage
description: Write a new test or modify an existing test
---

## Single File Test Coverage Improvement

**Objective:** Write a new single test file, or modify an existing file, to improve coverage for a specific target class.

**Instructions:**
1.  **Identify Target:** Choose a single source file (Dart) in `lib/` that has low or no test coverage and is suitable for unit testing (e.g., utility classes, logic helpers).
3.  **Establish Baseline:**
    *   Run `flutter analyze` to ensure validity.
    *   Run `flutter test` to ensure the project is stable.
    *   Run `flutter test --coverage` and check `coverage/lcov.info`.
4.  **Implement/Update Test:** Create a new test file in `test/` or update the existing one. Focus on:
    *   Edge cases (null inputs, empty strings, boundary values).
    *   Branch coverage (ensure if/else paths are exercised).
    *   Mocking dependencies where necessary (using `mockito` or `mocktail`).
5.  **Verify & Iterate:**
    *   Run the tests to ensure they pass.
    *   Run `flutter analyze` to ensure no regressions.
    *   If coverage is still low, **iterate a few times**: analyze missed lines/branches and add targeted test cases.
5.  **Report & Review:**
    *   Summarize what was fixed/covered and report coverage progress (e.g., `X% -> Y%` for `<filename>`).
    *   **Action:** Ask the user to review the new tests closely.
    *   **Do not commit or push.**
    *   Provide a suggested Git commit message (e.g., "Improve test coverage for [Class Name]").
```

## Example Skill: Migrate to modern Dart features

```markdown
---
name: migrate-to-modern-dart-features
description: Migrate to modern Dart features (Dart 3+)
---

## Migrate to Modern Dart Features

**Objective:** Optimize consistency and conciseness by migrating to modern Dart features (Dart 3+).

**Candidates for Migration:**
*   `if-else` chains -> `switch` expressions.
*   Data classes with manual `==`/`hashCode` -> `Records` or `equatable` (or class modifiers).
*   Null checks -> pattern matching.

**Instructions:**
1.  **Baseline:** Run `flutter test` and `flutter analyze`.
2.  **Select Target:** Identify a *single* migration opportunity.
3.  **Constraint:** Keep the change extremely small (**max 50 lines**).
4.  **Migrate:** Refactor to use the new feature.
5.  **Verify:**
    *   Run `flutter analyze`.
    *   Run `flutter test` to ensure no regressions.
6.  **Report & Review:**
    *   Summarize the migration.
    *   **Action:** Ask the user to review the changes closely.
    *   **Test Location:** Explicitly state where in the app the user should go to manually test the change (e.g., "Click the bottom button after the app opens").
    *   **Do not commit or push.**
    *   Provide a suggested Git commit message (e.g., "Refactor: Use switch expression in [Class Name]").
```

## In summary

The long game of the agentic era isn’t about the volume of code you produce today; it’s about responsibly architecting the infrastructure and cultural expectations for the repositories of tomorrow. By building the handle of the dumbbell, ensuring that as our tools move faster, they remain anchored to our shared values and technical rigor.

In the very near future, agents will move from reactive assistants to proactive contributors — checking in on your repository and resolving issues while you sleep. By hardening your high-signal feedback loops and documenting your workflows in a version-controlled suite of Skills, you are doing more than just saving time; you are training the agents of the future to respect your specific architecture, your vision, and your standards. Most importantly, you are ensuring that as the engine of development accelerates, your entire team has the digital sensors and shared knowledge to move forward with collective confidence and a stronger, more resilient engineering culture.
