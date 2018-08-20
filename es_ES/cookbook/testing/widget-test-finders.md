---
layout: page
title: "Descubriendo Widgets en un Widget Test"
permalink: /cookbook/testing/widget-test-finders/
---

Para localizar Widgets en un entorno de prueba, necesitamos usar clases `Finder`. Si bien es posible escribir nuestras propias clases `Finder`, generalmente es más conveniente ubicar Widgets usando las herramientas proporcionadas por el paquete  
[`flutter_test`](https://docs.flutter.io/flutter/flutter_test/flutter_test-library.html).

En esta receta, veremos la constante
[`find`](https://docs.flutter.io/flutter/flutter_test/find-constant.html)
proporcionada por el paquete `flutter_test` y demostraremos cómo trabajar con algunos de los `Finders` que proporciona. Para obtener una lista completa de los buscadores disponibles, por favor consulta la documentación de 
[`CommonFinders`](https://docs.flutter.io/flutter/flutter_driver/CommonFinders-class.html).

Si no estás familiarizado con Widget testing y el rol de las clases `Finder`, 
por favor revisa la receta 
[Introducción al Widget testing](/cookbook/testing/widget-test-introduction/). 

### Instrucciones

  1. Encuentra un Widget `Text` 
  2. Encuentra un Widget con una `Key` específica
  3. Encuentra una instancia específica de un Widget

### 1. Encuentra un Widget `Text`

En nuestras pruebas, a menudo necesitamos encontrar Widgets que contengan un texto específico. Esto es exactamente para lo que sirve el método `find.text`. Creará un `Finder` que busque por Widgets que muestren un `String` de texto específico.

<!-- skip -->
```dart
testWidgets('encuentra un Text Widget', (WidgetTester tester) async {
  // Crea una App con un Text Widget que muestra la letra 'H'
  await tester.pumpWidget(MaterialApp(
    home: Scaffold(
      body: Text('H'),
    ),
  ));

  // Encuentra un Widget que muestra la letra 'H'
  expect(find.text('H'), findsOneWidget);
});
```

### 2. Encuentra un Widget con una `Key` específica

En algunos casos, es posible que queramos encontrar un Widget basado en la clave que se le ha proporcionado. Esto puede ser útil si estamos mostrando múltiples instancias del mismo Widget. Por ejemplo, podríamos tener un `ListView` que muestre varios `Text` Widgets que contengan el mismo texto.

En este caso, podemos proporcionar una `Key` para cada Widget en la lista. Esto permitirá identificar de manera única un Widget específico, facilitando la búsqueda del Widget en el entorno de prueba.

<!-- skip -->
```dart
testWidgets('encuentra un Widget usando una Key', (WidgetTester tester) async {
  // Define nuestra llave de prueba
  final testKey = Key('K');

  // Construye un MaterialApp con la testKey
  await tester.pumpWidget(MaterialApp(key: testKey, home: Container()));

  // Encuentra el Widget MaterialApp usando la testKey
  expect(find.byKey(testKey), findsOneWidget);
});
```

### 3. Encuentra una instancia específica de un Widget

Por último, puede que nos interese localizar una instancia específica de un Widget.
Por ejemplo, esto puede ser útil al crear Widgets que toman una propiedad `child` 
y queremos asegurarnos de que estamos renderizando el Widget `child`.

<!-- skip -->
```dart
testWidgets('encuentra una instancia específica', (WidgetTester tester) async {
  final childWidget = Padding(padding: EdgeInsets.zero);

  // Proporciona nuestro childWidget al Container
  await tester.pumpWidget(Container(child: childWidget));

  // Busca por el childWidget en el árbol y verifica que exista
  expect(find.byWidget(childWidget), findsOneWidget);
});
```

### Resumen

La constante `find` proporcionada por el paquete `flutter_test` nos brinda varias formas de localizar Widgets en el entorno de prueba. Esta receta demostró tres de estos métodos, y existen muchos más métodos para diferentes propósitos.

Si los ejemplos anteriores no funcionan para un caso de uso en particular, por favor mira la documentación 
[`CommonFinders`](https://docs.flutter.io/flutter/flutter_driver/CommonFinders-class.html)
para revisar todos los métodos disponibles. 

### Ejemplo completo

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('encuentra un Text Widget', (WidgetTester tester) async {
    // Crea una App con un Text Widget que muestra la letra 'H'
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Text('H'),
      ),
    ));

    // Encuentra un Widget que muestra la letra 'H'
    expect(find.text('H'), findsOneWidget);
  });

  testWidgets('encuentra un Widget usando una Key',
      (WidgetTester tester) async {
    // Define nuestra llave de prueba
    final testKey = Key('K');

    // Construye un MaterialApp con la testKey
    await tester.pumpWidget(MaterialApp(key: testKey, home: Container()));

    // Encuentra el Widget MaterialApp usando la testKey
    expect(find.byKey(testKey), findsOneWidget);
  });
  testWidgets('encuentra una instancia específica',
      (WidgetTester tester) async {
    final childWidget = Padding(padding: EdgeInsets.zero);

    // Proporciona nuestro childWidget al Container
    await tester.pumpWidget(Container(child: childWidget));

    // Busca por el childWidget en el árbol y verifica que exista
    expect(find.byWidget(childWidget), findsOneWidget);
  });
}
```
