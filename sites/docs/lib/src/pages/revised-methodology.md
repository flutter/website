# Methodology

`FlutterBench is our evaluation framework designed to measure how AI coding agents perform within the Dart and Flutter ecosystem.`

`Our evaluation system consists of four core components:`

1. **`Dataset`**`: A collection of real-world development tasks derived from critical user journeys (CUJs).`  
2. **`Test matrix`**`: A multi-dimensional testing framework across models, agents, tooling configurations, and SDK versions.`  
3. **`Scoring system`**`: A unified grading approach that evaluates functional outcomes, code quality, and developer experience, paired with diagnostic telemetry.`  
4. **`Harness`**`: The automation infrastructure that runs evaluations at scale.`

# Dataset

## **Task design philosophy**

`We derive our evaluation tasks directly from Flutter's canonical Critical User Journeys (CUJs)—the core workflows that developers perform regularly. This approach ensures our evaluations reflect real-world developer needs rather than synthetic puzzles.`

`Each CUJ represents a combination of:`

* `A Flutter developer persona (e.g., app developer, plugin developer, full-stack developer)`  
* `A high-level goal`  
* `The specific sequential steps required to achieve that goal`

## **Task structure**

`We format our CUJs into Harbor tasks. Each task lives in its own directory and contains:`

* **`Instruction`**`: A realistic prompt written the way developers actually talk to agents (typically 1–2 sentences, behavior-focused rather than prescriptive).`  
* **`Target codebase and environment`**`: A containerized Docker environment preseeded with a Dart or Flutter codebase. Tasks test both greenfield creation from scratch and existing codebases with reintroduced bugs or technical debt.`  
* **`Verification criteria`**`: Verification scripts (tests/graders.dart and test.sh) executing our custom Dart evaluation package (package:eval_scoring).`  
* **`Configuration and metadata`**`: The task.toml configuration defining associated CUJs, priority tiers, expected skills, and MCP tools.`

## **Task categories**

`We categorize tasks by the primary agent capability being evaluated:`

* **`Greenfield generation`**`: Creating new features or applications from scratch.`  
* **`Hill climbing`**`: Iterative debugging, test repair, and multi-turn problem-solving.`  
* **`Refactoring`**`: Restructuring existing code while preserving functionality.`  
* **`Migration`**`: Upgrading deprecated APIs or transitioning between architectural patterns.`  
* **`Integration`**`: Adding platform-specific features, native plugins, or third-party packages.`

## **Task tiers and prioritization**

`To balance comprehensive coverage with evaluation speed, tasks are organized into tiers and priorities:`

### **`Execution tiers`**

* **`Tier 1`**`: Core benchmark tasks executed monthly across the complete evaluation matrix.`  
* **`Tier 2`**`: Maturing tasks slated to graduate into Tier 1 once calibrated.`  
* **`Tier 3`**`: Experimental tasks used for ad-hoc investigations and targeted questions.`

### **`Task priority`**

| `Priority` | `Description` |
| :---- | :---- |
| **`P0`** | `Critical production workflows and high-frequency productivity tasks` |
| **`P1`** | `Core functionality and API consistency verification` |
| **`P2`** | `Standard features and application maturity tasks` |
| **`P3`** | `Edge cases and cosmetic polish` |

## **Quality assurance**

`Before a task graduates into our core benchmark suite, it undergoes an engineering audit. Human reviewers inspect trial runs and classify outcomes into four categories:`

* **`True positive`**`: Agent correctly passed.`  
* **`True negative`**`: Agent correctly failed.`  
* **`False positive`**`: Agent passed incorrectly (grader was too lenient).`  
* **`False negative`**`: Agent failed incorrectly (grader penalized valid code).`

`This audit process ensures our dataset produces reliable, actionable signals rather than noise.`

# Test matrix

`To draw statistically sound conclusions, we evaluate tasks across a 4-axis matrix:`

## **1\. Tooling configuration**

`We test three configurations to isolate the exact impact of Dart and Flutter AI tooling:`

| `Configuration` | `Description` |
| :---- | :---- |
| `Baseline` | `No specialized Dart/Flutter tools—tests raw model capability` |
| `Enhanced` | `Full suite of Dart/Flutter skills and MCP server tools loaded` |
| `Enhanced Minus N` | `Full suite with a specific tool or skill group ablated to measure its isolated delta` |

`This A/B testing approach lets us measure whether adding a specific skill or MCP server improves task success rates and token economy.`

## **2\. Model selection**

`We evaluate major frontier model families across both high-capability and low-latency tiers:`

