---
title: Flutter - Crea hermosas aplicaciones nativas en tiempo récord
layout: page
homepage: true
hide_title: true
permalink: /
description: >
  Flutter es el SDK de aplicaciones móviles de Google para crear interfaces nativas de alta calidad en iOS y Android en un tiempo récord. Flutter funciona con código existente, es utilizado por desarrolladores y organizaciones de todo el mundo, y es gratuito y de código abierto.
---

<div class="homepage__illustration">
    <h1 class="homepage__illustration--text">
        <span>Último release:</span>
        &nbsp;
        <a href="https://medium.com/flutter-io/flutter-release-preview-1-943a9b6ee65a?linkId=53249457">Flutter Release Preview 1</a>
    </h1>
    <img src="images/homepage/header-illustration.png"
         class="homepage__illustration--image"
         alt="Illustration with a mobile phone, a pencil, and an abstract drawing of widgets.">
</div>

<section class="homepage__key_points card">
    <h1 class="homepage__title">
        Crea hermosas aplicaciones nativas en&nbsp;tiempo&nbsp;récord
    </h1>

    <div class="homepage__tagline">
    Flutter es el SDK de aplicaciones móviles de Google
    para crear interfaces nativas de alta calidad
    en iOS y Android en un tiempo récord. Flutter funciona con código existente,
    es utilizado por desarrolladores y organizaciones de todo el mundo,
    y es gratuito y de código abierto.
    </div>

    <div class="homepage__button_row">
    <a href="/get-started/install/" class="get-started-button">Inicio rápido</a>
    </div>

    <div class="key-points">

        <div class="homepage__key_point">
            <div class="homepage__key_point_title">Desarrollo rápido</div>

            <p>
            Hot Reload en milisegundos para dar vida a tu aplicación.
            Utilice un amplio conjunto de widgets totalmente personalizables para construir interfaces nativas en minutos.
            </p>
        </div>

        <div class="homepage__key_point">
            <div class="homepage__key_point_title">UI flexible y expresiva</div>

            <p>
            Genere rapidamente las funcionalidades con el foco puesto en una experiencia de usuario nativa.
            La arquitectura en capas permite una personalización completa,
            lo que resulta en una renderización increíblemente rápida y diseños expresivos y flexibles.
            </p>
        </div>

        <div class="homepage__key_point">
            <div class="homepage__key_point_title">Rendimiento nativo</div>

            <p>
            Los widgets de Flutter incorporan todas las diferencias críticas de la plataforma, como el scroll, la navegación, los íconos y las fuentes, para proporcionar un rendimiento nativo completo tanto en iOS como en Android.
            </p>
        </div>

    </div>
</section>

<section class="homepage__hot_reload card">
    <h1>Desarrollo rápido</h1>

    <p>
        El <em>hot reload</em> de Flutter te ayuda a experimentar rápida y fácilmente, crear interfaces de usuario, agregar funcionalidades y corregir errores más rápido. Experimenta tiempos de recarga menores a un segundo, sin perder el estado de la aplicación, en emuladores, simuladores y hardware para iOS y Android. 
    </p>

    <div class="hot-reload-gif-container">
        <img src="/images/intellij/hot-reload.gif" class="hot-reload-gif" alt="Haz un cambio en tu código y tu aplicación cambia instantáneamente.">
    </div>
</section>

<section class="homepage__beautiful_uis card ">
    <h1>Interfaces de usuario bellas y expresivas.</h1>

    <p>
    Deleita a tus usuarios con los hermosos widgets incorporados 
    en Material Design y Cupertino(iOS-flavor) de Flutter, rica APIs de movimiento, suave scroll natural, y conocimiento de la plataforma.

    </p>

    <div class="screenshot-list">
        <img class="screenshot" src="/images/homepage/screenshot-1.png" width="270" height="480" alt="Brand-first shopping design">
        <img class="screenshot" src="/images/homepage/screenshot-2.png" width="270" height="480" alt="Fitness app design">
        <img class="screenshot" src="/images/homepage/screenshot-3.png" width="270" height="480" alt="Contact app design">
        <img class="screenshot" src="/images/homepage/ios-friendlychat.png" width="270" height="480" alt="iOS chat app design">
    </div>

    <p>
    Browse the <a href="/widgets/">widget catalog</a>.
    </p>
</section>

<section class="homepage__reactive_framework card">
    <h1>Framework moderno y reactivo</h1>

    <p>
    Componga fácilmente su interfaz de usuario con el moderno framework reactivo de Flutter y un amplio conjunto de widgets, de plataforma, de layout y básicos.
    Resuelva sus desafíos de interfaz de usuario con poderosas y flexibles APIs para 2D, animación, gestos, efectos y más.
    </p>

{% prettify dart %}
class CounterState extends State<Counter> {
  int counter = 0;

  void increment() {
    // Avisa al framework de Flutter que este estado ha cambiado,
    // entonces el framework puede ejecutar build() y actualizar la pantalla.
    setState(() {
      counter++;
    });
  }

