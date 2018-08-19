---
layout: page
title: "Añadir un Drawer a la pantalla"
permalink: /cookbook/design/drawer/
---

En las aplicaciones que emplean Material Design, hay dos opciones principales de navegación: tabs y drawers. Cuando no hay suficiente espacio para sostener las pestañas, los Drawers proporcionan una alternativa práctica. 

En Flutter, podemos usar el Widget [`Drawer`](https://docs.flutter.io/flutter/material/Drawer-class.html) en combinación con un [`Scaffold`](https://docs.flutter.io/flutter/material/Scaffold-class.html) para ¡crear un layout con un Material Design Drawer!

## Instrucciones

  1. Crea un `Scaffold`
  2. Agrega un drawer
  3. Añade elementos al Drawer
  4. Cierra el drawer programáticamente
  
## 1. Crea un `Scaffold`

Para agregar un Drawer a nuestra app, necesitaremos envolverlo en un Widget [Scaffold](https://docs.flutter.io/flutter/material/Scaffold-class.html). El Widget Scaffold proporciona una estructura visual consistente a las aplicaciones que siguen las Directrices de Material Design. También admite componentes especiales de Material Design, como Drawers, AppBars, y SnackBars.

En este caso, queremos crear un `Scaffold` con un `drawer`:

<!-- skip -->
```dart
Scaffold(
  drawer: // ¡Añadiremos nuestro Drawer aquí en el siguiente paso!
);
```

## 2. Agrega un drawer

Ahora podemos agregar un drawer a nuestro `Scaffold`. Un drawer puede ser cualquier Widget, pero a menudo es mejor utilizar el widget `Drawer` de la [biblioteca Material](https://docs.flutter.io/flutter/material/material-library.html), 
que se adhiere a las especificaciones de Material Design.

<!-- skip -->
```dart
Scaffold(
  drawer: Drawer(
    child: // Poblaremos el Drawer en el siguiente paso!
  )
);
```

## 3. Añade elementos al Drawer

Ahora que tenemos un `Drawer` en su lugar, ¡podemos agregarle contenido! En este ejemplo, usaremos un [`ListView`](https://docs.flutter.io/flutter/widgets/ListView-class.html). Aunque podríamos usar un Widget `Column`, `ListView` es útil en esta situación, ya que permitirá a los usuarios desplazarse por el drawer si el contenido ocupa más espacio del que soporta la pantalla.

Poblaremos `ListView` con un [`DrawerHeader`](https://docs.flutter.io/flutter/material/DrawerHeader-class.html) 
y dos Widgets [`ListTile`](https://docs.flutter.io/flutter/material/ListTile-class.html). Para obtener más información sobre cómo trabajar con Listas, por favor consulta la 
[recetas de Listas](/cookbook/#listas).

<!-- skip -->
```dart
Drawer(
  // Agrega un ListView al drawer. Esto asegura que el usuario pueda desplazarse
  // a través de las opciones en el Drawer si no hay suficiente espacio vertical
  // para adaptarse a todo.
  child: ListView(
    // Importante: elimine cualquier padding del ListView.
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        child: Text('Drawer Header'),
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
      ),
      ListTile(
        title: Text('Item 1'),
        onTap: () {
          // Actualiza el estado de la aplicación
          // ...
        },
      ),
      ListTile(
        title: Text('Item 2'),
        onTap: () {
          // Actualiza el estado de la aplicación
          // ...
        },
      ),
    ],
  ),
);
```

## 4. Cierra el drawer programáticamente

Después de que un usuario toca un elemento, a menudo queremos cerrar el drawer. ¿Cómo podemos lograr esto? ¡Usando el [Navegador](https://docs.flutter.io/flutter/widgets/Navigator-class.html)!

Cuando un usuario abre el Drawer, Flutter agregará el drawer a la pila de navegación debajo de la cubierta.  Por lo tanto, para cerrar el drawer, podemos llamar a `Navigator.pop(context)`.  

<!-- skip -->
```dart
ListTile(
  title: Text('Item 1'),
  onTap: () {
    // Actualiza el estado de la aplicación
    // ...
    // Luego cierra el drawer 
    Navigator.pop(context);
  },
),
```

## Ejemplo completo

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('My Page!')),
      drawer: Drawer(
        // Agrega un ListView al drawer. Esto asegura que el usuario pueda desplazarse
        // a través de las opciones en el Drawer si no hay suficiente espacio vertical
        // para adaptarse a todo.
        child: ListView(
          // Importante: elimina cualquier padding del ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Actualiza el estado de la aplicación
                // ...
                // Luego cierra el drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // // Actualiza el estado de la aplicación
                // ...
                // Luego cierra el drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

![Drawer Demo](/images/cookbook/drawer.png)
