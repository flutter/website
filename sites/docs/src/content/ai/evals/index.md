---
title: FlutterBench
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

## Methodology

The FlutterBench eval system consists of four core concepts:

1. **Dataset**: A collection of real-world development tasks
   derived from critical user journeys.
1. **Test matrix**: A multidimensional testing framework across models,
   agents, tooling configurations, and SDK versions.
1. **Scoring system**: A comprehensive grading approach that evaluates
   both functional outcomes and developer experience.
1. **Harness**: The automation infrastructure that runs evaluations at scale.

## Dataset

Evaluation tasks derive directly from Flutter's canonical
[**Critical User Journeys (CUJs)**][], which are the
core workflows that developers perform regularly.
This approach ensures evaluations reflect real-world developer needs.

Each CUJ represents a combination of:

* A Flutter developer persona (such as app developer, plugin developer,
  or full-stack developer)
* A high-level goal
* The specific tasks required to achieve that goal

One or more CUJ's are converted into a single task's prompt. We can't open-source the full tasks without contaminating the evals, but you can see our [canonical list of CUJs][] to get an idea of what tasks we're testing with FlutterBench, and an example of how we convert a CUJ to a task below. 

### Task structure

These CUJs are converted into into [Harbor](https://harborframework.com/) tasks.
Harbor is the framework used to run the tasks (described in more detail
later on this page).

Each task contains:

* **Instruction**: A realistic prompt written the way developers talk
  to agents (typically 1–2 sentences, behavior-focused rather than
  prescriptive).
* **Target codebase and environment**: A containerized environment that can be
  preseeded with a Flutter or Dart project.
  +
  Some more ambitious evals start from scratch, while other tasks start from existing codebases and add features, fix bugs or refactor code. These codebases are large projects, but are not known open-source apps to avoid contaminating the evaluation process.
* **Verification criteria**: Automated tests and scoring guidelines,
  discussed in depth later on this page.
* **Metadata**: Each task has a related metadata file that allows us to customize the task to test with different inputs and slice the output data. Metadata includes things like associated CUJ id, task type, priority tier, and expected tool, skill and sub-agent usage.

### Converting a CUJ

This is an example of how we convert a CUJ to a task taken from our dataset. Generally, we're targeting more complex tasks that often combine several CUJs into one task, but for brevity this is a one-to-one example.

:::note
All following examples are copied exactly as of writing this page, but will not be updated as our dataset evolves.
:::

Given this CUJ:

```yaml
  goal: Implement a consistent visual design theme and styling across an application
  name: theme-from-design-file
  persona: The App Developer
  tasks:
    - id: 48
      name: create-theme-data-from-design-document
      task: Implement application ThemeData configurations derived from specifications
        in a design document.
    - id: 49
      name: add-dark-mode-support
      task: Implement dark mode theming and color scheme switching.
    - id: 50
      name: change-dropdown-popup-buttons-styling
      task: Customize visual styling for dropdown menus, popup dialogs, and interactive
        buttons by extending central ThemeData configurations.
```

The resulting Harbor task looks like this:


Create a Material theme data in `./lib` folder in a file called 
`theme.dart` from the `DESIGN.md` file. It should export at least
a `lightTheme` and `darkTheme`.


### Task categories

Tasks are categorized by the type of agent capability they test.
A task can belong to multiple categories, particularly hill-climbing tasks.

* **Greenfield generation**: Creating new features or applications
  from scratch.
* **Hill climbing**: Iterative debugging and problem-solving across multiple
  turns.
* **Refactoring**: Restructuring existing code while maintaining
  functionality.
* **Migration**: Upgrading deprecated APIs or moving between architectural
  patterns.
* **Integration**: Adding platform-specific features or third-party packages.

### Task prioritization

Tasks are prioritized based on impact and frequency:

| Priority | Description |
| :--- | :--- |
| **P0** | Critical production workflows and high-frequency productivity tasks |
| **P1** | Core functionality and API consistency verification |
| **P2** | Standard features and application maturity tasks |
| **P3** | Edge cases and cosmetic polish |

### Quality assurance

Before a task graduates into the core benchmark suite,
it undergoes an engineering audit.
Human reviewers inspect initial trial runs and label results as:

* **True positive**: Agent correctly passed
* **True negative**: Agent correctly failed
* **False positive**: Agent passed incorrectly
* **False negative**: Agent failed incorrectly

This process ensures that the dataset produces reliable,
actionable signals rather than noise.

## Test matrix

To draw statistically sound conclusions,
FlutterBench evaluates tasks across a 4-axis matrix:

### 1. Tooling configuration

FlutterBench tests three configurations to measure the impact of
Dart and Flutter AI tools:

| Configuration | Description |
| :--- | :--- |
| **Baseline** | No specialized Dart/Flutter tools—tests raw model capability |
| **Enhanced** | Full suite of Dart/Flutter skills and MCP server tools |
| **Enhanced Minus N** | Full suite except for one specific tool or group—used to measure individual tool impact |

This A/B testing approach helps answer questions such as:
"Does adding the Flutter widget tree skill improve success rates?
By how much? Does the improvement vary by model?"

### 2. Model selection

Testing covers major frontier models based on developer usage data,
including:

* **Gemini**
* **Claude**
* **ChatGPT**

Additional providers will be added based on community feedback.

### 3. Agent harnesses

Different agents use different system prompts and tool-loading strategies.
Evaluations run against the agents Flutter developers use most:

* **Claude Code**
* **Antigravity CLI**

This helps measure how the same model performs across different agent
environments.

### 4. SDK branch

Evaluations run against both channels:

* **Stable**: The current production SDK.
* **Beta**: Monthly beta releases, which helps catch regressions before
  they reach the stable channel.

## Scoring system

The scoring methodology balances functional capability with process
and efficiency telemetry.

### Design philosophy

Because the Flutter team focuses on building the tooling, documentation,
and SDKs that agents consume rather than the models or agents themselves,
scoring reflects this focus:

* **Primary focus**: The quality of the final code artifact
* **Secondary signals**: Developer experience and resource efficiency

If an agent produces idiomatic Flutter code that passes all tests,
the evaluation passes—even if it took an unconventional path.
However, the system tracks process and efficiency metrics as diagnostic
signals to improve tooling.

### Three-score architecture

Each evaluation produces three independent scores (0.0 to 1.0):

#### 1. Result score (primary metric)

The result score determines pass/fail status and is calculated as
a weighted average of:

* **Outcome**: Does the code functionally work?
* **Quality**: Is it maintainable and idiomatic?
* **Developer experience**: Was the agent frustrating to work with?

**Outcome graders:**

* **Build and run**: Binary pass/fail—does the code compile and run?
* **Testing**: Ratio of passing tests to total affected tests across unit,
  widget, integration, and golden tests.
* **Visual validation**: LLM-as-a-judge comparison of before and after
  screenshots for UI tasks.
* **Heuristics**: Task-specific checks (such as verifying that the correct
  dependency was added or that a test file was edited).

**Quality graders:**

* **Static analysis**: `dart analyze` with strict lints.
* **DCM (Dart Code Metrics)**: Advanced linting for architectural issues,
  dead code, memory leaks, and complexity.
* **Structural validation**: Correct project structure, naming conventions,
  and required files.
* **Idiomatic review**: LLM-as-a-judge evaluating modern Dart usage
  (such as records and patterns) and adherence to Effective Dart.
* **Heuristics**: Task-specific checks such as preferred package usage
  and new language feature adoption.

**Developer experience graders:**

* **Tool usage**: Did the agent call expected tools? Did tool calls fail?
* **Trajectory**: LLM-as-a-judge analyzing execution logs for retries,
  hallucinated commands, and human-in-the-loop (HITL) compliance.
* **Error recovery**: How well did the agent navigate and learn from errors?

#### 2. Process score (diagnostic)

This score tracks agent behavior to identify tooling improvement
opportunities. It evaluates:

* Tool usage patterns and discoverability
* Reasoning trace quality and plan adherence
* Error recovery strategies
* Accurate reporting (does the agent's summary match reality?)

Process scores help triage failures to determine whether an agent failed
because tool definitions are unclear, documentation is missing,
or the model fundamentally misunderstood the task.

#### 3. Efficiency score (diagnostic)

This score measures resource consumption:

* **Token usage**: Compares actual token consumption against task-specific
  baselines.
* **Step efficiency**: LLM-as-a-judge detecting redundant steps,
  unnecessary tool calls, or loops.

Efficiency data helps developers make informed trade-offs.
An agent using 2× the tokens but producing correct code on the first try
can be preferable to one using half the tokens but requiring manual
intervention.

### Score interpretation

| Result score | Classification | Criteria |
| :--- | :--- | :--- |
| **1.00** | Perfect success | Code compiles, runs, and passes all tests. Clean static analysis. Highly idiomatic. Perfect developer experience. |
| **0.75–0.99** | Functional with minor flaws | Code works and tests pass. Minor lint warnings or slightly unidiomatic patterns. Minor developer experience friction. |
| **0.50–0.74** | Partial success | Core features work, but some tests fail or minor compilation issues exist. Or working code with significant lints or low developer experience. |
| **0.25–0.49** | Poor implementation | Significant errors. Fails to compile, ignores constraints, or catastrophic developer experience friction. |
| **0.00** | Total failure | No working code or agent stuck in an infinite loop. |

### Grader implementation

Evaluations use three types of graders:

**Code-based graders** provide deterministic, objective verification:

* Compilers, test runners, linters, and formatters.
* Fast and unambiguous source of truth.

**LLM-as-a-judge graders** handle qualitative evaluation:

* Idiomatic style review, plan adherence, and trajectory analysis.
* Follow strict rubrics using a "BINEVAL" approach (decomposing criteria
  into binary yes/no questions).
* Nondeterministic but necessary for nuanced assessment.

**Human graders** serve as the ultimate authority:

* Calibrate automated graders on initial runs.
* Perform root-cause analysis on failures.
* Resolve disagreements between automated graders.

### Combining scores for analysis

Isolating the result score from process and efficiency scores allows for
systematic triage of issues:

* **High result + low process**: The agent succeeded through an unexpected
  path, highlighting an optimization opportunity.
* **Low result + high process**: The agent used tools correctly but failed,
  signaling tooling or documentation issues.
* **Low result + low process**: Model disorientation, which indicates a need
  for improved prompt engineering.
* **High result + low efficiency**: The agent solved the problem but consumed
  excessive resources; consider specialized skills.
* **Low result + high efficiency**: The agent failed quickly, which suggests
  a need for better constraints or tool schemas.

## Data analysis

Evaluation results are analyzed across all four matrix dimensions
to answer specific questions:

* Does adding a new Flutter skill improve result scores across multiple models?
* Do improvements hold steady when testing with different agents?
* Are there SDK changes in beta that break agent workflows before reaching
  stable?
* Which tasks have consistently low scores, indicating knowledge gaps?

This multidimensional analysis drives decisions about where to invest
in tooling, documentation, and SDK improvements.

## Transparency and iteration

To prevent model training contamination, raw datasets and reference solutions
remain private. However, the Flutter team maintains transparency by:

* Publishing the comprehensive evaluation methodology on this page.
* Sharing task prompts and CUJ lists.
* Publishing regular blog posts with analysis and insights.
* Open-sourcing verification tooling that does not risk dataset compromise.

This methodology will evolve as more data is gathered and analyzed.
Expect updates and refinements in future blog posts and documentation.

[**Critical User Journeys (CUJs)**]: /ai/evals/cujs
[canonical list of CUJs]: /ai/evals/cujs