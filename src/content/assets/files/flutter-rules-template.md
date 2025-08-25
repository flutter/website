# **AI Development Guidelines for Flutter**

These guidelines define the operational principles and capabilities of an AI agent (e.g., Gemini) interacting with Flutter projects within your environment. The goal is to enable an efficient, automated, and error-resilient application design and development workflow.

## **Environment & Context Awareness**

The AI operates within your development environment, which provides a Code OSS-based IDE with deep integration for Flutter.

* **Project Structure:** The AI assumes a standard Flutter project structure. The primary application entry point is typically lib/main.dart.

## **Code Modification & Dependency Management**

The AI is empowered to modify the Flutter codebase and manage its dependencies autonomously based on user requests and detected issues. The AI is creative and anticipates features that the user might need even if not explicitly requested.

* **Core Code Assumption:** When a user requests a change (e.g., "Add a button to navigate to a new screen"), the AI will primarily focus on modifying the Dart code. lib/main.dart is assumed to be the main entry point, and the AI will infer other relevant files (e.g., creating new widget files, updating pubspec.yaml).
* **Package Management:** If a new feature requires an external package, the AI will identify the most suitable and stable package from pub.dev.
  * To add a regular dependency, it will execute `flutter pub add <package_name>`.
  * To add a development dependency (e.g., for testing or code generation), it will execute `flutter pub add dev:<package_name>`.
* **Code Generation (build\_runner):**
  1. When a change introduces a need for code generation (e.g., for freezed classes, json\_serializable models, or riverpod\_generator), the AI will:
     1. Ensure build\_runner is listed in dev\_dependencies in pubspec.yaml.
     2. Automatically execute dart run build\_runner build \--delete-conflicting-outputs to generate necessary files after code modifications that require it.
* **Code Quality:** The AI aims to adhere to Flutter/Dart best practices, including:
  * Clean code structure and separation of concerns (e.g., UI logic separate from business logic).
  * Meaningful and consistent naming conventions.
  * Effective use of const constructors and widgets for performance optimization.
  * Appropriate state management solutions (e.g., Provider).
  * Avoiding expensive computations or I/O operations directly within build methods.
  * Proper use of async/await for asynchronous operations with robust error handling.

## **Automated Error Detection & Remediation**

A critical function of the AI is to continuously monitor for and automatically resolve errors to maintain a runnable and correct application state.

* **Post-Modification Checks:** After *every* code modification (including adding packages, running code generation, or modifying existing files), the AI will:
  1. Monitor the IDE's diagnostics (problem pane) and the terminal output (from flutter run, flutter analyze) for compilation errors, Dart analysis warnings, and runtime exceptions.
  2. Check the preview server's output for rendering issues, application crashes, or unexpected behavior.
* **Automatic Error Correction:** The AI will attempt to automatically fix detected errors. This includes, but is not limited to:
  * Syntax errors in Dart code.
  * Type mismatches and null-safety violations.
  * Unresolved imports or missing package references.
  * Linting rule violations (the AI will automatically run flutter format . and address lint warnings).
  * When analysis errors are detected, the AI will first attempt to resolve them by running `flutter fix --apply .`.
  * Common Flutter-specific issues such as calling setState on an unmounted widget, improper resource disposal in dispose() methods, or incorrect widget tree structures.
  * Ensuring proper asynchronous error handling (e.g., adding try-catch blocks for Future operations, using mounted checks before setState).
* **Problem Reporting:** If an error cannot be automatically resolved (e.g., a logic error requiring user clarification, or an environment issue), the AI will clearly report the specific error message, its location, and a concise explanation with a suggested manual intervention or alternative approach to the user.

## **Material Design Specifics**

### **Theming**

The AI will implement and manage a comprehensive and consistent theme for the application, adhering to Material Design 3 principles. This includes defining color schemes, typography, and component styles in a centralized `ThemeData` object.

#### **Color Schemes (Material 3\)**

The AI will prioritize using `ColorScheme.fromSeed` to generate harmonious and accessible color palettes from a single seed color. This is the foundation of Material 3 theming and supports dynamic color on platforms like Android.

#### **Typography and Custom Fonts**

The AI will use `TextTheme` to define consistent text styles (e.g., `displayLarge`, `titleMedium`, `bodySmall`). For custom fonts, the `google_fonts` package is the recommended approach for its ease of use and vast library of fonts.

To use `google_fonts`, add it to your project:

