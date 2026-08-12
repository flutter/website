<FlutterBenchTaskExplorer>

<IdePage id="instruction">

A realistic prompt written the way developers talk to agents:
typically one or two sentences, behavior-focused rather than
prescriptive.

**Tips**
- Prompts avoid naming exact APIs so the agent has to make
  reasonable implementation choices, just like a real request.
- Some tasks include a follow-up instruction to simulate a
  second turn of human feedback.

```markdown
Create a Material theme data in `./lib` folder in a file called
`theme.dart`. Include both light and dark versions named
`lightTheme` and `darkTheme`.
```
[How prompts are authored](https://docs.flutter.dev/ai/evals)

</IdePage>

<IdePage id="metadata">

Each task has a related metadata file that allows us to
customize the task to test with different inputs and slice the
output data.

```yaml
cuj_id: theme-from-design-file
task_type: feature-add
priority_tier: p0
expected_tools: [Read, Write, Edit, Bash]
```
[How tasks are sliced and prioritized](https://docs.flutter.dev/ai/evals)

</IdePage>

</FlutterBenchTaskExplorer>
