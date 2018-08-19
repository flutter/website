---
layout: page
title: "Mostrar imágenes desde internet"
permalink: /cookbook/images/network-image/
---

Mostrar imágenes es fundamental para la mayoría de las aplicaciones móviles. Flutter proporciona el widget de 
[`Image`](https://docs.flutter.io/flutter/widgets/Image-class.html) para mostrar diferentes tipos de imágenes.

Para trabajar con imágenes desde una URL, usa el constructor [`Image.network`](https://docs.flutter.io/flutter/widgets/Image/Image.network.html).

<!-- skip -->
```dart
Image.network(
  'https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg',
)
```

## Bono: Gifs animados

Una cosa increíble sobre el widget `Image` : ¡también es compatible con los gifs animados listos para usar!

<!-- skip -->
```dart
Image.network(
  'https://github.com/flutter/plugins/raw/master/packages/video_player/doc/demo_ipod.gif?raw=true',
);
```

## Marcadores de posición y almacenamiento en caché

El constructor predeterminado de `Image.network` no maneja una funcionalidad más avanzada, como el desvanecimiento de imágenes después de cargarlas o el almacenamiento en caché de las imágenes en el dispositivo una vez que se han descargado. Para lograr estas tareas, por favor consulte las siguientes recetas:

  * [Fundido en imágenes con un marcador de posición](/cookbook/images/fading-in-images/)
  * [Trabajando con imágenes en caché](/cookbook/images/cached-images/) 

## Ejemplo completo

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var title = 'Imágenes Web';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Image.network(
          'https://github.com/flutter/website/blob/master/_includes/code/layout/lakes/images/lake.jpg?raw=true',
        ),
      ),
    );
  }
}
```

![Network Image Demo](/images/cookbook/network-image.png)
