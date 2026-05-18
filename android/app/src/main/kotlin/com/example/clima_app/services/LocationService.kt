package com.example.clima_app.services

import android.Manifest
import android.annotation.SuppressLint
import android.app.Activity
import android.content.pm.PackageManager
import androidx.core.app.ActivityCompat
import com.google.android.gms.location.LocationServices

class LocationService(
    private val activity: Activity,
) {
    @SuppressLint("MissingPermission")
    fun getCurrentLocation(callback: (Double?, Double?) -> Unit) {
        val fusedLocationClient =
            LocationServices.getFusedLocationProviderClient(activity)

        if (
            ActivityCompat.checkSelfPermission(
                activity,
                Manifest.permission.ACCESS_FINE_LOCATION
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            callback(null, null)
            return
        }

        fusedLocationClient.lastLocation
            .addOnSuccessListener { location ->
                if (location != null) {
                    callback(location.latitude, location.longitude)
                } else {
                    callback(null, null)
                }
            }
            .addOnFailureListener {
                callback(null, null)
            }
    }
}