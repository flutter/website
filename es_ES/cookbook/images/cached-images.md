---
layout: page
title: "Trabajando con imágenes en caché"
permalink: /cookbook/images/cached-images/
---

En algunos casos, puede ser útil almacenar en caché las imágenes a medida que se descargan de la web para que puedan usarse sin conexión. Para este propósito, emplearemos el paquete  
[`cached_network_image`](https://pub.dartlang.org/packages/cached_network_image)
.

Además del almacenamiento en caché, el paquete cached_image_network también admite  
placeholders e imágenes que se van desvaneciendo a medida que se cargan.

<!-- skip -->
```dart
CachedNetworkImage(
  imageUrl: 'https://github.com/flutter/website/blob/master/_includes/code/layout/lakes/images/lake.jpg?raw=true',
);
```

## Agrega un placeholder

¡El paquete `cached_network_image` nos permite usar cualquier Widget como placeholder! 
En este ejemplo, mostraremos un spinner mientras se carga la imagen.

<!-- skip -->
```dart
CachedNetworkImage(
  placeholder: CircularProgressIndicator(),
  imageUrl: 'https://github.com/flutter/website/blob/master/src/_includes/code/layout/lakes/images/lake.jpg?raw=true',
);
``` 

## Ejemplo completo

<!-- skip -->
```dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Imágenes en caché';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: CachedNetworkImage(
            placeholder: CircularProgressIndicator(),
            imageUrl:
                'https://github.com/flutter/website/blob/master/src/_includes/code/layout/lakes/images/lake.jpg?raw=true',
          ),
        ),
      ),
    );
  }
}
```
