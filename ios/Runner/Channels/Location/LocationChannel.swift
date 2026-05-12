import Flutter
import UIKit

class LocationChannel {
    
    private static let locationHandler = LocationHandler()
    private static let streamHandler = LocationStreamHandler()

    static func register(with messenger: FlutterBinaryMessenger) {
        let eventChannel = FlutterEventChannel(
            name: "com.app/location_stream",
            binaryMessenger: messenger
        )
        
        let locationChannel = FlutterMethodChannel(name: "com.app/location", binaryMessenger: messenger)

        eventChannel.setStreamHandler(
            streamHandler
        )
        
        locationChannel.setMethodCallHandler(locationHandler.handle)
    }
}
