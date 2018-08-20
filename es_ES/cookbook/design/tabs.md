---
layout: page
title: "Trabajando con Pestañas"
permalink: /cookbook/design/tabs/
---

Trabajar con pestañas es un patrón común en las aplicaciones siguiendo las pautas de Material Design. Flutter incluye una forma conveniente de crear diseños de pestañas como parte de la  [biblioteca de materiales](https://docs.flutter.io/flutter/material/material-library.html).

## Instrucciones

  1. Crea un `TabController`
  2. Crea las pestañas
  3. Crea el contenido para cada pestaña

## 1. Crea un `TabController`

Para que las pestañas funcionen, necesitaremos mantener sincronizadas las secciones de pestañas y contenido seleccionadas. Este es el trabajo de [`TabController`](https://docs.flutter.io/flutter/material/TabController-class.html).

Podemos crear manualmente un `TabController` o usar el Widget 
[`DefaultTabController`](https://docs.flutter.io/flutter/material/DefaultTabController-class.html). Usar `DefaultTabController` es la opción más simple, ya que creará un `TabController` para nosotros y lo pondrá a disposición de todos los Widgets descendientes.

<!-- skip -->
```dart
DefaultTabController(
  // La cantidad de pestañas / secciones de contenido que necesitamos mostrar
  length: 3,
  child: // ¡Mira el siguiente paso!
);
```

## 2. Crea las pestañas

Ahora que tenemos un `TabController` para trabajar, podemos crear nuestras pestañas usando el Widget [`TabBar`](https://docs.flutter.io/flutter/material/TabController-class.html). En este ejemplo, crearemos un `TabBar` con 3 Widgets [`Tab`](https://docs.flutter.io/flutter/material/Tab-class.html) y lo colocaremos dentro de un [`AppBar`](https://docs.flutter.io/flutter/material/AppBar-class.html).

<!-- skip -->
```dart
DefaultTabController(
  length: 3,
  child: Scaffold(
    appBar: AppBar(
      bottom: TabBar(
        tabs: [
          Tab(icon: Icon(Icons.directions_car)),
          Tab(icon: Icon(Icons.directions_transit)),
          Tab(icon: Icon(Icons.directions_bike)),
        ],
      ),
    ),
  ),
);
```

Por defecto, `TabBar` busca en el árbol de Widgets el `DefaultTabController` más cercano. Si estás creando manualmente un `TabController`, deberás pasarlo al `TabBar`.

## 3. Crea el contenido para cada pestaña

Ahora que tenemos pestañas, queremos mostrar el contenido cuando se seleccione una pestaña. 
Para este propósito, emplearemos el Widget [`TabBarView`](https://docs.flutter.io/flutter/material/TabBarView-class.html).

*Nota:* ¡El orden es importante y debe corresponder al orden de las pestañas en el 
`TabBar`!

<!-- skip -->
```dart
TabBarView(
  children: [
    Icon(Icons.directions_car),
    Icon(Icons.directions_transit),
    Icon(Icons.directions_bike),
  ],
);
```

## Ejemplo completo

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(TabBarDemo());
}

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: Text('Demo de Pestañas'),
          ),
          body: TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
```

![Tabs Demo](/images/cookbook/tabs.gif)
