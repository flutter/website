---
layout: page
title: Un recorrido por el framework de los widgets Flutter
permalink: /widgets-intro/
---

* TOC Placeholder
{:toc}

## Introducción

Los widgets de Flutter están construidos utilizando un framework moderno de estilo reactivo, que se inspira en React. La idea central es que construya su interfaz de usuario con widgets. Los widgets describen cómo debería ser su vista dada su configuración y estado actual. Cuando el estado de un widget cambia, el widget reconstruye su descripción, que el framework difiere de la descripción anterior para determinar los cambios mínimos necesarios en el árbol de render subyacente para la transición de un estado al siguiente.

<aside id="note" class="alert alert-info" markdown="1">
**Nota**: Si quieres conocer mejor Flutter zambulléndote en algún código, echa un vistazo a [Construyendo Layouts in Flutter](/tutorials/layout/) y
[Agregando interactividad a tu Flutter App](/tutorials/interactive/).
</aside>

Hola Mundo
-----------

La aplicación Flutter mínima simplemente llama a la función [`runApp`](https://docs.flutter.io/flutter/widgets/runApp.html) con un widget:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    Center(
      child: Text(
        'Hello, world!',
        textDirection: TextDirection.ltr,
      ),
    ),
  );
}
```

La función [`runApp`](https://docs.flutter.io/flutter/widgets/runApp.html) toma el [`Widget`](https://docs.flutter.io/flutter/widgets/Widget-class.html) dado y lo convierte en la raíz del árbol de widgets. En este ejemplo, el árbol de widgets consta de dos widgets, el widget [`Center`](https://docs.flutter.io/flutter/widgets/Center-class.html) y su hijo (child), el widget [`Text`](https://docs.flutter.io/flutter/widgets/Text-class.html). El framework fuerza al widget raíz a cubrir la pantalla, lo que significa que el texto "Hello, world" termina centrado en la pantalla. En este caso, es necesario especificar la dirección del texto; cuando se utiliza el widget de MaterialApp, esto se hace por usted, como se demostrará más adelante.

Al escribir una aplicación, normalmente creará nuevos widgets que son subclases de [`StatelessWidget`](https://docs.flutter.io/flutter/widgets/StatelessWidget-class.html) o [`StatefulWidget`](https://docs.flutter.io/flutter/widgets/StatefulWidget-class.html), dependiendo de si su widget gestiona algún estado. El trabajo principal de un widget es implementar una función [`build`](https://docs.flutter.io/flutter/widgets/StatelessWidget/build.html), que describe el widget en términos de otros widgets de nivel inferior. El framework construye esos widgets a su vez hasta que el proceso toca fondo en widgets que representan el [`RenderObject`](https://docs.flutter.io/flutter/rendering/RenderObject-class.html) subyacente, que calcula y describe la geometría del widget.

Widgets básicos
-------------

_Artículo principal: [Descripción general de los widgets - Modelos de diseño](https://flutter.io/widgets/layout)_

Flutter viene con un conjunto de potentes widgets básicos, de los cuales los siguientes son de uso muy común:

 * [`Text`](https://docs.flutter.io/flutter/widgets/Text-class.html): El widget [`Text`](https://docs.flutter.io/flutter/widgets/Text-class.html) le permite crear una ejecución de texto con estilo dentro de su aplicación.

* [`Row`](https://docs.flutter.io/flutter/widgets/Row-class.html), [`Column`](https://docs.flutter.io/flutter/widgets/Column-class.html): Estos widgets flexibles le permiten crear diseños flexibles tanto en la dirección horizontal ([`Row`](https://docs.flutter.io/flutter/widgets/Row-class.html)) como en la vertical ([`Column`](https://docs.flutter.io/flutter/widgets/Column-class.html)). Su diseño se basa en el modelo de diseño flexbox de la web.

* [`Stack`](https://docs.flutter.io/flutter/widgets/Stack-class.html): En lugar de estar orientado linealmente (ya sea horizontal o verticalmente), un widget * [`Stack`](https://docs.flutter.io/flutter/widgets/Stack-class.html) le permite apilar widgets uno encima del otro en orden de pintura. A continuación, puedes usar el widget [`Positioned`](https://docs.flutter.io/flutter/widgets/Positioned-class.html) en los hijos de un [`Stack`](https://docs.flutter.io/flutter/widgets/Stack-class.html) para colocarlos en relación con el borde superior, derecho, inferior o izquierdo del Stack. Los Stacks se basan en el modelo de diseño de posicionamiento absoluto de la web.

* [`Container`](https://docs.flutter.io/flutter/widgets/Container-class.html): El widget [`Container`](https://docs.flutter.io/flutter/widgets/Container-class.html) le permite crear elementos visuales rectangulares. Un contenedor puede ser decorado con un [`BoxDecoration`](https://docs.flutter.io/flutter/painting/BoxDecoration-class.html), como un fondo, un borde o una sombra. Un [`Container`](https://docs.flutter.io/flutter/widgets/Container-class.html) también puede tener márgenes, paddings y restricciones aplicadas a su tamaño. Además, un [`Container`](https://docs.flutter.io/flutter/widgets/Container-class.html) puede ser transformado en un espacio tridimensional utilizando una matriz.

A continuación se muestran algunos widgets simples que combinan estos y otros widgets:

```dart
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  MyAppBar({this.title});

  // Fields in a Widget subclass are always marked "final".

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0, // in logical pixels
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.blue[500]),
      // Row is a horizontal, linear layout.
      child: Row(
        // <Widget> is the type of items in the list.
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed: null, // null disables the button
          ),
          // Expanded expands its child to fill the available space.
          Expanded(
            child: title,
          ),
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
    );
  }
}

