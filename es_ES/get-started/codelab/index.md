---
layout: tutorial
title: Escribe tu primer app en Flutter
permalink: /get-started/codelab/
image: /get-started/codelab/images/step7-themes.png
---

<figure class="right-figure" style="max-width: 260px; padding-right: 10px">
    <img src="images/startup-namer-app.gif"
         alt="Animated GIF of the app that you will be building."
         style="border: 10px solid #333; border-radius: 10px; margin-bottom: 10px" >
</figure>

Esta es una guiá para crear tu primera app en Flutter. Si la
programación orientada a objetos y conceptos básicos
de programación como variables, ciclos y condicionales
podrás completar este tutorial. No se necesita
experiencia previa con Dart o programación móvil.

{% comment %}
TODO: (maybe, but later)
- Retake screenshots on the Android emulator? (Tao)
  Maybe alternate between Android and iOS emulators?
- Somehow cross link from code to text so people can restart
  and find their place more easily? (Tao)
{% endcomment %}

* TOC
{:toc}

## Qué haremos
{:.no_toc}

Se implementará una app móvil sencilla que generará nombres propuestos para un
empresa que inicia. El usuario puede seleccionar o deseleccionar nombres,
almacenando los mejores. El código genera nombres de diez en diez.
A medida que el usuario se desplaza por la pantalla, nuevos juegos de nombres son generados.
El usuario puede puede tocar el icono de lista en la orilla superior derecha en la barra de la app
para moverse a una nueva ruta que muestra únicamente los nombre favoritos.

El GIF animado muestra como se verá el producto terminado.

<div class="whats-the-point" markdown="1">
  <h4>Que aprenderemos</h4>

  * Estructura básica de una app en Flutter.
  * Encontrar y utilizar paquetes para extender funcionalidades.
  * Usar hot reload para un ciclo de desarrollo más rápido.
  * Cómo implementar un "stateful widget".
  * Cómo crear una lista de carga lenta e infinita.
  * Cómo crear y navegar a una segunda pantalla.
  * Cómo cambiar el estilo de una app utilizando "Themes".
</div>

<div class="whats-the-point" markdown="1">
  <h4>Qué usaremos</h4>

  Necesitaremos instalar lo siguiente:

  - Flutter SDK<br>
    El SDK de Flutter incluye el motor de Flutter, framework, widgets, herramientas,
    y un SDK de Dart. Este laboratorio necesita v0.1.4 o superior.

  - Android Studio IDE<br>
    Este laboratorio utiliza el IDE de Android Studio, Pero puedes utilizar otro
    IDE, o trabajar de la linea de comandos.

  - Complementos para el IDE<br>
    Los complementes de Flutter y Dart deber ser instalado por separado para el
    IDE. Ademas Android Studio, los complementos Flutter y Dart también están disponibles
    para los IDEs [VS Code](https://code.visualstudio.com/download) e
    [IntelliJ](https://www.jetbrains.com/idea/download/#section=mac).

  Vea [Instalación y configuración de Flutter](/get-started/install/) para mas información de
  como configurar el ambiente de trabajo.
</div>

# Paso 1: Crear la app inicial de Flutter

Crear un app sencilla desde una plantilla de Flutter, utilizando las instrucciones en
[Iniciando con tu primer app de Flutter.](/get-started/test-drive/#create-app)
Nombre del proyecto **startup_namer** (en lugar de _myapp_).
Modificaras esta app de inicial para crear el app final.

En este laboratorio, mayormente estarás editando **lib/main.dart**,
donde el código Dart vive.

{{site.alert.tip}}
  Cuando se pega código dentro de tu app, los margenes pueden
  moverse. Puedes corregir esto automáticamente con las herramientas de Flutter:

  * Android Studio / IntelliJ IDEA: Clic derecho en el código Dart 
  y elige **Reformat Code with dartfmt**.
  * VS Code: Clic derecho y seleccionar **Format Document**.
  * Terminal: Ejecuta el comando `flutter format <filename>`.
{{site.alert.end}}

 1. Reemplaza `lib/main.dart`.<br>
    Borra todo el código de **lib/main.dart**.
    Reemplaza con el siguiente código, el cual muestra "Hello World" en el centro
    de la pantalla. 

    ```dart
    import 'package:flutter/material.dart';

    void main() => runApp(MyApp());

    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Welcome to Flutter',
          home: Scaffold(
            appBar: AppBar(
              title: Text('Welcome to Flutter'),
            ),
            body: Center(
              child: Text('Hello World'),
            ),
          ),
        );
      }
    }
    ```

 2. Ejecuta el app. Deberás ver la siguiente pantalla.

    <center><img src="images/hello-world-screenshot.png" alt="screenshot of hello world app"></center>


## Observaciones
{:.no_toc}

- Este ejemplo crea una "Material app".
  [Material](https://material.io/guidelines/) es un lenguaje de diseño visual
  el cual es un estándar en web y móvil. Flutter ofrece un gran conjunto
  de "Material widgets".
- El método main especifica con la siguiente notación de flecha (`=>`),
  la cual es una manera corta usada para funciones o métodos de una linea.
- La app hereda de `StatelessWidget` el cual hace a la app misma un
  widget. En Flutter, casi todo es un widget, incluyendo
  alignment, padding, y layout.
- El widget `Scaffold`, de la librería de Material,
  provee una AppBar por defecto, "title", y una propiedad "body" el cual
  soporta el árbol de widget para la pantalla de inicio. El subárbol de widget
  puede ser bastante complejo.
- El trabajo principal de un widget es proveer un método `build()`
  el cual describe como mostrar un widget en termino de otro,
  widgets de bajo nivel.
- El árbol de widget para este ejemplo consiste en un widget `Center`
  que contiene un child widget `Text`. El widget `Center` alinea un subárbol de 
  widgets al centro de la pantalla.

{% comment %}
  Removing this for now. A) It might be confusing and B) the code as shown here is wrong.
  <li markdown="1"> Moving the “hello world” text into a separate widget,
      HelloWorld, results in an identical widget tree as the code above.
      (This code is informational only. You are starting with the Hello
      World code above.)

  <!-- skip -->
  {% prettify dart %}
  import 'package: flutter/material.dart';

  class MyApp extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       title: 'Welcome to Flutter',
       home: Scaffold(
         appBar: AppBar(
           title: Text('Welcome to Flutter'),
         ),
         body: Center(
           child: Text('Hello World')
         ),
       ),
     );
   }
  }
  {% endprettify %}

  Actualiza con el siguiente código:

  class HelloWorld extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return Center(
       child: Text('Hello World'),
     );
   }
  }
  </li>
{% endcomment %}

