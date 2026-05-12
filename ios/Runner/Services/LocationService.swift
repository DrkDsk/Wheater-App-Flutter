import CoreLocation

class LocationService:
    NSObject,
    CLLocationManagerDelegate {

    private let manager =
        CLLocationManager()

    private var onLocationUpdate:
        ((CLLocation) -> Void)?

    override init() {
        super.init()

        manager.delegate = self
        manager.desiredAccuracy =
            kCLLocationAccuracyBest
    }

    func startUpdatingLocation(
        onUpdate:
        @escaping (CLLocation) -> Void
    ) {

        self.onLocationUpdate = onUpdate

        manager.requestWhenInUseAuthorization()

        manager.startUpdatingLocation()
    }

    func stopUpdating() {
        manager.stopUpdatingLocation()
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations:
        [CLLocation]
    ) {

        guard let location =
            locations.last else {
            return
        }

        onLocationUpdate?(location)
    }
}
