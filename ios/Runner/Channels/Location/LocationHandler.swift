//
//  LocationHandler.swift
//  Runner
//
//  Created by Alfredo Palacios on 12/05/26.
//

import Flutter
import CoreLocation

class LocationHandler {
    
    private let service = LocationService()
    
    func handle(
        call: FlutterMethodCall,
        result: @escaping FlutterResult
    ) {
        switch call.method {
            
        case "getCurrentLocation":
            service.getCurrentLocation { location in
                let data : [String : Any] = [
                    "latitude" : location.coordinate.latitude,
                    "longitude" : location.coordinate.longitude
                ]
                
                result(data)
            } onError: {
                result(
                    FlutterError(
                        code: "LOCATION_ERROR",
                        message: "Cannot get location",
                        details: nil
                    )
                )
            }
            
            default :
            result(FlutterMethodNotImplemented)
        }
    }
    
}
