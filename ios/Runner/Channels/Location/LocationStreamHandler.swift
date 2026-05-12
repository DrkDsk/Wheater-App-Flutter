//
//  LocationStreamHandler.swift
//  
//
//  Created by Alfredo Palacios on 11/05/26.
//
import Flutter

class LocationStreamHandler: NSObject, FlutterStreamHandler {
    
    private let locationService = LocationService()
    private var eventSink: FlutterEventSink?
    
    func onListen(withArguments arguments: Any?,
                  eventSink events: @escaping FlutterEventSink
    ) -> FlutterError? {
        self.eventSink = eventSink
        
        locationService.startUpdatingLocation { location in
            let data : [String: Any] = [
                "latitude" : location.coordinate.latitude,
                "longitude" : location.coordinate.longitude
            ]
            
            eventSink(data)
        }
        
        return nil
    }
    
    func onCancel(withArguments arguments: Any?,
                  eventSink: @escaping (Any) -> Void) -> FlutterError? {
        locationService.stopUpdating()
        eventSink = nil
        
        return nil
    }
}