---

# Paso 2: Usar un paquete externo

En este paso, empezarás utilizando un paquete de código libre llamado
**english_words**, el cual contiene uno cuantos de miles de las palabras
en Inglés más utilizadas, además de otras funciones de utilidad.

Puedes encontrar el paquete
[english_words](https://pub.dartlang.org/packages/english_words),
así como muchas otros paquetes de código libre en
[pub.dartlang.org](https://pub.dartlang.org/flutter/).

 1. El archivo pubspec gestiona los activos para una app Flutter.
    En **pubspec.yaml**, agrega **english_words** (3.1.0 o mayor)
    a las lista de dependencias.
    La nueva linea es resaltada abajo:

    {% prettify yaml %}
      dependencies:
        flutter:
          sdk: flutter

        cupertino_icons: ^0.1.0
        [[highlight]]english_words: ^3.1.0[[/highlight]]
    {% endprettify %}

 2. Mientras vez el pubspec en el editor de Android Studio,
    clic **Packages get** arriba a la derecha. Esto trae los paquetes dentro
    del proyecto. Se deberá ver lo siguiente en la consola:

    ```terminal
    > flutter packages get
    Running "flutter packages get" in startup_namer...
    Process finished with exit code 0
    ```

 3. En **lib/main.dart**, agrega el "import" para `english_words`,
    como se muestra resaltado en la linea:

    <!-- skip -->
    {% prettify dart %}
      import 'package:flutter/material.dart';
      [[highlight]]import 'package:english_words/english_words.dart';[[/highlight]]
    {% endprettify %}

    Mientras tecleas, Android Studio da sugerencias para las bibliotecas a
    importar. Entonces renderiza el texto de "import" en gris, haciéndote 
    saber que la librería importada no ha sido utilizada (hasta el momento).

 4. Usa el paquete de palabras en inglés para generar texto en lugar de
    utilizar el texto "Hello World".

    {{site.alert.note}}
      "Pascal case" (también conocido como "upper camel case"),
      significa que cada palabra en el texto, incluyendo la primera, 
      empezará con letra mayúscula. Entonces, "uppercamelcase" se convierte
      "UpperCamelCase".
    {{site.alert.end}}

    Realiza los siguientes cambios, como se resalta abajo:

    <!-- skip -->
    {% prettify dart %}
      import 'package:flutter/material.dart';
      import 'package:english_words/english_words.dart';

      void main() => runApp(MyApp());

      class MyApp extends StatelessWidget {
        @override
        Widget build(BuildContext context) {
          [[highlight]]final wordPair = WordPair.random();[[/highlight]]
          return MaterialApp(
            title: 'Welcome to Flutter',
            home: Scaffold(
              appBar: AppBar(
                title: Text('Welcome to Flutter'),
              ),
              body: Center(
                //child: Text([[highlight]]'Hello World'[[/highlight]]), // Replace the highlighted text...
                child: Text([[highlight]]wordPair.asPascalCase[[/highlight]]),  // With this highlighted text.
              ),
            ),
          );
        }
      }
    {% endprettify %}

 5. Si la app esta ejecutándose, utilice el botón de hot reload
    (<img src="images/hot-reload-button.png" alt="lightning bolt icon">)
    para actualizar el app. Cada vez que se presione hot reload
    o se guarde el proyecto, deberá verse una diferente palabra,
    elegida aleatoria mente, en la app.
    Esto es debido a que las palabras generadas dentro de el método "build",
    el cual se ejecuta cada vez que la MaterialApp requiere renderizar
    o al alternar la plataforma en el inspector de Flutter .

<center><img src="images/step2-screenshot.png" alt="screenshot at completion of second step"></center>


## Problemas?
{:.no_toc}

Si tu app no esta ejecutando correctamente, busque por errores al teclear. De ser necesario,
use el código en el siguiente enlace y continuar

* [**pubspec.yaml**](https://gist.githubusercontent.com/Sfshaza/bb51e3b7df4ebbf3dfd02a4a38db2655/raw/57c25b976ec34d56591cb898a3df0b320e903b99/pubspec.yaml)
(El archivo **pubspec.yaml** no cambiara de nuevo.)
* [**lib/main.dart**](https://gist.githubusercontent.com/Sfshaza/bb51e3b7df4ebbf3dfd02a4a38db2655/raw/57c25b976ec34d56591cb898a3df0b320e903b99/main.dart)

---

# Paso 3: Agregar un Stateful widget

State<em>less</em> widgets son inmutables, esto quiere decir que
sus propiedades no puedes cambiar&mdash;todos sus valores son finales.

State<em>ful</em> widgets mantienes un estado que puede cambiar
durante el tiempo de vida del widget. Implementar un stateful
widget necesitara al menos dos clases: 1) una clase StatefulWidget
la cual crea la instancia 2) una clase State. La clase StatefulWidget es,
a si misma, inmutable, pero la clase State persiste sobre el tiempo de
vida de el widget.

En este paso, agregaras un stateful widget, RandomWords, el cual crea su clase
State, RandomWordsState. La clase State eventualmente
mantendrá las palabras propuestas y favoritas para el widget.

 1. Agrega el stateful RandomWords widget a main.dart.
    Puede ir en cualquier lugar del archivo, fuera de MyApp, pero la solución
    la coloca al final del archivo. El RandomWords widget hace poco ademas de 
    crear su clase State:

    <!-- skip -->
    {% prettify dart %}
    class RandomWords extends StatefulWidget {
      @override
      createState() => RandomWordsState();
    }
    {% endprettify %}

 2. Agrega la clase RandomWordsState. La mayoría de código de la
    app se encuentra en esta clase, la cual mantiene el estado para el
    RandomWords widget. Esta clase guardara las palabras generadas,
    el cual crece infinitamente mientra el usuario de desplaza, y también las palabras
    favoritas, mientras el usuario agregue o elimine de la lista
    seleccionando el icono de corazón.

    Creara esta clase poco a poco. Para empezar, creé una clase pequeña
    y agregue el texto resaltado:

    <!-- skip -->
    {% prettify dart %}
    [[highlight]]class RandomWordsState extends State<RandomWords> {[[/highlight]]
    [[highlight]]}[[/highlight]]
    {% endprettify %}

 3. Después de agregar esta clase de estado, el IDE se quejara que
    a la clase le hace falta el método build. Siguiente, agregar un método
    build básico que genera el juego de palabras moviendo la
    generación de código de MyApp a RandomWordsState.

    Agregar el método build a RandomWordState, como se muestra
    en el siguiente texto resaltado:

    <!-- skip -->
    {% prettify dart %}
    class RandomWordsState extends State<RandomWords> {
      [[highlight]]@override[[/highlight]]
      [[highlight]]Widget build(BuildContext context) {[[/highlight]]
        [[highlight]]final wordPair = WordPair.random();[[/highlight]]
        [[highlight]]return Text(wordPair.asPascalCase);[[/highlight]]
      [[highlight]]}[[/highlight]]
    }
    {% endprettify %}

 4. Elimine la generación de código de MyApp haciendo los
    cambios resaltados como es la parte de abajo:

    <!-- skip -->
    {% prettify dart %}
    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        [[strike]]final wordPair = WordPair.random();[[/strike]]  // Delete this line

        return MaterialApp(
          title: 'Welcome to Flutter',
          home: Scaffold(
            appBar: AppBar(
              title: Text('Welcome to Flutter'),
            ),
            body: Center(
              //child: [[highlight]]Text(wordPair.asPascalCase),[[/highlight]] // Change the highlighted text to...
              child: [[highlight]]RandomWords(),[[/highlight]] // ... this highlighted text
            ),
          ),
        );
      }
    }
    {% endprettify %}

