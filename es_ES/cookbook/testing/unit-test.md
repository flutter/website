---
layout: page
title: "Introducción a la prueba unitaria"
permalink: /cookbook/testing/unit-test/
---

¿Cómo podemos asegurarnos de que nuestras aplicaciones sigan funcionando a medida que agregamos más funciones o cambiamos la funcionalidad existente? ¡Escribiendo pruebas!

Las pruebas unitarias son prácticas para verificar el comportamiento de una sola función, método o clase. El paquete [`test`](https://pub.dartlang.org/packages/test) proporciona el marco principal para escribir pruebas unitarias, y el paquete 
[`flutter_test`](https://docs.flutter.io/flutter/flutter_test/flutter_test-library.html) 
proporciona utilidades adicionales para probar Widgets.

Esta receta demuestra las características principales proporcionadas por el paquete `test` . Para obtener más información sobre el paquete test, por favor consulta la [documentación del paquete test](https://github.com/dart-lang/test/blob/master/README.md).

## Instrucciones

  1. Agrega la dependencia `test` o `flutter_test`
  2. Crea un archivo de prueba
  3. Crea una clase para probarla
  4. Escribe un `test` para nuestra clase
  5. Combina múltiples tests en un `group`
  6. Ejecuta las pruebas

## 1. Agrega la dependencia test

Si estamos trabajando en un paquete Dart que no depende de Flutter, podemos importar el paquete `test` . El paquete test proporciona la funcionalidad principal para escribir pruebas en Dart. 
Este es el mejor enfoque cuando se escriben paquetes que serán consumidos por la web, el servidor y las aplicaciones de Flutter.

```yaml
dev_dependencies:
  test: <latest_version>
```

Si estamos trabajando en un paquete que solo se utilizará para las aplicaciones de Flutter, o si necesitamos escribir Widget tests, podemos confiar en el paquete `flutter_test` . También incluirá todo, desde el paquete `test` , asi como utilidades adicionales para probar Widgets.

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
```


## 2. Crea un archivo de prueba

En este ejemplo, crearemos dos archivos: `counter.dart` y `counter_test.dart`. 

El archivo `counter.dart` contendrá una clase que queremos probar y residirá en la carpeta `lib`  . El archivo `counter_test.dart` contendrá los tests en sí y vivirá dentro de la carpeta de prueba!

En general, los archivos de prueba deben residir dentro de una carpeta `test` ubicada en la raíz de tu aplicación o paquete de Flutter.

Cuando hayamos terminado, nuestra estructura de carpetas debería verse así:

```
counter_app/
  lib/
    counter.dart
  test/
    counter_test.dart
```

## 3. Crea una clase para probarla

Luego, necesitaremos una "unidad" para probar. Recuerde: "unidad" es un nombre elegante para una función, método o clase. En este ejemplo, crearemos una clase `Counter` dentro del archivo
 `lib/counter.dart`. Será responsable de incrementar y disminuir un `value` comenzando en `0`. 

<!-- skip -->
```dart
class Counter {
  int value = 0;
  
  void increment() => value++;
  
  void decrement() => value--; 
}
```

**Nota:** Para simplificar, este tutorial no sigue el enfoque "Test Driven 
Development". Si estás más cómodo con ese estilo de desarrollo, ¡siempre puedes seguir esa ruta!

## 4. Escribe un `test` para nuestra clase

Dentro del archivo `counter_test.dart` , podemos escribir nuestra primera !prueba de unidad! Las pruebas se definen utilizando la función de alto nivel `test`, y podemos verificar si los resultados son correctos utilizando la función de alto nivel `expect` . Ambas funciones provienen del paquete `test` .

<!-- skip -->
```dart
// Importa el paquete test y la clase Counter
import 'package:test/test.dart';
import 'package:counter_app/counter.dart';

void main() {
  test('El contador debe ser incrementado', () {
    final counter = Counter();
    
    counter.increment();
    
    expect(counter.value, 1);
  });
}
```  

## 5. Combina múltiples tests en un `group`

Si tenemos varias pruebas que están relacionadas entre sí, puede ser útil combinarlas utilizando la función `group` proporcionada por el paquete `test` .

<!-- skip -->
```dart
import 'package:test/test.dart';
import 'package:counter_app/counter.dart';

void main() {
  group('Counter', () {
    test('el valor debe iniciar en 0', () {
      expect(Counter().value, 0);
    });
    
    test('el valor debe ser incrementado', () {
      final counter = Counter();
        
      counter.increment();
        
      expect(counter.value, 1);
    });
    
    test('el valor debe ser decrementado', () {
      final counter = Counter();
        
      counter.decrement();
        
      expect(counter.value, -1);
    });
  });
}
```

### 6. Ejecuta las pruebas

Ahora que tenemos una clase `Counter` con pruebas en sitio, ¡podemos ejecutarlas! 

#### Ejecuta las pruebas usando el IDE IntelliJ o VSCode 

Los plugins de Flutter para IntelliJ y VSCode admiten pruebas de ejecución. Esta suele ser la mejor opción al escribir pruebas porque proporciona el ciclo de retroalimentación más rápido y la capacidad de establecer breakpoints.

  * **IntelliJ** 
    1. Abre el archivo `counter_test.dart` 
    2. Selecciona el menú `Run` 
    3. Haz clic en la opción `Run 'tests en counter_test.dart'` 
    4. *Alternativamente, utiliza el atajo de teclado apropiado para tu plataforma!*
  * **VSCode**
    1. Abre el archivo `counter_test.dart` 
    2. Selecciona el menú `Debug` 
    3. Haz clic en la opción `Start Debugging` 
    4. *Alternativamente, utiliza el atajo de teclado apropiado para tu plataforma!*

#### Ejecuta las pruebas en una terminal

También podemos usar una terminal para ejecutar nuestras pruebas ejecutando el siguiente comando desde la raíz del proyecto:

```
flutter test test/counter_test.dart
```