```shell
flutter pub add google_fonts
```

*Example `TextTheme` with `google_fonts`:*

```
import 'package:google_fonts/google_fonts.dart';

final TextTheme myTextTheme = TextTheme(
  displayLarge: GoogleFonts.oswald(fontSize: 57, fontWeight: FontWeight.bold),
  titleLarge: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.w500),
  bodyMedium: GoogleFonts.openSans(fontSize: 14),
);
```

####

#### **Component Theming**

To ensure UI consistency, the AI will use specific theme properties (e.g., `appBarTheme`, `elevatedButtonTheme`) to customize the appearance of individual Material components.

#### **Dark/Light Mode and Theme Toggle**

The AI will implement support for both light and dark themes. A state management solution like `provider` is ideal for creating a user-facing theme toggle (`ThemeMode.light`, `ThemeMode.dark`, `ThemeMode.system`).

#### **Full Theming Example**

The following example demonstrates a complete theme setup using `provider` for a theme toggle and `google_fonts` for typography.

To use `provider`, add it to your project:

```shell
flutter pub add provider
```

```
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import GoogleFonts
import 'package:provider/provider.dart'; // Import Provider

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

// ThemeProvider class to manage the theme state
class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system; // Default to system theme

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setSystemTheme() {
    _themeMode = ThemeMode.system;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primarySeedColor = Colors.deepPurple;

    // Define a common TextTheme
    final TextTheme appTextTheme = TextTheme(
      displayLarge: GoogleFonts.oswald(fontSize: 57, fontWeight: FontWeight.bold),
      titleLarge: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.w500),
      bodyMedium: GoogleFonts.openSans(fontSize: 14),
    );

    // Light Theme
    final ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primarySeedColor,
        brightness: Brightness.light,
      ),
      textTheme: appTextTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: primarySeedColor,
        foregroundColor: Colors.white,
        titleTextStyle: GoogleFonts.oswald(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: primarySeedColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );

    // Dark Theme
    final ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primarySeedColor,
        brightness: Brightness.dark,
      ),
      textTheme: appTextTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        titleTextStyle: GoogleFonts.oswald(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: primarySeedColor.shade200,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Flutter Material AI App',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeProvider.themeMode,
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Material AI Demo'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(),
            tooltip: 'Toggle Theme',
          ),
          IconButton(
            icon: const Icon(Icons.auto_mode),
            onPressed: () => themeProvider.setSystemTheme(),
            tooltip: 'Set System Theme',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome!', style: Theme.of(context).textTheme.displayLarge),
            const SizedBox(height: 20),
            Text('This text uses a custom font.', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 30),
            ElevatedButton(onPressed: () {}, child: const Text('Press Me')),
          ],
        ),
      ),
    );
  }
}
```

###

### **Assets, Images, and Icons**

These widgets are used for managing and displaying various types of assets, including images and icons.

* **Asset Declaration in pubspec.yaml**: Before using assets, they must be declared in the pubspec.yaml file. The AI will prompt the user to ensure this is correctly configured or add it if necessary.

```
# In pubspec.yaml
flutter:
  uses-material-design: true
  assets:
    - assets/images/ # Example: entire folder
    - assets/icons/my_icon.png # Example: specific file
```

* **Image.asset**: Displays an image from the application's asset bundle.

```
// Assuming 'assets/images/placeholder.png' is declared in pubspec.yaml
Image.asset(
  'assets/images/placeholder.png',
  width: 100,
  height: 100,
  fit: BoxFit.cover,
)
```

* **Image.network**: Displays an image from a URL.

```
Image.network(
  'https://picsum.photos/200/300',
  width: 200,
  height: 300,
  fit: BoxFit.cover,
  loadingBuilder: (context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return Center(
      child: CircularProgressIndicator(
        value: loadingProgress.progress,
      ),
    );
  },
  errorBuilder: (context, error, stackTrace) {
    return const Icon(Icons.error, color: Colors.red, size: 50);
  },
)
```

* **Icon**: Displays a Material Design icon (from Icons class).

```
const Icon(
  Icons.favorite,
  color: Colors.red,
  size: 30.0,
)
```

* **ImageIcon**: Displays an icon from an ImageProvider (useful for custom icons not in Icons class).

```
// Assuming 'assets/icons/custom_icon.png' is declared in pubspec.yaml
ImageIcon(
  const AssetImage('assets/icons/custom_icon.png'),
  size: 24,
  color: Colors.green,
)
```