Reinicia la app. Si se intenta un hot reload, podría ver el siguiente mensaje de precaución:

```nocode
Reloading...
Not all changed program elements ran during view reassembly; consider
restarting.
```

Podría ser un falso positivo, pero considere reiniciar en orden de asegurar estos
cambios sean reflejados en la UI de la app.

La app deberá mostrar el comportamiento de antes, mostrando un juego de palabras
cada vez que que se haga un hot reload o guarde la app.

<center><img src="images/step3-screenshot.png" alt="screenshot at completion of third step"></center>

## Problemas?
{:.no_toc}

Si tu app no esta corriendo correctamente, puede utilizar este código
de el siguiente enlace y continuar.

* [**lib/main.dart**](https://gist.githubusercontent.com/Sfshaza/d7f13ddd8888556232476be8578efe40/raw/329c397b97309ce99f834bf70ebb90778baa5cfe/main.dart)

---

# Paso 4: Crear un ListView de scroll infinito

En este paso, extenderemos la clase RandomWordsState para generar
y desplegar una lista de palabras. Mientras el usuario se desplaza, la lista
lo desplegara en un ListView widget, crecerá infinitamente. El `builder` de fabrica del constructor 
ListView permite construir un una lista de carga lenta, a petición.

 1. Agrega una lista `_suggestions` a la clase RandomWordsState
    para guardar las palabras sugeridas. La variable empieza con
    un guion bajo (`_`)&mdash;prefijar un identificador con un guión bajo aplica 
    privacidad en el lenguaje Dart.

    También, agrega una variable `biggerFont` para hacer el tamaño de la fuente mas grande.

    <!-- skip -->
    {% prettify dart %}
    class RandomWordsState extends State<RandomWords> {
      [[highlight]]final _suggestions = <WordPair>[];[[/highlight]]

      [[highlight]]final _biggerFont = const TextStyle(fontSize: 18.0);[[/highlight]]
      ...
    }
    {% endprettify %}

 2. Agrega la función `_buildSuggestions()` a la clase RandomWordsState.
    Este método construirá el ListView que despliega las palabras sugeridas.

    La clase ListView provee una propiedad builder, `itemBuilder`,
    un builder de fabrica y un función callback especificada como función anónima,
    Dos parámetros se pasan a la función&mdash;El BuildContext, 
    y un renglón de iteración , `i`. El iterador empieza desde 0 e incrementa
    cada vez que la función es llamada, un vez cada que un juego de palabras es llamado.
    Este modelo permite que la lista sugerida crezca infinitamente mientras el usuario se desplaza.

    Agrega las lineas resaltadas abajo:

    <!-- skip -->
    {% prettify dart %}
    class RandomWordsState extends State<RandomWords> {
      ...
      [[highlight]]Widget _buildSuggestions() {[[/highlight]]
        [[highlight]]return ListView.builder([[/highlight]]
          [[highlight]]padding: const EdgeInsets.all(16.0),[[/highlight]]
          // The itemBuilder callback is called once per suggested word pairing,
          // and places each suggestion into a ListTile row.
          // For even rows, the function adds a ListTile row for the word pairing.
          // For odd rows, the function adds a Divider widget to visually
          // separate the entries. Note that the divider may be difficult
          // to see on smaller devices.
          [[highlight]]itemBuilder: (context, i) {[[/highlight]]
            // Add a one-pixel-high divider widget before each row in theListView.
            [[highlight]]if (i.isOdd) return Divider();[[/highlight]]

            // The syntax "i ~/ 2" divides i by 2 and returns an integer result.
            // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
            // This calculates the actual number of word pairings in the ListView,
            // minus the divider widgets.
            [[highlight]]final index = i ~/ 2;[[/highlight]]
            // If you've reached the end of the available word pairings...
            [[highlight]]if (index >= _suggestions.length) {[[/highlight]]
              // ...then generate 10 more and add them to the suggestions list.
              [[highlight]]_suggestions.addAll(generateWordPairs().take(10));[[/highlight]]
            [[highlight]]}[[/highlight]]
            [[highlight]]return _buildRow(_suggestions[index]);[[/highlight]]
          [[highlight]]}[[/highlight]]
        [[highlight]]);[[/highlight]]
      [[highlight]]}[[/highlight]]
    }
    {% endprettify %}

 3. La función `_buildSuggestions` llama a `_buildRow` una vez por
    juego de palabras. Esta función despliega un ListTile cada nuevo juego de palabras
    lo cual permite que los renglones se vean mejor en el siguiente paso.

    Agrega una función `_buildRow` a RandomWordsState:

    <!-- skip -->
    {% prettify dart %}
    class RandomWordsState extends State<RandomWords> {
      ...

      [[highlight]]Widget _buildRow(WordPair pair) {[[/highlight]]
        [[highlight]]return ListTile([[/highlight]]
          [[highlight]]title: Text([[/highlight]]
            [[highlight]]pair.asPascalCase,[[/highlight]]
            [[highlight]]style: _biggerFont,[[/highlight]]
          [[highlight]]),[[/highlight]]
        [[highlight]]);[[/highlight]]
      [[highlight]]}[[/highlight]]
    }
    {% endprettify %}

 4. Actualiza el método de build para RandomWordsState y utilizar
    `_buildSuggestions()`, en lugar de llamar directamente la librería
     de generación de palabras. Realice los cambios que están resaltados:

    <!-- skip -->
    {% prettify dart %}
    class RandomWordsState extends State<RandomWords> {
      ...
      @override
      Widget build(BuildContext context) {
        [[strike]]final wordPair = WordPair.random();[[/strike]] // Delete these two lines.
        [[strike]]return Text(wordPair.asPascalCase);[[/strike]]
        [[highlight]]return Scaffold ([[/highlight]]
          [[highlight]]appBar: AppBar([[/highlight]]
            [[highlight]]title: Text('Startup Name Generator'),[[/highlight]]
          [[highlight]]),[[/highlight]]
          [[highlight]]body: _buildSuggestions(),[[/highlight]]
        [[highlight]]);[[/highlight]]
      }
      ...
    }
    {% endprettify %}

 5. Actualiza el método build para MyApp.
    Elimina las instancias de Scaffold y AppBar de MyApp.
    Estos serán administrados por RandomWordsState, lo cual hará mas fácil
    de cambiar el nombre de la ruta en la app bar mientras el usuario navegue
    de una pantalla a otra, en el siguiente paso.

    Reemplace el método original con el método build resaltado abajo:

    <!-- skip -->
    {% prettify dart %}
    class MyApp extends StatelessWidget {
      @override
      [[highlight]]Widget build(BuildContext context) {[[/highlight]]
        [[highlight]]return MaterialApp([[/highlight]]
          [[highlight]]title: 'Startup Name Generator',[[/highlight]]
          [[highlight]]home: RandomWords(),[[/highlight]]
        [[highlight]]);[[/highlight]]
      [[highlight]]}[[/highlight]]
    }
    {% endprettify %}

 Reinicie la app. Deberá ver una lista de palabras. Desplazandoce hacia abajo
 tanto como lo quieras y continuara viendo nuevos juegos de palabras.

<center><img src="images/step4-screenshot.png" alt="screenshot at completion of fourth step"></center>

## Problemas?
{:.no_toc}

Si tu app no esta funcionando correctamente, puedes ver el código
en el siguiente enlace y continuar.

* [**lib/main.dart**](https://gist.githubusercontent.com/Sfshaza/d6f9460a04d3a429eb6ac0b0f07da564/raw/34fe240f4122435c871bb737708ee0357741801c/main.dart)

---

# Paso 5: Agregar interactividad.

En este paso, seras capaz de agregar iconos de corazón que puedan tocarse en cada renglón
cuando el usuario toque una entrada de la lista, se resaltara
a estado de "favorito", estas palabras serán agregadas o eliminadas 
al set de guardadas favoritas.

 1. Agrega un set `_saved` a RandomWordsState. Este set almacenara
    las palabras favoritas del usuario. Se prefiere utilizar un Set que una List
    debido a que este tiene una propiedad que no permite entradas duplicadas

    <!-- skip -->
    {% prettify dart %}
    class RandomWordsState extends State<RandomWords> {
      final _suggestions = <WordPair>[];

      [[highlight]]final _saved = Set<WordPair>();[[/highlight]]

      final _biggerFont = const TextStyle(fontSize: 18.0);
      ...
    }
    {% endprettify %}

 2. En la función `_buildRow`, agrega una verificación `alreadySaved`
    para asegurar que la palabras ha sido ya agregada a favoritos.

    <!-- skip -->
    {% prettify dart %}
      Widget _buildRow(WordPair pair) {
        [[highlight]]final alreadySaved = _saved.contains(pair);[[/highlight]]
        ...
      }
    {% endprettify %}

 3. También en `_buildRow()`, agrega un icono con forma de corazón al
    ListTiles para habilitar que es favorito. Después, agregaremos la posibilidad de
    interactuar con los iconos de corazón.

    Agrega las lineas resaltadas bajo:

    <!-- skip -->
    {% prettify dart %}
      Widget _buildRow(WordPair pair) {
        final alreadySaved = _saved.contains(pair);
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
          [[highlight]]trailing: Icon([[/highlight]]
            [[highlight]]alreadySaved ? Icons.favorite : Icons.favorite_border,[[/highlight]]
            [[highlight]]color: alreadySaved ? Colors.red : null,[[/highlight]]
          [[highlight]]),[[/highlight]]
        );
      }
    {% endprettify %}

 4. Reinicia la app. Deberás de ver corazones en cada renglón, 
    pero no podrás interactuar con ellos aún.

 5. Haz los nombre sugeridos se puedan pulsar en la función `_buildRow`. 
    Si una de las palabras ya fue agregada a favoritas,
    al pulsarla de nuevo la eliminara de la lista de favoritos.
    Cuando una palabra sea pulsada, llamara a la función
    `setState()` notificando al framework que el estado ha cambiado.

    Agregue las lineas resaltadas:

    <!-- skip -->
    {% prettify dart %}
      Widget _buildRow(WordPair pair) {
        final alreadySaved = _saved.contains(pair);
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
          trailing: Icon(
            alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null,
          ),
          [[highlight]]onTap: () {[[/highlight]]
            [[highlight]]setState(() {[[/highlight]]
              [[highlight]]if (alreadySaved) {[[/highlight]]
                [[highlight]]_saved.remove(pair);[[/highlight]]
              [[highlight]]} else {[[/highlight]]
                [[highlight]]_saved.add(pair);[[/highlight]]
              [[highlight]]}[[/highlight]]
            [[highlight]]});[[/highlight]]
          [[highlight]]},[[/highlight]]
        );
      }
    {% endprettify %}

