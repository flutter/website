---
title: AI Evaluations
sidenav: ai
description: >
  Learn about Dart and Flutter's evaluation frameworks for measuring AI tooling
  reliability.
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
