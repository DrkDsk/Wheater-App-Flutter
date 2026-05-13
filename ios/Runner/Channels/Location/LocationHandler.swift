//
//  LocationHandler.swift
//  Runner
//
//  Created by Alfredo Palacios on 12/05/26.
//

import Flutter
import CoreLocation

class LocationHandler : NSObject {
    
    private let service: LocationService
    
    init(service: LocationService) {
        self.service = service
    }
    
    func handle(
        call: FlutterMethodCall,
        result: @escaping FlutterResult
    ) {
        switch call.method {
            
        case "requestPermission":
            service.requestPermission(result: result)
            
        case "getCurrentLocation":
            service.getCurrentLocation { location in
                let data : [String : Any] = [
                    "latitude" : location.coordinate.latitude,
                    "longitude" : location.coordinate.longitude
                ]
                
                result(data)
            } onError: {error in
                result(
                    FlutterError(
                        code: "LOCATION_ERROR",
                        message: error,
                        details: nil
                    )
                )
            }
            
            default :
            result(FlutterMethodNotImplemented)
        }
    }
}
