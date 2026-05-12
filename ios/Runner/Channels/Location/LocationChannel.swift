import Flutter
import UIKit

class LocationChannel {

    static func register(with messenger: FlutterBinaryMessenger) {
        let eventChannel = FlutterEventChannel(
            name: "com.app/location_stream",
            binaryMessenger: messenger
        )

        let handler = LocationStreamHandler()

        eventChannel.setStreamHandler(
            handler
        )
    }

}