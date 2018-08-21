---
layout: page
title: "Trabajando con listas grandes"
permalink: /cookbook/lists/long-lists/
---

El constructor estándar [`ListView`](https://docs.flutter.io/flutter/widgets/ListView-class.html) funciona bien para listas pequeñas. Para trabajar con listas que contienen una gran cantidad de elementos, es mejor usar el constructor [`ListView.builder`](https://docs.flutter.io/flutter/widgets/ListView/ListView.builder.html) .

Mientras que el constructor predeterminado `ListView` requiere que creemos todos los elementos a la vez, el constructor `ListView.builder` creará los elementos a medida que se desplazan por la pantalla.

## 1. Crea una fuente de datos

Primero, necesitaremos una fuente de datos para trabajar. Por ejemplo, su fuente de datos puede ser una lista de mensajes, resultados de búsqueda o productos de una tienda. La mayoría de las veces, estos datos provendrán de internet o de una base de datos. 

Para este ejemplo, generaremos una lista de 10000 Strings usando el constructor 
[`List.generate`](https://docs.flutter.io/flutter/dart-core/List/List.generate.html) .

<!-- skip -->
```dart
final items = List<String>.generate(10000, (i) => "Item $i");
```

## 2. Convierte la fuente de datos en Widgets

¡Para mostrar nuestra Lista de Strings, necesitaremos representar cada String como un Widget!

Aquí es donde el `ListView.builder` entrará en juego. En nuestro caso, mostraremos cada 
 String en su propia línea. 

<!-- skip -->
```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text('${items[index]}'),
    );
  },
);
```

## Ejemplo completo

```dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp(
    items: List<String>.generate(10000, (i) => "Item $i"),
  ));
}

class MyApp extends StatelessWidget {
  final List<String> items;

  MyApp({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = 'Long List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${items[index]}'),
            );
          },
        ),
      ),
    );
  }
}
```

![Long Lists Demo](/images/cookbook/long-lists.gif)
