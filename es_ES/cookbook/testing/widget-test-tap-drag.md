---
layout: page
title: "Pulsando, arrastrando e ingresando texto en los Widget Tests"
permalink: /cookbook/testing/widget-test-tap-drag/
---

Muchos de los Widgets que construimos no sólo muestran información, sino que también responden a la interacción del usuario. Esto incluye botones en los que los usuarios pueden pulsar, arrastrar elementos por la pantalla o introducir texto en un 
[`TextField`](https://docs.flutter.io/flutter/material/TextField-class.html).

Para probar estas interacciones, necesitamos una forma de simularlas en el entorno de prueba. Para hacerlo, podemos usar la clase 
[`WidgetTester`](https://docs.flutter.io/flutter/flutter_test/WidgetTester-class.html)
proporcionada por la biblioteca 
[`flutter_test`](https://docs.flutter.io/flutter/flutter_test/flutter_test-library.html).

`WidgetTester` proporciona métodos para ingresar texto, pulsar y arrastrar.

  * [`enterText`](https://docs.flutter.io/flutter/flutter_test/WidgetTester/enterText.html)
  * [`tap`](https://docs.flutter.io/flutter/flutter_test/WidgetController/tap.html) 
  * [`drag`](https://docs.flutter.io/flutter/flutter_test/WidgetController/drag.html)
  
En muchos casos, las interacciones del usuario actualizarán el estado de nuestra aplicación. En el entorno de prueba, Flutter no reconstruirá automáticamente los widgets cuando cambie el estado. Para asegurarnos de que nuestro árbol de widgets se reconstruya después de simular una interacción con el usuario, debemos llamar a los métodos
[`pump`](https://docs.flutter.io/flutter/flutter_test/WidgetTester/pump.html) o
[`pumpAndSettle`](https://docs.flutter.io/flutter/flutter_test/WidgetTester/pumpAndSettle.html)
 proporcionados por el `WidgetTester`.
  
### Instrucciones

  1. Crea un Widget para probar
  2. Ingresa texto en el campo de texto
  3. Asegúrate de que, al pulsar un botón, agrega a la lista de tareas pendientes
  4. Asegúrate de que, al deslizar-para-desechar, retira de la lista de tareas pendientes
    
### 1. Crea un Widget para probar

Para este ejemplo, crearemos una aplicación básica de tareas pendientes. Tendrá tres características principales que queremos probar:

  1. Ingresa texto en un `TextField`
  2. Al pulsar un `FloatingActionButton` se agrega el texto a una lista de tareas pendientes
  3. Deslizar para desechar remueve el elemento de la lista

Para mantener el foco en las pruebas, esta receta no proporcionará una guía detallada sobre cómo crear la aplicación de tareas pendientes. Para obtener más información sobre cómo se construye esta aplicación, por favor consulte las recetas relevantes:

  * [Crea y da estilo a un campo de texto](/cookbook/forms/text-input/)
  * [Manejo de Toques](/cookbook/gestures/handling-taps/)
  * [Crea una lista básica](/cookbook/lists/basic-list/)
  * [Implementa Deslizar para desechar](/cookbook/gestures/dismissible/)
  
```dart
class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  static const _appTitle = 'Todo List';
  final todos = <String>[];
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(_appTitle),
        ),
        body: Column(
          children: [
            TextField(
              controller: controller,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (BuildContext context, int index) {
                  final todo = todos[index];

                  return Dismissible(
                    key: Key('$todo$index'),
                    onDismissed: (direction) => todos.removeAt(index),
                    child: ListTile(title: Text(todo)),
                    background: Container(color: Colors.red),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              todos.add(controller.text);
              controller.clear();
            });
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
```

### 2. Ingresa texto en el campo de texto

Ahora que tenemos una aplicación de tareas pendientes, !podemos empezar a escribir nuestra prueba! En este caso, comenzaremos por ingresar el texto en un `TextField`.

Podemos lograr esta tarea:

  1. Construyendo el Widget en el entorno de prueba
  2. Usando el método
  [`enterText`](https://docs.flutter.io/flutter/flutter_test/WidgetTester/enterText.html)
   desde el `WidgetTester`
  
<!-- skip -->
```dart
testWidgets('Agregar y remover de una lista de tareas pendientes',
   (WidgetTester tester) async {
  // Crear el Widget
  await tester.pumpWidget(TodoList());
    
  // Ingresar 'hola' en el TextField
  await tester.enterText(find.byType(TextField), 'hola');
});
```

**Nota:** Esta receta se basa en recetas de pruebas de Widgets anteriores. Para aprender los  
conceptos claves de probar un Widget, por favor consulta las siguientes recetas:

  * [Introducción a la prueba de Widget](/cookbook/testing/widget-test-introduction/)
  * [Descubriendo Widgets en un Widget Test](/cookbook/testing/widget-test-finders/)

### 3. Asegúrate de que, al pulsar un botón, agrega a la lista de tareas pendientes

Después de que hayamos ingresado texto en el `TextField`, queremos asegurarnos de que al pulsar 
el `FloatingActionButton` se agrega el elemento a la lista.

Esto implicará tres pasos:

  1. Pulsa el botón Agregar usando el método 
  [`tap`](https://docs.flutter.io/flutter/flutter_test/WidgetController/tap.html)
  2. Reconstruye el Widget después de que el estado haya cambiado usando el método 
  [`pump`](https://docs.flutter.io/flutter/flutter_test/TestWidgetsFlutterBinding/pump.html)
  3. Asegúrate de que la lista de elementos aparezca en la pantalla

<!-- skip -->
```dart
testWidgets('Agregar y remover de una lista de tareas pendientes',
   (WidgetTester tester) async {
  // Ingrese el código de texto...
  
  // pulsa el botón Agregar
  await tester.tap(find.byType(FloatingActionButton));

  // Reconstruye el Widget una vez que el estado haya cambiado
  await tester.pump();

  // Asegúrate de encontrar el elemento de la lista en la pantalla
  expect(find.text('hola'), findsOneWidget);
});
```

### 4. Asegúrate de que, al deslizar-para-desechar, retira de la lista de pendientes

Finalmente, podemos asegurarnos de que el desempeño de una acción deslice-para-desechar sobre un elemento de la lista de tareas pendientes lo removerá de la lista. Esto implicará tres pasos: 

  1. Usa el método 
  [`drag`](https://docs.flutter.io/flutter/flutter_test/WidgetController/drag.html)
  para realizar una acción deslice-para-desechar.
  2. Usa el método
  [`pumpAndSettle`](https://docs.flutter.io/flutter/flutter_test/WidgetTester/pumpAndSettle.html)
  para reconstruir continuamente nuestro árbol de Widgets hasta que finalice la animación de desechar.
  3. Asegúrate de que el elemento ya no aparezca en la pantalla.

<!-- skip -->
```dart
testWidgets('Agregar y remover de una lista de tareas pendientes',
   (WidgetTester tester) async {
  // Ingresa texto y adiciona el elemento...
  
  // Desliza el elemento para desecharlo
  await tester.drag(find.byType(Dismissible), Offset(500.0, 0.0));

  // Construye el Widget hasta que la animación de desechar finalice
  await tester.pumpAndSettle();

  // Asegúrate de que el elemento ya no está en la pantalla
  expect(find.text('hola'), findsNothing);
});
```

### Ejemplo Completo

Una vez que hayamos completado estos pasos, deberíamos tener una aplicación en funcionamiento con una prueba para asegurarnos de que ¡funciona correctamente!

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Agregar y remover de una lista de tareas pendientes',
      (WidgetTester tester) async {
    // Crear el Widget
    await tester.pumpWidget(TodoList());

    // Ingresar 'hola' en el TextField
    await tester.enterText(find.byType(TextField), 'hola');

    // pulsar el botón Agregar
    await tester.tap(find.byType(FloatingActionButton));

    // Reconstruir el Widget una vez que el estado haya cambiado
    await tester.pump();

    // Esperar a encontrar el elemento en la pantalla
    expect(find.text('hola'), findsOneWidget);

    // Deslizar el elemento para desecharlo
    await tester.drag(find.byType(Dismissible), Offset(500.0, 0.0));

    // Construir el Widget hasta que la animación de desechar finalice
    await tester.pumpAndSettle();

    // Asegurarse de que el elemento ya no está en la pantalla
    expect(find.text('hola'), findsNothing);
  });
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  static const _appTitle = 'Lista de Tareas Pendientes';
  final todos = <String>[];
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(_appTitle),
        ),
        body: Column(
          children: [
            TextField(
              controller: controller,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (BuildContext context, int index) {
                  final todo = todos[index];

                  return Dismissible(
                    key: Key('$todo$index'),
                    onDismissed: (direction) => todos.removeAt(index),
                    child: ListTile(title: Text(todo)),
                    background: Container(color: Colors.red),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              todos.add(controller.text);
              controller.clear();
            });
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
```