###

### **Routing and Navigation**

Flutter provides powerful mechanisms for navigating between different screens (routes) in an application. The AI will utilize and recommend appropriate routing strategies based on the complexity and requirements of the navigation flow.

* **Basic Imperative Navigation (Navigator)**: For simple navigation stacks, Flutter's built-in Navigator is straightforward.
  * **Navigator.push**: Pushes a new route onto the navigator stack.

```
// From Screen A to Screen B
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const ScreenB()),
);
```

* **Navigator.pop**: Pops the top route off the navigator stack.

```
// From Screen B back to Screen A
Navigator.pop(context);
```

* **Navigator.pushReplacement**: Replaces the current route with a new one.

```
// Replace current screen with a new one (e.g., after login)
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => const HomeScreen()),
);
```

* **Declarative Navigation with go\_router**: For more complex navigation, deep linking, and web support, the go\_router package is a robust and recommended solution. The AI will integrate and configure go\_router when declarative navigation or advanced features like deep linking are required.
  To use go\_router, first add it to your project by running:

```shell
flutter pub add go_router
```

  **Example go\_router Configuration:**

```
// In main.dart or a dedicated router.dart file
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Define your routes
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen(); // Your home screen
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details/:id', // Route with a path parameter
          builder: (BuildContext context, GoRouterState state) {
            final String id = state.pathParameters['id']!;
            return DetailScreen(id: id); // Screen to show details
          },
        ),
        GoRoute(
          path: 'settings',
          builder: (BuildContext context, GoRouterState state) {
            return const SettingsScreen(); // Your settings screen
          },
        ),
      ],
    ),
  ],
);

// In your MaterialApp or CupertinoApp
/*
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'GoRouter Example',
      // ... your theme data
    );
  }
}
*/

// Example screens for the router
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/details/123'), // Navigate to details with ID
              child: const Text('Go to Details 123'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/settings'), // Navigate to settings
              child: const Text('Go to Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String id;
  const DetailScreen({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Screen: $id')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.pop(), // Pop back
          child: const Text('Go Back'),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.pop(), // Pop back
          child: const Text('Go Back'),
        ),
      ),
    );
  }
}
```

* **Deep Linking**: go\_router handles deep links automatically based on the defined URL paths, allowing specific screens to be opened directly from external sources (e.g., web links, push notifications).
* **Auth Redirects**: The AI can configure go\_router's redirect property to handle authentication flows, ensuring users are redirected to login screens when unauthorized, and back to their intended destination after successful login.

## **Application Architecture**

This section outlines the AI's approach to structuring Flutter applications, covering core architectural concepts, recommended patterns, and design principles to ensure maintainability, scalability, and testability.

### **Architectural Concepts**

The AI will understand and apply fundamental architectural concepts in Flutter:

* **Widgets are the UI**: Everything in Flutter's UI is a widget. The AI will compose complex UIs from smaller, reusable widgets.
* **Immutability**: Widgets (especially StatelessWidget) are immutable. When the UI needs to change, Flutter rebuilds the widget tree.
* **State Management**: Understands the importance of managing mutable state. The AI will recommend and apply appropriate state management solutions based on the application's complexity.
* **Separation of Concerns**: Strive to separate UI (widgets), business logic, and data layers to improve code organization, testability, and maintainability.

### **State Management Recommendations**

The choice of state management solution depends on the project's scale and complexity. The AI will recommend and use the simplest appropriate tool for the job, starting with Flutter's built-in state management capabilities and using `provider` for more complex scenarios.

* **Local State Management (Built-in)**

  * **ValueNotifier & ValueListenableBuilder**: For managing the state of a single value. This is the most lightweight and efficient option for simple, local state (e.g., a counter, a boolean flag, or the text in a field). The AI will use `ValueListenableBuilder` to ensure only the widgets that depend on the state are rebuilt.

    *Example:*

```
// 1. Define a ValueNotifier to hold the state.
final ValueNotifier<int> _counter = ValueNotifier<int>(0);

// 2. Use ValueListenableBuilder to listen and rebuild.
ValueListenableBuilder<int>(
  valueListenable: _counter,
  builder: (context, value, child) {
    return Text('Count: $value');
  },
)

// 3. Update the value directly.
_counter.value++;
```

  * **Streams & StreamBuilder**: For handling a sequence of asynchronous events, such as data from a network request, user input, or streams. `StreamBuilder` listens to a stream and rebuilds its UI whenever new data is emitted.

  * **Futures & FutureBuilder**: For handling a single asynchronous operation that will complete in the future, such as fetching data from an API. `FutureBuilder` displays a widget based on the state of the `Future` (e.g., showing a loading spinner while waiting, data on completion, or an error message).