{{site.alert.tip}}
  En el framework de estilo reactivo de Flutter, llamar a `setState()`
  ejecuta una llamada al método `build()` para el objeto State, dando como resultado
  una actualización de la UI.
{{site.alert.end}}

Haga hot reload en la app. deberá ser capaz de pulsar cualquier palabra a favorito o quitar de favorito,
Vea que el pulsar la palabra genera una animación ink splash implícita
que sale de el lugar que fue pulsado.

<center><img src="images/step5-screenshot.png" alt="screenshot at completion of 5th step"></center>

## Problemas?
{:.no_toc}

Si tu app no funciona correctamente, puedes usar el código
en el siguiente enlace y continuar.

* [**lib/main.dart**](https://gist.githubusercontent.com/Sfshaza/936ce0059029a8c6e88aaa826a3789cd/raw/a3065d5c681a81eff32f75a9cd5f4d9a5b24f9ff/main.dart)

---

# Paso 6: Navegar a una nueva pantalla

En este paso, agregaras una nueva pantalla (llamada _route_ en Flutter) esta
mostrara los favoritos. Aprenderás como navegar entre la página de inicio
y la ruta nueva.

En Flutter, el Navegator administra la pila de rutas que contiene la app.
Empujando una rutas a la pila del Navegator, actualizando lo que muestra la ruta.
Sacando la ruta de la pila del Navegator, regresando lo que mostraba la ruta anterior.

 1. Agrega un icono de lista a la AppBar en el método build para 
    RandomWordsState.  Cuando el usuario presione el icono de lista, una nueva 
    ruta que contiene los artículos favoritos se empuja dentro del Navegator,
    mostrando el icono.

    {{site.alert.tip}}
      Algunas propiedades del widget permiten un solo widget (`child`), pero otras propiedades,
      como `action`, permiten un arreglo de widgets (`children`),
      como se ve en los corchetes (`[]`).
    {{site.alert.end}}

    Agregue el icono y su acción correspondiente al método build:

    <!-- skip -->
    {% prettify dart %}
    class RandomWordsState extends State<RandomWords> {
      ...
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Startup Name Generator'),
            [[highlight]]actions: <Widget>[[[/highlight]]
              [[highlight]]IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),[[/highlight]]
            [[highlight]]],[[/highlight]]
          ),
          body: _buildSuggestions(),
        );
      }
      ...
    }
    {% endprettify %}

 2. Agregue una función `_pushSaved()` a la clase RandomWordsState.

    <!-- skip -->
    {% prettify dart %}
    class RandomWordsState extends State<RandomWords> {
      ...
      [[highlight]]void _pushSaved() {[[/highlight]]
      [[highlight]]}[[/highlight]]
    }
    {% endprettify %}

    Hot reload la app. El icono de lista aparecerá en el AppBar.
    Pulsándolo no hace nada aún, por que la función `_pushSaved` esta vacía.

 3. Cuando el usuario pulse el icono de lista en el AppBarr,
    Se construirá una ruta y se meterá dentro de la pila del Navegator.
    Esta acción cambiara lo que muestra la pantalla a la nueva ruta.

    El contenido para la nueva página es construida en la propiedad `builder` en MaterialPageRoute's `builder`, 
    en  una función anónima.

    Agregar llamada al Navigator.push, como muestra el código resaltado,
    el cual empuja la ruta a la pila de Navigator.

    <!-- skip -->
    {% prettify dart %}
      [[highlight]]void _pushSaved() {[[/highlight]]
        [[highlight]]Navigator.of(context).push([[/highlight]]
        [[highlight]]);[[/highlight]]
      [[highlight]]}[[/highlight]]
    {% endprettify %}

 4. Agrega el MaterialPageRoute y su builder. Por ahora,
    Agrega el código que genera los renglones de ListTile. El método `divideTiles()`
    de ListTile agrega un espacio horizontal entre cada ListTile.
    La variable `divided` mantiene el renglón final, convertida a una lista
    por la función de conveniencia, `toList()`.

    <!-- skip -->
    {% prettify dart %}
      void _pushSaved() {
        Navigator.of(context).push(
          [[highlight]]MaterialPageRoute([[/highlight]]
            [[highlight]]builder: (context) {[[/highlight]]
              [[highlight]]final tiles = _saved.map([[/highlight]]
                [[highlight]](pair) {[[/highlight]]
                  [[highlight]]return ListTile([[/highlight]]
                    [[highlight]]title: Text([[/highlight]]
                      [[highlight]]pair.asPascalCase,[[/highlight]]
                      [[highlight]]style: _biggerFont,[[/highlight]]
                    [[highlight]]),[[/highlight]]
                  [[highlight]]);[[/highlight]]
                [[highlight]]},[[/highlight]]
              [[highlight]]);[[/highlight]]
              [[highlight]]final divided = ListTile[[/highlight]]
                [[highlight]].divideTiles([[/highlight]]
                  [[highlight]]context: context,[[/highlight]]
                  [[highlight]]tiles: tiles,[[/highlight]]
                [[highlight]])[[/highlight]]
                [[highlight]].toList();[[/highlight]]
            [[highlight]]},[[/highlight]]
          [[highlight]]),[[/highlight]]
        );
      }
    {% endprettify %}

 5. La propiedad builder regresa un Scaffold,
    contiene la AppBar para una nueva ruta, llamada
    "Saved Suggestions". El body de la ruta nueva
    consiste de un ListView que contiene los renglones del ListTiles;
    cada renglón es separado por un divisor.

    Agregue el código resaltado abajo:

    <!-- skip -->
    {% prettify dart %}
      void _pushSaved() {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              final tiles = _saved.map(
                (pair) {
                  return ListTile(
                    title: Text(
                      pair.asPascalCase,
                      style: _biggerFont,
                    ),
                  );
                },
              );
              final divided = ListTile
                .divideTiles(
                  context: context,
                  tiles: tiles,
                )
                .toList();

              [[highlight]]return Scaffold([[/highlight]]
                [[highlight]]appBar: AppBar([[/highlight]]
                  [[highlight]]title: Text('Saved Suggestions'),[[/highlight]]
                [[highlight]]),[[/highlight]]
                [[highlight]]body: ListView(children: divided),[[/highlight]]
              [[highlight]]);[[/highlight]]
            },
          ),
        );
      }
    {% endprettify %}

 6. Hot reload la app. Seleccione como favoritas algunas y
    pulse el icono de lista en la AppBar. La nueva ruta aparecerá conteniendo
    los favoritos. Vea que el Navegator agrega un boton de "Back" al AppBarr.
    No se necesita implementar explícitamente `Navigator.pop`.
    Pulse el botón de "Back" para regresar a la ruta de inicio.