  Widget build(BuildContext context) {
    // Este método es ejecutado cada vez que setState es llamado.
    // El framework de Flutter ha sido optimizado para rellamar
    // los metodos build rápido, para que puedas reconstruir cualquier cosa
    // que necesite actualizarse en lugar de tener que cambiar individualmente
    // instancias de widgets.
    return Row(
      children: <Widget>[
        RaisedButton(
          onPressed: increment,
          child: Text('Increment'),
        ),
        Text('Count: $counter'),
      ],
    );
  }
}
{% endprettify %}

    <p>
    Explora el<a href="/widgets/">catálogo de widgets</a>
    y aprende más sobre el  <a href="/widgets-intro/">framework reactivo</a>.
    </p>

</section>

<section class="homepage__interop card">
    <h1>Acede a funcionalidades y SDKs nativos</h1>

    <p>
    Haz que tu aplicación cobre vida
    con las APIs de cada plataforma, SDKs de terceros
    y código nativo.
    Flutter te permite reutilizar tu código existente en Java, Swift y Objective C
    y acceder a funcionalidades nativas y SDKs en iOS y Android.
    </p>

    <p>
    Acceder a las funcionalidades de cada plataforma es facil. Aqui hay un snippet de nuestro <a href="https://github.com/flutter/flutter/tree/master/examples/platform_channel"> repositorio de ejemplos</a>:
    </p>

{% prettify dart %}
Future<Null> getBatteryLevel() async {
  var batteryLevel = 'unknown';
  try {
    int result = await methodChannel.invokeMethod('getBatteryLevel');
    batteryLevel = 'Battery level: $result%';
  } on PlatformException {
    batteryLevel = 'Failed to get battery level.';
  }
  setState(() {
    _batteryLevel = batteryLevel;
  });
}
{% endprettify %}

    <p>
    Aprende como usar <a href="/using-packages/">paquetes</a>, o
    escribir <a href="/platform-channels/">canales de plataforma</a>,
    para acceder a código nativo, APIs y SDKs.
    </p>

</section>

<section class="homepage__features card">
    <h1>Desarrollo unificado de aplicaciones</h1>

    <p>
    Flutter tiene las herramientas y librerías para ayudarte 
    a que tus ideas cobren vida en iOS y Android.
    Si no tienes ninguna experiencia en desarrollo para móviles, Flutter
    es un camino fácil y rápido para construir hermosas aplicaciones móviles.
    Si eres un desarrollador experimentado en iOS o Android
    puedes usar Flutter para tus vistas y aprovechar su conocimiento existente en Java/Kotlin/ObjC/Swift.
    </p>

    <div class="feature-lists">

        <div class="feature-list-group">
            <h3>Construye</h3>

            <h4>Hermosas Interfaces de aplicación</h4>

                <ul>
                    <li>Rica API 2D acelerada por GPU</li>
                    <li>Framework reactivo</li>
                    <li>APIs de Animaciones/movimiento APIs</li>
                    <li>Material Components y widgets para Cupertino</li>
                </ul>

            <h4>Experiencia fluida de cógigo</h4>

            <ul>
                <li>Inferior a un segundo, hot reload manteniendo el estado</li>
                <li>Refactorización, autocompletado, etc.</li>
                <li>Uso de Dart como lenguaje y en las librerías del core</li>
                <li>Gestor de paquetes</li>
            </ul>

            <h4>Aplicaciones con funcionalidad completa</h4>

            <ul>
                <li>Interoperatividad con las APIs &amp; SDKs de OS </li>
                <li>Gradle: Java/Kotlin</li>
                <li>Cocoapods: ObjC/Swift</li>
            </ul>
        </div>

        <div class="feature-list-group">
            <h3>Optimizado</h3>

            <h4>Test</h4>

            <ul>
                <li>Unit testing</li>
                <li>Integration testing</li>
                <li>On-device testing</li>
            </ul>

            <h4>Debug</h4>

            <ul>
                <li>IDE debugger</li>
                <li>Web-based debugger</li>
                <li>async/await</li>
                <li>Evaluador de expresiones</li>
            </ul>

            <h4>Profile</h4>

            <ul>
                <li>Timeline</li>
                <li>CPU y memoria</li>
                <li>In-app perf charts</li>
            </ul>
        </div>

        <div class="feature-list-group">
            <h3>Deploy</h3>

            <h4>Compilado</h4>

            <ul>
                <li>Código nativo ARM</li>
                <li>"Tree shaking" compiler</li>
            </ul>

            <h4>Distribución</h4>

            <ul>
                <li>Apple App Store</li>
                <li>Google Play Store</li>
            </ul>
        </div>

    </div>

    <p>
    Aprende mas sobre que hace especial a Flutter en esta
    Learn more about what makes Flutter special in the
    <a href="/technical-overview/">descripción técnica general</a>.
    </p>
</section>

<section class="homepage__try_flutter card">

    <div class="homepage__try_today">Prueba Flutter hoy. Empezar es fácil.</div>

    <div class="homepage__button_row">
    <a href="/get-started/install/" class="get-started-button">Inicio rápido</a>
    </div>

</section>
