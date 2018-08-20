---
layout: page
title: Probando Apps en Flutter
permalink: /testing/
---

* TOC
{:toc}

## Introducción

Mientras más funciones tenga tu app, mas difícil será probarla manualmente. Un
buen conjunto de pruebas automatizadas te ayudarán a asegurarte que tu app funcione 
correctamente antes de publicarla, mientras conservas tus funciones y corriges errores a mayor
velocidad.

Existen varios tipos de pruebas automáticas. A continuación verás un resumen:

- Una _unit test_ prueba una sola función, método o clase. Dependencias externas
  de la unidad bajo prueba son generalmente imitadas utilizando, por ejemplo, 
  [`package:mockito`](https://github.com/dart-lang/mockito).
  Las pruebas unitarias generalmente no leen de/o escriben al disco, renderizan a pantalla y no
  reciben acciones de usuario fuera del proceso de prueba. El objetivo
  de una prueba unitaria es para verificar lo correcto de una unidad de lógica bajo una 
  variedad de condiciones.
- Un _widget test_ (en otros frameworks de UI se refieren a ellas como _component test_) prueba
  un solo widget. Probando un widget incluye clases múltiples y requiere una
  prueba de entorno el cual provee el widget apropiado para el ciclo de vida del contexto. Por
  ejemplo, debe ser capaz de responder y recibir acciones de usuario y eventos,
  realizar diseño e instancias widget hijos. Una prueba de widget es 
  por lo tanto, más completa que una prueba unitaria. Sin embargo, al igual que una 
  prueba unitaria, el entorno de una prueba de widgets se reemplaza por una implementación mucho más simple 
  que un sistema UI completo. El objetivo de una prueba de widget es verificar que la IU del widget se vea e interactúe como se espera.
- Un [_integration test_](https://en.wikipedia.org/wiki/Integration_testing)
  prueba un app completa o una gran parte de la app. Generalmente una
  _integration test_ se ejecuta en el dispositivo real o en el simulador, como iOS
  o emulador de Android. La aplicación bajo prueba generalmente está aislada del código 
  del controlador de prueba para evitar sesgar los resultados. El objetivo de una 
  prueba de integración es verificar que la aplicación funcione correctamente como un todo, 
  que todos los widgets de los que está compuesta se integren entre sí como se espera. También 
  puede usar sus pruebas de integración para verificar el rendimiento de su aplicación.

Aquí hay una tabla que resume las ventajas y desventajas relacionadas con la elección entre 
diferentes tipos de pruebas:

{: .flutter-table}

|                            | Unit   | Widget | Integration |
|----------------------------|--------|--------|-------------|
| **Confianza**              | Low    | Higher | Highest     |
| **Costo de mantenimiento** | Low    | Higher | Highest     |
| **Dependencias**           | Few    | More   | Lots        |
| **Rapidez de ejecución**   | Quick  | Slower | Slowest     |
|                            |        |        |             |

**Consejo**: Como regla general, una aplicación bien probada tiene un número muy alto de unidades
y pruebas de widgets, rastreadas por [cobertura de código](https://en.wikipedia.org/wiki/Code_coverage),
y un buen número de pruebas de integración cubriendo todos los escenarios de usos importantes.


## Pruebas Unitarias

Algunas bibliotecas de Flutter, tal como `dart:ui`, no están disponible en la standalone
Dart VM el cual viene con el SDK predeterminado de Dart. El comando `flutter test` permite
ejecutar tus pruebas en un Dart VM local con una versión sin encabezado de el motor de
Flutter, el cual suministra estas bibliotecas. Utilizando este comando puedes ejecutar cualquier prueba,
si depende de las bibliotecas de Flutter o no.

Escribe una prueba unitaria de Flutter como una prueba normal `package:test`. Escribir pruebas
unitarias utilizando `package:test` está documentado [aquí](https://github.com/dart-lang/test/blob/master/README.md).

Ejemplo:

Añade este archivo a `test/unit_test.dart`:

{% prettify dart %}
import 'package:test/test.dart';

void main() {
  test('my first unit test', () {
    /**highlight*/var answer = 42;/*-highlight*/
    expect(answer, 42);
  });
}
{% endprettify %}

Adicionalmente, añade el siguiente bloque a tu `pubspec.yaml`:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
```

(Esto se necesita aún si tu prueba no importa en si misma explícitamente 
`flutter_test`, por qué el mismo framework de prueba lo utiliza detrás 
de escena.)

Para ejecutar la prueba, ejecuta `flutter test test/unit_test.dart` desde el
directorio de proyecto (no desde el subdirectorio de `test` ).

Para correr todas las pruebas, ejecuta `flutter test` desde el directorio del proyecto.


## Pruebas de Widget

Implementa una prueba de widget de forma similar a una prueba unitaria. Para realizar 
una interacción con un widget en su prueba, use el
[`WidgetTester`](https://docs.flutter.io/flutter/flutter_test/WidgetTester-class.html)
utilidad que provee Flutter. Por ejemplo, puedes enviar gesticulaciones de tap y 
scroll. También puedes usar
[`WidgetTester`](https://docs.flutter.io/flutter/flutter_test/WidgetTester-class.html)

Para encontrar child widgets en el árbol de widgets, leer texto y verificar que los 
valores de las propiedades del widget sean correctos.

Ejemplo:

Añade este archivo a `test/widget_test.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('my first widget test', (WidgetTester tester) async {
    // Puedes usar keys para localizar el widget que necesitas probar
    var sliderKey = UniqueKey();
    var value = 0.0;

    // Dice al test que construya una UI basada en el árbol de widgets que se le ha pasado
    await tester.pumpWidget(
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return MaterialApp(
            home: Material(
              child: Center(
                child: Slider(
                  key: sliderKey,
                  value: value,
                  onChanged: (double newValue) {
                    setState(() {
                      value = newValue;
                    });
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
    expect(value, equals(0.0));

    // Hace Tap en el widget encontrado por su key
    await tester.tap(find.byKey(sliderKey));

    // Verifica que el widget se actualiza el valor correctamente
    expect(value, equals(0.5));
  });
}
```

Ejecuta `flutter test test/widget_test.dart`.

Vea [`package:flutter_test` API](https://docs.flutter.io/flutter/flutter_test/flutter_test-library.html)
para todas las utilidades disponibles para pruebas de widgets.

Para ayudar a depurar las pruebas de widget, puedes utilizar la función [`debugDumpApp()`](https://docs.flutter.io/flutter/widgets/debugDumpApp.html) para visualizar el estado de UI de tu prueba o simplemente `flutter run test/widget_test.dart` para ver tus pruebas ejecutarse en tu entorno de ejecución preferido tal como un simulador o un dispositivo. Durante una sesión `flutter run` en una prueba de widgets, también puede interactivamente tocar partes de la pantalla para la herramienta Flutter para imprimir las sugerencias [`Finder`](https://docs.flutter.io/flutter/flutter_test/CommonFinders-class.html).


## Pruebas de integración

Una prueba de integración de Flutter también se escribe utilizando `package:test`. Una prueba completa 
es un par - un script de prueba y una aplicación Flutter instrumentadas para recibir comandos 
de la prueba. A diferencia de las pruebas de unidad y widget, el código de prueba de integración 
no se ejecuta en el mismo proceso que la aplicación que se está probando. En cambio, 
la aplicación probada se inicia en _dispositivo real_ o en un _emulador_ (por ejemplo el emulador de Android o simulador de iOS). El script de prueba se ejecuta en su computadora. Se conecta 
a la aplicación y emite comandos a la aplicación para realizar diversas acciones del usuario. 
Esto se conoce como "conducir" la aplicación. Flutter proporciona herramientas y API, 
denominados colectivamente como _Flutter Driver_, para hacer justamente eso.

> Si has trabajado con Selenium/WebDriver (web), Espresso (Android) or UI
> Automation (iOS), entonces Flutter Driver es el equivalente en Flutter para aquellas
> herramientas de pruebas de integración. Adicionalmente, Flutter Driver proveé una API para
> registrar trazas de rendimiento (conocido como el _timeline_) de las acciones realizadas.
> por la prueba.

Flutter Driver es:

* una herramienta de línea de comando `flutter drive`
* un paquete `package:flutter_driver` ([API](https://docs.flutter.io/flutter/flutter_driver/FlutterDriver-class.html))

Juntos, estos dos te permiten:

* crear una aplicación instrumentada para pruebas de integración
* escribir una prueba
* ejecutar una prueba

### Agregar la dependencia flutter_driver

Para utilizar `flutter_driver`, deberás agregar el siguiente bloque a tu `pubspec.yaml`:

```yaml
dev_dependencies:
  flutter_driver:
    sdk: flutter
```

### Creando apps instrumentadas con Flutter

Una aplicación instrumentada es una aplicación Flutter que tiene la _extensión_ Flutter 
Driver habilitado. Para habilitar la extensión se llama `enableFlutterDriverExtension()`.

Ejemplo:

Supongamos que tienes una aplicación con el punto de entrada en
`my_app/lib/main.dart`. Para crear una versión instrumentada, cree un archivo 
Dart en `my_app/test_driver/`. Nómbrelo después acorde a la función que esté probando; 
vamos por `user_list_scrolling.dart` ubicado en `my_app/test_driver/`:

```dart
// Esta línea importa la extensión
import 'package:flutter_driver/driver_extension.dart';

void main() {
  // Esta línea habilita la extensión
  enableFlutterDriverExtension();

  // Llama a main() de tu app o llama runApp con el widget que sea que estas interesado en probar.
}
```

### Escribiendo pruebas de integración

Una prueba de integración es una prueba simple `package:test` que usa la 
API de Flutter Driver para indicar a la aplicación qué hacer y luego verifica que la aplicación
lo hizo.

Ejemplo:

Solo por diversión, hagamos que nuestra prueba registre la línea de tiempo de rendimiento. Creemos
un archivo de prueba `user_list_scrolling_test.dart` localizado en `my_app/test_driver/`:

```dart
import 'dart:async';

// Importamos la API Driver de Flutter
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('scrolling performance test', () {
    FlutterDriver driver;

    setUpAll(() async {
      // Conectamos con la app
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        // Cerramos la conexión
        driver.close();
      }
    });

    test('measure', () async {
      // Registra el timeline del rendimiento de aquellas cosas que ocurren dentro del closure
      Timeline timeline = await driver.traceAction(() async {
        // Encuentra la lista de usuarios scrollable
        SerializableFinder userList = find.byValueKey('user-list');

        // Hace scroll hacia abajo 5 veces
        for (int i = 0; i < 5; i++) {
          // Hace scroll de 300 pixels abajo, durante 300 milisegundos
          await driver.scroll(
              userList, 0.0, -300.0, Duration(milliseconds: 300));

          // Simula el dedo de un usuario tomándose su tiempo para volver atrás a la posición original 
          // antes de hacer scroll de nuevo

          await Future<Null>.delayed(Duration(milliseconds: 500));
        }

        // Hace scroll hacia arriba 5 veces
        for (int i = 0; i < 5; i++) {
          await driver.scroll(
              userList, 0.0, 300.0, Duration(milliseconds: 300));
          await Future<Null>.delayed(Duration(milliseconds: 500));
        }
      });

      // El objeto timeline contiene todos los datos de rendimiento registrados 
      // durante la sesión de scroll. Se puede interpretar valores útiles, 
      // como "tiempo medio de construcción del frame"

      TimelineSummary summary = TimelineSummary.summarize(timeline);

      // Las siguientes líneas guardan el sumario del timeline a un fichero JSON
      summary.writeSummaryToFile('scrolling_performance', pretty: true);

      // La siguiente línea guarda los datos crudos del timeline como un JSON.
      summary.writeTimelineToFile('scrolling_performance', pretty: true);
    });
  });
}
```

### Ejecutando pruebas de integración

Para ejecutar la prueba en un dispositivo Android, conecte el dispositivo a través de USB a su
computadora y habilite la depuración de USB. Luego ejecuta el siguiente comando:

```
flutter drive --target=my_app/test_driver/user_list_scrolling.dart
```

Este comando:

* construye la app `--target` y la instala en el dispositivo
* lanza la app
* ejecuta la prueba `user_list_scrolling_test.dart` localizada en `my_app/test_driver/`

Es posible que se pregunte cómo el comando encuentra el archivo de prueba correcto. El
comando `flutter drive` usa una convención para buscar el archivo de prueba en el mismo
directorio que la app instrumentada `--target` que tenga el mismo nombre de archivo pero 
con el sufijo de `_test` en el.

## Integración continua y pruebas

Para obtener información sobre implementación y pruebas continuas, consulte:

* [Entrega continua usando Fastlane con Flutter](/fastlane-cd/)
* [Probar Flutter apps en Travis](https://medium.com/flutter-io/test-flutter-apps-on-travis-3fd5142ecd8c)
* Probando app de Flutter con [GitLab
  CI](https://docs.gitlab.com/ee/ci/README.html#doc-nav). Necesitarás crear y configurar un
  archivo `.gitlab-ci.yml`. Puedes [encontrar un ejemplo](https://raw.githubusercontent.com/brianegan/flutter_redux/master/.gitlab-ci.yml)
  en la [biblioteca flutter_redux](https://github.com/brianegan/flutter_redux).
