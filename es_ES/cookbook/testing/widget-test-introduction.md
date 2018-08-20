---
layout: page
title: "Introducción a la prueba de Widget"
permalink: /cookbook/testing/widget-test-introduction/
---

En el curso [introducción a las pruebas unitarias](/cookbook/testing/unit-test/), aprendimos 
como probar las clases Dart usando el paquete `test`. Con el fin de probar las clases 
Widget, necesitaremos un poco de herramientas adicionales proporcionadas por el paquete 
[`flutter_test`](https://docs.flutter.io/flutter/flutter_test/flutter_test-library.html), el cual 
viene con el SDK de Flutter.

El paquete `flutter_test` provee las siguientes herramientas para probar los Widgets:

  * La clase [`WidgetTester`](https://docs.flutter.io/flutter/flutter_test/WidgetTester-class.html), 
  nos permite construir e interactuar con los Widgets en un entorno de pruebas.
  * La función [`testWidgets`](https://docs.flutter.io/flutter/flutter_test/testWidgets.html). Esta 
  función creará automáticamente un nuevo `WidgetTester` por 
  cada caso de prueba, y es utilizada en lugar de la función normal `test`. 
  * Clases [`Finder`](https://docs.flutter.io/flutter/flutter_test/Finder-class.html). Nos permiten 
  buscar por Widgets en el entorno de pruebas.  
  * Las constantes [`Matcher`](https://docs.flutter.io/flutter/package-matcher_matcher/Matcher-class.html) 
  específicas de los Widget, que nos ayudan a verificar si un `Finder` localiza un Widget o múltiples Widgets en el entorno de pruebas.
  
Si esto suena abrumador, ¡no se preocupe! Veremos como todas esas piezas encajan juntas a través de este curso.
  
### Direcciones

  1. Agregue la dependencia `flutter_test` 
  2. Cree un Widget para probar
  3. Cree una prueba `testWidgets` 
  4. Construya el Widget utilizando el `WidgetTester`
  5. Busque nuestro Widget usando un `Finder`
  6. Verifique que nuestro Widget esté trabajando usando un `Matcher`
  
### 1. Agregue la dependencia `flutter_test`

Antes de que podamos comenzar a escribir pruebas, necesitaremos incluir la dependencia, `flutter_test` 
en la sección `dev_dependencies` de nuestro archivo `pubspec.yaml`. Si crea un nuevo proyecto 
Flutter con las herramientas de línea de comando o el editor de código, esta dependencia ya debería estar en su lugar!

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
```
    
### 2. Cree un Widget para probar

A continuación, ¡tendremos que crear un widget que podamos probar! Para este procedimiento, 
crearemos un Widget que muestra un `title` y un `message`. 

```dart
class MyWidget extends StatelessWidget {
  final String title;
  final String message;

  const MyWidget({
    Key key,
    @required this.title,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text(message),
        ),
      ),
    );
  }
}
``` 

### 3. Cree una prueba `testWidgets`

Ahora que tenemos un Widget para probar, ¡podemos comenzar a escribir nuestra primera prueba! Para comenzar, usaremos la función
[`testWidgets`](https://docs.flutter.io/flutter/flutter_test/testWidgets.html) 
proporcionada por el paquete `flutter_test` para definir una prueba. La función `testWidgets` nos permitirá definir un Widget de prueba y creará un `WidgetTester` para que podamos trabajar con él.

Nuestra prueba verificará que `MyWidget` muestre el título y el mensaje especificado.

<!-- skip -->
```dart
void main() {
  // Define una prueba. la función TestWidgets también proporcionará un WidgetTester
  // para que podamos trabajar con él. El WidgetTester nos permitirá construir e interactuar
  // con Widgets en el entorno de pruebas.   
  testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
    // Test code will go here!
  });
}
```

### 4. Construya el Widget usando el `WidgetTester`

A continuación, queremos compilar `MyWidget` dentro del entorno de prueba. Para hacerlo, podemos usar el método
[`pumpWidget`](https://docs.flutter.io/flutter/flutter_test/WidgetTester/pumpWidget.html) 
proporcionado por`WidgetTester`. El método `pumpWidget` creará y renderizará el Widget que proporcionamos.

En este caso, crearemos una instancia de `MyWidget` que muestre "T" como título y "M" como mensaje.

<!-- skip -->
```dart
void main() {
  testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
    // Crea el Widget y le dice al tester que lo construya
    await tester.pumpWidget(MyWidget(title: 'T', message: 'M'));
  });
}
```

#### Nota

Después de la llamada inicial a `pumpWidget`, el `WidgetTester` proporciona formas adicionales 
para reconstruir el mismo Widget. Esto es útil si se está trabajando con un `StatefulWidget` o animaciones. 

Por ejemplo, si tocamos un botón y este botón llama a `setState`, Flutter no reconstruirá automáticamente su Widget en el entorno de prueba. Necesitamos usar uno de los siguientes métodos para pedirle a Flutter que cree nuestro Widget una vez más. 

  - [tester.pump()](https://docs.flutter.io/flutter/flutter_test/TestWidgetsFlutterBinding/pump.html) 
  : Dispara la reconstrucción del widget después de una duración determinada.
  - [tester.pumpAndSettle()](https://docs.flutter.io/flutter/flutter_test/WidgetTester/pumpAndSettle.html) 
  : Repetidamente llama a pump con la duración dada hasta que ya no exista ningún frame programado. Esto esencialmente espera a que se completen todas las animaciones.

Estos métodos proporcionan un control detallado sobre el ciclo de vida de la construcción, lo cual es particularmente útil durante las pruebas.

### 5. Busque nuestro Widget usando un `Finder`

Ahora que hemos creado nuestro Widget en el entorno de prueba, queremos buscar en el árbol de widgets el Text Widget `title` y el `message` utilizando un `Finder`. Esto nos permitirá verificar que ¡estamos mostrando esos Widgets correctamente!

En este caso, usaremos el método de alto nivel [`find`](https://docs.flutter.io/flutter/flutter_test/find-constant.html) 
proporcionado por el paquete `flutter_test` para crear nuestros `Finders`. Como sabemos que estamos buscando los 
widgets `Text`, podemos usar el método
[`find.text`](https://docs.flutter.io/flutter/flutter_test/CommonFinders-class.html).

Para más información acerca de las clases `Finder`, por favor vea el curso [Buscando Widgets en un Widget Test](/cookbook/testing/widget-test-finders/). 

<!-- skip -->
```dart
void main() {
  testWidgets('MyWidget tiene un título y un mensaje', 
     (WidgetTester tester) async {
    await tester.pumpWidget(MyWidget(title: 'T', message: 'M'));
    
    // Crear nuestros Finders
    final titleFinder = find.text('T');
    final messageFinder = find.text('M');
  });
}
```

### 6. Verificar que nuestro Widget este trabajando usando un `Matcher`

Finalmente, podemos verificar que los `Text` Widgets, title y message aparecen en la pantalla utilizando la constante `Matcher` proporcionada por `flutter_test`. Las clases `Matcher` son una parte fundamental del paquete `test`, y proporcionan una forma común de verificar que un valor determinado cumpla con nuestras expectativas. 

En este caso, queremos asegurarnos de que nuestros Widgets aparezcan en la pantalla exactamente una vez. Por lo tanto, podemos usar el `Matcher` 
[`findsOneWidget`](https://docs.flutter.io/flutter/flutter_test/findsOneWidget-constant.html).

<!-- skip -->
```dart
void main() {
  testWidgets('MyWidget tiene un título y un mensaje',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyWidget(title: 'T', message: 'M'));
    final titleFinder = find.text('T');
    final messageFinder = find.text('M');

    // Use el matcher `findsOneWidget` proporcionado por flutter_test para verificar que
    // nuestros Text Widgets aparezcan exactamente una vez en el Widget tree
    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });
}
```

#### Matchers adicionales

Además de `findsOneWidget`, `flutter_test` proporciona matchers adicionales para casos comunes.

  * [findsNothing](https://docs.flutter.io/flutter/flutter_test/findsNothing-constant.html)
 : verifica que no se encuentren Widgets
  * [findsWidgets](https://docs.flutter.io/flutter/flutter_test/findsWidgets-constant.html)
  : verifica que uno o más Widgets sean encontrados
  * [findsNWidgets](https://docs.flutter.io/flutter/flutter_test/findsNWidgets.html)
  : verifica que un número especifico de Widgets sea encontrado

### Ejemplo completo 

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Define una prueba. La función TestWidgets también proporcionará un WidgetTester
  // para que podamos trabajar con él. El WidgetTester permitirá construir e interactuar
  // con Widgets en el entorno de prueba.
  testWidgets('MyWidget tiene un título y un mensaje',
      (WidgetTester tester) async {
    // Crear el Widget, le dice al tester que lo construya
    await tester.pumpWidget(MyWidget(title: 'T', message: 'M'));

    // Crea nuestros Finders
    final titleFinder = find.text('T');
    final messageFinder = find.text('M');

    // Use el matcher `findsOneWidget` proporcionado por flutter_test para verificar que
    // nuestros Text Widgets aparezcan exactamente una vez en el Widget tree
    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });
}

class MyWidget extends StatelessWidget {
  final String title;
  final String message;

  const MyWidget({
    Key key,
    @required this.title,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text(message),
        ),
      ),
    );
  }
}
```
