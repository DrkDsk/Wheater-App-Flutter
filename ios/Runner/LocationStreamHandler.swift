//
//  LocationStreamHandler.swift
//  
//
//  Created by Alfredo Palacios on 11/05/26.
//
import Flutter
import CoreLocation

class LocationStreamHandler: NSObject, FlutterStreamHandler {
    
    private let locationService = LocationService()
    private var eventSink: FlutterEventSink?
    
    func onListen(withArguments arguments: Any?,
                  eventSink events: @escaping FlutterEventSink
    ) -> FlutterError? {
        self.eventSink = events
        
        locationService.startUpdatingLocation { location in
            print("location: \(location)")
            let data : [String: Any] = [
                "latitude" : location.coordinate.latitude,
                "longitude" : location.coordinate.longitude
            ]
            
            events(data)
        }
        
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        locationService.stopUpdating()
        eventSink = nil
        
        return nil
    }
}
