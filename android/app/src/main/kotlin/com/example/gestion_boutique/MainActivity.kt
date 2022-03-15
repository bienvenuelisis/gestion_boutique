package com.example.gestion_boutique

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    SqflitePlugin.registerWith(registrarFor("com.tekartik.sqflite.SqflitePlugin"))
}
