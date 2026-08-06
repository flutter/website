---
title: AI evaluations
sidenav: ai
description: >
  Learn about Dart and Flutter's evaluation frameworks for
  measuring AI tooling reliability.
---

:::experimental
Evaluation tooling and benchmarks are experimental and likely to change.
:::

To explore the evaluation strategy,
view the open-source dataset and scoring rubrics,
or get involved with community benchmark datasets,
visit the [Flutter Evals repository](https://github.com/flutter/evals).

Evaluating the capabilities and reliability of AI agents requires testing
approaches that model actual developer tasks.
Because LLMs are non-deterministic,
standard unit testing is insufficient for verifying agentic behaviors like
codebase navigation, plan execution, and code synthesis.

To build developer confidence in AI tooling,
Dart and Flutter use an evaluation system ("evals")
to test critical user journeys (CUJs).
Evals measure both deterministic code correctness
(compilation, lints, automated tests) and qualitative performance
(reasoning, safety, and conciseness) using automated model judges
and expert human grading.

INSERT DATA HERE !

## Methodology

## Dataset

The Flutter and Dart evaluation dataset is based on our canonical list of CUJS. A CUJ is a critical user journey. We took the CUJ, and we turned it into a task. A task has the following info:

1. task
2. some other thing
3. some other thing

The tasks themselves are private, because we don't want the model to "cheat on the test". But you can
see the CUJs that we wrote tasks for on the [Critical User Journeys (CUJs)](/resources/cujs) page.

Here's one example of CUJ => task:

CUJ: "A cuj" 
Task: "A task from CUJ"