* **`Gemini`** `(Pro and Flash)`  
* **`Claude`** `(Opus and Sonnet)`  
* **`ChatGPT`** `(GPT-4o series)`

## **3\. Agent harnesses**

`Different agent harnesses use distinct system prompts, context management techniques, and tool-invocation strategies. We test across the CLI agents Flutter developers use most:`

* **`Antigravity CLI`**  
* **`Claude Code`**

`This ensures we understand how a model's performance varies when hosted in different agent runtime environments.`

## **4\. SDK branch**

`We run evaluations against both:`

* **`Stable`**`: The current production SDK release.`  
* **`Beta`**`: Monthly beta releases, allowing us to catch AI tooling regressions or breaking SDK changes before they reach stable.`

# Scoring system

`Our scoring methodology evaluates functional task completion while capturing developer experience and telemetry.`

## **Design philosophy**

`When evaluating AI coding agents, execution friction—such as tool failures, endless retries, and hallucinations—is often attributed entirely to model capability. However, AI coding systems follow a core equation: Agent = Model + Harness`

`While the Dart and Flutter teams do not train the underlying LLMs, we build and own several parts of an agent harness. Dart and Flutter AI Harness (our skills, MCP tools, compiler diagnostics, and sandboxes). Therefore, Developer Experience (DX) is directly within our engineering control and belongs in our primary benchmark score.`

## **The Result Score (primary benchmark metric)**

`Each task run produces a single Result Score on a 0.0 to 1.0 scale, output to Harbor's reward.json to determine pass or fail. The Result Score is a weighted composite across three core dimensions:`

1. **`Outcome`**`: Does the generated code solve the functional requirements of the task?`  
2. **`Quality`**`: Is the code maintainable, clean, and idiomatic Dart?`  
3. **`Developer Experience (DX)`**`: Was the agent smooth to work with, or did it encounter severe friction, broken tool calls, or recovery loops?`

### **`Outcome graders`**

* **`Build & Run (Deterministic)`**`: Binary pass/fail. Does the code compile and launch without errors?`  
* **`Testing (Deterministic)`**`: Executes unit, widget, integration, and golden tests, scoring the ratio of passing tests to total affected tests.`  
* **`Visual validation (LLM-as-a-judge)`**`: Compares before-and-after screenshots captured from Flutter DevTools service extensions to verify functional UI correctness.`  
* **`Heuristics (Deterministic)`**`: Programmatic micro-checks (e.g., verifying a required dependency was added or specific test files were edited).`

### **`Quality graders`**

* **`Static analysis (Deterministic)`**`: Runs dart analyze enforcing strict analysis_options.yaml lints.`  
* **`DCM - Dart Code Metrics (Deterministic)`**`: Runs a curated suite of DCM checks targeting architectural health: dead code, duplicate code, widget complexity, undisposed controllers, and memory leaks.`  
* **`Structural validation (Deterministic)`**`: Verifies file existence (pubspec.yaml), directory structure, and naming conventions.`  
* **`Idiomatic review (LLM-as-a-judge)`**`: Evaluates modern Dart 3 features (records, patterns) and adherence to Effective Dart guidelines.`  
* **`Heuristics (Deterministic)`**`: Verifies quality best practices (e.g., using recommended packages).`

### **`Developer Experience (DX) graders`**

* **`Tool usage (Deterministic)`**`: Analyzes execution logs to detect incorrect tool selections and failed tool invocations with invalid arguments.`  
* **`Trajectory (LLM-as-a-judge)`**`: Analyzes execution logs to verify human-in-the-loop (HITL) compliance, measure retry frequencies, and check step efficiency (detecting redundant steps or infinite loops).`  
* **`Error recovery (LLM-as-a-judge)`**`: Evaluates how effectively the agent interpreted and adapted to compiler, analysis, and test errors.`

## **Grader implementation and BINEVAL**

`We use three types of graders:`

* **`Code-based deterministic graders`**`: Compilers, test runners, dart analyze, DCM, and structural checkers. They serve as the fast, objective source of truth.`  
* **`LLM-as-a-judge graders with BINEVAL`**`: For qualitative dimensions (visual validation, idiomatic review, trajectory, and error recovery), we use frontier LLMs as judges. To ensure consistency and avoid subjective scoring drift, our LLM judges use a BINEVAL (binary evaluation) methodology. Qualitative criteria are decomposed into a structured rubric of concrete yes/no questions, aggregating the binary results into a calibrated score.`  
* **`Human graders`**`: Expert engineers review baseline datasets, calibrate LLM judges, and conduct deep root-cause audits on failures.`

## **Diagnostic telemetry (excluded from Result Score)**

