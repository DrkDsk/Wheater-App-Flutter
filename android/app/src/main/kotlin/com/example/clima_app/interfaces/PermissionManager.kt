package com.example.clima_app.interfaces

interface PermissionManager {

    fun hasLocationPermission(): Boolean
    fun requestPermission(callback: (Boolean) -> Unit)

    fun onRequestPermissionsResult(
        requestCode: Int,
        grantResults: IntArray
    )
}