<center>
  <img src="images/step6a-screenshot.png" alt="screenshot at completion of 6th step">
  <img src="images/step6b-screenshot.png" alt="second route">
</center>

## Problemas?
{:.no_toc}

Si tu app no funciona correctamente, puedes utilizar el código
en el siguiente enlace y continuar.

* [**lib/main.dart**](https://gist.github.com/Sfshaza/bc5547e112e4dc3a1aa87afdf917caeb)

---

# Paso 7: Cambiar la UI utilizando Temas.

En este paso final, jugaremos un poco con el tema de la app. El
_theme_ controla como se ve y se siente tu app. Puedes usar un tema
por defecto, el cual depende del dispositivo físico o emulador,
o puedes crear un tema personalizado que refleje tu branding.

 1. Puedes fácilmente cambiar el tema de una app configurando
    la clase ThemeData. Tu app actualmente utiliza el tema por defecto,
    pero puedes cambiar el color primario a blanco.

    Cambiar el tema de la app a blanco agregando el código resaltado a MyApp:

    <!-- skip -->
    {% prettify dart %}
    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Startup Name Generator',
          [[highlight]]theme: ThemeData([[/highlight]]
            [[highlight]]primaryColor: Colors.white,[[/highlight]]
          [[highlight]]),[[/highlight]]
          home: RandomWords(),
        );
      }
    }
    {% endprettify %}

 2. Hot reload la app. vea que ahora el fondo es completamente blanco,
    hasta el app bar.

 3. Como ejercicio para el lector, utilice
    [ThemeData](https://docs.flutter.io/flutter/material/ThemeData-class.html)
    para cambiar otros aspectos de la UI. La
    [Colors](https://docs.flutter.io/flutter/material/Colors-class.html)
    clase que se proveé en Material library tiene muchas constantes de color con las cual se puede jugar,
    y hot reload permite experimentar con la UI fácil y rápido.

<center><img src="images/step7-themes.png" alt="screenshot at completion of 7th step"></center>

## Problemas?
{:.no_toc}

Si te has salido del camino, usa el código de el siguiente enlace
y ve el código final de la app.

* [**lib/main.dart**](https://gist.githubusercontent.com/Sfshaza/c07c91a4061fce4b5eacaaf4d82e4993/raw/4001a72c0133b97c8e16bdeb3195ca03525696bd/main.dart)

---

# Bien hecho!

Has escrito una app interactiva en Flutter que se ejecuta en ambos iOS y Android

En este laboratorio, tu has:

* Creaste una app de Flutter desde cero.
* Escrita en código Dart.
* Utilizando una librería externa de un tercero.
* Usaste hot reload para un ciclo de desarrollo mas rápido.
* Implementaste un stateful widget, agregando interactividad a tu app.
* Creaste una lista de carga lenta, mostrando un desplazamiento infinito con un
  ListView y ListTiles.
* Creaste una ruta y agregaste lógica de movimiento entre la ruta de inicio
  y la ruta nueva.
* Aprendiste como cambiar el estilo de tu app utilizando Themes.

## Siguiente paso
{:.no_toc}

[Aprender mas](/get-started/learn-more/)