* **App-wide State Management & Dependency Injection**

  * **ChangeNotifier & ChangeNotifierProvider**: When state is more complex than a single value or needs to be shared across multiple widgets that are not direct descendants. The AI will use a `ChangeNotifier` to encapsulate the state and business logic, and a `ChangeNotifierProvider` to make it available to the widget tree. This is a foundational pattern for the `provider` package.

  * **Provider**: For dependency injection and managing state that needs to be accessed in multiple places throughout the application. The AI will use `provider` to make services, repositories, or complex state objects available to the UI layer without tight coupling. It is the recommended approach for medium to large applications.

### **Data Flow and Services**

The AI will design data flow in a unidirectional manner, typically from a data source (e.g., network, database) through services/repositories to the state management layer, and finally to the UI.

* **Repositories/Services**: For abstracting data sources (e.g., API calls, database operations). This promotes testability and allows for easy swapping of data sources.
* **Models/Entities**: Define data structures (classes) to represent the data used in the application.
* **Dependency Injection**: Use simple constructor injection or a package like provider to manage dependencies between different layers of the application.

### **Common Architectural Patterns**

The AI will apply common architectural patterns to ensure a well-structured application:

* **MVC (Model-View-Controller) / MVVM (Model-View-ViewModel) / MVI (Model-View-Intent)**: While Flutter's widget-centric nature makes strict adherence to these patterns challenging, the AI will aim for similar separation of concerns.
  * **Model**: Data layer and business logic.
  * **View**: The UI (widgets).
  * **Controller/ViewModel/Presenter**: Handles UI logic, interacts with the model, and updates the view.
* **Layered Architecture**: Organize the project into logical layers such as:
  * presentation (UI, widgets, pages)
  * domain (business logic, models, use cases)
  * data (repositories, data sources, API clients)
  * core (shared utilities, common extensions)
* **Feature-first Structure**: Organize code by feature, where each feature has its own presentation, domain, and data subfolders. This improves navigability and scalability for larger projects.

### **Error Handling and Logging**

* **Centralized Error Handling**: Implement mechanisms to gracefully handle errors across the application (e.g., using try-catch blocks, Either types for functional error handling, or global error handlers).
* **Logging**: Incorporate logging for debugging and monitoring application behavior.

### **Logging with `dart:developer`**

For effective debugging and monitoring, the AI will use the `dart:developer` library, which provides structured logging that integrates with Dart DevTools.

* **Basic Logging**: For simple messages, the `log` function is used.

```
import 'dart:developer' as developer;

developer.log('This is a simple log message.');
```

* **Structured Logging**: For more detailed logs, the `log` function accepts several optional parameters:

  * `name`: A `String` to categorize log messages (e.g., 'my\_app.network').
  * `level`: An `int` for severity (e.g., `800` for `INFO`, `900` for `WARNING`, `1000` for `SEVERE`).
  * `error`: An `Object` for logging exceptions.
  * `stackTrace`: A `StackTrace` object.


  *Example:*

```
import 'dart:developer' as developer;

try {
  throw 'Something went wrong!';
} catch (e, s) {
  developer.log(
    'An error occurred',
    name: 'my_app.network',
    level: 900, // WARNING
    error: e,
    stackTrace: s,
  );
}
```

* **Viewing Logs**: Structured logs can be viewed in the "Debug Console" of the IDE or, for a more detailed analysis, in the "Logging" tab of Dart DevTools. This allows for filtering and inspecting log entries, making debugging more efficient.

## **Test Generation & Execution**

When requested, the AI will facilitate the creation and execution of tests, ensuring code reliability and validating functionality.

* **Test Writing:**
  * Upon user request for tests (e.g., "Write tests for this new feature"), the AI will generate appropriate test files (e.g., test/\<file\_name\>\_test.dart).
  * For new functions, methods, or classes, especially those containing business logic, the AI will prioritize writing comprehensive unit tests using the package:test/test.dart framework.
  * The AI will automatically set up mocking (e.g., using mockito) to isolate units under test from their dependencies.
  * Tests will be designed to cover different input values, edge cases, and error scenarios.
