package com.example.clima_app.services

import android.annotation.SuppressLint
import android.content.Context
import android.location.Location
import android.os.Looper
import com.google.android.gms.location.LocationCallback
import com.google.android.gms.location.LocationRequest
import com.google.android.gms.location.LocationResult
import com.google.android.gms.location.LocationServices
import com.google.android.gms.location.Priority


import io.flutter.plugin.common.EventChannel

class LocationStreamService(context: Context) : EventChannel.StreamHandler {

    private val fusedLocationClient =
        LocationServices.getFusedLocationProviderClient(
            context
        )

    private var eventSink:
            EventChannel.EventSink? = null

    private lateinit var locationCallback:
            LocationCallback

    @SuppressLint("MissingPermission")
    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events

        val locationRequest = LocationRequest.Builder(
            Priority.PRIORITY_HIGH_ACCURACY,
            1000L
        )
            .setMinUpdateDistanceMeters(500f)
            .setWaitForAccurateLocation(true)
            .build()

        locationCallback = object : LocationCallback() {
            override fun onLocationResult(result: LocationResult) {
                super.onLocationResult(result)

                val location: Location = result.lastLocation ?: return

                val data = mapOf<String, Any>(
                    "latitude" to location.latitude,
                    "longitude" to location.longitude
                )

                eventSink?.success(data)
            }
        }

        fusedLocationClient.requestLocationUpdates(
            locationRequest,
            locationCallback,
            Looper.getMainLooper()
        )
    }

    override fun onCancel(p0: Any?) {
        fusedLocationClient.removeLocationUpdates(
            locationCallback
        )

        eventSink = null
    }

    @SuppressLint("MissingPermission")
    fun getCurrentLocation(
        onSuccess: (Location) -> Unit,
        onError: (String?) -> Unit
    ) {
        fusedLocationClient.lastLocation.addOnSuccessListener {
            if (it != null) {
                onSuccess(it)
            } else {
                onError("Ocurrió un error")
            }
        }.addOnFailureListener { error ->
            onError(error.message)
        }
    }
}