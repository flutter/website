package io.flutter.addfluttertoandroid

import android.app.Application
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.view.FlutterMain

class MyApplication : Application() {
    lateinit var engine: FlutterEngine

    override fun onCreate() {
        super.onCreate()
        FlutterMain.startInitialization(applicationContext)
        FlutterMain.ensureInitializationComplete(applicationContext, arrayOf<String>())
        engine = FlutterEngine(this)
        val entryPoint = DartExecutor.DartEntrypoint(this.assets,
            FlutterMain.findAppBundlePath(this), "main")
        engine.dartExecutor.executeDartEntrypoint(entryPoint)
    }
}