* **Automated Test Execution:**
  * After generating or modifying tests, and after any significant code change, the AI will automatically execute the relevant tests using `flutter test` in the terminal.
  * The AI will report test results (pass/fail, with details on failures) to the user.
  * For broader application validation, the AI can suggest or execute integration tests (`flutter test integration_test/app_test.dart`) when appropriate.
* **Test-Driven Iteration:** The AI supports an iterative test-driven approach, where new features or bug fixes are accompanied by relevant tests, which are then run to validate the changes and provide immediate feedback.

## **Visual Design**

**Aesthetics:** The AI always makes a great first impression by creating a unique user experience that incorporates modern components, a visually balanced layout with clean spacing, and polished styles that are easy to understand.

1. Build beautiful and intuitive user interfaces that follow modern design guidelines.
2. Ensure your app is mobile responsive and adapts to different screen sizes, working perfectly on mobile and web.
3. Propose colors, fonts, typography, iconography, animation, effects, layouts, texture, drop shadows, gradients, etc.
4. If images are needed, make them relevant and meaningful, with appropriate size, layout, and licensing (e.g., freely available). If real images are not available, provide placeholder images.
5. If there are multiple pages for the user to interact with, provide an intuitive and easy navigation bar or controls.

**Bold Definition:** The AI uses modern, interactive iconography, images, and UI components like buttons, text fields, animation, effects, gestures, sliders, carousels, navigation, etc.

1. Fonts \- Choose expressive and relevant typography. Stress and emphasize font sizes to ease understanding, e.g., hero text, section headlines, list headlines, keywords in paragraphs, etc.
2. Color \- Include a wide range of color concentrations and hues in the palette to create a vibrant and energetic look and feel.
3. Texture \- Apply subtle noise texture to the main background to add a premium, tactile feel.
4. Visual effects \- Multi-layered drop shadows create a strong sense of depth. Cards have a soft, deep shadow to look "lifted."
5. Iconography \- Incorporate icons to enhance the user’s understanding and the logical navigation of the app.
6. Interactivity \- Buttons, checkboxes, sliders, lists, charts, graphs, and other interactive elements have a shadow with elegant use of color to create a "glow" effect.

## **Accessibility or A11Y Standards:** Implement accessibility features to empower all users, assuming a wide variety of users with different physical abilities, mental abilities, age groups, education levels, and learning styles.

## **Iterative Development & User Interaction**

The AI's workflow is iterative, transparent, and responsive to user input.

* **Plan Generation & Blueprint Management:** Each time the user requests a change, the AI will first generate a clear plan overview and a list of actionable steps. This plan will then be used to **create or update a blueprint.md file** in the project's root directory (or a designated docs folder if specified).
  * The blueprint.md file will serve as a single source of truth, containing:
    * A section with a concise overview of the purpose and capabilities.
    * A section with a detailed outline documenting the project, including all *style, design, and features* implemented in the application from the initial version to the current version.
    * A section with a detailed section outlining the plan and steps for the *current* requested change.
    *
  * Before initiating any new change or at the start of a new chat session, the AI will reference the blueprint.md to ensure full context and understanding of the application's current state and existing features. This ensures consistency and avoids redundant or conflicting modifications.
* **Prompt Understanding:** The AI will interpret user prompts to understand the desired changes, new features, bug fixes, or questions. It will ask clarifying questions if the prompt is ambiguous.
* **Contextual Responses:** The AI will provide conversational and contextual responses, explaining its actions, progress, and any issues encountered. It will summarize changes made.
* **Error Checking Flow:**
  1. **Code Change:** AI applies a code modification.
  2. **Lint/Format:** AI runs `dart format .` and addresses minor lint warnings.
  3. **Dependency Check:** If pubspec.yaml was modified, AI runs `flutter pub get`.
  4. **Code Generation:** If necessary, AI runs `dart run build_runner build --delete-conflicting-outputs`.
  5. **Compile & Analyze:** AI monitors terminal for `flutter analyze` and compilation errors from flutter run (which happens automatically on file save with the preview server).
  6. **Test Execution:** If tests were requested or modified, AI runs `flutter test`.
  7. **Preview Check:** AI observes the preview server for visual and runtime errors.
  8. **Remediation/Report:** If errors are found, AI attempts automatic fixes. If unsuccessful, it reports details to the user.

This structured approach ensures that the AI can effectively assist in developing and maintaining robust Flutter applications within your environment, making the development process more automated and efficient.
