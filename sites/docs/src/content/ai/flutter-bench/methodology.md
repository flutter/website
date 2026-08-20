---
title: FlutterBench methodology
layout: story
showToc: false
description: >
  Learn about Dart and Flutter's evaluation frameworks for
  measuring AI tooling reliability.
---

<!-- TODO: maybe remove, but KEEP AS COMKMENT FOR NOW -->
<div class="methodology-hero">
  <div class="hero-badge">
    <span class="material-symbols">verified</span>
    <span>Primary Metric Architecture</span>
  </div>
  <h3 class="hero-title">The Result Score</h3>
  <p>
    Each task run produces a composite <code>reward.json</code> score on a
    <strong>0.0 to 1.0 scale</strong>, synthesizing deterministic code
    correctness, maintainability, and developer experience.
  </p>
</div>

## Methodology overview

FlutterBench is our evaluation framework designed to measure how AI coding
agents perform within the Dart and Flutter ecosystem.

The evaluation system consists of four core components:

| Component | Description |
|:---|:---|
| **Dataset** | Real-world development tasks derived from critical user journeys (CUJs). |
| **Test matrix** | Multidimensional testing framework across models, agents, tooling configurations, and SDK versions. |
| **Scoring system** | Unified grading approach evaluating functional outcomes, code quality, and developer experience, paired with diagnostic telemetry. |
| **Harness** | Containerized automation infrastructure that executes evaluations at scale. |

## Dataset & tasks

### Task derivation

Evaluation tasks derive directly from Flutter's canonical
[**Critical User Journeys (CUJs)**][], which are the core workflows that
developers perform regularly. This approach ensures evaluations reflect
real-world developer needs rather than synthetic puzzles.

Each CUJ represents a combination of:
* A Flutter developer persona (e.g., app developer, plugin developer,
  full-stack developer)
* A high-level goal
* The specific sequential steps required to achieve that goal

:::note
We can't open-source the full evaluation tasks without contaminating the
benchmark dataset, but we publish our [canonical list of CUJs][]. With
this list, along with the example task below, you can understand our
evaluation philosophy for FlutterBench.
:::

These CUJs are converted into [Harbor](https://harborframework.com/)
tasks. Harbor is the framework used to run containerized evaluation tasks.

CUJs and Harbor tasks don't map cleanly one-to-one. Instead, the CUJ list
serves as a guide to verify that core developer workflows are evaluated.
In some cases, several CUJs combine into a single task, and vice-versa.
Our most ambitious evaluations combine multiple Harbor tasks, and thus
cover many CUJs.

### Task specifications

<TaskSpecifications />

### Interactive task anatomy

Each task contains an instruction, a target codebase and environment,
verification criteria, and metadata. Using the CUJ example above,
a corresponding Harbor task looks like this:

{% render "docs/ai/flutter_bench_task_explorer.md" %}

## Evaluation test matrix

<EvaluationMatrixTabs />

## Scoring architecture

### Scoring philosophy

When evaluating AI coding agents, execution friction—such as tool failures,
endless retries, and hallucinations—is often attributed entirely to model
capability. However, AI coding systems follow a core equation:

$$\text{Agent} = \text{Model} + \text{Harness}$$

While the Dart and Flutter teams do not train the underlying LLMs, we build
and maintain the **Dart and Flutter AI Harness** (skills, MCP tools,
compiler diagnostics, and sandboxes).

Therefore, **Developer Experience (DX)** is directly within our engineering
control and belongs in our primary benchmark score alongside functional
outcomes and code quality:

* **Primary focus**: The quality and correctness of the final code artifact.
* **First-class signal**: Developer experience friction, tool accuracy, and
  recovery efficiency.

### Three core evaluation dimensions

Each evaluation produces three independent dimensions that compute the
composite Result Score in Harbor's `reward.json`:

<ThreeDimensionsCards />

### Grader matrix

FlutterBench deploys a mix of deterministic, LLM-as-a-judge, and
heuristic graders across all three dimensions:

<GraderMatrix />

### Grader implementation tiers

Evaluations use three types of graders:

| Tier | Grader type | Evaluation role |
|:---|:---|:---|
| **Code-based** | Compilers, test runners, `dart analyze`, DCM, and structural checkers | Deterministic, unambiguous source of truth for syntax and correctness. |
| **LLM judge (BINEVAL)** | Frontier model rubric evaluation | Evaluates qualitative dimensions (visual UI, idiomatic review, trajectory, recovery) using binary yes/no questions. |
| **Human audit** | Flutter engineer manual review | Ground truth calibration, failure root-cause analysis, and conflict resolution. |

### Diagnostic telemetry (excluded from Result Score)

To avoid penalizing capability scores on complex tasks that require more
reasoning steps or tokens, FlutterBench tracks diagnostic telemetry separately
from the Result Score:

| Metric | Measurement target |
|:---|:---|
| **Token usage** | Tracks total input and output tokens consumed to measure efficiency deltas and verify token reductions from skill optimizations. |
| **Expected tool calls** | Compares actual tool invocations against expected tools. If an agent succeeds without using an expected tool, it is not penalized; this telemetry helps evaluate whether the tool is necessary for that user journey. |

## Reliability & triage

### Multi-run reliability metrics

Single-run trials only sample luck. True agent trust requires measuring
multi-trial stability across repeated runs:

<ReliabilityCards />

### Score interpretation & triage

Click a score tier to view its grading criteria and actionable engineering
triage steps:

<ScoreTriage />

#### Human root-cause audits

When an evaluation task receives a low Result Score, human expert reviewers
inspect the diagnostic process data:

* **Reasoning trace review**: Inspect the agent's internal thoughts to identify
  where misunderstandings of Dart/Flutter APIs occurred.
* **Plan adherence audit**: Check whether the agent derailed due to ambiguous
  task prompts or missing context.
* **Harness diagnostics**: Audit error messages returned to the agent during
  failed compile/test steps to see why recovery failed.

## Transparency & dataset integrity

To prevent model training contamination, raw datasets and reference
solutions cannot be open-sourced. However, the Flutter team maintains
transparency by:

* Publishing the comprehensive evaluation methodology on this page.
* Sharing task prompts and [CUJ][] lists.
* Publishing regular blog posts with analysis and insights.
* Open-sourcing verification tooling that does not risk dataset compromise.

This methodology will evolve as more data is gathered and analyzed. Expect
updates and refinements in future blog posts and documentation.

[**Critical User Journeys (CUJs)**]: /ai/flutter-bench/cujs
[CUJ]: /ai/flutter-bench/cujs

[canonical list of CUJs]: /ai/flutter-bench/cujs
