import re

# stateful-widget.md
with open('src/content/learn/pathway/tutorial/stateful-widget.md', 'r') as f:
    content = f.read()

content = re.sub(
    r'```dart\nclass GamePage extends StatefulWidget \{\n  GamePage\(\{super\.key\}\);\n\n  @override\n  State<GamePage> createState\(\) => _GamePageState\(\);\n\}\n\nclass _GamePageState extends State<GamePage> \{\n  // This manages game logic, and is out of scope for this lesson\.\n  final Game _game = Game\(\);\n\n  @override\n  Widget build\(BuildContext context\) \{\n    return Padding\(/\* \.\.\. \*/\);\n  \}\n\}\n```',
    r'<?code-excerpt "fwe/birdle/lib/step5_main.dart (GamePage)" plaster="none"?>\n```dart\nclass GamePage extends StatefulWidget {\n  const GamePage({super.key});\n\n  @override\n  State<GamePage> createState() => _GamePageState();\n}\n\nclass _GamePageState extends State<GamePage> {\n  final Game _game = Game();\n\n  @override\n  Widget build(BuildContext context) {\n    return Padding(/* ... */);\n  }\n}\n```',
    content
)

content = re.sub(
    r'```dart\nclass GamePage extends StatefulWidget \{.*?\}\n  \}\n\}\n```',
    r'<?code-excerpt "fwe/birdle/lib/step5_main.dart (GamePage)"?>\n```dart\nclass GamePage extends StatefulWidget {\n  // ...\n}\n```',
    content, flags=re.DOTALL
)

with open('src/content/learn/pathway/tutorial/stateful-widget.md', 'w') as f:
    f.write(content)


# implicit-animations.md
with open('src/content/learn/pathway/tutorial/implicit-animations.md', 'r') as f:
    content = f.read()

content = re.sub(
    r'```dart\nclass Tile extends StatelessWidget \{\n  const Tile\(this\.letter, this\.hitType, \{super\.key\}\);\n\n  final String letter;\n  final HitType hitType;\n\n  @override\n  Widget build\(BuildContext context\) \{\n    return Container\(\n      duration: const Duration\(milliseconds: 500\),\n      height: 60,\n      width: 60,\n      decoration: BoxDecoration\(\n        border: Border\.all\(color: Colors\.grey\.shade300\),\n        color: switch \(hitType\) \{\n          HitType\.hit => Colors\.green,\n          HitType\.partial => Colors\.yellow,\n          HitType\.miss => Colors\.grey,\n          _ => Colors\.white,\n        \},\n      \),\n      child: Center\(\n        child: Text\(\n          letter\.toUpperCase\(\),\n          style: Theme\.of\(context\)\.textTheme\.titleLarge,\n        \),\n      \),\n    \);\n  \}\n\}\n```',
    r'<?code-excerpt "fwe/birdle/lib/step2_main.dart (Tile)"?>\n```dart\nclass Tile extends StatelessWidget {\n  // ...\n}\n```',
    content
)

content = re.sub(
    r'```dart\nclass Tile extends StatelessWidget \{\n  const Tile\(this\.letter, this\.hitType, \{super\.key\}\);\n\n  final String letter;\n  final HitType hitType;\n\n  @override\n  Widget build\(BuildContext context\) \{\n    return AnimatedContainer\(\n      duration: const Duration\(milliseconds: 500\),\n      curve: Curves\.bounceIn, // NEW\n      height: 60,\n      width: 60,\n      decoration: BoxDecoration\(\n        border: Border\.all\(color: Colors\.grey\.shade300\),\n        color: switch \(hitType\) \{\n          HitType\.hit => Colors\.green,\n          HitType\.partial => Colors\.yellow,\n          HitType\.miss => Colors\.grey,\n          _ => Colors\.white,\n        \},\n      \),\n      child: Center\(\n        child: Text\(\n          letter\.toUpperCase\(\),\n          style: Theme\.of\(context\)\.textTheme\.titleLarge,\n        \),\n      \),\n    \);\n  \}\n\}\n```',
    r'<?code-excerpt "fwe/birdle/lib/main.dart (Tile)"?>\n```dart\nclass Tile extends StatelessWidget {\n  // ...\n}\n```',
    content
)

with open('src/content/learn/pathway/tutorial/implicit-animations.md', 'w') as f:
    f.write(content)
