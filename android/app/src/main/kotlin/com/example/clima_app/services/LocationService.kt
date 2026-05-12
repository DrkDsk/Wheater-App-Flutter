package com.example.clima_app.services

import android.content.Context
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class LocationService(context: Context) : MethodChannel.MethodCallHandler {

    val service = LocationStreamService(context)

    override fun onMethodCall(
        call: MethodCall,
        result: MethodChannel.Result
    ) {
        when (call.method) {
            "getCurrentLocation" -> {
                service.getCurrentLocation(
                    onSuccess = { location ->
                        result.success(
                            mapOf<String, Any>(
                                "latitude" to location.latitude,
                                "longitude" to location.longitude
                            )
                        )
                    },
                    onError = { error ->
                        result.error(
                            "LOCATION_ERROR",
                            error,
                            null
                        )
                    }
                )
            }
        }
    }
}