class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece of paper on which the UI appears.
    return Material(
      // Column is a vertical, linear layout.
      child: Column(
        children: <Widget>[
          MyAppBar(
            title: Text(
              'Example title',
              style: Theme.of(context).primaryTextTheme.title,
            ),
          ),
          Expanded(
            child: Center(
              child: Text('Hello, world!'),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'My app', // used by the OS task switcher
    home: MyScaffold(),
  ));
}
```

Asegúrese de tener `uses-material-design: true` en la sección `flutter` de su archivo `pubspec.yaml`. Permite utilizar el conjunto predefinido de [Material icons](https://design.google.com/icons/).

```yaml
name: my_app
flutter:
  uses-material-design: true
```

Es necesario que haya muchos widgets dentro de [`MaterialApp`](https://docs.flutter.io/flutter/material/MaterialApp-class.html) para que se muestren correctamente, a fin de heredar los datos del tema. Por lo tanto, ejecutamos la aplicación con [`MaterialApp`](https://docs.flutter.io/flutter/material/MaterialApp-class.html).

El widget `MyAppBar` crea un [`Container`](https://docs.flutter.io/flutter/widgets/Container-class.html) con una altura de 56 píxeles independientes del dispositivo con un relleno interno de 8 píxeles, tanto a la izquierda como a la derecha. Dentro del contenedor, `MyAppBar` usa un diseño de [`Row`](https://docs.flutter.io/flutter/widgets/Row-class.html) para organizar a sus hijos. El hijo del medio, el widget de título, está marcado como [`Expanded`](https://docs.flutter.io/flutter/widgets/Expanded-class.html), lo que significa que se expande para llenar cualquier espacio disponible que no haya sido consumido por los otros hijos. Puede tener varios hijos [`Expanded`](https://docs.flutter.io/flutter/widgets/Expanded-class.html) y determinar la proporción en la que consumen el espacio disponible usando el argumento [`flex`](https://docs.flutter.io/flutter/widgets/Expanded-class.html#flex) para [`Expanded`](https://docs.flutter.io/flutter/widgets/Expanded-class.html).

El widget`MyScaffold` organiza a sus hijos en una columna vertical. En la parte superior de la columna coloca una instancia de `MyAppBar`, pasando a la app bar un widget [`Text`](https://docs.flutter.io/flutter/widgets/Text-class.html) para usar como título. Pasar widgets como argumentos a otros widgets es una técnica poderosa que le permite crear widgets genéricos que pueden ser reutilizados en una amplia variedad de formas. Finalmente, `MyScaffold` utiliza un [`Expanded`](https://docs.flutter.io/flutter/widgets/Expanded-class.html) para llenar el espacio restante con su cuerpo, que consiste en un mensaje centrado.

Utilización de Material Components
---------------------

_Artículo principal: [Resumen de widgets: Material Components](https://flutter.io/widgets/material)_

Flutter proporciona una serie de widgets que te ayudan a crear aplicaciones que siguen a Material Design. Una aplicación MaterialApp comienza con el widget [`MaterialApp`](https://docs.flutter.io/flutter/material/MaterialApp-class.html), que crea una serie de widgets útiles en la raíz de su aplicación, incluyendo un [`Navigator`](https://docs.flutter.io/flutter/widgets/Navigator-class.html), que gestiona una pila de widgets identificados por cadenas, también conocidas como "routes". El [`Navigator`](https://docs.flutter.io/flutter/widgets/Navigator-class.html) le permite realizar una transición fluida entre las pantallas de su aplicación. El uso del widget de [`MaterialApp`](https://docs.flutter.io/flutter/material/MaterialApp-class.html) es totalmente opcional, pero es una buena práctica.

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Tutorial',
    home: TutorialHome(),
  ));
}

class TutorialHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: Text('Example title'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
      // body is the majority of the screen.
      body: Center(
        child: Text('Hello, world!'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        child: Icon(Icons.add),
        onPressed: null,
      ),
    );
  }
}
```

Ahora que hemos cambiado de  `MyAppBar` y `MyScaffold` a los widgets [`AppBar`](https://docs.flutter.io/flutter/material/AppBar-class.html) y [`Scaffold`](https://docs.flutter.io/flutter/material/Scaffold-class.html) de `material.dart`, nuestra aplicación está empezando a buscar un poco más de Material. Por ejemplo, la barra de aplicaciones tiene una sombra y el texto del título hereda automáticamente el estilo correcto. También hemos añadido un botón de acción flotante para una buena medida.

Note que estamos pasando de nuevo los widgets como argumentos a otros widgets. El widget [`Scaffold`](https://docs.flutter.io/flutter/material/Scaffold-class.html) toma un número de diferentes widgets como argumentos con nombre, cada uno de los cuales se coloca en la disposición de Scaffold en el lugar apropiado. Del mismo modo, el widget de [`AppBar`](https://docs.flutter.io/flutter/material/AppBar-class.html) nos permite pasar widgets para el [`leading`](https://docs.flutter.io/flutter/material/AppBar-class.html#leading) y las [`actions`](https://docs.flutter.io/flutter/material/AppBar-class.html#actions) del widget de [`title`](https://docs.flutter.io/flutter/material/AppBar-class.html#title). Este patrón se repite a lo largo del framework y es algo que usted podría considerar al diseñar sus propios widgets.

Manejar gestos
-----------------

_Artículo principal: [Gestos en Flutter](https://flutter.io/gestures/)_

La mayoría de las aplicaciones incluyen alguna forma de interacción del usuario con el sistema. El primer paso para construir una aplicación interactiva es detectar gestos de entrada. Veamos cómo funciona creando un simple botón:

```dart
class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('MyButton was tapped!');
      },
      child: Container(
        height: 36.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.lightGreen[500],
        ),
        child: Center(
          child: Text('Engage'),
        ),
      ),
    );
  }
}
```

El widget [`GestureDetector`](https://docs.flutter.io/flutter/widgets/GestureDetector-class.html) no tiene una representación visual sino que detecta los gestos realizados por el usuario. Cuando el usuario toca el [`Container`](https://docs.flutter.io/flutter/widgets/Container-class.html), el [`GestureDetector`](https://docs.flutter.io/flutter/widgets/GestureDetector-class.html) llama a su llamada [`onTap`](https://docs.flutter.io/flutter/widgets/GestureDetector-class.html#onTap), en este caso imprimiendo un mensaje a la consola. Puede utilizar [`GestureDetector`](https://docs.flutter.io/flutter/widgets/GestureDetector-class.html) para detectar una variedad de gestos de entrada, incluidos toques (taps), arrastres (drags) y escalas (scales).

Muchos widgets utilizan un [`GestureDetector`](https://docs.flutter.io/flutter/widgets/GestureDetector-class.html) para proporcionar llamadas de retorno (callbacks) opcionales para otros widgets. Por ejemplo, los widgets [`IconButton`](https://docs.flutter.io/flutter/material/IconButton-class.html),
[`RaisedButton`](https://docs.flutter.io/flutter/material/RaisedButton-class.html) y [`FloatingActionButton`](https://docs.flutter.io/flutter/material/FloatingActionButton-class.html) tienen [`onPressed`](https://docs.flutter.io/flutter/material/RaisedButton-class.html#onPressed) callbacks que se activan cuando el usuario toca el widget.

Cambiar los widgets en respuesta a las entradas
-------------------------------------
_Artículos principales: [`StatefulWidget`](https://docs.flutter.io/flutter/widgets/StatefulWidget-class.html), [`State.setState`](https://docs.flutter.io/flutter/widgets/State/setState.html)_

Hasta ahora, sólo hemos usado widgets sin estado. Los widgets sin estado reciben argumentos de su widget padre, que almacenan en variables de miembro [`final`](https://www.dartlang.org/docs/dart-up-and-running/ch02.html#final-and-const). Cuando se le pide [`build`](https://docs.flutter.io/flutter/widgets/StatelessWidget/build.html)a un widget, utiliza estos valores almacenados para derivar nuevos argumentos para los widgets que crea.

Para construir experiencias más complejas -por ejemplo, para reaccionar de forma más interesante a las entradas de los usuarios- las aplicaciones suelen tener algún estado. Flutter utiliza StatefulWidgets para capturar esta idea. StatefulWidgets son widgets especiales que saben cómo generar objetos State, que luego se utilizan para mantener el estado. Considere este ejemplo básico, usando el [`RaisedButton`](https://docs.flutter.io/flutter/material/RaisedButton-class.html) mencionado anteriormente:

```dart
class Counter extends StatefulWidget {
  // This class is the configuration for the state. It holds the
  // values (in this nothing) provided by the parent and used by the build
  // method of the State. Fields in a Widget subclass are always marked "final".

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      // This call to setState tells the Flutter framework that
      // something has changed in this State, which causes it to rerun
      // the build method below so that the display can reflect the
      // updated values. If we changed _counter without calling
      // setState(), then the build method would not be called again,
      // and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance
    // as done by the _increment method above.
    // The Flutter framework has been optimized to make rerunning
    // build methods fast, so that you can just rebuild anything that
    // needs updating rather than having to individually change
    // instances of widgets.
    return Row(
      children: <Widget>[
        RaisedButton(
          onPressed: _increment,
          child: Text('Increment'),
        ),
        Text('Count: $_counter'),
      ],
    );
  }
}
```

Puede que se pregunte por qué StatefulWidget y State son objetos separados. En Flutter, estos dos tipos de objetos tienen diferentes ciclos de vida. Los widgets son objetos temporales, utilizados para construir una presentación de la aplicación en su estado actual. Por otro lado, los objetos de estado son persistentes entre llamadas a [`build()`](https://docs.flutter.io/flutter/widgets/State/build.html), permitiéndoles recordar información.

El ejemplo anterior acepta la entrada del usuario y utiliza directamente el resultado en su método de compilación. En aplicaciones más complejas, diferentes partes de la jerarquía de widgets pueden ser responsables de diferentes preocupaciones; por ejemplo, un widget puede presentar una interfaz de usuario compleja con el objetivo de recopilar información específica, como una fecha o ubicación, mientras que otro widget puede utilizar esa información para cambiar la presentación general.

En Flutter, las notificaciones de cambio fluyen "hacia arriba" en la jerarquía de widgets por medio de llamadas de callbacks, mientras que el estado actual fluye "hacia abajo" a los widgets sin estado que hacen la presentación. El padre común que redirige este flujo es el State. Veamos cómo funciona en la práctica, con este ejemplo un poco más complejo:

```dart
class CounterDisplay extends StatelessWidget {
  CounterDisplay({this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Text('Count: $count');
  }
}

class CounterIncrementor extends StatelessWidget {
  CounterIncrementor({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      child: Text('Increment'),
    );
  }
}

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      ++_counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      CounterIncrementor(onPressed: _increment),
      CounterDisplay(count: _counter),
    ]);
  }
}
```

Nótese cómo creamos dos nuevos widgets sin estado, separando limpiamente las preocupaciones de mostrar el contador (CounterDisplay) y cambiar el contador (CounterIncrementor). Aunque el resultado neto es el mismo que en el ejemplo anterior, la separación de responsabilidades permite encapsular una mayor complejidad en los widgets individuales, manteniendo al mismo tiempo la simplicidad en el padre.

Unirlo todo
-----------

Consideremos un ejemplo más completo que reúne los conceptos presentados anteriormente. Trabajaremos con una hipotética aplicación de compras, que muestra varios productos ofrecidos a la venta y mantiene un carrito de compras para las compras previstas. Comencemos por definir nuestra clase de presentación, `ShoppingListItem`:

```dart
class Product {
  const Product({this.name});
  final String name;
}

typedef void CartChangedCallback(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({Product product, this.inCart, this.onCartChanged})
      : product = product,
        super(key: ObjectKey(product));

  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different parts of the tree
    // can have different themes.  The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onCartChanged(product, !inCart);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(product.name, style: _getTextStyle(context)),
    );
  }
}
```


El widget `ShoppingListItem` sigue un patrón común para los widgets stateless. Almacena los valores que recibe en su constructor en variables de miembro [`final`](https://www.dartlang.org/docs/dart-up-and-running/ch02.html#final-and-const), que luego utiliza durante su función [`build`](https://docs.flutter.io/flutter/widgets/StatelessWidget/build.html). Por ejemplo, el booleano `inCart` para alternar entre dos apariencias visuales: una que usa el color primario del tema actual y otra que usa gris.

Cuando el usuario pulsa sobre el elemento de la lista, el widget no modifica su valor `inCart` directamente. En su lugar, el widget llama a la función `onCartChanged` que recibió de su widget padre. Este patrón le permite almacenar estados más arriba en la jerarquía de widgets, lo que hace que el estado persista durante períodos de tiempo más largos. En el extremo, el estado almacenado en el widget pasado a [`runApp`](https://docs.flutter.io/flutter/widgets/runApp.html) persiste durante toda la vida útil de la aplicación.

Cuando el padre recibe la llamada de retorno `onCartChanged`, el padre actualiza su estado interno, lo que provoca que el padre reconstruya y cree una nueva instancia de `ShoppingListItem` con el nuevo valor `inCart`. Aunque el padre crea una nueva instancia de `ShoppingListItem` cuando reconstruye, esa operación es barata porque el framework compara los widgets recién construidos con los widgets previamente construidos y aplica sólo las diferencias al [`RenderObject`](https://docs.flutter.io/flutter/rendering/RenderObject-class.html) subyacente.

Veamos un ejemplo de un widget padre que almacena estado mutable:

<!--
class Product {
  const Product({this.name});
  final String name;
}

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({Product product, bool inCart, Function onCartChanged});
  @override
  Widget build(BuildContext context) => null;
}
-->
```dart
class `ShoppingList` extends StatefulWidget {
  `ShoppingList`({Key key, this.products}) : super(key: key);

  final List<Product> products;

  // The framework calls createState the first time a widget appears at a given
  // location in the tree. If the parent rebuilds and uses the same type of
  // widget (with the same key), the framework re-uses the State object
  // instead of creating a new State object.

  @override
  `_ShoppingListState` createState() => `_ShoppingListState`();
}

class `_ShoppingListState` extends State<`ShoppingList`> {
  Set<Product> _shoppingCart = Set<Product>();

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      // When a user changes what's in the cart, we need to change _shoppingCart
      // inside a setState call to trigger a rebuild. The framework then calls
      // build, below, which updates the visual appearance of the app.

      if (inCart)
        _shoppingCart.add(product);
      else
        _shoppingCart.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: widget.products.map((Product product) {
          return ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Shopping App',
    home: `ShoppingList`(
      products: <Product>[
        Product(name: 'Eggs'),
        Product(name: 'Flour'),
        Product(name: 'Chocolate chips'),
      ],
    ),
  ));
}
```

La clase `ShoppingList` extiende [`StatefulWidget`](https://docs.flutter.io/flutter/widgets/StatefulWidget-class.html), lo que significa que este widget almacena estado mutable. Cuando el widget `ShoppingList` se inserta por primera vez en el árbol, el framework llama a la función [`createState`](https://docs.flutter.io/flutter/widgets/StatefulWidget-class.html#createState) para crear una nueva instancia de `_ShoppingListState` para asociarla con esa ubicación en el árbol (Note que típicamente nombramos subclases de [`State`](https://docs.flutter.io/flutter/widgets/State-class.html) con guiones bajos para indicar que son detalles de implementación privados). Cuando el padre de este widget se reconstruye, el padre crea una nueva instancia de `ShoppingList`, pero el framework reutiliza la instancia `_ShoppingListState` que ya está en el árbol en lugar de llamar [`createState`](https://docs.flutter.io/flutter/widgets/StatefulWidget-class.html#createState) de nuevo.

Para acceder a las propiedades de la Lista de la Compra actual, el `_ShoppingListState` puede usar su propiedad [`widget`](https://docs.flutter.io/flutter/widgets/State-class.html#widget). Si el padre reconstruye y crea una nueva `ShoppingList`, el `_ShoppingListState` reconstruye con el nuevo valor del [`widget`](https://docs.flutter.io/flutter/widgets/State-class.html#widget). Si desea que se le notifique cuando cambie la propiedad del widget, puede anular la función [`didUpdateWidget`](https://docs.flutter.io/flutter/widgets/State-class.html#didUpdateWidget), que se pasa a `oldWidget` para permitirle comparar el antiguo [`widget`](https://docs.flutter.io/flutter/widgets/State-class.html#widget) con el actual.

Al manejar la devolución de llamada `onCartChanged`, el `_ShoppingListState` muta su estado interno añadiendo o quitando un producto de `_shoppingCart`. Para señalar al framework que cambia su estado interno, envuelve esas llamadas en una llamada [`setState`](https://docs.flutter.io/flutter/widgets/State-class.html#setState). Calling [`setState`](https://docs.flutter.io/flutter/widgets/State-class.html#setState) marca este widget como sucio y lo programa para ser reconstruido la próxima vez que su aplicación necesite actualizar la pantalla. Si olvida llamar a [`setState`](https://docs.flutter.io/flutter/widgets/State-class.html#setState) al modificar el estado interno de un widget, el framework no sabrá que su widget está sucio y puede que no llame a la función [`build`](https://docs.flutter.io/flutter/widgets/StatelessWidget/build.html) del widget, lo que significa que la interfaz de usuario puede que no se actualice para reflejar el estado cambiado.

Gestionando el estado de esta manera, no es necesario escribir código separado para crear y actualizar widgets hijo. En su lugar, simplemente implemente la función de construcción, que maneja ambas situaciones.

Responder a los eventos del ciclo de vida de los widgets
--------------------------------------------------------
_Artículo principal: [Estado](https://docs.flutter.io/flutter/widgets/State-class.html)_

Después de llamar [`createState`](https://docs.flutter.io/flutter/widgets/StatefulWidget-class.html#createState) en el StatefulWidget, el framework inserta el nuevo objeto state en el árbol y luego llama a [`initState`](https://docs.flutter.io/flutter/widgets/State-class.html#initState) en el objeto state. Una subclase de [`State`](https://docs.flutter.io/flutter/widgets/State-class.html) puede invalidar [`initState`](https://docs.flutter.io/flutter/widgets/State-class.html#initState) para hacer el trabajo que necesita suceder sólo una vez. Por ejemplo, puede anular [`initState`](https://docs.flutter.io/flutter/widgets/State-class.html#initState) para configurar animaciones o suscribirse a servicios de plataforma. Las implementaciones de [`initState`](https://docs.flutter.io/flutter/widgets/State-class.html#initState) se requieren para comenzar llamando a [`super.initState`](https://docs.flutter.io/flutter/widgets/State-class.html#initState).

Cuando un objeto de estado ya no es necesario, el framework llama a [`dispose`](https://docs.flutter.io/flutter/widgets/State-class.html#dispose) sobre el objeto de estado. Puede anular la función de [`dispose`](https://docs.flutter.io/flutter/widgets/State-class.html#dispose) para realizar el trabajo de limpieza. Por ejemplo, puede anular [`dispose`](https://docs.flutter.io/flutter/widgets/State-class.html#dispose) para cancelar temporizadores o darse de baja de los servicios de la plataforma. Las implementaciones de [`dispose`](https://docs.flutter.io/flutter/widgets/State-class.html#dispose) típicamente terminan llamando [`super.dispose`](https://docs.flutter.io/flutter/widgets/State-class.html#dispose).

Llaves (keys)
-------------
_Artículo principal: [Clave](https://docs.flutter.io/flutter/foundation/Key-class.html)

Puede utilizar las claves para controlar qué widgets el framework coincide con otros widgets cuando un widget se reconstruye. De forma predeterminada, el framework coincide con los widgets de la compilación actual y anterior según su [`runtimeType`](https://docs.flutter.io/flutter/widgets/Widget-class.html#runtimeType) y el orden en el que aparecen. Con las claves, el framework requiere que los dos widgets tengan la misma [`key`](https://docs.flutter.io/flutter/widgets/Widget-class.html#key) así como el mismo [`runtimeType`](https://docs.flutter.io/flutter/widgets/Widget-class.html#runtimeType).

Las claves son más útiles en los widgets que construyen muchas instancias del mismo tipo de widget. Por ejemplo, el widget `ShoppingList`, que construye sólo suficientes instancias de `ShoppingListItem` para llenar su región visible:

* Sin las keys, la primera entrada de la compilación actual siempre se sincronizaría con la primera entrada de la compilación anterior, incluso si, semánticamente, la primera entrada de la lista se desplaza fuera de la pantalla y ya no es visible en la ventana de visualización.

* Asignando a cada entrada de la lista una clave "semántica", la lista infinita puede ser más eficaz porque el framework sincroniza las entradas con las claves semánticas coincidentes y, por lo tanto, con apariencias visuales similares (o idénticas). Además, sincronizar las entradas semánticamente significa que el estado retenido en los widgets hijos de estado permanece unido a la misma entrada semántica en lugar de la entrada en la misma posición numérica en la ventana de visualización.

Claves Globales
---------------
_Artículo principal: [GlobalKey](https://docs.flutter.io/flutter/widgets/GlobalKey-class.html)_

Puede utilizar claves globales para identificar de forma única los widgets hijos. Las claves globales deben ser globalmente únicas en toda la jerarquía de widgets, a diferencia de las claves locales que sólo necesitan ser únicas entre hermanos. Dado que son únicos en el mundo, se puede utilizar una clave global para recuperar el estado asociado a un widget.





