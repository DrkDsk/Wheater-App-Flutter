package com.example.clima_app

import com.example.clima_app.channels.LocationMethodChannelHandler
import com.example.clima_app.interfaces.PermissionManager
import com.example.clima_app.managers.AndroidPermissionManager
import com.example.clima_app.services.LocationService
import com.example.clima_app.services.LocationStreamService
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val locationStreamChannel = "com.app/location_stream"
    private val locationChannel = "com.app/location"
    private lateinit var locationStreamService: LocationStreamService
    private lateinit var locationService: LocationService
    private lateinit var permissionManager: PermissionManager

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {

        super.configureFlutterEngine(flutterEngine)

        locationStreamService = LocationStreamService(this)
        locationService = LocationService(this)
        permissionManager = AndroidPermissionManager(this)

        EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            locationStreamChannel
        ).setStreamHandler(
            locationStreamService
        )

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            locationChannel
        ).setMethodCallHandler(LocationMethodChannelHandler(locationService, permissionManager))
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String?>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)

        permissionManager.onRequestPermissionsResult(requestCode, grantResults)
    }
}
