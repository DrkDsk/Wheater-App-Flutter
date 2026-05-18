package com.example.clima_app.channels

import com.example.clima_app.interfaces.PermissionManager
import com.example.clima_app.services.LocationService
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class LocationMethodChannelHandler(
    private val locationService: LocationService,
    private val permissionManager: PermissionManager
) :
    MethodChannel.MethodCallHandler {

    override fun onMethodCall(
        call: MethodCall,
        result: MethodChannel.Result
    ) {
        when (call.method) {
            "requestLocationPermission" -> {
                permissionManager.requestPermission {
                    result.success(it)
                }
            }

            "getCurrentLocation" -> {
                locationService.getCurrentLocation { lat, lng ->
                    if (lat != null && lng != null) {
                        result.success(
                            mapOf(
                                "latitude" to lat,
                                "longitude" to lng
                            )
                        )
                    } else {
                        result.error(
                            "LOCATION_ERROR",
                            "No se pudo obtener la ubicación",
                            null
                        )
                    }
                }
            }

            else -> result.notImplemented()
        }
    }


}