`To avoid penalizing capability scores on complex tasks that require more reasoning steps or tokens, we track diagnostic telemetry separately from the Result Score:`

* **`Token usage`**`: Tracks total input and output tokens consumed. Used in side-by-side comparisons to measure efficiency deltas and verify token reductions from skill optimizations.`  
* **`Expected tool calls`**`: Compares actual tool invocations against expected tools. If an agent succeeds without using an expected tool, it is not penalized; this telemetry helps us evaluate whether the tool is necessary for that user journey.`

## **Multi-run reliability: Capability vs. Consistency**

`Evaluating an agent on a single trial only measures a single sample. True reliability requires evaluating tasks across multiple runs ($k$ attempts):`

* **`Capability (pass@k$)`**`: The probability that an agent succeeds at least once in $k$ attempts. This measures the agent's maximum capability ceiling.`  
* **`Consistency (pass^k$)`**`: The probability that an agent succeeds every single time across all $k$ attempts.`

**`Consistency (pass^k$) is our North Star for developer trust`**`. An agent that solves a task once out of five attempts may demonstrate capability, but its unreliability creates friction for developers. We optimize for predictable, repeatable success.`

## **Score interpretation and engineering triage**

`We interpret Result Scores using the following classifications:`

| `Result Score` | `Classification` | `Criteria` |
| :---- | :---- | :---- |
| **`1.00`** | `Perfect Success` | `Code compiles, runs, passes all tests. Clean static analysis and DCM. Idiomatic Dart. Perfect DX.` |
| **`0.75–0.99`** | `Functional with Minor Flaws` | `Code works and tests pass. Minor lint warnings or slightly unidiomatic patterns. Minor DX friction.` |
| **`0.50–0.74`** | `Partial Success` | `Core features work but some tests fail, lints are significant, or the agent encountered noticeable recovery loops.` |
| **`0.25–0.49`** | `Poor Implementation` | `Significant errors. Fails to compile, ignores constraints, or encountered severe DX breakdown.` |
| **`0.00`** | `Total Failure` | `No working code produced, or the agent became stuck in an infinite loop.` |

### **`How scores drive decisions`**

`By combining the Result Score with diagnostic telemetry and human audits, we systematically triage issues:`

* **`High Result (1.00)`**`:`  
  * *`Telemetry check`*`: If expected tools were used, tool design is validated. If expected tools were skipped, evaluate whether the tool is necessary. If token burn was high, streamline prompt context or add shortcut tools.`  
* **`Medium Result (0.50–0.99)`**`:`  
  * *`Action`*`: Tune skill prompts, refine tool parameter schemas and validation logic, or collaborate with model teams on code generation polish.`  
* **`Low Result (< 0.50)`**`:`  
  * *`If expected tools were ignored`*`: Indicates discoverability issues or ambiguous prompt instructions $\rightarrow$ refine tool descriptions, frontmatter, and context guidelines.`  
  * *`If expected tools were used but the run failed`*`: Indicates tool outputs were insufficient $\rightarrow$ build stronger helper tools or refine framework APIs.`  
  * *`If token burn was high`*`: Indicates the agent was caught in repetitive debugging loops $\rightarrow$ improve compiler diagnostic messages to enable single-step self-healing.`  
  * *`If token burn was low`*`: Indicates the agent gave up prematurely $\rightarrow$ refine task prompt constraints and instructions.`  
* **`Human root-cause audits`**`: For failed runs, engineers inspect the reasoning traces, plan adherence, and harness error logs to diagnose why the agent derailed.`

# Data analysis

`We slice evaluation results across all four matrix dimensions to answer specific engineering questions:`

* `Does adding a new Flutter skill improve Result Scores and consistency across multiple models?`  
* `Do tooling improvements hold steady when testing with different agent harnesses?`  
* `Are there SDK changes in beta that break agent workflows before reaching stable?`  
* `Which CUJs have consistently low scores, indicating priority areas for documentation or tooling?`

`This multi-dimensional analysis directly drives decisions on where to invest across tooling, documentation, and the Flutter SDK.`

# Transparency and iteration

`While we keep our evaluation datasets and reference solutions private to prevent benchmark contamination in future model training, we are committed to open methodology:`

* `Publishing our evaluation methodology and framework designs`  
* `Sharing our canonical list of CUJs and prompt patterns`  
* `Publishing regular benchmark findings, analysis, and insights`  
* `Open-sourcing verification tooling and harness utilities that do not compromise dataset privacy`

`Our methodology will continue to evolve as we gather data and refine our benchmarks.`

&nbsp;