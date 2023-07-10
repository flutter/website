You can also create a `.vscode/launch.json` file in your Flutter module project.
This enables you to attach using the **Run > Start Debugging** command or `F5`:

```json
{
  name: "Flutter: Attach",
  request: "attach",
  type: "dart",
}
```