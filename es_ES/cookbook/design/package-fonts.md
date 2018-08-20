---
layout: page
title: "Exportando fuentes de un paquete"
permalink: /cookbook/design/package-fonts/
---

En lugar de declarar una fuente como parte de nuestra aplicación, podemos declarar una fuente como parte de un paquete separado. Esta es una forma conveniente de compartir la misma fuente a través de varios proyectos diferentes o para desarrolladores que publican sus paquetes en el 
[sitio web de pub](https://pub.dartlang.org/).  

## Instrucciones

  1. Agrega una fuente a un paquete
  2. Agrega el paquete y la fuente a nuestra aplicación
  3. Usa la fuente
  
## 1. Agrega una fuente a un paquete

Para exportar una fuente desde un paquete, necesitamos importar los archivos de fuente en la carpeta `lib` de nuestro paquete del proyecto. Podemos colocar los archivos de fuente directamente en la carpeta `lib` o en un subdirectorio, como `lib/fonts`. 

En este ejemplo, asumiremos que tenemos una biblioteca Flutter llamada 
`awesome_package` con fuentes que viven en una carpeta `lib/fonts`.

```
awesome_package/
  lib/
    awesome_package.dart
    fonts/
      Raleway-Regular.ttf
      Raleway-Italic.ttf
```

## 2. Agrega el paquete y la fuente a nuestra aplicación

Ahora podemos consumir el paquete y usar las fuentes que proporciona. Esto implica actualizar `pubspec.yaml` en el directorio raíz de nuestra *app*. 

### Añade el paquete al proyecto

```yaml
dependencies:
  awesome_package: <latest_version>
```

### Declara los font assets

Ahora que hemos importado el paquete, debemos decirle a Flutter dónde encontrar las fuentes de nuestro `awesome_package`.

Para declarar las fuentes del paquete, debemos prefijar la ruta a la fuente con 
`packages/awesome_package`. Esto le indicará a Flutter que busque en la carpeta `lib` del paquete para la fuente.

```yaml
flutter:
  fonts:
    - family: Raleway
      fonts:
        - asset: packages/awesome_package/fonts/Raleway-Regular.ttf
        - asset: packages/awesome_package/fonts/Raleway-Italic.ttf
          style: italic
```

## 3. Usa la fuente

Podemos usar [`TextStyle`](https://docs.flutter.io/flutter/painting/TextStyle-class.html)
para cambiar la apariencia del texto. Para usar paquetes de fuentes, necesitamos no sólo declarar qué fuente queremos usar, sino también declarar el `package` al que pertenece la fuente. 

<!-- skip -->
```dart
Text(
  'Using the Raleway font from the awesome_package',
  style: TextStyle(
    fontFamily: 'Raleway',
    package: 'awesome_package',
  ),
);
```

## Ejemplo completo

### Fuentes

Las fuentes Raleway y RobotoMono se descargaron de [Google Fonts](https://fonts.google.com/).

### `pubspec.yaml`

```yaml
name: package_fonts
description: Un ejemplo de cómo usar el paquete de fuentes con Flutter

dependencies:
  awesome_package:
  flutter:
    sdk: flutter

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  fonts:
    - family: Raleway
      fonts:
        - asset: packages/awesome_package/fonts/Raleway-Regular.ttf
        - asset: packages/awesome_package/fonts/Raleway-Italic.ttf
          style: italic
  uses-material-design: true
```

### `main.dart`

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Package Fonts',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar utilizará la fuente Raleway predeterminada de la aplicación
      appBar: AppBar(title: Text('Package Fonts')),
      body: Center(
        // Este widget de texto usará la fuente RobotoMono
        child: Text(
          'Using the Raleway font from the awesome_package',
          style: TextStyle(
            fontFamily: 'Raleway',
            package: 'awesome_package',
          ),
        ),
      ),
    );
  }
}
```

![Package Fonts Demo](/images/cookbook/package-fonts.png)

