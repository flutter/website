<IdeExplorer>

<IdeRoot label="Task" id="task">

<IdeFolder label="environment/" id="environment" subtitle="Containerized Flutter workspace pre-seeded for the agent">

The target codebase is an isolated, containerized Flutter workspace.

When a benchmark run starts, the evaluation harness boots an ephemeral
Docker container pre-seeded with this project. The agent is given access to
tools (such as reading files, editing code, and running terminal commands)
to investigate and resolve the issue.

The agent only sees the files inside this directory. Grading scripts and
reference solutions remain strictly isolated outside the container until
the agent completes its run.

<IdeFolder label="lib/" id="lib" subtitle="Application source code">

Contains the Flutter application source code.

In this evaluation task, the agent inspects `lib/main.dart` to locate the
source of the
`RenderFlex` layout errors and applies appropriate widget modifications.

<IdePage label="main.dart" id="main-dart" subtitle="Flutter app containing horizontal and vertical overflow bugs">

The starter code for the Flutter application. Alternatively, the docker
file may point to a remote codebase.

</IdePage>

</IdeFolder>

<IdeFolder label="test/" id="test" subtitle="Target directory for agent-authored widget tests">

The test directory for the target project.

Initially, this directory is empty. The task instruction directs the agent
to create `test/main_test.dart`
to verify its bug fix with automated widget tests.

<IdePage label="main_test.dart" id="main-test-dart" subtitle="Widget tests the agent must write to verify its fix">

The widget test file that the agent is expected to author.

</IdePage>

</IdeFolder>

<IdePage label="pubspec.yaml" id="pubspec" subtitle="Project manifest declaring Flutter and lint dependencies">

Declares dependencies and environment constraints for the Flutter project.

</IdePage>

<IdePage label="analysis_options.yaml" id="analysis-options" subtitle="Linter configuration enforcing const and style rules">

Defines the static analysis rules enforced across the project.

During grading,
`StaticAnalysisGrader` runs `flutter analyze` against the modified
codebase. Solutions that introduce analyzer errors, warnings, or lint
violations
(such as missing `const` constructors) lose quality points.

```yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
  # Strict lints for this task
```

</IdePage>

<IdePage label="Dockerfile" id="dockerfile" subtitle="Container setup, SDK caching, and baseline commit">

Defines the container image for the task environment.

**Workflow**

1. Inherits from the pre-warmed `flutter-linux:latest` base image, which
   contains the Flutter and Dart SDKs.
2. Copies project manifests and initial source files into `/workspace`.
3. Runs `flutter pub get` so dependencies are pre-fetched.
4. Executes `init-baseline` to snapshot the clean repository state. This
   allows the evaluation harness to measure the agent's work as a precise
   Git diff against the starting baseline.

</IdePage>

</IdeFolder>

<IdeFolder label="tests/" id="tests" badge="hidden from agent" badge-color="warning" subtitle="Multi-dimensional evaluation harness hidden from the agent">

The automated verification harness used to grade the agent's performance.

This entire directory is hidden from the agent during task execution. It is
mounted into the evaluation container only when the grading phase starts.

The harness evaluates the agent's output across three weighted dimensions:

- **Outcome**: Functional correctness, test pass rates, and layout fixes.
- **Quality**: Static analysis, formatting, and code craftsmanship.
- **DX**: Developer experience and tool interaction efficiency.

<IdePage label="graders.dart" id="graders-dart" subtitle="Outcome, quality, and craftsmanship scoring rules via eval_scoring">

Defines the multi-dimensional scoring pipeline using a separate scoring package.

```dart
// Heavily edited
AggregateGrader grader(context) =>
    AggregateGrader.result(
      outcome: _outcomeGraders,
      quality: _qualityGraders,
      dx: _dxGraders,
    );
```

</IdePage>

<IdePage label="test.sh" id="test-sh" subtitle="Verification entry point running the eval_scoring suite">

The test harness entrypoint script executed inside the grading container.

```bash
#!/bin/bash
eval_scoring run [tasks]
```

</IdePage>

</IdeFolder>

<IdeFolder label="solution/" id="solution" subtitle="Oracle reference solution used to validate the eval task">

Contains the ground truth reference implementation maintained by the
benchmark authors.

Before a task is added to the benchmark suite, the reference solution is
executed through the grading harness to confirm that it achieves a full
`1.0` reward. This ensures the task is solvable, unambiguous, and
calibrated correctly.

<IdePage label="solve.sh" id="solve-sh" subtitle="Reference script fixing layout bugs and adding layout tests">

The reference shell script that applies the canonical fix and generates
comprehensive tests. Not safe to share publicly.

</IdePage>

</IdeFolder>

<IdePage label="instruction.md" id="instruction" is-default-page="true" badge="input" badge-color="tip" subtitle="The prompt the agent receives">

The instruction is the task prompt provided to the agent. It mimics
real-world workflows from developers, and is written in a way that real
developers interact with agents.

**Design principles**

- Prompts state symptoms and expected outcomes without naming exact 
  remedy widgets.
- Prompts require the agent to write regression tests, measuring both
  implementation skills and testing rigor.

```markdown
We currently keep receiving `RenderFlex overflowed` errors both
horizontally and vertically. Implement the correct widgets to resolve these
layout issues.

Write widget tests in
`test/main_test.dart` that verifies the changes.
```

</IdePage>

<IdePage label="task.toml" id="task-toml" subtitle="Task definition, difficulty notes, and timeouts">

The task configuration file specifies execution bounds, metadata, and
target artifacts evaluated during grading.

**Key sections**

- `artifacts`: Lists files that must be present in the workspace after the
  run.
- `task` definition: Task-related data, like name, author and tags. 
-  infra and agent configurations, such as timeout limits and retries.

</IdePage>

</IdeRoot>

</IdeExplorer>
