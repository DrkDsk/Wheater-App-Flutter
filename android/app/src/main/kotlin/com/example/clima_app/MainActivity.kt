package com.example.clima_app

import com.example.clima_app.services.LocationService
import com.example.clima_app.services.LocationStreamService
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val locationStreamChannel = "com.app/location_stream"
    private val locationChannel = "com.app/location"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {

        super.configureFlutterEngine(flutterEngine)

        val locationStreamService =
            LocationStreamService(context = this)

        val locationService = LocationService(context = this)

        EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            locationStreamChannel
        ).setStreamHandler(
            locationStreamService
        )

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            locationChannel
        ).setMethodCallHandler(locationService)
    }
}
