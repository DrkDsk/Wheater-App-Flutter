//
//  LocationStreamHandler.swift
//  
//
//  Created by Alfredo Palacios on 11/05/26.
//
import Flutter

class LocationStreamHandler: NSObject, FlutterStreamHandler {
    
    private let service: LocationService
    
    init(service: LocationService) {
        self.service = service
    }
    
    private let locationService = LocationService()
    private var eventSink: FlutterEventSink?
    
    func OnError(withError error: Error) {
        print("Error: \(error)")
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        locationService.stopUpdating()
        eventSink = nil
        
        return nil
    }
    
    func onListen(withArguments arguments: Any?,
                  eventSink events: @escaping FlutterEventSink
    ) -> FlutterError? {
        self.eventSink = events
        
        locationService.startUpdatingLocation { location in
            let data : [String: Any] = [
                "latitude" : location.coordinate.latitude,
                "longitude" : location.coordinate.longitude
            ]
            
            self.eventSink?(data)
        }
        
        return nil
    }
}
