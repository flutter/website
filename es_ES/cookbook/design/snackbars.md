---
layout: page
title: "Mostrando SnackBars"
permalink: /cookbook/design/snackbars/
---

En algunos casos, puede ser útil informar brevemente a nuestros usuarios cuando ciertas acciones
se llevan a cabo. Por ejemplo, cuando un usuario borra un mensaje de una lista, es posible que 
desees informarles que el mensaje ha sido borrado. Puede que incluso queramos darle 
una opción para ¡deshacer la acción! 

En Material Design, este es el trabajo de un [SnackBar](https://docs.flutter.io/flutter/material/SnackBar-class.html).

## Instrucciones

  1. Crea un `Scaffold`
  2. Muestra un `SnackBar`
  3. Proporciona una acción adicional
  
## 1. Crea un `Scaffold`

Cuando creamos aplicaciones que siguen las directrices de Material Design, queremos dar a nuestras aplicaciones una estructura visual consistente. En este caso, necesitaremos mostrar el SnackBar en la parte inferior de la pantalla, ¡sin solapar otros Widgets importantes, como el `FloatingActionButton`!

El Widget [Scaffold](https://docs.flutter.io/flutter/material/Scaffold-class.html)
de la [biblioteca Material](https://docs.flutter.io/flutter/material/material-library.html) crea esta estructura visual para nosotros y asegura que los Widgets importantes ¡no se superpongan!

<!-- skip -->
```dart
Scaffold(
  appBar: AppBar(
    title: Text('SnackBar Demo'),
  ),
  body: SnackBarPage(), // ¡Lo completaremos a continuación!
);
```

## 2. Muestra un `SnackBar`

Con el `Scaffold` en su lugar, ¡podemos mostrar un `SnackBar`! Primero necesitamos crear un `SnackBar`, luego mostrarlo usando el `Scaffold`.

<!-- skip -->
```dart
final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));

// Encuentra el Scaffold en el árbol de widgets y ¡úsalo para mostrar un SnackBar!
Scaffold.of(context).showSnackBar(snackBar);
```

## 3. Proporciona una acción adicional

En algunos casos, es posible que queramos proporcionar una acción adicional al usuario cuando se muestre la SnackBar. Por ejemplo, si han eliminado accidentalmente un mensaje, podemos ofrecer una acción para deshacer ese cambio.

Para lograr esto, podemos proporcionar un `action` adicional al Widget `SnackBar` .

```dart
final snackBar = SnackBar(
  content: Text('Yay! A SnackBar!'),
  action: SnackBarAction(
    label: 'Undo',
    onPressed: () {
      // Algo de código para ¡deshacer el cambio!
    },
  ),
);
``` 

## Ejemplo completo 

Nota: En este ejemplo, mostraremos un SnackBar cuando un usuario pulse un botón.
Para obtener más información sobre cómo trabajar con las entradas del usuario, por favor consulta la sección 
[Manejando Gestos](/cookbook/#manejando-gestos) del Cookbook.

```dart
import 'package:flutter/material.dart';

void main() => runApp(SnackBarDemo());

class SnackBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnackBar Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('SnackBar Demo'),
        ),
        body: SnackBarPage(),
      ),
    );
  }
}

class SnackBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: Text('Yay! A SnackBar!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Algo de código para ¡deshacer el cambio!
              },
            ),
          );

          // Encuentra el Scaffold en el árbol de widgets y ¡úsalo para mostrar un SnackBar!
          Scaffold.of(context).showSnackBar(snackBar);
        },
        child: Text('Show SnackBar'),
      ),
    );
  }
}
```

![SnackBar Demo](/images/cookbook/snackbar.gif)
