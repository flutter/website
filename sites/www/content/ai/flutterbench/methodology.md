---
title: FlutterBench Methodology
bodyTags: interior flutterbench methodology
description: Detailed explanation of the FlutterBench harness, three-dimensional scoring rubric, and reproduction steps.
publishDate: "2026-09-10"
---

# FlutterBench Methodology

FlutterBench is Flutter's dedicated evaluation harness for measuring how autonomous AI coding agents perform on real-world Dart and Flutter development tasks.

Unlike general code benchmarks that rely on isolated algorithm puzzles or synthetic docstring completions, FlutterBench tests agents against authentic developer workflows grounded in Flutter's canonical **Critical User Journeys (CUJs)**.

---

## Core Principles

1. **Realistic Tasks over Synthetic Puzzles**: Every task tests a real feature implementation, bug fix, or refactoring in a realistic Flutter or Dart codebase.
2. **Developer Experience (DX) is a First-Class Signal**: We measure not just whether the final code compiles, but tool accuracy, trajectory efficiency, and recovery from errors.
3. **Containerized Sandboxing**: All trials run inside isolated Docker containers with pre-installed Flutter SDKs and the official Dart MCP server.
4. **Weighted Multi-Dimensional Scoring**: A composite reward evaluates outcome, quality, and developer experience, while capturing diagnostic telemetry separately.

---

## Three-Dimensional Scoring Rubric

Each trial produces a normalized composite reward between `0.0` and `1.0`:

$$\text{Reward} = 0.60 \times \text{Outcome} + 0.30 \times \text{Quality} + 0.10 \times \text{DX}$$

| Dimension | Weight | Description | Evaluation Mechanism |
| :--- | :--- | :--- | :--- |
| **Outcome** | 60% | Functional correctness and feature completion | `flutter test`, `flutter build bundle`, heuristic event assertion |
| **Quality** | 30% | Architectural conventions, idiomatic code, maintainability | `dart analyze`, DCM, LLM judge rubrics |
| **DX (Developer Experience)** | 10% | Tool interaction accuracy, minimal thrash, clean trajectory | Dart MCP telemetry, plan adherence, error loops |

### Diagnostic Telemetry (Unscored)

Separate telemetry blocks track **Process** and **Efficiency**:
- **Process**: Number of prompt turns, reasoning quality, and recovery velocity.
- **Efficiency**: Token usage (input, cache, and output tokens) and wall-clock execution time.

These diagnostic metrics are reported alongside trials for observability, but are strictly excluded from the composite reward.

---

## Task Anatomy

Each FlutterBench task directory contains:
- **Instruction**: Natural developer prompt describing the target user journey.
- **Codebase**: Seed workspace repository containing initial project structure and dependencies.
- **Graders**: Verification scripts (`tests/graders.dart`, unit test suites, static analysis checks).
- **Environment**: Docker container specification defining SDK constraints and tool permissions.

---

## Trial Execution Phases

Each trial proceeds through four distinct, timed phases:

1. **Environment Setup**: Container initialization, caching, and volume mounts.
2. **Agent Setup**: Workspace cloning, dependency resolution, and MCP tool initialization.
3. **Agent Execution**: Autonomous problem-solving, code generation, and iterative refinement.
4. **Verifier**: Automated test execution, static analysis grading, and LLM rubric evaluation.

---

## Reproducing Results

To reproduce benchmark trials locally using the Harbor evaluation runner:

```bash
# Clone the evaluation task repository
git clone https://github.com/flutter/evals.git
cd evals

# Run an individual trial
harbor run \
  --task dataset/flutter/manage-state-with-bloc \
  --agent antigravity-sdk \
  --model google/gemini-3.5-flash \
  --mcp dart
```

For questions or to contribute new CUJ evaluation tasks, visit the [Flutter repository on GitHub](https://github.com/flutter/flutter).
